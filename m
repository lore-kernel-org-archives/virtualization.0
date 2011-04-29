From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [RESEND] [PATCH 00/18] Staging: hv: Cleanup vmbus driver code
Date: Fri, 29 Apr 2011 13:42:59 -0700
Message-ID: <1304109779-24819-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

This is a resend of the patches yet to be applied.
This patch-set addresses some of the bus/driver model cleanup that
Greg sugested over the last couple of days.  In this patch-set we
deal with the following issues:


	1) Cleanup error handling in the vmbus_probe() and 
	   vmbus_child_device_register() functions. Fixed a 
	   bug in the probe failure path as part of this cleanup.

	2) The Windows host cannot handle the vmbus_driver being 
	   unloaded and subsequently loaded. Cleanup the driver with
	   this in mind.

	3) Get rid of struct hv_bus that embedded struct bus_type to 
	   conform with the LDM.

	4) Add probe/remove/shutdown functions to struct hv_driver to
	   conform to LDM.

	5) On some older Hyper-V hosts, the Linux PCI sub-sytem is not able
	   to allocate irq resources to the vmbus driver. I recently learnt
	   that the vmbus driver is an acpi enumerated device on the Hyper-V
	   platform. Added code to retrieve irq information from DSDT.



Regards,

K. Y
