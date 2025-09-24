Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E431D63F8
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675106; cv=none; b=VfGXzNCvEWDMXjDBvWdgcVS4vcLgqst1DzBzvi7DkCCEYKn392hzEY8fndGwSE8rs/4L9DI0fyJKkzJDRfg6AnDSOgIm5n44nSUSA1y/yx3RqWT+Mwjub+z7XAyKplVbB3rnA+Z02tDNYycRN/AHtUsEZKvNFwQziRqe73ZvQJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675106; c=relaxed/simple;
	bh=B+gaEmpZQToa9D3BoDg5LW16aK2GKwumpEPqc28GJP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kECUdgBANSz/oQVRCHHfJZtQGxfUCRyjAD5/KTqIXUV3b/AVlt1X3zr/6eZqlwTeeFC23QkDfxwz0B8UichGs/mzaOnA3eN044kzoRAJCnoPMBSQ0TmimJLFSiV+/TNegR2SdK9Zm81TQM/jkmpgADDpPk5xsJIymLf+S93uaBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E07reOT1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E07reOT1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758675103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+CF+f8ZPtjHdoOi5iGDqJ4Pzq5sIU1lG9ApqP2SS3I=;
	b=E07reOT16ucuujXiTH1s35u5SksHh2hSwgM83KPTegSumPBuVSaT2ZwMKcB0BbBThO8JJJ
	FewluLqWq8bnthexSvt1MfIuwHvKuKtENq6olUC/029uB5ThYgquURr2ku80YNkDjPFmwk
	/U3s4Qzku7wJKsWVWsJ0vHFE35JiexI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-RkKLFDRuPGyBqus41m5i5w-1; Tue, 23 Sep 2025 20:51:42 -0400
X-MC-Unique: RkKLFDRuPGyBqus41m5i5w-1
X-Mimecast-MFC-AGG-ID: RkKLFDRuPGyBqus41m5i5w_1758675101
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so6353225a91.2
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 17:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675101; x=1759279901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+CF+f8ZPtjHdoOi5iGDqJ4Pzq5sIU1lG9ApqP2SS3I=;
        b=qNfxYAJaXACRvS30G7eDcZUdRQX++S5nhgDqDuqLO/pqnSBZYT8rfvAyVCbItzaXAT
         GMGowHHjQmJCTV3e5CcoGZroUOQtAxZCL7qrs11lRVx+ibhqnSm2FbFsy/fwMlmw2bxv
         M8ESkD4KHm7D6uY6LH2Uqg/2yo2DarRh6i9is71kJXmn0xPRHpkQ01mFDGevsj8LKIIb
         QbSand6CbhWb+iscAqKBaFv37768TTTfnN+YF4xFSwDFpEkrAEW11hs1yeqfP47x7cUS
         LrGcWFnz9Cnq7dBsVDgc6aLyPesubRfoaNwJtItaxY93CfyIEgjnWsnzeT4Rxaa8R0WC
         MEMA==
X-Forwarded-Encrypted: i=1; AJvYcCXTouIxWveXhVHUXYT1ek/vBsuQKzR5drC5cxBP4YjaT26/pm96LOyt+4WuyK/y1vfxN40DcPUiMKv3mdEmMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtYbyi2yHSL5FZIsgpILl0POvLZJbY5dyHcjRj+lj5hUVgIxGk
	h7+s7XYqB+Vc43snbeE5omMC/L5m5YxLd7NPX15urYxOf4f6fc1gRhor8yaDDPHFuBUTs2BTa0L
	1Big/cMU1sHNyZLMnXXzBhe+0e1utB2J20sszNlwcttdnxteTvQ7Inp6Fx/vNe7weO/b6uWqn+g
	1/8gjBZZpVZTIOwUnyKYfpi+p26l3Gh21Oz3HYb023Pzc=
X-Gm-Gg: ASbGnctIigUiur/3ZjQcaH/9kM0GeU66jVirudIYm7LajZHDBGuXcb0/ZE4yipNS3x+
	iyIYktQNRfMfKwsewL/iEwa2HL61j+1sVfmlKcisvCf6iP4SkPGvSOvwnK/iHH6hphMb6ZUlp4M
	fG13eYnBah9Bdwk8LTbw==
X-Received: by 2002:a17:90b:3811:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-332a970664cmr4735580a91.36.1758675101153;
        Tue, 23 Sep 2025 17:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6wlZU45QFpZaoYYGJj/yXqXhdztwIB8H8KjfQJG+1bAi7ZxkXTql04g41IaDsPBl3CCKvK35kQdqhNnbKqmU=
X-Received: by 2002:a17:90b:3811:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-332a970664cmr4735562a91.36.1758675100707; Tue, 23 Sep 2025
 17:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250923202258.2738717-1-kshankar@marvell.com> <20250923202258.2738717-2-kshankar@marvell.com>
In-Reply-To: <20250923202258.2738717-2-kshankar@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 08:51:29 +0800
X-Gm-Features: AS18NWDo9GoRDKQ-kypc5YbeoTNltuvTxzdNxXyoo3qGwjJnvJLpDCXfXyisvgk
Message-ID: <CACGkMEvUMq7xgOndvWUYU=BZL=ZZD1q_LRy=5YFL7k80cYBRRg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/3] net: implement virtio helper to handle
 outer nw offset
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	jerinj@marvell.com, ndabilpuram@marvell.com, sburla@marvell.com, 
	schalla@marvell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xkICwkjEu6jlurR9CPnCX7-B51xO5LAzeeZ2LWze97M_1758675101
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:23=E2=80=AFAM Kommula Shiva Shankar
<kshankar@marvell.com> wrote:
>
> virtio specification introduced support for outer network
> header offset broadcast.
>
> This patch implements the needed defines and virtio header
> parsing capabilities.
>
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> ---
>  include/linux/virtio_net.h      | 40 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net.h |  8 +++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 20e0584db1dd..e6153e9106d3 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -374,6 +374,46 @@ static inline int virtio_net_handle_csum_offload(str=
uct sk_buff *skb,
>         return 0;
>  }
>
> +static inline int
> +virtio_net_out_net_header_to_skb(struct sk_buff *skb,
> +                                struct virtio_net_hdr_v1_hash_tunnel_out=
_net_hdr *vhdr,
> +                                bool out_net_hdr_negotiated,
> +                                bool little_endian)
> +{
> +       unsigned int out_net_hdr_off;
> +
> +       if (!out_net_hdr_negotiated)
> +               return 0;
> +
> +       if (vhdr->outer_nh_offset) {
> +               out_net_hdr_off =3D __virtio16_to_cpu(little_endian, vhdr=
->outer_nh_offset);
> +               skb_set_network_header(skb, out_net_hdr_off);
> +       }
> +
> +       return 0;
> +}
> +
> +static inline int
> +virtio_net_out_net_header_from_skb(const struct sk_buff *skb,
> +                                  struct virtio_net_hdr_v1_hash_tunnel_o=
ut_net_hdr *vhdr,
> +                                  bool out_net_hdr_negotiated,
> +                                  bool little_endian)
> +{
> +       unsigned int out_net_hdr_off;
> +
> +       if (!out_net_hdr_negotiated) {
> +               vhdr->outer_nh_offset =3D 0;
> +               return 0;
> +       }
> +
> +       out_net_hdr_off =3D skb_network_offset(skb);
> +       if (out_net_hdr_off && skb->protocol =3D=3D htons(ETH_P_IP))
> +               vhdr->outer_nh_offset =3D __cpu_to_virtio16(little_endian=
,
> +                                                         out_net_hdr_off=
);

I'd expect this to work for IPV6 as well.

Thanks

