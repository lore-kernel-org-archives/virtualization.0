From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0000/0117] Staging: hv: Driver cleanup
Date: Fri, 15 Jul 2011 10:47:04 -0700
Message-ID: <1310752024-27854-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Further cleanup of the hv drivers. Back in June I had sent two patch
sets to address these issues. I have addressed the comments I got from
the community on my earlier patches here:

	1) Implement code for autoloading the vmbus drivers without using PCI or DMI
	   signatures. I have implemented this based on Greg's feedback on my earlier
	   implementation.

	2) Cleanup error handling across the board and use standard Linux error codes.

	3) General cleanup

	4) Some bug fixes.

	5) Cleanup the reference counting mess for both stor and net devices.

	6) Handle all block devices using the storvsc driver. I have modified
	   the implementation here based on Christoph's feedback on my earlier
	   implementation.

	7) Accomodate some host side scsi emulation bugs.

	8) In case of scsi errors off-line the device.

This patch-set further reduces the size of Hyper-V drivers - the code is
about 10% smaller. This reduction is mainly because we have eliminated the
blkvsc driver.
	  

Regards,

K. Y 
