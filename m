Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551F13475E
	for <virtualization@lists.linux.dev>; Tue,  6 Feb 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235020; cv=none; b=S9WNwYFTNJhkKBo/TdtzdpUcq/ntbqyTdNWv1zFFcoyplliscJlqALyZ5HYKA3YV8xiF3hSjm94ouA9q5znPTNyQj0xDPZceqSBaaGfXx8Q2xyXRPCoMkT7t/aieWPxWoJDgwzeeCDr2cSLt3DW7WBslAB+0zPVDJpzLZbP8wvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235020; c=relaxed/simple;
	bh=F/z9jhc2DNpq42Uj0IwIW4uQheTDId/6OFJGQsAfoP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NExh75QzLElm1FTDCbUrstyUuicELs/Cp4pbt9LDu3yLXagFW1PZlLE+rnf+D+9zKHR2hXnBFPdzA/XdSQ2SnfDJZPIxlYV5d3R6MaSIaerNhGLfY+OeiJr4wVulbhb8AiuT0Biq77FKiFBcSZTL1jU3iLt/+hg3awhv3mEtRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CC8CTamr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CC8CTamr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707235018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OaTEG/kcinyrw5Lp6MTv1pW09dqJMhWlKXXDkBtUnZU=;
	b=CC8CTamrdS/IieWz0w9zD2mbvo1lGLe+q/4JcyWbXutLNC1FBvrbZ1JX3GzuJr09rgo/q3
	BYERBrQ9sIY79lErecLQ02yza1iYjuLQ97C6fxGq8siVooutzqhMNmqlPzrL/4VTimku7o
	uEzoxBWiJdL3fPL8760pwEi0W+IuiC4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-o4qHDPfrNFyoDaati0P3Fg-1; Tue, 06 Feb 2024 10:56:56 -0500
X-MC-Unique: o4qHDPfrNFyoDaati0P3Fg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55fcdc80ddbso2581280a12.0
        for <virtualization@lists.linux.dev>; Tue, 06 Feb 2024 07:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707235015; x=1707839815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaTEG/kcinyrw5Lp6MTv1pW09dqJMhWlKXXDkBtUnZU=;
        b=hZ/mrlGSJMDHM6+T0bsRH34Je7nP93bg/aQ0WD2ePZBXzseYU4shL7+kG1L1AORnWl
         4IND72naZzk96ESmbXU+hvjK8bVLxyzZXLsA+Iqs0FxGoBRX3GOttYLiYrueQSuT1NMO
         /BS4Pvb0lBIBDw2DH0cqVuuE9X4a9H78TK3q/kQPLe76laLBGJ0WQtgmpoKCEuwRVoAW
         RHi1EmRMc4/pTnfbEnPiVAHzFQjGAQqy5ICz7CyKPI0/ckRL6ifLF2atPi/v/Zcm5vOf
         Dg0PQK78Bo8ByIkuBodNZZInHGQx8UDrzpQ/w9pj6+1Y2PvbRSoEW4Pz/NBSqTsAhQMu
         7j9Q==
X-Gm-Message-State: AOJu0YwJWrl0JYhnGFnh3Zi89mYIsH1uq72HGfEah/0U7d0iUwMKTE4E
	MIH+3IqoV4p+fViFLjxzVcHtso8UyTZl+mN98+xN1HBHJw6pKAZJcN/JMGRvvvySs5hjWxylPlX
	+cYv3KhqJXDPdpQ3ZNDXyNFLPV7d7uBGOstnbl7HRwQjZGEt+n6NYTEOBJyZKrEnD
X-Received: by 2002:a05:6402:31a2:b0:560:c1cc:ba9 with SMTP id dj2-20020a05640231a200b00560c1cc0ba9mr416734edb.28.1707235015567;
        Tue, 06 Feb 2024 07:56:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiNlUZejXoz4+eeqUFdQTaOSbylW6RyLRLnyotHOkI/qcgp2YinYoK5zuakU+tssZGz6gYFA==
X-Received: by 2002:a05:6402:31a2:b0:560:c1cc:ba9 with SMTP id dj2-20020a05640231a200b00560c1cc0ba9mr416706edb.28.1707235015186;
        Tue, 06 Feb 2024 07:56:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVqSkksK7XpMD9RJv1iaBa7WpQTCPLDeXDC+QEQcTfC56ij53hliMpewCvvKdqyxFlPXjoAg8KIKMRTPTLM5OZeKRYMhXoegc0ER6Q9YzkeecTdAOW981jgJe0/INtGfdeZiuthTuP7bcF6zohPqycrmuIWxC9BvSlWeiMeABUpsUGZ7k0x04Vso0b15PKJoIrx0HhEmxjyDOqnDnEkcGnQVafnwWoSUBtlxmYe/219a3DWagn2tevXtOSIV0O7UBE4jYS+1E7b4dQWDyPf
Received: from redhat.com ([2.52.129.159])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7da4d000000b00560422bd11asm1160996eds.30.2024.02.06.07.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:56:54 -0800 (PST)
Date: Tue, 6 Feb 2024 10:56:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, Shannon Nelson <shannon.nelson@amd.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: fail enabling virtqueue in certain conditions
Message-ID: <20240206105558-mutt-send-email-mst@kernel.org>
References: <20240206145154.118044-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240206145154.118044-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

better @subj: try late vq enable only if negotiated

On Tue, Feb 06, 2024 at 03:51:54PM +0100, Stefano Garzarella wrote:
> If VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated, we expect
> the driver to enable virtqueue before setting DRIVER_OK. If the driver
> tries anyway, better to fail right away as soon as we get the ioctl.
> Let's also update the documentation to make it clearer.
> 
> We had a problem in QEMU for not meeting this requirement, see
> https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.com/
> 
> Fixes: 9f09fd6171fe ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature")
> Cc: eperezma@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/uapi/linux/vhost_types.h | 3 ++-
>  drivers/vhost/vdpa.c             | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> index d7656908f730..5df49b6021a7 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -182,7 +182,8 @@ struct vhost_vdpa_iova_range {
>  /* Device can be resumed */
>  #define VHOST_BACKEND_F_RESUME  0x5
>  /* Device supports the driver enabling virtqueues both before and after
> - * DRIVER_OK
> + * DRIVER_OK. If this feature is not negotiated, the virtqueues must be
> + * enabled before setting DRIVER_OK.
>   */
>  #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
>  /* Device may expose the virtqueue's descriptor area, driver area and
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..1fba305ba8c1 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -651,6 +651,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  	case VHOST_VDPA_SET_VRING_ENABLE:
>  		if (copy_from_user(&s, argp, sizeof(s)))
>  			return -EFAULT;
> +		if (!vhost_backend_has_feature(vq,
> +			VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) &&
> +		    (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +			return -EINVAL;
>  		ops->set_vq_ready(vdpa, idx, s.num);
>  		return 0;
>  	case VHOST_VDPA_GET_VRING_GROUP:
> -- 
> 2.43.0

