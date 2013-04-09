From: Kees Cook <keescook@chromium.org>
Subject: Re: [kernel-hardening] Re: [PATCH] x86: make IDT read-only
Date: Tue, 9 Apr 2013 11:22:27 -0700
Message-ID: <CAGXu5jKo=11RrsvctcZjP6dusAj659O_GsaA2J2qFq-6mOeRwQ@mail.gmail.com>
References: <20130408224328.GA17641@www.outflux.net>
	<51634935.9010905@zytor.com>
	<alpine.LFD.2.02.1304091122490.21884@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1304091122490.21884@ionos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Alex Shi <alex.shi@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, Dan Rosenberg <drosenberg@vsecurity.com>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <borislav.petkov@amd.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 9, 2013 at 2:23 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 8 Apr 2013, H. Peter Anvin wrote:
>
>> On 04/08/2013 03:43 PM, Kees Cook wrote:
>> > This makes the IDT unconditionally read-only. This primarily removes
>> > the IDT from being a target for arbitrary memory write attacks. It has
>> > an added benefit of also not leaking (via the "sidt" instruction) the
>> > kernel base offset, if it has been relocated.
>> >
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > Cc: Eric Northup <digitaleric@google.com>
>>
>> Also, tglx: does this interfere with your per-cpu IDT efforts?
>
> I don't think so. And it's on the backburner at the moment.

What would be a good way to do something similar for the GDT? sgdt
leaks GDT location as well, and even though it's percpu, it should be
trivial to figure out a kernel base address, IIUC.

$ ./sgdt
ffff88001fc04000
# cat /sys/kernel/debug/kernel_page_tables
...
---[ Low Kernel Mapping ]---
...
0xffff880001e00000-0xffff88001fe00000         480M     RW         PSE GLB NX pmd

With the IDT patch, things look good for sidt:

$ ./sidt
ffffffffff579000
# cat /sys/kernel/debug/kernel_page_tables
...
---[ End Modules ]---
0xffffffffff579000-0xffffffffff57a000           4K     ro             GLB NX pte

Can we create a RO fixed per-cpu area?

-Kees

--
Kees Cook
Chrome OS Security
