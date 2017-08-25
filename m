From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] virtio-net: invoke zerocopy callback on xmit
	path if no tx napi
Date: Fri, 25 Aug 2017 18:44:36 -0400
Message-ID: <CAF=yD-+1wheMmC+HFKe_B_ULO0Mmh6HMSEbYY5D-HgqxVJee6A__12970.9495734007$1503701153$gmane$org@mail.gmail.com>
References: <5352c98a-fa48-fcf9-c062-9986a317a1b0@redhat.com>
	<CAF=yD-LZ4=WAYfUtY7xRWi50FRSkrcOa+b7uc46xRnC4sbDCzQ@mail.gmail.com>
	<64d451ae-9944-e978-5a05-54bb1a62aaad@redhat.com>
	<20170822204015-mutt-send-email-mst@kernel.org>
	<1503498504.8694.26.camel@klaipeden.com>
	<CAF=yD-+U_aWxSmPPY8v8t=JO0MRZ+N+DzVJTAMKYQ5F=pE1PfA@mail.gmail.com>
	<20170824014553-mutt-send-email-mst@kernel.org>
	<CAF=yD-KSek+LmZu0X0TXetmFEQ59iF3NpjZ4KugbwLo1BGfhaA@mail.gmail.com>
	<20170824160748-mutt-send-email-mst@kernel.org>
	<CAF=yD-+9Ah8pC9i2w3Ad3WnhQit7Yo479pMrToty7priL6BFLw@mail.gmail.com>
	<20170824234551-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170824234551-mutt-send-email-mst@kernel.org>
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
Cc: Network Development <netdev@vger.kernel.org>, Koichiro Den <den@klaipeden.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>> >> > We don't enable network watchdog on virtio but we could and maybe
>> >> > should.
>> >>
>> >> Can you elaborate?
>> >
>> > The issue is that holding onto buffers for very long times makes guests
>> > think they are stuck. This is funamentally because from guest point of
>> > view this is a NIC, so it is supposed to transmit things out in
>> > a timely manner. If host backs the virtual NIC by something that is not
>> > a NIC, with traffic shaping etc introducing unbounded latencies,
>> > guest will be confused.
>>
>> That assumes that guests are fragile in this regard. A linux guest
>> does not make such assumptions.
>
> Yes it does. Examples above:
>         > > - a single slow flow can occupy the whole ring, you will not
>         > >   be able to make any new buffers available for the fast flow

Oh, right. Though those are due to vring_desc pool exhaustion
rather than an upper bound on latency of any single packet.

Limiting the number of zerocopy packets in flight to some fraction
of the ring ensures that fast flows can always grab a slot. Running
out of ubuf_info slots reverts to copy, so indirectly does this. But
I read it correclty the zerocopy pool may be equal to or larger than
the descriptor pool. Should we refine the zcopy_used test

    (nvq->upend_idx + 1) % UIO_MAXIOV != nvq->done_idx

to also return false if the number of outstanding ubuf_info is greater
than, say, vq->num >> 1?
