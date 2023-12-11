Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A113AF7
	for <virtualization@lists.linux.dev>; Mon, 11 Dec 2023 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMw7ytCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702312427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bzIkbZpiRzJdrc6a6vDeJqlwsyKzW2Z5OW2xriwEAsQ=;
	b=IMw7ytCLi2monybRlcj8JSOMhfyBFpVdwa5MKXWH0QkExQlITZpPmU0y/JmYut2WGMJzJX
	RsLdMMMl+1J7z5rK9AtJQbSa33UNBge8OlZyqpXe5kgrWnagiGbGQKX7pIRXhdgR7bV6uu
	rK7w3p+xY0twgeYmuzIvWAeAELm6P2A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-PGmofqVwN3W0X_epWFAqog-1; Mon, 11 Dec 2023 11:33:46 -0500
X-MC-Unique: PGmofqVwN3W0X_epWFAqog-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b3d4d6417so30235525e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 Dec 2023 08:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312425; x=1702917225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzIkbZpiRzJdrc6a6vDeJqlwsyKzW2Z5OW2xriwEAsQ=;
        b=OZxQkcrqz+jWcEFme9mxNZw1zTb6+Tear5LofP+77Miu7+KbIUsZrK1N2h1KgG5ARw
         ztRTSVAQvUgTlitqwNtUd89wiOCQhRwmzMLsONhkmLVhM+1CEl+uxAm49c1TXSuNWYcG
         JxHbEDDZR0PiHtIj7hdmV/wxiI9ZY4WWrrSrj315r6DwCraj3k8g4z19n7+UA9ptEpII
         AY/cgUmVUcvydVPWtxrw11hDSrK0N4Rkf+R3ZujYs2HsK0XDOs7coB2nY8cZjjnMMFe7
         29kk6NSGcIH0JfbMpKC77JbUHIht17TtCbv+x0piQzK6rzCoGr46tikJRVav+dF+Wjqz
         KTwQ==
X-Gm-Message-State: AOJu0YyyPv60eKDKTiRk88kY3bY7DcH7LEWOYgLRAx9kPG6sNrq5TF5V
	ILzoHQXjKXGTtpz8cknONuJeLriNemf1e10mbo5yTVoYVmGGNdfHWNMCmP7UeO0aPl/kIalhMbk
	Et7dO01sZKuFIenX/vzZDimEmx9s=
X-Received: by 2002:a05:600c:501e:b0:40c:25c7:b340 with SMTP id n30-20020a05600c501e00b0040c25c7b340mr1172682wmr.281.1702312424867;
        Mon, 11 Dec 2023 08:33:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVGkZ4+oYYezirnB3Q25N7aHGvQW9MmXB7XVlCjjG2JGiHt8ONICyX4hMLT/PJy3biQX9FqQ==
X-Received: by 2002:a05:600c:501e:b0:40c:25c7:b340 with SMTP id n30-20020a05600c501e00b0040c25c7b340mr1172674wmr.281.1702312424427;
        Mon, 11 Dec 2023 08:33:44 -0800 (PST)
Received: from sgarzare-redhat ([95.131.45.143])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00405c7591b09sm13524344wmo.35.2023.12.11.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:33:43 -0800 (PST)
Date: Mon, 11 Dec 2023 17:33:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2] vsock/virtio: Fix unsigned integer wrap around in
 virtio_transport_has_space()
Message-ID: <nuyxku7erp67jjs2uw4kpufwxcgdrevl2lqys5fyltzgz6ikgk@3db26gkjghjw>
References: <t6mnn7lyusvwt4knlxkgaajphhs6es5xr6hr7iixtwrfcljw67@foceocwkayk2>
 <20231211162317.4116625-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231211162317.4116625-1-kniv@yandex-team.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Dec 11, 2023 at 07:23:17PM +0300, Nikolay Kuratov wrote:
>We need to do signed arithmetic if we expect condition
>`if (bytes < 0)` to be possible
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
>---
>
>V1 -> V2: Added Fixes section

Please, next time carry also R-b tags.

>
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index c8e162c9d1df..6df246b53260 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -843,7 +843,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	s64 bytes;
>
>-	bytes = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.34.1
>
>

