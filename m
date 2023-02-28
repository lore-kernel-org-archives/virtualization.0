Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBF9C64EC7
	for <virtualization@archiver.kernel.org>; Tue, 28 Feb 2023 12:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B19A2813FD;
	Tue, 28 Feb 2023 12:13:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B19A2813FD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pg8G5OW7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TAKLqxp1qRyJ; Tue, 28 Feb 2023 12:13:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3FEE7813CB;
	Tue, 28 Feb 2023 12:13:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FEE7813CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15A18C0032;
	Tue, 28 Feb 2023 12:13:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2B57C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 12:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86699813B2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 12:13:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86699813B2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGii0GAB5Vmq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 12:13:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66765813AE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66765813AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677586390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hoxu+nGD6T923oeRrMSsGpCNCuS7fv2W8hkqbtX7YfY=;
 b=Pg8G5OW7WjqWz8gFFVpOrXmApyCTJdaP37zcjTugKY1Neb6c6Rqs2UrIwQ7Sr1zaatXzbj
 dosqX43VEeOrjS0nA2q34fJCe3A3iFH+FCVZVSmkVtD3srKW+o9TiiUceC7YRlfHD4/Txx
 ngSgGrTwj3rVmd2egzJrNqEyK7OfS40=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-0Dz5JQzZNwOJpVRa2WqpYw-1; Tue, 28 Feb 2023 07:13:09 -0500
X-MC-Unique: 0Dz5JQzZNwOJpVRa2WqpYw-1
Received: by mail-wm1-f71.google.com with SMTP id
 bi27-20020a05600c3d9b00b003e9d0925341so3542261wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 04:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677586385;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hoxu+nGD6T923oeRrMSsGpCNCuS7fv2W8hkqbtX7YfY=;
 b=bWE4vWqh4hr133cY7LYSJvD4nfNdv7km6+HAAMFW4364KsNIHO5PsEfe1IJPpOLvUf
 5G8pat8bKX5tELHGg/YnGuNbzdAzZzmzra29WhHLZ9xoAC3cw5AdSBha5qGVVukUbC2N
 p/TeiU/gtxLedsPl/5itM9JkyeO9vIchQzGwIhJq6nm4MC0wffIOCS9GZyAQnj6NYdt6
 UdziaeYklsVos+pLEG/0IbZdjl9Wbr6pU2kN+Nng7h2neFUt5NZQFZwpDo+82IU+6Phh
 VREjj3GXIPgKHX1BA157A2wY2ybxZyhN8py+0S4FOpM32F2bV0J+DVg6VHmge4ddbpjp
 cuWw==
X-Gm-Message-State: AO0yUKXb8XYx6bChEUkxdEhguFPanGa/IK0wc/FJvs8Cqs1Ryd1lv62k
 nxUlG7AKb70pNuAomtdiZ6bImMQvUQS78B2IQQS8eboWux4GVZG1xf9WkC7QlAQGinQqL1TMliv
 iqs9HMs06UJg41I2eip9DXfCG6VeabX0weL0w49/fqQ==
X-Received: by 2002:a05:600c:b8c:b0:3e2:2057:b9d6 with SMTP id
 fl12-20020a05600c0b8c00b003e22057b9d6mr8897293wmb.20.1677586384805; 
 Tue, 28 Feb 2023 04:13:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/2iShf6XFmQ2DdHxYHI4OxYv/tx+ud/3W68x8DevBdyxg8dtxcKgmSO73oehT+Nr0/8lZ/8g==
X-Received: by 2002:a05:600c:b8c:b0:3e2:2057:b9d6 with SMTP id
 fl12-20020a05600c0b8c00b003e22057b9d6mr8897272wmb.20.1677586384455; 
 Tue, 28 Feb 2023 04:13:04 -0800 (PST)
Received: from redhat.com ([2.52.141.194]) by smtp.gmail.com with ESMTPSA id
 iv16-20020a05600c549000b003e0238d9101sm13869495wmb.31.2023.02.28.04.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Feb 2023 04:13:03 -0800 (PST)
Date: Tue, 28 Feb 2023 07:13:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v2] vdpa_sim: set last_used_idx as last_avail_idx in
 vdpasim_queue_ready
Message-ID: <20230228071109-mutt-send-email-mst@kernel.org>
References: <20230203142501.300125-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230203142501.300125-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, lulu@redhat.com,
 linux-kernel@vger.kernel.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com,
 Eli Cohen <elic@nvidia.com>, longpeng2@huawei.com
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

On Fri, Feb 03, 2023 at 03:25:01PM +0100, Eugenio P=E9rez wrote:
> Starting from an used_idx different than 0 is needed in use cases like
> virtual machine migration.  Not doing so and letting the caller set an
> avail idx different than 0 causes destination device to try to use old
> buffers that source driver already recover and are not available
> anymore.
> =

> Since vdpa_sim does not support receive inflight descriptors as a
> destination of a migration, let's set both avail_idx and used_idx the
> same at vq start.  This is how vhost-user works in a
> VHOST_SET_VRING_BASE call.
> =

> Although the simple fix is to set last_used_idx at vdpasim_set_vq_state,
> it would be reset at vdpasim_queue_ready.  The last_avail_idx case is
> fixed with commit a09f493c ("vdpa_sim: not reset state in
> vdpasim_queue_ready").  Since the only option is to make it equal to
> last_avail_idx, adding the only change needed here.
> =

> This was discovered and tested live migrating the vdpa_sim_net device.
> =

> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
> Cherry-picked from patch 2/2 of the series [1]. Differences are:
> * Set the value of used_idx at vdpasim_queue_ready instead of fetching
>   from the guest vring like vhost-kernel.
> =

> v2: Actually update last_used_idx only at vdpasim_queue_ready.
> =

> Note that commit id present in the patch text is not in master but in
> git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
> =

> [1] https://lkml.org/lkml/2023/1/18/1041


Can you post with a fixed hash please?

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 6a0a65814626..79ac585e40b9 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -68,6 +68,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim=
, unsigned int idx)
>  			  (uintptr_t)vq->device_addr);
>  =

>  	vq->vring.last_avail_idx =3D last_avail_idx;
> +	vq->vring.last_used_idx =3D last_avail_idx;
>  	vq->vring.notify =3D vdpasim_vq_notify;
>  }
>  =

> -- =

> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
