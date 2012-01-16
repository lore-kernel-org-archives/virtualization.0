From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Mon, 16 Jan 2012 19:50:23 +0530
Message-ID: <20120116142014.GA10155@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
Reply-To: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>Dave Hansen <dav>
List-Id: virtualization@lists.linuxfoundation.org

* Alexander Graf <agraf@suse.de> [2012-01-16 04:57:45]:

> Speaking of which - have you benchmarked performance degradation of pv ticket locks on bare metal?

You mean, run kernel on bare metal with CONFIG_PARAVIRT_SPINLOCKS
enabled and compare how it performs with CONFIG_PARAVIRT_SPINLOCKS disabled for 
some workload(s)?

In some sense, the 1x overcommitcase results posted does measure the overhead
of (pv-)spinlocks no? We don't see any overhead in that case for atleast
kernbench ..

> Result for Non PLE machine :
> ============================

[snip]

> Kernbench:
>                BASE                    BASE+patch
>                %improvement
>                mean (sd)               mean (sd)
> Scenario A:
> case 1x:	 164.233 (16.5506)	 163.584 (15.4598	0.39517

[snip]

> Result for PLE machine:
> ======================

[snip]
> Kernbench:
>                BASE                    BASE+patch
>                %improvement
>                mean (sd)               mean (sd)
> Scenario A:
> case 1x:	 161.263 (56.518)        159.635 (40.5621)	1.00953

- vatsa
