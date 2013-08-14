From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH delta V13 14/14] kvm : Paravirtual ticketlocks support
	for linux guests running on KVM hypervisor
Date: Wed, 14 Aug 2013 15:20:16 +0530
Message-ID: <520B52D8.5040105@linux.vnet.ibm.com>
References: <y>
	<1376058122-8248-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<1376058122-8248-15-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20130810193849.GA25260@linux.vnet.ibm.com>
	<520A620B.6070702@zytor.com> <20130813165552.GA6795@gmail.com>
	<20130813200211.GA27811@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130813200211.GA27811@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: jeremy@goop.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, riel@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Suzuki Poulose <suzuki@in.ibm.com>, habanero@linux.vnet.ibm.com, drjones@redhat.com, konrad.wilk@oracle.com, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/14/2013 01:32 AM, Raghavendra K T wrote:
>
> Ingo, below delta patch should fix it, IIRC, I hope you will be folding this
> back to patch 14/14 itself. Else please let me.
> I have already run allnoconfig, allyesconfig, randconfig with below patch. But will
> test again.

I Did 2 more runs of allyesconfig, allnoconfig, and 40 runs of
randconfig. patchset with the fix looking good now.
