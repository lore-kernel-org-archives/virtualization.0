Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332C9C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 12:58:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CF422CE3
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 12:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDAkyT/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CF422CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CFF7B87FA4;
	Wed,  5 Aug 2020 12:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2z11HuWzOkKo; Wed,  5 Aug 2020 12:58:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40A078815F;
	Wed,  5 Aug 2020 12:58:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36EF3C0050;
	Wed,  5 Aug 2020 12:58:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08B04C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 04E3187E9C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NCgCzsY-rEO9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:58:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4C7B48815C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596632290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ULrzApT10RVIpakDAc4yxKBeNUnNTeZD7ehmAQ8Tms=;
 b=TDAkyT/2zOgW5a2DH4nveB0xiUThVr4T03r9yzkUlOHKbkA85aPsEaP6N3Y3sAqLAylnMm
 v+IasmatnOFAsAxJ6QL9gYdeUj5Mu5LULu3M1DxzRilhL0wLZ1ir+RbT9sjz7Rx2+Be/Bk
 t2VmTeYCimN3Ie0U1MdM2Z1jCUEiir8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-b6iQiZOEM2KA9q1OJL57HQ-1; Wed, 05 Aug 2020 08:58:08 -0400
X-MC-Unique: b6iQiZOEM2KA9q1OJL57HQ-1
Received: by mail-wm1-f71.google.com with SMTP id q15so2689542wmj.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 05:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8ULrzApT10RVIpakDAc4yxKBeNUnNTeZD7ehmAQ8Tms=;
 b=PL3GhTz8AUiqWrqYEvkMMmvQsLo6tLsTpsk/ppRYIEIZZrsvKwwAb5vqRf8fsrcTVE
 fCTWZpoF5DLVfLoX50oVvfZIR8MOaVLJuhy9Pyp4MZSON9hQDyb6WQcpfWo9OAjPKb7v
 f53wPLzz4omWT35aCr7ccz0MZegZ0tULKI7VMR2kigDIfdfoghq80rWRgy7h0J3Vo8hH
 8p4Jy3r44IyrznaByJ0I15frTni64i8H8vsiFR0rtWP/C60e5epvWC591b15TOHCVxlD
 7AOWJJgUSo8iX0hgx7CyTvEcTGpNjwIm3zNaaazrhJaUhtuKxhtIJNuRsZkD2y2BiqXX
 MNQg==
X-Gm-Message-State: AOAM531dsZpzjsx37TcjsWL1FxGKjMpVj7F3OLnUz1ngyY1VICKpURvF
 PAUnhPT9OTqRJIi38+yXTFCn2szMT1MszbkSxUfLdHYhQdO5lYuLeixy47iIBXu40jX001qQjhj
 KuD8lutEFVAan/I30yyYmYcWQe2spOYidcrLkVpVf1A==
X-Received: by 2002:adf:a106:: with SMTP id o6mr2692910wro.1.1596632287578;
 Wed, 05 Aug 2020 05:58:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymsZfge35MX/5Sup1G9j697447cGxNEw/hBVXxdZ/SC5LeZkULFXxLuRBqbaI8jyXaxQHhUw==
X-Received: by 2002:adf:a106:: with SMTP id o6mr2692833wro.1.1596632286353;
 Wed, 05 Aug 2020 05:58:06 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 p8sm2842373wrq.9.2020.08.05.05.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 05:58:05 -0700 (PDT)
Date: Wed, 5 Aug 2020 08:58:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 4/4] vhost: vdpa: report iova range
Message-ID: <20200805085635-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-5-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200617032947.6371-5-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

On Wed, Jun 17, 2020 at 11:29:47AM +0800, Jason Wang wrote:
> This patch introduces a new ioctl for vhost-vdpa device that can
> report the iova range by the device. For device that depends on
> platform IOMMU, we fetch the iova range via DOMAIN_ATTR_GEOMETRY. For
> devices that has its own DMA translation unit, we fetch it directly
> from vDPA bus operation.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vdpa.c             | 27 +++++++++++++++++++++++++++
>  include/uapi/linux/vhost.h       |  4 ++++
>  include/uapi/linux/vhost_types.h |  5 +++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 77a0c9fb6cc3..ad23e66cbf57 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -332,6 +332,30 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
>  
>  	return 0;
>  }
> +
> +static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
> +{
> +	struct iommu_domain_geometry geo;
> +	struct vdpa_device *vdpa = v->vdpa;
> +	const struct vdpa_config_ops *ops = vdpa->config;
> +	struct vhost_vdpa_iova_range range;
> +	struct vdpa_iova_range vdpa_range;
> +
> +	if (!ops->set_map && !ops->dma_map) {

Why not just check if (ops->get_iova_range) directly?




> +		iommu_domain_get_attr(v->domain,
> +				      DOMAIN_ATTR_GEOMETRY, &geo);
> +		range.start = geo.aperture_start;
> +		range.end = geo.aperture_end;
> +	} else {
> +		vdpa_range = ops->get_iova_range(vdpa);
> +		range.start = vdpa_range.start;
> +		range.end = vdpa_range.end;
> +	}
> +
> +	return copy_to_user(argp, &range, sizeof(range));
> +
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  				   void __user *argp)
>  {
> @@ -442,6 +466,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  	case VHOST_VDPA_SET_CONFIG_CALL:
>  		r = vhost_vdpa_set_config_call(v, argp);
>  		break;
> +	case VHOST_VDPA_GET_IOVA_RANGE:
> +		r = vhost_vdpa_get_iova_range(v, argp);
> +		break;
>  	default:
>  		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>  		if (r == -ENOIOCTLCMD)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 0c2349612e77..850956980e27 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -144,4 +144,8 @@
>  
>  /* Set event fd for config interrupt*/
>  #define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
> +
> +/* Get the valid iova range */
> +#define VHOST_VDPA_GET_IOVA_RANGE	_IOW(VHOST_VIRTIO, 0x78, \
> +					     struct vhost_vdpa_iova_range)
>  #endif
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> index 669457ce5c48..4025b5a36177 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -127,6 +127,11 @@ struct vhost_vdpa_config {
>  	__u8 buf[0];
>  };
>  
> +struct vhost_vdpa_iova_range {
> +	__u64 start;
> +	__u64 end;
> +};
> +


Pls document fields. And I think first/last is a better API ...

>  /* Feature bits */
>  /* Log all write descriptors. Can be changed while device is active. */
>  #define VHOST_F_LOG_ALL 26
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
