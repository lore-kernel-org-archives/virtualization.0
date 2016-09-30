From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/vmware: Skip lapic calibration on VMware.
Date: Fri, 30 Sep 2016 10:52:56 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609301023560.4799@nanos>
References: <9FDEBA6F-7CB2-4637-BFC7-EA336B97EDAD@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1159237027-1475224214=:4799"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9FDEBA6F-7CB2-4637-BFC7-EA336B97EDAD@vmware.com>
Content-ID: <alpine.DEB.2.20.1609301032230.4799@nanos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Renat Valiullin <rvaliullin@vmware.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1159237027-1475224214=:4799
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.20.1609301032231.4799@nanos>

On Thu, 29 Sep 2016, Renat Valiullin wrote:
> In virtualized environment the APIC timer calibration could go wrong
> when the host is overcommitted or the guest is running nested,
> this would result in the APIC timers operating at an incorrect frequency.
> Since VMware supports a mechanism to retrieve the local APIC frequency
> we can ask the hypervisor for it and skip this APIC calibration loop.
> 
> Signed-off-by: Renat Valiullin <rvaliullin@vmware.com>
> Acked-by: Alok N Kataria <akataria@vmware.com>
> ---
>  arch/x86/kernel/cpu/vmware.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Please fix your mail client so it does not mangle the patch into DOS
format. Aside of that it's white space mangled, i.e. the tabs are converted
to spaces.
 
Please send your patch to yourself, export it to a mbox and apply it with
git am.

> -       if (ebx != UINT_MAX)
> +       if (ebx != UINT_MAX) {
>                 x86_platform.calibrate_tsc = vmware_get_tsc_khz;
> -       else
> +#ifdef CONFIG_X86_LOCAL_APIC
> +               /* Skip lapic calibration since we know the bus frequency. */
> +               lapic_timer_frequency = ecx / HZ;
> +               pr_info("Host bus clock speed read from hypervisor : %u Hz\n",
> +                       ecx);
> +#endif
> +       } else
>                 pr_warn("Failed to get TSC freq from the hypervisor\n");

Please add braces around this as well. See Documentation/Codingstyle

Thanks,

	tglx

--8323329-1159237027-1475224214=:4799
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--8323329-1159237027-1475224214=:4799--
