From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0 of 4] mm+paravirt+xen: add pte read-modify-write abstraction
Date: Sat, 24 May 2008 21:44:25 +0100
Message-ID: <48387E29.50103@goop.org>
References: <patchbomb.1211552448@localhost> <alpine.LFD.1.10.0805231133130.3081@woody.linux-foundation.org> <48372C2F.1090704@goop.org> <alpine.LFD.1.10.0805241022210.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761952AbYEXUpK@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0805241022210.3081@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, xen-devel <xen-devel@lists.xensource.com>, Thomas Gleixner <tglx@linutronix.de>, Hugh Dickins <hugh@veritas.com>, Zachary Amsden <zach@vmware.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: virtualization@lists.linuxfoundation.org

Linus Torvalds wrote:
> On Fri, 23 May 2008, Jeremy Fitzhardinge wrote:
>   
>> Well, you could use it to update the page and protection bits while preserving
>> the AD bits, but I don't think that's very useful.
>>     
>
> It's not that it's not "very useful" - it's that it would be TOTALLY 
> WRONG.
>   

Sorry, I was using ironic understatement.  I meant "...while preserving 
the AD bits, but I think that would be totally fucking stupid".

    J
