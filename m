From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Fri, 19 Sep 2014 15:57:05 -0700
Message-ID: <CAL54oT1AnWswhaXLNuMWjdv-b8ihnQc9N=A_b2gyjo_BWhPjiw@mail.gmail.com>
References: <1969371640.51211843.1411066715223.JavaMail.zimbra@redhat.com>
	<CALCETrUGS_V2h_beStbVyoTC8vuKiudmJwt55Q2BJg=S2KCNKw@mail.gmail.com>
	<0180a8dfcad746a895755c4374853c16@BY2PR03MB585.namprd03.prod.outlook.com>
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
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, John Starks <John.Starks@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Hepkin <davidhep@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 19, 2014 at 3:06 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Fri, Sep 19, 2014 at 3:05 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>> On Fri, Sep 19, 2014 at 09:40:42AM -0700, H. Peter Anvin wrote:
>>>
>>> There is a huge disadvantage to the fact that CPUID is a user space
>>> instruction, though.
>>
>> But if the goal is to provide something like getrandom(2) direct from
>> the Host OS, it's not necessarily harmful to allow the Guest ring 3
>> code to be able to fetch randomness in that way.  The hypervisor can
>> implement rate limiting to protect against the guest using this too
>> frequently, but this is something that you should be doing for guest
>> ring 0 code anyway, since from the POV of the hypervisor Guest ring 0
>> is not necessarily any more trusted than Guest ring 3.
>
> On the other hand, the guest kernel might not want the guest ring 3 to
> be able to get random numbers.
>

But the RDSEED instruction, for example, is available in user-level.
And I'm not sure that the kernel can do something with that.

-- 
Jun
Intel Open Source Technology Center
