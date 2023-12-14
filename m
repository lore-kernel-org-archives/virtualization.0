Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD938DF4
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNzOCmwa"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E5AE61B19
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 09:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E5AE61B19
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dNzOCmwa
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FtenGDFXvG8i
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 09:57:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 42C2A61B11
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 09:57:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42C2A61B11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702547860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VbNgQOlqA6uJ+zRh1fYoyaXPvn6oHay0OVtTkel+hcE=;
	b=dNzOCmwaYG34wVnSo4he7SuJeN0I6t05Q2SdXuGzvyAjfcRM755tPdwsn7oNVc5ABdT04u
	++T19RG+7YmS6LI6V5AVToNvYB1ON1OIY/Emqlev1RnNf635nzsloznF0hJ2KSsJOgsb+q
	7knzKVSce0m9o0SjWHcFxwqoovuhatQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-UzezsglKPYWOGEDFjrU3AA-1; Thu, 14 Dec 2023 04:57:38 -0500
X-MC-Unique: UzezsglKPYWOGEDFjrU3AA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3333c009305so6622763f8f.1
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 01:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547857; x=1703152657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbNgQOlqA6uJ+zRh1fYoyaXPvn6oHay0OVtTkel+hcE=;
        b=ob8Y605bBcU59DPf6YsjrzG3oL25fFiNJ8YPyiR/l0zriame8tRuY6rAgC27QzgTzE
         XA42J8EsNz2ZAnPTLf1IJmM9zgtYNTjf1frp3snGf5OX01xETCPEUU+EF2Qytjz0wERx
         4liZb8DkVxB5um96dWPMBMEI4llnXTduW+xibux4dMIlm8scDqH/XwjJYHPiCkXqrGJ2
         q5qucZkILDAbbt0GUtRMw6rPe19kuM0P20/hx6jNsD/op3BAlTA48ORIuhM5hno2J6SL
         xeELaXUSPMF3H4m+PqCIjCCS2RnrYMmbfp3OdRWoOwoeapPt7VSNOdxgwA0OFs6c/fc+
         CXng==
X-Gm-Message-State: AOJu0YxpFAsgb9lx2lpWGN98HywbdCnEMJbVYExLZCIbeMVWc0tJWsnH
	ZxHTuAvoD+Fm9GFP82bNjcciKlUamWc4bzLIVIpS6sV4gx63BzaWybIgasrLuymbvFAYRJ6J93g
	8O4ZMl4DdKQf+zd8TM/3kxrvdP11U67FqKkHJ4dsAYw==
X-Received: by 2002:a05:600c:b43:b0:40b:5e1e:cf2 with SMTP id k3-20020a05600c0b4300b0040b5e1e0cf2mr4879009wmr.45.1702547857607;
        Thu, 14 Dec 2023 01:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIMcrRPUr2M5N3AZHrTn2j7CFarP7ZToRtVz3Wt+VPt0vGWHfE5JUVAn5fPT1rWcRb4rxeWQ==
X-Received: by 2002:a05:600c:b43:b0:40b:5e1e:cf2 with SMTP id k3-20020a05600c0b4300b0040b5e1e0cf2mr4878999wmr.45.1702547857326;
        Thu, 14 Dec 2023 01:57:37 -0800 (PST)
Received: from sgarzare-redhat ([5.11.101.217])
        by smtp.gmail.com with ESMTPSA id s13-20020a05600c384d00b004030e8ff964sm26261376wmr.34.2023.12.14.01.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:57:36 -0800 (PST)
Date: Thu, 14 Dec 2023 10:57:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v9 2/4] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <rambimqosesmdqnko3ttcntpzrq7cm376pln6qsohtz7phm3un@ln3ate7qmcp7>
References: <20231214091947.395892-1-avkrasnov@salutedevices.com>
 <20231214091947.395892-3-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231214091947.395892-3-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Dec 14, 2023 at 12:19:45PM +0300, Arseniy Krasnov wrote:
>Send credit update message when SO_RCVLOWAT is updated and it is bigger
>than number of bytes in rx queue. It is needed, because 'poll()' will
>wait until number of bytes in rx queue will be not smaller than
>SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
>for tx/rx is possible: sender waits for free space and receiver is
>waiting data in 'poll()'.
>
>Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>---
> Changelog:
> v1 -> v2:
>  * Update commit message by removing 'This patch adds XXX' manner.
>  * Do not initialize 'send_update' variable - set it directly during
>    first usage.
> v3 -> v4:
>  * Fit comment in 'virtio_transport_notify_set_rcvlowat()' to 80 chars.
> v4 -> v5:
>  * Do not change callbacks order in transport structures.
> v5 -> v6:
>  * Reorder callbacks in transport structures.
>  * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
> v8 -> v9:
>  * Add 'Fixes' tag.
>
> drivers/vhost/vsock.c                   |  1 +
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport.c        |  1 +
> net/vmw_vsock/virtio_transport_common.c | 30 +++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |  1 +
> 5 files changed, 34 insertions(+)

As I already mentioned in the cover letter, this patch doesn't compile
unless we apply patch 3 before this one, so:

Nacked-by: Stefano Garzarella <sgarzare@redhat.com>

