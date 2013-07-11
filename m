From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Thu, 11 Jul 2013 13:56:31 +0300
Message-ID: <20130711105631.GH8575@redhat.com>
References: <51CAEF45.3010203@linux.vnet.ibm.com>
	<20130626161130.GB18152@redhat.com>
	<51CB2AD9.5060508@linux.vnet.ibm.com>
	<51DBD3C2.2040807@linux.vnet.ibm.com>
	<20130710103325.GP24941@redhat.com>
	<51DE771F.7070805@linux.vnet.ibm.com>
	<20130711094833.GC8575@redhat.com>
	<51DE849E.4020405@linux.vnet.ibm.com>
	<20130711101104.GF8575@redhat.com>
	<51DE8EC6.6020700@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51DE8EC6.6020700@linux.vnet.ibm.com>
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

On Thu, Jul 11, 2013 at 04:23:58PM +0530, Raghavendra K T wrote:
> On 07/11/2013 03:41 PM, Gleb Natapov wrote:
> >On Thu, Jul 11, 2013 at 03:40:38PM +0530, Raghavendra K T wrote:
> >>>>>>Gleb,
> >>>>>>Can you elaborate little more on what you have in mind regarding per
> >>>>>>VM ple_window. (maintaining part of it as a per vm variable is clear
> >>>>>>to
> >>>>>>  me), but is it that we have to load that every time of guest entry?
> >>>>>>
> >>>>>Only when it changes, shouldn't be to often no?
> >>>>
> >>>>Ok. Thinking how to do. read the register and writeback if there need
> >>>>to be a change during guest entry?
> >>>>
> >>>Why not do it like in the patch you've linked? When value changes write it
> >>>to VMCS of the current vcpu.
> >>>
> >>
> >>Yes. can be done. So the running vcpu's ple_window gets updated only
> >>after next pl-exit. right?
> >I am not sure what you mean. You cannot change vcpu's ple_window while
> >vcpu is in a guest mode.
> >
> 
> I agree with that. Both of us are on the same page.
>  What I meant is,
> suppose the per VM ple_window changes when a vcpu x of that VM  was running,
> it will get its ple_window updated during next run.
Ah, I think "per VM" is what confuses me. Why do you want to have "per
VM" ple_windows and not "per vcpu" one? With per vcpu one ple_windows
cannot change while vcpu is running.

--
			Gleb.
