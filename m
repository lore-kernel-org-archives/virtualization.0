Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF42E401;
	Sun,  9 Aug 2026 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786317337; cv=none; b=PPCfFCtOJ6tZGQEbfiJ+e1v8VE4FWKObUKX9TkYp6VNTgMcpx0fdAdnY/fljpGMiNxuZ2G/HLo0NZsqi+dgqWYAxpiSVqnKXo+OFHY6AOJcKZrBBBZmeNV3lR083xi0gYdLvGR3cPGNQw6pjqVQiPvmMmc8vwIPMHUQV6WLvgtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786317337; c=relaxed/simple;
	bh=HkgiL877x1NhAZjHcTrix8HGGel5Y3l+BrxwBDUSSPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/XUeoFnz66PAV1liy00qjWvM0H3wGk0+f9gENbXDqoKq5kyveZM9ZRYeuAj2Pvxd4nUCGngyG0CCPNtPs/RbAhT5biIoCKeSQRm8dvy49ThHY/wRPwOYqNOiKMdCTxGwJdGpar0Vs1rBjV+3DbNMnTa6BSee4sLzD2IZ1gG9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oo+FFzlK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oo+FFzlK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=SoBiIcUKkLsP6UDETpX1PzwZE2TvLHRfs52WUirHK+E=; b=oo+FFzlKcz078c83/WyrtUw+PW
	iA1GgatjSrSZ2aKBBZC/4vkfPF9T1Y1YCL1Yr1HT9o1ckIjoA2fHIzbQnIyNNHZFN4JMDq3rLPLMe
	7BRSTJfDx8CxljivNobV952ucQx5CxpBXMD4RV8UBLifcaqTkyytP46D3OeKMHd3EL9OfTUNFAXD2
	bRqfB5c4Jq8Gp97Us1mvgXuwJFQML2kXk/v5Z3ApgazaGTdm3yUo4ZcRRO+e2jKKueche8CA1W2fU
	VKSDlERWqeFW8c8MWJDknrnSXTDqlfMrLsDTbta6D73qrB9EpFtO4NuL+SLT+fgjsVPbOidC10FQj
	Mpn919Tw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtCjn-0000000Ap9n-1LGv;
	Sun, 09 Aug 2026 23:15:28 +0000
Message-ID: <3f225be6-c87d-433d-9589-231d37ca6360@infradead.org>
Date: Sun, 9 Aug 2026 16:15:25 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/12] virtio: guarantee a virtqueue can publish its
 first descriptor chain
To: "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>
Cc: Jason Wang <jasowangio@gmail.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, virtualization@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 nh-open-source@amazon.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260809182010.32931-13-graf@amazon.com>
 <20260809184014-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260809184014-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/9/26 3:41 PM, Michael S. Tsirkin wrote:
> On Sun, Aug 09, 2026 at 06:20:10PM +0000, Alexander Graf wrote:
>> A device's pool is shared by every virtqueue it has and nothing
>> partitions it between them, so a virtqueue that asks late can get
>> nothing at all. virtnet_open() pre-fills the receive queues in index
>> order and discards the result, and a queue that came up with nothing is
>> one the device cannot signal a completion on.
>>
>> Withhold a range of the pool from ordinary claims and let a virtqueue
>> whose ring is empty draw on it for one descriptor chain.
> Why bother? one chain can just go inline in the ring.

https://people.kernel.org/tglx/notes-about-netiquette
or
https://subspace.kernel.org/etiquette.html

It would be good if 100s (or 1000s) or people didn't need to scan a 65 KB
email to see that most of it can be ignored.

-- 
~Randy

