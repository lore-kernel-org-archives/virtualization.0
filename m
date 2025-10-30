Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB762FFDFA
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812271; cv=none; b=JapjZPzbhRE4uHs4qgPHzmqfFz9CRBrha5pg96tLSAEFqcb8sMOd+hPX9nqYGS7Iosi1ncPlgvjaLssQlXEr1bxm8JhXA9NPU4ceNH5t3bGgAig2SCLGxohFcTPrzDtXd3xo10le894W+agXyUqVORezjcd0Yp1iJrx5L+HRmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812271; c=relaxed/simple;
	bh=ck1HslZ0kp7J+WUPymd8AWip7MysypRZtLhSaaOAht4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rGLI5O1kXI157zT0SKOzfPZwUmV0GJ10WzW5EGwiROdzp9uZQVNk+jMQLjWgfSP1TpoDv35cXQ+3Sx10A9N+nc3G5frVpEtpeBJfhqwRHhAgYdvsCgOPt1TPjkZnjB15YBhOAVj/aPlDiSAGr7/g7+wGLWE2r8MQY/iUPkqtBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCyHLPDf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCyHLPDf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761812269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62lhztl4PsEx1t/ejtRJFKI6a/pEqBnCixqR/6fg7Gg=;
	b=bCyHLPDfKv7g/b8xvvj/ZiR4JFO6/pqfQ+icQubrr9NjC5+drNLokZnulFrN6fJyBU/Byw
	5kaAb/68+TWv2M2GYEjLuCyjxQydU+gGcDOLtiSp3IpE7PPzCKR69N5MoqCUZzYUYyIPjC
	Z9Zchj1R3ps+DzOiGVA0jGZSPluP/X8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-KrLyR17QNjSU-DalmgRqWQ-1; Thu, 30 Oct 2025 04:17:47 -0400
X-MC-Unique: KrLyR17QNjSU-DalmgRqWQ-1
X-Mimecast-MFC-AGG-ID: KrLyR17QNjSU-DalmgRqWQ_1761812266
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42851b6a659so385452f8f.1
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 01:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812266; x=1762417066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62lhztl4PsEx1t/ejtRJFKI6a/pEqBnCixqR/6fg7Gg=;
        b=L7NhFTY2YWvNJZIAzg+oeqbNgUK0vuFnN9v7D+8wkx7hFM4URrNLH3Z42V1LPZDPDp
         xr3/uLWXKeWOtEbyyLrzPLhDPLdv3DGuomO8a/fOf33bLNY4F3m/3yaZeXtOqGSZGQTK
         T9URU0nAdWyLO9IeDvGfxPGms8xKyy+K54ZZaUMX3PR4ckr9Et1qQnhe5q/WB8MAmceG
         U/8dmq7QnbYglzKWejcMHX+e5GmicUcEd3oQm9IUvWg4woygF7bTwz0g2Q5ZUsW7i2c6
         UzCL7X6cCzoAlFnAsvrToqfTMwDT9QMpY+6EPsVWChN19AhEcB2I0zeES4Vaw+Vchg9L
         qr5w==
X-Forwarded-Encrypted: i=1; AJvYcCX25MtOtC/9yvf/pv3/IJjvbTf9gwYcIzAXd199cCn/1kVMb3h9yP2lWfi9YQnnJzbilLW/Z/4yFIN/ZhsOcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyyJ+aqc3c0+UEsu6OTubwb9+C57SM1/6H7bHoqwrbRfGXvY9P
	HACw6QqilxC8kFV9qY9tiFlqbcxgPCaj3uxnp2urt3R7+j4qKJAsS9CG89EovZkGcs48HNb4DTc
	J0tpPb4iq6q0Y5tUp5w5vjzxbgzulSDv5gW6/wPnEJgziK7/fnQ8vSFtJrf1nGJf3FYlv
X-Gm-Gg: ASbGncsaY1RNgUfzFHQTyeM4y/+SuuB7/VbyhTElbdV86xGRwGO4bAfcrB4wtVXrNdA
	sjp8+1i8W3uqCUeCVJVzX9m8hbMgSUxFLsJi3kL0AvBUJMo6jGwzptCI/tQtYmGZhHz10OB/DvI
	IsVQosx8Mms5D1vFEtGIOW/gOeg1WVkChyrLCYtcVNGEL22hnTKsfaLpVc36lgmu1obmwuAXcRJ
	LvqFZy0OB/g1vzDYFxpO+c+AO1IMUM551e0rmV9/eqWFzZZlcEFWQxfzRFp6j0pa9cFNTbkC0VA
	c0LkDQiyRGiiC8tt16tup17ujOutJMqt085JWBrPvGiCPvuLTrBXBHuaimuie2SK6RxU
X-Received: by 2002:a05:6000:240c:b0:429:8a40:e995 with SMTP id ffacd0b85a97d-429b4ca2efemr2051341f8f.61.1761812266314;
        Thu, 30 Oct 2025 01:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCC3j3pkeyjV7zwh2zWVtG7xi2X9bxfuD0Q0xhE4+gU6d0C0xhwka/NPYq7UvjEnPJvnZ1gw==
X-Received: by 2002:a05:6000:240c:b0:429:8a40:e995 with SMTP id ffacd0b85a97d-429b4ca2efemr2051295f8f.61.1761812265790;
        Thu, 30 Oct 2025 01:17:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:9d00:de90:c0da:d265:6f70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df473sm30541624f8f.42.2025.10.30.01.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:17:45 -0700 (PDT)
Date: Thu, 30 Oct 2025 04:17:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
Message-ID: <20251030041636-mutt-send-email-mst@kernel.org>
References: <20251029012434.75576-1-jasowang@redhat.com>
 <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
 <CACGkMEsTd6uCOCre8HK=5G14zu+xVOPOORZ2xcV_n9Kg6w8F5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsTd6uCOCre8HK=5G14zu+xVOPOORZ2xcV_n9Kg6w8F5Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YOxBYLJZGVLNDqzIzYt1PZWB4Sz5hhEu5fD5fKcG4AI_1761812266
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 30, 2025 at 10:40:13AM +0800, Jason Wang wrote:
> On Wed, Oct 29, 2025 at 4:20 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 10/29/25 2:24 AM, Jason Wang wrote:
> > > From: "Michael S. Tsirkin" <mst@redhat.com>
> > >
> > > Changing alignment of header would mean it's no longer safe to cast a
> > > 2 byte aligned pointer between formats. Use two 16 bit fields to make
> > > it 2 byte aligned as previously.
> > >
> > > This fixes the performance regression since
> > > commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> > > virtio_net_hdr_v1_hash_tunnel which embeds
> > > virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> > > shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
> > >
> > > Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Whoops, I replied to the older thread before reading this one.
> >
> > Acked-by: Paolo Abeni <pabeni@redhat.com>
> 
> I apologize, build will be broken since
> 
> commit b2284768c6b32aa224ca7d0ef0741beb434f03aa
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Wed Oct 22 11:44:21 2025 +0800
> 
>     virtio-net: zero unused hash fields
> 
> I will prepare a new version.
> 
> Btw, it looks like there's an uAPI change that may break builds of the
> userspace:

No, I think this has not been out long enough to matter.
QEMU imports linux headers extremely quickly but it can adapt.


> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 8bf27ab8bcb4..1db45b01532b 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -193,7 +193,8 @@ struct virtio_net_hdr_v1 {
> 
>  struct virtio_net_hdr_v1_hash {
>         struct virtio_net_hdr_v1 hdr;
> -       __le32 hash_value;
> +       __le16 hash_value_lo;
> +       __le16 hash_value_hi;
> 
> We can have a kernel only version for this but it probably means we
> need a kernel only version for all the future extension of vnet
> header?
> 
> Thanks
> 

Let's not complicate things too much please.

-- 
MST

