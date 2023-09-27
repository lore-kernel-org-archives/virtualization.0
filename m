Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78D7E82CA1
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 15:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 518556153E;
	Wed, 27 Sep 2023 15:20:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 518556153E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AcSl4GSD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nNfUmRyrwU-a; Wed, 27 Sep 2023 15:20:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DB7D961431;
	Wed, 27 Sep 2023 15:20:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB7D961431
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCE6EC0071;
	Wed, 27 Sep 2023 15:20:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05D18C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 15:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4B8B4197C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 15:20:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4B8B4197C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AcSl4GSD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6g3As_OykAk2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 15:20:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 257F741970
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 15:20:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 257F741970
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695828015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/EIbBjpy9O83n9qhTihg7QeV6q2TpAQGQwYAPKsUVIA=;
 b=AcSl4GSDqNEYsaKVTCbdBah5/Ycpze7ED0A7AFI3hu0rvtoVJo/WgX4zzWzgjMYdgJoPXG
 606H8IFndOa71wYUqfbfapCt2OlKzrHiZ/Yat0K2JVAqOnWphjjmLlQYkAbHTDA0jouZgb
 c22n20Fw0nsKENC/FAyg79xIIohi/+g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-bTUqLj-9NwGLkeoeSgSGjA-1; Wed, 27 Sep 2023 11:20:13 -0400
X-MC-Unique: bTUqLj-9NwGLkeoeSgSGjA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-315af0252c2so9267027f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 08:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695828011; x=1696432811;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EIbBjpy9O83n9qhTihg7QeV6q2TpAQGQwYAPKsUVIA=;
 b=GFGdZaXxGXLf//tiG+USJK9yYvfdy+zdl7jAvYMD0y0wF5lLaZ8y4L1Tc61OXQAAaa
 JFAewxCFYkUOEJnw0krePFjdUPckTJtYqWo4s3JDnwPYV3YmO++ut7GSC4VQ9YVP7NP2
 Apt1u+T90/ZsV7YXYUcfAoGgWLwiaxxXNrOr3GylmyYB0hFAkjity+PPyBS0fBBR1+Iu
 SRXAr1l8nnfZz3102Jo/B8V0MPs4MfbaTl7/b+PPrrRjWL2DyA8FvCpKpltcGJvKdfBz
 O87nYA7ft4UbgzVajK3IO6LwziSpR8bm4Y768qXoDiagsikoG/nhLpm0DHC0Rv/zdmeG
 yHOw==
X-Gm-Message-State: AOJu0YxnQFUu965no3WX7WAlsdRX00eTgVga/PPXyEy8V5AiGZi/toLM
 X/+DJ9YJHN5/gVKZ4OLYZDeMusDrZ8fWhwI/430boGSI0Q9kYJra8KX0GSnRKcGcYyJ0haWMrT9
 wpoZlkK9K/av/UatTW8H0j+MwIoqGDs/BokHMgUC6tQ==
X-Received: by 2002:a5d:4cc7:0:b0:314:a3f:9c08 with SMTP id
 c7-20020a5d4cc7000000b003140a3f9c08mr1876010wrt.39.1695828011764; 
 Wed, 27 Sep 2023 08:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdjsQhdmBlcldN4VQo0/wB1Ma3pLJGSeiqWpRsH5/5aS/zWnrBptxpvSLI02eGQaomR+j8gQ==
X-Received: by 2002:a5d:4cc7:0:b0:314:a3f:9c08 with SMTP id
 c7-20020a5d4cc7000000b003140a3f9c08mr1875993wrt.39.1695828011418; 
 Wed, 27 Sep 2023 08:20:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:b9f6:556e:c001:fe18:7e0a])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a5d6511000000b0031fd849e797sm17324370wru.105.2023.09.27.08.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:20:10 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:20:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: liming.wu@jaguarmicro.com
Subject: Re: [PATCH 2/2] tools/virtio: Add hints when module is not installed
Message-ID: <20230927111904-mutt-send-email-mst@kernel.org>
References: <20230926050021.717-1-liming.wu@jaguarmicro.com>
 <20230926050021.717-2-liming.wu@jaguarmicro.com>
MIME-Version: 1.0
In-Reply-To: <20230926050021.717-2-liming.wu@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: 398776277@qq.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
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

On Tue, Sep 26, 2023 at 01:00:20PM +0800, liming.wu@jaguarmicro.com wrote:
> From: Liming Wu <liming.wu@jaguarmicro.com>
> 
> Need to insmod vhost_test.ko before run virtio_test.
> Give some hints to users.
> 
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  tools/virtio/virtio_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 028f54e6854a..ce2c4d93d735 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -135,6 +135,10 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>  	dev->buf = malloc(dev->buf_size);
>  	assert(dev->buf);
>  	dev->control = open("/dev/vhost-test", O_RDWR);
> +
> +	if (dev->control < 0)
> +		fprintf(stderr, "Install vhost_test module" \
> +		"(./vhost_test/vhost_test.ko) firstly\n");

Thanks!

things to improve:

firstly -> first
add space before (
End sentence with a dot
align "" on the two lines

>  	assert(dev->control >= 0);
>  	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
>  	assert(r >= 0);
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
