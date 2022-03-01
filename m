Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A83DC433EF
	for <virtualization@archiver.kernel.org>; Tue,  1 Mar 2022 08:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4904408A0;
	Tue,  1 Mar 2022 08:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AEd8BmTQwlcd; Tue,  1 Mar 2022 08:05:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 96B4E4086D;
	Tue,  1 Mar 2022 08:05:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A99EC0077;
	Tue,  1 Mar 2022 08:05:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4B0FC001A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 08:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93E86400F6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 08:05:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dwC9k_oS1sWu
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 08:05:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1BC2400E5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 08:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646121946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w77Ebi4LifMh+ZrcFTZqWSEQCBXXdZGjexRcCg9Znzs=;
 b=Hu13LBe/jRRsuYqDbLfPntiMfg3GVLjZ8XikbQsHZhMRmkRXfO6O0l6yrDie5fVeaO7+0j
 JEJu8uvgBTpvnrnNP1Yitmaq3UKVYnBUON4AzRpkdek24Af39bFEGAQ5kfGmt9tM7hdc2p
 y4jGOgGLCfZFKccIazOCaRNrRSknNIw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-tX64yeSVPyeWZFOOUJFY7Q-1; Tue, 01 Mar 2022 03:05:44 -0500
X-MC-Unique: tX64yeSVPyeWZFOOUJFY7Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 m12-20020a1709062acc00b006cfc98179e2so6442608eje.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Mar 2022 00:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=w77Ebi4LifMh+ZrcFTZqWSEQCBXXdZGjexRcCg9Znzs=;
 b=phnyiaxZnvcNu0yw4ZEqJkuBn3EfaSg6SkQ5N8uhbqdpmoO+O3LQ9E7aYDDev93FZk
 EWF8TsgdauopQI1fhWqNxF1bXNZcTpAUOOxvKBGTr1XTpeotmCNX2nDfl/WiZgr0lTrq
 RtzoeSBKMENLPUCm58If9UpFAE90ksi88YwylD6cZQuBwodZUujzIH6omEn/mzEetOQx
 0jYCjbE8L4tZaOP0HhObRmRAQ1XlQOtp0UE4yHXBasxoJSKgptSzL8YoLWBv1ksBuyiX
 MW/xR1M71HeuB8vVgtJ5gHX6/BLyjimBpEfxkUA/hl+RpSFY4js6QFeD/rn6uBIpEsxJ
 ww5A==
X-Gm-Message-State: AOAM53030teEgKNO+F+RWr8BbCjQ2G9TyhIhN65D/LQ43up+nuw091in
 YPGTHAI7XA48yQy6uLZFyxg2mFbfmMnPm4mEhA4ZYqyjhhGfQWJayEhmUvlf4QRlQ8eZMepkVvp
 KkN1XyFHiFNiK3nX34VaImrvYn6fTLLaOExf9J4kixA==
X-Received: by 2002:a05:6402:168a:b0:3fb:600e:4cc3 with SMTP id
 a10-20020a056402168a00b003fb600e4cc3mr23152118edv.32.1646121943306; 
 Tue, 01 Mar 2022 00:05:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2pXZS36u3F2oeMJehcUk31fIeBl/2gQcaSHUT4ZU+CTnm865d3/D4s5dPIC9Q5J5DliIC2w==
X-Received: by 2002:a05:6402:168a:b0:3fb:600e:4cc3 with SMTP id
 a10-20020a056402168a00b003fb600e4cc3mr23152105edv.32.1646121943127; 
 Tue, 01 Mar 2022 00:05:43 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 n6-20020aa7c786000000b00410d2403ccfsm6861832eds.21.2022.03.01.00.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Mar 2022 00:05:42 -0800 (PST)
Date: Tue, 1 Mar 2022 09:05:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH] vdpa: fix use-after-free on vp_vdpa_remove
Message-ID: <CAGxU2F5-PUzDNQrMiOn4Naj7Mga3NZ4kb6AHi7AfPSVauhGFTw@mail.gmail.com>
References: <20220301091059.46869-1-wang.yi59@zte.com.cn>
MIME-Version: 1.0
In-Reply-To: <20220301091059.46869-1-wang.yi59@zte.com.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Yi Wang <wang.yi59@zte.com.cn>, Zhang Min <zhang.min9@zte.com.cn>,
 wang.liang82@zte.com.cn, Michael Tsirkin <mst@redhat.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, xue.zhihong@zte.com.cn,
 Eli Cohen <elic@nvidia.com>
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

On Tue, Mar 1, 2022 at 2:26 AM Yi Wang <wang.yi59@zte.com.cn> wrote:
>
> From: Zhang Min <zhang.min9@zte.com.cn>
>
> When vp_vdpa driver is unbind, vp_vdpa is freed in vdpa_unregister_device
> and then vp_vdpa->mdev.pci_dev is dereferenced in vp_modern_remove,
> triggering use-after-free.
>
> Call Trace of unbinding driver free vp_vdpa :
> do_syscall_64
>   vfs_write
>     kernfs_fop_write_iter
>       device_release_driver_internal
>         pci_device_remove
>           vp_vdpa_remove
>             vdpa_unregister_device
>               kobject_release
>                 device_release
>                   kfree
>
> Call Trace of dereference vp_vdpa->mdev.pci_dev:
> vp_modern_remove
>   pci_release_selected_regions
>     pci_release_region
>       pci_resource_len
>         pci_resource_end
>           (dev)->resource[(bar)].end

We can add the fixes tag:

Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")

>
> Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index a57e381e830b..cce101e6a940 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -533,8 +533,8 @@ static void vp_vdpa_remove(struct pci_dev *pdev)
>  {
>         struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
>
> -       vdpa_unregister_device(&vp_vdpa->vdpa);
>         vp_modern_remove(&vp_vdpa->mdev);
> +       vdpa_unregister_device(&vp_vdpa->vdpa);
>  }
>
>  static struct pci_driver vp_vdpa_driver = {
> --
> 2.27.0
>

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
