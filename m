From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] tools/virtio: make barriers stronger.
Date: Fri, 08 Mar 2013 10:56:05 +1100
Message-ID: <87y5dywyqy.fsf@rustcorp.com.au>
References: <1362491468-16681-1-git-send-email-sjur.brandeland@stericsson.com>
	<871ubtcezb.fsf@rustcorp.com.au> <87y5e1b03l.fsf@rustcorp.com.au>
	<87vc95b019.fsf@rustcorp.com.au>
	<20130306102017.GB16921@redhat.com>
	<87a9qfyinr.fsf@rustcorp.com.au> <20130307092908.GA4129@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130307092908.GA4129@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Thu, Mar 07, 2013 at 02:48:24PM +1100, Rusty Russell wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> > On Wed, Mar 06, 2013 at 03:54:42PM +1100, Rusty Russell wrote:
>> >> In the coming vringh_test, we share an mmap with another userspace process
>> >> for testing.  This requires real barriers.
>> >> 
>> >> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>> >> 
>> >> diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
>> >> index aff61e1..7a63693 100644
>> >> --- a/tools/virtio/asm/barrier.h
>> >> +++ b/tools/virtio/asm/barrier.h
>> >> @@ -3,8 +3,8 @@
>> >>  #define mb() __sync_synchronize()
>> >>  
>> >>  #define smp_mb()	mb()
>> >> -# define smp_rmb()	barrier()
>> >> -# define smp_wmb()	barrier()
>> >> +# define smp_rmb()	mb()
>> >> +# define smp_wmb()	mb()
>> >>  /* Weak barriers should be used. If not - it's a bug */
>> >>  # define rmb()	abort()
>> >>  # define wmb()	abort()
>> >
>> > Hmm this seems wrong on x86 which has strong order in hardware.
>> > It should not matter whether the other side is a userspace
>> > process or a kernel thread.
>> 
>> Actually, this code is completely generic now, though overkill for x86 smp_wmb():
>> 
>> Interestingly, when I try defining them, 32-bit x86 slows down (it seems
>> that gcc is using "lock orl $0x0,(%esp)" for __sync_synchronize()).:
>
> Well this depends on which arch you are building for.
> We saw this in qemu too, see e.g. include/qemu/atomic.h in qemu.

Hmm, I thought x86 had load reordering, but it seems that was only some
older chips, which we can consider obsolete.

I learned something... I've dropped the patch.

Thanks,
Rusty.
