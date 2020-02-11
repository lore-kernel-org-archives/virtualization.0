From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: Work around frames incorrectly marked as gso
Date: Tue, 11 Feb 2020 05:37:50 -0500
Message-ID: <20200211053502-mutt-send-email-mst@kernel.org>
References: <20191209104824.17059-1-anton.ivanov@cambridgegreys.com>
 <57230228-7030-c65f-a24f-910ca52bbe9e@cambridgegreys.com>
 <f78bfe6e-2ffc-3734-9618-470f1afea0c6@redhat.com>
 <918222d9-816a-be70-f8af-b8dfcb586240@cambridgegreys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <918222d9-816a-be70-f8af-b8dfcb586240@cambridgegreys.com>
Sender: netdev-owner@vger.kernel.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org, linux-um@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 07:42:37AM +0000, Anton Ivanov wrote:
> On 11/02/2020 02:51, Jason Wang wrote:
> > 
> > On 2020/2/11 上午12:55, Anton Ivanov wrote:
> > > 
> > > 
> > > On 09/12/2019 10:48, anton.ivanov@cambridgegreys.com wrote:
> > > > From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > > > 
> > > > Some of the frames marked as GSO which arrive at
> > > > virtio_net_hdr_from_skb() have no GSO_TYPE, no
> > > > fragments (data_len = 0) and length significantly shorter
> > > > than the MTU (752 in my experiments).
> > > > 
> > > > This is observed on raw sockets reading off vEth interfaces
> > > > in all 4.x and 5.x kernels I tested.
> > > > 
> > > > These frames are reported as invalid while they are in fact
> > > > gso-less frames.
> > > > 
> > > > This patch marks the vnet header as no-GSO for them instead
> > > > of reporting it as invalid.
> > > > 
> > > > Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > > > ---
> > > >   include/linux/virtio_net.h | 8 ++++++--
> > > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > > index 0d1fe9297ac6..d90d5cff1b9a 100644
> > > > --- a/include/linux/virtio_net.h
> > > > +++ b/include/linux/virtio_net.h
> > > > @@ -112,8 +112,12 @@ static inline int
> > > > virtio_net_hdr_from_skb(const struct sk_buff *skb,
> > > >               hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> > > >           else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > > >               hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> > > > -        else
> > > > -            return -EINVAL;
> > > > +        else {
> > > > +            if (skb->data_len == 0)
> > > > +                hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
> > > > +            else
> > > > +                return -EINVAL;
> > > > +        }
> > > >           if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> > > >               hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
> > > >       } else
> > > > 
> > > 
> > > ping.
> > > 
> > 
> > Do you mean gso_size is set but gso_type is not? Looks like a bug
> > elsewhere.
> > 
> > Thanks
> > 
> > 
> Yes.
> 
> I could not trace it where it is coming from.
> 
> I see it when doing recvmmsg on raw sockets in the UML vector network
> drivers.
> 

I think we need to find the culprit and fix it there, lots of other things
can break otherwise.
Just printing out skb->dev->name should do the trick, no?


> -- 
> Anton R. Ivanov
> Cambridgegreys Limited. Registered in England. Company Number 10273661
> https://www.cambridgegreys.com/
