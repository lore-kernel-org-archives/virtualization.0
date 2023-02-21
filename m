Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1E5C61DA3
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 15:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4EB1415AC;
	Tue, 21 Feb 2023 15:27:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4EB1415AC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ganXHfcs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G1-NG9iyTyaC; Tue, 21 Feb 2023 15:26:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2754A41016;
	Tue, 21 Feb 2023 15:26:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2754A41016
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB832C0032;
	Tue, 21 Feb 2023 15:26:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EA77C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A0D341016
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:26:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A0D341016
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tRxhuEDG7zxX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:26:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 750C24023B
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 750C24023B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:26:56 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id u10so5339283pjc.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CEBQYFfz8u1AQ/qusEQlYsB5MIzDcptJm3TnGtSX42M=;
 b=ganXHfcsHc1FLGIm1FbFzKTNHXRPhCgH9k4aSTvgxxXPEtvDtIL5Gno0e4Du667/wn
 0g1TugteC6QFgAAzMbrQrDHZYw6hf6mElcJ4FNSKzQ4idls6Ys3UIzMT3ShAni7PHNQQ
 lA55rflyFv9EbcbWnsoEVHF0/zGnNVAb14eS1OLUOtrGbY84y17lRiPqrPZN++TlS2d7
 aDKYriyo6FWfkHAT5Od5SSyO4tQFb2vlhKUbyHS92lG+f7asbS5pZcb/WcJzQ43/GD7k
 pAldqMBgElL8Tj6ofNihxl52LhazIPkPpH/Hs+//hl6DGHl329HcpWcZT9TtsG4O+3tO
 rbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CEBQYFfz8u1AQ/qusEQlYsB5MIzDcptJm3TnGtSX42M=;
 b=4ZlpD16J+5+JaIIf3bMRL1sGKl7VyQlf1XTRrQ8YxmjPHUcGksYBKMP/0A/YK2NvQQ
 2vvsZIOcJ2dWPATfn/Uajs96FdcOFcAF7bd7SkStZ1gKkIHuCBksunomgO4W6+5ot5wg
 TBO5g4jr4lLGLP7zNhfkaSxGDvjZuyo0p4G6iq9y30PC/xtd4w/AALdz3uhUoatDqUjf
 V8lVgVSzXE6bmMP0NLVkO5EBG8155HCDQN+byX1e0mgV/uuTAecjStWtcyPmyTVksHjg
 LLXMulu14caGI9U0+CRRO/lVAZEhSfjqEV1ND4LUB06S+G2kuNsJlfbbimreBEWwfghD
 i5Ig==
X-Gm-Message-State: AO0yUKUceVLlNYA3vk3T7+69MK9dyoslDi0TXNeSLMSGWHU7WZE8FCac
 Quo9M0/80pvhWIlkq61h0U3QTMC6/GbXTq/4RtRUTA2o6TNr9IlJ
X-Google-Smtp-Source: AK7set/qHTpAvHhp8PD1WmOrzerofi/YjEjmRzdSlSv29jiMeyxbdKlgxlSYSlQmd118whC13xVGKzd2fpwhr8zKhVo=
X-Received: by 2002:a17:90b:3912:b0:233:f53f:95eb with SMTP id
 ob18-20020a17090b391200b00233f53f95ebmr1575044pjb.51.1676993215734; Tue, 21
 Feb 2023 07:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20230221144741.316477-1-jiri@resnulli.us>
In-Reply-To: <20230221144741.316477-1-jiri@resnulli.us>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 21 Feb 2023 17:26:19 +0200
Message-ID: <CAJs=3_Aqy25Xnm3fNV7A2Xz6uN9vdKGXE9w5Zg99fb0HgpbZnQ@mail.gmail.com>
Subject: Re: [patch net-next v2] net: virtio_net: implement exact header
 length guest feature
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, netdev@vger.kernel.org, vmireyno@marvell.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
> set implicates that the driver provides the exact size of the header.
>
> Quoting the original virtio spec:
> "hdr_len is a hint to the device as to how much of the header needs to
>  be kept to copy into each packet"
>
> "a hint" might not be clear for the reader what does it mean, if it is
> "maybe like that" of "exactly like that". This feature just makes it
> crystal clear and let the device count on the hdr_len being filled up
> by the exact length of header.
>
> Also note the spec already has following note about hdr_len:
> "Due to various bugs in implementations, this field is not useful
>  as a guarantee of the transport header size."
>
> Without this feature the device needs to parse the header in core
> data path handling. Accurate information helps the device to eliminate
> such header parsing and directly use the hardware accelerators
> for GSO operation.
>
> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
> The driver already complies to fill the correct value. Introduce the
> feature and advertise it.
>
> Note that virtio spec also includes following note for device
> implementation:
> "Caution should be taken by the implementation so as to prevent
>  a malicious driver from attacking the device by setting
>  an incorrect hdr_len."
>
> There is a plan to support this feature in our emulated device.
> A device of SolidRun offers this feature bit. They claim this feature
> will save the device a few cycles for every GSO packet.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - extended patch description
> ---
>  drivers/net/virtio_net.c        | 6 ++++--
>  include/uapi/linux/virtio_net.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fb5e68ed3ec2..e85b03988733 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -62,7 +62,8 @@ static const unsigned long guest_offloads[] = {
>         VIRTIO_NET_F_GUEST_UFO,
>         VIRTIO_NET_F_GUEST_CSUM,
>         VIRTIO_NET_F_GUEST_USO4,
> -       VIRTIO_NET_F_GUEST_USO6
> +       VIRTIO_NET_F_GUEST_USO6,
> +       VIRTIO_NET_F_GUEST_HDRLEN
>  };
>
>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> @@ -4213,7 +4214,8 @@ static struct virtio_device_id id_table[] = {
>         VIRTIO_NET_F_CTRL_MAC_ADDR, \
>         VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>         VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> -       VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL
> +       VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
> +       VIRTIO_NET_F_GUEST_HDRLEN
>
>  static unsigned int features[] = {
>         VIRTNET_FEATURES,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index b4062bed186a..12c1c9699935 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -61,6 +61,7 @@
>  #define VIRTIO_NET_F_GUEST_USO6        55      /* Guest can handle USOv6 in. */
>  #define VIRTIO_NET_F_HOST_USO  56      /* Host can handle USO in. */
>  #define VIRTIO_NET_F_HASH_REPORT  57   /* Supports hash report */
> +#define VIRTIO_NET_F_GUEST_HDRLEN  59  /* Guest provides the exact hdr_len value. */
>  #define VIRTIO_NET_F_RSS         60    /* Supports RSS RX steering */
>  #define VIRTIO_NET_F_RSC_EXT     61    /* extended coalescing info */
>  #define VIRTIO_NET_F_STANDBY     62    /* Act as standby for another device
> --
> 2.39.0
>

This indeed saves some cycles in our device.
Thanks!

Reviewed-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
