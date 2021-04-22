#include <iostream>
#include <unistd.h>
#include <opencv2/opencv.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>

extern "C" bool save_image_grayscale(cv::Mat save_img, std::string save_name)
{
	cv::Mat gray_scale;
	cv::cvtColor(save_img, gray_scale, cv::COLOR_BGR2GRAY);

	try
	{
		cv::imwrite(save_name, gray_scale);
	}
	catch(int ex)
	{
		std::cout<<"error occured"<<std::endl;
		return false;
	}
	return true;
}

extern "C" bool make_grayscale_image(cv::Mat save_img, std::string save_name)
{
	cv::Mat gray(save_img.rows, save_img.cols, CV_8UC1);

    for(int rows = 0; rows < save_img.rows; rows++)
	{
		for(int cols = 0; cols < save_img.cols; cols++)
		{
			unsigned char gray_scale_data = (save_img.at<cv::Vec3b>(rows, cols)[0] * 0.114) +
											(save_img.at<cv::Vec3b>(rows, cols)[1] * 0.587) +
											(save_img.at<cv::Vec3b>(rows, cols)[2] * 0.299);
			gray.at<unsigned char>(rows, cols) = gray_scale_data;
		}
	}

	cv::imwrite(save_name, gray);
	return true;
}

extern "C" void save_image(cv::Mat save_img, char* save_name)
{
	try
	{
		cv::imwrite(save_name, save_img);
	}
	catch(int ex)
	{
		std::cout<<"error occured"<<std::endl;
	}
}

extern "C" void show_image(char* name)
{
    std::cout<< "Show Image called!!!!!!!!!!!!" << std::endl;
	cv::Mat img = cv::imread(name, cv::IMREAD_COLOR);


	cv::imshow("c++", img);
	int k = cv::waitKey(0);
	if(k == 's')
	{
		make_grayscale_image(img, "gray.jpg");
	}
}
