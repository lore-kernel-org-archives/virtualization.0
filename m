From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RESEND V13 14/14] kvm : Paravirtual ticketlocks support
	for linux guests running on KVM hypervisor
Date: Tue, 13 Aug 2013 09:42:51 -0700
Message-ID: <520A620B.6070702@zytor.com>
References: <y>
	<1376058122-8248-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<1376058122-8248-15-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20130810193849.GA25260@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130810193849.GA25260@linux.vnet.ibm.com>
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
Cc: jeremy@goop.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, riel@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, Ingo Molnar <mingo@kernel.org>, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, Suzuki Poulose <suzuki@in.ibm.com>, habanero@linux.vnet.ibm.com, drjones@redhat.com, konrad.wilk@oracle.com, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Raghavendra...

Even with this latest patch this branch is broken:

:(.discard+0x6108): multiple definition of `__pcpu_unique_lock_waiting'
arch/x86/xen/built-in.o:(.discard+0x23): first defined here
  CC      drivers/firmware/google/gsmi.o
arch/x86/kernel/built-in.o:(.discard+0x6108): multiple definition of
`__pcpu_unique_lock_waiting'
arch/x86/xen/built-in.o:(.discard+0x23): first defined here
  CC      sound/core/seq/oss/seq_oss_init.o

This is trivially reproducible by doing a build with "make allyesconfig".

Please fix and *verify* it is fixed before resubmitting.

I will be away so Ingo will have to handle the resubmission.

	-hpa
