From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V10 15/18] kvm : Paravirtual ticketlocks support for
	linux guests running on KVM hypervisor
Date: Wed, 17 Jul 2013 00:19:42 +0530
Message-ID: <51E595C6.9020708@linux.vnet.ibm.com>
References: <20130624124014.27508.8906.sendpatchset@codeblue.in.ibm.com>
	<20130624124342.27508.44656.sendpatchset@codeblue.in.ibm.com>
	<20130714131241.GA11772@redhat.com>
	<51E3C5CE.7000009@linux.vnet.ibm.com>
	<20130715103648.GN11772@redhat.com>
	<51E4C011.4060803@linux.vnet.ibm.com>
	<20130716060215.GE11772@redhat.com>
	<20130716154852.GN23818@dyad.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130716154852.GN23818@dyad.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/16/2013 09:18 PM, Peter Zijlstra wrote:
> On Tue, Jul 16, 2013 at 09:02:15AM +0300, Gleb Natapov wrote:
>> BTW can NMI handler take spinlocks?
>
> No -- that is, yes you can using trylock, but you still shouldn't.

Thanks Peter for the clarification.

I had started checking few of nmi handlers code to confirm.
Did saw a raw spinlock in drivers/acpi/apei/ghes.c, but then stopped.

>
>> If it can what happens if NMI is
>> delivered in a section protected by local_irq_save()/local_irq_restore()?
>
> You deadlock.
>
