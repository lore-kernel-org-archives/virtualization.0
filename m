From: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Fri, 19 Sep 2014 23:21:15 +0300
Message-ID: <15C8041A-3488-4693-B329-3A9FE77A0CB9__29646.7778309763$1411159199$gmane$org@gmail.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<541C765B.5050705@codeaurora.org>
	<CALCETrU_r90=ve4v6xKfZHR_2O5+f05URqD5fzkbSpcuV4tb8A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrU_r90=ve4v6xKfZHR_2O5+f05URqD5fzkbSpcuV4tb8A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Theodore Ts'o <tytso@mit.edu>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On Sep 19, 2014, at 9:42 PM, Andy Lutomirski <luto@amacapital.net> wrote:

> On Fri, Sep 19, 2014 at 11:30 AM, Christopher Covington
> <cov@codeaurora.org> wrote:
>> On 09/17/2014 10:50 PM, Andy Lutomirski wrote:
>>> Hi all-
>>> =

>>> I would like to standardize on a very simple protocol by which a guest
>>> OS can obtain an RNG seed early in boot.
>>> =

>>> The main design requirements are:
>>> =

>>> - The interface should be very easy to use.  Linux, at least, will
>>> want to use it extremely early in boot as part of kernel ASLR.  This
>>> means that PCI and ACPI will not work.
>> =

>> How do non-virtual systems get entropy this early? RDRAND/Padlock? Truer=
and?
>> Could hypervisors and simulators simply make sure these work?
>> =

> =

> If RDRAND is available, then Linux, at least, will use it.  The rest
> are too complicated for early use.  Linux on x86 plays some vaguely
> clever games with rdtsc and poking at the i8254 port.
> =

> I think that these tricks are even less useful as a guest than they
> are on metal, and we can use paravirt mechanisms to make guest early
> boot rngs much stronger.

Sorry for interrupting, as I understand the discussion tries to be generic.

However, it sounds to me that at least for KVM, it is very easy just to emu=
late the RDRAND instruction. The hypervisor would report to the guest that =
RDRAND is supported in CPUID and the emulate the instruction when guest exe=
cutes it. KVM already traps guest #UD (which would occur if RDRAND executed=
 while it is not supported) - so this scheme wouldn=92t introduce additiona=
l overhead over RDMSR.

Nadav
