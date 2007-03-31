From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 0/6] i386 gdt and percpu cleanups
Date: Fri, 30 Mar 2007 20:16:29 -0700
Message-ID: <460DD28D.2070302@goop.org>
References: <20070331020042.003398870@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933571AbXCaDQc@vger.kernel.org>
In-Reply-To: <20070331020042.003398870@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> This is a series of patches based on your latest queue (as of the
> other day, at least).
>   

BTW, the From: line attributions got dropped from a few of these.  These:

    Allow percpu variables to be page-aligned
    Page-align the GDT

should be From: Rusty.  He did most of the work on the others, but I
changed them enough that he shouldn't be saddled with the blame when
things break ;)

    J
