From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/3] x86/vdso: Add Hyper-V TSC page clocksource support
Date: Fri, 17 Feb 2017 11:35:44 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702171130470.3536@nanos>
References: <20170214124408.25931-1-vkuznets@redhat.com>
	<alpine.DEB.2.20.1702141552360.3635@nanos>
	<87a89o22ml.fsf@vitty.brq.redhat.com>
	<CALCETrUNdemXG7GnehNus-EW2FDuTzB8HKW_3HUjhPt9ZNf45w@mail.gmail.com>
	<87y3x7zh6h.fsf@vitty.brq.redhat.com>
	<alpine.DEB.2.20.1702161832020.3543@nanos>
	<87tw7txgx9.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87tw7txgx9.fsf@vitty.brq.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 17 Feb 2017, Vitaly Kuznetsov wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> > On Wed, 15 Feb 2017, Vitaly Kuznetsov wrote:
> >> Actually, we already have an implementation of TSC page update in KVM
> >> (see arch/x86/kvm/hyperv.c, kvm_hv_setup_tsc_page()) and the update does
> >> the following:
> >> 
> >> 0) stash seq into seq_prev
> >> 1) seq = 0 making all reads from the page invalid
> >> 2) smp_wmb()
> >> 3) update tsc_scale, tsc_offset
> >> 4) smp_wmb()
> >> 5) set seq = seq_prev + 1
> >
> > I hope they handle the case where seq_prev overflows and becomes 0 :)
> >
> >> As far as I understand this helps with situations you described above as
> >> guest will notice either invalid value of 0 or seq change. In case the
> >> implementation in real Hyper-V is the same we're safe with compile
> >> barriers only.
> >
> > On x86 that's correct. smp_rmb() resolves to barrier(), but you certainly
> > need the smp_wmb() on the writer side.
> >
> > Now looking at the above your reader side code is bogus:
> >
> > +       while (1) {
> > +               sequence = tsc_pg->tsc_sequence;
> > +               if (!sequence)
> > +                       break;
> >
> > Why would you break out of the loop when seq is 0? The 0 is just telling
> > you that there is an update in progress.
> 
> Not only. As far as I understand (and I *think* K. Y. pointed this out)
> when VM is migrating to another host TSC page clocksource is disabled for
> extended period of time so we're better off reading from MSR than
> looping here. With regards to VDSO this means reverting to doing normal
> syscall.

If you migrate to another host and the VM is using the TSC page, then the
TSC page on the new host _must_ be available and accessible _before_ the VM
resumes there. So that extended period of time does not make any sense at
all. Voodoo programming is the only explanation which come to my mind.

Thanks,

	tglx
