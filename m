From: Gleb Natapov <gleb@kernel.org>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Fri, 19 Sep 2014 19:37:50 +0300
Message-ID: <20140919163749.GI26540@minantech.com>
References: <5b9c7dcde3824e49a25f3ee00844b868@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT0W4H0VUX+UARphWRm+c9YNz+pOngLNMxFVSTZ05s6OZA@mail.gmail.com>
	<541B13B8.1020006@redhat.com>
	<b697ef83ae594d8fb34347339dd52dfa@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT1nFrbffotNmLSE0+TVBSR3OChfe5Zu1yPNz0ponznVOQ@mail.gmail.com>
	<CALCETrWCKe2Pfmgu1gi6jMqdyqQ78kCpKawoLbAFgaN2USMksw@mail.gmail.com>
	<1969371640.51211843.1411066715223.JavaMail.zimbra@redhat.com>
	<CALCETrUGS_V2h_beStbVyoTC8vuKiudmJwt55Q2BJg=S2KCNKw@mail.gmail.com>
	<0180a8dfcad746a895755c4374853c16@BY2PR03MB585.namprd03.prod.outlook.com>
	<CALCETrUgcJt7p_aS0njtHmvPQ=XxNdonFHtPzFgVNpAE4U=R3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrUgcJt7p_aS0njtHmvPQ=XxNdonFHtPzFgVNpAE4U=R3Q@mail.gmail.com>
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
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, David Hepkin <davidhep@microsoft.com>, kvm list <kvm@vger.kernel.org>, Niels Ferguson <niels@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 18, 2014 at 03:00:05PM -0700, Andy Lutomirski wrote:
> On Thu, Sep 18, 2014 at 2:46 PM, David Hepkin <davidhep@microsoft.com> wrote:
> > I suggest we come to consensus on a specific CPUID leaf where an OS needs to look to determine if a hypervisor supports this capability.  We could define a new CPUID leaf range at a well-defined location, or we could just use one of the existing CPUID leaf ranges implemented by an existing hypervisor.  I'm not familiar with the KVM CPUID leaf range, but in the case of Hyper-V, the Hyper-V CPUID leaf range was architected to allow for other hypervisors to implement it and just show through specific capabilities supported by the hypervisor.  So, we could define a bit in the Hyper-V CPUID leaf range (since Xen and KVM also implement this range), but that would require Linux to look in that range on boot to discover this capability.
> 
> I also don't know whether QEMU and KVM would be okay with implementing
> the host side of the Hyper-V mechanism by default.  They would have to
> implement at least leaves 0x40000001 and 0x4000002, plus correctly
> reporting zeros through whatever leaf is used for this new feature.
> Gleb?  Paolo?
> 
KVM and any other hypervisor out there already implement capability
detection mechanism in 0x40000000 range, and of course all of them do
it differently. Linux detects what hypervior it runs on very early and
switch to correspondent code to handle each hypervisor. Quite frankly
I do not see what problem you are trying to fix with standardizing MSR
to get RND and detection mechanism for this MSR. RND MSR is in no way
unique here. There are other mechanisms that are virtually identical
between hypervisors but have different gust/hypervisor interfaces and
are detected differently on different hypervisors. Examples are pvclock,
pveoi may be others.

--
			Gleb.
