Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DE8C25B0C
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 940A040C5E;
	Thu, 11 Aug 2022 08:29:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 940A040C5E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BaJ3u1qi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mbHg-CLVIaeW; Thu, 11 Aug 2022 08:29:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 976A140128;
	Thu, 11 Aug 2022 08:29:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 976A140128
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C021C0033;
	Thu, 11 Aug 2022 08:29:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 215D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2770402E8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:29:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2770402E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EwIq04TbHRbs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:29:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05EF840128
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05EF840128
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660206555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FxVByzSzFDmsCiLB/TiRSXnYOQzfrWFzUNaldqvoDEA=;
 b=BaJ3u1qi9tgl72ibhxNdY8wqQhE42VfvUvl5PdBNjcjwAD2z2gp1EeMDafOoSVH0Qu3weC
 55759HZvW1/lBgKChDZwHIwl2GBZ1NVAJ60oHRQx7fv7PqVjlNRZOSTBywrzA566meSk79
 tf2e14qO6WFZJEhgmS7XKyVzrsdSXZA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-7oJONk6VPZ2AgG8x51RTAw-1; Thu, 11 Aug 2022 04:29:14 -0400
X-MC-Unique: 7oJONk6VPZ2AgG8x51RTAw-1
Received: by mail-wm1-f69.google.com with SMTP id
 v24-20020a7bcb58000000b003a37681b861so1417467wmj.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 01:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=FxVByzSzFDmsCiLB/TiRSXnYOQzfrWFzUNaldqvoDEA=;
 b=ImTmJAk8rDgXf4Um+IVsuc2oTagPsXT6irRICu4O8gFYJf/zbJ8lAwaQgUllPzFkg4
 O7dSfkq2dZaoilw89vRm8uJ7qlQhRlIAFv6UUgskIwyjqaVOALkWFOz92dhLNX5SEj6F
 p5Orw/eJPzZPLaJt2rB4lr+Tm7WI2ahTo0/elOdOl12dJqTNxDZZ0zi2QInU2+cID5+t
 yI04osv7Z8FsiZjMSrBYC3n0M8Q0MElXs/p1bs045POdXx5CJza43aboX2Simho6BBXE
 I3/IS/oqtkojs7zXsv3J+VefX6bsVMkpN/p0zJq5RcevwHwZNzVMfoW7+1b2C74lBHa4
 GkvQ==
X-Gm-Message-State: ACgBeo2iwvEFyoeifgvcy6n4Hbq2gghxWvrjPOOgOKxDTLIJlDVcZ+By
 A/7nCc80t+J/ZtjGL0YPuE8zDRqfDsQl91qQbCsonBPJ2zRQxIol8u3BBtz6DrARUA++XFWpO81
 4iD9bGjv9CAdp12NjhkofRmvhhEMFX89knXBWZTZCzw==
X-Received: by 2002:a7b:cbd7:0:b0:3a5:500e:13bc with SMTP id
 n23-20020a7bcbd7000000b003a5500e13bcmr4872390wmi.83.1660206553688; 
 Thu, 11 Aug 2022 01:29:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR66zsuUOgvuqZVbOtSOAaY+Zmwp04081qg20ikPfEaP/6IS6rnkd3YWhqyK4i6W0P73yvfqIw==
X-Received: by 2002:a7b:cbd7:0:b0:3a5:500e:13bc with SMTP id
 n23-20020a7bcbd7000000b003a5500e13bcmr4872374wmi.83.1660206553473; 
 Thu, 11 Aug 2022 01:29:13 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c3b1500b003a317ee3036sm5522733wms.2.2022.08.11.01.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 01:29:12 -0700 (PDT)
Date: Thu, 11 Aug 2022 04:29:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v7 3/4] vhost-vdpa: uAPI to suspend the device
Message-ID: <20220811042847-mutt-send-email-mst@kernel.org>
References: <20220810171512.2343333-1-eperezma@redhat.com>
 <20220810171512.2343333-4-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220810171512.2343333-4-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tanuj.kamde@amd.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 lulu@redhat.com, Piotr.Uminski@intel.com, martinh@xilinx.com,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, lvivier@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com,
 hanand@xilinx.com, martinpo@xilinx.com, gautam.dawar@amd.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Aug 10, 2022 at 07:15:11PM +0200, Eugenio P=E9rez wrote:
> The ioctl adds support for suspending the device from userspace.
> =

> This is a must before getting virtqueue indexes (base) for live migration,
> since the device could modify them after userland gets them. There are
> individual ways to perform that action for some devices
> (VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there was no
> way to perform it for any vhost device (and, in particular, vhost-vdpa).
> =

> After a successful return of the ioctl call the device must not process
> more virtqueue descriptors. The device can answer to read or writes of
> config fields as if it were not suspended. In particular, writing to
> "queue_enable" with a value of 1 will not make the device start
> processing buffers of the virtqueue.
> =

> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> Message-Id: <20220623160738.632852-4-eperezma@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

You are not supposed to include upstream maintainer's signoff
like this.

> ---
> v7: Delete argument to ioctl, unused
> ---
>  drivers/vhost/vdpa.c       | 19 +++++++++++++++++++
>  include/uapi/linux/vhost.h |  9 +++++++++
>  2 files changed, 28 insertions(+)
> =

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 3d636e192061..7fa671ac4bdf 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -478,6 +478,22 @@ static long vhost_vdpa_get_vqs_count(struct vhost_vd=
pa *v, u32 __user *argp)
>  	return 0;
>  }
>  =

> +/* After a successful return of ioctl the device must not process more
> + * virtqueue descriptors. The device can answer to read or writes of con=
fig
> + * fields as if it were not suspended. In particular, writing to "queue_=
enable"
> + * with a value of 1 will not make the device start processing buffers.
> + */
> +static long vhost_vdpa_suspend(struct vhost_vdpa *v)
> +{
> +	struct vdpa_device *vdpa =3D v->vdpa;
> +	const struct vdpa_config_ops *ops =3D vdpa->config;
> +
> +	if (!ops->suspend)
> +		return -EOPNOTSUPP;
> +
> +	return ops->suspend(vdpa);
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cm=
d,
>  				   void __user *argp)
>  {
> @@ -654,6 +670,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>  	case VHOST_VDPA_GET_VQS_COUNT:
>  		r =3D vhost_vdpa_get_vqs_count(v, argp);
>  		break;
> +	case VHOST_VDPA_SUSPEND:
> +		r =3D vhost_vdpa_suspend(v);
> +		break;
>  	default:
>  		r =3D vhost_dev_ioctl(&v->vdev, cmd, argp);
>  		if (r =3D=3D -ENOIOCTLCMD)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index cab645d4a645..f9f115a7c75b 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -171,4 +171,13 @@
>  #define VHOST_VDPA_SET_GROUP_ASID	_IOW(VHOST_VIRTIO, 0x7C, \
>  					     struct vhost_vring_state)
>  =

> +/* Suspend a device so it does not process virtqueue requests anymore
> + *
> + * After the return of ioctl the device must preserve all the necessary =
state
> + * (the virtqueue vring base plus the possible device specific states) t=
hat is
> + * required for restoring in the future. The device must not change its
> + * configuration after that point.
> + */
> +#define VHOST_VDPA_SUSPEND		_IO(VHOST_VIRTIO, 0x7D)
> +
>  #endif
> -- =

> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
