Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D790C001DF
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 09:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B493B70473;
	Fri, 20 Oct 2023 09:34:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B493B70473
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGAUjgDU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UtmUjltX48rm; Fri, 20 Oct 2023 09:34:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2515C70471;
	Fri, 20 Oct 2023 09:34:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2515C70471
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 020D8C0039;
	Fri, 20 Oct 2023 09:34:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1E61C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 960394064E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:34:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 960394064E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGAUjgDU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id skbFFsfoSG5r
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:34:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0A9240604
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:34:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0A9240604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697794488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tAB7Iz32RgXSddcXY/V5m8QJyFvIuwe2gAktuOJNjXM=;
 b=hGAUjgDUN4f3W053A6yHz5fbsb2NGXv60/0oLgTvCaCUGZ7dxUr41RTUXNaOnmTij61MgY
 uOwiaFZxZ2cI8lCxsc4AsI3sWiNze3596OISGuSnJw/pQEx1ZZaXeahMUtjVUWeSQwYNIm
 HQ5V2BrOajstXPWmOQZwo3lJ/9M5DA0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-3s2UnrBjNJuZ2CnjBR3Yvg-1; Fri, 20 Oct 2023 05:34:37 -0400
X-MC-Unique: 3s2UnrBjNJuZ2CnjBR3Yvg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084001846eso3855135e9.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 02:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697794476; x=1698399276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAB7Iz32RgXSddcXY/V5m8QJyFvIuwe2gAktuOJNjXM=;
 b=Hx227RXVS2J4GwbXsOdhUz1AwYVNPASSVAEUvJQdS9eLVKtjkjTlHzlqg9ELsKZoDm
 2KmG69iQAqA/Xq/PlymxoN2nfwZNCCybXd7hU8rDc6iD0HRhyZFrctccJFbTyImqm0DL
 i3pzlvkZM1c1WfW7lMk9wFsYshKTA7p2XdG/ACb9PpVxnTTZddLN72eCfrKfsXsruqPB
 YyC0JyH0H1hJQIShQXqErnnreYFO9A+ZtH1WN0KoGx0VJ4LP9rHCp8X8s6YjwbbxP8bb
 4UFGIKh0naBtaOQBj1k7txE/Dsx1QFC5H+2V5oIXwMQw3ugVRCZ0hXqnWygV4DJyDN60
 O7Uw==
X-Gm-Message-State: AOJu0Yz4GYwtnLVgL9vyDxKtOHm2eABDfKCKMRzM1J49JeyMOeBTDK7x
 yYag5qaBe+qRwIiFaSBMIjQ+awwDPV8OAzzamKGVmPX41FOn4jIZFPtoJVkzQbM05HKJISVvx7e
 KLbe5AvieLO5eoG0raKM3vOl0M+k9hWhNbSHw4O+PIQ==
X-Received: by 2002:a05:600c:3111:b0:406:8491:ec2 with SMTP id
 g17-20020a05600c311100b0040684910ec2mr958411wmo.15.1697794476057; 
 Fri, 20 Oct 2023 02:34:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4API/mXl60/J/SzspOM0lDrt9ZQKAaYMDD+MpiY1h5LWvzInLOfYWTEBlY+tciVYRMLzAyQ==
X-Received: by 2002:a05:600c:3111:b0:406:8491:ec2 with SMTP id
 g17-20020a05600c311100b0040684910ec2mr958402wmo.15.1697794475694; 
 Fri, 20 Oct 2023 02:34:35 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c228100b0040596352951sm6420179wmf.5.2023.10.20.02.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:34:35 -0700 (PDT)
Date: Fri, 20 Oct 2023 05:34:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Message-ID: <20231020053047-mutt-send-email-mst@kernel.org>
References: <20231020092320.209234-1-suhui@nfschina.com>
MIME-Version: 1.0
In-Reply-To: <20231020092320.209234-1-suhui@nfschina.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Fri, Oct 20, 2023 at 05:23:21PM +0800, Su Hui wrote:
> virtqueue_resize_packed() or virtqueue_resize_split() can return
> error code if failed, so add a check for this.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> 
> I'm not sure that return directly is right or not,
> maybe there are some process should do before return.

yes - presizely what virtqueue_enable_after_reset does.

Error handling in virtqueue_enable_after_reset is really weird BTW.
For some reason it overrides the error code returned.





>  drivers/virtio/virtio_ring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..cf662c3a755b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2759,6 +2759,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	else
>  		err = virtqueue_resize_split(_vq, num);
>  
> +	if (err)
> +		return err;
> +
>  	return virtqueue_enable_after_reset(_vq);

So I think it should be something like:

	int err_reset = virtqueue_enable_after_reset(_vq);
	BUG_ON(err_reset);

	return err;



>  }
>  EXPORT_SYMBOL_GPL(virtqueue_resize);
> -- 
> 2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
