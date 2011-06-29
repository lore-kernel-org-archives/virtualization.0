From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/40] Staging: hv: Driver cleanup
Date: Wed, 29 Jun 2011 07:38:21 -0700
Message-ID: <1309358301-8488-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Further cleanup of the hv drivers:

	1) Cleanup the reference counting mess for both stor and net devices.

	2) Handle all block devices using the storvsc driver.
	  
	3) Accomodate some host side scsi emulation bugs.

	4) In case of scsi errors off-line the device.


Regads,

K. Y 
