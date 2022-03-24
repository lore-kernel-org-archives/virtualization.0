Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF3FC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 19:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAF9884333;
	Thu, 24 Mar 2022 19:54:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kMOHGOxh3ly8; Thu, 24 Mar 2022 19:54:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 76CF284309;
	Thu, 24 Mar 2022 19:54:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 215A0C001A;
	Thu, 24 Mar 2022 19:54:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06317C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 19:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E156A40165
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 19:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B4ZiWB6Fwa_l
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 19:54:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0140D4011A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 19:54:19 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id dr20so11316344ejc.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K9sl01AafDLfHeJ8+rUYL1jruEZ6Cs2sfqWkv5Qf36M=;
 b=kJbLa8fVZEm9Lomxaz580vFzf/vK0kM5gxcSSAlcYViTg3RoiXMMeXAUijr5uWypMX
 YF/k5dd42BjL/g0wTFXTLeTJhQXBeoSpv16UwXSYoApKghKarShWRBtnT/TakPd3lp1I
 kjCD+CQJ0R0m0N65cjghEh6OEf5lB/OZ8Yc2tHYWPoj7DsFtqdQL5dVNog8kPYQZxRrb
 ttTSGTMLUGwO2YuXPx5kEX21/+vCv8H/rTzwtOkhkEYizolaVyP+TI7Rr+mAWMk0PrC2
 KqV6wmgGzMns38SEmoXzcf777FSIcQGcMbejxBv+dWWmJyNcLDy91Jm5XVmFsxMrNUO1
 LZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K9sl01AafDLfHeJ8+rUYL1jruEZ6Cs2sfqWkv5Qf36M=;
 b=YYfssWNCYrPF+NA8x/wlqp2l81dZdtJYIOQo7JR5yJfKMkE20+BRDKPnq2NZhS6+9s
 S553fdjq7vcjzRpm+7jP7ExpNNeyGRt47E1anPi37FG2xTEdDUPgtPH8E7RFEziuo3fO
 ORI8LSG/eVfpGSeTtMZ1kb99xO/pHF6pW/pLZfD+DleNUpLatkPeHtWT3gDTHJoR8/E9
 /O47yYvmqolRmnJd/naSYUvMc0gc0jEvMCtAgm3OGhD1V/wD/SFtT24FYkUFbv4slvaZ
 xtn10HV3N0breP6GfpMYbO/y5MIDpjleqgXdirXFi+rQrZLdnf19WpuM2C+ytNKHLOK2
 QtAw==
X-Gm-Message-State: AOAM531P1BWcTzP4tIvFlafYobVEUHqs4hLUzT6/bkdwE4Ogvtoo4BqH
 Qz3eO/ApWIqaMuBlYjZ8eWNlMReQYEgKRS0KFsk=
X-Google-Smtp-Source: ABdhPJxMqUgL9xIKmM0ThULgMmo4gdtf6W2OaS3j8SXt35yUtFmr9WCOJe5pu921op6RnmuJhqPSHv1cO1XB6/gQv88=
X-Received: by 2002:a17:907:2ce3:b0:6df:d819:8b98 with SMTP id
 hz3-20020a1709072ce300b006dfd8198b98mr7797833ejc.130.1648151657995; Thu, 24
 Mar 2022 12:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220322081844.1602-1-liuzixian4@huawei.com>
In-Reply-To: <20220322081844.1602-1-liuzixian4@huawei.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 24 Mar 2022 12:54:07 -0700
Message-ID: <CAPaKu7QgGH2jhvBYZvOpyMXDf6xS_uvNkGADfdjHb4GVSCFeFg@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: fix NULL pointer dereference in
 virtio_gpu_conn_get_modes
To: Liu Zixian <liuzixian4@huawei.com>
Cc: linfeilong@huawei.com, ML dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO CORE,
 NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>
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

On Wed, Mar 23, 2022 at 4:01 AM Liu Zixian <liuzixian4@huawei.com> wrote:
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 5b00310ac..f73352e7b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -179,6 +179,8 @@ static int virtio_gpu_conn_get_modes(struct drm_connector *connector)
>                 DRM_DEBUG("add mode: %dx%d\n", width, height);
>                 mode = drm_cvt_mode(connector->dev, width, height, 60,
>                                     false, false, false);
> +               if (!mode)
> +                       return count;
>                 mode->type |= DRM_MODE_TYPE_PREFERRED;
>                 drm_mode_probed_add(connector, mode);
>                 count++;
Can we avoid early return here?  Something like

  mode = drm_cvt_mode(...);
  if (mode) {
    DRM_DEBUG("add mode: %dx%d\n", width, height);
    mode->type |= DRM_MODE_TYPE_PREFERRED
    drm_mode_probed_add(connector, mode);
    count++;
  }

is more future proof.

> --
> 2.33.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
