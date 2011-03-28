From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/20] Staging: hv: Cleanup-storage-drivers-phase-II
Date: Mon, 28 Mar 2011 09:32:30 -0700
Message-ID: <1301329950-25490-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org


This patch-set restructures and cleans up struct hv_storvsc_request.
In the current code, two data structures: struct hv_storvsc_request
and struct storvsc_request_extension together are used to carry
the I/O state and there are many issues with this current
architecture:

	1) The memory for extension data structure 
	   is allocatted just after the data buffer
	   field in struct hv_storvsc_request resulting in comments
	   such as this in struct blkvsc_request (blkvsc_drv.c):

	/*
	 * !!!DO NOT ADD ANYTHING BELOW HERE!!! Otherwise, memory can overlap,
	 * because - The extension buffer falls right here and is pointed to by
	 * request.Extension;
	 * Which sounds like a horrible idea, who designed this?
	 */


	2) State is unnecessarily replicated in both struct hv_storvsc_request
	   and the struct vstor_packet that is embedded in 
	   struct storvsc_request_extension.

This patch-set addresses the above issues by geting rid of replicated
state and consolidating all necessary state into a single data structure.
We also deal with a range of other cleanups in this patch-set:

	1) Use completion primitives to wait for completion.
	2) Get rid of the synch primitive in struct blkvsc_request
	3) Get rid of the need for struct hv_device to be the first
	   element of struct host_device_context.


Regards,

K. Y
