Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9539DBD3
	for <virtualization@lists.linux.dev>; Wed,  8 Apr 2026 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635968; cv=none; b=Pk4AwHvHtqwNaLu3pfwc/kY3pDO4K9kcdwUojSB2HEvXcmCLd9LQDr5ZtQWpr5ALZZkOESWqWNQODvLiQe0LekAo/NvCpoEKifgAIsDFlUsP6p5YFYwtAWhOvXBkneWtm/kicyrAY7MQ7X/PbeMFaGt4xl/Yr0upawr3Er6l3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635968; c=relaxed/simple;
	bh=RiCBBjqJ6U8+nG7CHcXztQnXvaUlmfGwoy/fj7EupJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E1ja6koHlzr7SWiPWb2GzrnQ8EQgspKAloZpazi46jnTVR6I0XH0Kf22jFp+QwG1hJlNjOGenGFMCkNfYCZBeCmgUDBMucMFNNtDm4O9Hn+DlZKj1nFyoPtGvy33L6Ojze6GgkBGyVeFVuFdcMb7cXc4bSr+xo9oDe2hrxszm2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RG6UmTWA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RG6UmTWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775635965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3Abwh6EeEcrZMTQmkJv8CKYZpVXeikipJN0c4fSKWE=;
	b=RG6UmTWAiM903K4aK3JVWXCuGdtfmvdSk0M+VPVWPc/YULnHQ7BNbp0HlvR4dYphFWXP+c
	OKCk8ekAKi+J8P/wOx7e/Wa/GA73ETtxN2edCuxZjr5xnAwPPvg48LlZuyXza3ArV5d+ML
	GmMeZixT4OikC2OKPUY1hoCYDa2AWJI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-59I8iWHjOo6s1Z5rg6rH3A-1; Wed, 08 Apr 2026 04:12:42 -0400
X-MC-Unique: 59I8iWHjOo6s1Z5rg6rH3A-1
X-Mimecast-MFC-AGG-ID: 59I8iWHjOo6s1Z5rg6rH3A_1775635961
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b99add7f3so423872f8f.1
        for <virtualization@lists.linux.dev>; Wed, 08 Apr 2026 01:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635961; x=1776240761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3Abwh6EeEcrZMTQmkJv8CKYZpVXeikipJN0c4fSKWE=;
        b=BdjuRT4aY8G4pdMoEw3oGUWVCSWoEeR/7jiY3RcthAi8V8iYN8lx5ERHt9QPG3hLpq
         rT3GST9zLb6lFyI0jZWt+hP14bzDkIL6OHH/Lw+0a7m94Ivrzrczr/wC4s+Xt+mm3lfE
         QVCM8nrWdZmXup5dvaPUVtiuqy5KDiNjwG8V8ons/LzJqvNP0t3nHJ0TQZ76CfBRq/DG
         hJH+EqaasTBL9I1g7yMyIy0VllfjixBGIi89swzMH2bk8gJzhcVSAT3X7R+Egc0RXWW7
         H/nQZ8J+Fda2U+l1mbNtFU8WrWZ+Dz27iJ8DwooRDaf6LkAniGydSa0LX/vsAd6/1Uoa
         YTEA==
X-Forwarded-Encrypted: i=1; AJvYcCW1QSrs+HSp0lcMZ28PgVbeyRIc6ihyLa5nlfgirg+0kANnoUX7+nwX8P75GCxMBylvJnZoXke4nffd+rubzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH4GGYPEs5ENN4kEGDqNEYshI0ASlyi2gtphpgd8sq2vYsJRs2
	fT2wGWzFvwxqhYiq82KoNjXXezE33a/hH6szzynHJHW1uLqFD+a2XpW3Mnn/rhJYf11kxQUrUTC
	DTuVNKUgOeIuO4mnaRAL63zuFDNjzRqtKEuC3U5hBQklvwO/EJqvkfDcunCP5ClTJi5kf
X-Gm-Gg: AeBDiesLtiJrFyllG6GTC1Oj5koppT75eBjMOG6AcakkpBakn4MIStBw4hfk8DI4CMk
	Gekmct+wIthtXm2Jd4V1H/+ht2dyFWMWtuk6gG84nkpZUtWFOanHugFrpIouOL6pJVJ9/NX5E9t
	wbnWkLZ91/WjmwbGxd7jWPXECcwPIioO0SEPZDv2BOkV0T6i48CQ85CSpTVqb+9xHMnAzqOvimg
	u7tUDnxYNOkGDIrsJx5wUyfNGqszsY5gwlLSuVf22mMx4eHt2ficCTQQye39PQ8JByBgb+ZTeVN
	27xQ/3+2EmGjm4txhNXY22S2hDBiR6Y3IrQZ1qwtO1tSW0f9jds94AjiGYXb20siQlpXXqdTSxD
	bMC3JEvG/pXBse7d28oyN9dpmN4YyKrh9y9mb9L27pzJZoP3ZHU4ATULbxYTVYoz9eBoCGGrGZg
	==
X-Received: by 2002:a05:6000:41f6:b0:43b:a16b:ee69 with SMTP id ffacd0b85a97d-43d2124e1f5mr31165880f8f.24.1775635961066;
        Wed, 08 Apr 2026 01:12:41 -0700 (PDT)
X-Received: by 2002:a05:6000:41f6:b0:43b:a16b:ee69 with SMTP id ffacd0b85a97d-43d2124e1f5mr31165826f8f.24.1775635960583;
        Wed, 08 Apr 2026 01:12:40 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d214f2b63sm50930205f8f.28.2026.04.08.01.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:12:39 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:11:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adYNUs3pmVmQe7pk@sgarzare-redhat>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mpcsi-7AZV-4Iu9FqZfG26QglMjDIxU0DqnZZEfoEWw_1775635961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 07, 2026 at 04:31:56PM +0200, Luigi Leonardi wrote:
>`virtio_transport_send_pkt_info` gets all the transport information
>from the parameter `t_ops`. There is no need to call
>`virtio_transport_get_ops()`.
>
>Remove it.
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>I marked this as net-next material, but honsetly I'm not sure if I
>should have targeted net. It's not a bug after all, it's just a cleanup.

The patch LGTM, but as Michael and Jakub pointed out, better to remove 
Fixes tag if this is not a bug fix.

Thanks,
Stefano

>---
> net/vmw_vsock/virtio_transport_common.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8a9fb23c6e85..a152a9e208d0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
> 		return false;
>
> 	/* Check that transport can send data in zerocopy mode. */
>-	t_ops = virtio_transport_get_ops(info->vsk);
>-
> 	if (t_ops->can_msgzerocopy) {
> 		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>
>
>---
>base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
>change-id: 20260407-remove_parameter-f61a3e40cf90
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>

