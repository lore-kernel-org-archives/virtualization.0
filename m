From: Ian Jackson <Ian.Jackson@eu.citrix.com>
Subject: Re: [Xen-devel] [RFC] Hypervisor RNG and enumeration
Date: Wed, 29 Oct 2014 15:14:21 +0000
Message-ID: <21585.1101.912184.610549@mariner.uk.xensource.com>
References: <CALCETrUuSApjNk+xdB1XEPH+Lz2PGY0gnreHwx5Z6xQ0Vj74tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrUuSApjNk+xdB1XEPH+Lz2PGY0gnreHwx5Z6xQ0Vj74tw@mail.gmail.com>
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
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, Jim Mattson <jmattson@vmware.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, David Hepkin <davidhep@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Doug Covelli <dcovelli@vmware.com>, Paolo Bonzini <pbonzini@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Andy Lutomirski writes ("[Xen-devel] [RFC] Hypervisor RNG and enumeration"):
> Here's a draft CommonHV spec.  It's also on github:
> https://github.com/amluto/CommonHV

This a worthwhile direction to investigate, and an interesting
proposal.  From a Xen point of view I have some concerns, though.

I think in Xen we would want to implement the bulk of the provision of
random numbers to guests outside the hypervisor.  That is, the
hypervisor itself should not have random number pool code, associated
policy, and so on.  We would like to avoid adding too much code to the
hypervisor.

That functionality should live in the lower toolstack layers.  For the
benefit of people who want to do radical disaggregation (for security
reasons), it should be capable of being provided by a different domain
to dom0.

I think a fully general interface based purely on MSRs makes that
difficult in a number of ways:

 * Currently I don't think there is any way in Xen to cause MSR
   accesses to be passed to toolstack support programs.

 * In some configurations, Xen PV domains do not have a suitable
   longrunning service process to handle requests of this kind.

 * MSR reads of this kind might be expected to be fast but if they
   involve trapping to a service domain they might be very slow.

 * This interface is very x86-specific.


It seems to me that the real need for this facility is to provide a
good seed for the guest's own cryptographic PRNG.  If we restrict
ourselves to that use case, we can sidestep the difficulties.

In particular, the parts of this proposal that are most difficult are:

 * The facility for the guest to provide random numbers back to the
   host.  I think this can be dealt with easily by hypervisor-specific
   mechanisms, if it is desirable.

 * The implication that a hypervisor ought to be providing a unbounded
   stream of random numbers, rather than a fixed amount of seed.


I think the most obvious approach would be to provide the VM, at
startup, with a page containing a fixed amount of random number seed,
along with some metatdata.

Some platform-specific way of discovering the location of the page
would have to be defined.  (That might an MSR but more likely it would
be Device Tree or ACPI.)

After the guest has read the page, it would be free to treat it as
normal memory.

The metadata need do little more than specify the length and the
amount of provided entropy.  There should be some room for expansion.

The specification should say that the provided seed MUST be
cryptographically secure, MUST have as much entropy as stated and that
that amount of entropy MUST be at least (say) 64 bits and SHOULD be at
least (say) 256 bits.

Ian.
