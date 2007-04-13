From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 0/4] i386 - pte update optimizations
Date: Thu, 12 Apr 2007 19:24:37 -0700
Message-ID: <461EE9E5.6060403@vmware.com>
References: <200704120530.l3C5UGbv022814@zach-dev.vmware.com> <461EDBF1.4080904@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753012AbXDMC10@vger.kernel.org>
In-Reply-To: <461EDBF1.4080904@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Hugh Dickins <hugh@veritas.com>, David Rientjes <rientjes@google.com>, Michel Lespinasse <walken@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Zachary Amsden wrote:
>> Some PTE optimizations for native and paravirt-ops kernels; this
>> provides a huge win for shadow mode hypervisors and gets rid of
>> some unnecessary atomic instructions in native kernels, saving
>> even more on UP by getting rid of implicit LOCK on xchg instruction.
>
> You do know that P6 and higher don't do locked bus references as long 
> as the value is in the cache, right?

Yes.  Even then, last time I clocked instructions, xchg was still slower 
than read / write, although I could be misremembering.  And it's not 
totally clear that they will always be in cached state, however, and for 
SMP, we still want to drop the implicit lock in cases where the 
processor might not know they are cached exclusive, but we know there 
are no other racing users.  And there are plenty of old processors out 
there to still make it worthwhile.

Zach
