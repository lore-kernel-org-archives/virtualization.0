Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ADBC433EF
	for <virtualization@archiver.kernel.org>; Sun, 13 Feb 2022 17:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22E6D80D74;
	Sun, 13 Feb 2022 17:08:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVmU9aIeZlaQ; Sun, 13 Feb 2022 17:08:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 81EB880C01;
	Sun, 13 Feb 2022 17:08:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 610BDC001A;
	Sun, 13 Feb 2022 17:08:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AD11C000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 17:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DC8860706
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 17:08:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H1z0Np4gkqMN
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 17:08:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 104D3600BB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 17:08:33 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id 4so15089998oil.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ddTopwiOGudbD9c0a1S+23MlMo36ot+qZJddmpaLkno=;
 b=10QNQxhBItsEVnI9uWuTdUg1N8XxitvYvB6ISMdKdA6/icQ88LLUBFxcdcPqR+6zs2
 xBfa9AWa1Sr7eef5v45RJnVrvCkVoSzxtqCXLx+N/rWMUOpMRjX/NNMdJXc3PQ5+uwEU
 J4zuED6wDY5ShU6pzYHB/wrfHTXWpNNsJ64I8n4n5oImdktZTLA3OpZ+Lf/GZZiWDS4l
 pxq7L0rYCQl6hK0OnvvEdfYwo7o6KYl/UUHc7R8XIudFXKwadJKgtJRhCbb6VL+qgqkH
 j0WuFjrsfd0eSptRIbcptITiXIS+jxSkG3VzZzx0nFvQ70+lZoN6nqXTo/WXmCTN5+QQ
 6/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ddTopwiOGudbD9c0a1S+23MlMo36ot+qZJddmpaLkno=;
 b=Qv1funNCTX+uEjAl/B7Rxoc6KcIp0DGJFEKvMQdK48O5DPTBLIIzyXLo6p1Xbj9X4m
 eicPJ7je6pnUe+n3koA5oxVJcg+mrydNfxn5x/wUxPWbbNOBrQaPwoo4yYjzJ55lziRK
 Z619JB26V9Y/nwMxJ5GkS9gGTaKUVo7LKzeDRhUVG5C+LU/UJH9r0slP0mEX5rOUGAdI
 55tj9rTCOhlvsk5TolCIjdk896+zWq8XNod0U3H0WHK6K5Y/6tuBnDH7nNma5I0+EgKO
 uglv596RCQw6VJY+bcVFijQLeEcUN0bjXsWe4O5Rz+HrwtOq/1RtYYCyW9VcOWjlgpDD
 bUGQ==
X-Gm-Message-State: AOAM530eoU5ijx5eFRraYWiGqcaMAdWZd33x12JSxoNQR6S4juQ225pr
 zH2+Ewp1xAkUt+cuq8Gp2fJj98lmXVzGMCsDZL9aAQ==
X-Google-Smtp-Source: ABdhPJx6F8OPpe1PPrZyszS/d8TyHzUHd9dKhENhV4//VQzt2tEHJaVAXRekVPgnJuRKyRH5j6Wzt0gKKGcEGFpF318=
X-Received: by 2002:a05:6808:1206:: with SMTP id
 a6mr4162215oil.279.1644772112850; 
 Sun, 13 Feb 2022 09:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20220208181510.787069-1-andrew@daynix.com>
 <20220208181510.787069-4-andrew@daynix.com>
 <CA+FuTSdrHwNWh1Mz7KT8w+Z69LcNipeTcasny6ioqOUYBisNXg@mail.gmail.com>
In-Reply-To: <CA+FuTSdrHwNWh1Mz7KT8w+Z69LcNipeTcasny6ioqOUYBisNXg@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Sun, 13 Feb 2022 19:08:21 +0200
Message-ID: <CABcq3pFpP1OkbsmZpMuM53DNSRo94uS9DLQ_8JVmuO0rJuRN_w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drivers/net/virtio_net: Added RSS hash report.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

Hi all,

On Tue, Feb 8, 2022 at 10:55 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Tue, Feb 8, 2022 at 1:19 PM Andrew Melnychenko <andrew@daynix.com> wrote:
> >
> > Added features for RSS hash report.
> > If hash is provided - it sets to skb.
> > Added checks if rss and/or hash are enabled together.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 44 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 495aed524e33..543da2fbdd2d 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -227,6 +227,7 @@ struct virtnet_info {
> >
> >         /* Host supports rss and/or hash report */
> >         bool has_rss;
> > +       bool has_rss_hash_report;
> >         u8 rss_key_size;
> >         u16 rss_indir_table_size;
> >         u32 rss_hash_types_supported;
> > @@ -421,7 +422,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> >
> >         hdr_len = vi->hdr_len;
> >         if (vi->mergeable_rx_bufs)
> > -               hdr_padded_len = sizeof(*hdr);
> > +               hdr_padded_len = hdr_len;
>
> Belongs in patch 1?

Yeah, I'll move it.

>
> >         else
> >                 hdr_padded_len = sizeof(struct padded_vnet_hdr);
> >
> > @@ -1156,6 +1157,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >         struct net_device *dev = vi->dev;
> >         struct sk_buff *skb;
> >         struct virtio_net_hdr_mrg_rxbuf *hdr;
> > +       struct virtio_net_hdr_v1_hash *hdr_hash;
> > +       enum pkt_hash_types rss_hash_type;
> >
> >         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >                 pr_debug("%s: short packet %i\n", dev->name, len);
> > @@ -1182,6 +1185,29 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >                 return;
> >
> >         hdr = skb_vnet_hdr(skb);
> > +       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report) {
>
> Can the first be true if the second is not?

Yes, RSS may be enabled, but the hash report feature is disabled.
For now, it's possible to enable/disable VirtioNet RSS by manipulating RXHASH.

>
> > +               hdr_hash = (struct virtio_net_hdr_v1_hash *)(hdr);
> > +
> > +               switch (hdr_hash->hash_report) {
> > +               case VIRTIO_NET_HASH_REPORT_TCPv4:
> > +               case VIRTIO_NET_HASH_REPORT_UDPv4:
> > +               case VIRTIO_NET_HASH_REPORT_TCPv6:
> > +               case VIRTIO_NET_HASH_REPORT_UDPv6:
> > +               case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > +               case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > +                       rss_hash_type = PKT_HASH_TYPE_L4;
> > +                       break;
> > +               case VIRTIO_NET_HASH_REPORT_IPv4:
> > +               case VIRTIO_NET_HASH_REPORT_IPv6:
> > +               case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > +                       rss_hash_type = PKT_HASH_TYPE_L3;
> > +                       break;
> > +               case VIRTIO_NET_HASH_REPORT_NONE:
> > +               default:
> > +                       rss_hash_type = PKT_HASH_TYPE_NONE;
> > +               }
> > +               skb_set_hash(skb, hdr_hash->hash_value, rss_hash_type);
> > +       }
>
> so many lines, perhaps deserves a helper function

Ok, I'll create the helper.

>
> >
> >         if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >                 skb->ip_summed = CHECKSUM_UNNECESSARY;
> > @@ -2232,7 +2258,8 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
> >         sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
> >
> >         if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
> > -                                 VIRTIO_NET_CTRL_MQ_RSS_CONFIG, sgs)) {
> > +                                 vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
> > +                                 : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
> >                 dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
> >                 return false;
> >         }
> > @@ -3230,6 +3257,8 @@ static bool virtnet_validate_features(struct virtio_device *vdev)
> >              VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR,
> >                              "VIRTIO_NET_F_CTRL_VQ") ||
> >              VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_RSS,
> > +                            "VIRTIO_NET_F_CTRL_VQ") ||
> > +            VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_HASH_REPORT,
> >                              "VIRTIO_NET_F_CTRL_VQ"))) {
> >                 return false;
> >         }
> > @@ -3365,8 +3394,13 @@ static int virtnet_probe(struct virtio_device *vdev)
> >         if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> >                 vi->mergeable_rx_bufs = true;
> >
> > -       if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
> > +       if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
> > +               vi->has_rss_hash_report = true;
> > +
> > +       if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> >                 vi->has_rss = true;
> > +
> > +       if (vi->has_rss || vi->has_rss_hash_report) {
> >                 vi->rss_indir_table_size =
> >                         virtio_cread16(vdev, offsetof(struct virtio_net_config,
>
> should indir table size be zero if only hash report is enabled?

Not really - but of course, for hash only, the table is not necessary.
(Qemu always provides the table with size 1, I'll add checks for zero sizes
in case of hardware implementation.)

>
> >                                 rss_max_indirection_table_length));
> > @@ -3382,8 +3416,11 @@ static int virtnet_probe(struct virtio_device *vdev)
> >
> >                 dev->hw_features |= NETIF_F_RXHASH;
> >         }
> > -       if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> > -           virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> > +
> > +       if (vi->has_rss_hash_report)
> > +               vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
> > +       else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> > +                virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> >                 vi->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
> >         else
> >                 vi->hdr_len = sizeof(struct virtio_net_hdr);
> > @@ -3450,7 +3487,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> >                 }
> >         }
> >
> > -       if (vi->has_rss)
> > +       if (vi->has_rss || vi->has_rss_hash_report)
> >                 virtnet_init_default_rss(vi);
> >
> >         err = register_netdev(dev);
> > @@ -3585,7 +3622,7 @@ static struct virtio_device_id id_table[] = {
> >         VIRTIO_NET_F_CTRL_MAC_ADDR, \
> >         VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> >         VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> > -       VIRTIO_NET_F_RSS
> > +       VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT
> >
> >  static unsigned int features[] = {
> >         VIRTNET_FEATURES,
> > --
> > 2.34.1
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
