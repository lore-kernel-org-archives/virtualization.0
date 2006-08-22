From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 16:54:10 +0200
Message-ID: <200608221654.10558.ak@muc.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <200608221550.57603.ak@muc.de> <20060822142519.GX11651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932268AbWHVOyz@vger.kernel.org>
In-Reply-To: <20060822142519.GX11651@stusta.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 22 August 2006 16:25, Adrian Bunk wrote:
> On Tue, Aug 22, 2006 at 03:50:57PM +0200, Andi Kleen wrote:
> > 
> > > this would need a "const after boot" section; which is really not hard
> > > to make and probably useful for a lot more things.... todo++
> > 
> > except for anything that needs tlb entries in user space. And it only gives you
> > false sense of security. --todo
> 
> What's the alternative?

The alternative is to not protect it, since protecting it doesn't
offer any significant additional security over not protecting it.

> 
> Change it from a struct to a compile time choice?

One of the design goals of paravirt-ops was to allow single binaries
that run on both native hardware and on hypervisors. So that would
be a non starter.

-Andi
