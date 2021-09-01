Return-Path: <SRS0=XZyc=NX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DE9C4320E
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 07:35:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB3960F92
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 07:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABB3960F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AA6D404FB;
	Wed,  1 Sep 2021 07:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iG27SOPrzcmg; Wed,  1 Sep 2021 07:35:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0E6B3404E0;
	Wed,  1 Sep 2021 07:35:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9054C001A;
	Wed,  1 Sep 2021 07:35:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC9C7C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 07:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6B9C60638
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 07:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tLG-JNLb0st5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 07:35:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55B486062C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 07:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630481726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s+ump4GqwhE3Q2452iXIzElbFXvnHKp47scqPabSYj0=;
 b=Iff8F1AlFrEjEFgg4ffFig3UbwLkUSh649xixIKPnf6L3suKeayDTLeUqXQ+TmrZWzNq1E
 aizXkJ1DnEKOY95cxeCyFhpIFA+6jl/9jN+xS2dp3h9+z1Axgng/GJFqimAQqkSIY6ZhEK
 og0W0GxD1KxpZMETfFNPPAzS4diOofc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-aOsitFraP6GRcY0WL6hgaw-1; Wed, 01 Sep 2021 03:35:25 -0400
X-MC-Unique: aOsitFraP6GRcY0WL6hgaw-1
Received: by mail-lj1-f199.google.com with SMTP id
 q9-20020a2e9689000000b001b964fa10b3so724943lji.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Sep 2021 00:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s+ump4GqwhE3Q2452iXIzElbFXvnHKp47scqPabSYj0=;
 b=lVDXSjeLHnmknlS8zrO07EHJP4BtlfWZ58RuynFOkneft0eTmQ6iCgzimvp1946hp2
 xrJWOSZ61MiRZeWOIMe9BeS3UGZ/3C0Wj3UYdYYQOQSpkYqWkJYEBSXWzmPzBwWI9pIt
 O8rQAAdkrIsNJcu8vKwNEaQ7yOKXLV+gIzHWh60yakcnGMK4kWDDAhbT5i9+me/w5VP9
 VwMxDWioi2mpC/89M7ldyomLVWf6z1LKUwAxBLYVmfn6ELKdXO98I8SoztHqPdIzEfn6
 Ah/LrD6ic8JrHsytUNbGNdVneElhMMoOzMAjI9T8ITl32KuyLY8qBExX34jCneWwp8b1
 RxAA==
X-Gm-Message-State: AOAM5314jqP/w0WYBR2X5DChv/v64lLzYHHVl7hMCPtmSaIC1nmU+xgR
 kREUEuaf+S1PsfKAbiyf8vSEs9MVKMvTi0DloNY1TMKJJfQ3pA381nqZVoZDPXu/sx3uHYQL8W1
 mNvaAMMF9dAlQjm9R3fFUgCg35vCNfvlELF4dtyyo5fF7lBNJxYHCZiSKKQ==
X-Received: by 2002:a05:6512:31d2:: with SMTP id
 j18mr10993913lfe.436.1630481723415; 
 Wed, 01 Sep 2021 00:35:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZlPHx+kBC2Bfdek6J7tJLLBBmGRceaIcjusutSFYx8YIyPx7BjDlEvhv6tx/wseeWlZqGEQxqHh1324M0WbM=
X-Received: by 2002:a05:6512:31d2:: with SMTP id
 j18mr10993895lfe.436.1630481723070; 
 Wed, 01 Sep 2021 00:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210818175440.128691-1-andrew@daynix.com>
 <20210818175440.128691-3-andrew@daynix.com>
In-Reply-To: <20210818175440.128691-3-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Sep 2021 15:35:11 +0800
Message-ID: <CACGkMEuf3La+xsXJTHAJuTMuMU6oKD81vH9tn4YvZ4zzw4irAA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] drivers/net/virtio_net: Added basic RSS support.
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
> Added features for RSS and RSS hash report.
> Added initialization, RXHASH feature and ethtool ops.
> By default RSS/RXHASH is disabled.
> Added ethtools ops to set key and indirection table.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/net/virtio_net.c | 215 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 203 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 85427b4f51bc..d87bde246305 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -167,6 +167,23 @@ struct receive_queue {
>         struct xdp_rxq_info xdp_rxq;
>  };
>
> +/* This structure can contain rss message with maximum settings for indirection table and keysize */
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> +#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128
> +struct virtio_net_ctrl_rss {
> +       struct {
> +               __le32 hash_types;
> +               __le16 indirection_table_mask;
> +               __le16 unclassified_queue;
> +       } __packed table_info;
> +       u16 indirection_table[VIRTIO_NET_RSS_MAX_TABLE_LEN];
> +       struct {
> +               u16 max_tx_vq; /* queues */
> +               u8 hash_key_length;
> +       } __packed key_info;
> +       u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +};


Any reason that those doesn't belong to uAPI?

And spec said:

"

The device MUST set rss_max_key_size to at least 40, if it offers
VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.

The device MUST set rss_max_indirection_table_length to at least 128,
if it offers VIRTIO_NET_F_RSS.

"

But it looks to me that you define those as maximum size instead of
minimum size?

> +
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
>         struct virtio_net_ctrl_hdr hdr;
> @@ -176,6 +193,7 @@ struct control_buf {
>         u8 allmulti;
>         __virtio16 vid;
>         __virtio64 offloads;
> +       struct virtio_net_ctrl_rss rss;
>  };
>
>  struct virtnet_info {
> @@ -204,6 +222,14 @@ struct virtnet_info {
>         /* Host will merge rx buffers for big packets (shake it! shake it!) */
>         bool mergeable_rx_bufs;
>
> +       /* Host supports rss and/or hash report */
> +       bool has_rss;
> +       bool has_rss_hash_report;
> +       u8 rss_key_size;
> +       u16 rss_indir_table_size;
> +       u32 rss_hash_types_supported;
> +       u32 rss_hash_types_saved;
> +
>         /* Has control virtqueue */
>         bool has_cvq;
>
> @@ -393,7 +419,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>         hdr_p = p;
>
>         hdr_len = vi->hdr_len;
> -       if (vi->mergeable_rx_bufs)
> +       if (vi->has_rss_hash_report)
> +               hdr_padded_len = sizeof(struct virtio_net_hdr_v1_hash);
> +       else if (vi->mergeable_rx_bufs)
>                 hdr_padded_len = sizeof(*hdr);
>         else
>                 hdr_padded_len = sizeof(struct padded_vnet_hdr);

I don't get here. You change the padder_vnet_hdr but here it was only
used for !non-mergeable ?


> @@ -2171,6 +2199,56 @@ static void virtnet_get_ringparam(struct net_device *dev,
>         ring->tx_pending = ring->tx_max_pending;
>  }
>
> +static bool virtnet_commit_rss_command(struct virtnet_info *vi)
> +{
> +       struct net_device *dev = vi->dev;
> +       struct scatterlist sgs[4];
> +       unsigned int sg_buf_size;
> +
> +       /* prepare sgs */
> +       sg_init_table(sgs, 4);
> +
> +       sg_buf_size = sizeof(vi->ctrl->rss.table_info);
> +       sg_set_buf(&sgs[0], &vi->ctrl->rss.table_info, sg_buf_size);
> +
> +       sg_buf_size = sizeof(uint16_t) * vi->rss_indir_table_size;
> +       sg_set_buf(&sgs[1], vi->ctrl->rss.indirection_table, sg_buf_size);
> +
> +       sg_buf_size = sizeof(vi->ctrl->rss.key_info);
> +       sg_set_buf(&sgs[2], &vi->ctrl->rss.key_info, sg_buf_size);
> +
> +       sg_buf_size = vi->rss_key_size;
> +       sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
> +
> +       if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
> +                                 vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
> +                                 : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
> +               dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
> +               return false;
> +       }
> +       return true;
> +}
> +
> +static void virtnet_init_default_rss(struct virtnet_info *vi)
> +{
> +       u32 indir_val = 0;
> +       int i = 0;
> +
> +       vi->ctrl->rss.table_info.hash_types = vi->rss_hash_types_supported;
> +       vi->rss_hash_types_saved = vi->rss_hash_types_supported;
> +       vi->ctrl->rss.table_info.indirection_table_mask = vi->rss_indir_table_size - 1;
> +       vi->ctrl->rss.table_info.unclassified_queue = 0;
> +
> +       for (; i < vi->rss_indir_table_size; ++i) {
> +               indir_val = ethtool_rxfh_indir_default(i, vi->max_queue_pairs);
> +               vi->ctrl->rss.indirection_table[i] = indir_val;
> +       }
> +
> +       vi->ctrl->rss.key_info.max_tx_vq = vi->curr_queue_pairs;
> +       vi->ctrl->rss.key_info.hash_key_length = vi->rss_key_size;
> +
> +       netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
> +}
>
>  static void virtnet_get_drvinfo(struct net_device *dev,
>                                 struct ethtool_drvinfo *info)
> @@ -2395,6 +2473,72 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>                 vi->duplex = duplex;
>  }
>
> +u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> +{
> +       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> +}
> +
> +u32 virtnet_get_rxfh_indir_size(struct net_device *dev)
> +{
> +       return ((struct virtnet_info *)netdev_priv(dev))->rss_indir_table_size;
> +}
> +
> +int virtnet_get_rxfh(struct net_device *dev, u32 *indir, u8 *key, u8 *hfunc)
> +{
> +       struct virtnet_info *vi = netdev_priv(dev);
> +       int i;
> +
> +       if (indir) {
> +               for (i = 0; i < vi->rss_indir_table_size; ++i)
> +                       indir[i] = vi->ctrl->rss.indirection_table[i];
> +       }
> +
> +       if (key)
> +               memcpy(key, vi->ctrl->rss.key, vi->rss_key_size);
> +
> +       if (hfunc)
> +               *hfunc = ETH_RSS_HASH_TOP;
> +
> +       return 0;
> +}
> +
> +int virtnet_set_rxfh(struct net_device *dev, const u32 *indir, const u8 *key, const u8 hfunc)
> +{
> +       struct virtnet_info *vi = netdev_priv(dev);
> +       int i;
> +
> +       if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
> +               return -EOPNOTSUPP;
> +
> +       if (indir) {
> +               for (i = 0; i < vi->rss_indir_table_size; ++i)
> +                       vi->ctrl->rss.indirection_table[i] = indir[i];
> +       }
> +       if (key)
> +               memcpy(vi->ctrl->rss.key, key, vi->rss_key_size);
> +
> +       virtnet_commit_rss_command(vi);
> +
> +       return 0;
> +}
> +
> +int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
> +{
> +       struct virtnet_info *vi = netdev_priv(dev);
> +       int rc = 0;
> +
> +       switch (info->cmd) {
> +       case ETHTOOL_GRXRINGS:
> +               info->data = vi->curr_queue_pairs;
> +               rc = -EOPNOTSUPP;
> +       }
> +       default:
> +               rc = -EOPNOTSUPP;
> +       }
> +
> +       return rc;
> +}
> +
>  static const struct ethtool_ops virtnet_ethtool_ops = {
>         .supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES,
>         .get_drvinfo = virtnet_get_drvinfo,
> @@ -2410,6 +2554,11 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>         .set_link_ksettings = virtnet_set_link_ksettings,
>         .set_coalesce = virtnet_set_coalesce,
>         .get_coalesce = virtnet_get_coalesce,
> +       .get_rxfh_key_size = virtnet_get_rxfh_key_size,
> +       .get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
> +       .get_rxfh = virtnet_get_rxfh,
> +       .set_rxfh = virtnet_set_rxfh,
> +       .get_rxnfc = virtnet_get_rxnfc,
>  };
>
>  static void virtnet_freeze_down(struct virtio_device *vdev)
> @@ -2662,6 +2811,16 @@ static int virtnet_set_features(struct net_device *dev,
>                 vi->guest_offloads = offloads;
>         }
>
> +       if ((dev->features ^ features) & NETIF_F_RXHASH) {
> +               if (features & NETIF_F_RXHASH)
> +                       vi->ctrl->rss.table_info.hash_types = vi->rss_hash_types_saved;
> +               else
> +                       vi->ctrl->rss.table_info.hash_types = 0;
> +
> +               if (!virtnet_commit_rss_command(vi))
> +                       return -EINVAL;
> +       }
> +
>         return 0;
>  }
>
> @@ -3080,13 +3239,14 @@ static int virtnet_probe(struct virtio_device *vdev)
>         u16 max_queue_pairs;
>         int mtu;
>
> -       /* Find if host supports multiqueue virtio_net device */
> -       err = virtio_cread_feature(vdev, VIRTIO_NET_F_MQ,
> -                                  struct virtio_net_config,
> -                                  max_virtqueue_pairs, &max_queue_pairs);
> +       /* Find if host supports multiqueue/rss virtio_net device */
> +       max_queue_pairs = 0;
> +       if (virtio_has_feature(vdev, VIRTIO_NET_F_MQ) || virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> +               max_queue_pairs =
> +                    virtio_cread16(vdev, offsetof(struct virtio_net_config, max_virtqueue_pairs));

I think virtio_cread_features() can still work here, or am I missing anything?

>
>         /* We need at least 2 queue's */
> -       if (err || max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> +       if (max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
>             max_queue_pairs > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
>             !virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
>                 max_queue_pairs = 1;
> @@ -3160,6 +3320,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>
>         INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>
> +       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
> +               vi->has_cvq = true;
> +
>         /* If we can receive ANY GSO packets, we must allocate large ones. */
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> @@ -3170,8 +3333,32 @@ static int virtnet_probe(struct virtio_device *vdev)
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>                 vi->mergeable_rx_bufs = true;
>
> -       if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> -           virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> +       if (vi->has_cvq && virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {

Let's add a new validation in virtnet_validate_features(), then
there's no need for the check of cvq here (and the moving of the
has_cvq assignment).


> +               vi->has_rss_hash_report = true;
> +               vi->rss_indir_table_size = 1;
> +               vi->rss_key_size = VIRTIO_NET_RSS_MAX_KEY_SIZE;
> +       }
> +
> +       if (vi->has_cvq && virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
> +               vi->has_rss = true;
> +               vi->rss_indir_table_size =
> +                       virtio_cread16(vdev, offsetof(struct virtio_net_config,
> +                                                     rss_max_indirection_table_length));
> +               vi->rss_key_size =
> +                       virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> +       }
> +
> +       if (vi->has_rss || vi->has_rss_hash_report) {
> +               vi->rss_hash_types_supported =
> +                   virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> +
> +               dev->hw_features |= NETIF_F_RXHASH;
> +       }
> +
> +       if (vi->has_cvq && vi->has_rss_hash_report)
> +               vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
> +       else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> +                virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>                 vi->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
>         else
>                 vi->hdr_len = sizeof(struct virtio_net_hdr);
> @@ -3180,9 +3367,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>             virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>                 vi->any_header_sg = true;
>
> -       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
> -               vi->has_cvq = true;
> -
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
>                 mtu = virtio_cread16(vdev,
>                                      offsetof(struct virtio_net_config,
> @@ -3254,6 +3438,12 @@ static int virtnet_probe(struct virtio_device *vdev)
>
>         virtnet_set_queues(vi, vi->curr_queue_pairs);
>
> +       if (vi->has_rss || vi->has_rss_hash_report) {
> +               rtnl_lock();
> +               virtnet_init_default_rss(vi);
> +               rtnl_unlock();
> +       }

I wonder what happens if the user sets a new RSS before this?

Thanks


> +
>         /* Assume link up if device can't report link status,
>            otherwise get link status from config. */
>         netif_carrier_off(dev);
> @@ -3369,7 +3559,8 @@ static struct virtio_device_id id_table[] = {
>         VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
>         VIRTIO_NET_F_CTRL_MAC_ADDR, \
>         VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> -       VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY
> +       VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> +       VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT
>
>  static unsigned int features[] = {
>         VIRTNET_FEATURES,
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
