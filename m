From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Tue, 22 Sep 2009 09:52:28 -0700
Message-ID: <4AB900CC.7090409@goop.org>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com> <20090919224430.GB9567@kroah.com> <1253419185.3253.21.camel@ank32.eng.vmware.com> <20090920074247.GA5733@elte.hu> <20090920095239.456ad6f2@infradead.org> <4AB5EF25.9070502@redhat.com> <4AB64EFC.10707@goop.org> <20090922080913.GB1475@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756193AbZIVQwa@vger.kernel.org>
In-Reply-To: <20090922080913.GB1475@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Avi Kivity <avi@redhat.com>, Arjan van de Ven <arjan@infradead.org>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 09/22/09 01:09, Ingo Molnar wrote:
>>> kvm will be removing the pvmmu support soon; and Xen is talking about
>>> running paravirtualized guests in a vmx/svm container where they don't
>>> need most of the hooks.
>>>       
>> We have no plans to drop support for non-vmx/svm capable processors, 
>> let alone require ept/npt.
>>     
> But, just to map out our plans for the future, do you concur with the 
> statements and numbers offered here by the VMware and KVM folks that
> on sufficiently recent hardware, hardware-assisted virtualization 
> outperforms paravirt_ops in many (most?) workloads?
>   

Well, what Avi is referring to here is some discussions about a hybrid
paravirtualized mode, in which Xen runs a normal Xen PV guest within a
hardware container in order to get some immediate optimisations, and
allow further optimisations like using hardware assisted paging extensions.

For KVM and VMI, which always use a shadow pagetable scheme, hardware
paging is now unambigiously better than shadow pagetables, but for Xen
PV guests the picture is mixed since they don't use shadow pagetables. 
The NPT/EPT extensions make updating the pagetable more efficent, but
actual access is more expensive because of the higher load on the TLB
and the increased expense of a TLB miss, so the actual performance
effects are very workload dependent.

> I.e. paravirt_ops becomes a legacy hardware thing, not a core component 
> of the design of arch/x86/.
>
> (with a long obsoletion period, of course.)
>   

I expect we'll eventually get to the point that the performance delta
and the installed userbase will no longer justify the effort in
maintaining the full set of pvops hooks.  But I don't have a good
feeling for when that might be.

    J
