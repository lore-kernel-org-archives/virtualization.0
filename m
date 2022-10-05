Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32606C433FE
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 10:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8BA040AFA;
	Wed,  5 Oct 2022 10:18:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8BA040AFA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UVz7TmqB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kcX3IXpr8YO9; Wed,  5 Oct 2022 10:18:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 56A94402E5;
	Wed,  5 Oct 2022 10:18:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56A94402E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2197DC0033;
	Wed,  5 Oct 2022 10:18:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0C1AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 10:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C0CE400BC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 10:18:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C0CE400BC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UVz7TmqB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jA4XKJu5cKzF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 10:18:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9CFC7400AC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CFC7400AC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 10:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664965115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x41/5klT3HDcc3qHUO/xtt9h6BjGcktdGOkkPFwNbTk=;
 b=UVz7TmqB1Bqzm2FxAaRlCb1bmlBtJp8cw5bpAbW8ajNR82GNRS3pikJJy7Bl6pWea+6dEJ
 dX7xANfMGPsswXtl1uh+QIKz4G79d5YPPfFU3Ny1vXKrPH+TNuITDoP7Z7EMdRxqItaMhA
 UCsl6jzoIZpIrRq2ZfhTh6DJqRfH1CE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-xmB2BGn2Pe65g1LUyygU1w-1; Wed, 05 Oct 2022 06:18:34 -0400
X-MC-Unique: xmB2BGn2Pe65g1LUyygU1w-1
Received: by mail-ej1-f69.google.com with SMTP id
 ga36-20020a1709070c2400b007837e12cd7bso6231479ejc.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Oct 2022 03:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x41/5klT3HDcc3qHUO/xtt9h6BjGcktdGOkkPFwNbTk=;
 b=0kZE9rBzfSu8kAHXG4HDtJU8c5093sv5aTiH11tPH8xUy7AU13EhMDOzaYCXXJ8BOW
 wL326YB2SFM65RFSuT+8MCiefibsNIrID8LavVdV6lWEZC/x4O768hbRen5FBkUxyQIC
 pw/aLES+B/9z3Cn4jS5/pUTVQwIsUrduTmFX4A5+Q5+mf0U3Wc1nhVapMF545Zq1fOrl
 5Q+5Le9kWnQjmkGuHaResLNSpgZW4iBzl5W3MwnaureisogNI/yNc0DCHFQTTgD160N5
 FFmIdXzP44n4dcSP3xmF8uyLHxt3CTFXbPr1WIePTho0jHispbW3Sh4S295cfzB9UNXw
 bKXA==
X-Gm-Message-State: ACrzQf0JMcUrg90klmjEGb8kxVFPjKpdLvmMery0QK8pkv5HuBgfqAmr
 I7dGzi8GUFYSz1pkl5wlhXHIVTEKC5FTBefPKSauVSTmwDMIQVUMGlvLVGNhEvPSKkje/HsLTwT
 dkBjUlrX9gyFt3U1JZuveNSdlLW70hs+qvwzEz4goJkgEP1lUF2/nZxpUgQ==
X-Received: by 2002:a05:6402:298d:b0:451:5fc5:d423 with SMTP id
 eq13-20020a056402298d00b004515fc5d423mr27385188edb.102.1664965112464; 
 Wed, 05 Oct 2022 03:18:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Q2Be0EZiS40BB/UlOpYk38i36HWcBT5ILV8Eb8kxwz4LCRB5s881Uem4lPfFPpVuDFdhhDY3/u/OObRmsBhM=
X-Received: by 2002:a05:6402:298d:b0:451:5fc5:d423 with SMTP id
 eq13-20020a056402298d00b004515fc5d423mr27385181edb.102.1664965112292; Wed, 05
 Oct 2022 03:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220811084749.83809-1-sgarzare@redhat.com>
In-Reply-To: <20220811084749.83809-1-sgarzare@redhat.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 5 Oct 2022 12:18:20 +0200
Message-ID: <CAGxU2F6hQLbi2inrA+Tjd9YrfRovppZR=sbDxDD42=94nYw4MA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix warning casts when building with C=2
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Aug 11, 2022 at 10:47 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Use __virtio16_to_cpu() to read `max_virtqueue_pairs` field in
> virtio_net_config since its type is __virtio16.
>
> This silences the following warning when building with `make C=2`:
>
>     ../drivers/vdpa/vdpa.c:811:19: warning: cast to restricted __le16
>     ../drivers/vdpa/vdpa.c:811:19: warning: cast from restricted __virtio16
>

I just noticed that we still have these warnings, maybe this patch has
fallen through the cracks, so I just ping kindly to include it in this
merge window :-)

Thanks,
Stefano

> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index c06c02704461..2466d5087478 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -808,7 +808,7 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>         if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
>                 return 0;
>
> -       val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
> +       val_u16 = __virtio16_to_cpu(true, config->max_virtqueue_pairs);
>         return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
>  }
>
> --
> 2.37.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
