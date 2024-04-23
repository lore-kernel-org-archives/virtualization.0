Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9A1F94C
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713851677; cv=none; b=VZ1DkrLwWQ8erTg+cERfDy7VTXiiw+O0NxJqZy1/9S+lM3imvRgFZ2cOTNJ49uMiyQD0QbzDZW94Cddk2RaiyKZrPgUOjXZbwFl4/DOK2Zd9+QJoL4qCY7VFUROg0SQaZ8v0sqN5ARPeC743dO1N8vI9g3FMqy4ibX8YvL+3tK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713851677; c=relaxed/simple;
	bh=oHJaPwu+1MrlP9savi4dmj4yo0rmVTG87IxUghRrskQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=J5yM1RjYgWlAs6SgWM1thkzT2Lh4wD/EvTA/WNsQYlMuERdVcjlB+HGqmQoHfxNk74Q3YJSurpJa48xUHVJ8fv4mGHSSuaKnJpkvsnw+dvqHcZtRYtxe2FcFrpGTOkJfMpyxU6IzbWp24fNLunwDIE34dBxJ4scVjEriYKnTHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QT+zOS0O; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QT+zOS0O"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713851672; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=Cic5HLQvD7g1K6EqFZ3bBVYuQ25WV9OCvTHntcPpXtM=;
	b=QT+zOS0OZJl2i6j29xOhWtMxEk7Gv8y+zjFZG7JikR55eh1MiGQQLhdxWLatwNt1zOgoClLlFAWjMJF6nL4TlK5YePI2zxaN0vFBr4YvWNAaWXIsKu7IXl6MGPL7R4M8zfXzXvzBWeAIck8DJH+8srf9mPfl47dlEj6bMcuoNFA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W57uP-X_1713851668;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W57uP-X_1713851668)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 13:54:30 +0800
Message-ID: <1713851629.1603248-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost] virtio_net: update the hdr_len calculation for xmit
Date: Tue, 23 Apr 2024 13:53:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux.dev,
 Spike Du <spiked@nvidia.com>
References: <20240320102025.11327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs-x-W2DHh8U=+0ORnq7=kjw9SJNNtDFfGNjC2KqqPZeA@mail.gmail.com>
 <1711074462.3244817-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtOjPYuPi7MQcnp+TroxLKa4YtpTdsP4bNUSxUV8rgq3A@mail.gmail.com>
 <1711086351.5199406-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv7XsRVLSgOu8=VPvLwQZf5rAXrUFD2v9mCvLiV4PRCSw@mail.gmail.com>
 <1711087705.9262164-4-xuanzhuo@linux.alibaba.com>
 <20240422163048-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240422163048-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 22 Apr 2024 16:31:03 -0400, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
> On Fri, Mar 22, 2024 at 02:08:25PM +0800, Xuan Zhuo wrote:
> > On Fri, 22 Mar 2024 13:57:36 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Mar 22, 2024 at 1:51=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Fri, 22 Mar 2024 13:04:48 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Fri, Mar 22, 2024 at 10:29=E2=80=AFAM Xuan Zhuo <xuanzhuo@linu=
x.alibaba.com> wrote:
> > > > > >
> > > > > > On Thu, 21 Mar 2024 12:17:54 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Wed, Mar 20, 2024 at 6:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > The virtio spec says:
> > > > > > > >     If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO =
options have
> > > > > > > >     been negotiated:
> > > > > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been n=
egotiated,
> > > > > > > >         and gso_type differs from VIRTIO_NET_HDR_GSO_NONE, =
the driver
> > > > > > > >         MUST set hdr_len to a value equal to the length of =
the headers,
> > > > > > > >         including the transport header.
> > > > > > > >
> > > > > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not be=
en negotiated,
> > > > > > > >         or gso_type is VIRTIO_NET_HDR_GSO_NONE, the driver =
SHOULD set
> > > > > > > >         hdr_len to a value not less than the length of the =
headers,
> > > > > > > >         including the transport header.
> > > > > > > >
> > > > > > > > So if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negoti=
ated, the
> > > > > > > > hdr->hdr_len should be eth header + ip header + tcp/udp hea=
der.
> > > > > > > >
> > > > > > > > But now:
> > > > > > > >     hdr->hdr_len =3D __cpu_to_virtio15(little_endian, skb_h=
eadlen(skb));
> > > > > > > >
> > > > > > > > The skb_headlen() returns the linear space of the skb, not =
the header
> > > > > > > > size that only match the case the VIRTIO_NET_F_GUEST_HDRLEN=
 feature has
> > > > > > > > not been negotiated, or gso_type is VIRTIO_NET_HDR_GSO_NONE.
> > > > > > > >
> > > > > > > > We do not check the feature of the device. This function is=
 a common
> > > > > > > > function used by many places. So we do more stricter work w=
hatever
> > > > > > > > the features is negotiated.
> > > > > > > >
> > > > > > > > For the case skb_is_gso(skb) is false, if none of the
> > > > > > > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have been =
negotiated,
> > > > > > > > the spec not define the action of setting hdr_len. Here I s=
et it to
> > > > > > > > skb_headlen(). If one of the above features have been negot=
iated, we
> > > > > > > > should set a value not less than the length of "eth header =
+ ip header +
> > > > > > > > tcp/udp header". So the skb_headlen() also is a valid value.
> > > > > > > >
> > > > > > > > For the case skb_is_gso(skb) is true, it implies that one of
> > > > > > > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options MUST have =
been
> > > > > > > > negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN is negotiated,=
 we MUST set
> > > > > > > > it to the length of "eth header + ip header + tcp/udp heade=
r".
> > > > > > > > If the VIRTIO_NET_F_GUEST_HDRLEN is not negotiated, that st=
ill be a
> > > > > > > > valid value.
> > > > > > > >
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > Reported-by: Spike Du <spiked@nvidia.com>
> > > > > > > > ---
> > > > > > > >  include/linux/virtio_net.h | 41 ++++++++++++++++++++++++++=
++----------
> > > > > > > >  1 file changed, 31 insertions(+), 10 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/include/linux/virtio_net.h b/include/linux/vir=
tio_net.h
> > > > > > > > index 4dfa9b69ca8d..51d93f9762d7 100644
> > > > > > > > --- a/include/linux/virtio_net.h
> > > > > > > > +++ b/include/linux/virtio_net.h
> > > > > > > > @@ -201,24 +201,45 @@ static inline int virtio_net_hdr_from=
_skb(const struct sk_buff *skb,
> > > > > > > >
> > > > > > > >         if (skb_is_gso(skb)) {
> > > > > > > >                 struct skb_shared_info *sinfo =3D skb_shinf=
o(skb);
> > > > > > > > +               u32 hdrlen;
> > > > > > > >
> > > > > > > > -               /* This is a hint as to how much should be =
linear. */
> > > > > > > > -               hdr->hdr_len =3D __cpu_to_virtio16(little_e=
ndian,
> > > > > > > > -                                                skb_headle=
n(skb));
> > > > > > > > -               hdr->gso_size =3D __cpu_to_virtio16(little_=
endian,
> > > > > > > > -                                                 sinfo->gs=
o_size);
> > > > > > > > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > > > > > > > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> > > > > > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GS=
O_TCPV4;
> > > > > > > > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > > > > > > > +                       hdrlen =3D tcp_hdrlen(skb) + skb_tr=
ansport_offset(skb);
> > > > > > >
> > > > > > > So could evil guests give us a 0 hdrlen through this. If yes,=
 it seems
> > > > > > > much more dangerous than headlen or we need harden the value =
as
> > > > > > > 9181d6f8a2bb32d158de66a84164fac05e3ddd18 did.
> > > > > >
> > > > > > Spec says:
> > > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negot=
iated, and
> > > > > >         gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the devi=
ce MAY use
> > > > > >         hdr_len as the transport header size. Note: Caution sho=
uld be taken by
> > > > > >         the implementation so as to prevent a malicious driver =
from attacking
> > > > > >         the device by setting an incorrect hdr_len.
> > > > > >
> > > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been n=
egotiated, or
> > > > > >         gso_type is VIRTIO_NET_HDR_GSO_NONE, the device MAY use=
 hdr_len only as
> > > > > >         a hint about the transport header size. The device MUST=
 NOT rely on
> > > > > >         hdr_len to be correct. Note: This is due to various bug=
s in
> > > > > >         implementations.
> > > > > >
> > > > > > The device nerver trust the hdr_len completely.
> > > > > > So I think that is safe.
> > > > >
> > > > > It doesn't, there's no way to audit all the existing implementati=
ons of virtio.
> > > > >
> > > > > For example, have you seen the commit I've pointed to you?
> > > >
> > > > I haven seen it.
> > > >
> > > > But here, this is driver, the device should handen the check.
> > >
> > > Unfortunately not. We can't audit all device implementations.
> > >
> > > > For the driver, we should do as the spec.
> > > > Do you mean that some evil driver pass 0 to device?
> > > > Now we fix that.
> > >
> > > hdrlen =3D tcp_hdrlen(skb) + skb_transport_offset(skb)
> > >
> > > Did you mean hdrlen can't be zero here? I guess it is done by the
> > > DODGY checking in the GSO path?
> >
> > Do you mean tcp_hdrlen(skb) + skb_transport_offset(skb) maybe zero?
> > I think so indeed. I will to check the logic of DODGY.
> >
> > Thanks.
>
> Was any conclusion reached?

No, I am currently more focused on other work.

Thanks.

>
> > >
> > > Then, let's explain it here.
> > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > +
> > > > > > > > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6)=
 {
> > > > > > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GS=
O_TCPV6;
> > > > > > > > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > > > > > > > +                       hdrlen =3D tcp_hdrlen(skb) + skb_tr=
ansport_offset(skb);
> > > > > > > > +
> > > > > > > > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4=
) {
> > > > > > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GS=
O_UDP_L4;
> > > > > > > > -               else
> > > > > > > > +                       hdrlen =3D sizeof(struct udphdr) + =
skb_transport_offset(skb);
> > > > > > > > +
> > > > > > > > +               } else {
> > > > > > > >                         return -EINVAL;
> > > > > > > > +               }
> > > > > > > > +
> > > > > > > > +               /* One of VIRTIO_NET_F_HOST_TSO4, TSO6, USO=
 or UFO options MUST
> > > > > > > > +                * have been negotiated. If the VIRTIO_NET_=
F_GUEST_HDRLEN is
> > > > > > > > +                * negotiated, we MUST set it to the length=
 of "eth header + ip
> > > > > > > > +                * header + tcp/udp header".  If the VIRTIO=
_NET_F_GUEST_HDRLEN
> > > > > > > > +                * is not negotiated, that still be a valid=
 value.
> > > > > > > > +                */
> > > > > > >
> > > > > > > I'd stick the headlen for deivce without GUEST_HDRLEN. It see=
ms much
> > > > > > > more safe as we don't want to break legacy devices.
> > > > > >
> > > > > > I do not get it.
> > > > >
> > > > > if (GUEST_HDRLEN)
> > > > >     tell the offset of the payload
> > > > > else
> > > > >     tell the headlen (stick to the old behaviour)
> > > >
> > > >
> > > > I am ok. Then we need to pass the features of the device to this fu=
nction.
> > >
> > > Yes, a boolean probably.
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
>
