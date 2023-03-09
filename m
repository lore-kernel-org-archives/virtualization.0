Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C000C61DA4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 08:24:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB4A481EDE;
	Thu,  9 Mar 2023 08:24:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB4A481EDE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NZ/6V4ZD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iG_SAkVux5wl; Thu,  9 Mar 2023 08:24:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 505808139B;
	Thu,  9 Mar 2023 08:24:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 505808139B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B0ABC0035;
	Thu,  9 Mar 2023 08:24:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19E8BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9A3D402B1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:24:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E9A3D402B1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NZ/6V4ZD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F-KWTyYXewT9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:24:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E9BE40111
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E9BE40111
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678350258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KKd192dm2AeL+ZfUgfO3ZLwcRrb/6MAd0iIB60AdtXk=;
 b=NZ/6V4ZDDrnn4h3ktRqk4aCRe6n/b55RqRkZQlIYXOpMDKa/rD2Zyg+LNI5QVUS0qAvVNZ
 VmCY2foqjPiPuQvNINXfF/AhHIE59MqeSUarWItPvTB8P6SsfEXB68++Ug3eldCuvBGqJK
 E3I5veAUVJ3as/RGTmW3c9JMw4rd4gM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-eD23RWWkOE65-E7Tq-bJKw-1; Thu, 09 Mar 2023 03:24:16 -0500
X-MC-Unique: eD23RWWkOE65-E7Tq-bJKw-1
Received: by mail-wm1-f71.google.com with SMTP id
 l31-20020a05600c1d1f00b003e8626cdd42so385003wms.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 00:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678350255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKd192dm2AeL+ZfUgfO3ZLwcRrb/6MAd0iIB60AdtXk=;
 b=6+m3jhWnkKJ3V5gx+fmiirLuJuytM+jmM1XGK7l2kV5Xo9QdqVgqosttxbDI+t7xp2
 SBvGj7cFuRJYVqCQlTYuGuj0Sf1OrLHQBLhaka2EqiB2RJWnnZ5ekiUckYaBBwRl70Gv
 VjFQCM1pELpQoITDggVy/uqAf5+/XdoEs+KphPx1nWYnJuzvClJeCb4b+exEV+k0jsh6
 IxLAXO6luW1GbqhBwxLpN75wBf4txrqpMNOVPB/VCD9JzNJ1+OFNnnUkofCtJidG5orL
 YY5xvY3HvYHA2ZC9krXko2F4KqUgPmKsQWvSw5PnSXWH5asKWZu4nT5iK/DCzMmsBqp8
 bmSg==
X-Gm-Message-State: AO0yUKVmA8Qbw6CZOlwuapQQ6LXcixvPHAna/RfCX7W+U+WzDPNY9O0N
 9ajycls/l9AQz+W665SbPvbpT3eZtV5aXIdn0I0klfXe0/EOp9Uk1X9GvYFf9JGNiB/PAjAA/Bw
 1bWpnVaXz7vDP2hrDhrXJJpl/8+PHN0s/lMm4A4KN+EYcqIXOCw==
X-Received: by 2002:a05:600c:1c12:b0:3eb:389d:156c with SMTP id
 j18-20020a05600c1c1200b003eb389d156cmr18410277wms.37.1678350255022; 
 Thu, 09 Mar 2023 00:24:15 -0800 (PST)
X-Google-Smtp-Source: AK7set81Q5EAoFOSJYyUpDBHF44G5XfExEzpA2t/qHqCgPH7fAmK72jRNAakqfKtUPzJ2Tpk8jg1Ew==
X-Received: by 2002:a05:600c:1c12:b0:3eb:389d:156c with SMTP id
 j18-20020a05600c1c1200b003eb389d156cmr18410264wms.37.1678350254762; 
 Thu, 09 Mar 2023 00:24:14 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003e4326a6d53sm1752740wmr.35.2023.03.09.00.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 00:24:14 -0800 (PST)
Date: Thu, 9 Mar 2023 09:24:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Rong Tao <rtoax@foxmail.com>
Subject: Re: [PATCH] tools/virtio: virtio_test: Fix indentation
Message-ID: <20230309082411.nm5apbepytansfpm@sgarzare-redhat>
References: <tencent_89579C514BC4020324A1A4ACA44B5B95BB07@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_89579C514BC4020324A1A4ACA44B5B95BB07@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>, mst@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 09, 2023 at 02:13:20PM +0800, Rong Tao wrote:
>Replace eight spaces with Tab.
>
>Signed-off-by: Rong Tao <rtoax@foxmail.com>
>---
> tools/virtio/virtio_test.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>index 6e348fbdc5d8..44409a311580 100644
>--- a/tools/virtio/virtio_test.c
>+++ b/tools/virtio/virtio_test.c
>@@ -134,7 +134,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
> 	dev->buf_size = 1024;
> 	dev->buf = malloc(dev->buf_size);
> 	assert(dev->buf);
>-        dev->control = open("/dev/vhost-test", O_RDWR);
>+	dev->control = open("/dev/vhost-test", O_RDWR);
> 	assert(dev->control >= 0);
> 	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
> 	assert(r >= 0);
>-- 
>2.39.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
