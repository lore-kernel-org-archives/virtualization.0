From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 12:03:42 -0700
Message-ID: <CALCETrXbV1qLZOt3aDbXRSSxApS0Qvb1WFPmkOrn8o1zyGVK6w@mail.gmail.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<2aa00301e9af4826b5781e01709f81e7@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<541AEF7D.2010007@zytor.com>
	<CALCETrVPAEdQjFaBzk6F5wKScHDAwwyzVCC--iMSHJjrbz4EqQ@mail.gmail.com>
	<5b9c7dcde3824e49a25f3ee00844b868@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT0W4H0VUX+UARphWRm+c9YNz+pOngLNMxFVSTZ05s6OZA@mail.gmail.com>
	<541B13B8.1020006@redhat.com>
	<b697ef83ae594d8fb34347339dd52dfa@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT1nFrbffotNmLSE0+TVBSR3OChfe5Zu1yPNz0ponznVOQ@mail.gmail.com>
	<CALCETrWCKe2Pfmgu1gi6jMqdyqQ78kCpKawoLbAFgaN2USMksw@mail.gmail.com>
	<f879d1d0-8444-4653-a25a-d2216bcd7312@email.android.com>
	<e2ac32426deb468b97bd1445091e351a@BL2PR03MB243.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <e2ac32426deb468b97bd1445091e351a@BL2PR03MB243.namprd03.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Niels Ferguson <niels@microsoft.com>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, John Starks <John.Starks@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, David Hepkin <davidhep@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 18, 2014 at 11:54 AM, Niels Ferguson <niels@microsoft.com> wrote:
> Defining a standard way of transferring random numbers between the host and the guest is an excellent idea.
>
> As the person who writes the RNG code in Windows, I have a few comments:
>
> DETECTION:
> It should be possible to detect this feature through CPUID or similar mechanism. That allows the code that uses this feature to be written without needing the ability to catch CPU exceptions. I could be wrong, but as far as I know there is no support for exception handling in the Windows OS loader where we gather our initial random state.
>

Linux is like this, too, except that I have experimental code to
create an IDT in that code, so we can handle it.  I agree, though,
that using CPUID in early boot is easier.

> EFFICIENCY:
> Is there a way we can transfer more bytes per interaction? With a single 64-bit MSR we always need multiple reads to get a seed, and each of them results in a context switch to the host, which is expensive. This is even worse for 32-bit guests. Windows would typically need to fetch 64 bytes of random data at boot and at regular intervals. It is not a show-stopper, but better efficiency would be nice.

I thought about this for a while and didn't come up with anything that
wouldn't messy.  We could fudge the MSR rax/rdx high bits to get 128
bits, but that's nonportable and awful to implement.  We could return
a random number directly from CPUID, but that's weird.

In very informal benchmarking, rdmsr wasn't that bad.  On the other
hand, I wasn't immediately planning on using the msr on an ongoing
basis on Linux guests except after suspend/resume.

>
> GUEST-TO-HOST:
> Can we also define a way to have random values flow from the guest to the host? Guests are also gathering entropy from their own sources, and if we allow the guests to send random data to the host, then the host can treat it as an entropy source and all the VMs on a single host can share their entropy. (This is not a security problem; any reasonable host RNG cannot be hurt even by maliciously chosen entropy inputs.)
>

wrmsr on the same MSR?

>
> I don't know much about how hypervisors work on the inside, but maybe we can define a mechanism for standardized hypervisor calls that work on all hypervisors that support this feature. Then we could define a function to do an entropy exchange: the guest provides N bytes of random data to the host, and the host replies with N bytes of random data. The data exchange can now be done through memory.
>
> A standardized hypervisor-call mechanism also seems generally useful for future features, whereas the MSR solution is very limited in what it can do. We might end up with standardized hypervisor-calls in the future for some other reason, and then the MSR solution looks very odd.

I think there'll be resistance to a standardized hypercall mechanism,
just because the implementations tend to be complex.  Hyper-V uses a
special page in guest physical memory that contains a trampoline.

We could use wrmsr to a register where the payload is a pointer to a
buffer to receive random bytes, but that loses some of the simplicity
of just calling rdmsr a few times.

--Andy
