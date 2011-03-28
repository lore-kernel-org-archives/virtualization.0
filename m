From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/22] Staging: hv: Cleanup-storage-drivers-phase-III
Date: Mon, 28 Mar 2011 10:00:15 -0700
Message-ID: <1301331615-26226-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

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
