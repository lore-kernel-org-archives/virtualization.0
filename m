From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/16] Staging: hv: Cleanup storage drivers - Phase I
Date: Wed, 23 Mar 2011 10:48:57 -0700
Message-ID: <1300902537-1290-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

This is first in a series of patch-sets aimed at cleaning up the storage
drivers for Hyper-V. Before I get into the details of this patch-set, I think
it is  useful to give a brief overview of the storage related front-end
drivers currently in the tree for Linux on Hyper-V:

On the host side, Windows emulates the  standard PC hardware 
to permit hosting of fully virtualized operating systems.
To enhance disk I/O performance, we support a virtual block driver.
This block driver currently handles disks that have been setup as IDE 
disks for the guest - as specified in the guest configuration.

On the SCSI side, we emulate a SCSI HBA. Devices configured
under the SCSI controller for the guest are handled via this
emulated HBA (SCSI front-end). So, SCSI disks configured for 
the guest are handled through native SCSI upper-level drivers.
If this SCSI front-end driver is not loaded, currently, the guest
cannot see devices that have been configured as SCSI devices. 
So, while the virtual block driver described earlier could potentially
handle all block devices, the implementation choices made on the host
may not permit it. Also, the only SCSI device that can be currently
configured for the guest is a disk device.

Both the block device driver (hv_blkvsc) and the SCSI front-end
driver (hv_storvsc) communicate with the host via unique channels
that are implemented as bi-directional ring-buffers. Each 
(storage) channel carries with it enough state to uniquely
identify the device on the host side. Microsoft has chosen to
use SCSI verbs for this storage channel communication.

In this patch-set I have addressed the following issues in the Hyper-V
storage drivers (virtual block and SCSI front-end):

	1) Get rid of the inclusion of storvsc.c from blockvsc.c
	2) Cleanup storvsc.c
	3) Get rid of the file blkvsc.c
	4) Cleanup the initialization sequence for both block and 
	   SCSI front-end drivers.

Regards,

K. Y
