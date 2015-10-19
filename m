From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] drm/virtio: use %llu format string form atomic64_t
Date: Mon, 19 Oct 2015 12:39:09 +0200
Message-ID: <CAMuHMdUcAhocNosTB+YnQ0LiPui58ph13mrDYcE15vDjRAmscQ__19792.6827510402$1445251169$gmane$org@mail.gmail.com>
References: <5082760.FgB9zHNfte@wuerfel> <5152101.mD2bWzUJ2V@wuerfel>
	<CAMuHMdWbzEFqVctMXTWtdBn2B+guFdphQX5nXUnHPo1szQbtPg@mail.gmail.com>
	<4345582.jiHe94XBb3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4345582.jiHe94XBb3@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Ralf Baechle <ralf@linux-mips.org>, Dave Airlie <airlied@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 19, 2015 at 12:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 19 October 2015 09:34:15 Geert Uytterhoeven wrote:
>> On Wed, Oct 7, 2015 at 1:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
>> >
>> > which truncates the result to 32 bit.
>>
>> Woops.
>>
>> See also my unanswered question in "atomic64 on 32-bit vs 64-bit (was:
>> Re: Add virtio gpu driver.)", which is still valid:
>> https://lkml.org/lkml/2015/6/28/18
>>
>
> Regarding your question of
>
>> Instead of sprinkling casts, is there any good reason why atomic64_read()
>> and atomic64_t aren't "long long" everywhere, cfr. u64?
>
>
> I assume the answer is that some (all?) 64-bit architectures intentionally
> return 'long' here, in order for atomic_long_read() to return 'long' on
> all architectures, given the definitions from
> include/asm-generic/atomic-long.h
>
> We would have to either change those, or we have to pick between
> atomic_long_* or atomic64_* to have a consistent return type.

I guess the main reason is this comment in include/asm-generic/atomic-long.h,
which I hadn't noticed before:

 * Casts for parameters are avoided for existing atomic functions in order to
 * avoid issues with cast-as-lval under gcc 4.x and other limitations that the
 * macros of a platform may have.

Still, it's a pity, as printing atomic_64 is one more place where casts are
needed in callers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
