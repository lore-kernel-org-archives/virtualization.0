From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0000/0046] Staging: hv: Driver cleanup
Date: Sat, 27 Aug 2011 11:31:14 -0700
Message-ID: <1314469874-7017-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Further cleanup of the hv drivers. 

	1) Cleanup reference counting.

	2) Handle all block devices using the storvsc driver. I have modified
	   the implementation here based on Christoph's feedback on my earlier
	   implementation.

	3) Fix bugs.

	4) Accomodate some host side scsi emulation bugs.

	5) In case of scsi errors off-line the device.

This patch-set further reduces the size of Hyper-V drivers - the code is
about 10% smaller. This reduction is mainly because we have eliminated the
blkvsc driver.


Regards,

K. Y
