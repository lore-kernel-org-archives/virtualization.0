From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 25/40] Staging: hv: storvsc: Add state to manage the
 lifecycle of emulated HBA
Date: Thu, 30 Jun 2011 15:44:21 -0400
Message-ID: <20110630194421.GD22707@infradead.org>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-25-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309358377-8537-25-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

I think all this would be a lot simpler if you simply used one scsi
host per ide device as mentioned before.

Also it would be nice if you could sent patches 23 to 28 as one patch
in the next round, as that allows reviewing the whole IDE related code
in one go, which is useful given that it's all interwinded.
