From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Thu, 11 Jul 2013 12:48:33 +0300
Message-ID: <20130711094833.GC8575@redhat.com>
References: <1372171802.3804.30.camel@oc2024037011.ibm.com>
	<51CAAA26.4090204@linux.vnet.ibm.com>
	<20130626113744.GA6300@hawk.usersys.redhat.com>
	<20130626125240.GY18508@redhat.com>
	<51CAEF45.3010203@linux.vnet.ibm.com>
	<20130626161130.GB18152@redhat.com>
	<51CB2AD9.5060508@linux.vnet.ibm.com>
	<51DBD3C2.2040807@linux.vnet.ibm.com>
	<20130710103325.GP24941@redhat.com>
	<51DE771F.7070805@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51DE771F.7070805@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, riel@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, Andrew Jones <drjones@redhat.com>, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 11, 2013 at 02:43:03PM +0530, Raghavendra K T wrote:
> On 07/10/2013 04:03 PM, Gleb Natapov wrote:
> [...] trimmed
> 
> >>>Yes. you are right. dynamic ple window was an attempt to solve it.
> >>>
> >>>Probelm is, reducing the SPIN_THRESHOLD is resulting in excess halt
> >>>exits in under-commits and increasing ple_window may be sometimes
> >>>counter productive as it affects other busy-wait constructs such as
> >>>flush_tlb AFAIK.
> >>>So if we could have had a dynamically changing SPIN_THRESHOLD too, that
> >>>would be nice.
> >>>
> >>
> >>Gleb, Andrew,
> >>I tested with the global ple window change (similar to what I posted
> >>here https://lkml.org/lkml/2012/11/11/14 ),
> >This does not look global. It changes PLE per vcpu.
> 
> Okay. Got it. I was thinking it would change the global value. But IIRC
>  It is changing global sysfs value and per vcpu ple_window.
> Sorry. I missed this part yesterday.
> 
Yes, it changes sysfs value but this does not affect already created
vcpus.

> >
> >>But did not see good result. May be it is good to go with per VM
> >>ple_window.
> >>
> >>Gleb,
> >>Can you elaborate little more on what you have in mind regarding per
> >>VM ple_window. (maintaining part of it as a per vm variable is clear
> >>to
> >>  me), but is it that we have to load that every time of guest entry?
> >>
> >Only when it changes, shouldn't be to often no?
> 
> Ok. Thinking how to do. read the register and writeback if there need
> to be a change during guest entry?
> 
Why not do it like in the patch you've linked? When value changes write it
to VMCS of the current vcpu.

--
			Gleb.
