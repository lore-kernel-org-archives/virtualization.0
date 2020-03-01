From: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v2 1/3] virtio-net: Introduce extended RSC feature
Date: Sun, 1 Mar 2020 14:43:08 +0200
Message-ID: <CAOEp5OeNLa=0hJXOSrPvRbkm7XpE-uzq7vQB-GprXsoCgyk7kQ@mail.gmail.com>
References: <20200301110733.20197-1-yuri.benditovich@daynix.com>
 <20200301110733.20197-2-yuri.benditovich@daynix.com> <20200301061745-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200301061745-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Yan Vugenfirer <yan@daynix.com>
List-Id: virtualization@lists.linuxfoundation.org

No problem, I'll send an update

On Sun, Mar 1, 2020 at 1:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Mar 01, 2020 at 01:07:31PM +0200, Yuri Benditovich wrote:
> > VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> > is able to provide extended RSC information. When the feature
> > is negotiatede and 'gso_type' field in received packet is not
> > GSO_NONE, the device reports number of coalesced packets in
> > 'csum_start' field and number of duplicated acks in 'csum_offset'
> > field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  include/uapi/linux/virtio_net.h | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > index a3715a3224c1..536152fad3c4 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -57,6 +57,7 @@
> >                                        * Steering */
> >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> >
> > +#define VIRTIO_NET_F_RSC_EXT   61    /* extended coalescing info */
> >  #define VIRTIO_NET_F_STANDBY   62    /* Act as standby for another device
> >                                        * with the same MAC.
> >                                        */
> > @@ -104,6 +105,7 @@ struct virtio_net_config {
> >  struct virtio_net_hdr_v1 {
> >  #define VIRTIO_NET_HDR_F_NEEDS_CSUM  1       /* Use csum_start, csum_offset */
> >  #define VIRTIO_NET_HDR_F_DATA_VALID  2       /* Csum is valid */
> > +#define VIRTIO_NET_HDR_F_RSC_INFO    4       /* rsc info in csum_ fields */
> >       __u8 flags;
> >  #define VIRTIO_NET_HDR_GSO_NONE              0       /* Not a GSO frame */
> >  #define VIRTIO_NET_HDR_GSO_TCPV4     1       /* GSO frame, IPv4 TCP (TSO) */
> > @@ -113,8 +115,14 @@ struct virtio_net_hdr_v1 {
> >       __u8 gso_type;
> >       __virtio16 hdr_len;     /* Ethernet + IP + tcp/udp hdrs */
> >       __virtio16 gso_size;    /* Bytes to append to hdr_len per frame */
> > -     __virtio16 csum_start;  /* Position to start checksumming from */
> > -     __virtio16 csum_offset; /* Offset after that to place checksum */
> > +     union {
> > +             __virtio16 csum_start;  /* Position to start checksumming from */
> > +             __le16 rsc_ext_num_packets; /* num of coalesced packets */
> > +     };
> > +     union {
> > +             __virtio16 csum_offset; /* Offset after that to place checksum */
> > +             __le16 rsc_ext_num_dupacks; /* num of duplicated acks */
>
> dupacks -> dup_acks ?
>
> Also wouldn't it be cleaner to have an rsc struct? And "num" is kind of
> extraneous, right?
> So how about we group the fields:
>
> union {
>         /* Unnamed struct for compatiblity. */
>         struct {
>                 csum_start
>                 csum_offset
>         };
>         struct {
>                 virtio16 start;
>                 virtio16 offset;
>         } csum;
>         struct {
>                 le16 packets;
>                 le16 dup_acks;
>         } rsc;
> };
>
>
> what do you think?
>
>
> > +     };
> >       __virtio16 num_buffers; /* Number of merged rx buffers */
> >  };
>
>
>
> > --
> > 2.17.1
>
