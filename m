Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60314E71094
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 16:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D10BC83B4A;
	Thu, 21 Sep 2023 16:35:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D10BC83B4A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GOvnhWYi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ekSvUHLM5AA7; Thu, 21 Sep 2023 16:35:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E8E5983B2A;
	Thu, 21 Sep 2023 16:35:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8E5983B2A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7564C0071;
	Thu, 21 Sep 2023 16:35:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 460CEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 16:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FC7260BA1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 16:35:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FC7260BA1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GOvnhWYi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jDEnBYWqeeGP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 16:35:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F9B760B53
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 16:35:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F9B760B53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695314137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tD4U+DBz8vqdTLY/43Ehl4REYq1fEB86EZ9HCmor6qM=;
 b=GOvnhWYiO6u4GpFgz2v1b4XCJidUSjTDh47eudY3XLU7fNF0Xa+dj6fY/YL4yi9H4zOAxo
 BjmGdMnC1X3Kicg4rLSDcIr+JfjUVlJhWOjlHlyk00AAXSYT8m73077CoLBH38ZAfGS6Hb
 SquRKAlvkBkxk+0m4BENXW4F776yBAA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-c_YkEkKgPvixgevRGufaRg-1; Thu, 21 Sep 2023 12:35:36 -0400
X-MC-Unique: c_YkEkKgPvixgevRGufaRg-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7982d05b429so78379139f.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 09:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695314135; x=1695918935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tD4U+DBz8vqdTLY/43Ehl4REYq1fEB86EZ9HCmor6qM=;
 b=dg6KuYEd6qf6HkcJ0C789YS9KqOXJ/4yUwtMrhVsNovJcjKiaNMQJv1RXntc/3EnQ4
 lWQ/In5gKwedS+HDg87V4mvSE7WaqOqOCMSGvJj/b7T4AT+OnZHFIoJm624fEEjxpZaa
 BPlnOjKVf52MEFN6fvNAOkbfmj5RTq0nlhWZSruDdBxW2ew1VYrvRJPzWAhnsDtB9WfU
 doTivdTURXGBT1EVajk7J1y1c/FIyqmw55lnYDhSEQjAlLzGsyqdjcDM2IgNSn7+87xO
 08Dcnr/zkBmn2ujKyFlzo2jdmHOQJZZ5mIUS9QCTTdNcA4EAKWQDkMtw51NDbwdv73dV
 HoSw==
X-Gm-Message-State: AOJu0YwSkqd7oXNVqYUbav5/DMdu3PQQ4GmIHVXL4sz7wHtjuUucT8Gv
 uIWv8Ffukr6L4iIevYm5A3eXP6vbH26hcKw9XbHW2RtSnVfsizm/4k3+7wQ82v5JhA/emgHTKnB
 IFX09cXMMbNto5Bgc5vIg+x4sIsjyUzNfIA01shNsEQ==
X-Received: by 2002:a05:6602:22c9:b0:792:72b8:b8a with SMTP id
 e9-20020a05660222c900b0079272b80b8amr5798011ioe.18.1695314135535; 
 Thu, 21 Sep 2023 09:35:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg+vjIgiiKahCTX3pMbVYZvVM7y++HS72J5LDp17dAkeKgi8T2pTu5LkSnAe4sFsqgAei9hg==
X-Received: by 2002:a05:6602:22c9:b0:792:72b8:b8a with SMTP id
 e9-20020a05660222c900b0079272b80b8amr5797998ioe.18.1695314135221; 
 Thu, 21 Sep 2023 09:35:35 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 w26-20020a02cf9a000000b00430a69ea278sm456847jar.167.2023.09.21.09.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 09:35:34 -0700 (PDT)
Date: Thu, 21 Sep 2023 10:35:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 08/11] vfio/pci: Expose vfio_pci_core_setup_barmap()
Message-ID: <20230921103532.3e5f319e.alex.williamson@redhat.com>
In-Reply-To: <20230921124040.145386-9-yishaih@nvidia.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-9-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Thu, 21 Sep 2023 15:40:37 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:

> Expose vfio_pci_core_setup_barmap() to be used by drivers.
> 
> This will let drivers to mmap a BAR and re-use it from both vfio and the
> driver when it's applicable.
> 
> This API will be used in the next patches by the vfio/virtio coming
> driver.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 25 +++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_rdwr.c | 28 ++--------------------------
>  include/linux/vfio_pci_core.h    |  1 +
>  3 files changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 1929103ee59a..b56111ed8a8c 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -684,6 +684,31 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
>  
> +int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	void __iomem *io;
> +	int ret;
> +
> +	if (vdev->barmap[bar])
> +		return 0;
> +
> +	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
> +	if (ret)
> +		return ret;
> +
> +	io = pci_iomap(pdev, bar, 0);
> +	if (!io) {
> +		pci_release_selected_regions(pdev, 1 << bar);
> +		return -ENOMEM;
> +	}
> +
> +	vdev->barmap[bar] = io;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(vfio_pci_core_setup_barmap);

Not to endorse the rest of this yet, but minimally _GPL, same for the
following patch.  Thanks,

Alex

> +
>  void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>  {
>  	struct vfio_pci_core_device *vdev =
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index e27de61ac9fe..6f08b3ecbb89 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -200,30 +200,6 @@ static ssize_t do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  	return done;
>  }
>  
> -static int vfio_pci_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
> -{
> -	struct pci_dev *pdev = vdev->pdev;
> -	int ret;
> -	void __iomem *io;
> -
> -	if (vdev->barmap[bar])
> -		return 0;
> -
> -	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
> -	if (ret)
> -		return ret;
> -
> -	io = pci_iomap(pdev, bar, 0);
> -	if (!io) {
> -		pci_release_selected_regions(pdev, 1 << bar);
> -		return -ENOMEM;
> -	}
> -
> -	vdev->barmap[bar] = io;
> -
> -	return 0;
> -}
> -
>  ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite)
>  {
> @@ -262,7 +238,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  		}
>  		x_end = end;
>  	} else {
> -		int ret = vfio_pci_setup_barmap(vdev, bar);
> +		int ret = vfio_pci_core_setup_barmap(vdev, bar);
>  		if (ret) {
>  			done = ret;
>  			goto out;
> @@ -438,7 +414,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
>  		return -EINVAL;
>  #endif
>  
> -	ret = vfio_pci_setup_barmap(vdev, bar);
> +	ret = vfio_pci_core_setup_barmap(vdev, bar);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 562e8754869d..67ac58e20e1d 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -127,6 +127,7 @@ int vfio_pci_core_match(struct vfio_device *core_vdev, char *buf);
>  int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
> +int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
>  pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
>  						pci_channel_state_t state);
>  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
