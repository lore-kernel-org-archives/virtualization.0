Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA312CCA47D
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 07:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97D6D40526;
	Thu,  2 Jun 2022 07:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 198Y3P6d_MpV; Thu,  2 Jun 2022 07:40:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 31E804026F;
	Thu,  2 Jun 2022 07:40:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFE58C0032;
	Thu,  2 Jun 2022 07:40:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04432C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F11BC409EA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o6VsrrFMG4r9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:40:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E79E1409B2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654155648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H3rUL7ZZeT2JwdmclqqOS1FGxkIH/lrh6coXqnJEDkk=;
 b=WKw/XvvUecXTSiCh/kdiQdcPvtecXxPjss5wsIIjtjWS9iGCV5VlPowPDkSmgzw5b6QUlN
 KqiOPsFud0iZyUlEA208mPWS0HJ+wQU3oaTM+DZkW0MfhHxM/xZDHodfOkrvY3alCamuF2
 8Ia7c5Cz00YmdRlsWb/cYZpFWQlhpR4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-GhK5FWftMeOOtiR-OLig_g-1; Thu, 02 Jun 2022 03:40:47 -0400
X-MC-Unique: GhK5FWftMeOOtiR-OLig_g-1
Received: by mail-lf1-f72.google.com with SMTP id
 s12-20020a056512202c00b00478f00fcb3dso2162756lfs.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Jun 2022 00:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H3rUL7ZZeT2JwdmclqqOS1FGxkIH/lrh6coXqnJEDkk=;
 b=R0sBwiwwx3IeIq8Ym1c17Yul9YjWLV7Lc1Q1svjJdWzHAniMaOuik4V3YjqOtuGk56
 E6HZZk6PXoHOyiE/5jgBqtMx5ZwOzsTQ2V4MCHigFRzuJX6+ZbNehqwiKI03rw7HXfud
 I2xghUfZeK5IFbMML4GPYHNEb8anfoSsWnfa9P2KOIP+WSJMTIByL3o7w58rQub4xhTK
 6qIyhEjsHll48Y9aGVDXBpuDtN+nhSpS1HR6UKAbi4/t5Cbcq9csHZPqjq2zvhGzDWpb
 RfRoW7JTYJWV9nr5uB0EoKsiXE366S2wM8Si8qK15t9h4ZOWI8M9uNwqn2bVEPQX2nrs
 gZ3Q==
X-Gm-Message-State: AOAM532gBQZsc9LHZARDFNc661F8Epj4Hvx4jop7d2/1Fnm729C/rBA/
 Hv3TWcu8jandkkxaMYGcLrF/MQhhuaqEtZg62LfWE0dExu8WaZBpLA07bCL0AO4NwaHwhxjEkpU
 aH+6Y+lfpQDflAq8Er6YIaETzfePkSfRzE7ZYIsxqBU7fwE54nh37RPFcqA==
X-Received: by 2002:a2e:8752:0:b0:255:6df7:7ad5 with SMTP id
 q18-20020a2e8752000000b002556df77ad5mr3614644ljj.73.1654155646303; 
 Thu, 02 Jun 2022 00:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmmX7LWMurM60IlJrSEEDX4JnlvIsnNorPLL0O33CXCEcRX5d60Fd6hXV3QcY0b++HGPrddNlzyUhtSmsEZag=
X-Received: by 2002:a2e:8752:0:b0:255:6df7:7ad5 with SMTP id
 q18-20020a2e8752000000b002556df77ad5mr3614632ljj.73.1654155646126; Thu, 02
 Jun 2022 00:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220602023845.2596397-1-lingshan.zhu@intel.com>
 <20220602023845.2596397-7-lingshan.zhu@intel.com>
In-Reply-To: <20220602023845.2596397-7-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jun 2022 15:40:35 +0800
Message-ID: <CACGkMEtS6W8wXdrXbQuniZ-ox1WsCAc1UQHJGD=J4PViviQYpA@mail.gmail.com>
Subject: Re: [PATCH 6/6] vDPA: fix 'cast to restricted le16' warnings in
 vdpa_dev_net_config_fill()
To: Zhu Lingshan <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

On Thu, Jun 2, 2022 at 10:48 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> This commit fixes spars warnings: cast to restricted __le16
> in function vdpa_dev_net_config_fill()
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 50a11ece603e..2719ce9962fc 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -837,11 +837,11 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>                     config.mac))
>                 return -EMSGSIZE;
>
> -       val_u16 = le16_to_cpu(config.status);
> +       val_u16 = le16_to_cpu((__force __le16)config.status);

Can we use virtio accessors like virtio16_to_cpu()?

Thanks

>         if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
>                 return -EMSGSIZE;
>
> -       val_u16 = le16_to_cpu(config.mtu);
> +       val_u16 = le16_to_cpu((__force __le16)config.mtu);
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>                 return -EMSGSIZE;
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
