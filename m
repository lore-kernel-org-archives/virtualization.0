From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot transaction	abstraction
Date: Wed, 18 Jun 2008 22:03:43 -0700
Message-ID: <4859E8AF.30306@goop.org>
References: <b020e42384197b824320.1213615800@localhost>	 <1213831403.8011.24.camel@pasglop> <4859A149.9090004@goop.org>	 <4859A528.1010107@goop.org>	 <alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org> <1213835971.8011.54.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755052AbYFSFEg@vger.kernel.org>
In-Reply-To: <1213835971.8011.54.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Benjamin Herrenschmidt wrote:
> On Wed, 2008-06-18 at 17:24 -0700, Linus Torvalds wrote:
>   
>> On Wed, 18 Jun 2008, Jeremy Fitzhardinge wrote:
>>     
>>> Along the lines of:
>>>       
>> Hell no. There's a reason we have a special set_wrprotect() thing. We can 
>> do it more efficiently on native hardware by just clearing the bit 
>> atomically. No need to do the cmpxchg games.
>>     
>
> But we can't batch ... 
>   

Which architecture are you interested in?  If it isn't x86, you can 
probably get anything past Linus ;)

I'll do some measurements to see what effect the batchable 
ptep_set_wrprotect() has on native.  If it's significant, I'll propose 
making it conditional on CONFIG_PARAVIRT.

    J
