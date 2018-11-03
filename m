From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] i8253: Fix PIT shutdown quirk on Hyper-V
Date: Sat, 3 Nov 2018 18:22:05 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1811031817570.3160@nanos.tec.linutronix.de>
References: <1541093374-10496-1-git-send-email-mikelley@microsoft.com>
	<11f82d95-539c-b680-183b-b6c5c60468a8@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11f82d95-539c-b680-183b-b6c5c60468a8@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, "apw@canonical.com" <apw@canonical.com>, "akataria@vmware.com" <akataria@vmware.com>, Michael Kelley <mikelley@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2 Nov 2018, Juergen Gross wrote:
> On 01/11/2018 18:30, Michael Kelley wrote:
> > pit_shutdown() doesn't work on Hyper-V because of a quirk in the
> > PIT emulation. This problem exists in all versions of Hyper-V and
> > had not been noticed previously. When the counter register is set
> > to zero, the emulated PIT continues to interrupt @18.2 HZ.
> > 
> > So add a test for running on Hyper-V, and use that test to skip
> > setting the counter register when running on Hyper-V.
> > 
> > This patch replaces a previously proposed patch with a different
> > approach. This new approach follows comments from Thomas Gleixner.
> 
> Did you consider using a static_key instead? You could set it in
> ms_hyperv_init_platform(). This would enable you to support future
> Hyper-V versions which don't require avoiding to set the count to zero.

Duh. Now that you say it it's more than obvious. Instead of checking for
running on hyperv have a quirk check in that function and set it from
hyperv. Not necessarily a static key required as this is not a fast path,
so a simple ro_after_init marked variable is good enough

Michael, sorry for guiding you down the wrong road. Juergens idea is much
better.

If you redo that, could you please make sure, that your mail series is
properly threaded? i.e. the 1..n/n mails contain a

	 Reference: <message_id_of_0/n>

Thanks,

	tglx
