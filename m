Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB66C4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 06:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BCE5C404B5;
	Fri, 16 Dec 2022 06:03:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BCE5C404B5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g0/2hB8w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LWHI3Vx4za81; Fri, 16 Dec 2022 06:03:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9C3A340327;
	Fri, 16 Dec 2022 06:03:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C3A340327
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C484C0033;
	Fri, 16 Dec 2022 06:03:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D243C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 06:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8145E6101A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 06:03:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8145E6101A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g0/2hB8w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iC2P8_WUaSSv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 06:03:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52E8861002
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52E8861002
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 06:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671170592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UuNQMA6JcfSSdnhdfJmqcm9JUwGwugR4wse2RVyEn1M=;
 b=g0/2hB8wsKd71IZz+DBfC7fZ60WH3M5J0LDj9/cphyWgrZwABVkGzYdGzpyHqBprrSWmIK
 nl1cGW3Tk5IByge1v9gviVf2MKg7X0uwi5kcGUkulSW6p1ycsqctMh4NeQDSwfdIVoOsNX
 5JA+rsrLHH7nQAZB0ZZEEdepj+0c1KQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-uSeBMOdpPYOoYAv0AvffxA-1; Fri, 16 Dec 2022 01:03:10 -0500
X-MC-Unique: uSeBMOdpPYOoYAv0AvffxA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-14496b502dfso838472fac.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 22:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UuNQMA6JcfSSdnhdfJmqcm9JUwGwugR4wse2RVyEn1M=;
 b=Pfe0FrDLMgTPop6o4SPJ8jwa6Kra2F2XnxZKVpVuzKf1DBYmGjkcvaD4tBlxrh8/pk
 tv1fErUvLqPdJaxJ0nAm7LLJuGOwteQyJcKDW5oVrRTEClvtxPm6qUAeY7UoaYHjFSBy
 8mYvQCQA+G4+8YRIMwGcw3qsTh2yn1kafZbB8y1KD2NfLStqfaoNSdDw9Sm4KqwNjIoC
 2RXMSey05bYT71dEnpO7e5vTv2uaH6du6i3W+pr46X27bkUoo2WH4OxSUjgNHV2CAlz3
 Jdu4wTfdm78iffjhAtKnEKiQdaTXrHXIbIVpqPa7qFmeki4iK381GLJm/YtAhji3yOtZ
 bpew==
X-Gm-Message-State: ANoB5pk46MWah3b2h9UaO0uQnl3MgEu+tXd1+ybewzdogdF1Eu7nm4lV
 2z88kOFbeEymsvIizLL4LTjXhRVIFbNCB9WOEPL1lbvC8CCNzH8YfOHBIwCoQclEGubCultRSoL
 taMPsU5url9zYtlteJSlKeN0Y6w/vxQDH99qsCVCdwjyjuwke9HyC2PSiaQ==
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr49188802otb.237.1671170590072; 
 Thu, 15 Dec 2022 22:03:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf44wCtaLEGrmygRsNYPZSB/qx0UBsq4nNqJgssZ8o67Es/2EoyDrCzZkJkKlrgTFV17aSqnSElYGuRideppYUs=
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr49188794otb.237.1671170589839; Thu, 15
 Dec 2022 22:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-5-xieyongji@bytedance.com>
In-Reply-To: <20221205090243.791-5-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 14:02:58 +0800
Message-ID: <CACGkMEsf64xOqxzySXDE807-nGy6dwrjT36y7O8ZyPFDrm0Yfw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] vduse: Support specifying bounce buffer size via
 sysfs
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, hch@lst.de, mst@redhat.com
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

On Mon, Dec 5, 2022 at 5:03 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> As discussed in [1], this adds sysfs interface to support
> specifying bounce buffer size in virtio-vdpa case. It would
> be a performance tuning parameter for high throughput workloads.
>
> [1] https://www.spinics.net/lists/netdev/msg754288.html
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 45 +++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index bd1ba6c33e09..0458d61cee1f 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -38,8 +38,11 @@
>  #define DRV_LICENSE  "GPL v2"
>
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
> +#define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> +#define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> -#define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
> +/* 128 MB reserved for virtqueue creation */
> +#define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
>  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>
>  struct vduse_virtqueue {
> @@ -1795,8 +1798,48 @@ static ssize_t msg_timeout_store(struct device *device,
>
>  static DEVICE_ATTR_RW(msg_timeout);
>
> +static ssize_t bounce_size_show(struct device *device,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct vduse_dev *dev = dev_get_drvdata(device);
> +
> +       return sysfs_emit(buf, "%u\n", dev->bounce_size);
> +}
> +
> +static ssize_t bounce_size_store(struct device *device,
> +                                struct device_attribute *attr,
> +                                const char *buf, size_t count)
> +{
> +       struct vduse_dev *dev = dev_get_drvdata(device);
> +       unsigned int bounce_size;
> +       int ret;
> +
> +       ret = -EPERM;
> +       mutex_lock(&dev->domain_lock);
> +       if (dev->domain)
> +               goto unlock;
> +
> +       ret = kstrtouint(buf, 10, &bounce_size);
> +       if (ret < 0)
> +               goto unlock;
> +
> +       ret = -EINVAL;
> +       if (bounce_size > VDUSE_MAX_BOUNCE_SIZE ||
> +           bounce_size < VDUSE_MIN_BOUNCE_SIZE)
> +               goto unlock;
> +
> +       dev->bounce_size = bounce_size & PAGE_MASK;
> +       ret = count;
> +unlock:
> +       mutex_unlock(&dev->domain_lock);
> +       return ret;
> +}
> +
> +static DEVICE_ATTR_RW(bounce_size);
> +
>  static struct attribute *vduse_dev_attrs[] = {
>         &dev_attr_msg_timeout.attr,
> +       &dev_attr_bounce_size.attr,
>         NULL
>  };
>
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
