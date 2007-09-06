From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Fix preemptible lazy mode bug
Date: Thu, 06 Sep 2007 10:56:51 +0100
Message-ID: <46DFCEE3.8010903@goop.org>
References: <46CE70C8.2030005@vmware.com> <1189024666.10802.197.camel@localhost.localdomain> <1189036175.21516.31.camel@bodhitayantram.eng.vmware.com> <200709060641.36855.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756836AbXIFJ5N@vger.kernel.org>
In-Reply-To: <200709060641.36855.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> ; it does
>> seem perfectly acceptable though for the mm code to use kmap or vmap
>> (not kmap_atomic) internally somewhere in the pagetable code.
>>     
>
> i386 does it all the time for highmem pagetables in fact.
>   

Yes, it uses kmap_atomic(_pte) all the time.  Is that what you meant?

    J
