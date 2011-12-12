From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0000/0004] Drivers: hv: Fixes
Date: Mon, 12 Dec 2011 09:28:51 -0800
Message-ID: <1323710931-29616-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Some fixes to the vmbus driver:

	1. Fix a memory leak in a failure path.

	2. Make vmbus driver unloadable.

	3. Get rid of an unnecessary check in hv_init()
	   in preparation for supporting kexec().

	4. Make it possible to build the vmbus driver as part of the
	   kernel. This patch was submitted earlier, but seems to have been 
	   lost.

Regards,

K. Y
