From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 0/6] i386 gdt and percpu cleanups
Date: Fri, 30 Mar 2007 20:05:26 -0700
Message-ID: <460DCFF6.2070100@goop.org>
References: <20070331020042.003398870@goop.org> <1175309761.12230.422.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933546AbXCaDF0@vger.kernel.org>
In-Reply-To: <1175309761.12230.422.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> One nitpick: I'd really like PER_CPU() renamed to PER_CPU_ADDR().
> That's a separate patch, but I think would be far clearer.
>   

Seems pretty simple, given that it has precisely one use.

    J
