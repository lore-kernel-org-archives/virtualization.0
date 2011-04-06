From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [RESEND][PATCH 00/22] Staging: hv: Cleanup storage drivers - Phase IV
Date: Wed,  6 Apr 2011 16:03:26 -0700
Message-ID: <1302131006-15411-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The latest upstream merge changed struct block_device_operations:
This merge got rid of blkvsc_media_changed and introduced the
function blkvsc_check_events. This broke all the patches that
were sent after the tree was closed the last time. This is a resend of
this patch-set to account for this change in the kernel.


More cleanup. In this patch-set we deal with the following issues:

	1) While a Linux guest on Hyper-V can be assigned removable media
	   devices (DVD, floppy etc), these devices are not handled by the
	   Hyper-V block driver. So, we cleanup all the dead code
	   dealing with removable media devices.

	2) There were multiple functions to retrieve information about 
	   the device. Since much of the code in these functions were
	   identical, we have consolidated these functions into a single
	   function.

	3) Enable the ioctl code for handling HDIO_GET_IDENTITY

	4) Cleanup the code for getting the geometry.

	5) Cleanup code for retreiving device capacity; this has also fixed
	   a bug with regards to presenting physical disks to the guest
	   as an IDE disk.

	6) General cleanup: simplify blkvsc_init_rw(), get rid of 
	   unnecessary DPRINT*() calls, get rid of unnecessary code,
	   cleanup blkvsc_open().

	7) Remove all IDE details from blkvsc_drv.c.

Regards,

K. Y
