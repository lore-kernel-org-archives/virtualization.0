From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
	support
Date: Sat, 6 Oct 2018 17:49:34 -0300
Message-ID: <20181006204932.GA27822__31787.9892806106$1539011883$gmane$org@amt.cnet>
References: <20180914125006.349747096@linutronix.de>
	<CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
	<87sh1ne64t.fsf@vitty.brq.redhat.com>
	<20181003190617.GC21381@amt.cnet>
	<87k1mycfju.fsf@vitty.brq.redhat.com>
	<20181004081100.GI19272@hirez.programming.kicks-ass.net>
	<B8C05946-43BB-40A4-A564-53904FAF8CC0@amacapital.net>
	<20181004193150.GQ19272@hirez.programming.kicks-ass.net>
	<499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net>
	<CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, devel@linuxdriverproject.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 04, 2018 at 03:15:32PM -0700, Andy Lutomirski wrote:
> For better or for worse, I'm trying to understand this code.  So far,
> I've come up with this patch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/vdso-tglx&id=14fd71e12b1c4492a06f368f75041f263e6862bf
> 
> Is it correct, or am I missing some subtlety?

"In the non-fallback case, a bunch of gnarly arithmetic is done: a
hopefully matched pair of (TSC, boot time) is read, then all locks
are dropped, then the TSC frequency is read, a branch new multiplier
and shift is read, and the result is turned into a time.

This seems quite racy to me.  Because locks are not held, I don't
see what keeps TSC frequency used in sync with the master clock
data."

If tsc_khz changes, the host TSC clocksource will not be used, which 
disables masterclock:

if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
                        (val == CPUFREQ_POSTCHANGE && freq->old >
freq->new)) {
                *lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq,
freq->new);

                tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq,
freq->new);
                if (!(freq->flags & CPUFREQ_CONST_LOOPS))
                        mark_tsc_unstable("cpufreq changes");

In which case it ends up in:

-	spin_lock(&ka->pvclock_gtod_sync_lock);
-	if (!ka->use_master_clock) {
-		spin_unlock(&ka->pvclock_gtod_sync_lock);
-		return ktime_get_boot_ns() + ka->kvmclock_offset;
-	}

masterclock -> non masterclock transition sets
a REQUEST bit on each vCPU, so as to invalidate any previous
clock reads.

static void kvm_gen_update_masterclock(struct kvm *kvm)
{
#ifdef CONFIG_X86_64
        int i;
        struct kvm_vcpu *vcpu;
        struct kvm_arch *ka = &kvm->arch;

        spin_lock(&ka->pvclock_gtod_sync_lock);
        kvm_make_mclock_inprogress_request(kvm);
        /* no guest entries from this point */
        pvclock_update_vm_gtod_copy(kvm);

        kvm_for_each_vcpu(i, vcpu, kvm)
                kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);

        /* guest entries allowed */
        kvm_for_each_vcpu(i, vcpu, kvm)
                kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);

        spin_unlock(&ka->pvclock_gtod_sync_lock);
#endif



        /*
         * If the host uses TSC clock, then passthrough TSC as stable
         * to the guest.
         */
        host_tsc_clocksource = kvm_get_time_and_clockread(
                                        &ka->master_kernel_ns,
                                        &ka->master_cycle_now);

        ka->use_master_clock = host_tsc_clocksource && vcpus_matched
                                && !ka->backwards_tsc_observed
                                && !ka->boot_vcpu_runs_old_kvmclock;
