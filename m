Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3988AEB64D9
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 16:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C8AA44063F;
	Tue,  4 Jul 2023 16:43:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8AA44063F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FrZp3K32
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OI3ptom3wU2V; Tue,  4 Jul 2023 16:43:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 51B7E404EB;
	Tue,  4 Jul 2023 16:43:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51B7E404EB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26B27C0071;
	Tue,  4 Jul 2023 16:43:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A96DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 16:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 740034022F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 16:43:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 740034022F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FrZp3K32
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gtif8bOqiemq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 16:43:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 821E5401BF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 821E5401BF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688489006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++31QNnFpybX5MmpnsU7eZDLUx30FaViiXqi2htj32Q=;
 b=FrZp3K32652/0Rqx+Px7R2+/81/3RUb7GGTS2tGHC6Nndew3JhJ3vHIwJMZcun2AyBzu7l
 dFJ24DORkLylwAgZJsPIybzVckna+lzdchW45HZ9p1M+VBpiSTC8PJihgYZwiZenGv9kcI
 tYvJ8RWpYtMNBvmdy7hbSfkw0vk3Luw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-2PN-0aEDNnafOpU1n_p2SA-1; Tue, 04 Jul 2023 12:43:25 -0400
X-MC-Unique: 2PN-0aEDNnafOpU1n_p2SA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e6153f0eeso3269479f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jul 2023 09:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688489004; x=1691081004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++31QNnFpybX5MmpnsU7eZDLUx30FaViiXqi2htj32Q=;
 b=K2noU7sYu5sfFDHRrot3F51QWnWH95nDQd10h1KYShv0rvn0G8cDsYW5t6VbKB3EYQ
 I6dPEwyzcjsmf5kxiXdGQjdfxipFRm93WFLcDWstb80VRdv/Swizwu2XK0iRiShIqtpO
 wRea15R4t+SR6Dt2sfMGXKCjn4VAYcbJTRSlHv2yYkb0+2pDRh+X2IP3r2qCcLPbc5fc
 bJZhLbXm6UpaEc0TKcmSLnJINkWL9gkDjrYLeZhEvfEASJXT11XkmHtzaoP++qmag0aK
 BeY8l62+NIdAFdkGtnKQwU0RWBzh0v5vs+d6CiWdxK9QnF2e7UWb9Dyx+k+X8H0ymcrI
 hf6Q==
X-Gm-Message-State: ABy/qLaJK+4eT55IKsFMhQ0UhWqpKZhWJvO1eKp8cJzwxeiPheo5LhLu
 067ml4+eoBX62sCeKjtktJFBXrzYGgpQHHYqvLAVj2UOKH4RjZUfZyoky46XU5rNc7274/+P0RB
 1hvqknuX0Vs4F8yK8aj6AAdUBRSmplxjwpIaLG4v8NQ==
X-Received: by 2002:a5d:4fc4:0:b0:313:ebf3:f817 with SMTP id
 h4-20020a5d4fc4000000b00313ebf3f817mr11139664wrw.22.1688489004438; 
 Tue, 04 Jul 2023 09:43:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFLwTkm7jWgBjGyISZ+jMBiAdz5/mJ7POTeZPg0ZURSljLDG/kIWES+tk18V/kyaa6T4rWemQ==
X-Received: by 2002:a5d:4fc4:0:b0:313:ebf3:f817 with SMTP id
 h4-20020a5d4fc4000000b00313ebf3f817mr11139646wrw.22.1688489004093; 
 Tue, 04 Jul 2023 09:43:24 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 a16-20020adfeed0000000b0031431fb40fasm7742592wrp.89.2023.07.04.09.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:43:23 -0700 (PDT)
Date: Tue, 4 Jul 2023 12:43:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v2 3/3] vduse: Temporarily disable control queue features
Message-ID: <20230704124245-mutt-send-email-mst@kernel.org>
References: <20230704164045.39119-1-maxime.coquelin@redhat.com>
 <20230704164045.39119-4-maxime.coquelin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230704164045.39119-4-maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 david.marchand@redhat.com
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

On Tue, Jul 04, 2023 at 06:40:45PM +0200, Maxime Coquelin wrote:
> Virtio-net driver control queue implementation is not safe
> when used with VDUSE. If the VDUSE application does not
> reply to control queue messages, it currently ends up
> hanging the kernel thread sending this command.
> 
> Some work is on-going to make the control queue
> implementation robust with VDUSE. Until it is completed,
> let's disable control virtqueue and features that depend on
> it.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 1271c9796517..04367a53802b 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1778,6 +1778,25 @@ static struct attribute *vduse_dev_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(vduse_dev);
>  
> +static void vduse_dev_features_fixup(struct vduse_dev_config *config)
> +{
> +	if (config->device_id == VIRTIO_ID_NET) {
> +		/*
> +		 * Temporarily disable control virtqueue and features that
> +		 * depend on it while CVQ is being made more robust for VDUSE.
> +		 */
> +		config->features &= ~((1ULL << VIRTIO_NET_F_CTRL_VQ) |
> +				(1ULL << VIRTIO_NET_F_CTRL_RX) |
> +				(1ULL << VIRTIO_NET_F_CTRL_VLAN) |
> +				(1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE) |
> +				(1ULL << VIRTIO_NET_F_MQ) |
> +				(1ULL << VIRTIO_NET_F_CTRL_MAC_ADDR) |
> +				(1ULL << VIRTIO_NET_F_RSS) |
> +				(1ULL << VIRTIO_NET_F_HASH_REPORT) |
> +				(1ULL << VIRTIO_NET_F_NOTF_COAL));
> +	}
> +}
> +


This will never be exhaustive, we are adding new features.
Please add an allowlist with just legal ones instead.


>  static int vduse_create_dev(struct vduse_dev_config *config,
>  			    void *config_buf, u64 api_version)
>  {
> @@ -1793,6 +1812,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	if (!dev)
>  		goto err;
>  
> +	vduse_dev_features_fixup(config);
> +
>  	dev->api_version = api_version;
>  	dev->device_features = config->features;
>  	dev->device_id = config->device_id;
> -- 
> 2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
