From: Eric Northup <digitaleric@google.com>
Subject: Re: [kernel-hardening] Re: [PATCH] x86: make IDT read-only
Date: Tue, 9 Apr 2013 11:54:15 -0700
Message-ID: <CAG7+5M3==rndLLak9cZBKKdgQMmJMpSP_jpQd8HOVGp6LhUAgw@mail.gmail.com>
References: <20130408224328.GA17641@www.outflux.net>
	<51634935.9010905@zytor.com>
	<alpine.LFD.2.02.1304091122490.21884@ionos>
	<CAGXu5jKo=11RrsvctcZjP6dusAj659O_GsaA2J2qFq-6mOeRwQ@mail.gmail.com>
	<51645D6F.7070705@zytor.com>
	<CAGXu5jKkHKw8efdPOmt-Zi99m+uMKVGKpc_DC72_ztwxnRbRRQ@mail.gmail.com>
	<51646054.3090509@zytor.com>
	<CAGXu5jJNG4o+_-kk=A2AfSRwyQE0pgaQh7YpSjnD_fB-s7U+wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGXu5jJNG4o+_-kk=A2AfSRwyQE0pgaQh7YpSjnD_fB-s7U+wA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Alex Shi <alex.shi@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Frederic Weisbecker <fweisbec@gmail.com>, Dan Rosenberg <drosenberg@vsecurity.com>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <borislav.petkov@amd.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 9, 2013 at 11:46 AM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Apr 9, 2013 at 11:39 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On 04/09/2013 11:31 AM, Kees Cook wrote:
>>>>> ...
>>>>> 0xffff880001e00000-0xffff88001fe00000         480M     RW         PSE GLB NX pmd
>>>>>
>>>>
>>>> That is the 1:1 memory map area...
>>>
>>> Meaning what?
>>>
>>> -Kees
>>>
>>
>> That's the area in which we just map 1:1 to memory.  Anything allocated
>> with e.g. kmalloc() ends up with those addresses.
>
> Ah-ha! Yes, I see now when comparing the debug/kernel_page_tables
> reports. It's just the High Kernel Mapping that we care about.
> Addresses outside that range are less of a leak. Excellent, then GDT
> may not be a problem. Whew.

The GDT is a problem if the address returned by 'sgdt' is
kernel-writable - it doesn't necessarily reveal the random offset, but
I'm pretty sure that writing to the GDT could cause privilege
escalation.

>
> Does the v2 IDT patch look okay, BTW?
>
> -Kees
>
> --
> Kees Cook
> Chrome OS Security
