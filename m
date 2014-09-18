From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 11:35:39 -0700
Message-ID: <CALCETrWCKe2Pfmgu1gi6jMqdyqQ78kCpKawoLbAFgaN2USMksw@mail.gmail.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<2aa00301e9af4826b5781e01709f81e7@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<541AEF7D.2010007@zytor.com>
	<CALCETrVPAEdQjFaBzk6F5wKScHDAwwyzVCC--iMSHJjrbz4EqQ@mail.gmail.com>
	<5b9c7dcde3824e49a25f3ee00844b868@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT0W4H0VUX+UARphWRm+c9YNz+pOngLNMxFVSTZ05s6OZA@mail.gmail.com>
	<541B13B8.1020006@redhat.com>
	<b697ef83ae594d8fb34347339dd52dfa@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT1nFrbffotNmLSE0+TVBSR3OChfe5Zu1yPNz0ponznVOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAL54oT1nFrbffotNmLSE0+TVBSR3OChfe5Zu1yPNz0ponznVOQ@mail.gmail.com>
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

On Thu, Sep 18, 2014 at 10:42 AM, Nakajima, Jun <jun.nakajima@intel.com> wrote:
> On Thu, Sep 18, 2014 at 10:20 AM, KY Srinivasan <kys@microsoft.com> wrote:
>>
>>
>>> -----Original Message-----
>>> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo
>>> Bonzini
>>> Sent: Thursday, September 18, 2014 10:18 AM
>>> To: Nakajima, Jun; KY Srinivasan
>>> Cc: Mathew John; Theodore Ts'o; John Starks; kvm list; Gleb Natapov; Niels
>>> Ferguson; Andy Lutomirski; David Hepkin; H. Peter Anvin; Jake Oshins; Linux
>>> Virtualization
>>> Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
>>>
>>> Il 18/09/2014 19:13, Nakajima, Jun ha scritto:
>>> > In terms of the address for the MSR, I suggest that you choose one
>>> > from the range between 40000000H - 400000FFH. The SDM (35.1
>>> > ARCHITECTURAL MSRS) says "All existing and future processors will not
>>> > implement any features using any MSR in this range." Hyper-V already
>>> > defines many synthetic MSRs in this range, and I think it would be
>>> > reasonable for you to pick one for this to avoid a conflict?
>>>
>>> KVM is not using any MSR in that range.
>>>
>>> However, I think it would be better to have the MSR (and perhaps CPUID)
>>> outside the hypervisor-reserved ranges, so that it becomes architecturally
>>> defined.  In some sense it is similar to the HYPERVISOR CPUID feature.
>>
>> Yes, given that we want this to be hypervisor agnostic.
>>
>
> Actually, that MSR address range has been reserved for that purpose, along with:
> - CPUID.EAX=1 -> ECX bit 31 (always returns 0 on bare metal)
> - CPUID.EAX=4000_00xxH leaves (i.e. HYPERVISOR CPUID)

I don't know whether this is documented anywhere, but Linux tries to
detect a hypervisor by searching CPUID leaves 0x400xyz00 for
"KVMKVMKVM\0\0\0", so at least Linux can handle the KVM leaves being
in a somewhat variable location.

Do we consider this mechanism to work across all hypervisors and
guests?  That is, could we put something like "CrossHVPara\0"
somewhere in that range, where each hypervisor would be free to decide
exactly where it ends up?

--Andy
