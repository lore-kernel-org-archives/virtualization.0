From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Xen-devel] [RFC] Hypervisor RNG and enumeration
Date: Wed, 29 Oct 2014 09:07:52 -0700
Message-ID: <545110D8.2030209@zytor.com>
References: <CALCETrUuSApjNk+xdB1XEPH+Lz2PGY0gnreHwx5Z6xQ0Vj74tw@mail.gmail.com>
	<5450C35D.1030907@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5450C35D.1030907@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Cooper <andrew.cooper3@citrix.com>, Andy Lutomirski <luto@amacapital.net>, Linux Virtualization <virtualization@lists.linux-foundation.org>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, Jim Mattson <jmattson@vmware.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, David Hepkin <davidhep@microsoft.com>, Doug Covelli <dcovelli@vmware.com>, Paolo Bonzini <pbonzini@redhat.com>, Jake Oshins <jakeo@microsoft.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/29/2014 03:37 AM, Andrew Cooper wrote:
>>
>> CPUID with EAX = 0x4F000001 and ECX >= N MUST return all zeros.
>>
>> To the extent that the hypervisor prefers a given interface, it should
>> specify that interface earlier in the list.  For example, KVM might place
>> its "KVMKVMKVM" signature first in the list to indicate that it should be
>> used by guests in preference to other supported interfaces.  Other hypervisors
>> would likely use a different order.
>>
>> The exact semantics of the ordering of the list is beyond the scope of
>> this specification.
> 
> How do you evaluate N?
> 
> It would make more sense for CPUID.4F000001[ECX=0] to return N in one
> register, and perhaps "prefered interface index" in another.  The
> signatures can then be obtained from CPUID.4F000001[ECX={1 to N}].
> 
> That way, a consumer can be confident that they have found all the
> signatures, without relying on an unbounded loop and checking for zeroes

Yes.  Specifically, it should return it in EAX.  That is the preferred
interface and we are trying to push for that going forward.

	-hpa
