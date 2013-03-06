From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 08/16] virtio_ring: virtqueue_add_outbuf /
	virtqueue_add_inbuf.
Date: Wed, 06 Mar 2013 17:03:42 +1100
Message-ID: <87y5e19i9t.fsf@rustcorp.com.au>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
	<1361260594-601-9-git-send-email-rusty@rustcorp.com.au>
	<20130221170902.GA27097@redhat.com>
	<87sj4pfc61.fsf@rustcorp.com.au>
	<20130225213504.GC18167@redhat.com>
	<87lia9c9er.fsf@rustcorp.com.au> <20130228070124.GD4743@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130228070124.GD4743@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
>> Without the inline keywords, it doesn't inline virtqueue_add, and thus
>> sg_next_chained and sg_next_add aren't inlined:
>> 
>> $ for i in `seq 50`; do /usr/bin/time --format=%U ./vringh_test --indirect --eventidx --parallel; done 2>&1 | stats --trim-outliers
>> Using CPUS 0 and 3
>> Guest: notified 39102-39145(39105), pinged 39060-39063(39063)
>> Host: notified 39060-39063(39063), pinged 19551-19581(19553)
>> 3.050000-3.220000(3.136875)
>> 
>> With inline:
>> 
>> $ for i in `seq 50`; do /usr/bin/time --format=%U ./vringh_test --indirect --eventidx --parallel; done 2>&1 | stats --trim-outliers
>> Using CPUS 0 and 3
>> Guest: notified 39084-39148(39099), pinged 39062-39063(39062)
>> Host: notified 39062-39063(39062), pinged 19542-19574(19550)
>> 2.940000-3.140000(3.014583)
>> 
>> Cheers,
>> Rusty.
>
> Cool and did it actually unroll all loops?

Sorry for the delay in answering... I spent a day chasing red-herrings,
as my tests became limited by the vringh side, so optimizations on the
virtio side were having no effect :(

I'll answer a related question based on the current tree, where
virtio_add_outbuf (and virtio_add_inbuf) are the stars:

	return virtqueue_add(vq, &sg, sg_next_arr, num, 0, 1, 0, data, gfp);

Ideally, gcc would eliminated the input-descriptor loop altogether (that
0 for in_sgs), and unroll the 1-iteration output-descriptor loop into
straightline code.

Which it seems to have done, by my reading of the asm (at least, for gcc
4.7 on 32-bit x86).

Cheers,
Rusty.
