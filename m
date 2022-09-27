Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BF1C07E9D
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 04:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C75360F95;
	Tue, 27 Sep 2022 04:39:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C75360F95
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ObVpW/8v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TTMYwvFI7XtY; Tue, 27 Sep 2022 04:39:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 11023606ED;
	Tue, 27 Sep 2022 04:39:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11023606ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C22F7C0032;
	Tue, 27 Sep 2022 04:39:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18CE3C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA456405E3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:39:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA456405E3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ObVpW/8v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 406zYfIc5Uvf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:39:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EC46400C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3EC46400C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664253541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UUYySdokudzYAu/PwShHz0v/wpwcIfbDjXPzc5w9Z/8=;
 b=ObVpW/8v5vr27ITirxsec6tCRIstFkB130WWFhdvJvmo8B4dtp6V2A9N/kAFOcSrsI3Jy9
 OQotv0jlG/4XnOS4oDGpeTogORq7in1NH1IcgFzViZxhfzhV5QASZ3iixQU0tp1Ox8JJr6
 JFMtqLLECz3XkGuCoA8o8zzOuZwS99M=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-31-nVOLfDTRMeSUlb_P-V8W-A-1; Tue, 27 Sep 2022 00:38:59 -0400
X-MC-Unique: nVOLfDTRMeSUlb_P-V8W-A-1
Received: by mail-ot1-f72.google.com with SMTP id
 t4-20020a9d7484000000b006585c2ad6a0so4175208otk.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 21:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=UUYySdokudzYAu/PwShHz0v/wpwcIfbDjXPzc5w9Z/8=;
 b=DyNsqj+ghaNFc5IFNPFTCSxHYG3zp4kaGtBrQ413mMWz2P/kANP0aOm2FI6WIBfdYu
 mLpuSJvFY8JJQmxcJg4o7gf4/E0EaLmyU9GMQRXsmKvLt6XFS5NVkxrTVlQc7P3LAEL1
 FBowlkPmOSTqr9IXJnEodlv7gU7dXngnRYKsxUwbsetamSJPrdVQxdnMS3eFXb7l7riC
 41BWsqI5s0ORHG448LhGTPtzfsjqW32Uf43T9WIGE1+sdUZVOOoQbuxWRqv5HAONhdN4
 ReqwUYzTwReE7ElU7Iax6PHWnisYj/MjGfi4EAyRXioik8Hme3cHQKclwMcyd02jOI4E
 F34g==
X-Gm-Message-State: ACrzQf3Jt+T/QQJ/4CS3os+HFjP3KvL2nrntDIHA18ZNcAVU0tNlIY0T
 S+Vppxn07k8oXfX2PgdgChcJtcl4FUAxGXZ2pRYvQlQ+Tr5+XqDh/nrs6D5WqZBFXzWq67ofESm
 11127N38oxcJrmKyhOi6lba0aI4VoHRWhBAYRWVQg8ZdQOlX+0nk52RG8JA==
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr948387oib.35.1664253538579; 
 Mon, 26 Sep 2022 21:38:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6dtWDIDMFMsm1TLAUpFC0nEqOJfRQrv1Inh+yp5FeOdRtNy1OaIjtWjmVbiQUn0wRzZTkbR7IWTxa32X2nA7Y=
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr948382oib.35.1664253538380; Mon, 26
 Sep 2022 21:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220927030117.5635-1-lingshan.zhu@intel.com>
 <20220927030117.5635-6-lingshan.zhu@intel.com>
In-Reply-To: <20220927030117.5635-6-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Sep 2022 12:38:47 +0800
Message-ID: <CACGkMEtBQr9ZSdN0WUxEZ7wHb5ikpyheVAjfbiPSDRM8SqHhcQ@mail.gmail.com>
Subject: Re: [PATCH V2 RESEND 5/6] vDPA: fix spars cast warning in
 vdpa_dev_net_mq_config_fill
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, mst@redhat.com
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

On Tue, Sep 27, 2022 at 11:10 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> This commit fixes spars warnings: cast to restricted __le16
> in function vdpa_dev_net_mq_config_fill()
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 84a0c3877d7c..fa7f65279f79 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -809,7 +809,8 @@ static int vdpa_dev_net_mq_config_fill(struct sk_buff *msg, u64 features,
>             (features & BIT_ULL(VIRTIO_NET_F_RSS)) == 0)
>                 return 0;
>
> -       val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
> +       val_u16 = __virtio16_to_cpu(true, config->max_virtqueue_pairs);
> +
>         return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
>  }
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
