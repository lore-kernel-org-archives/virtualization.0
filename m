Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E8C4363D
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 09:31:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A892068D
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 09:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwtkIEv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A892068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D9D232E0FF;
	Thu, 24 Sep 2020 09:31:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zAlmcEsZm3Hg; Thu, 24 Sep 2020 09:31:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 37F232E0D9;
	Thu, 24 Sep 2020 09:31:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1ED9FC0859;
	Thu, 24 Sep 2020 09:31:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7044C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C0B7F874E6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:31:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tjiTFO3J7RxR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:31:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 36D08874C5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IivbX2PeE0RzW/9tWIJCPda1plSHGjAQvAPPVLRLJpk=;
 b=JwtkIEv82m8D5mbXzCLCSNpao7dJkjolNmTiqUaEZ3NWGU/Wh5iTpXwGIKzLvOuFmPPMWF
 xopS9jnJX80nztXJYYHmS/7Eh0/YUYWnhT3hMctl6orEMMbWDI598J4YTXRvF39oi8Hb+J
 NrgzOjlZ1uquOYwzQM8/KgVco5Jrgt4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223--rzmj1ooMNSgjR0HB9l_Ew-1; Thu, 24 Sep 2020 05:31:48 -0400
X-MC-Unique: -rzmj1ooMNSgjR0HB9l_Ew-1
Received: by mail-wr1-f70.google.com with SMTP id g6so1011977wrv.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 02:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IivbX2PeE0RzW/9tWIJCPda1plSHGjAQvAPPVLRLJpk=;
 b=C8TQbD1MW1xKZ7Be7xHUK7BFvAHvJL2HIpEbSEioFt7z9X2pNiN3NnQgbqcVuKKzvj
 uOssFbwruUk5Z9VV5ryDhbokLjTlFHjNpStbIpk/Mb1nZliCq2fAS2V7OGicja3kcHYb
 AeNimkm1KogS/Pk04dJWZI8xZCwPR7/zMPIQlMMuu0mhuKPuw95t5vbXvYd9DEeLn7tH
 wn3K94GwTimV1cDPNKlCIFonWIsIIoq1hxCu7aaHliZLwnVBz0XH2qGguaC51wulPXMZ
 w+4b5QFoLPdmKfm6Vi1FtoUQDPl3AWqSkT2jgTvsLPPNyEkOIUjyeKAIGIwW2LeVZXm/
 o1ew==
X-Gm-Message-State: AOAM532GG1TcI35y67khnG8KEn4jwcEWrtPH4lyvPnRFNDeFISW0PXSL
 nHT7cRAF7VYf9OYY3BogrfYOByWPz2VihBaQaFyC7gh1hk4cKa6/L8rsnz+lvx132ZHA3JBcay7
 pD2badt0nQspLRdxWdfwfrDo4ginocOpFUKd+RVnfkw==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr3884962wrn.145.1600939906693; 
 Thu, 24 Sep 2020 02:31:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz692FbM28SSNAgRM+pmYBV1x3+0U+/VUYbSIXGAG9tNcRIQZ9ScUUpWmMjwo9LJkxBth6P1g==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr3884952wrn.145.1600939906533; 
 Thu, 24 Sep 2020 02:31:46 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id v17sm3144042wrc.23.2020.09.24.02.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:31:45 -0700 (PDT)
Date: Thu, 24 Sep 2020 05:31:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 02/24] vhost-vdpa: fix vqs leak in vhost_vdpa_open()
Message-ID: <20200924053119-mutt-send-email-mst@kernel.org>
References: <20200924032125.18619-1-jasowang@redhat.com>
 <20200924032125.18619-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924032125.18619-3-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lulu@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

On Thu, Sep 24, 2020 at 11:21:03AM +0800, Jason Wang wrote:
> We need to free vqs during the err path after it has been allocated
> since vhost won't do that for us.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

This is a bugfix too right? I don't see it posted separately ...

> ---
>  drivers/vhost/vdpa.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 796fe979f997..9c641274b9f3 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -764,6 +764,12 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
>  	v->domain = NULL;
>  }
>  
> +static void vhost_vdpa_cleanup(struct vhost_vdpa *v)
> +{
> +	vhost_dev_cleanup(&v->vdev);
> +	kfree(v->vdev.vqs);
> +}
> +
>  static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  {
>  	struct vhost_vdpa *v;
> @@ -809,7 +815,7 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  	return 0;
>  
>  err_init_iotlb:
> -	vhost_dev_cleanup(&v->vdev);
> +	vhost_vdpa_cleanup(v);
>  err:
>  	atomic_dec(&v->opened);
>  	return r;
> @@ -840,8 +846,7 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
>  	vhost_vdpa_free_domain(v);
>  	vhost_vdpa_config_put(v);
>  	vhost_vdpa_clean_irq(v);
> -	vhost_dev_cleanup(&v->vdev);
> -	kfree(v->vdev.vqs);
> +	vhost_vdpa_cleanup(v);
>  	mutex_unlock(&d->mutex);
>  
>  	atomic_dec(&v->opened);
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
