Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37828C11
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711087881; cv=none; b=WOvGdq2+SgTTNzl+34mx3AvGStG6U1nc1b+yGriXtSHJg0VSCfK8MUC6cpm1ltWvxCLI9wxTG3jJBhiyHfVU6oWPFEEBz0fY7Ry1yOl94tLwdlh+LYqe8delOyMSqggIaf/RpKMZAeI4tMOu3O1jQ18I8ZPjR2rz4RQJSilOJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711087881; c=relaxed/simple;
	bh=qPyTRzUtI1B5csLrpfeTHFbEZuwuu1l2FEYIDk256EE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=pIYlGMYkZyy/ow5um1EbRxLoK8WqP1x5N6inznIZ1ojCFHTvebVJgABnOZfOHo2DbmpEubxodLVi3yoh99Y1JVIke93hpbUb/jvH9yhxGQczO1e6JpGKPu5prHsmNl5GmWIoYutVM8S2K8TE9wYjffCiF2mcU211X2P104Lwa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EglbVDjP; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EglbVDjP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711087871; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=4T1oRh4SMTuC0j/o6bQt1gQ/vLyBVyX5rQPBJwjEDe0=;
	b=EglbVDjPsGwF+5u+aOWEyQNWR5A7pCIjfPp1wwt5LHtVne9wibjsk/Jdjfd3yIbxO5vikKyOBaH7bzZQ0OagCbJSRpmzELrZUSglLL0A30MLGEg1VqFx/bFTV218yMQEVC6CAGdIaBSm95sv7zSeALJvJ2mVWCMuxvw0dL/C0ZU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W315sE7_1711087870;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W315sE7_1711087870)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 14:11:10 +0800
Message-ID: <1711087705.9262164-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost] virtio_net: update the hdr_len calculation for xmit
Date: Fri, 22 Mar 2024 14:08:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Spike Du <spiked@nvidia.com>
References: <20240320102025.11327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs-x-W2DHh8U=+0ORnq7=kjw9SJNNtDFfGNjC2KqqPZeA@mail.gmail.com>
 <1711074462.3244817-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtOjPYuPi7MQcnp+TroxLKa4YtpTdsP4bNUSxUV8rgq3A@mail.gmail.com>
 <1711086351.5199406-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv7XsRVLSgOu8=VPvLwQZf5rAXrUFD2v9mCvLiV4PRCSw@mail.gmail.com>
In-Reply-To: <CACGkMEv7XsRVLSgOu8=VPvLwQZf5rAXrUFD2v9mCvLiV4PRCSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 22 Mar 2024 13:57:36 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Mar 22, 2024 at 1:51=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Fri, 22 Mar 2024 13:04:48 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Mar 22, 2024 at 10:29=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > On Thu, 21 Mar 2024 12:17:54 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Wed, Mar 20, 2024 at 6:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > The virtio spec says:
> > > > > >     If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO opti=
ons have
> > > > > >     been negotiated:
> > > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negot=
iated,
> > > > > >         and gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the =
driver
> > > > > >         MUST set hdr_len to a value equal to the length of the =
headers,
> > > > > >         including the transport header.
> > > > > >
> > > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been n=
egotiated,
> > > > > >         or gso_type is VIRTIO_NET_HDR_GSO_NONE, the driver SHOU=
LD set
> > > > > >         hdr_len to a value not less than the length of the head=
ers,
> > > > > >         including the transport header.
> > > > > >
> > > > > > So if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated=
, the
> > > > > > hdr->hdr_len should be eth header + ip header + tcp/udp header.
> > > > > >
> > > > > > But now:
> > > > > >     hdr->hdr_len =3D __cpu_to_virtio15(little_endian, skb_headl=
en(skb));
> > > > > >
> > > > > > The skb_headlen() returns the linear space of the skb, not the =
header
> > > > > > size that only match the case the VIRTIO_NET_F_GUEST_HDRLEN fea=
ture has
> > > > > > not been negotiated, or gso_type is VIRTIO_NET_HDR_GSO_NONE.
> > > > > >
> > > > > > We do not check the feature of the device. This function is a c=
ommon
> > > > > > function used by many places. So we do more stricter work whate=
ver
> > > > > > the features is negotiated.
> > > > > >
> > > > > > For the case skb_is_gso(skb) is false, if none of the
> > > > > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have been nego=
tiated,
> > > > > > the spec not define the action of setting hdr_len. Here I set i=
t to
> > > > > > skb_headlen(). If one of the above features have been negotiate=
d, we
> > > > > > should set a value not less than the length of "eth header + ip=
 header +
> > > > > > tcp/udp header". So the skb_headlen() also is a valid value.
> > > > > >
> > > > > > For the case skb_is_gso(skb) is true, it implies that one of
> > > > > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options MUST have been
> > > > > > negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN is negotiated, we =
MUST set
> > > > > > it to the length of "eth header + ip header + tcp/udp header".
> > > > > > If the VIRTIO_NET_F_GUEST_HDRLEN is not negotiated, that still =
be a
> > > > > > valid value.
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > Reported-by: Spike Du <spiked@nvidia.com>
> > > > > > ---
> > > > > >  include/linux/virtio_net.h | 41 ++++++++++++++++++++++++++++--=
--------
> > > > > >  1 file changed, 31 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_=
net.h
> > > > > > index 4dfa9b69ca8d..51d93f9762d7 100644
> > > > > > --- a/include/linux/virtio_net.h
> > > > > > +++ b/include/linux/virtio_net.h
> > > > > > @@ -201,24 +201,45 @@ static inline int virtio_net_hdr_from_skb=
(const struct sk_buff *skb,
> > > > > >
> > > > > >         if (skb_is_gso(skb)) {
> > > > > >                 struct skb_shared_info *sinfo =3D skb_shinfo(sk=
b);
> > > > > > +               u32 hdrlen;
> > > > > >
> > > > > > -               /* This is a hint as to how much should be line=
ar. */
> > > > > > -               hdr->hdr_len =3D __cpu_to_virtio16(little_endia=
n,
> > > > > > -                                                skb_headlen(sk=
b));
> > > > > > -               hdr->gso_size =3D __cpu_to_virtio16(little_endi=
an,
> > > > > > -                                                 sinfo->gso_si=
ze);
> > > > > > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > > > > > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> > > > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TC=
PV4;
> > > > > > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > > > > > +                       hdrlen =3D tcp_hdrlen(skb) + skb_transp=
ort_offset(skb);
> > > > >
> > > > > So could evil guests give us a 0 hdrlen through this. If yes, it =
seems
> > > > > much more dangerous than headlen or we need harden the value as
> > > > > 9181d6f8a2bb32d158de66a84164fac05e3ddd18 did.
> > > >
> > > > Spec says:
> > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiate=
d, and
> > > >         gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the device M=
AY use
> > > >         hdr_len as the transport header size. Note: Caution should =
be taken by
> > > >         the implementation so as to prevent a malicious driver from=
 attacking
> > > >         the device by setting an incorrect hdr_len.
> > > >
> > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negot=
iated, or
> > > >         gso_type is VIRTIO_NET_HDR_GSO_NONE, the device MAY use hdr=
_len only as
> > > >         a hint about the transport header size. The device MUST NOT=
 rely on
> > > >         hdr_len to be correct. Note: This is due to various bugs in
> > > >         implementations.
> > > >
> > > > The device nerver trust the hdr_len completely.
> > > > So I think that is safe.
> > >
> > > It doesn't, there's no way to audit all the existing implementations =
of virtio.
> > >
> > > For example, have you seen the commit I've pointed to you?
> >
> > I haven seen it.
> >
> > But here, this is driver, the device should handen the check.
>
> Unfortunately not. We can't audit all device implementations.
>
> > For the driver, we should do as the spec.
> > Do you mean that some evil driver pass 0 to device?
> > Now we fix that.
>
> hdrlen =3D tcp_hdrlen(skb) + skb_transport_offset(skb)
>
> Did you mean hdrlen can't be zero here? I guess it is done by the
> DODGY checking in the GSO path?

Do you mean tcp_hdrlen(skb) + skb_transport_offset(skb) maybe zero?
I think so indeed. I will to check the logic of DODGY.

Thanks.

>
> Then, let's explain it here.
>
> >
> >
> > >
> > > >
> > > >
> > > > >
> > > > > > +
> > > > > > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> > > > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TC=
PV6;
> > > > > > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > > > > > +                       hdrlen =3D tcp_hdrlen(skb) + skb_transp=
ort_offset(skb);
> > > > > > +
> > > > > > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> > > > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UD=
P_L4;
> > > > > > -               else
> > > > > > +                       hdrlen =3D sizeof(struct udphdr) + skb_=
transport_offset(skb);
> > > > > > +
> > > > > > +               } else {
> > > > > >                         return -EINVAL;
> > > > > > +               }
> > > > > > +
> > > > > > +               /* One of VIRTIO_NET_F_HOST_TSO4, TSO6, USO or =
UFO options MUST
> > > > > > +                * have been negotiated. If the VIRTIO_NET_F_GU=
EST_HDRLEN is
> > > > > > +                * negotiated, we MUST set it to the length of =
"eth header + ip
> > > > > > +                * header + tcp/udp header".  If the VIRTIO_NET=
_F_GUEST_HDRLEN
> > > > > > +                * is not negotiated, that still be a valid val=
ue.
> > > > > > +                */
> > > > >
> > > > > I'd stick the headlen for deivce without GUEST_HDRLEN. It seems m=
uch
> > > > > more safe as we don't want to break legacy devices.
> > > >
> > > > I do not get it.
> > >
> > > if (GUEST_HDRLEN)
> > >     tell the offset of the payload
> > > else
> > >     tell the headlen (stick to the old behaviour)
> >
> >
> > I am ok. Then we need to pass the features of the device to this functi=
on.
>
> Yes, a boolean probably.
>
> Thanks
>
> >
> > Thanks
> >
> >
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > >
> > >
> >
>
