From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 06/25] xen: Core Xen implementation
Date: Fri, 27 Apr 2007 00:08:07 -0700
Message-ID: <4631A157.9040702@goop.org>
References: <20070423215638.563901986@goop.org> <20070423215710.355105690@goop.org> <200704242325.23447.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754102AbXD0HHi@vger.kernel.org>
In-Reply-To: <200704242325.23447.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Adrian Bunk <bunk@stusta.de>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> +	/* convert from IF type flag */
>> +	flags = !(flags & X86_EFLAGS_IF);
>> +	vcpu = x86_read_percpu(xen_vcpu);
>> +	vcpu->evtchn_upcall_mask = flags;
>> +	if (flags == 0) {
>> +		barrier(); /* unmask then check (avoid races) */
>>     
>
> Don't you need a rmb() here then? The CPU could speculate reads
> (more occurrences) 
>   

Is rmb() sufficient?  It will stop a speculative read on the pending
flag, but will it make sure the write has happened by then?  Ie, is it a
write-vs-read barrier, or just a read-vs-read? 
Documentation/memory-barriers.txt suggests not.

    J
