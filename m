From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 15:07:45 -0700
Message-ID: <CALCETrUq71jpO1de4pwbVo+hnE-D2FkuqBDFbdyLiDQzNdENEQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <541B5553.7020203@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, David Hepkin <davidhep@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 18, 2014 at 2:57 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 09/18/2014 02:46 PM, David Hepkin wrote:
>> I'm not sure what you mean by "this mechanism?"  Are you suggesting that each hypervisor put "CrossHVPara\0" somewhere in the 0x40000000 - 0x400fffff CPUID range, and an OS has to do a full scan of this CPUID range on boot to find it?  That seems pretty inefficient.  An OS will take 1000's of hypervisor intercepts on every boot just to search this CPUID range.
>>
>> I suggest we come to consensus on a specific CPUID leaf where an OS needs to look to determine if a hypervisor supports this capability.  We could define a new CPUID leaf range at a well-defined location, or we could just use one of the existing CPUID leaf ranges implemented by an existing hypervisor.  I'm not familiar with the KVM CPUID leaf range, but in the case of Hyper-V, the Hyper-V CPUID leaf range was architected to allow for other hypervisors to implement it and just show through specific capabilities supported by the hypervisor.  So, we could define a bit in the Hyper-V CPUID leaf range (since Xen and KVM also implement this range), but that would require Linux to look in that range on boot to discover this capability.
>>
>
> Yes, I would agree that if anything we should define a new range unique
> to this cross-VM interface, e.g. 0x48000000.

So, as a concrete straw-man:

CPUID leaf 0x48000000 would return a maximum leaf number in EAX (e.g.
0x48000001) along with a signature value (e.g. "CrossHVPara\0") in
EBX, ECX, and EDX.

CPUID 0x48000001.EAX would contain an MSR number to read to get a
random number if supported and zero if not supported.

Questions:

1. Can we use a fixed MSR number?  This would be a little bit simpler,
but it would depend on getting a wider MSR range from Intel.

2. Who would host and maintain such a spec?  I could do it on github,
but this seems a bit silly.  Other options would include Intel,
Microsoft, or perhaps the Linux Foundation.  I don't know whether
Intel or LF would want to do this, and MS isn't exactly
vendor-neutral.  (Even L-F isn't entirely neutral, since they sort of
represent two hypervisors.)  Or we could do something temporary and
then try to work with a group like OASIS, but that might end up being
a lot of work.

--Andy
