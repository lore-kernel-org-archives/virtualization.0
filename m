Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F514883B
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257087; cv=none; b=OKbLPxd2iJN7BoQJfSwN2ikOfuYLcTw9CQwch5rzeSyFFWJkhyRiG3Asu93LDry0Lr/iDwcITUGGtfG+NIFd2hzOzZj6YDH2AQA85ffYB/rXM6jSnW40Hk96LHAx/c8mmwKsxy1lrSEeiqkOd1PH8YLzW1lqI7UX5WtkqbYJIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257087; c=relaxed/simple;
	bh=5mbYS28kR+anl9LddH2GIect/DwV20q0RBYiy+oebfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eNJUlUVJbl6P5zfLlbZp9Wvfx0nzE/gwKghpd3GcqzQR2/+ROe/B5jWtJafcmxwuXH+fQ8tVdOsuxOXfS0OaHaefZ5ayPgq0nJa5A3083t1e03GcIZAdgm8vNVocvxr69mQ4Bu0DUc4En4pjMQirujkP+pI0v28IZcOmiw03Zzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3bc1ajw; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3bc1ajw"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8279E80BF8
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 12:44:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K_VdiJfpsNmh for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Jul 2024 12:44:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BA8AD80B9B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA8AD80B9B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C3bc1ajw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA8AD80B9B
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722257083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=imU5JWIdoIr0tLfxDfEeLPjwXwqe1TCwz+4f/zgzfRE=;
	b=C3bc1ajw6FF2exRQYE5ZNqNvs7jyxKv6MwqM2O6OYRecl6JhYd3sDXYwzERgU3FA0JkHA8
	StIKjBtUyywyugwBkby4yQVE8WDWMP6X/UcL9SBr6yyI2rlERG5h1RRnGYuvyJAoRJXHjF
	Z4hOCjhOSo8D+GH6QCeBlpVGrV8Vpz0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-b2NHRvN9O9OWEZpxkfrOVA-1; Mon, 29 Jul 2024 08:44:41 -0400
X-MC-Unique: b2NHRvN9O9OWEZpxkfrOVA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3684ea1537fso1454689f8f.1
        for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 05:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257080; x=1722861880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imU5JWIdoIr0tLfxDfEeLPjwXwqe1TCwz+4f/zgzfRE=;
        b=bRe9GDYDfySstoe4rsUtF0dWUcEMTNAXsQ9iio2+ABxuAiHXYiR/Ofb77YyinNZuZ3
         CrBYi0kOfs1RCV0gvbYbVbx2+dDo7iQY0OD4rSIpQRGBzK+gadH4rgMZThUmY7bX5HKW
         598QirMxbg9yfp/xXPtRFrwVzx11E62dwzqSpYkpdUAMwvQ8zr2C7L6I9MsUH5EsrY9d
         +TN4kJ2AXEWr892iE3Qs/xMnUltikhsHGQkSpY3c/rVbnffffULfdQ8RrWRX3Ld41RGK
         Lppi1F9xxqTsVQjl0DYYYnVE8Y4CfMWQyfQBkiUm5ScB8ve05a9bfuJcjsj2EwRh52Tp
         CKYA==
X-Forwarded-Encrypted: i=1; AJvYcCUIXX6pNU4mWMbFHHmYqmGSclFovugn+Cjajl4oHVz3jckzU2WrzOMXUo3pmG73Ae29DyB2DYhJ47qn+ONHzk0iljg3cfY75kdu3G+7xaCNdry9XGPG997cOQ==
X-Gm-Message-State: AOJu0Yy9gRa2pI0DNDEjCpLHxHLP26Vi4cCRPNSMHXadnMcNSawlXusY
	TOkeufblJ/jtXX16d2bFESfzSiS+7InZw77evwqAENU54dfxVYNNIH2w6kx1gT+/zdZ24+PLbAi
	FL0gms9GNKUAA3D3XxY7T2frEikkCQyemCi2mgg3MJpSH90CiLtXShbo65u7lQXzAVYO1k4/A1X
	3DqL8=
X-Received: by 2002:adf:fe07:0:b0:367:958e:9821 with SMTP id ffacd0b85a97d-36b5d0d1002mr4391901f8f.29.1722257080417;
        Mon, 29 Jul 2024 05:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaJJDIOyE8oIlYOdXwKaZY62JoigjIwdVZsp9HQ8Tass/f0PxfO6xtI8+Zomu1LS9HO70CTw==
X-Received: by 2002:adf:fe07:0:b0:367:958e:9821 with SMTP id ffacd0b85a97d-36b5d0d1002mr4391872f8f.29.1722257079783;
        Mon, 29 Jul 2024 05:44:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9a3asm12002314f8f.36.2024.07.29.05.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:44:39 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:44:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH v1] MAINTAINERS: add me as reviewer of AF_VSOCK and
 virtio-vsock
Message-ID: <4hzlvcppr6t7g3shaghr5w7yv7lvr6q3p3h3albzv7xrs6xsfs@54fx34dq422x>
References: <20240728183325.1295283-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240728183325.1295283-1-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Jul 28, 2024 at 09:33:25PM GMT, Arseniy Krasnov wrote:
>I'm working on AF_VSOCK and virtio-vsock.

Yeah, thanks for the help!

>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> MAINTAINERS | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index c0a3d9e93689..2bf0987d87ed 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -24131,6 +24131,7 @@ F:	virt/lib/
> VIRTIO AND VHOST VSOCK DRIVER
> M:	Stefan Hajnoczi <stefanha@redhat.com>
> M:	Stefano Garzarella <sgarzare@redhat.com>
>+R:	Arseniy Krasnov <avkrasnov@salutedevices.com>
> L:	kvm@vger.kernel.org
> L:	virtualization@lists.linux.dev
> L:	netdev@vger.kernel.org
>@@ -24370,6 +24371,7 @@ F:	drivers/media/test-drivers/vivid/*
>
> VM SOCKETS (AF_VSOCK)
> M:	Stefano Garzarella <sgarzare@redhat.com>
>+R:	Arseniy Krasnov <avkrasnov@salutedevices.com>
> L:	virtualization@lists.linux.dev
> L:	netdev@vger.kernel.org
> S:	Maintained
>-- 
>2.35.0
>

