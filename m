Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32A203706
	for <virtualization@lists.linux.dev>; Thu,  5 Jun 2025 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121392; cv=none; b=QrwuAnK7kSYBFSJ60qRv58suhd0PaxkPrDhYP4Y95oSE9DKX2yqRlyBhiMwwo7733Xyt5kLrqTT7A42XtrElaqqYeqI/ZkzYlZf91FVrBnNQJ5+BtFGQriHu8wAFp3aLJbv+DIsziPQ14/3JfgOAcuiA45qbhTn/xO8B5sKCLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121392; c=relaxed/simple;
	bh=5iVRkX4FSgcRxi/CvcNtolFKz6k8kFco9qX1fh/s/lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seYRyTx9kC6HlMBISkmiwEb0X75ACcJkXxv6kY9/AjGykNz8EGZ4wsNm5nVVBr5t+d7izewq0iOlU1jEHo8/eWXXTVdajIfbDVpLAqgbuz/AoaABRR4QuxsJC3av3W4C0RkK/QAfnEpn/beWNEfT/VzH2+RvktymMdlTCSQghHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUJUQRaE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUJUQRaE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749121389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/iNd4rCLMH3G4cLnw5oDzeODmTZrxz5jMOWbyZxDPY=;
	b=XUJUQRaEJTUdQYD2qx1MPkdyzhLQ9y8MjiHQrDqIWIlt+ww6FOYUbg8iOh/OVrJsha0heB
	SOkFWwpRMtzL0qiEIoTQXBr1H8nnnqc5+tKuqAjnF/vBwXl43QCBlzKd9c9QHSvqiVCpSw
	SAsU5iW83mlbl1fxzsQhBsdQNXWTD5s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-Qbyn9E0qO8CIOugbxZt7sA-1; Thu, 05 Jun 2025 07:03:08 -0400
X-MC-Unique: Qbyn9E0qO8CIOugbxZt7sA-1
X-Mimecast-MFC-AGG-ID: Qbyn9E0qO8CIOugbxZt7sA_1749121388
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f3796779so589350f8f.1
        for <virtualization@lists.linux.dev>; Thu, 05 Jun 2025 04:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749121387; x=1749726187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/iNd4rCLMH3G4cLnw5oDzeODmTZrxz5jMOWbyZxDPY=;
        b=e0h6Nu5MqAxpkfyImXXH2Tp2pqvPaXMCAPubCjZe4enF09c3smwv4tVWJS0SGLMhsD
         azRKVqUmVoS0OwY+6iqvfcA5P6XLjIJyjrwFA7TnhGkIEh1g6l8Io1Ir4O/RLL/YEvTt
         3YnTUw0HOX8d8XMR+er92ahvJWOQdIWKDWYzHhdS3xf+5puVKR26far9/Tsk/kl8+8fW
         g1YLRQ1wKoMBqslRYYnVAQXyBewezcFRk2lkXsscwPphbsMV0owvsGA4Gzjk1mNNtUW3
         gfvLrur1yhS5dk3QeWm6BgdFCxQPs4IrwQy1a5N4Y4EFUtYe8+4wTTwM++4BoDzzvZ+n
         gXqg==
X-Forwarded-Encrypted: i=1; AJvYcCUP9hRUSPBsL73JXRvwD7t3qwZBbAvNdcI6IPfO5Ob0WztZYcmOkfjlp/U9nbQO9JNVSceIhzQOiLVwBMYBfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz8TGX+Z2u6IFsNqigTqkTi7qoYuQuY6BD9pIJeCZIZxek18rM
	Gq30FY1fOKLlQRFSEcfdqrpiWxhjy6ntl2hfIiqgZ7YzoEt/NdgeYD7kO9H8DSikAW2kLfUPW8t
	dRdW1mRKwcrZYIMdl9GB6dIVibhat4Ok+RH/ZeecZxaTbSCH9wJhb3wF3cSAIGrDkWj6R
X-Gm-Gg: ASbGncsg+oaCqvnxRcLoOqL2CMOe4T7ygYw55ga3apZxtPPNIU6gNWuLs+4BEHNR6rp
	Wmh3FPI8PE56+ZqiZbxC2fO2zojSAnQ4/L8enD04BFn0oudBK+U1ATANROymS9IPs709q9tQsmG
	FuRESWwskaKgCPFQ06+OD41GFer4DApgKhhdauEhr6NW8A2girdegwbQHR5YXys6n3Gg3/BXNAx
	qFwUOk5LhlUbIEi/IBKDc9CPnuHAVJe9wsUKdipMe94YiMvSp3iOP3kZjuCic49xoEwVzn3UYY4
	HD/IACy2LAD2urOLGewc/0nenvL3fA==
X-Received: by 2002:a05:6000:4387:b0:3a5:2949:6c24 with SMTP id ffacd0b85a97d-3a529496f56mr1757620f8f.51.1749121384691;
        Thu, 05 Jun 2025 04:03:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdGUXYZXrNIrCyhAh0tp1ScDeHW0FOJjHuHj6Po7K6huTF1gR9wGCaSTi+dFD3HnrC0pmIFw==
X-Received: by 2002:a05:6000:4387:b0:3a5:2949:6c24 with SMTP id ffacd0b85a97d-3a529496f56mr1757543f8f.51.1749121383960;
        Thu, 05 Jun 2025 04:03:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cced:ed10::f39? ([2a0d:3341:cced:ed10::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm20995275e9.23.2025.06.05.04.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 04:03:03 -0700 (PDT)
Message-ID: <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
Date: Thu, 5 Jun 2025 13:03:01 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603150613.83802-1-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pYSp_IwxnUzvuBj55QniP6wo5JXhFKJ89ONy1SOsjaw_1749121388
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 5:06 PM, Bui Quang Minh wrote:
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior. 

Why? AFAICS the multi-buffer mode depends on features negotiation, which
is not controlled by the VM user.

Let's suppose the user wants to attach an XDP program to do some per
packet stats accounting. That suddenly would cause drop packets
depending on conditions not controlled by the (guest) user. It looks
wrong to me.

XDP_ABORTED looks like a better choice.

/P

