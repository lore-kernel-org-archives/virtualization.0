From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Fri, 19 Sep 2014 10:18:37 -0700
Message-ID: <541C656D.5040808@zytor.com>
References: <CAL54oT1nFrbffotNmLSE0+TVBSR3OChfe5Zu1yPNz0ponznVOQ@mail.gmail.com>
	<CALCETrWCKe2Pfmgu1gi6jMqdyqQ78kCpKawoLbAFgaN2USMksw@mail.gmail.com>
	<1969371640.51211843.1411066715223.JavaMail.zimbra@redhat.com>
	<CALCETrUGS_V2h_beStbVyoTC8vuKiudmJwt55Q2BJg=S2KCNKw@mail.gmail.com>
	<0180a8dfcad746a895755c4374853c16@BY2PR03MB585.namprd03.prod.outlook.com>
	<CALCETrUgcJt7p_aS0njtHmvPQ=XxNdonFHtPzFgVNpAE4U=R3Q@mail.gmail.com>
	<20140919163749.GI26540@minantech.com> <541C5C67.6040608@zytor.com>
	<20140919165349.GJ26540@minantech.com> <541C6304.3080903@zytor.com>
	<20140919171545.GK26540@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140919171545.GK26540@minantech.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@kernel.org>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, David Hepkin <davidhep@microsoft.com>, kvm list <kvm@vger.kernel.org>, Niels Ferguson <niels@microsoft.com>, Andy Lutomirski <luto@amacapital.net>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/19/2014 10:15 AM, Gleb Natapov wrote:
> On Fri, Sep 19, 2014 at 10:08:20AM -0700, H. Peter Anvin wrote:
>> On 09/19/2014 09:53 AM, Gleb Natapov wrote:
>>> On Fri, Sep 19, 2014 at 09:40:07AM -0700, H. Peter Anvin wrote:
>>>> On 09/19/2014 09:37 AM, Gleb Natapov wrote:
>>>>>
>>>>> Linux detects what hypervior it runs on very early
>>>>
>>>> Not anywhere close to early enough.  We're talking for uses like kASLR.
>>>>
>>> Still to early to do:
>>>
>>>    h = cpuid(HYPERVIOR_SIGNATURE)
>>>    if (h == KVMKVMKVM) {
>>>       if (cpuid(kvm_features) & kvm_rnd)
>>>          rdmsr(kvm_rnd)
>>>    else (h == HyperV) {
>>>       if (cpuid(hv_features) & hv_rnd)
>>>         rdmsr(hv_rnd) 
>>>    else (h == XenXenXen) {
>>>       if (cpuid(xen_features) & xen_rnd)
>>>         rdmsr(xen_rnd)
>>>   }
>>>
>>
>> If we need to do chase loops, especially not so...
>>
> What loops exactly? As a non native English speaker I fail to understand
> if your answer is "yes" or "no" ;)
> 

The above isn't actually the full algorithm used.

	-hpa
