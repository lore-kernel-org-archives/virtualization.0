From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0000/0015] Staging: hv: storvsc cleanup
Date: Thu, 12 Jan 2012 12:37:17 -0800
Message-ID: <1326400637-13494-1-git-send-email-kys@microsoft.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, jbottomley@parallels.com, hch@infradead.org, linux-scsi@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Cleanup storvsc driver  based on the latest review comments from Christoph:

	1. Get rid of unnecessary comments and unused defines. Use a consistent
	   style for comments.

	2. Cleanup all the structure definitions used in communication with
	   the host. Also consolidate all protocol related definitions to
	   a single location in the file.

	3. Get rid of some unnecessary indirection and consolidate the state in
	   request structure.

	4. Some general cleanup.

With this, I believe I have addressed all of the review comments I have received
on this driver. I will submit a separate patch for moving the driver out of staging
(that includes these patches).


Regards,

K. Y

