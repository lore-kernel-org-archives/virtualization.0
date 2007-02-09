From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/10] lguest: Don't rely on last-linked fallthru when
 no paravirt handler
Date: Fri, 09 Feb 2007 12:49:06 -0800
Message-ID: <45CCDE42.2050603@goop.org>
References: <1171012296.2718.26.camel@localhost.localdomain>	 <1171012458.2718.30.camel@localhost.localdomain>	 <200702091031.20249.ak@muc.de> <1171021966.2718.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992834AbXBIUtJ@vger.kernel.org>
In-Reply-To: <1171021966.2718.82.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> If we make it thought early_fault, this will do just that.
>
> Given this is a "never happens" situation, however... if you're actually
> under Xen or lguest, you won't make it that far (lguest, at least, will
> kill you on the cr2 load in early_fault, but it doesn't matter because
> we won't get anywhere with early_printk anyway).
>
> Actually, if we did BUG() here at least lguest would print something...
> I wonder what Xen would do...

Xen would print a complete register dump and backtrace.  There's not a
lot else you can do here; you could try early_printk, but if we're in a
strange virtual environment, there may be no device on which the output
could appear.

    J
