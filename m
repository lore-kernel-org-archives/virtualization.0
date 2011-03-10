From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/21] Staging: hv: Cleanup vmbus driver
Date: Thu, 10 Mar 2011 13:59:42 -0800
Message-ID: <1299794382-709-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This patch-set fixes the following issues in the vmbus driver (vmbus_drv.c):

Cleanup root device management: (patches 1/21 through 10/21)
	1) Get rid of the hv_driver code from the vmbus abstraction
	2) Get rid of unnecessary call sequences and functions
	3) Cleanup the management of the root device by using the 
	   standard mechanism for grouping devices under /sys/devices

Make vmbus driver a platform pci device and cleanup irq allocation
(patches 11/21 through 12/21):
	1) Make vmbus driver a platform pci driver.
	2) Leverage the pci model for allocating irq.

General cleanup of vmbus driver (patches 13/21 though  21/21):
	1) Rename vmbus_driver_context structure and do
	   related cleanup.
	2) Get rid of forward declarations by moving code.

Regards,

K. Y
 
