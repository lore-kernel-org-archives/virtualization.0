From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors	and	Linux.
Date: Wed, 01 Oct 2008 18:11:40 -0700
Message-ID: <1222909900.7330.106.camel__18853.3937711783$1222910259$gmane$org@bodhitayantram.eng.vmware.com>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
	<1222894878.9381.63.camel@alok-dev1> <48E3E8DE.1080602@goop.org>
	<48E3ECD1.30809@codemonkey.ws>
	<1222904824.7330.83.camel@bodhitayantram.eng.vmware.com>
	<48E4183A.7090208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E4183A.7090208@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Anthony Liguori <anthony@codemonkey.ws>, Alok Kataria <akataria@vmware.com>, Ingo Molnar <mingo@elte.hu>, "avi@redhat.com" <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2008-10-01 at 17:39 -0700, H. Peter Anvin wrote:
> third, which is subject to spread-spectrum modulation due to RFI
> concerns.  Therefore, relying on the *nominal* frequency of this clock

I'm not suggesting using the nominal value.  I'm suggesting the
measurement be done in the one and only place where there is perfect
control of the system, the processor boot-strapping in the BIOS.

Only the platform designers themselves know the speed of the oscillator
which is modulating the clock and so only they should be calibrating the
speed of the TSC.

If this modulation really does alter the frequency by +/- 2% (seems high
to me, but hey, I don't design motherboards), using an LFO, then
basically all the calibration done in Linux is broken and has been for
some time.  You can't calibrate only once, or risk being off by 2%, you
can't calibrate repeatedly and take the fastest estimate, or you are off
by 2%, and you can't calibrate repeatedly and take the average without
risking SMI noise affecting the lowest clock speed measurement,
contributing unknown error.

Hmm.  Re-reading your e-mail, I see you are saying the nominal frequency
may be off by 2% (and I easily believe that), not necessarily that the
frequency modulation may be 2% (which I still think is high).  Does
anyone know what the actual bounds on spread spectrum modulation are or
how fast the clock is modulated?

Zach
