From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/8] Staging: hv: vmbus: Driver cleanup
Date: Mon, 15 Aug 2011 15:10:10 -0700
Message-ID: <1313446210-10611-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Further cleanup of the vmbus driver:

	1) Cleanup the interrupt handler by inlining some code. 

	2) Ensure message handling is performed on the same CPU that
	   takes the vmbus interrupt. 

	3) Check for events before messages (from the host).

	4) Disable auto eoi for the vmbus interrupt since Linux will eoi the
	   interrupt anyway. 

	5) Some general cleanup.
	  

Regards,

K. Y 
