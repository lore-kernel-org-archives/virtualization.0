From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Fri, 19 Sep 2014 18:57:27 -0400
Message-ID: <20140919225727.GT26995@thunk.org>
References: <0180a8dfcad746a895755c4374853c16@BY2PR03MB585.namprd03.prod.outlook.com>
	<541B5553.7020203@zytor.com>
	<CALCETrUq71jpO1de4pwbVo+hnE-D2FkuqBDFbdyLiDQzNdENEQ@mail.gmail.com>
	<CAL54oT1Q8kABge=t4s5REVWWakboON-6vfszMRkVz=ks_3vRoA@mail.gmail.com>
	<CALCETrUXz1B=x6rjkQri_qU5Tv-XM5du=rUr-=E-EfNSvOnThg@mail.gmail.com>
	<CALCETrWZ1cF23aT82yGfTKS48d2G+_Od7hEkAzDWzDhqpHNVqA@mail.gmail.com>
	<CAL54oT0sibBiLSHf+eajdRgxqs1jgSzdTTCWBUH9M25ZL10EzA@mail.gmail.com>
	<541C5C8A.6030304@zytor.com> <20140919220537.GR26995@thunk.org>
	<CALCETrXct3eqJH7wATfR=H3NrAHXMkydRKsctVhpzZ4jsv87bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXct3eqJH7wATfR=H3NrAHXMkydRKsctVhpzZ4jsv87bw@mail.gmail.com>
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
Cc: Mathew John <mathewj@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Hepkin <davidhep@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 19, 2014 at 03:06:55PM -0700, Andy Lutomirski wrote:
> On Fri, Sep 19, 2014 at 3:05 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> > On Fri, Sep 19, 2014 at 09:40:42AM -0700, H. Peter Anvin wrote:
> >>
> >> There is a huge disadvantage to the fact that CPUID is a user space
> >> instruction, though.
> >
> > But if the goal is to provide something like getrandom(2) direct from
> > the Host OS, it's not necessarily harmful to allow the Guest ring 3
> > code to be able to fetch randomness in that way.  The hypervisor can
> > implement rate limiting to protect against the guest using this too
> > frequently, but this is something that you should be doing for guest
> > ring 0 code anyway, since from the POV of the hypervisor Guest ring 0
> > is not necessarily any more trusted than Guest ring 3.
> 
> On the other hand, the guest kernel might not want the guest ring 3 to
> be able to get random numbers.

Um, why?

We're talking about using this to seed the RNG, and not something that
the guest kernel would be using continuously.  So what's the problem
with letting the guest ring get random numbers from the host?

     	     	       	    	       	       - Ted
