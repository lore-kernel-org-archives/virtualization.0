Return-Path: <SRS0=XZyc=NX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21D8C432BE
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 07:40:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6977A6103A
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 07:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6977A6103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30FE9406C1;
	Wed,  1 Sep 2021 07:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PMi8O8PMDIdo; Wed,  1 Sep 2021 07:40:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B6296405E7;
	Wed,  1 Sep 2021 07:40:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89187C001A;
	Wed,  1 Sep 2021 07:40:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CE11C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 07:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1634C40613
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 07:40:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b9dtyDWdVQSk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 07:40:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E901405E7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 07:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630482036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WbA7CP4xtTeLnvPq3VcqMOzaSiQi1f+ly7oxs5Az3g=;
 b=JargjN6WeUUhx5SWxlZhrXdmTWJHFX0Mw46O1jerL8nCy3+gVgkE5Sa7LKpmphGIwHiLdj
 fE7BO+5dzBWxUumSFpAqs96Y9vmXOyFkQ7mJczUwLn72f9AgTzUJjIdLDwuaCvWYr6Eu5h
 PIP0/sbEeCYNTjnQUI0v1IkusVo3RxE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-Ksu6T9mCOFy766ys4qTj-Q-1; Wed, 01 Sep 2021 03:40:34 -0400
X-MC-Unique: Ksu6T9mCOFy766ys4qTj-Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 m10-20020a2e97ca000000b001bb5da17f7dso724280ljj.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Sep 2021 00:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0WbA7CP4xtTeLnvPq3VcqMOzaSiQi1f+ly7oxs5Az3g=;
 b=azclidsgCTvkuufAeaZhjOCN7owaJz+j+ddEeByDaeazBj3pZXF3D/Sc1hOwMeJ2Xi
 ZPlwaO11TBZhvOOELPokyuzgVeh2xpqc0lA+FzxJE83SptX+DmYcCTwle4fc7T7hIocG
 oLbxOh3KBtIabbV7l+jCigMYFQe62Rduh71ra7ro9CG4zmxVUh0lUjjod87Mt2RZ2L1c
 lyOcF1whLJXHTzFFIgE1jMP2/iwG9rocuAH5z9fzXh8bxD2vrRGKHfPEVSKE933GYvrr
 ls5KmPBKScDDAkWHR7Ki8RbeWphLW5eNioDFkI0SQLnaWMefKrAsuO5pKr8uimeNNbiX
 eveA==
X-Gm-Message-State: AOAM532lFWjoS2+cLfGW7PPabMu0x0RscmI0ekiLvc7bPI6ZDUBN8yes
 g1RxS6chqEo8v/kwk+/oyn5QmqGAgxSg7QDdTgSdtMp7/f0l+voOFjuWbkOUzh847ssIarVVV2F
 Xvyfszi0b/1k2aLe1FjmMSQppC9lQSlsKfdnfuDyCyoz5JZt5qXLBxdkE1A==
X-Received: by 2002:a05:6512:31d2:: with SMTP id
 j18mr11009425lfe.436.1630482033376; 
 Wed, 01 Sep 2021 00:40:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyahV0M9rKSrLz0mU1SWubpqt6FJo9F3vajGULKpIMtl+B/GMoT9WUyYL46OT/AWY+UK7B7y4hkiWepNYG0vfE=
X-Received: by 2002:a05:6512:31d2:: with SMTP id
 j18mr11009407lfe.436.1630482033131; 
 Wed, 01 Sep 2021 00:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210818175440.128691-1-andrew@daynix.com>
 <20210818175440.128691-4-andrew@daynix.com>
In-Reply-To: <20210818175440.128691-4-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Sep 2021 15:40:21 +0800
Message-ID: <CACGkMEtphOre1QPwOqYk5uLM=2Xy_QEXUJehY3-YTop5h=2Rag@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] drivers/net/virtio_net: Added RSS hash report.
To: Andrew Melnychenko <andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, davem <davem@davemloft.net>
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

On Thu, Aug 19, 2021 at 1:55 AM Andrew Melnychenko <andrew@daynix.com> wrote:
>
> Added set_hash for skb.
> Also added hashflow set/get callbacks.
> Virtio RSS "IPv6 extensions" hashes disabled.
> Also, disabling RXH_IP_SRC/DST for TCP would disable them for UDP.
> TCP and UDP supports only:
> ethtool -U eth0 rx-flow-hash tcp4 sd
>     RXH_IP_SRC + RXH_IP_DST
> ethtool -U eth0 rx-flow-hash tcp4 sdfn
>     RXH_IP_SRC + RXH_IP_DST + RXH_L4_B_0_1 + RXH_L4_B_2_3
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/net/virtio_net.c | 177 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d87bde246305..6a52eeaf9292 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1151,6 +1151,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>         struct net_device *dev = vi->dev;
>         struct sk_buff *skb;
>         struct virtio_net_hdr_mrg_rxbuf *hdr;
> +       struct virtio_net_hdr_v1_hash *hdr_hash;
> +       enum pkt_hash_types rss_hash_type;
>
>         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                 pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1177,6 +1179,29 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>                 return;
>
>         hdr = skb_vnet_hdr(skb);
> +       if (vi->has_rss_hash_report && (dev->features & NETIF_F_RXHASH)) {
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
>
>         if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>                 skb->ip_summed = CHECKSUM_UNNECESSARY;
> @@ -2250,6 +2275,132 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
>         netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
>  }
>
> +void virtnet_get_hashflow(const struct virtnet_info *vi, struct ethtool_rxnfc *info)
> +{
> +       info->data = 0;
> +       switch (info->flow_type) {
> +       case TCP_V4_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_TCPv4) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST |
> +                                                RXH_L4_B_0_1 | RXH_L4_B_2_3;
> +               } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +               }
> +               break;
> +       case TCP_V6_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_TCPv6) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST |
> +                                                RXH_L4_B_0_1 | RXH_L4_B_2_3;
> +               } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv6) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +               }
> +               break;
> +       case UDP_V4_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_UDPv4) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST |
> +                                                RXH_L4_B_0_1 | RXH_L4_B_2_3;
> +               } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +               }
> +               break;
> +       case UDP_V6_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_UDPv6) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST |
> +                                                RXH_L4_B_0_1 | RXH_L4_B_2_3;
> +               } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv6) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +               }
> +               break;
> +       case IPV4_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +
> +               break;
> +       case IPV6_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +
> +               break;
> +       default:
> +               info->data = 0;
> +               break;
> +       }
> +}
> +
> +bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *info)
> +{
> +       u64 is_iphash = info->data & (RXH_IP_SRC | RXH_IP_DST);
> +       u64 is_porthash = info->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3);
> +       u32 new_hashtypes = vi->rss_hash_types_saved;
> +
> +       if ((is_iphash && (is_iphash != (RXH_IP_SRC | RXH_IP_DST))) ||
> +           (is_porthash && (is_porthash != (RXH_L4_B_0_1 | RXH_L4_B_2_3)))) {
> +               return false;
> +       }
> +
> +       if (!is_iphash && is_porthash)
> +               return false;
> +
> +       switch (info->flow_type) {
> +       case TCP_V4_FLOW:
> +       case UDP_V4_FLOW:
> +       case IPV4_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> +               if (is_iphash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> +
> +               break;
> +       case TCP_V6_FLOW:
> +       case UDP_V6_FLOW:
> +       case IPV6_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> +               if (is_iphash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> +
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       switch (info->flow_type) {
> +       case TCP_V4_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_TCPv4;
> +               if (is_porthash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_TCPv4;
> +
> +               break;
> +       case UDP_V4_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_UDPv4;
> +               if (is_porthash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_UDPv4;
> +
> +               break;
> +       case TCP_V6_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_TCPv6;
> +               if (is_porthash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_TCPv6;
> +
> +               break;
> +       case UDP_V6_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_UDPv6;
> +               if (is_porthash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_UDPv6;
> +
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (new_hashtypes != vi->rss_hash_types_saved) {
> +               vi->rss_hash_types_saved = new_hashtypes;
> +               vi->ctrl->rss.table_info.hash_types = vi->rss_hash_types_saved;
> +               if (vi->dev->features & NETIF_F_RXHASH)
> +                       return virtnet_commit_rss_command(vi);
> +       }
> +
> +       return true;
> +}
> +
>  static void virtnet_get_drvinfo(struct net_device *dev,
>                                 struct ethtool_drvinfo *info)
>  {
> @@ -2530,8 +2681,28 @@ int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *r
>         switch (info->cmd) {
>         case ETHTOOL_GRXRINGS:
>                 info->data = vi->curr_queue_pairs;
> +               break;
> +       case ETHTOOL_GRXFH:
> +               virtnet_get_hashflow(vi, info);
> +               break;
> +       default:
>                 rc = -EOPNOTSUPP;
>         }
> +
> +       return rc;
> +}
> +
> +static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
> +{
> +       struct virtnet_info *vi = netdev_priv(dev);
> +       int rc = 0;
> +
> +       switch (info->cmd) {
> +       case ETHTOOL_SRXFH:
> +               if (!virtnet_set_hashflow(vi, info))
> +                       rc = -EINVAL;
> +
> +               break;
>         default:
>                 rc = -EOPNOTSUPP;
>         }
> @@ -2559,6 +2730,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>         .get_rxfh = virtnet_get_rxfh,
>         .set_rxfh = virtnet_set_rxfh,
>         .get_rxnfc = virtnet_get_rxnfc,
> +       .set_rxnfc = virtnet_set_rxnfc,
>  };
>
>  static void virtnet_freeze_down(struct virtio_device *vdev)
> @@ -3351,8 +3523,13 @@ static int virtnet_probe(struct virtio_device *vdev)
>         if (vi->has_rss || vi->has_rss_hash_report) {
>                 vi->rss_hash_types_supported =
>                     virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> +               vi->rss_hash_types_supported &=
> +                               ~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> +                                 VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> +                                 VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
>
>                 dev->hw_features |= NETIF_F_RXHASH;
> +               dev->features |= NETIF_F_NTUPLE;

I think we don't support ntuple filters but hash filters?

Thanks

>         }
>
>         if (vi->has_cvq && vi->has_rss_hash_report)
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
