From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] drm/virtio: use %llu format string form atomic64_t
Date: Mon, 19 Oct 2015 09:34:15 +0200
Message-ID: <CAMuHMdWbzEFqVctMXTWtdBn2B+guFdphQX5nXUnHPo1szQbtPg__36189.9292249747$1445240084$gmane$org@mail.gmail.com>
References: <5082760.FgB9zHNfte@wuerfel>
	<20151007104502.GH21513@n2100.arm.linux.org.uk>
	<6260324.3MlUEc3veg@wuerfel> <5152101.mD2bWzUJ2V@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5152101.mD2bWzUJ2V@wuerfel>
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
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Dave Airlie <airlied@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 7, 2015 at 1:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 07 October 2015 13:04:06 Arnd Bergmann wrote:
>> On Wednesday 07 October 2015 11:45:02 Russell King - ARM Linux wrote:
>> > On Wed, Oct 07, 2015 at 12:41:21PM +0200, Arnd Bergmann wrote:
>> > > The virtgpu driver prints the last_seq variable using the %ld or
>> > > %lu format string, which does not work correctly on all architectures
>> > > and causes this compiler warning on ARM:
>> > >
>> > > drivers/gpu/drm/virtio/virtgpu_fence.c: In function 'virtio_timeline_value_str':
>> > > drivers/gpu/drm/virtio/virtgpu_fence.c:64:22: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat=]
>> > >   snprintf(str, size, "%lu", atomic64_read(&fence->drv->last_seq));
>> > >                       ^
>> > > drivers/gpu/drm/virtio/virtgpu_debugfs.c: In function 'virtio_gpu_debugfs_irq_info':
>> > > drivers/gpu/drm/virtio/virtgpu_debugfs.c:37:16: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'long long int' [-Wformat=]
>> > >   seq_printf(m, "fence %ld %lld\n",
>> > >                 ^
>> > >
>> > > In order to avoid the warnings, this changes the format strings to %llu
>> > > and adds a cast to u64, which makes it work the same way everywhere.
>> >
>> > You have to wonder why atomic64_* functions do not use u64 types.
>> > If they're not reliant on manipulating 64-bit quantities, then what's
>> > the point of calling them atomic _64_.
>>
>> I haven't checked all architectures, but I assume what happens is that
>> 64-bit ones just #define atomic64_t atomic_long_t, so they don't have
>> to provide three sets of functions.
>
> scratch that, I just looked at all the architectures and found that it's
> just completely arbitrary, even within one architecture you get a mix
> of 'long' and 'long long', plus this gem from MIPS:
>
> static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
>
> which truncates the result to 32 bit.

Woops.

See also my unanswered question in "atomic64 on 32-bit vs 64-bit (was:
Re: Add virtio gpu driver.)", which is still valid:
https://lkml.org/lkml/2015/6/28/18

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
