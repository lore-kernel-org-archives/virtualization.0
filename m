From: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v2] virtio-net: Introduce extended RSC feature
Date: Mon, 13 Jan 2020 14:32:25 +0200
Message-ID: <CAOEp5OfgSwsa63kgAUJW9E2C7FiWt7AFdPupQCaMb4CLgi4YXg@mail.gmail.com>
References: <20200113081736.2340-1-yuri.benditovich@daynix.com> <bdc6cb05-30d1-b4fd-512e-740b2550c14e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bdc6cb05-30d1-b4fd-512e-740b2550c14e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Yan Vugenfirer <yan@daynix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 13, 2020 at 1:08 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/1/13 =E4=B8=8B=E5=8D=884:17, Yuri Benditovich wrote:
> > VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> > is able to provide extended RSC information. When the feature
> > is negotiatede and 'gso_type' field in received packet is not
> > GSO_NONE, the device reports number of coalesced packets in
> > 'csum_start' field and number of duplicated acks in 'csum_offset'
> > field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>
>
> Hi Yuri:
>
> Is the feature used by Linux? If yes, it's better to include the real use=
r.
>

It is not used by Linux. Mainly needed for certification under Windows.

>
> > ---
> >   include/uapi/linux/virtio_net.h | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virti=
o_net.h
> > index a3715a3224c1..2bdd26f8a4ed 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -56,7 +56,7 @@
> >   #define VIRTIO_NET_F_MQ     22      /* Device supports Receive Flow
> >                                        * Steering */
> >   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23       /* Set MAC address */
> > -
> > +#define VIRTIO_NET_F_RSC_EXT   61    /* Provides extended RSC info */
>
>
> Is this better to keep the newline around?

No problem, let's wait until the rest is accepted.

>
>
> >   #define VIRTIO_NET_F_STANDBY          62    /* Act as standby for ano=
ther device
> >                                        * with the same MAC.
> >                                        */
> > @@ -104,6 +104,7 @@ struct virtio_net_config {
> >   struct virtio_net_hdr_v1 {
> >   #define VIRTIO_NET_HDR_F_NEEDS_CSUM 1       /* Use csum_start, csum_o=
ffset */
> >   #define VIRTIO_NET_HDR_F_DATA_VALID 2       /* Csum is valid */
> > +#define VIRTIO_NET_HDR_F_RSC_INFO    4       /* rsc_ext data in csum_ =
fields */
> >       __u8 flags;
> >   #define VIRTIO_NET_HDR_GSO_NONE             0       /* Not a GSO fram=
e */
> >   #define VIRTIO_NET_HDR_GSO_TCPV4    1       /* GSO frame, IPv4 TCP (T=
SO) */
> > @@ -118,6 +119,13 @@ struct virtio_net_hdr_v1 {
> >       __virtio16 num_buffers; /* Number of merged rx buffers */
> >   };
> >
> > +/*
> > + * if VIRTIO_NET_F_RSC_EXT feature has been negotiated and
> > + * VIRTIO_NET_HDR_F_RSC_INFO is set in RX packet
> > + */
> > +#define virtio_net_rsc_ext_num_packets       csum_start
> > +#define virtio_net_rsc_ext_num_dupacks       csum_offset
>
>
> This looks sub-optimal, it looks to me union is better?

This was discussed in v1, MST decided the define is better.

>
> Thanks
>
>
> > +
> >   #ifndef VIRTIO_NET_NO_LEGACY
> >   /* This header comes first in the scatter-gather list.
> >    * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it mu=
st
>
