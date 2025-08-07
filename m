Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9CA273D9A
	for <virtualization@lists.linux.dev>; Thu,  7 Aug 2025 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754598280; cv=none; b=n7iYFwYQrfkn010UgnWqMt1FL+RHKSSasSorOE0LSSo1ahwywafDFCR8RZYvQbUJWCOVt/1mdJT7gtxghLLFUxD3Yo/5lVp4FkzO75k5nstitFthvmvjnvpCWrIxxYygxo087GApwlOKjte6O4XY6opUo1VjJ6AlyOmQnfjY8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754598280; c=relaxed/simple;
	bh=B5dHpd9/2CVBm2hMcIJ9Lj/mYxIYk3/xJor8Q45KyBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/Jtbjpw3htle9yY4Us2A91efKrLa9uMtj8KZrUhDDb+Pbo+MctI3puYQgqmZsObZsJblLo8GXW9o8gIQMB1TWR7xgnYLEmb+rBc6WG5BiNpvn2Ceg411rMp+CGg89Te5H3pw0lrGlfej1nAhIT0a9z419fYXW0Z/PyIUJ7JLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmYg3WCQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmYg3WCQ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bdce2ee10so1352977b3a.2
        for <virtualization@lists.linux.dev>; Thu, 07 Aug 2025 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754598277; x=1755203077; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3RlVskhZ/9tPsfsfYQZQqqA9goXX/0nRbKP1avcqUY=;
        b=XmYg3WCQwmmZXTMX/C3iax3x4vwaHcfZPQi8xnx3e83aH5t7vZWQhYRy9rtMjNA8yT
         ax6KZ6DkmGT+ZP2cXwsSlIO/mci5QqSMD3tjR7mXUMFjdDjx4YScYT8p50BC5bBMDCr/
         /w1RP8vxOsMyLeIsayX92bwqQBnct3F3vCPEPjSmZ47lFd6RhVmSuYIMa6FQAXlcFSp4
         m14Dh9Atj0PP5Ygkxcziu3e3IQU5oBct1M9caaqvZ40JGeDT4oeS9O7nUx+ICx9F1ehl
         MEcToi+VE99Rx4sddZx9bzKauz4MrBZG1DHH4o8TgUzEwzKXpgiKWGcMCseqqotQkrG2
         Oj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754598277; x=1755203077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3RlVskhZ/9tPsfsfYQZQqqA9goXX/0nRbKP1avcqUY=;
        b=m2JKOXVqeuGV06ACgBj2ARiaEZos5B2wapqjPDzhdJs3/IYYGZPp8BxZ8HagcAmPiu
         m4Y5/HRitpchH8sD51ooK6OFdZmfgu4CuLfXsw3uihTly7EHJ00LYhM05NwNyqpDj91D
         B5UAOG3ag/00X8At2kq3FJJbXXn6QGihIfNDDy6C/385BAIR712Z4sgo7FkxBV/Su5n+
         S12vX0xmtqHpucZ1xjggG7ytFLPMFp99aMnDPDfsE7YtL7IUzLtjVqr6cyHtlbA2uuCk
         ApYeOnH0nxLyOhDtcUqvk9aKtyYJUaiqw8IgCtUhtfbU9f7VSyw9mDnFRq9CZlfmDlht
         7Zfw==
X-Forwarded-Encrypted: i=1; AJvYcCXDALIFJhl9ToqLthgko0bs6vvv1k8I+jg9mBk05heHEHqs121my0lcU4Rv/jm9ZPLZ97XGjay2r9tnsY3VpA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9tIrJJfT6tBZZYpNSPydvZdk9PnDNIa/SiZhNpvYn/Nd7uDBZ
	YyIrVlv/bSjHzX7pUHz7nWWqtYthcZOc1u+V2juq66KRPn3d+7ciQ5gC
X-Gm-Gg: ASbGncuaoRVibtgymvZlUW2WCx+fqmY+L+U+x4yoGuBM4iRNGbBtTpEEGfl6AnEchp9
	T1bsW7zUB1NsmiBS/DcvKVuI66HOUUbjG3xjJ4wKlKHRr/0M8NYfdwkut28geUtaQzlFtWtxnzU
	JNW6/L69iCgTQokD+DT94cqlEVylSUgm2WJvtuj4ffKUvPNlaUzLzDmfl356sVptPAhu5YNqL91
	ZngEx+IYg3zlfdHkcPKa1AKyRVcn3twsZxyj5tiRt0p6H7RZfTdjoD6T4/IsoEwFa5w34N/uDKe
	Y3jBDfMVAqTRvTiiLhf0+NLW5yoqDkhonop0G+75IeQELSqDN3osrLD9vJIq7jehlJK8rkfCok1
	+u7/G6WWk8cIiSAN3kmIdyTaLFwKbq4wxgbs1sahLa3Q=
X-Google-Smtp-Source: AGHT+IF/VWh5TM2qquaqzYZqHo8a91a/584HOmbew0G6ouHaU7Evm8NtOh9ULhmHs70qMUCw7xImDg==
X-Received: by 2002:a17:903:2310:b0:234:d431:ec6e with SMTP id d9443c01a7336-242c1ffcf60mr4675265ad.3.1754598276994;
        Thu, 07 Aug 2025 13:24:36 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaadadsm193768745ad.156.2025.08.07.13.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 13:24:36 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:24:34 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v4 00/12] vsock: add namespace support to
 vhost-vsock
Message-ID: <aJULgjM8r+d+bKpM@devvm6216.cco0.facebook.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
 <27a6zuc6wwuixgozhkxxd2bmpiegiat4bkwghvjz6y3wugtjqm@az7j7et7hzpq>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a6zuc6wwuixgozhkxxd2bmpiegiat4bkwghvjz6y3wugtjqm@az7j7et7hzpq>

On Thu, Aug 07, 2025 at 10:06:35AM +0200, Stefano Garzarella wrote:
> Hi Bobby,
> 

...

> 
> Thanks for your work!
> 
> As I mentioned to you, I'll be off for the next 2 weeks, so I'll take a look
> when I'm back, but feel free to send new versions if you receive enough
> comments on this.
> 
> Thanks,
> Stefano
> 

Thanks Stefano, enjoy your time off!

Best,
Bobby
