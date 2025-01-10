Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AFF20B7E9
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504634; cv=none; b=jr8k/inZbl0IZLSpG7j495hxQ9JjfXhrQZDzG88CGGnTbUcrXqhw/occLKBb2KyDdICRhZRL0VK/CP5p9IyzsX9IY9ytyGaBl/beucxNmymAjUhpJWmT8BH4Tc8+H1aVNVZXUlXUJKvU4Rfjd0M7czOPVfg+uKZW6SX6hfJbg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504634; c=relaxed/simple;
	bh=xjzJiHVG1rcoDk2fTADzQ9apBt/E2B/VHNJo4JUJl8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Czx/buyjK/aynZChS+BPTFQRHw1KLNDDHa3ZDkJ0u6DJJfp99tfQnNzL2oJNsTcXDfS7PymnVPgj8Cc9b5LIl96cKK4rdJHtvpifa1Bam+vdGYb1sdbZgH7zPqf8ARorfu4PY4q/YIawlC/XgeLQ7yR13mkWad/+rINi3w6WRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLF4owk8; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLF4owk8"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4183402B3
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:23:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CUDyce8KVnEX for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 10:23:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D17C240276
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D17C240276
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fLF4owk8
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D17C240276
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736504630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jp3bnJiwix2Gu1b46TgPaNYsSc3q3ZVFUH5fpD6tH7A=;
	b=fLF4owk8wLRErACyXaGl1g/X0YnCNIqRnKGo0fvlYSph58SVpg5+qwvrQtkILIWhYF52Yr
	/GkxvjAB5drOr2BSUbjzpczdtuElxBTAX8uJj8f7KN8iMpZt2by6ueDhvi5IcE7KnxX/N3
	V59fjMnevDIiD/MT4av7QXYhDPU2HA0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-PWhY0laFNgS_J_vKteXAfQ-1; Fri, 10 Jan 2025 05:23:47 -0500
X-MC-Unique: PWhY0laFNgS_J_vKteXAfQ-1
X-Mimecast-MFC-AGG-ID: PWhY0laFNgS_J_vKteXAfQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so16876715e9.0
        for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 02:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504626; x=1737109426;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jp3bnJiwix2Gu1b46TgPaNYsSc3q3ZVFUH5fpD6tH7A=;
        b=NGobKZquhyQi+uWAgTuo44Oo42Kj4fYXt1FKYIPzOVuDZRKsZR5v+typ95Umw+UdA5
         B6bS2PXgheCJd5+ojUMBcnegoO2Ek+wHVNUw+mhKUqUPjEJsSHQG/AbP7GKvjMVsIZxW
         Ap2e4BsrboirABL3TkQpvH8p9FNYpqHwSb83fKbxpqmLtAZgmkFQZUnhHlfp7fzzlVfm
         L6OeEk4Jep9Yn9R/9SqRcpjiHd2xzMXKwk2h5kkFDxnIYb1eIaZ20EP1NnfkchsmNhbe
         a9aENPpHVoKKN1Lo3xXqyZErfwnW1P65aB8qfIlZTVzrdnha/bEhfyuuSTa5zGC5JK+a
         w03A==
X-Forwarded-Encrypted: i=1; AJvYcCUbL49azh6V+M+Ti41eZ3/3/mmuw7XiFDEhG9VYnxH+5E8JyQOlCfWvR147sZsFwWBIeX6GCfc7YzBdb5XEwg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwL5H5EjZOY30C68cmvUy/vY4COeIGrqtA3ZrbP0+c92sCVXgaD
	9Zk7ksLQkX4v+40P/D8KPunE18UVI34e8A/+CHHAx06EHq1zKlD1tWLUYh5tgf5n3JX+WJsEOHI
	8ZxIqFDVQbxnrl7J0WbzsXbP+eJh9Mnfv6vtQuLo59Gb2Hc6gLbCO2+DwbqHbOJdGuMCPeU0Uty
	qgtgc=
X-Gm-Gg: ASbGnctlyK24WqIBBDav8pQVU5ubOR0g1rwIYfttyG6pHvYj9e5hJNESFyoYb9CaiE5
	3e1EcmBxReNOKB5KglIAKjmEP82zazsfhlOuuB3W6zKVp6T+/yAYArQxbmyCYMK57fqH5+xBizg
	VTZfi+dKIduhZR1Ldn2pD24/+l7JYCIX9ad8fK2uVnMbL+tgd8haA5k/+O+2jt/iGVKEURmGU/R
	DD4uOMv8kh6p9CfdpjiLlQxcMEjM+xssiP8YE7KGwMXa0vCoDq/
X-Received: by 2002:a05:600c:1e09:b0:436:e751:e445 with SMTP id 5b1f17b1804b1-436e751e61fmr82747665e9.5.1736504625696;
        Fri, 10 Jan 2025 02:23:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCfvXG8JypksNxAK+IHkKlFtMebcL1LMAzRXVW08Nh57eky+TRviObBgV58/zlzJhK4cMqJA==
X-Received: by 2002:a05:600c:1e09:b0:436:e751:e445 with SMTP id 5b1f17b1804b1-436e751e61fmr82747375e9.5.1736504625358;
        Fri, 10 Jan 2025 02:23:45 -0800 (PST)
Received: from redhat.com ([2a06:c701:740d:3500:7f3a:4e66:9c0d:1416])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e03e5fsm47436835e9.18.2025.01.10.02.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:23:44 -0800 (PST)
Date: Fri, 10 Jan 2025 05:23:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
Message-ID: <20250110052246-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mjaWMUgc6Swn2QWQpvVYejJA1aSXvy2-boWlosvx1YY_1736504626
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >
> > The specification says the device MUST set num_buffers to 1 if
> > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> 
> Have we agreed on how to fix the spec or not?
> 
> As I replied in the spec patch, if we just remove this "MUST", it
> looks like we are all fine?
> 
> Thanks

We should replace MUST with SHOULD but it is not all fine,
ignoring SHOULD is a quality of implementation issue.

