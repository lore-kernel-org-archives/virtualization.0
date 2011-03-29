From: Hank Janssen <hjanssen@microsoft.com>
Subject: [PATCH 00/07] Remove and replace all un-needed DPRINT and printk
Date: Tue, 29 Mar 2011 13:58:43 -0700
Message-ID: <1301432330-1705-1-git-send-email-hjanssen@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hjanssen@microsoft.com, haiyangz@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This patch set removes all un-needed DPRINT and printk calls and replaces
the remaining ones with the correct pr_, dev_ and netdev_ calls 
from hv_vmbus, hv_netvsc, hv_timesource and hv_utils.

Several DPRINTS are remaining that will be cleaned up in my next
set of patches. They deal with printing out certain debugging that will be 
implemented slightly differently.

The remaining hv_storvsc and hv_blkvsc will get the same treatment in
a different set of patches.

Regards,

Hank Janssen <hjanssen@microsoft.com>
