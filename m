From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 6/10] lguest code: the little linux hypervisor.
Date: Sat, 10 Feb 2007 02:23:19 +1100
Message-ID: <1171034599.2718.190.camel@localhost.localdomain>
References: <1171012296.2718.26.camel@localhost.localdomain>
	 <1171012761.2718.40.camel@localhost.localdomain>
	 <1171012827.2718.42.camel@localhost.localdomain>
	 <200702091109.20061.ak@muc.de>
	 <1171024771.2718.129.camel@localhost.localdomain>
	 <20070209141728.GA26749@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946521AbXBIPYG@vger.kernel.org>
In-Reply-To: <20070209141728.GA26749@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-02-09 at 15:17 +0100, Sam Ravnborg wrote:
> I do not quite see what you ask for.
> Care to try to describe the problem a bit then I may look at it sometime.
> 
> [Heading for vacation in a few hours so no prompt reply]

I'd like my own, private "asm-offsets.h".  In this case, in
arch/i386/lguest/.  I guess it's a matter of extracting the core of the
asm-offsets.h magic and generalizing it.

Have a good break!
Rusty.
