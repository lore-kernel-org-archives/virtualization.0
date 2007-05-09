From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 7/9] lguest: the net driver
Date: Wed, 9 May 2007 22:09:04 +0100
Message-ID: <20070509210904.GA20064@infradead.org>
References: <200705090951.l499pdOr020406@shell0.pdx.osdl.net> <4641BE65.3030807@garzik.org> <1178723695.7286.164.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759163AbXEIVJ0@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1178723695.7286.164.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Garzik <jeff@garzik.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, ak@suse.de, jmorris@namei.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 10, 2007 at 01:14:55AM +1000, Rusty Russell wrote:
> > > +	info->peer = (void *)ioremap(info->peer_phys, info->mapsize);
> > 
> > check for NULL
> 
> Erk, good catch!

Also the cast is bogus.  ioremap already returns void already.  Even
more importantly the lack of the __iomem annotations shows that either this
code hasn't been run through sparse or someone decided to ignore it's
errors.
