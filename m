From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 4/9] lguest: the asm offsets
Date: Wed, 9 May 2007 22:46:13 +0200
Message-ID: <20070509204613.GA10336@uranus.ravnborg.org>
References: <200705090951.l499pa6G020397@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758602AbXEIUpc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200705090951.l499pa6G020397@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, rusty@rustcorp.com.au, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 09, 2007 at 02:51:36AM -0700, akpm@linux-foundation.org wrote:
> From: Rusty Russell <rusty@rustcorp.com.au>
> 
> This is the structure offsets required by lg.ko's switcher.S.
> 
> Unfortunately we don't have infrastructure for private asm-offsets
> creation.
Someone maybe it was Oleg? did an OK job to abstract out asm-offset
generation. I asked to have it rebased but never heard anything back.

I would like to get this generic approach in and then let lguest use it.
But I do not see this as a reason to hold back inclusion in -linus.

But could we please get rid of the "../../../" in the include....

	Sam
