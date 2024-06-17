Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513742AB3
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 02:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591683; cv=none; b=mVmeTPvjQro/rT6wkXss1hl3hbfTETAIQgGMgVpx63WmdA71j3nxmnW8WCT7pHOciBzW6yf/LwdaYLooOjnAI1VZWTXYX/76nPGJrTV3c3S0YRrES/upiXyqDbjD/KCAMdHLECOLTX0ofNVfG+pyvD+LV636bN00tV81k6l6aqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591683; c=relaxed/simple;
	bh=wVjX/l5CugFbIXZq34PxHCJ8/aJuMF+svZ9a8x+A0X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z95q7S4LRa/RRZ76k522Olugoglvxxym5V0oeln/M8e9soqWYf/WmP5q78Rix2LPCzs6ifRlKp//jWxQWsMQBBLVgfnmjuBbPBinaOMVSeGG1g6qHrwojqwNJJU4orkpHRa138L1LIkJCVTlEoT8VUbNlVerBPX0MiCFk9xJ3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6wxqMnU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6wxqMnU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718591680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JszeaKzCJJ+7l4j0Mas4tHvSBPtGEySdFo11lqznNxg=;
	b=E6wxqMnUNjNzaaCSBOVPRql9Jv26n10skXNRSbgw0CLiZki9Rc6NlETjlYPsuH2DXqE163
	QziSGyjWGM0+ELMeEEyMmfvShwC7y5yWhsqa6tUJfJB3Wl2p0DfLgcZc5SFG+4H4Qvvre4
	8RWeb7j4kVCJ7fmJZ61jrNx/FUY4xfM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-R21qBhPqMT2_GS_odXNvTQ-1; Sun, 16 Jun 2024 22:34:39 -0400
X-MC-Unique: R21qBhPqMT2_GS_odXNvTQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6e73d656bd0so3304630a12.1
        for <virtualization@lists.linux.dev>; Sun, 16 Jun 2024 19:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718591678; x=1719196478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JszeaKzCJJ+7l4j0Mas4tHvSBPtGEySdFo11lqznNxg=;
        b=uvnLMIF2vFKn0T7FiuhuxKzEiJ5Caq8cPOKzApPjNNoQEBp6KNOo2EpBBqxP4AOFDO
         8oTfLSj2sqCUTnCoj03bn3c4Bk9r8jVhrUaT4coEpd+7mftRwNUGML+od+mpBZ0UIpN+
         qdng8KF2geflLvxS8hTrdiU6JF7Z6UVt/qR2N13V+i2saOtJC36ZZmhXueaQwMIpOHNv
         aorwOfEqKWBC3WXssSqQ26Sanirwrs+nxqVTsSoZCCEJ2rwZ1Ot3sipOGqEH5Tv2HUFF
         8ae09RFOuGLZfdI9kgDtHw+xFVUcMt8Y2iHT/wuLIqYtyBRINP86+YSAMii5Vxuvr91U
         +T1w==
X-Forwarded-Encrypted: i=1; AJvYcCXTjnV4wjqcmEVnL0HHFWhWdzMCSR52BBuGHD7euFJAn1dTdjwNXgBNx1C8PijC/ApwsaKi17/hOoY9C/PQgMlBwZqku1Knpyt/HpmPRLM=
X-Gm-Message-State: AOJu0Yw7NwlCI64Lnrl7exrwO8DuJYFLh5/P8YwPpThbxOceZYk3K92p
	9CKRN+UTQBZY9qPm0B2+PqE2Xtl5Fa5MBr8r1CDVCOZ2TuFd/IRNlIRa0KiSPhpYpkSxBKYfgct
	Y5AUFo+QqJvjUTjQ/egTqVcG+C8e6odxly3ZS522c8tnRDIWwj93m4xuDTzfnppuU/xNkoOxx2e
	45Ujl962jIYuSka2BSZB4nhJnyjq+fkc0F+jMV5fs=
X-Received: by 2002:a05:6a20:430d:b0:1b6:db6c:11dd with SMTP id adf61e73a8af0-1bae7e29041mr9381585637.9.1718591677954;
        Sun, 16 Jun 2024 19:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3G1lgoKUKITFW2RvGO2yeflzp9Fh1IrK5zjnNOFRBaNyS8KMl6/lpvxThMCxCmxEaj/LNMsNixYaC3L1+jgk=
X-Received: by 2002:a05:6a20:430d:b0:1b6:db6c:11dd with SMTP id
 adf61e73a8af0-1bae7e29041mr9381570637.9.1718591677588; Sun, 16 Jun 2024
 19:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240612170851.1004604-1-jiri@resnulli.us>
In-Reply-To: <20240612170851.1004604-1-jiri@resnulli.us>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 10:34:26 +0800
Message-ID: <CACGkMEv-mO6Sus7_MkCR3B3QGukrig2e2KgBeVBcfOMU5uvo9g@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	dave.taht@gmail.com, kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 1:09=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Add support for Byte Queue Limits (BQL).
>
> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
> running in background. Netperf TCP_RR results:
>
> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>   BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>   BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>   BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>   BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>   BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>   BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>   propagate use_napi flag to __free_old_xmit() and only call
>   netdev_tx_completed_queue() in case it is true
> - added forgotten call to netdev_tx_reset_queue()
> - fixed stats for xdp packets
> - fixed bql accounting when __free_old_xmit() is called from xdp path
> - handle the !use_napi case in start_xmit() kick section
> ---
>  drivers/net/virtio_net.c | 50 +++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d134544..5863c663ccab 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
>
>  struct virtnet_sq_free_stats {
>         u64 packets;
> +       u64 xdp_packets;
>         u64 bytes;
> +       u64 xdp_bytes;
>  };
>
>  struct virtnet_sq_stats {
> @@ -506,29 +508,33 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
>  }
>
> -static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *=
txq,
> +                           bool in_napi, bool use_napi,
>                             struct virtnet_sq_free_stats *stats)
>  {
>         unsigned int len;
>         void *ptr;
>
>         while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> -               ++stats->packets;
> -
>                 if (!is_xdp_frame(ptr)) {
>                         struct sk_buff *skb =3D ptr;
>
>                         pr_debug("Sent skb %p\n", skb);
>
> +                       stats->packets++;
>                         stats->bytes +=3D skb->len;
>                         napi_consume_skb(skb, in_napi);
>                 } else {
>                         struct xdp_frame *frame =3D ptr_to_xdp(ptr);
>
> -                       stats->bytes +=3D xdp_get_frame_len(frame);
> +                       stats->xdp_packets++;
> +                       stats->xdp_bytes +=3D xdp_get_frame_len(frame);
>                         xdp_return_frame(frame);
>                 }
>         }
> +       if (use_napi)
> +               netdev_tx_completed_queue(txq, stats->packets, stats->byt=
es);
> +
>  }

I wonder if this works correctly, for example NAPI could be enabled
after queued but before sent. So __netdev_tx_sent_queue() is not
called before.

Thanks

