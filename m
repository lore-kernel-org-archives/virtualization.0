From: KY Srinivasan <kys@microsoft.com>
Subject: RE: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 16:36:45 +0000
Message-ID: <5b9c7dcde3824e49a25f3ee00844b868__5122.00583839348$1411060169$gmane$org@BY2PR0301MB0711.namprd03.prod.outlook.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<2aa00301e9af4826b5781e01709f81e7@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<541AEF7D.2010007@zytor.com>
	<CALCETrVPAEdQjFaBzk6F5wKScHDAwwyzVCC--iMSHJjrbz4EqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrVPAEdQjFaBzk6F5wKScHDAwwyzVCC--iMSHJjrbz4EqQ@mail.gmail.com>
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
To: Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, Niels Ferguson <niels@microsoft.com>, David Hepkin <davidhep@microsoft.com>, Mathew John <mathewj@microsoft.com>, John Starks <John.Starks@microsoft.com>
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Theodore Ts'o <tytso@mit.edu>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Andy Lutomirski [mailto:luto@amacapital.net]
> Sent: Thursday, September 18, 2014 8:38 AM
> To: H. Peter Anvin
> Cc: KY Srinivasan; Linux Virtualization; kvm list; Gleb Natapov; Paolo Bonzini;
> Theodore Ts'o
> Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
> 
> On Thu, Sep 18, 2014 at 7:43 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> > On 09/18/2014 07:40 AM, KY Srinivasan wrote:
> >>>
> >>> The main questions are what MSR index to use and how to detect the
> >>> presence of the MSR.  I've played with two approaches:
> >>>
> >>> 1. Use CPUID to detect the presence of this feature.  This is very
> >>> easy for KVM to implement by using a KVM-specific CPUID feature.
> >>> The problem is that this will necessarily be KVM-specific, as the
> >>> guest must first probe for KVM and then probe for the KVM feature.
> >>> I doubt that Hyper-V, for example, wants to claim to be KVM.  If we
> >>> could standardize a non- hypervisor-specific CPUID feature, then this
> problem would go away.
> >>
> >> We would prefer a CPUID feature bit to detect this feature.
> >>
> >
> > I guess if we're introducing the concept of pan-OS MSRs we could also
> > have pan-OS CPUID.  The real issue is to get a single non-conflicting
> > standard.
> 
> Agreed.
> 
> KVM currently puts 0 in 0x40000000.EAX, meaning that a feature bit in
> Microsoft's leaf 0x40000003 would probably not work well for KVM.  I don't
> expect that Microsoft wants to start claiming to be KVM for the purpose of
> using a KVM-style feature bit, so, if we went the CPUID route, we would
> probably need something new.
> 
> --Andy

I am copying other Hyper-V engineers to this discussion.

Regards,

K. Y
> 
> >
> >         -hpa
> >
> >
> 
> 
> 
> --
> Andy Lutomirski
> AMA Capital Management, LLC
