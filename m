Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577686;
	b=ULGkLJnWqLh5+ByaHMukP8QmrT25+dKepHoZi1CLQ1aCCQHz4nMk8e9YROsah9fWlmZE
	 vvl8PZZV9xEojZva072zjQ5412ZGoKEqD1N8vPKsOO8TaNN32e2dJh4ohOQVJfq8Mt9Yd
	 HPCjZUj3ZXAuoCKd9cZafvZSdnzaMwsKJr4peLPzYyqJRdKEagK7Q75XGkJALfrMCAc2O
	 uN+fIHEfo0pilkSnFdP81qcowahxS8+8KoaPli0oACEosYjeXQ47+tZvTrQojw1m0/3mP
	 IcXFuduNiSUQ6igouZpsuCr1n8BKlCI7QLPmK7TGbTwdKeR1opJZ7vkpIR6l43U+qCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577686;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=LaMrw0UGiuCnM59eNBEdevbmBZ2o/qyOQGg9zp+WMrM=;
	b=Y0dqx1CMrCoTWZKHcuBcnMHYyc/aMUhReiDU3fWoeXzQqeMtE4/hyMEZnlC+xG5sOg6B
	 8D1EM/M2WK68blUNp19YGAt/jLIXr/gMQqPdeBhor6BfAJ+rk+cupy26lSxXu4iUL1m2U
	 exOL/3l27gNlOW14wjpmmsbsHxMwjY4aOmiQ+7IceXcNKr3L6sNi2iOX4JmAHT8/mOYIc
	 Lpfbgi3g6mtWIFjJPOy3Ldz5OHawNiRJ4QgB5M9JRq0k0G+FDIHDao675VBlibW1wAERp
	 wmHOa+Qelbl7G4hU20mE5Tq1mu0pofc1Sosc3W6R9a5jmckiPccEUFykfCpAPYftDhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TpixcOcI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF1606A31D
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 10:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0FF1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TpixcOcI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792577684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LaMrw0UGiuCnM59eNBEdevbmBZ2o/qyOQGg9zp+WMrM=;
	b=TpixcOcIc+qEmEDiQ0FLw+S+qtpggT3NqH0RIXuzC8XKV/f9YbgNr3ahFBE7fZ+GDb2aiM
	MJ8Tu/HXmRNLwBcF7ACuwPEadiowaMAmgZJ/st10hS9I3uA3Zr1aRYCnlG+rN/XIpsvwi5
	q+58VurQ3uB5vhiS4wynDKnC3HLs7QE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-JLe91Y0ZOnqsy_1shIqZDA-1; Wed, 21 Oct 2026 06:14:36 -0400
X-MC-Unique: JLe91Y0ZOnqsy_1shIqZDA-1
X-Mimecast-MFC-AGG-ID: JLe91Y0ZOnqsy_1shIqZDA_1792577675
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4870142f030so317916f8f.2
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 03:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577675; x=1793182475;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LaMrw0UGiuCnM59eNBEdevbmBZ2o/qyOQGg9zp+WMrM=;
        b=u1ty0PGYh7nobZkIJhJigYyRj0JGE9iNAvYnyTq5P9QWJ4tvqbK1xoesYfHs2cPA4W
         +C3Z/dtERGoyxLwLta2KG5z0djj0sEoeyICtLdb5iTSLDRd+j/l3zEzhuPR/ifYQeFqL
         2lHv5uQXnDkFWTYafdcmM1oRn0dh0/n5jA/puJcT8avDLAjTfVq5W4X5TkUtFvsDpocH
         7MCyDrvQn2LoiwGIYoO3IVZvi5CIgzsE0tooMQrcIkzU/6Q4nPhpf2IBUIrpEZArvcP/
         p3E5f7hyev5cZXMJrqRY+EeBfWv3DX5it2SMgCa7xYjuzVEijzmVmDtU8nZlPvWi6cWg
         B0dg==
X-Forwarded-Encrypted: i=1; AKwUvBwIdjVFu0jJ84xDcK/1NWGOn223svNDEaP/54ihO7gji0cGoz0PUzWT6xMiCCwSSB7QBiD9ncBC84bTF48nJg==@lists.linux.dev
X-Gm-Message-State: AFq9FYI9vvjq15D6T7jvIFEoj5w0oSfkGUl8ubLyD7yDRTKSE77ulLpW
	40qnrWCcJXU+3L3i5U1B6cE4BxnD11j1XIbfQhbb6TiQI349gFHPXAcMdeHI6NYGb8JALsv+rLp
	Vn7AoAs2PNQcwhS3jYCUUfpIoUVzZIQY/ZZzLcpzORhwTVzr/EfNGKOsRlfrkDeBfqXef
X-Gm-Gg: AYBFou0WWV1rFhYuoHLoOaxfMDqhWnCDeEY8K7SoC/+99agkZwedrKYGhpG7+3Uli6Q
	ETH5v+hVy/6B/zIrOknCsCnZsHWcQlb66/KjdnYVVgyhV1soCcW0g+3YeOkkgznUVEGG9Min0Zb
	6sDeBSwU6z39ggO9vr4L6Hhi+WxBRNb0yrMyoe3xSbJxJJucr5GTzlUSrQH0EVU4S1Ptf3pBzcn
	9XeXNNshAPQUDk9H1k0WuXZJe5+vJMG2W3Z8jrwq3X5vPUBg7wIAB4ACMRyshN6PFH3UVV5i8NN
	L8EOXOWTIuwADQw7GZQHBXMDm9mrrQsFm7dzGPHAQU/gjbSab+QwA0SeUgskxkz3GCu3eCKyPZz
	nYmFrrA==
X-Received: by 2002:a05:6000:4213:b0:488:8931:b1b2 with SMTP id ffacd0b85a97d-48e264bd584mr3754095f8f.28.1792577675507;
        Wed, 21 Oct 2026 03:14:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4213:b0:488:8931:b1b2 with SMTP id ffacd0b85a97d-48e264bd584mr3754032f8f.28.1792577675060;
        Wed, 21 Oct 2026 03:14:35 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f0bc2sm4512724f8f.1.2026.10.21.03.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:14:34 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:14:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v4 3/7] vsock: pass the netns to
 ->has_remote_cid()
Message-ID: <atiQfOneKTIyhGHX@sgarzare-redhat>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-3-047527cfccfc@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261020-vsock-guest-ns-v4-3-047527cfccfc@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sfgNezDYEhwy0ln_HQAnBe8mD1nZHsZyyaMa-ZnOMYI_1792577675
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Oct 20, 2026 at 06:15:06PM -0700, Bobby Eshleman wrote:
>The transports only use the socket to find its network namespace. Pass
>the namespace instead, so that a later patch can ask whether a CID is
>taken in a namespace without necessarily having a socket on hand. This
>will help with avoiding CID collisions when devices move between
>namespaces.
>
>No functional change.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> drivers/vhost/vsock.c            | 4 +---
> include/net/af_vsock.h           | 2 +-
> net/vmw_vsock/af_vsock.c         | 6 ++++--
> net/vmw_vsock/virtio_transport.c | 2 +-
> 4 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

