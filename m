From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Fri, 19 Sep 2014 11:20:49 -0700
Message-ID: <CALCETrX=HFB01rg_iCNNfEd8mEoj20hK2K-bU6FbgOkWF7fO-A@mail.gmail.com>
References: <0180a8dfcad746a895755c4374853c16@BY2PR03MB585.namprd03.prod.outlook.com>
	<CALCETrUgcJt7p_aS0njtHmvPQ=XxNdonFHtPzFgVNpAE4U=R3Q@mail.gmail.com>
	<20140919163749.GI26540@minantech.com> <541C5C67.6040608@zytor.com>
	<20140919165349.GJ26540@minantech.com> <541C6304.3080903@zytor.com>
	<20140919171545.GK26540@minantech.com> <541C656D.5040808@zytor.com>
	<20140919174942.GL26540@minantech.com>
	<CALCETrXGd0Qu4ES7T4Hx_ozsT5zUAvk0WtZ4DXq=CY7YS9vzbQ@mail.gmail.com>
	<20140919181248.GN26540@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140919181248.GN26540@minantech.com>
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
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, David Hepkin <davidhep@microsoft.com>, kvm list <kvm@vger.kernel.org>, Niels Ferguson <niels@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, Alok N Kataria <akataria@vmware.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

[cc: Alok Kataria at VMware]

On Fri, Sep 19, 2014 at 11:12 AM, Gleb Natapov <gleb@kernel.org> wrote:
> On Fri, Sep 19, 2014 at 11:02:38AM -0700, Andy Lutomirski wrote:
>> On Fri, Sep 19, 2014 at 10:49 AM, Gleb Natapov <gleb@kernel.org> wrote:
>> > On Fri, Sep 19, 2014 at 10:18:37AM -0700, H. Peter Anvin wrote:
>> >> On 09/19/2014 10:15 AM, Gleb Natapov wrote:
>> >> > On Fri, Sep 19, 2014 at 10:08:20AM -0700, H. Peter Anvin wrote:
>> >> >> On 09/19/2014 09:53 AM, Gleb Natapov wrote:
>> >> >>> On Fri, Sep 19, 2014 at 09:40:07AM -0700, H. Peter Anvin wrote:
>> >> >>>> On 09/19/2014 09:37 AM, Gleb Natapov wrote:
>> >> >>>>>
>> >> >>>>> Linux detects what hypervior it runs on very early
>> >> >>>>
>> >> >>>> Not anywhere close to early enough.  We're talking for uses like kASLR.
>> >> >>>>
>> >> >>> Still to early to do:
>> >> >>>
>> >> >>>    h = cpuid(HYPERVIOR_SIGNATURE)
>> >> >>>    if (h == KVMKVMKVM) {
>> >> >>>       if (cpuid(kvm_features) & kvm_rnd)
>> >> >>>          rdmsr(kvm_rnd)
>> >> >>>    else (h == HyperV) {
>> >> >>>       if (cpuid(hv_features) & hv_rnd)
>> >> >>>         rdmsr(hv_rnd)
>> >> >>>    else (h == XenXenXen) {
>> >> >>>       if (cpuid(xen_features) & xen_rnd)
>> >> >>>         rdmsr(xen_rnd)
>> >> >>>   }
>> >> >>>
>> >> >>
>> >> >> If we need to do chase loops, especially not so...
>> >> >>
>> >> > What loops exactly? As a non native English speaker I fail to understand
>> >> > if your answer is "yes" or "no" ;)
>> >> >
>> >>
>> >> The above isn't actually the full algorithm used.
>> >>
>> > What part of actually algorithm cannot be implemented? Loop that searches
>> > for KVM leaf in case KVM pretend to be HyperV (is this what you called
>> > "chase loops"?)? First of all there is no need to implement it, if KVM
>> > pretends to be HyperV use HyperV's way to obtain RNG, but what is the
>> > problem with the loop?
>> >
>>
>> It can be implemented, and I've done it.  But it's a mess.  Almost the
>> very first thing we do in boot (even before decompressing the kernel)
>> will be to scan a bunch of cpuid leaves looking for a hypervisor with
>> an rng source that we can use for kASLR.  And we'll have to update
>> that code and make it bigger every time another hypervisor adds
>> exactly the same feature.
> IMO implementing this feature is in hypervisor's best interest, so the task
> of updating the code will scale by virtue of hypervisor's developers each
> adding it for hypervisor he cares about.

I assume that you mean guest, not hypervisor.

>
>>
>> And then we have another copy of almost exactly the same code in the
>> normal post-boot part of the kernel.
>>
>> We can certainly do this, but I'd much rather solve the problem once
>> and let all of the hypervisors and guests opt in and immediately be
>> compatible with each other.
>>
>> > I "forgot" VMware because I do not see VMware people to be CCed. They may
>> > be even less excited about them being told _how_ this feature need to be
>> > implemented (e.g implement HyperV leafs for the feature detection). I
>> > do not want to and cannot speak for VMware, but my guess is that for
>> > them it would be much easier to add an else clause for VMware in above
>> > "if" then to coordinate with all hypervisor developers about MSR/cpuid
>> > details. And since this is security feature implementing it for Linux
>> > is in their best interest.
>>
>> Do you know any of them who should be cc'd?
>>
> No, not anyone in particular. git log arch/x86/kernel/cpu/vmware.c may help.
>
> But VMware is an elephant in the room here. There are other hypervisors out there.
> VirtualBox, bhyve...

Exactly.  The amount of effort to get everything to be compatible with
everything scales quadratically in the number of hypervisors, and the
probability that some combination is broken also increases.

If we can get everyone to back something common here then this problem
goes away.

--Andy

>
> --
>                         Gleb.



-- 
Andy Lutomirski
AMA Capital Management, LLC
