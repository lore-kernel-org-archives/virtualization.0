Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583F6804
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817873; cv=none; b=AEoI+j8qo+uBD/x1FJzcYg7abOaFGaO1QOcJTecSgddJUyk8qR0DnpBBliFEYYIlhYRb/U7UvL0mppcjlsf9AQcRNYX+/+fM7eA3tfRy8fWqLXC2mljhrSoSoWYfbKsmjTlTrOwQ9OYVNSVz2Z8bQ1NLj7CJ1XAVVzzc5EzMBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817873; c=relaxed/simple;
	bh=VdEmOmtc0MnMUdyq0jHAkV2JuKbxBZtywGiWccAIGlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nht+A42vRefNU2jcJjV9cSsYsDB/Co2DiMCUCnIKfYSBJ4sHwc8fdaTfgh5GsDWAHprxduzyOcZ14iIdn1QXALihzH23PG8e6IXqxPbdIBqlEFHTXEYj6KV2okjnx1qOnnZPv7RApWQUaxjsZVSzLxn2cFr2PiZTu1+C1YNrIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sujkv5Co; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sujkv5Co"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713817870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXFh5b94b0GK/2/s/kABTn5grjUtSft6qQHzgg2WxWo=;
	b=Sujkv5CoqK1q7ZlCgsUS04B8cI2nG5hmkY1VWPROkrBefUbsppCQ8n8WautwLRDuSjj16Y
	yp+MGzlWkfpesZ9nzZcm2RkLuQAukbt8hL2JCQWJuvodd5UOrzZMz4P8U80i+3FskDFsNN
	q3b/cMWS1K+y2M0RxILE7z5udamMAFk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-xdQrGl9TMgSHwVIiw-B_ZQ-1; Mon, 22 Apr 2024 16:31:08 -0400
X-MC-Unique: xdQrGl9TMgSHwVIiw-B_ZQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34b40e8482aso745920f8f.0
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 13:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713817867; x=1714422667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXFh5b94b0GK/2/s/kABTn5grjUtSft6qQHzgg2WxWo=;
        b=sO81n1DoW8dFt6v0bO0Ic6fEmNWe8jKO6xAUh6jl6X+eYIahm61WYDCc4vpHzdF6Cd
         gxAXoFdUhH4CKaRq+FZixo0sJND1J1g/hzOZCkUuoD3Ae581DqOacOu2cfRSr6fGEo77
         ySTh+sgk3w3k6vVDlvcr4yLYiX+bWkWgSZmtV/isKvhrquHlmBBoAJleYbCWH5evM09x
         mGLQtIZsrsJQTduh0UnFu7foUsqbix5j+BZ1idTwmA/gWfGY5n3KyD8yzE2VwGICpI/i
         2lr8su8clcSdrxIjOoBQCQSt72uQN6T19FYWu7AMN73925AbGHl4koe9hRjYLIxBMjLq
         oJug==
X-Forwarded-Encrypted: i=1; AJvYcCX+SWhXlYl/XdRGJsJgPkxvpif2mf6qFzph2Kk368WyS+ooaZL8DY3Ay6aUPN6tDrJYB/Olti5Q8Hd9b3u1sDwWIZQ+CUuSyHMryR3KRf8=
X-Gm-Message-State: AOJu0YyvSnjcUz9xb5srybGYwiFRtw6gCIqM6boIjZT/KuwRUE+zc4c1
	Ivc2baEvHmWORzvUKz+ltHvGSk4k9NNOmsCVGDluKioKMWka6KiNBrLwwsN4v8ZKPy3lclKmznD
	g3RUaKJY5z4h0zA+C2hSfY7ULeycFX/yINqk9+JywAJVW1qYz8HhVQMx263ttcH5T
X-Received: by 2002:adf:f085:0:b0:348:104c:c105 with SMTP id n5-20020adff085000000b00348104cc105mr8986632wro.46.1713817866892;
        Mon, 22 Apr 2024 13:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT2V5Vy3TlGc4I/sEMpoSxb+Q9Agc8nqZ4MQ8pOteovmWyTSyk1jdtUZXQXLQq6jU8rc7KfQ==
X-Received: by 2002:adf:f085:0:b0:348:104c:c105 with SMTP id n5-20020adff085000000b00348104cc105mr8986607wro.46.1713817866232;
        Mon, 22 Apr 2024 13:31:06 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b0034aa0fc51f3sm7532435wrt.80.2024.04.22.13.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:31:05 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:31:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	Spike Du <spiked@nvidia.com>
Subject: Re: [PATCH vhost] virtio_net: update the hdr_len calculation for xmit
Message-ID: <20240422163048-mutt-send-email-mst@kernel.org>
References: <20240320102025.11327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs-x-W2DHh8U=+0ORnq7=kjw9SJNNtDFfGNjC2KqqPZeA@mail.gmail.com>
 <1711074462.3244817-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtOjPYuPi7MQcnp+TroxLKa4YtpTdsP4bNUSxUV8rgq3A@mail.gmail.com>
 <1711086351.5199406-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv7XsRVLSgOu8=VPvLwQZf5rAXrUFD2v9mCvLiV4PRCSw@mail.gmail.com>
 <1711087705.9262164-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1711087705.9262164-4-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 22, 2024 at 02:08:25PM +0800, Xuan Zhuo wrote:
> On Fri, 22 Mar 2024 13:57:36 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Fri, Mar 22, 2024 at 1:51 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Fri, 22 Mar 2024 13:04:48 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > On Fri, Mar 22, 2024 at 10:29 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > >
> > > > > On Thu, 21 Mar 2024 12:17:54 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > On Wed, Mar 20, 2024 at 6:20 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > >
> > > > > > > The virtio spec says:
> > > > > > >     If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
> > > > > > >     been negotiated:
> > > > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
> > > > > > >         and gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the driver
> > > > > > >         MUST set hdr_len to a value equal to the length of the headers,
> > > > > > >         including the transport header.
> > > > > > >
> > > > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiated,
> > > > > > >         or gso_type is VIRTIO_NET_HDR_GSO_NONE, the driver SHOULD set
> > > > > > >         hdr_len to a value not less than the length of the headers,
> > > > > > >         including the transport header.
> > > > > > >
> > > > > > > So if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated, the
> > > > > > > hdr->hdr_len should be eth header + ip header + tcp/udp header.
> > > > > > >
> > > > > > > But now:
> > > > > > >     hdr->hdr_len = __cpu_to_virtio15(little_endian, skb_headlen(skb));
> > > > > > >
> > > > > > > The skb_headlen() returns the linear space of the skb, not the header
> > > > > > > size that only match the case the VIRTIO_NET_F_GUEST_HDRLEN feature has
> > > > > > > not been negotiated, or gso_type is VIRTIO_NET_HDR_GSO_NONE.
> > > > > > >
> > > > > > > We do not check the feature of the device. This function is a common
> > > > > > > function used by many places. So we do more stricter work whatever
> > > > > > > the features is negotiated.
> > > > > > >
> > > > > > > For the case skb_is_gso(skb) is false, if none of the
> > > > > > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have been negotiated,
> > > > > > > the spec not define the action of setting hdr_len. Here I set it to
> > > > > > > skb_headlen(). If one of the above features have been negotiated, we
> > > > > > > should set a value not less than the length of "eth header + ip header +
> > > > > > > tcp/udp header". So the skb_headlen() also is a valid value.
> > > > > > >
> > > > > > > For the case skb_is_gso(skb) is true, it implies that one of
> > > > > > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options MUST have been
> > > > > > > negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN is negotiated, we MUST set
> > > > > > > it to the length of "eth header + ip header + tcp/udp header".
> > > > > > > If the VIRTIO_NET_F_GUEST_HDRLEN is not negotiated, that still be a
> > > > > > > valid value.
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > Reported-by: Spike Du <spiked@nvidia.com>
> > > > > > > ---
> > > > > > >  include/linux/virtio_net.h | 41 ++++++++++++++++++++++++++++----------
> > > > > > >  1 file changed, 31 insertions(+), 10 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > > > > > index 4dfa9b69ca8d..51d93f9762d7 100644
> > > > > > > --- a/include/linux/virtio_net.h
> > > > > > > +++ b/include/linux/virtio_net.h
> > > > > > > @@ -201,24 +201,45 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> > > > > > >
> > > > > > >         if (skb_is_gso(skb)) {
> > > > > > >                 struct skb_shared_info *sinfo = skb_shinfo(skb);
> > > > > > > +               u32 hdrlen;
> > > > > > >
> > > > > > > -               /* This is a hint as to how much should be linear. */
> > > > > > > -               hdr->hdr_len = __cpu_to_virtio16(little_endian,
> > > > > > > -                                                skb_headlen(skb));
> > > > > > > -               hdr->gso_size = __cpu_to_virtio16(little_endian,
> > > > > > > -                                                 sinfo->gso_size);
> > > > > > > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > > > > > > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> > > > > > >                         hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> > > > > > > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > > > > > > +                       hdrlen = tcp_hdrlen(skb) + skb_transport_offset(skb);
> > > > > >
> > > > > > So could evil guests give us a 0 hdrlen through this. If yes, it seems
> > > > > > much more dangerous than headlen or we need harden the value as
> > > > > > 9181d6f8a2bb32d158de66a84164fac05e3ddd18 did.
> > > > >
> > > > > Spec says:
> > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated, and
> > > > >         gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the device MAY use
> > > > >         hdr_len as the transport header size. Note: Caution should be taken by
> > > > >         the implementation so as to prevent a malicious driver from attacking
> > > > >         the device by setting an incorrect hdr_len.
> > > > >
> > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiated, or
> > > > >         gso_type is VIRTIO_NET_HDR_GSO_NONE, the device MAY use hdr_len only as
> > > > >         a hint about the transport header size. The device MUST NOT rely on
> > > > >         hdr_len to be correct. Note: This is due to various bugs in
> > > > >         implementations.
> > > > >
> > > > > The device nerver trust the hdr_len completely.
> > > > > So I think that is safe.
> > > >
> > > > It doesn't, there's no way to audit all the existing implementations of virtio.
> > > >
> > > > For example, have you seen the commit I've pointed to you?
> > >
> > > I haven seen it.
> > >
> > > But here, this is driver, the device should handen the check.
> >
> > Unfortunately not. We can't audit all device implementations.
> >
> > > For the driver, we should do as the spec.
> > > Do you mean that some evil driver pass 0 to device?
> > > Now we fix that.
> >
> > hdrlen = tcp_hdrlen(skb) + skb_transport_offset(skb)
> >
> > Did you mean hdrlen can't be zero here? I guess it is done by the
> > DODGY checking in the GSO path?
> 
> Do you mean tcp_hdrlen(skb) + skb_transport_offset(skb) maybe zero?
> I think so indeed. I will to check the logic of DODGY.
> 
> Thanks.

Was any conclusion reached?

> >
> > Then, let's explain it here.
> >
> > >
> > >
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> > > > > > >                         hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> > > > > > > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > > > > > > +                       hdrlen = tcp_hdrlen(skb) + skb_transport_offset(skb);
> > > > > > > +
> > > > > > > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> > > > > > >                         hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
> > > > > > > -               else
> > > > > > > +                       hdrlen = sizeof(struct udphdr) + skb_transport_offset(skb);
> > > > > > > +
> > > > > > > +               } else {
> > > > > > >                         return -EINVAL;
> > > > > > > +               }
> > > > > > > +
> > > > > > > +               /* One of VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options MUST
> > > > > > > +                * have been negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN is
> > > > > > > +                * negotiated, we MUST set it to the length of "eth header + ip
> > > > > > > +                * header + tcp/udp header".  If the VIRTIO_NET_F_GUEST_HDRLEN
> > > > > > > +                * is not negotiated, that still be a valid value.
> > > > > > > +                */
> > > > > >
> > > > > > I'd stick the headlen for deivce without GUEST_HDRLEN. It seems much
> > > > > > more safe as we don't want to break legacy devices.
> > > > >
> > > > > I do not get it.
> > > >
> > > > if (GUEST_HDRLEN)
> > > >     tell the offset of the payload
> > > > else
> > > >     tell the headlen (stick to the old behaviour)
> > >
> > >
> > > I am ok. Then we need to pass the features of the device to this function.
> >
> > Yes, a boolean probably.
> >
> > Thanks
> >
> > >
> > > Thanks
> > >
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >

