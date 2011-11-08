From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0000/0011] Staging: hv: storvsc cleanup/new features
Date: Tue,  8 Nov 2011 09:01:17 -0800
Message-ID: <1320771677-29095-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, James.Bottomley@HansenPartnership.com, hch@infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Cleanup storvsc based on review comments from James and
implement a couple of new features:

	1) The bulk of this patch-set addresses the review comments by James.
	   James, the last time I had posted the patch to move the storage
	   driver out of staging, you wanted to wait until Greg's tree had
	   percolated up. Now, Greg's staging/hv has been merged up. Do you 
	   now want me to re-post the patch to move the storage driver 
	   out of staging? Let me know.

	2) I have also implemented the feature to support hot add/remove
	   of devices configured under the scsi controller on the host.

Regards,

K. Y
