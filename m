From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [Xen-devel] [RFC] Hypervisor RNG and enumeration
Date: Thu, 30 Oct 2014 07:45:35 -0700
Message-ID: <CALCETrUp2A27tPb=+9LM4KUmpsRHyKqJM-UB1GApvyQqNu36-Q@mail.gmail.com>
References: <CALCETrUuSApjNk+xdB1XEPH+Lz2PGY0gnreHwx5Z6xQ0Vj74tw@mail.gmail.com>
	<54522D40.8040405@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54522D40.8040405@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, Jim Mattson <jmattson@vmware.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, David Hepkin <davidhep@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Doug Covelli <dcovelli@vmware.com>, Paolo Bonzini <pbonzini@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Alok Kataria <akataria@vmware.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 30, 2014 at 5:21 AM, David Vrabel <david.vrabel@citrix.com> wrote:
> On 29/10/14 05:19, Andy Lutomirski wrote:
>> CPUID leaf 4F000002H: miscellaneous features
>> --------------------------------------------
>>
> [...]
>> ### CommonHV RNG
>>
>> If CPUID.4F000002H.EAX is nonzero, then it contains an MSR index used to
>> communicate with a hypervisor random number generator.  This MSR is
>> referred to as MSR_COMMONHV_RNG.
>>
>> rdmsr(MSR_COMMONHV_RNG) returns a 64-bit best-effort random number.  If the
>> hypervisor is able to generate a 64-bit cryptographically secure random number,
>> it SHOULD return it.  If not, then the hypervisor SHOULD do its best to return
>> a random number suitable for seeding a cryptographic RNG.
>>
>> A guest is expected to read MSR_COMMONHV_RNG several times in a row.
>> The hypervisor SHOULD return different values each time.
>>
>> rdmsr(MSR_COMMONHV_RNG) MUST NOT result in an exception, but guests MUST
>> NOT assume that its return value is indeed secure.  For example, a hypervisor
>> is free to return zero in response to rdmsr(MSR_COMMONHV_RNG).
>
> I would add:
>
>   If the hypervisor's pool of random data is exhausted, it MAY
>   return 0.  The hypervisor MUST provide at least 4 (?) non-zero
>   numbers to each guest.
>
> Xen does not have a continual source of entropy and the only feasible
> way is for the toolstack to provide each guest with a fixed size pool of
> random data during guest creation.
>

Xen could seed a very simple per-guest DRBG at guest startup and then
let the rdmsr call read from it.

> The fixed size pool could be refilled by the guest if further random
> data is needed (e.g., before an in-guest kexec).

That gets complicated.  Then you need an API to refill it.

>
>> wrmsr(MSR_COMMONHV_RNG) offers the hypervisor up to 64 bits of entropy.
>> The hypervisor MAY use it as it sees fit to improve its own random number
>> generator.  A hypervisor SHOULD make a reasonable effort to avoid making
>> values written to MSR_COMMONHV_RNG visible to untrusted parties, but
>> guests SHOULD NOT write sensitive values to wrmsr(MSR_COMMONHV_RNG).
>
> I don't think unprivileged guests should be able to influence the
> hypervisor's RNG. Unless the intention here is it only affects the
> numbers returned to this guest?
>

An RNG can be designed to be secure even if malicious users can
provide input.  Linux has one of these, and I assume that Windows
does, too.  Xen doesn't for the entirely legitimate reason that Xen
has no need for such a thing.  (Xen dom0, on the other hand, has
Linux's.)

> But since the write is optional, I don't object to it.

Draft 2 has a bit that Xen could clear to ask the guest not to even
try to use this feature.

I'll send out draft 2 by email later today.  It's on github now, though.

--Andy
