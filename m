From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC v5 net-next 4/6] virtio-net: add basic interrupt
	coalescing support
Date: Mon, 16 Feb 2015 13:49:25 +1030
Message-ID: <874mqma6gy.fsf__37935.8591781513$1424059865$gmane$org@rustcorp.com.au>
References: <1423471165-34243-1-git-send-email-jasowang@redhat.com>
	<1423471165-34243-5-git-send-email-jasowang@redhat.com>
	<87386ey2iy.fsf@rustcorp.com.au> <20150210104019.GD9505@redhat.com>
	<874mqqbk12.fsf@rustcorp.com.au>
	<20150213191918.0caf0d9a.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150213191918.0caf0d9a.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: pagupta@redhat.com, Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> On Fri, 13 Feb 2015 13:22:09 +1030
> Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> > On Tue, Feb 10, 2015 at 12:02:37PM +1030, Rusty Russell wrote:
>> >> Jason Wang <jasowang@redhat.com> writes:
>> >> > This patch enables the interrupt coalescing setting through ethtool.
>> >> 
>> >> The problem is that there's nothing network specific about interrupt
>> >> coalescing.  I can see other devices wanting exactly the same thing,
>> >> which means we'd deprecate this in the next virtio standard.
>> >> 
>> >> I think the right answer is to extend like we did with
>> >> vring_used_event(), eg:
>> >> 
>> >> 1) Add a new feature VIRTIO_F_RING_COALESCE.
>> >> 2) Add another a 32-bit field after vring_used_event(), eg:
>> >>         #define vring_used_delay(vr) (*(u32 *)((vr)->avail->ring[(vr)->num + 2]))
>> >> 
>> >> This loses the ability to coalesce by number of frames, but we can still
>> >> do number of sg entries, as we do now with used_event, and we could
>> >> change virtqueue_enable_cb_delayed() to take a precise number if we
>> >> wanted.
>> >
>> > But do we expect delay to be update dynamically?
>> > If not, why not stick it in config space?
>> 
>> Hmm, we could update it dynamically (and will, in the case of ethtool).
>> But it won't be common, so we could append a field to
>> virtio_pci_common_cfg for PCI.
>> 
>> I think MMIO and CCW would be easy to extend too, but CC'd to check.
>
> If this is a simple extension of the config space, it should just work
> for ccw (the Linux guest driver currently uses 0x100 as max config
> space size, which I grabbed from pci at the time I wrote it).
>
> But looking at this virtio_pci_common_cfg stuff, it seems to contain a
> lot of things that are handled via ccws on virtio-ccw (like number of
> queues or device status). Having an extra ccw just for changing this
> delay value seems like overkill.

Yes, possibly.

> On the basic topic of interrupt coalescing: With adapter interrupts,
> virtio-ccw already has some kind of coalescing: The summary indicator
> is set just once and an interrupt is made pending, then individual
> queue indicators are switched on and no further interrupt is generated
> if the summary indicator has not been cleared by the guest yet. I'm not
> sure how it would be different if an individual queue indicator is
> switched on later. Chances are that the guest code processing the
> indicators has not even yet processed to that individual indicator, so
> it wouldn't matter if it was set delayed. It is probably something that
> has to be tried out.

The network driver will do this at the virtio level too: no more rx
interrupts will be received until all packets have been processed.

But it is particularly useful for network transmit interrupts: we want
to be notified of the packet's finishing, but a little delay (hence more
batching) is better.  For rx, I can envision a case where the guest is
too fast and thus keeps getting interrupted after each packet.  A user
might decide to trade off some latency to increase batching; seems
like a bit like a benchmark hack to me, though...

Cheers,
Rusty.
