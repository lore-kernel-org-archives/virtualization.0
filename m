From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V4 4/5] kvm : pv-ticketlocks support for linux guests
	running on KVM hypervisor
Date: Mon, 16 Jan 2012 11:05:16 +0200
Message-ID: <4F13E84C.3010808@redhat.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182645.8604.68884.sendpatchset@oc5400248562.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120114182645.8604.68884.sendpatchset@oc5400248562.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki
List-Id: virtualization@lists.linuxfoundation.org

On 01/14/2012 08:26 PM, Raghavendra K T wrote:
> Extends Linux guest running on KVM hypervisor to support pv-ticketlocks. 
>
> During smp_boot_cpus  paravirtualied KVM guest detects if the hypervisor has
> required feature (KVM_FEATURE_PVLOCK_KICK) to support pv-ticketlocks. If so,
>  support for pv-ticketlocks is registered via pv_lock_ops.
>
> Use KVM_HC_KICK_CPU hypercall to wakeup waiting/halted vcpu.
> +
> +	debugfs_create_u8("zero_stats", 0644, d_spin_debug, &zero_stats);
> +
> +	debugfs_create_u32("taken_slow", 0444, d_spin_debug,
> +		   &spinlock_stats.contention_stats[TAKEN_SLOW]);
> +	debugfs_create_u32("taken_slow_pickup", 0444, d_spin_debug,
> +		   &spinlock_stats.contention_stats[TAKEN_SLOW_PICKUP]);
> +
> +	debugfs_create_u32("released_slow", 0444, d_spin_debug,
> +		   &spinlock_stats.contention_stats[RELEASED_SLOW]);
> +	debugfs_create_u32("released_slow_kicked", 0444, d_spin_debug,
> +		   &spinlock_stats.contention_stats[RELEASED_SLOW_KICKED]);
> +
> +	debugfs_create_u64("time_blocked", 0444, d_spin_debug,
> +			   &spinlock_stats.time_blocked);
> +
> +	debugfs_create_u32_array("histo_blocked", 0444, d_spin_debug,
> +		     spinlock_stats.histo_spin_blocked, HISTO_BUCKETS + 1);
> +
>

Please drop all of these and replace with tracepoints in the appropriate
spots.  Everything else (including the historgram) can be reconstructed
the tracepoints in userspace.

-- 
error compiling committee.c: too many arguments to function
