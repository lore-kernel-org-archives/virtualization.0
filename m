From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0000/0059] Staging: hv: Driver cleanup
Date: Thu, 25 Aug 2011 09:47:46 -0700
Message-ID: <1314290866-2644-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Further cleanup of the hv drivers. 

	1) Implement code for autoloading the vmbus drivers without using PCI or DMI
	   signatures. I have implemented this based on Greg's feedback on my earlier
	   implementation.

	2) Cleanup error handling across the board and use standard Linux error codes.

	3) General cleanup



Regards,

K. Y 
