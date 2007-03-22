From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] lguest: clean rest of linkage warnings (bar one)
Date: Thu, 22 Mar 2007 12:45:49 +0100
Message-ID: <20070322114549.GC29453@uranus.ravnborg.org>
References: <1174532243.2713.95.camel@localhost.localdomain> <1174558182.2713.151.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030519AbXCVLpN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1174558182.2713.151.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 22, 2007 at 09:09:42PM +1100, Rusty Russell wrote:
> My previous warning fix broke lguest if your text size wasn't correct
> to make the __start_paravirtprobe aligned correctly.  Put the separate
> paravirtprobe section back, but inside the init section so it gets
> discarded.
> 
> It also fixes the remaining warnings, except one.  The code in
> modpost.c which needs to be taught that it's legal to link from
> .paravirtprobe to .init.text is horrible, and I'm pretty sure I'd just
> make it worse.

If you drop me a sample of the exact warning I will add this one too.
Current kbuild.git contains a lot of fixes in this area so I refer to
do so on top of that tree.

	Sam
