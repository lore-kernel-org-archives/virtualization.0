From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] Staging: hv: Add the necessary dependencies to
 hyperv Kconfig
Date: Wed, 4 May 2011 11:59:45 -0700
Message-ID: <20110504185945.GA15032@suse.de>
References: <1304535105-26892-1-git-send-email-kys@microsoft.com>
 <20110504185142.GA28458@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110504185142.GA28458@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 04, 2011 at 02:51:42PM -0400, Christoph Hellwig wrote:
> On Wed, May 04, 2011 at 11:51:45AM -0700, K. Y. Srinivasan wrote:
> >  config HYPERV
> >  	tristate "Microsoft Hyper-V client drivers"
> > -	depends on X86 && m
> > +	depends on X86 && ACPI && PCI && m
> 
> I can't see anything preventing this driver from beeing built-in,
> so the "depends on m" should probably go away.

Originally there were some problems with some bad global symbols.
Hopefully those should all be resolved now, but it can't hurt to review
the code to verify this first.

thanks,

greg k-h
