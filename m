Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6144BC433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 20:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 057C160F21;
	Tue,  8 Feb 2022 20:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U2_ruJ7KYoyr; Tue,  8 Feb 2022 20:59:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8EF5960E28;
	Tue,  8 Feb 2022 20:59:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 641D3C001A;
	Tue,  8 Feb 2022 20:59:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13018C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 20:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D930D408C3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 20:59:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H-_3WcPfxbe4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 20:59:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C859C40176
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 20:59:05 +0000 (UTC)
Received: by mail-vs1-xe2b.google.com with SMTP id b2so371534vso.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 12:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NxB7BzC6ZAoAU/UTQQPI/XYwGHJmUDw1BkVBGKXBE4c=;
 b=Y3dHeM9K1rCwczLjQBwnOlwAC1lSGX6KBBSSvc9OyYXm6MqTlm+Arx3JxBqbvT2562
 W0x2T60xfaRmhG7hTPmRYxjsLOT4FN+LbwHOE0BH68Xi/mXCfSwaGROEhPdmrgqDlHqJ
 JPRWBGOJQ1PS76ChpBJzY0tx4VNWTjdTb5fVBwWSghrT8vsr7qedw4jQ2c13cNgs/aAc
 e+yl1ENT+jlXNFeDSWDJK7+ZX7++Mr0D+/gQpLUqOG41iNLxTrInsNBCQIyOYpRI8+tI
 gAz2GORpxqQe3vUVD0C0We+OO0BwCa4LDGZN8KtEOfBlMnFIXOa75bonu1iLcDzr68hi
 cOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NxB7BzC6ZAoAU/UTQQPI/XYwGHJmUDw1BkVBGKXBE4c=;
 b=7nNP1zh/Z6FEE5KhEjuQrc33z/j4GDcaUBP8wVdJHZFdGCNAKcVatyY0X1CKm8GGFZ
 L29MNY/lozKTREEIv7+QiKzi7f6KlclU9WnFOLLI2T36739Sn1VvU2TkWylRAqCzYruw
 KCFnqgcS5KOdN++7LxdzcdHsK/N99EQFqPGwQQtco51N1bpwCwcoYLISrXVH/PjsLXDA
 R+usmpKRj+5quMsXBDPYeC4Vk1OCNdBBsG015mUjVjmW5Vw+imfeeORseADw+IQ3GVSD
 YSGcsYSrrkuzYHwrx1ZBtcvnNBj1HtVWTg6IROjz9jjf9o+B/HjjYap4K6lT6AZK3eGc
 zbQA==
X-Gm-Message-State: AOAM533BaBPX+K2FpKKnxSMQHKj2Xs0iDQ7I4SRENcJ8GO8IeQNlOFu/
 7EO4V3D/tLdZn1yAF1R0/gxywJA3fOrALA==
X-Google-Smtp-Source: ABdhPJxcY7X5TnTOfmrgPGz4i14xbSWpelXM2JGwtPrqI44/Wu5KaEgI/JJJAZ+bDsDSDV80WtEsUg==
X-Received: by 2002:a05:6102:d1:: with SMTP id u17mr396536vsp.57.1644353944423; 
 Tue, 08 Feb 2022 12:59:04 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com.
 [209.85.222.41])
 by smtp.gmail.com with ESMTPSA id z23sm1432672uaq.2.2022.02.08.12.59.03
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 12:59:04 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id f13so246380uab.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 12:59:03 -0800 (PST)
X-Received: by 2002:ab0:384c:: with SMTP id h12mr2198570uaw.122.1644353943533; 
 Tue, 08 Feb 2022 12:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20220208181510.787069-1-andrew@daynix.com>
 <20220208181510.787069-5-andrew@daynix.com>
In-Reply-To: <20220208181510.787069-5-andrew@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 8 Feb 2022 15:58:27 -0500
X-Gmail-Original-Message-ID: <CA+FuTScRp5hhkvETuVRsUxMRCZVU0wVrmd5_=a5UoKNLDv4LnA@mail.gmail.com>
Message-ID: <CA+FuTScRp5hhkvETuVRsUxMRCZVU0wVrmd5_=a5UoKNLDv4LnA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drivers/net/virtio_net: Added RSS hash report
 control.
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
> Now it's possible to control supported hashflows.
> Added hashflow set/get callbacks.
> Also, disabling RXH_IP_SRC/DST for TCP would disable then for UDP.

I don't follow this comment. Can you elaborate?

> TCP and UDP supports only:
> ethtool -U eth0 rx-flow-hash tcp4 sd
>     RXH_IP_SRC + RXH_IP_DST
> ethtool -U eth0 rx-flow-hash tcp4 sdfn
>     RXH_IP_SRC + RXH_IP_DST + RXH_L4_B_0_1 + RXH_L4_B_2_3
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/net/virtio_net.c | 141 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 140 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 543da2fbdd2d..88759d5e693c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -231,6 +231,7 @@ struct virtnet_info {
>         u8 rss_key_size;
>         u16 rss_indir_table_size;
>         u32 rss_hash_types_supported;
> +       u32 rss_hash_types_saved;

hash_types_active?

> +static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *info)
> +{
> +       u32 new_hashtypes = vi->rss_hash_types_saved;
> +       bool is_disable = info->data & RXH_DISCARD;
> +       bool is_l4 = info->data == (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3);
> +
> +       /* supports only 'sd', 'sdfn' and 'r' */
> +       if (!((info->data == (RXH_IP_SRC | RXH_IP_DST)) | is_l4 | is_disable))

maybe add an is_l3

> +               return false;
> +
> +       switch (info->flow_type) {
> +       case TCP_V4_FLOW:
> +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv4 | VIRTIO_NET_RSS_HASH_TYPE_TCPv4);
> +               if (!is_disable)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv4
> +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_TCPv4 : 0);
> +               break;
> +       case UDP_V4_FLOW:
> +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv4 | VIRTIO_NET_RSS_HASH_TYPE_UDPv4);
> +               if (!is_disable)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv4
> +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_UDPv4 : 0);
> +               break;
> +       case IPV4_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> +               if (!is_disable)
> +                       new_hashtypes = VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> +               break;
> +       case TCP_V6_FLOW:
> +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv6 | VIRTIO_NET_RSS_HASH_TYPE_TCPv6);
> +               if (!is_disable)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv6
> +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_TCPv6 : 0);
> +               break;
> +       case UDP_V6_FLOW:
> +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv6 | VIRTIO_NET_RSS_HASH_TYPE_UDPv6);
> +               if (!is_disable)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv6
> +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_UDPv6 : 0);
> +               break;
> +       case IPV6_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> +               if (!is_disable)
> +                       new_hashtypes = VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> +               break;
> +       default:
> +               /* unsupported flow */
> +               return false;
> +       }
> +
> +       /* if unsupported hashtype was set */
> +       if (new_hashtypes != (new_hashtypes & vi->rss_hash_types_supported))
> +               return false;
> +
> +       if (new_hashtypes != vi->rss_hash_types_saved) {
> +               vi->rss_hash_types_saved = new_hashtypes;

should only be updated if the commit function returned success?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
