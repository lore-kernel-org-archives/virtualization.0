From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/12] Staging: hv: Cleanup vmbus driver - Phase II
Date: Tue, 15 Mar 2011 15:02:07 -0700
Message-ID: <1300226527-26933-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch-set fixes the following issues in the vmbus driver (vmbus_drv.c):

Make vmbus driver a platform pci device and cleanup
root device management and  irq allocation
(patches 1/12 through 3/12):
	1) Make vmbus driver a platform pci driver.
	2) Cleanup root device management.
	3) Leverage the pci model for allocating irq.

General cleanup of vmbus driver (patches 4/12 though  12/12):
	1) Rename vmbus_driver_context structure and do
	   related cleanup.
	2) Get rid of forward declarations by moving code.

Regards,

K. Y
 
