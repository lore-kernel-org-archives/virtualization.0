From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 12/49] Staging: hv: storvsc: Add a DMI signature to
 support auto-loading
Date: Mon, 6 Jun 2011 19:12:59 -0400
Message-ID: <20110606231259.GA18222@infradead.org>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-12-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1307400613-13234-12-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 06, 2011 at 03:49:36PM -0700, K. Y. Srinivasan wrote:
> To support auto-loading the storvsc driver, add a DMI signature.

The storvsc driver is not a DMI driver, but a vmbus driver.  As such it
should have a vmbus table that is used for autoloading, not a dmi one.
