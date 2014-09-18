From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 14:35:28 -0700
Message-ID: <CALCETrU55Q68BQkYuLBuviG_WO3wpebFCps7gLJezTX-QaOB9Q@mail.gmail.com>
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
	<CAL54oT1QB3MKYkWf7y+_zKuxVqyr7L+32AuKuPAMwyXcXUkjFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAL54oT1QB3MKYkWf7y+_zKuxVqyr7L+32AuKuPAMwyXcXUkjFA@mail.gmail.com>
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

On Thu, Sep 18, 2014 at 2:21 PM, Nakajima, Jun <jun.nakajima@intel.com> wrote:
> On Thu, Sep 18, 2014 at 12:07 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>
>> Might Intel be willing to extend that range to 0x40000000 -
>> 0x400fffff?  And would Microsoft be okay with using this mechanism for
>> discovery?
>
> So, for CPUID, the SDM (Table 3-17. Information Returned by CPUID) says today:
> "No existing or future CPU will return processor identification or
> feature information if the initial EAX value is in the range 40000000H
> to 4FFFFFFFH."
>
> We can define a cross-VM CPUID range from there. The CPUID can return
> the index of the MSR if needed.

Right, sorry.  I was looking at this sentence in SDM Volume 3 Section 35.1:

MSR address range between 40000000H - 400000FFH is marked as a
specially reserved range. All existing and
future processors will not implement any features using any MSR in this range.

That's not really a large enough range for us to reserve an MSR for
this.  However, KVM, is already using MSRs outside that range: it uses
0x4b564d00-0x4b564d04 or so.  I wonder whether KVM got confused by the
differing ranges for cpuid leaves and MSR indices.

Any chance that Intel could reserve a larger range to include the KVM
MSRs?  It would also be easier if the MSR indices for cross-HV
features were constants.

Thanks,
Andy
