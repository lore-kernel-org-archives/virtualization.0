From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 4/9] lguest: the asm offsets
Date: Thu, 10 May 2007 10:09:39 +1000
Message-ID: <1178755780.7286.175.camel@localhost.localdomain>
References: <200705090951.l499pa6G020397@shell0.pdx.osdl.net>
	 <20070509204613.GA10336@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760537AbXEJAJz@vger.kernel.org>
In-Reply-To: <20070509204613.GA10336@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-05-09 at 22:46 +0200, Sam Ravnborg wrote:
> On Wed, May 09, 2007 at 02:51:36AM -0700, akpm@linux-foundation.org wrote:
> > From: Rusty Russell <rusty@rustcorp.com.au>
> > 
> > This is the structure offsets required by lg.ko's switcher.S.
> > 
> > Unfortunately we don't have infrastructure for private asm-offsets
> > creation.
> Someone maybe it was Oleg? did an OK job to abstract out asm-offset
> generation. I asked to have it rebased but never heard anything back.
> 
> I would like to get this generic approach in and then let lguest use it.
> But I do not see this as a reason to hold back inclusion in -linus.

Hi Sam,

	Yeah, I never heard back either.  And I'm reluctant to try to fix it
myself: I've never managed to patch the build system without causing you
to rewrite it better 8)

> But could we please get rid of the "../../../" in the include....

	Sure: but how?  It's a private internal include for the lg.ko module.

Thanks!
Rusty.
