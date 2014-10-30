From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [Xen-devel] [RFC] Hypervisor RNG and enumeration
Date: Thu, 30 Oct 2014 15:12:53 +0000
Message-ID: <1414681973.2064.49.camel@citrix.com>
References: <CALCETrUuSApjNk+xdB1XEPH+Lz2PGY0gnreHwx5Z6xQ0Vj74tw@mail.gmail.com>
	<54522D40.8040405@citrix.com>
	<CALCETrUp2A27tPb=+9LM4KUmpsRHyKqJM-UB1GApvyQqNu36-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrUp2A27tPb=+9LM4KUmpsRHyKqJM-UB1GApvyQqNu36-Q@mail.gmail.com>
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
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, David Hepkin <davidhep@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Doug Covelli <dcovelli@vmware.com>, Jake Oshins <jakeo@microsoft.com>, David Vrabel <david.vrabel@citrix.com>, Jim Mattson <jmattson@vmware.com>, "H.
	Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alok Kataria <akataria@vmware.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2014-10-30 at 07:45 -0700, Andy Lutomirski wrote:
> > Xen does not have a continual source of entropy and the only feasible
> > way is for the toolstack to provide each guest with a fixed size pool of
> > random data during guest creation.
> >
> 
> Xen could seed a very simple per-guest DRBG at guest startup and then
> let the rdmsr call read from it.

I think I'm a bit confused by the intended scope of this facility. The
original spec said:
        
        Note that the CommonHV RNG is not intended to replace stronger, asynchronous
        paravirtual random number generator interfaces.  It is intended primarily
        for seeding guest RNGs early in boot.
        
Which to me reads that the guest should be using this facility to seed
it's own simple DRBG on boot (with some finite amount of seed data from
the hv) and then using that until it can switch to something better. Is
that not the intention?

I think it's important to nail down the intended scope of this
interface, since it has quite an impact on what would be considered a
reasonable common design. 

Post boot I would as you say expect most OSes to switch over to
something more capable, not continue to rely on this facility for the
duration.

Ian.
