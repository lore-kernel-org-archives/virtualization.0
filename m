Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931C14AD29
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235028; cv=none; b=SfTdx232DznyP1ieKD6ngpeZtawOZjOg15FMnltfClfRCewwCNQaZELQnbD9vOy4KXj48wJAoYwOcgYfv8oHs1PrPai7zlhviQyFru1pMInLGwDnWRWFZqisw03wTf50rz8EdCoGZDTsiGltl8diqDSv7c/AvruKhjkROVlHifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235028; c=relaxed/simple;
	bh=/pj+RCuXouKWKKmVNJjkG4mjtgCiJqE6IxJ4EvXxnE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEfycQpkhNgnd09HOcsezMHVUofWAYSCzLoOFekt/3GmCFOGQaLs+Xg/Q7iR0GdG8/EF4piXSUKVzSISJgwMrCIoyRYOIftYLlsWVf05fqbD4zyYJrAhUrRE5ZMjNEvAtR1Ir69/uHDSfc60bVccRtvH6LvP1RuV/2+zJHJ6X7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cc50jO1v; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc50jO1v"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E17D481926
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 03:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYxaAsrIPHNW for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Sep 2024 03:30:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1EDBD81902
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1EDBD81902
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cc50jO1v
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1EDBD81902
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727235024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pj+RCuXouKWKKmVNJjkG4mjtgCiJqE6IxJ4EvXxnE4=;
	b=Cc50jO1vwKFaEKU2XlDyrbNt/ghI8Q4f7OyGi9IdYTcKsiVT1tASj2oYd0URyrZRUE7e1k
	5Xg3T3sKJYlPAyDMdt9z7r6570YQXa97L6GW7EBMhp5bQ1Y3llL19jXoLqYbkqozaQpyDb
	IvLuAhyly3Iw+ra5b+DjdRpRwy+KIH4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-R9TAEeL3OwK-S3MY7OCzZQ-1; Tue, 24 Sep 2024 23:30:22 -0400
X-MC-Unique: R9TAEeL3OwK-S3MY7OCzZQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2db446a3d28so8951695a91.2
        for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 20:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727235022; x=1727839822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pj+RCuXouKWKKmVNJjkG4mjtgCiJqE6IxJ4EvXxnE4=;
        b=Eo+GRgBhvyc3KqgGIA3k9xJOuYyPjhLpC0UNUFEFaGBhu66pGgoGghV3XItwDMhxlT
         n2qRMwBOfYLy/Qi/q33ZD/pgwQrrnGjj/zhCLtMTCmSDMltshQ//sPZpvaZM+MLlCgz+
         8IVgle8ZYQIaCumfJbsYJW7cUPwWlNlQWd7BI1o5V2i6UgXACqvQCkLIIITG/ZFsnnLV
         KpvkgEO0MLCTVa/oorDE4WQLTYTZ1Nk/s5tKggG47Uu8OsDjCCB2ZJAj17ZxAKO3H14N
         2xfzsFaNxeNfud20hTkKTP1+bV7HnsKu5OgtS3/JWGWbUhsZM0ESNSZnfH55de0uA+EQ
         oAMA==
X-Forwarded-Encrypted: i=1; AJvYcCWjjCPOUOIFX6WFgxUW478r8Imj6ZRMV0oC3nzhTvT6ylyNwZ68LE0C8nYlII3Kwr9zOu/Iq0A51d4bJouQPA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyaU29drDa3m/aX+nK00oLeWJGb3wxR92O3H5POsmrx5t+9Ragi
	OJ5FnCpk2gIiDzHaWwa1AmToLGKB3y6BI9vXciwMD/GYeqG1XfjyxWkmzfXn00vN54zYXLSDUqU
	uduHcHIwMnfaApSyWVt+/0RR+/xQNZIhYqGQLslpu0mW5T/klm/54Jr56yhp994EBGrLVmSHHU2
	6cgwtwvLS9hJKYjrYz61sKYpzKFkr3Nv4PgnDsBCZKF4PPdsnemTE4og==
X-Received: by 2002:a17:90a:f2d5:b0:2da:905a:d88a with SMTP id 98e67ed59e1d1-2e06ae791a7mr1467817a91.21.1727235021754;
        Tue, 24 Sep 2024 20:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt284MvmYUlT8+AL6adgtTv8NmOQ1ld/MsvwYgsNGC040Pi/BgPI1vkZfb6OO4Jtnfla96r8UcK+AJSx61zg8=
X-Received: by 2002:a17:90a:f2d5:b0:2da:905a:d88a with SMTP id
 98e67ed59e1d1-2e06ae791a7mr1467782a91.21.1727235021240; Tue, 24 Sep 2024
 20:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Sep 2024 11:30:08 +0800
Message-ID: <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio-net have two usage of hashes: one is RSS and another is hash
> reporting. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF.
>
> Introduce the code to compute hashes to the kernel in order to overcome
> thse challenges.
>
> An alternative solution is to extend the eBPF steering program so that it
> will be able to report to the userspace, but it is based on context
> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> and vhost_net).
>

I wonder if we could clone the skb and reuse some to store the hash,
then the steering eBPF program can access these fields without
introducing full RSS in the kernel?

Thanks

