Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE41FC433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 20:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D9C08140F;
	Tue,  8 Feb 2022 20:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1NKEM6H-uqle; Tue,  8 Feb 2022 20:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 00B7C813F0;
	Tue,  8 Feb 2022 20:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF920C001A;
	Tue,  8 Feb 2022 20:55:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09EFEC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 20:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCEDB410D0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 20:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nml-SjYaiSGG
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 20:55:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD3FE410B6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 20:55:16 +0000 (UTC)
Received: by mail-vk1-xa2b.google.com with SMTP id d27so39907vkn.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 12:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dav5GHwHoInVNFFUmD/+H7rFBilhhPolISX4pLfyPgs=;
 b=I35aftOGkLR/ISv6OSLuGuNra4KAzA0XXAvR3HIzqJsZ4sbzSCT6m6eUErRZTsBdRZ
 5zHFtqoTfYTj0VaC44XixtJmomtIqu6M2jaGsuJVIFo9NFo73pcMfzY6Ib6daRmOQQ6G
 s61LlDd0JuL2BDMhfXFEtfUTzv8Gb82qMMbR0G9yretQLwALK2QmdEaFwNvtCZ+xTHcw
 YsKyu3HM3enCJRsm6D5qPoryva8Zw7Tulo94jtMwvcQWakEadP5Kr9mEupdTsILy1yjH
 aZAW1pjsKR/HlEntXIBoRge+jo1q74UJiwiUyNQKf6AdaelrV1Cb0N0B5Vj6vewPaFM1
 JBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dav5GHwHoInVNFFUmD/+H7rFBilhhPolISX4pLfyPgs=;
 b=jp87V60gY7rj2lGDhOu2c/SzYky2/rdoZHCoJseF4IWz69vZs6pI++EX2/6wMwy4Hw
 eweds7UhneLFNgqqaM8A6OUbQVbHsaGmdDByRV/ovflDPbl7FESiH4qraRjOIYCXvqws
 pDzcRre7YTgl1EvpXw6l1EAsc1IAqWC9D0kBC9eoOHfUBhGX+Pl9bTwFqxTbemQHkDiJ
 vcIDHNbrrkAtueg9XlN6UebIiHTYbOtr/BxcvIPqQuR+QyUQ8t2DTRU4a3ByxoHkcnQx
 lqzrYxqGvaA+jLB3C01qyjvF5NbM84XMShnbHS1DdJGdfo/8BDhbBS9DxP6OOYdjot8K
 iHVg==
X-Gm-Message-State: AOAM531gbZDSo1UOkUuDQElKv2qJb/i8dAP6w+lZRWtsv6FXdMj36qWJ
 gwoim7CR/ScobSybZ3ABxhITQgvCdBeIiw==
X-Google-Smtp-Source: ABdhPJyCiYvu8aQi1/sNqpSLXmHmP+STDhTrpTmnqT3cUmNoEMnnVCYpSAUrPQmCY34yek6uB24c8w==
X-Received: by 2002:a05:6122:886:: with SMTP id 6mr2549119vkf.37.1644353715477; 
 Tue, 08 Feb 2022 12:55:15 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com.
 [209.85.222.51])
 by smtp.gmail.com with ESMTPSA id l187sm3002870vke.6.2022.02.08.12.55.15
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 12:55:15 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id b37so235317uad.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 12:55:15 -0800 (PST)
X-Received: by 2002:ab0:6718:: with SMTP id q24mr1146421uam.141.1644353714675; 
 Tue, 08 Feb 2022 12:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20220208181510.787069-1-andrew@daynix.com>
 <20220208181510.787069-4-andrew@daynix.com>
In-Reply-To: <20220208181510.787069-4-andrew@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 8 Feb 2022 15:54:38 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdrHwNWh1Mz7KT8w+Z69LcNipeTcasny6ioqOUYBisNXg@mail.gmail.com>
Message-ID: <CA+FuTSdrHwNWh1Mz7KT8w+Z69LcNipeTcasny6ioqOUYBisNXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drivers/net/virtio_net: Added RSS hash report.
To: Andrew Melnychenko <andrew@daynix.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, yuri.benditovich@daynix.com,
 yan@daynix.com, kuba@kernel.org, davem@davemloft.net
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

On Tue, Feb 8, 2022 at 1:19 PM Andrew Melnychenko <andrew@daynix.com> wrote:
>
> Added features for RSS hash report.
> If hash is provided - it sets to skb.
> Added checks if rss and/or hash are enabled together.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 495aed524e33..543da2fbdd2d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -227,6 +227,7 @@ struct virtnet_info {
>
>         /* Host supports rss and/or hash report */
>         bool has_rss;
> +       bool has_rss_hash_report;
>         u8 rss_key_size;
>         u16 rss_indir_table_size;
>         u32 rss_hash_types_supported;
> @@ -421,7 +422,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>
>         hdr_len = vi->hdr_len;
>         if (vi->mergeable_rx_bufs)
> -               hdr_padded_len = sizeof(*hdr);
> +               hdr_padded_len = hdr_len;

Belongs in patch 1?

>         else
>                 hdr_padded_len = sizeof(struct padded_vnet_hdr);
>
> @@ -1156,6 +1157,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>         struct net_device *dev = vi->dev;
>         struct sk_buff *skb;
>         struct virtio_net_hdr_mrg_rxbuf *hdr;
> +       struct virtio_net_hdr_v1_hash *hdr_hash;
> +       enum pkt_hash_types rss_hash_type;
>
>         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                 pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1182,6 +1185,29 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>                 return;
>
>         hdr = skb_vnet_hdr(skb);
> +       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report) {

Can the first be true if the second is not?

> +               hdr_hash = (struct virtio_net_hdr_v1_hash *)(hdr);
> +
> +               switch (hdr_hash->hash_report) {
> +               case VIRTIO_NET_HASH_REPORT_TCPv4:
> +               case VIRTIO_NET_HASH_REPORT_UDPv4:
> +               case VIRTIO_NET_HASH_REPORT_TCPv6:
> +               case VIRTIO_NET_HASH_REPORT_UDPv6:
> +               case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> +               case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> +                       rss_hash_type = PKT_HASH_TYPE_L4;
> +                       break;
> +               case VIRTIO_NET_HASH_REPORT_IPv4:
> +               case VIRTIO_NET_HASH_REPORT_IPv6:
> +               case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> +                       rss_hash_type = PKT_HASH_TYPE_L3;
> +                       break;
> +               case VIRTIO_NET_HASH_REPORT_NONE:
> +               default:
> +                       rss_hash_type = PKT_HASH_TYPE_NONE;
> +               }
> +               skb_set_hash(skb, hdr_hash->hash_value, rss_hash_type);
> +       }

so many lines, perhaps deserves a helper function

>
>         if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>                 skb->ip_summed = CHECKSUM_UNNECESSARY;
> @@ -2232,7 +2258,8 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>         sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
>
>         if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
> -                                 VIRTIO_NET_CTRL_MQ_RSS_CONFIG, sgs)) {
> +                                 vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
> +                                 : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
>                 dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
>                 return false;
>         }
> @@ -3230,6 +3257,8 @@ static bool virtnet_validate_features(struct virtio_device *vdev)
>              VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR,
>                              "VIRTIO_NET_F_CTRL_VQ") ||
>              VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_RSS,
> +                            "VIRTIO_NET_F_CTRL_VQ") ||
> +            VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_HASH_REPORT,
>                              "VIRTIO_NET_F_CTRL_VQ"))) {
>                 return false;
>         }
> @@ -3365,8 +3394,13 @@ static int virtnet_probe(struct virtio_device *vdev)
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>                 vi->mergeable_rx_bufs = true;
>
> -       if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
> +       if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
> +               vi->has_rss_hash_report = true;
> +
> +       if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
>                 vi->has_rss = true;
> +
> +       if (vi->has_rss || vi->has_rss_hash_report) {
>                 vi->rss_indir_table_size =
>                         virtio_cread16(vdev, offsetof(struct virtio_net_config,

should indir table size be zero if only hash report is enabled?

>                                 rss_max_indirection_table_length));
> @@ -3382,8 +3416,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>
>                 dev->hw_features |= NETIF_F_RXHASH;
>         }
> -       if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> -           virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> +
> +       if (vi->has_rss_hash_report)
> +               vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
> +       else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> +                virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>                 vi->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
>         else
>                 vi->hdr_len = sizeof(struct virtio_net_hdr);
> @@ -3450,7 +3487,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>                 }
>         }
>
> -       if (vi->has_rss)
> +       if (vi->has_rss || vi->has_rss_hash_report)
>                 virtnet_init_default_rss(vi);
>
>         err = register_netdev(dev);
> @@ -3585,7 +3622,7 @@ static struct virtio_device_id id_table[] = {
>         VIRTIO_NET_F_CTRL_MAC_ADDR, \
>         VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>         VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> -       VIRTIO_NET_F_RSS
> +       VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT
>
>  static unsigned int features[] = {
>         VIRTNET_FEATURES,
> --
> 2.34.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
