From: David Hepkin <davidhep@microsoft.com>
Subject: RE: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 21:46:05 +0000
Message-ID: <0180a8dfcad746a895755c4374853c16__8628.40701961449$1411159188$gmane$org@BY2PR03MB585.namprd03.prod.outlook.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrUGS_V2h_beStbVyoTC8vuKiudmJwt55Q2BJg=S2KCNKw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, John Starks <John.Starks@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter
	Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

I'm not sure what you mean by "this mechanism?"  Are you suggesting that each hypervisor put "CrossHVPara\0" somewhere in the 0x40000000 - 0x400fffff CPUID range, and an OS has to do a full scan of this CPUID range on boot to find it?  That seems pretty inefficient.  An OS will take 1000's of hypervisor intercepts on every boot just to search this CPUID range.

I suggest we come to consensus on a specific CPUID leaf where an OS needs to look to determine if a hypervisor supports this capability.  We could define a new CPUID leaf range at a well-defined location, or we could just use one of the existing CPUID leaf ranges implemented by an existing hypervisor.  I'm not familiar with the KVM CPUID leaf range, but in the case of Hyper-V, the Hyper-V CPUID leaf range was architected to allow for other hypervisors to implement it and just show through specific capabilities supported by the hypervisor.  So, we could define a bit in the Hyper-V CPUID leaf range (since Xen and KVM also implement this range), but that would require Linux to look in that range on boot to discover this capability.

Thanks...

David

-----Original Message-----
From: Andy Lutomirski [mailto:luto@amacapital.net] 
Sent: Thursday, September 18, 2014 12:07 PM
To: Paolo Bonzini
Cc: Jun Nakajima; KY Srinivasan; Mathew John; Theodore Ts'o; John Starks; kvm list; Gleb Natapov; Niels Ferguson; David Hepkin; H. Peter Anvin; Jake Oshins; Linux Virtualization
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?

On Thu, Sep 18, 2014 at 11:58 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>> > Actually, that MSR address range has been reserved for that 
>> > purpose, along
>> > with:
>> > - CPUID.EAX=1 -> ECX bit 31 (always returns 0 on bare metal)
>> > - CPUID.EAX=4000_00xxH leaves (i.e. HYPERVISOR CPUID)
>>
>> I don't know whether this is documented anywhere, but Linux tries to 
>> detect a hypervisor by searching CPUID leaves 0x400xyz00 for 
>> "KVMKVMKVM\0\0\0", so at least Linux can handle the KVM leaves being 
>> in a somewhat variable location.
>>
>> Do we consider this mechanism to work across all hypervisors and 
>> guests?  That is, could we put something like "CrossHVPara\0"
>> somewhere in that range, where each hypervisor would be free to 
>> decide exactly where it ends up?
>
> That's also possible, but extending the hypervisor CPUID range beywond 
> 400000FFH is not officially sanctioned by Intel.
>
> Xen started doing that in order to expose both Hyper-V and Xen CPUID 
> leaves, and KVM followed the practice.
>

Whoops.

Might Intel be willing to extend that range to 0x40000000 - 0x400fffff?  And would Microsoft be okay with using this mechanism for discovery?

Do we have anyone from VMware in this thread?  I don't have any VMware contacts.

--Andy
