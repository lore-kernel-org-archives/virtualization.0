From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 18:03:46 -0700
Message-ID: <CALCETrUXz1B=x6rjkQri_qU5Tv-XM5du=rUr-=E-EfNSvOnThg@mail.gmail.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<CALCETrVPAEdQjFaBzk6F5wKScHDAwwyzVCC--iMSHJjrbz4EqQ@mail.gmail.com>
	<5b9c7dcde3824e49a25f3ee00844b868@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT0W4H0VUX+UARphWRm+c9YNz+pOngLNMxFVSTZ05s6OZA@mail.gmail.com>
	<541B13B8.1020006@redhat.com>
	<b697ef83ae594d8fb34347339dd52dfa@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT1nFrbffotNmLSE0+TVBSR3OChfe5Zu1yPNz0ponznVOQ@mail.gmail.com>
	<CALCETrWCKe2Pfmgu1gi6jMqdyqQ78kCpKawoLbAFgaN2USMksw@mail.gmail.com>
	<1969371640.51211843.1411066715223.JavaMail.zimbra@redhat.com>
	<CALCETrUGS_V2h_beStbVyoTC8vuKiudmJwt55Q2BJg=S2KCNKw@mail.gmail.com>
	<0180a8dfcad746a895755c4374853c16@BY2PR03MB585.namprd03.prod.outlook.com>
	<541B5553.7020203@zytor.com>
	<CALCETrUq71jpO1de4pwbVo+hnE-D2FkuqBDFbdyLiDQzNdENEQ@mail.gmail.com>
	<CAL54oT1Q8kABge=t4s5REVWWakboON-6vfszMRkVz=ks_3vRoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAL54oT1Q8kABge=t4s5REVWWakboON-6vfszMRkVz=ks_3vRoA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, John Starks <John.Starks@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Hepkin <davidhep@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 18, 2014 at 5:49 PM, Nakajima, Jun <jun.nakajima@intel.com> wrote:
> On Thu, Sep 18, 2014 at 3:07 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>
>> So, as a concrete straw-man:
>>
>> CPUID leaf 0x48000000 would return a maximum leaf number in EAX (e.g.
>> 0x48000001) along with a signature value (e.g. "CrossHVPara\0") in
>> EBX, ECX, and EDX.
>>
>> CPUID 0x48000001.EAX would contain an MSR number to read to get a
>> random number if supported and zero if not supported.
>>
>> Questions:
>>
>> 1. Can we use a fixed MSR number?  This would be a little bit simpler,
>> but it would depend on getting a wider MSR range from Intel.
>>
>
> Why do you need a wider MSR range if you always detect the feature by
> CPUID.0x48000001?
> Or are you still trying to avoid the detection by CPUID?

Detecting the feature is one thing, but figuring out the MSR index is
another.  We could shove the index into the cpuid leaf, but that seems
unnecessarily indirect.  I'd much rather just say that CPUID leaves
*and* MSR indexes 0x48000000-0x4800ffff or so are reserved for the
cross-HV mechanism, but we can't do that without either knowingly
violating the SDM assignments or asking Intel to consider allocating
more MSR indexes.

Also, KVM is already conflicting with the SDM right now in its MSR
choice :(  I *think* that KVM could be changed to fix that, but 256
MSRs is rather confining given that KVM currently implements its own
MSR index *and* part of the Hyper-V index.

--Andy
