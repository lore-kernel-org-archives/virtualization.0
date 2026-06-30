Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027346AEE2
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jun 2026 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834756; cv=none; b=HvDs9IxpdUQNtUppodxrlidREqxp2IqLNtsIuEP+Tnxox3d7nK0taZzwYKqnpLpc9oFXbAZZE86tpBRNruSgpv+wVqhyLK5jUaYIgOKg/QPSkvQb9YezXe7mIjJUv6+THlp68q1tyuXsAlX3CEsJGFvyQnT4wHhj+rMepe3mnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834756; c=relaxed/simple;
	bh=xAV++Nv09s0Fx3qQqUFt2hh8zlLTaDft5mA4iivYxak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJLiK5smV9s/sRgFytUqbV7gAUnefv8vPNPUudT2NFHvBQ7MAs7B6dGIlcowvujqF3nQ/Wb0Njm1aLIyF/EbvF1js2Fait9I4Xr1lZy2/2O3PQq9Yb6ZHutwdDmUq58eiQHqeH+u6Ucmh8DNCSgcTk2xeXCWs8BCRTiXjt6jGm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSpU6ZQq; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSpU6ZQq"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFFC940FA1
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jun 2026 15:52:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-YZnboHJu1g for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Jun 2026 15:52:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9E50D40E68
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E50D40E68
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LSpU6ZQq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E50D40E68
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jun 2026 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782834749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0U78ZlodXLMOImJ/ZNFyI40d4zG0e33pCvJOLPMpoNw=;
	b=LSpU6ZQq2cOBcTEpItECManop6BTe2IJ3aZKakpq1vXxkFaCTQoSD0KVbjx+f2pu9PI03y
	dnHy0wQp9MYyalgfqihcPIj0EqBIzv6Zt5fN1cRpMbTErGEaYNJ+9wVc8smikSug67h0A2
	oiHQF+LrL+qoGYua6ii8g7DelrrNh+Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-b-Omhto_MAmC4ScsBOQBKQ-1; Tue, 30 Jun 2026 11:52:25 -0400
X-MC-Unique: b-Omhto_MAmC4ScsBOQBKQ-1
X-Mimecast-MFC-AGG-ID: b-Omhto_MAmC4ScsBOQBKQ_1782834744
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493bab443f7so7639235e9.0
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jun 2026 08:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834744; x=1783439544;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0U78ZlodXLMOImJ/ZNFyI40d4zG0e33pCvJOLPMpoNw=;
        b=WPzbCMjANktHyHqT/1iByddZ430aDSJMgvKzyK+xd+Q8pQGroaO+xE/cx/64g8Hyk0
         8pq206ogdcB31hnXiGdGqhHBUZnPvjhhYT71sWq6OxaVEJHnNid54k+fZR5gET1CkOZ8
         lSORMEg3f9RmlCWSSzAhOgZXseKK2nBKh3wWlcUNbjfSCCSpZmS9vs0IHEEPmR2MGl9c
         bJmnFUJsPRK4ECYNvoJi/SL2xJJDuXlbikjp0eF3aRJ8DchaM73AIPtadzLbk+b6IBgR
         iwPGaLXATMdR5VG3UBhpQXwFL7/vggn1eXynbpe6scmVLRPNQjf/7QlGYbiY/WgkZubW
         QW3w==
X-Forwarded-Encrypted: i=1; AFNElJ9xMnEwWpMnlmY1QAYPn+IlPUJ3YgcEcCSdw1vavCawlLziMKnv6ZYI3SIZPg/csEUhvi7VtW0CfeGEUuIUiw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyBy0VGLwn0XcAOliRqEdLqRs/Z4Z4wz9etGxoEtT3SnqNp797g
	Yc4bDA5ZyHUTznvX0Sys0WvfADYfFZKW+l7YSH7DHcFy0+1IugjCk5NCOKs8OWpfWxZBHQHoUc9
	qsSt8R7EwCVEJuAhxLLMtY1qXCysP+dlZU5skMmSUs+M5TTJ6yIl5HZNVh48LTMLDcW/PUD0fBr
	38++5Tts0=
X-Gm-Gg: AfdE7cn1fxHie8oGXac12lcj5Hqz0RInNBj0O0Yz9Ql0A+YFuRJQ1UxiCg4QtKjMEZx
	oYiU5qHIvM0q01qvq5x4Z0E/su/P114INX2S6xHnk/UXLvUb2ioou5D5BVODWXRl3PP6neV8QlT
	8k8lMnyUl35Lxi5CYiOqg+atOwFfDPOVvLUJhnXahAM4V2telIGJLUShIuvcIt4cEaaoJ/xxFOa
	iYTA+Y57ZfNWIlz7mFbbe2hFbP3StGtM/Scv01cJXOiSreWyZVR8viBsEqh43wjye/3q0vZMHkj
	km7k2SWXLTU87mIy6HEQGyY+GkbU2NepPWP91/fd5SDm5+5X8/KH9+rZuo6pXqTJjGiQpyHL4w6
	zwtgjMxSuwEbzQu0HZljyzzNrJfeHCHRIHjJ6UVqvIMz+Iv0KnunaWVLJLdT59eR9LRc8mL7Ll0
	LO0ZNE473/+Q==
X-Received: by 2002:a05:600c:8715:b0:492:4871:7e21 with SMTP id 5b1f17b1804b1-493bc53dc56mr31413255e9.10.1782834744239;
        Tue, 30 Jun 2026 08:52:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8715:b0:492:4871:7e21 with SMTP id 5b1f17b1804b1-493bc53dc56mr31412855e9.10.1782834743805;
        Tue, 30 Jun 2026 08:52:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be22098esm5669225e9.2.2026.06.30.08.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:52:23 -0700 (PDT)
Message-ID: <caeaf483-b19d-45c8-82e1-79eb2d56dc65@redhat.com>
Date: Tue, 30 Jun 2026 17:52:21 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
To: Arseniy Krasnov <avkrasnov@rulkc.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
 rulkc@linuxtesting.org
References: <20260628182052.951760-1-avkrasnov@rulkc.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260628182052.951760-1-avkrasnov@rulkc.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IW1oolpfmQlWs8Im2XMzAlXfhYPkCoo-qQWpEFu92S0_1782834744
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/26 8:20 PM, Arseniy Krasnov wrote:
> Logically it was based on TCP implementation, so to make further support
> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
> this way, patch also adds handling case when 'msg_ubuf' is already set.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>

The PW bot is on holiday, no automated notifications for a while.

Applied, thanks!

/P

