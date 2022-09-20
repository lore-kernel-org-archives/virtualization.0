Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B87C6FA82
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 02:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2ED8C4177F;
	Tue, 20 Sep 2022 02:17:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2ED8C4177F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IBQchELG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UZ1LehvWITCe; Tue, 20 Sep 2022 02:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4D1894175D;
	Tue, 20 Sep 2022 02:17:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D1894175D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31947C0032;
	Tue, 20 Sep 2022 02:17:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D39BCC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADBB282438
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADBB282438
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IBQchELG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ZIE9ySRkB2i
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:17:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 781EB82437
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 781EB82437
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663640249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tVCH3EQNWqSiJDgyHq2+Ujl+8EWbJfikiqyIrXZgBBQ=;
 b=IBQchELGUSzwQV+2PYDmwcs4/L5MVmh4Azy9T0yQJA9WVPoMqbVGe1AbF8QTCC5OAfCrcB
 v8uh7hRu0Ydh9iN9EOsIgdUGmQ3j1zI1S+TpzT2+5sLXZ48luUo0L7ZagAX019vbPt1v37
 nGdjXEckDUGcepCYgUz5PrA7YVI9hdU=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-7-idEBWLv8PV2kGuVuQjdncQ-1; Mon, 19 Sep 2022 22:17:28 -0400
X-MC-Unique: idEBWLv8PV2kGuVuQjdncQ-1
Received: by mail-vs1-f72.google.com with SMTP id
 k12-20020a67ef4c000000b00398774a1c52so318032vsr.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 19:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=tVCH3EQNWqSiJDgyHq2+Ujl+8EWbJfikiqyIrXZgBBQ=;
 b=nEuDXf4qOFeyB+9SiflTJsxb6MOuTDqlxrnkPlLYxvTFJca5xRGBMrJjNWLkR1gFva
 QmhIinFXJZdApeM6EVHJm70G7/h5Bc9lh11XhXk9NEZ/B4+Xcq4V3V09J9PLg8sDiScT
 mkFfMXyw05k0whssWurq4hUhGoolXGOrg8hacId9icy6XoW9I4X/qyWFuRozNscRd9Gx
 UIE1OvFDl9wNC0rMq0Xx2WVnxbhJvPYayUPPwPAyCmlipv7ae1wbykltN4I9cTbrnShx
 KOFoA+tbPpBKr2/8XwJp6KPbbPLUVOKUhZJN4cETs9DV9Jwxu5bnorV1ETRRd/mCBWRM
 SsHA==
X-Gm-Message-State: ACrzQf3X30u8v4MhFiwIndHTXQ+tovpu1rfxrgXsj6I6IPCcE3OKrIeB
 ZSRzgoF2pB1rbUf7XQN2gNac32TGtADwPvmwI3tNgcdb9458Bqyet4T17qkUFNLdGh7qvwmlPRh
 AOB77CMrxM4E7+67PVVXx+VBCCDDp76DXvVj3DaExhpM8jYhDupqEaLssdQ==
X-Received: by 2002:a1f:9cc5:0:b0:3a2:bd20:8fc6 with SMTP id
 f188-20020a1f9cc5000000b003a2bd208fc6mr7123772vke.22.1663640247366; 
 Mon, 19 Sep 2022 19:17:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4mWq5eT7AaXAQ7qFJ/OxyfUSXqtfTWp3+HqW/hPsRN4Q3Epwcu7sGV69XwzMKFpw5UU8UDgsDN14/VW5xjOcQ=
X-Received: by 2002:a1f:9cc5:0:b0:3a2:bd20:8fc6 with SMTP id
 f188-20020a1f9cc5000000b003a2bd208fc6mr7123766vke.22.1663640247184; Mon, 19
 Sep 2022 19:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220909085712.46006-1-lingshan.zhu@intel.com>
 <20220909085712.46006-4-lingshan.zhu@intel.com>
In-Reply-To: <20220909085712.46006-4-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Sep 2022 10:17:16 +0800
Message-ID: <CACGkMEsjMotoSqukdzcCrQu-P8H1MxnVrC8LGCXiRQegLT7gJg@mail.gmail.com>
Subject: Re: [PATCH 3/4] vDPA: check VIRTIO_NET_F_RSS for max_virtqueue_paris's
 presence
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>
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

On Fri, Sep 9, 2022 at 5:05 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> virtio 1.2 spec says:
> max_virtqueue_pairs only exists if VIRTIO_NET_F_MQ or
> VIRTIO_NET_F_RSS is set.
>
> So when reporint MQ to userspace, it should check both
> VIRTIO_NET_F_MQ and VIRTIO_NET_F_RSS.
>
> This commit also fixes:
> 1) a spase warning by replacing le16_to_cpu with __virtio16_to_cpu.
> 2) vdpa_dev_net_mq_config_fill() should checks device features
> for MQ than driver features.
> 3) struct vdpa_device *vdev is not needed for
> vdpa_dev_net_mq_config_fill(), unused.

Let's do those in separate patches please.

Thanks

>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 29d7e8858e6f..f8ff61232421 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -801,16 +801,17 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>         return msg->len;
>  }
>
> -static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> -                                      struct sk_buff *msg, u64 features,
> +static int vdpa_dev_net_mq_config_fill(struct sk_buff *msg, u64 features,
>                                        const struct virtio_net_config *config)
>  {
>         u16 val_u16;
>
> -       if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
> +       if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0 &&
> +           (features & BIT_ULL(VIRTIO_NET_F_RSS)) == 0)
>                 return 0;
>
> -       val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
> +       val_u16 = __virtio16_to_cpu(true, config->max_virtqueue_pairs);
> +
>         return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
>  }
>
> @@ -851,7 +852,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>                               VDPA_ATTR_PAD))
>                 return -EMSGSIZE;
>
> -       return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver, &config);
> +       return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>  }
>
>  static int
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
