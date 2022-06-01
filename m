Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03059C433EF
	for <virtualization@archiver.kernel.org>; Wed,  1 Jun 2022 11:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A73683148;
	Wed,  1 Jun 2022 11:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id liz6F_LHRmWv; Wed,  1 Jun 2022 11:04:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1BC8C83145;
	Wed,  1 Jun 2022 11:04:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E822AC0039;
	Wed,  1 Jun 2022 11:04:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE377C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 11:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA85240AA1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 11:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VHQHCoPAaTum
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 11:03:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A85040530
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654081437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tgtl50+cOg4p6sNpA44wE53+ToNHu8zqxjdgIaqTCDg=;
 b=KJrj5FW2RXPCJAq4+3QdbEBw5gCI/Q7id2HOQ8cvmQpEJ5KTHqjEj+74oZODnZB3FLwF6x
 lEY1Pn7y9LVZ/1rG6CotSiQjfkUzVFQoXgTUo1H3CMUaRu3wxb2YnKGTny4qM90le4wUD0
 zKrlV4C7fEnVVqXpqhQCryfm9qLNG8g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-5Jfg6kpBN9y0vYHOaXOgkw-1; Wed, 01 Jun 2022 07:03:54 -0400
X-MC-Unique: 5Jfg6kpBN9y0vYHOaXOgkw-1
Received: by mail-wr1-f70.google.com with SMTP id
 n3-20020a5d5983000000b0021021e3036eso228561wri.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Jun 2022 04:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Tgtl50+cOg4p6sNpA44wE53+ToNHu8zqxjdgIaqTCDg=;
 b=Uolt8vUIzJJj3rnMn4ujXZKqsSp+M06P/YfMJeERTWpFXVyDq64HNuN3nQ6NymnyDc
 kQnvZutjOMMrPABB/HKVF2MYVqT9MaKpX7zn42DMy77dI3B5tZIxnw6gruqbYfmCGIBc
 BxSNTY/AwPFRChZBPTAr8Y4zZ3GWyYQPj9ybM6GU0aVgXnAonERI4W7msKRzqfkTnyY+
 tkP4gLzpvsWPAXEeOeRR759Zc3QFwXlsU6lMCksJapcqXA0hOFatL6JcRdsUXWl/N9yQ
 zcUmfeO2m/OCPXU79niGjhukv9pGoe9BxHFzFxVtG+FAh25WgK1MNR1DNZxO6FFR7nvm
 Cvzw==
X-Gm-Message-State: AOAM532OhzdD0nJOBL8lKnU6gkREj6nJYw1p9uziezgo3wfqtVzA81z8
 WrevfaMk1TpWtlY7cIoVjvpa4pypOpDOm4mGeJKIheXzWH+ZV289gwE9KY5QnnOKcE6JIPbCFfm
 eSpFe+laatfu96hZVHoh2uT15au0fNiAuHsJMajmQZQ==
X-Received: by 2002:a5d:5145:0:b0:210:55c:4790 with SMTP id
 u5-20020a5d5145000000b00210055c4790mr26849899wrt.714.1654081432924; 
 Wed, 01 Jun 2022 04:03:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgKD3kkMJ5yY3Qc/mDpdOAlutZgyiyXLasWfkgGa3quLXJOeNWzJU9s8z4oSyg2SRWcOUapA==
X-Received: by 2002:a5d:5145:0:b0:210:55c:4790 with SMTP id
 u5-20020a5d5145000000b00210055c4790mr26849873wrt.714.1654081432646; 
 Wed, 01 Jun 2022 04:03:52 -0700 (PDT)
Received: from redhat.com ([2.52.157.68]) by smtp.gmail.com with ESMTPSA id
 q15-20020adff50f000000b002102e6b757csm1518657wro.90.2022.06.01.04.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jun 2022 04:03:51 -0700 (PDT)
Date: Wed, 1 Jun 2022 07:03:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v4 3/4] vhost-vdpa: uAPI to stop the device
Message-ID: <20220601070303-mutt-send-email-mst@kernel.org>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <20220526124338.36247-4-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220526124338.36247-4-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tanuj.kamde@amd.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 pabloc@xilinx.com, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, lulu@redhat.com, Piotr.Uminski@intel.com,
 martinh@xilinx.com, Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, lvivier@redhat.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com, hanand@xilinx.com,
 martinpo@xilinx.com, gautam.dawar@amd.com,
 Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, May 26, 2022 at 02:43:37PM +0200, Eugenio P=E9rez wrote:
> The ioctl adds support for stop the device from userspace.
> =

> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  drivers/vhost/vdpa.c       | 18 ++++++++++++++++++
>  include/uapi/linux/vhost.h | 14 ++++++++++++++
>  2 files changed, 32 insertions(+)
> =

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 32713db5831d..d1d19555c4b7 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -478,6 +478,21 @@ static long vhost_vdpa_get_vqs_count(struct vhost_vd=
pa *v, u32 __user *argp)
>  	return 0;
>  }
>  =

> +static long vhost_vdpa_stop(struct vhost_vdpa *v, u32 __user *argp)
> +{
> +	struct vdpa_device *vdpa =3D v->vdpa;
> +	const struct vdpa_config_ops *ops =3D vdpa->config;
> +	int stop;
> +
> +	if (!ops->stop)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&stop, argp, sizeof(stop)))
> +		return -EFAULT;
> +
> +	return ops->stop(vdpa, stop);
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cm=
d,
>  				   void __user *argp)
>  {
> @@ -650,6 +665,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>  	case VHOST_VDPA_GET_VQS_COUNT:
>  		r =3D vhost_vdpa_get_vqs_count(v, argp);
>  		break;
> +	case VHOST_VDPA_STOP:
> +		r =3D vhost_vdpa_stop(v, argp);
> +		break;
>  	default:
>  		r =3D vhost_dev_ioctl(&v->vdev, cmd, argp);
>  		if (r =3D=3D -ENOIOCTLCMD)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index cab645d4a645..c7e47b29bf61 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -171,4 +171,18 @@
>  #define VHOST_VDPA_SET_GROUP_ASID	_IOW(VHOST_VIRTIO, 0x7C, \
>  					     struct vhost_vring_state)
>  =

> +/* Stop or resume a device so it does not process virtqueue requests any=
more
> + *
> + * After the return of ioctl with stop !=3D 0, the device must finish any
> + * pending operations like in flight requests. It must also preserve all
> + * the necessary state (the virtqueue vring base plus the possible device
> + * specific states) that is required for restoring in the future. The
> + * device must not change its configuration after that point.
> + *
> + * After the return of ioctl with stop =3D=3D 0, the device can continue
> + * processing buffers as long as typical conditions are met (vq is enabl=
ed,
> + * DRIVER_OK status bit is enabled, etc).
> + */
> +#define VHOST_VDPA_STOP			_IOW(VHOST_VIRTIO, 0x7D, int)
> +
>  #endif

I wonder how does this interact with the admin vq idea.
I.e. if we stop all VQs then apparently admin vq can't
work either ...
Thoughts?

> -- =

> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
