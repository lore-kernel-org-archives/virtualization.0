Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C2397689
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610610; cv=none; b=l05UzLnAtg7t8FqBsCHVf06nrbom2EnUs1A+DnPS6BBXdHeNzBgbYIvI7uhAO916q7uxom+r+7B+MKgXf3ud2GpUwlfJH0BnJ3iZk0ARCHDLwOLS07Kwfo1zkb+ivv+QrazakeWRzl4mv/7yjNuyAWUGdMEdR1tYASX1i/Yg3wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610610; c=relaxed/simple;
	bh=7eh/tEEaVVT82VWXjTL8vLLDWxnKGlVuFG9YrOF+sW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cB2aM1RErifBys0BeEd89eB6BT4K9QFJLK1zX4vHcmdIHBMH47g7qXEvhTcvfbpr5PsaABoCZu1Wp0k/b56HONhS/9WStdAa3ntQcDbxmB6ylVuwo5d3MokZJCI0P5GoyNdF2/dQhaM85TtCDi/jwGL3HG8xoYRAwaOnATeqpaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUkJAhsD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUkJAhsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786610604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w06Zz5eZ4ZoMZ6QYcdF6VhN9WY/dFLXdTr47WLmeFiU=;
	b=gUkJAhsDikP6IEyVsZjxI2hkP1Wo1fkynM/R/1XWS9yocdS/GO+PBQ3sXkEyCM1rfNbgVw
	L4loGl4pZRYAXM6B3Xsv10FyMEyTuHFHw4tnxqY5YD9CEXuSFMm4GqXTjh/CNKorT/01Lz
	hWBIBOeNLEf/8lcCld3q7jQuwYMriCM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-YHYm_aXZOVe86qnj6LUkeA-1; Thu, 13 Aug 2026 04:43:22 -0400
X-MC-Unique: YHYm_aXZOVe86qnj6LUkeA-1
X-Mimecast-MFC-AGG-ID: YHYm_aXZOVe86qnj6LUkeA_1786610601
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49808ea1b64so7896015e9.1
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 01:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786610601; x=1787215401;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w06Zz5eZ4ZoMZ6QYcdF6VhN9WY/dFLXdTr47WLmeFiU=;
        b=TAW1dz2XSTUuytNNXjp7B9qKaDmdQlLDLbFqZbJK969BAFxkMnrVCMlXCureUiQ7ON
         rck2Bh5rorNqHTeXsJy5cQi7xjn5Ew6uruvn3X4jHiwQoaH5+FVpi1w4huUpbLcypuh2
         DZY+QamCTOtSAYuZgyEdsCF0PbxzP4kOj4TDxcIlC69zOLzrMoWp9qgx+/uT80P6ezPz
         IydBMO3QMVmlBSHbaurmazbQrfKRESLRtDKuOCQn7Y8jaGBtJT5BAfZCTGDfQisatASu
         Nldf5VJAPoVX5FTQKeiz7b7iUgfZQ9OVLxhor34SsAEnloDn1WZt3ieDWejpU70Z+YHy
         B6MA==
X-Forwarded-Encrypted: i=1; AHgh+RqN0v/DRvDDHYOwTKbl8wL2mfdDjVXGooZ8O5Maqk8S+iDiKDMQpWMBSF1HAXBl0SzM85Dctlsjc4Xl1OrOKg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7SwIu6+UU0qdVJtOwPsnNif9i4gZf+z2iIwMQosq0PweT5djS
	+mnvmvD+vIlhH4pN5XhYahwet8+eQZzdKQ/zcQnsgbpFhaxqnnCVwe5xQ+jV3B6JA/xa2Wyp1WL
	93Ly21B5XDPv08DPRg5cipTw11IcPVeCj1vUl0IaT0xEltXL05XZL+zwWEH1AY12t3DTQ
X-Gm-Gg: AR+sD13UgI4qB1HI0ZWs5Cy+7GnIhZ/8VI7159x+/mu80Srbu0jTITBBn+q2E/MCUAh
	+o+PjyiYHDYDzC8mS5d83JdmzigTvPNXpdA1ns8tCvT9eARWp56cVB55ScbsS02+vMk721+ohHK
	XSLtIc+EuukJJ/hX6s1U6zDqmKPoUCyL3teL9aahx5h0ZU/cOaDjxlr9nD79lQyuG5zG5H1rPbI
	hTLrRetbOKkg73cQa9k95pSp7wGv8v31mBQnbQOlfpGsICRKX1NqU41FdDmZqQbGTMvhnly4rUu
	lsb0btcKJwwnBaeRwKlONFBOuW56Pji/pHIFCD2nCMfnNwz2dM2l2aU6r2I7b5woHSaGniL5nuJ
	Dz9MJJGo/9IlQTxCqFOVIsXbfsZaEs+7uULFbFfKZ9Bn0A0tLXh67
X-Received: by 2002:a05:600c:4708:b0:499:596b:2e91 with SMTP id 5b1f17b1804b1-49982200a77mr35404285e9.3.1786610601128;
        Thu, 13 Aug 2026 01:43:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4708:b0:499:596b:2e91 with SMTP id 5b1f17b1804b1-49982200a77mr35403785e9.3.1786610600655;
        Thu, 13 Aug 2026 01:43:20 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b0f6b1sm48409915e9.4.2026.08.13.01.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:43:20 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:43:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Wupeng Ma <mawupeng1@huawei.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] vsock: use sock_error() to consume sk_err after a
 failed connect
Message-ID: <an17EsASX_Nn8wxi@sgarzare-redhat>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
 <20260810170935.2242314-4-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260810170935.2242314-4-phind.uet@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0NveD0vwnITLgvosGcEseCC25dqj0cKGW-_R5lsyYaA_1786610601
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Aug 11, 2026 at 01:09:32AM +0800, Nguyen Dinh Phi wrote:
>vsock_connect() returns sk_err to userspace but does not clear it:
>  if (sk->sk_err) {
>            err = -sk->sk_err;
>
>For a blocking connect() the error has already been delivered as
>connect()'s return value, so leaving it set causes subsequent operations
>like poll()/epoll() to keep reporting POLLERR even though the connect
>failure was already delivered.
>
>The error should be consumed once it has been returned to userspace.
>Switch to sock_error(), which reads and clears sk_err atomically,
>matching the behavior of other protocol implementations such as
>__inet_stream_connect().
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Tested-by: Wupeng Ma <mawupeng1@huawei.com>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

