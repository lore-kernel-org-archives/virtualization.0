From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3] virtio: Work around frames incorrectly marked as gso
Date: Mon, 24 Feb 2020 15:20:53 -0500
Message-ID: <CA+FuTSdOCJZCVS4xohx+BQmkmq8JALnK=gGc0=qy1TbjY707ag@mail.gmail.com>
References: <20200224132550.2083-1-anton.ivanov@cambridgegreys.com>
 <CA+FuTSd8P6uQnwisZEh7+nfowW9qKLBEvA4GPg+xUkjBa-6TDA@mail.gmail.com> <4e7757cf-148e-4585-b358-3b38f391275d@cambridgegreys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <4e7757cf-148e-4585-b358-3b38f391275d@cambridgegreys.com>
Sender: netdev-owner@vger.kernel.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Network Development <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-um@lists.infradead.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Dumazet <eric.dumazet@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 24, 2020 at 2:55 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> On 24/02/2020 19:27, Willem de Bruijn wrote:
> > On Mon, Feb 24, 2020 at 8:26 AM <anton.ivanov@cambridgegreys.com> wrote:
> >>
> >> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> >>
> >> Some of the locally generated frames marked as GSO which
> >> arrive at virtio_net_hdr_from_skb() have no GSO_TYPE, no
> >> fragments (data_len = 0) and length significantly shorter
> >> than the MTU (752 in my experiments).
> >
> > Do we understand how these packets are generated?
>
> No, we have not been able to trace them.
>
> The only thing we know is that this is specific to locally generated
> packets. Something arriving from the network does not show this.
>
> > Else it seems this
> > might be papering over a deeper problem.
> >
> > The stack should not create GSO packets less than or equal to
> > skb_shinfo(skb)->gso_size. See for instance the check in
> > tcp_gso_segment after pulling the tcp header:
> >
> >          mss = skb_shinfo(skb)->gso_size;
> >          if (unlikely(skb->len <= mss))
> >                  goto out;
> >
> > What is the gso_type, and does it include SKB_GSO_DODGY?
> >
>
>
> 0 - not set.

Thanks for the follow-up details. Is this something that you can trigger easily?

An skb_dump() + dump_stack() when the packet socket gets such a
packet may point us to the root cause and fix that.
