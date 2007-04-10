From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 9/10] Vmi timer update.patch
Date: Tue, 10 Apr 2007 10:24:29 -0700
Message-ID: <20070410172429.GN10574@sequoia.sous-sol.org>
References: <200704100006.l3A06RUR020644@zach-dev.vmware.com>
	<20070410023702.GJ10574@sequoia.sous-sol.org>
	<461BC373.10306@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <461BC373.10306@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Thomas Gleixner <tglx@linutronix.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

* Zachary Amsden (zach@vmware.com) wrote:
> >>+void __init vmi_time_init(void)
> >>+{
> >>+	/* Disable PIT: BIOSes start PIT CH0 with 18.2hz peridic. */
> >>+	outb_p(0x3a, PIT_MODE); /* binary, mode 5, LSB/MSB, ch 0 */
> >
> >That shouldn't be necessary using clockevents.
> =

> Actually, I'm not so sure.  If clockevents simply masks the PIT when =

> disabling it, we still have overhead of keeping the latch in sync, which =

> requires a timer at the PIT frequency.  I can instrument to see how =

> exactly the PIT gets disabled.

It should switch from pit to vmi-timer, and the switch should do the state
transistions on pit to go to unused mode.

> >>+	vmi_time_init_clockevent();
> >>+	setup_irq(0, &vmi_clock_action);
> >>+}
> >>+
> >>+#ifdef CONFIG_X86_LOCAL_APIC
> >>+void __devinit vmi_time_bsp_init(void)
> >>+{
> >>+	/*
> >>+	 * On APIC systems, we want local timers to fire on each cpu.  We do
> >>+	 * this by programming LVTT to deliver timer events to the IRQ =

> >>handler
> >>+	 * for IRQ-0, since we can't re-use the APIC local timer handler
> >>+	 * without interfering with that code.
> >>+	 */
> >>+	clockevents_notify(CLOCK_EVT_NOTIFY_SUSPEND, NULL);
> >
> >Why do you do this suspend...
> =

> We need to cancel all pending PIT timer events and restart then local =

> timer, which requires atomically taking over IRQ-0.  We use the IDT gate =

> for IRQ-0 because it is already an exclusive interrupt, but we can't =

> re-use the LVTT IDT gate for local timer since that requires a custom =

> custom SMP interrupt in entry.S.  So we must be absolutely sure when we =

> get an interrupt on IRQ-0 that it came from the VMI local (rather than =

> PIT) delivery path.

OK, this is why it seems odd.  Clockevents should put pit timer into
unused state.

> >>+	local_irq_disable();
> >>+#ifdef CONFIG_X86_SMP
> >>+	/*
> >>+	 * XXX handle_percpu_irq only defined for SMP; we need to switch over
> >>+	 * to using it, since this is a local interrupt, which each CPU must
> >>+	 * handle individually without locking out or dropping simultaneous
> >>+	 * local timers on other CPUs.  We also don't want to trigger the
> >>+	 * quirk workaround code for interrupts which gets invoked from
> >>+	 * handle_percpu_irq via eoi, so we use our own IRQ chip.
> >>+	 */
> >>+	set_irq_chip_and_handler_name(0, &vmi_chip, handle_percpu_irq, =

> >>"lvtt");
> >>+#else
> >>+	set_irq_chip_and_handler_name(0, &vmi_chip, handle_edge_irq, "lvtt");
> >>+#endif
> >>+	vmi_wiring =3D VMI_ALARM_WIRED_LVTT;
> >>+	apic_write(APIC_LVTT, vmi_get_timer_vector());
> >>    =

> >
> >isn't this just your ->startup?
> =

> Which structure has a ->startup function we can use?  Sorry if this =

> seems ignorant, I'm not quite sure what you mean.

The irq_chip.  IOW, it looks like a liberal sprinkling of LVTT vector
initialization.

> >>+	local_irq_enable();
> >>+	clockevents_notify(CLOCK_EVT_NOTIFY_RESUME, NULL);
> >...and resume?  Instead of letting clockevents core handle all of that,
> >and just registering right here?
> =

> It wasn't clear that clockevents would issue a resume notify for us; if =

> so we could handle this setup in the callback, but it has to be done on =

> the correct CPU.  I can try it and see if that works.

I would've expected to simply register the clockevents device right here,
and that should do the proper state transitions on the old device, as well
as the new device.  Why do you need resume notify?

thanks,
-chris
