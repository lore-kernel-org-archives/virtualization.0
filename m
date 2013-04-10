From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] x86: make IDT read-only
Date: Wed, 10 Apr 2013 03:40:33 -0700
Message-ID: <87sj2yzn1a.fsf@xmission.com>
References: <20130408224328.GA17641@www.outflux.net>
	<51634935.9010905@zytor.com> <877gkc596d.fsf@xmission.com>
	<20130410095716.GF24443@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130410095716.GF24443@gmail.com> (Ingo Molnar's message of
	"Wed, 10 Apr 2013 11:57:16 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, kernel-hardening@lists.openwall.com, Frederic Weisbecker <fweisbec@gmail.com>, Dan Rosenberg <drosenberg@vsecurity.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, Alex Shi <alex.shi@intel.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Kees Cook <keescook@chromium.org>, Julien Tinnes <jln@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <borislav.petkov@amd.com>, Steven Rostedt <rostedt@goodmis.org>, xen-devel@lists.xensource.com, Thomas Gleixner <tglx@linutronix.de>, Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar <mingo@kernel.org> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>> 
>> > On 04/08/2013 03:43 PM, Kees Cook wrote:
>> >> This makes the IDT unconditionally read-only. This primarily removes
>> >> the IDT from being a target for arbitrary memory write attacks. It has
>> >> an added benefit of also not leaking (via the "sidt" instruction) the
>> >> kernel base offset, if it has been relocated.
>> >> 
>> >> Signed-off-by: Kees Cook <keescook@chromium.org>
>> >> Cc: Eric Northup <digitaleric@google.com>
>> >
>> > Also, tglx: does this interfere with your per-cpu IDT efforts?
>> 
>> Given that we don't change any IDT entries why would anyone want a
>> per-cpu IDT?  The cache lines should easily be shared accross all
>> processors.
>
> That's true iif they are cached.
>
> If not then it's a remote DRAM access cache miss for all CPUs except the node that 
> holds that memory.
>
>> Or are there some giant NUMA machines that trigger cache misses when accessing 
>> the IDT and the penalty for pulling the cache line across the NUMA fabric is 
>> prohibitive?
>
> IDT accesses for pure userspace execution are pretty rare. So we are not just 
> talking about huge NUMA machines here but about ordinary NUMA machines taking a 
> remote cache miss hit for the first IRQ or other IDT-accessing operation they do 
> after some cache-intense user-space processing.
>
> It's a small effect, but it exists and improving it would be
> legitimate.

If the effect is measurable I agree it is a legitimate optimization.  At
one point there was a suggestion to make the code in the IDT vectors
differ based on the which interrupt was registed.  While that can also
reduce cache misses that can get hairy very quickly, and of course that
would require read-write IDTs.

My only practical concern with duplicating the IDT tables per cpu is (a)
there are generic idt handlers that remain unduplicated reducing the
benefit and this is essentially the same optimization as making the
entire kernel text per cpu which last time it was examined was not an
optimization worth making.  So I wonder if just a subset of the
optimization is worth making.

Eric
