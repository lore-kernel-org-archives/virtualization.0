From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/77] Staging: hv: Driver cleanup
Date: Thu, 16 Jun 2011 13:16:33 -0700
Message-ID: <1308255393-3785-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Further cleanup of the hv drivers:

	1) On some loaded hosts, we have discovered that the host does not respond to
	   the guest within the specified interval - currently one second. Increase the
	   timeout value in the guest.

	2) Implement code for autoloading the vmbus drivers without using PCI or DMI
	   signatures.

	3) Cleanup error handling across the board and use standard Linux error codes.

	4) General cleanup

	5) Some bug fixes.
	  

Regads,

K. Y 
