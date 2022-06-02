Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AFAC43334
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 07:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E7EE607C0;
	Thu,  2 Jun 2022 07:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ub_gEW9AMJwC; Thu,  2 Jun 2022 07:36:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 47F6B607CA;
	Thu,  2 Jun 2022 07:36:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16377C0039;
	Thu,  2 Jun 2022 07:36:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66051C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43305409B2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:36:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JeYe1BFrW7X9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:36:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4648E409A4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654155396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l00IQqB81+H5bP30hrUtm+oNhTBjm7YmLlYdO4/7FSE=;
 b=NZ7iN0uGh7/5pXUUVPOhWfznBD6f9V7ZullEQFitB/J4t/HDa0HmFabB12NiVgFWO081Yv
 6XZgDBDJ196/XnUy9GLQ8OUjmb0SNJUcC6wzCFaueb6lR6fCP7rBRxYMC7/yubYnEDBl76
 bCRLMvDnJAYhPMVnTGh1P1DYf+/eoio=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-zo5BsgRuPyiTMUuWN0_ZQg-1; Thu, 02 Jun 2022 03:36:35 -0400
X-MC-Unique: zo5BsgRuPyiTMUuWN0_ZQg-1
Received: by mail-yb1-f200.google.com with SMTP id
 70-20020a250249000000b0065cbf886b23so3476923ybc.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Jun 2022 00:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l00IQqB81+H5bP30hrUtm+oNhTBjm7YmLlYdO4/7FSE=;
 b=xCw5dl22VY3/610sQ+FZn0uofxXrBaBSu5POHuge5zopw2dO8khzX/Es98VegPAJeB
 jGtKsQjrkjoG4MGF6VZH+DsPSnul8lmmfrmQw6TANXOi/I+TopgwCMvZoKrFRrCu0kqg
 a+O2ODx0UpeXj17vKhMJaUZHKihWM5xm/KojKDlsHvcsLitCh0S2cb/TM2b1Gr114+31
 ZBN6ZG/tnFv4Lem4NIgrtnRSj2+RwhRtLWPFov1TX4BJ+RuwLBXpvcZBk4TYYie1hGFI
 LWi8E/hBPQDKrY7zh6mYCNp61SUTRatt32U5Q2l6teRwfN7oBlFGp6im9IH/BnbDK3fo
 JtSw==
X-Gm-Message-State: AOAM532h3yFzyplYwLTHrxiqT8GGSe43L5wofjcq04kjAep6Ov2zxeg3
 kTr0x+nm7lShqoPh1d6naVInPOcEhSNCW7DpkmJR3L2uJJCfCeY0aGDk1R+mJsbhvqCFqwmb4nJ
 khasq4BS96A5l+IMkya9JAbBI9XxsbxD7nFVy5igM2VvaZwo0uhfTQCP3Fg==
X-Received: by 2002:a25:bac7:0:b0:64c:b780:90d3 with SMTP id
 a7-20020a25bac7000000b0064cb78090d3mr3890101ybk.10.1654155394622; 
 Thu, 02 Jun 2022 00:36:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLZvnLYAkQE0UJGJ91nxExuoLuGjC7sOLRQk6mmI/a6gfxOle0c8YveJkKocH1JNYmkjISxYhsm6RLPDM/jXM=
X-Received: by 2002:a25:bac7:0:b0:64c:b780:90d3 with SMTP id
 a7-20020a25bac7000000b0064cb78090d3mr3890093ybk.10.1654155394417; Thu, 02 Jun
 2022 00:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220602023845.2596397-1-lingshan.zhu@intel.com>
 <20220602023845.2596397-5-lingshan.zhu@intel.com>
In-Reply-To: <20220602023845.2596397-5-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jun 2022 15:36:23 +0800
Message-ID: <CACGkMEtzHB9e9fgQ=t9vT1iz6A9t46hsEMmpHghQSTSfhr7kuw@mail.gmail.com>
Subject: Re: [PATCH 4/6] vDPA: !FEATURES_OK should not block querying device
 config space
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
> Users may want to query the config space of a vDPA device,
> to choose a appropriate one for a certain guest. This means the
> users need to read the config space before FEATURES_OK, and
> the existence of config space contents does not depend on
> FEATURES_OK.

Quotes from the spec:

"The device MUST allow reading of any device-specific configuration
field before FEATURES_OK is set by the driver. This includes fields
which are conditional on feature bits, as long as those feature bits
are offered by the device."

>
> This commit removes FEATURES_OK blocker in vdpa_dev_config_fill()
> which calls vdpa_dev_net_config_fill() for virtio-net
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index c820dd2b0307..030d96bdeed2 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -863,17 +863,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>  {
>         u32 device_id;
>         void *hdr;
> -       u8 status;
>         int err;
>
>         mutex_lock(&vdev->cf_mutex);
> -       status = vdev->config->get_status(vdev);
> -       if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> -               NL_SET_ERR_MSG_MOD(extack, "Features negotiation not completed");
> -               err = -EAGAIN;
> -               goto out;
> -       }

So we had the following in vdpa_dev_net_config_fill():

        features = vdev->config->get_driver_features(vdev);
        if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
                              VDPA_ATTR_PAD))
                return -EMSGSIZE;

It looks to me we need to switch to using get_device_features() instead.

Thanks

> -
>         hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>                           VDPA_CMD_DEV_CONFIG_GET);
>         if (!hdr) {
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
