Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269D8F68
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086652; cv=none; b=p2oxdakyqs4Q3KpjR1mjgl4QDsDUPJLN1RFKZD4d2GIVmQHdDf4aX1itie1Y/9zaRYO4ta/3qBBpuMJQyekALENiumOfAHjWRrpKh6vbatGs2rnIIUuM0BBvLTNzXNgthu1HNepspEuDP8hGE+RnzOfl7NhNpF/NR1DrafBN+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086652; c=relaxed/simple;
	bh=ZPcAbPZbgwha3coRt5UvTIPeTih8m59AEHpI3qDQcX4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=kp+XbxXuHay+CJVmaKEvGFiQ1St2EfjwMWD9EVymokWEvgm53Stsz+GN3Kur2QhPMUH1K87vLDUDEU6EEMHvMWcbWqjaWdEnqNGS4xmCzRKErn19A2/DkxFvLRgu5/fovbKaWZU3kLoruJIEF/AwIiw9IsXnpR+VBsKM0nWwWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Du0pZncl; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Du0pZncl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711086646; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=UwCdL2MNslMJGZsEr33rlN5G4C05VGgW0tNuKfRIZbs=;
	b=Du0pZnclSMN+x8Mm8hjNI9MAiGRrMoqlyP0vaQbybjV76CpYg3Ob/29sPnj3HlRjZQ316bmRvLCATunBhT7D+StPM7FUzZchxHPxT0AhMRaAVMBVzM+vmsSnEVblZfF4BbRdVZ4J/93pdeaIFn4QnpADDdPeFfWVk+FSyj5m+As=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W315.kX_1711086644;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W315.kX_1711086644)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 13:50:44 +0800
Message-ID: <1711086351.5199406-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost] virtio_net: update the hdr_len calculation for xmit
Date: Fri, 22 Mar 2024 13:45:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Spike Du <spiked@nvidia.com>
References: <20240320102025.11327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs-x-W2DHh8U=+0ORnq7=kjw9SJNNtDFfGNjC2KqqPZeA@mail.gmail.com>
 <1711074462.3244817-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtOjPYuPi7MQcnp+TroxLKa4YtpTdsP4bNUSxUV8rgq3A@mail.gmail.com>
In-Reply-To: <CACGkMEtOjPYuPi7MQcnp+TroxLKa4YtpTdsP4bNUSxUV8rgq3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 22 Mar 2024 13:04:48 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Mar 22, 2024 at 10:29=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Thu, 21 Mar 2024 12:17:54 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Wed, Mar 20, 2024 at 6:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > The virtio spec says:
> > > >     If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options =
have
> > > >     been negotiated:
> > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiate=
d,
> > > >         and gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the driv=
er
> > > >         MUST set hdr_len to a value equal to the length of the head=
ers,
> > > >         including the transport header.
> > > >
> > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negot=
iated,
> > > >         or gso_type is VIRTIO_NET_HDR_GSO_NONE, the driver SHOULD s=
et
> > > >         hdr_len to a value not less than the length of the headers,
> > > >         including the transport header.
> > > >
> > > > So if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated, the
> > > > hdr->hdr_len should be eth header + ip header + tcp/udp header.
> > > >
> > > > But now:
> > > >     hdr->hdr_len =3D __cpu_to_virtio15(little_endian, skb_headlen(s=
kb));
> > > >
> > > > The skb_headlen() returns the linear space of the skb, not the head=
er
> > > > size that only match the case the VIRTIO_NET_F_GUEST_HDRLEN feature=
 has
> > > > not been negotiated, or gso_type is VIRTIO_NET_HDR_GSO_NONE.
> > > >
> > > > We do not check the feature of the device. This function is a common
> > > > function used by many places. So we do more stricter work whatever
> > > > the features is negotiated.
> > > >
> > > > For the case skb_is_gso(skb) is false, if none of the
> > > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have been negotiat=
ed,
> > > > the spec not define the action of setting hdr_len. Here I set it to
> > > > skb_headlen(). If one of the above features have been negotiated, we
> > > > should set a value not less than the length of "eth header + ip hea=
der +
> > > > tcp/udp header". So the skb_headlen() also is a valid value.
> > > >
> > > > For the case skb_is_gso(skb) is true, it implies that one of
> > > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options MUST have been
> > > > negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN is negotiated, we MUST=
 set
> > > > it to the length of "eth header + ip header + tcp/udp header".
> > > > If the VIRTIO_NET_F_GUEST_HDRLEN is not negotiated, that still be a
> > > > valid value.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Reported-by: Spike Du <spiked@nvidia.com>
> > > > ---
> > > >  include/linux/virtio_net.h | 41 ++++++++++++++++++++++++++++------=
----
> > > >  1 file changed, 31 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > > index 4dfa9b69ca8d..51d93f9762d7 100644
> > > > --- a/include/linux/virtio_net.h
> > > > +++ b/include/linux/virtio_net.h
> > > > @@ -201,24 +201,45 @@ static inline int virtio_net_hdr_from_skb(con=
st struct sk_buff *skb,
> > > >
> > > >         if (skb_is_gso(skb)) {
> > > >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > > > +               u32 hdrlen;
> > > >
> > > > -               /* This is a hint as to how much should be linear. =
*/
> > > > -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> > > > -                                                skb_headlen(skb));
> > > > -               hdr->gso_size =3D __cpu_to_virtio16(little_endian,
> > > > -                                                 sinfo->gso_size);
> > > > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > > > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> > > > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > > > +                       hdrlen =3D tcp_hdrlen(skb) + skb_transport_=
offset(skb);
> > >
> > > So could evil guests give us a 0 hdrlen through this. If yes, it seems
> > > much more dangerous than headlen or we need harden the value as
> > > 9181d6f8a2bb32d158de66a84164fac05e3ddd18 did.
> >
> > Spec says:
> >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated, a=
nd
> >         gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the device MAY u=
se
> >         hdr_len as the transport header size. Note: Caution should be t=
aken by
> >         the implementation so as to prevent a malicious driver from att=
acking
> >         the device by setting an incorrect hdr_len.
> >
> >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiate=
d, or
> >         gso_type is VIRTIO_NET_HDR_GSO_NONE, the device MAY use hdr_len=
 only as
> >         a hint about the transport header size. The device MUST NOT rel=
y on
> >         hdr_len to be correct. Note: This is due to various bugs in
> >         implementations.
> >
> > The device nerver trust the hdr_len completely.
> > So I think that is safe.
>
> It doesn't, there's no way to audit all the existing implementations of v=
irtio.
>
> For example, have you seen the commit I've pointed to you?

I haven seen it.

But here, this is driver, the device should handen the check.
For the driver, we should do as the spec.
Do you mean that some evil driver pass 0 to device?
Now we fix that.


>
> >
> >
> > >
> > > > +
> > > > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> > > > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > > > +                       hdrlen =3D tcp_hdrlen(skb) + skb_transport_=
offset(skb);
> > > > +
> > > > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> > > > -               else
> > > > +                       hdrlen =3D sizeof(struct udphdr) + skb_tran=
sport_offset(skb);
> > > > +
> > > > +               } else {
> > > >                         return -EINVAL;
> > > > +               }
> > > > +
> > > > +               /* One of VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO =
options MUST
> > > > +                * have been negotiated. If the VIRTIO_NET_F_GUEST_=
HDRLEN is
> > > > +                * negotiated, we MUST set it to the length of "eth=
 header + ip
> > > > +                * header + tcp/udp header".  If the VIRTIO_NET_F_G=
UEST_HDRLEN
> > > > +                * is not negotiated, that still be a valid value.
> > > > +                */
> > >
> > > I'd stick the headlen for deivce without GUEST_HDRLEN. It seems much
> > > more safe as we don't want to break legacy devices.
> >
> > I do not get it.
>
> if (GUEST_HDRLEN)
>     tell the offset of the payload
> else
>     tell the headlen (stick to the old behaviour)


I am ok. Then we need to pass the features of the device to this function.

Thanks



>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > Thanks
> > >
> > >
> >
>
