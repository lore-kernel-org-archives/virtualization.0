From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86: make IDT read-only
Date: Mon, 8 Apr 2013 15:55:10 -0700
Message-ID: <CAGXu5j+zz1PyqRM4_Mz_UokD3Y6i6Vj7v_G8W-Ggd1XO_i0MsA@mail.gmail.com>
References: <20130408224328.GA17641@www.outflux.net>
	<516348F6.1080902@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <516348F6.1080902@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Alex Shi <alex.shi@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, Dan Rosenberg <drosenberg@vsecurity.com>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <borislav.petkov@amd.com>, Ingo Molnar <mingo@redhat.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 8, 2013 at 3:47 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 04/08/2013 03:43 PM, Kees Cook wrote:
>> This makes the IDT unconditionally read-only. This primarily removes
>> the IDT from being a target for arbitrary memory write attacks. It has
>> an added benefit of also not leaking (via the "sidt" instruction) the
>> kernel base offset, if it has been relocated.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: Eric Northup <digitaleric@google.com>
>
> This isn't quite what this patch does, though, right?  There is still a
> writable IDT mapping at all times, which is different from a true
> readonly IDT, no?

Ah, I guess that's true. I suppose I should say it makes the memory
seen at the "sidt" location read-only. Can we make them both
read-only?

-Kees

--
Kees Cook
Chrome OS Security
