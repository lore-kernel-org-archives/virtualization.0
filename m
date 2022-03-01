Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCDCC433F5
	for <virtualization@archiver.kernel.org>; Tue,  1 Mar 2022 01:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA40560E46;
	Tue,  1 Mar 2022 01:54:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AiHWDslQCa_S; Tue,  1 Mar 2022 01:54:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6861360AE1;
	Tue,  1 Mar 2022 01:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A7C5C0077;
	Tue,  1 Mar 2022 01:54:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E0F5C001A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 01:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E11D405E7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 01:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X22MRpsN2JYY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 01:54:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E58AA4050E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 01:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646099680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g40r52wHu65FpHGhPhkJNOWmkU7K31s8CzbExRsMUVU=;
 b=goOPrPJ+xfwiS2jGInwCZWDM+eU5t1ggKLJ4TpZ7KKsyYA3SOoW/LaSf+cOrUuhlRmh1Ua
 GiQPVQVDJi3+WymqzlCVBCUqQwphg4BhnykXpgxSxq2hQoaCuBkMP+/AC1tpT86Kn02JGG
 xMOT+t9PM+8dPVEiE4kBzUJzZX/uKSo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-lCSeqPdtNuecc4HtoweCUA-1; Mon, 28 Feb 2022 20:54:37 -0500
X-MC-Unique: lCSeqPdtNuecc4HtoweCUA-1
Received: by mail-lj1-f198.google.com with SMTP id
 o8-20020a2e9448000000b00246133c54deso6586728ljh.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 17:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g40r52wHu65FpHGhPhkJNOWmkU7K31s8CzbExRsMUVU=;
 b=UFWGHN4N7dUjJvRnUHW35BhnsC/2/YuUog3Ufov8jN/cQm3cGwN5Yx7Xlf6h3Iq8EQ
 bK0EkL4iSuqbzXoiLxNgMyx+fQoGjxeEd9HrodQF96b+cxxhYdzRGvNyeY2VW8NcSNMP
 C+0EsQ3NRn3KuD3Rc2JrhmeBrB34/u7wlTfvms+YH1uSJyVpM4viPNaPIkbtSY5DcVHM
 IVnGxjZ1zdqvhaa94V1sUPxw0tokGW1xWjXZRM+WXGIiiUhs7lVj/BypURWCqvO1PXyy
 mGBkugszCtgcB3xPh0Y4cZYLM/yhW/uxMm9h1NH7wXyw3099OhH0tueB3QCiSurENlBU
 u3TA==
X-Gm-Message-State: AOAM532nTFQuy0FgJnx4J/jH0Az04GAWXAoViRuMM4WMEUCdYs5mk7t2
 s3n3841eGVhbwHv8z/dPsuFyA1DYJS2MjUKirl/HZHse5TfIoOAA+d3XA5A/ksLEFwRxTXd8oxT
 tayfFD9urNLyGKSBrn8iQQHU2kjF/iCDDZHKqEsFz9OV6jt6zG1cY6Hd9zQ==
X-Received: by 2002:a2e:a885:0:b0:23a:30ac:5798 with SMTP id
 m5-20020a2ea885000000b0023a30ac5798mr16079124ljq.73.1646099675482; 
 Mon, 28 Feb 2022 17:54:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxw2rPJ4y3ziPQM8cVViNqHOz9fcmI1XLguFucvqdFCOhRObJ9+wV8U3FtF7b2/fBHQt3VcdKCGoxdc36ylRhU=
X-Received: by 2002:a2e:a885:0:b0:23a:30ac:5798 with SMTP id
 m5-20020a2ea885000000b0023a30ac5798mr16079111ljq.73.1646099675293; Mon, 28
 Feb 2022 17:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20220301091059.46869-1-wang.yi59@zte.com.cn>
In-Reply-To: <20220301091059.46869-1-wang.yi59@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Mar 2022 09:54:24 +0800
Message-ID: <CACGkMEvKcb1DrdSvCR8YvoDQu4TF1LMUDtngKFycNOzY11cYHg@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix use-after-free on vp_vdpa_remove
To: Yi Wang <wang.yi59@zte.com.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Zhang Min <zhang.min9@zte.com.cn>, wang.liang82@zte.com.cn,
 mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>,
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

On Tue, Mar 1, 2022 at 9:26 AM Yi Wang <wang.yi59@zte.com.cn> wrote:
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
>
> Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

Acked-by: Jason Wang <jasowang@redhat.com>

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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
