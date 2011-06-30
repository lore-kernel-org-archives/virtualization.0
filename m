From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/40] Staging: hv: Driver cleanup
Date: Thu, 30 Jun 2011 15:33:46 -0400
Message-ID: <20110630193346.GA22707@infradead.org>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309358301-8488-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 29, 2011 at 07:38:21AM -0700, K. Y. Srinivasan wrote:
> Further cleanup of the hv drivers:
> 
> 	1) Cleanup the reference counting mess for both stor and net devices.

I really don't understand the need for reference counting on the storage
side, especially now that you only have a SCSI driver.  The SCSI
midlayer does proper counting on it's objects (Scsi_Host, scsi_device,
scsi_cmnd), so you'll get that for free given that SCSI drivers just
piggyback on the midlayer lifetime rules.

For now your patches should probably go in as-is, but mid-term you
should be able to completely remove that code on the storage side.
