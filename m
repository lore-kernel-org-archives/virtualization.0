Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83808C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 10:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4963408E9;
	Tue,  9 Aug 2022 10:42:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4963408E9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=axmr7Ehw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H8BmV4xeXJIB; Tue,  9 Aug 2022 10:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F3D65408D3;
	Tue,  9 Aug 2022 10:42:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3D65408D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9A60C0032;
	Tue,  9 Aug 2022 10:42:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AEA8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 326668183D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:42:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 326668183D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=axmr7Ehw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rgomqQBf-DHk
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:42:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 613A781455
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 613A781455
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660041761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2wU77kUCNeTkF1cn8B/etxN35pV2qrtvMIoXHK0vfB8=;
 b=axmr7EhwAW0qJIYpU4se6ZHDRLdar2G67AloX3hfI14R+NDB1YEVTzRun6F2W+zF01UK78
 3kItJduQ3VVx3Gfha3ohBOVKPPjITuubaQLzMeNjtl9I/sKD0X3ImwRItCG/OHPLaPnQqJ
 /Hsr5+/im8mgVe48p1oBmZK2w8AbPSQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-vXq1-yU2OoOSi3SYDC9_QA-1; Tue, 09 Aug 2022 06:42:40 -0400
X-MC-Unique: vXq1-yU2OoOSi3SYDC9_QA-1
Received: by mail-ej1-f72.google.com with SMTP id
 hr32-20020a1709073fa000b00730a39f36ddso3263653ejc.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 03:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=2wU77kUCNeTkF1cn8B/etxN35pV2qrtvMIoXHK0vfB8=;
 b=T7Td6s/OlGo20Ek5IhxYPpFA0FVzHUDB2BO9Kno/3P7Vs01YEJxcneR4LNlt8P1NM8
 ojrZ/9Wfsr4LCDuyBiWycFfcy2KgOTN/NrD7tAv7SwAGW90iWotFmw4zEow6pYS69uUD
 oGCuGU/g98FkSw3UTGPowyY6vqF8FvLsD00fjamIUQ2VLUUG2RKQGNcCiyMI1ziYkyfE
 Ikt7XChF1/6J9n//DGUJwIB3t+XeBE2iWdu1xQ4YcaStDhMDWWq4UFFRqqVSjBmpSwbh
 /geHpV7r2QprK1Es4IXqXFjiGzh+/KJB0CuMQrKyeazq6nkABfu6rU4kzeHPYKCozBxi
 OIYA==
X-Gm-Message-State: ACgBeo1rkCeIIRwykv3rgWp3DbO5LblJW181U4DnirimqhNrCM74G1YI
 yU0VTel6fkc5NM/0GUbj+gxH8SejiX+sFPHkduRV2fKBzIR3RlhPOsfhsHtQ6beJs0ygu9MRXkw
 Yk+wnWl+eWFocWqoVpeErnpTu63qcIoBlYYGuR8PgKg==
X-Received: by 2002:a17:907:1c9d:b0:732:f9da:aa51 with SMTP id
 nb29-20020a1709071c9d00b00732f9daaa51mr1108828ejc.654.1660041759015; 
 Tue, 09 Aug 2022 03:42:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4dwBXMrir1bhZ90knllSNXJ6IriUJkpeut7pGLGEfq3icbGS1zZfCNRRun+zm9ZUcJ60OBXg==
X-Received: by 2002:a17:907:1c9d:b0:732:f9da:aa51 with SMTP id
 nb29-20020a1709071c9d00b00732f9daaa51mr1108816ejc.654.1660041758814; 
 Tue, 09 Aug 2022 03:42:38 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 p12-20020a1709066a8c00b0072af4af2f46sm998853ejr.74.2022.08.09.03.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 03:42:38 -0700 (PDT)
Date: Tue, 9 Aug 2022 06:42:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Subject: Re: [PATCH v6 2/2] Unify how inflated memory is accounted in virtio
 balloon driver
Message-ID: <20220809063624-mutt-send-email-mst@kernel.org>
References: <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
 <20220726141047.72913-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20220726141047.72913-1-alexander.atanasov@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, kernel@openvz.org,
 linux-kernel@vger.kernel.org
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

On Tue, Jul 26, 2022 at 02:10:47PM +0000, Alexander Atanasov wrote:
> Always account inflated memory as used for both cases - with and
> without deflate on oom. Do not change total ram which can confuse
> userspace and users.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>

I only noticed this patch accidentally since it looked like
part of discussion on an older patch.
Please do not do this, each version should be its own thread,
if you want to link to previous discussion provide a
cover letter and do it there.

> ---
>  drivers/virtio/virtio_balloon.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 97d3b29cb9f1..fa6ddec45fc4 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -244,9 +244,6 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> -		if (!virtio_has_feature(vb->vdev,
> -					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -			adjust_managed_page_count(page, -1);
>  		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	}
>  
> @@ -265,9 +262,6 @@ static void release_pages_balloon(struct virtio_balloon *vb,
>  	struct page *page, *next;
>  
>  	list_for_each_entry_safe(page, next, pages, lru) {
> -		if (!virtio_has_feature(vb->vdev,
> -					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -			adjust_managed_page_count(page, 1);
>  		list_del(&page->lru);
>  		put_page(page); /* balloon reference */
>  	}

We adjusted total ram with balloon usage for many years.  I don't think
we can just drop this accounting using "can confuse userspace" as a
justification - any userspace that's confused by this has been confused
since approximately forever.

> @@ -750,12 +744,9 @@ static void report_free_page_func(struct work_struct *work)
>  static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
>  {
>  	struct virtio_balloon *vb = f->private;
> -	s64 num_pages = vb->num_pages << (VIRTIO_BALLOON_PFN_SHIFT - 10);
> +	u64 num_pages = vb->num_pages << (VIRTIO_BALLOON_PFN_SHIFT - 10);
>  
> -	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -		num_pages = -num_pages;
> -
> -	seq_printf(f, "inflated: %lld kB\n", num_pages);
> +	seq_printf(f, "inflated: %llu kB\n", num_pages);
>  
>  	return 0;

I don't much like it when patch 1 adds code only for patch 2 to drop it.

>  }
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
