Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282C1E9B1C
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Feb 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038330; cv=none; b=DAfvgU53oi1OsyAVlg9DS2kNtDljKiv5iBrmbVa9++L3RlQPN4uCyx2UqxREdqrOJUl7g79FV3EY+20CI0TupgPYzAbgkPBVktgKvlC4aIKLjnOk+6hm+gprmvxz8XWjCN+fLC22n6jSQqZ5R65Gz6lcZUlanz9XnDrfnqyF+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038330; c=relaxed/simple;
	bh=PpJNYD2lhmYApKCUTFbnIB2Oz9xNpyPKhkXzhRQ1kRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q9hlfMy4R40ZrB6B8V9rVMxRh4Ov/CRexkvZQ+AAlnLK+y047ir1clwRAF7poRmQj7Z1TxJ+ZWaePN1FYUbQTxO7zNcRk5h6I32I1z62Pvh9BagLS6Ix2tk0I1np34P6jPgBT2zEzhUQ7a2ehfR+syCdimrHOk6subtHzGLmFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XE6RBLog; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE6RBLog"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 569F2413A5
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Feb 2025 07:58:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lbskd8r__LCi for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Feb 2025 07:58:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 28677402D0
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28677402D0
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XE6RBLog
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 28677402D0
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Feb 2025 07:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740038325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDyq9aCOU4k6/OxS5NyOrQ8zBZnEHt3wS9LzAF8nhU4=;
	b=XE6RBLogwAGAyaC8nSRcY5sY+KefFsdVfwnpGsX7noVe4dR+ge2TtxbfHnuArbBfblVp4C
	JcfL+0rIh7nOc/So4R/7gBjKHatV6U4el0kt6gC96qXCQF/OZVoP3vBoYOPSpUn5i9SoQl
	Dy8lkEy5AeJ16HISm+MqI7Vc2dmI64A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-sp-YYHp_P9qDy_muEFeA8Q-1; Thu, 20 Feb 2025 02:58:43 -0500
X-MC-Unique: sp-YYHp_P9qDy_muEFeA8Q-1
X-Mimecast-MFC-AGG-ID: sp-YYHp_P9qDy_muEFeA8Q_1740038322
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4393b6763a3so2541245e9.2
        for <virtualization@lists.linux-foundation.org>; Wed, 19 Feb 2025 23:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740038322; x=1740643122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDyq9aCOU4k6/OxS5NyOrQ8zBZnEHt3wS9LzAF8nhU4=;
        b=GnT8OFTtbRWB/OXMt6UOHjL5uUz7UMMrPq3TrJHesR0DmHt7YU5qUoVCaIXhb4PWbx
         jhSG7YY0Z8ukVTPJKFx90LYt4vCivdCftb5SeaqmGQ5/EHNQLBzPd87WBrkEmDIWpA3Z
         hbGfVGKvYnPKmwB49ovTesMcRYVaqk11D4Tl05g4XJHfbEwHNZsLtEhz3o7UyP/BS14j
         q69IcTMm2DVHZSvIUJ9ZKX59xsnyxZJbNafhIeep7+rRCUjtBlqhiuNIJ8dRDeI2vXDs
         NVIBhcY1EHLdgGS/5Q28x0Izmu86iCF6kqd3+GdV/eAi5T4FDY7LV4fLq5nON9dzHj0S
         YDBg==
X-Forwarded-Encrypted: i=1; AJvYcCUpE9MtenFn9JXYMHisLKWwUFHA1rE9XrgQT7dAHjKupVxtlWoxooZaCF2KnSo9+G2lpF6UxD2cbrMZUMOyEw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwT4uCsexXVARcqaaATzm8jKvFjQLvKSGEtBS9bfPS7Muw5mBoW
	Lf/pN1tN3D7xSCJjZ6ZZbi8ny806/lFVjrBb57BofTF933RKQgiafqDCkq6SiYR5khZmBPh5cAL
	MrMK1GOfvDiv5j0ftEeYhsjLBkn5RpUSELLaEDJJLuvB6b3hROu0hQDIkiD8MFID27cDT0uJE5j
	t2VKs=
X-Gm-Gg: ASbGncvqWSjPbOLJjNBmR8yTOLxc8Kh6tg2tko/WY4L7iq7bc+dgbRZwdQTSoNWavAN
	z6O4TFzVIpR3862PmwZNt5mXuG7bDuYcBALszt5FgbxEqozkYQlUIehjL9vtg3KHKH5EloDM36i
	eOyFbhWiPxLGRYzOQ0Tflf14UfNqFr2uVLaC3+nUCD7VupOHTmlkPtdCCOcUW5vuVr9vCS8xNTO
	X88y1smqRFLJwtUuJXy5yDS10m8TIMIXXaKfBSkX0H7ksuWUU0qbboNqvDtzWaY5AZ345fK8b0F
	gODAy1fgJ3rXUoiSXo1yATlbcr+jerXOpvI=
X-Received: by 2002:a05:600c:1e89:b0:439:9828:c447 with SMTP id 5b1f17b1804b1-439a7b81c85mr5230785e9.17.1740038321784;
        Wed, 19 Feb 2025 23:58:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMZ/J4mT4eh+w4zVIHYL3J2TeyMMFBaqTsZEuN7XJULLXJfI3m9ZBVAO4oeESyI4i7d0LvUQ==
X-Received: by 2002:a05:600c:1e89:b0:439:9828:c447 with SMTP id 5b1f17b1804b1-439a7b81c85mr5230655e9.17.1740038321375;
        Wed, 19 Feb 2025 23:58:41 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7bcsm232584425e9.28.2025.02.19.23.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 23:58:40 -0800 (PST)
Message-ID: <d4b7f8a0-db50-4b48-b5a3-f60eab76e96b@redhat.com>
Date: Thu, 20 Feb 2025 08:58:38 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] tun: Pad virtio headers
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet
 <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oVb53mm1MUZh8c2pCM55TAPEMia_qJ9vj50V5SuNuOs_1740038322
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/15/25 7:04 AM, Akihiko Odaki wrote:
> tun simply advances iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This will become
> especially problematic when tun starts to allow enabling the hash
> reporting feature; even if the feature is enabled, the packet may lack a
> hash value and may contain a hole in the virtio header because the
> packet arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.

Should virtio starting sending packets only after feature negotiation?
In other words, can the above happen without another bug somewhere else?

I guess the following question is mostly for Jason and Michael: could be
possible (/would it make any sense) to use a virtio_net_hdr `flags` bit
to explicitly signal the hash fields presence? i.e. making the actual
virtio_net_hdr size 'dynamic'.

> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so replace advancing the iterator with writing zeros.
> 
> A user might have initialized the buffer to some non-zero value,
> expecting tun to skip writing it. As this was never a documented
> feature, this seems unlikely.
> 
> The overhead of filling the hole in the header is negligible when the
> header size is specified according to the specification as doing so will
> not make another cache line dirty under a reasonable assumption. Below
> is a proof of this statement:
> 
> The first 10 bytes of the header is always written and tun also writes
> the packet itself immediately after the 
> packet unless the packet is

 ^^^^^ this possibly should be 'virtio header'. Otherwise the sentence
is hard to follow for me.

> empty. This makes a hole between these writes whose size is: sz - 10
> where sz is the specified header size.
> 
> Therefore, we will never make another cache line dirty when:
> sz < L1_CACHE_BYTES + 10
> where L1_CACHE_BYTES is the cache line size. Assuming
> L1_CACHE_BYTES >= 16, this inequation holds when: sz < 26.
> 
> sz <= 20 according to the current specification so we even have a
> margin of 5 bytes in case that the header size grows in a future version
> of the specification.

FTR, the upcoming GSO over UDP tunnel support will add other 4 bytes to
the header. but that will still fit the given boundary.

/P

