From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [RESEND] [PATCH 00/22] Staging: hv: Cleanup-storage-drivers-phase-III
Date: Wed,  6 Apr 2011 14:34:15 -0700
Message-ID: <1302125655-10741-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

The latest upstream merge changed struct block_device_operations:
This merge got rid of blkvsc_media_changed and introduced the
function blkvsc_check_events. This broke all the patches that
were sent after the tree was closed the last time. This is a resend of
this patch-set to account for this change in the kernel.

This patch-set deals with some of the style isues in blkvsc_drv.c. We also
get rid most of the "dead code" in this file:

	1) Get rid of most of the forward declarations in this file.
	   The only remaining forward declarations are to deal with 
	   circular dependencies.

	2) Get rid of most of the dead code in the file. Some of
	   the functions in this file are place holders - they are not
	   fuly implementedi yet (blkvsc_ioctl(), blkvsc_media_changed(). 
	   We have retained some comments/dead code, to help us in the
	   final implementation.

Regads,

K. Y 
