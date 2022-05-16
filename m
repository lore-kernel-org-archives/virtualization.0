Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399EAC433EF
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 08:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E043982404;
	Mon, 16 May 2022 08:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yDIgUfJjDkzi; Mon, 16 May 2022 08:33:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E270081DAB;
	Mon, 16 May 2022 08:33:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1EFDC0032;
	Mon, 16 May 2022 08:33:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5837AC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37FD160BA3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7dGf0SSk5Jh1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:33:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8F9D60782
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652690027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/0TZKOmU5MYWRVEx2nEVYoYURBZEYA8OdDToJDLw5d8=;
 b=jBW7hDxB4d47erGYSGcYnzQcnsFU4ZZCzpO/1FMYXQOILgra92Y2+UoVr3/F1G7MK+A7FS
 6nvr7MIrY0ko7XWRDZgFDe5U0KddsQ/OcmqnZfzKPqo2yhEZsVlOhmx6KrRlpiqYpcE7aY
 izPTLcM5VI1TZjhTzqNCEn0vvcw3Ma8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-0_EqhbQJN8-r_00zl9sqhg-1; Mon, 16 May 2022 04:33:46 -0400
X-MC-Unique: 0_EqhbQJN8-r_00zl9sqhg-1
Received: by mail-wr1-f70.google.com with SMTP id
 s8-20020adfecc8000000b0020d080b6fddso269276wro.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 01:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/0TZKOmU5MYWRVEx2nEVYoYURBZEYA8OdDToJDLw5d8=;
 b=RnzGxE14VSrJvPMQcbU76qsMlQMXUwQZAiBogusuUfsamav+3DZXcU6fHbbWMvp7Sd
 mMC4e/DqqvOFt6/IVApv8YbbUM1bFFzSJKKN58JYNWpMMUeMvG/iNawdfhNMABoHa883
 b6v0fSi5IX/e8Dk3B9nrQiyiYb2gBws8welub0W6Qr6S7KFun9IFU0rr0suBYc0twWQY
 uKuvNImrRoF4dpwLT7ysV6miD9XMXxEvgVS3gJLgMh53YEWxmnE8sCKwXgbg7vFNLasN
 Ni1btZfEQJVu02vWAyrRt70KfNTQt+vvHRKCfq7VVbOSqjewIoRrFa6FaRNzskFGZVhW
 c1Ag==
X-Gm-Message-State: AOAM532Rs+t9AhyJesWxJXrRWXBvq0xuevxBp3usvQfO2lPTeFY/vfAB
 1fdA0qrDLYtxHVcJSCXOgERXy8khyuUk3jtQp5drFcKTESiN7imLx8LIrJEYE8CRzqQWgvbjrnW
 e7yO++jW9lvrIesFM5TsQ1mupYWYVuFPAEUPtJCBd5Q==
X-Received: by 2002:a05:600c:2f0f:b0:393:fbd1:cc94 with SMTP id
 r15-20020a05600c2f0f00b00393fbd1cc94mr15638599wmn.162.1652690025004; 
 Mon, 16 May 2022 01:33:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIEFtVeTft8pRLN6bEI3CqrbRtfwxp6sU2c+wnmYiqaCR/RRh+MwL06EIDZYlveP4Fu2d6FA==
X-Received: by 2002:a05:600c:2f0f:b0:393:fbd1:cc94 with SMTP id
 r15-20020a05600c2f0f00b00393fbd1cc94mr15638588wmn.162.1652690024830; 
 Mon, 16 May 2022 01:33:44 -0700 (PDT)
Received: from redhat.com ([2.55.141.66]) by smtp.gmail.com with ESMTPSA id
 i7-20020adfa507000000b0020d012692dbsm6085331wrb.18.2022.05.16.01.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 01:33:44 -0700 (PDT)
Date: Mon, 16 May 2022 04:33:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 1/3] vduse: Pass management device pointer to
 vduse_dev_init_vdpa()
Message-ID: <20220516043242-mutt-send-email-mst@kernel.org>
References: <20220516060342.106-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20220516060342.106-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: gregkh@linuxfoundation.org, virtualization@lists.linux-foundation.org,
 lingshan.zhu@intel.com, elic@nvidia.com
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

On Mon, May 16, 2022 at 02:03:40PM +0800, Xie Yongji wrote:
> Pass management device pointer from vdpa_dev_add() to
> vduse_dev_init_vdpa() rather than using the static
> variable directly.
> 
> No functional change.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Could you pls add a cover letter explaining what is the patchset
trying to achieve? I think I can guess but I'd rather not guess ...


> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 160e40d03084..d3bf55a58cd2 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1484,9 +1484,8 @@ static struct device vduse_mgmtdev = {
>  	.release = vduse_mgmtdev_release,
>  };
>  
> -static struct vdpa_mgmt_dev mgmt_dev;
> -
> -static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
> +static int vduse_dev_init_vdpa(struct vduse_dev *dev,
> +			       struct vdpa_mgmt_dev *mdev, const char *name)
>  {
>  	struct vduse_vdpa *vdev;
>  	int ret;
> @@ -1509,7 +1508,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  	}
>  	set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
>  	vdev->vdpa.dma_dev = &vdev->vdpa.dev;
> -	vdev->vdpa.mdev = &mgmt_dev;
> +	vdev->vdpa.mdev = mdev;
>  
>  	return 0;
>  }
> @@ -1526,7 +1525,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  		mutex_unlock(&vduse_lock);
>  		return -EINVAL;
>  	}
> -	ret = vduse_dev_init_vdpa(dev, name);
> +	ret = vduse_dev_init_vdpa(dev, mdev, name);
>  	mutex_unlock(&vduse_lock);
>  	if (ret)
>  		return ret;
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
