From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 14:58:35 -0400 (EDT)
Message-ID: <1969371640.51211843.1411066715223.JavaMail.zimbra@redhat.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<CALCETrVPAEdQjFaBzk6F5wKScHDAwwyzVCC--iMSHJjrbz4EqQ@mail.gmail.com>
	<5b9c7dcde3824e49a25f3ee00844b868@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT0W4H0VUX+UARphWRm+c9YNz+pOngLNMxFVSTZ05s6OZA@mail.gmail.com>
	<541B13B8.1020006@redhat.com>
	<b697ef83ae594d8fb34347339dd52dfa@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT1nFrbffotNmLSE0+TVBSR3OChfe5Zu1yPNz0ponznVOQ@mail.gmail.com>
	<CALCETrWCKe2Pfmgu1gi6jMqdyqQ78kCpKawoLbAFgaN2USMksw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrWCKe2Pfmgu1gi6jMqdyqQ78kCpKawoLbAFgaN2USMksw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, John Starks <John.Starks@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, David Hepkin <davidhep@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org


> > Actually, that MSR address range has been reserved for that purpose, along
> > with:
> > - CPUID.EAX=1 -> ECX bit 31 (always returns 0 on bare metal)
> > - CPUID.EAX=4000_00xxH leaves (i.e. HYPERVISOR CPUID)
> 
> I don't know whether this is documented anywhere, but Linux tries to
> detect a hypervisor by searching CPUID leaves 0x400xyz00 for
> "KVMKVMKVM\0\0\0", so at least Linux can handle the KVM leaves being
> in a somewhat variable location.
> 
> Do we consider this mechanism to work across all hypervisors and
> guests?  That is, could we put something like "CrossHVPara\0"
> somewhere in that range, where each hypervisor would be free to decide
> exactly where it ends up?

That's also possible, but extending the hypervisor CPUID range
beywond 400000FFH is not officially sanctioned by Intel.

Xen started doing that in order to expose both Hyper-V and Xen
CPUID leaves, and KVM followed the practice.

Paolo
