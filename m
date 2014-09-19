From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Fri, 19 Sep 2014 08:04:44 +0200
Message-ID: <541BC77C.6060607@redhat.com>
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
	<CALCETrXbV1qLZOt3aDbXRSSxApS0Qvb1WFPmkOrn8o1zyGVK6w@mail.gmail.com>
	<572ba53a2e1e4278823f718a421e2c1d@BY2PR03MB585.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <572ba53a2e1e4278823f718a421e2c1d@BY2PR03MB585.namprd03.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hepkin <davidhep@microsoft.com>, Andy Lutomirski <luto@amacapital.net>, Niels Ferguson <niels@microsoft.com>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, John Starks <John.Starks@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 18/09/2014 23:54, David Hepkin ha scritto:
> The chief advantage I see to using a hypercall based mechanism is
> that it would work across more architectures.  MSR's and CPUID's are
> specific to X86.  If we ever wanted this same mechanism to be
> available on an architecture that doesn't support MSR's,  a hypercall
> based approach would allow for a more consistent mechanism across the
> architectures.
> 
> I agree, though, that converging on a common hypercall interface that
> would be implemented by all of the hypervisors would likely be much
> harder to achieve.

There are differences between architectures at the hypercall level,
starting with the calling convention.  So I don't think it makes much
sense to use a hypercall.

Paolo
