From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RESEND V13 14/14] kvm : Paravirtual ticketlocks support
	for linux guests running on KVM hypervisor
Date: Tue, 13 Aug 2013 18:55:52 +0200
Message-ID: <20130813165552.GA6795__24595.8314546899$1376412977$gmane$org@gmail.com>
References: <y>
	<1376058122-8248-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<1376058122-8248-15-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20130810193849.GA25260@linux.vnet.ibm.com>
	<520A620B.6070702@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <520A620B.6070702@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: jeremy@goop.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, riel@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Suzuki Poulose <suzuki@in.ibm.com>, habanero@linux.vnet.ibm.com, drjones@redhat.com, konrad.wilk@oracle.com, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> Raghavendra...
> 
> Even with this latest patch this branch is broken:
> 
> :(.discard+0x6108): multiple definition of `__pcpu_unique_lock_waiting'
> arch/x86/xen/built-in.o:(.discard+0x23): first defined here
>   CC      drivers/firmware/google/gsmi.o
> arch/x86/kernel/built-in.o:(.discard+0x6108): multiple definition of
> `__pcpu_unique_lock_waiting'
> arch/x86/xen/built-in.o:(.discard+0x23): first defined here
>   CC      sound/core/seq/oss/seq_oss_init.o
> 
> This is trivially reproducible by doing a build with "make allyesconfig".
> 
> Please fix and *verify* it is fixed before resubmitting.
> 
> I will be away so Ingo will have to handle the resubmission.

Would be nice to have a delta fix patch against tip:x86/spinlocks, which 
I'll then backmerge into that series via rebasing it.

Thanks,

	Ingo
