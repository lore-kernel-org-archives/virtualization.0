Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C80218ADD
	for <virtualization@lists.linux.dev>; Tue,  6 May 2025 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746571674; cv=none; b=ALIehPDXMhUhvjRnQTx3f4j9mdCq623naAc2c/yOwQxFYOt9MxmeSomd/gejfZ1Usd4KpjjiHJQ9KX/6Hxh+Njs/7BvAd/jS7572P+9SXcWCAf6oHq/eSRyB/97NXhuA/p1jNf9l/sjlugxPIj79J+BpN0vFDC0qch5tgljHaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746571674; c=relaxed/simple;
	bh=BmVebgSwoJe1CZ2YVQOiNYym1SpMqws0eh/maQxHzZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgfjzeNhO1niT2R80c4l4mHmC9nSKkunazv+cfDmdmRBnsr9glWPpSi3ryvfQySnRssRCsYriPjvW3eSPdbo8eByswoGeQjY2fMgAif5eWqBsrfHFCslil9N5iT4GuQzCR6323j//zYdduSmOdVTH/lR0N8k7yi3ohoO9zx1E/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=OV/XZL1C; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="OV/XZL1C"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uCR4m-007tKE-77; Wed, 07 May 2025 00:47:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=BmVebgSwoJe1CZ2YVQOiNYym1SpMqws0eh/maQxHzZU=; b=OV/XZL1CJjjLBM6ND5SoR0EevN
	h6AOvVWGeUNvub+mIIa2x4xRhY04lqYnRMMnd0uubnBIg2WjpVNcvVh4r0ZGa6FH3bwuC9ftcH80d
	IW010Kswehpf4inm7fVh/7jNgaAa7Uyy7pjT4B/jwyJqak+kmG7awJS9quWpU885AskrSU4BZXPSA
	tkFgcMkCTz8JIdSvKkefvE4mR6Qvd+MG+AMMRDfiK/H2+4BmcgIDukIyywl1hJ+qfPd5OnSwwTjab
	qzT0EOqh06fHXLSqo/Kpk34dbNGKbq2yWhNb5NmDZe4IQINz/G4pzrRzrw64D0+Jxw8OyF2XDhyWd
	zFpR2GtA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uCR4l-0005WD-MV; Wed, 07 May 2025 00:47:48 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uCR4i-00FMkF-A2; Wed, 07 May 2025 00:47:44 +0200
Message-ID: <ff959c3e-4c47-4f93-8ab8-32446bb0e0d0@rbox.co>
Date: Wed, 7 May 2025 00:47:43 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/3] vsock/test: Expand linger test to ensure
 close() does not misbehave
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co>
 <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
 <CAGxU2F59O7QK2Q7TeaP6GU9wHrDMTpcO94TKz72UQndXfgNLVA@mail.gmail.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <CAGxU2F59O7QK2Q7TeaP6GU9wHrDMTpcO94TKz72UQndXfgNLVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 11:46, Stefano Garzarella wrote:
> On Tue, 6 May 2025 at 11:43, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Thu, May 01, 2025 at 10:05:24AM +0200, Michal Luczaj wrote:
>>> There was an issue with SO_LINGER: instead of blocking until all queued
>>> messages for the socket have been successfully sent (or the linger timeout
>>> has been reached), close() would block until packets were handled by the
>>> peer.
>>
>> This is a new behaviour that only new kernels will follow, so I think
>> it is better to add a new test instead of extending a pre-existing test
>> that we described as "SOCK_STREAM SO_LINGER null-ptr-deref".
>>
>> The old test should continue to check the null-ptr-deref also for old
>> kernels, while the new test will check the new behaviour, so we can skip
>> the new test while testing an old kernel.

Right, I'll split it.

> I also saw that we don't have any test to verify that actually the
> lingering is working, should we add it since we are touching it?

Yeah, I agree we should. Do you have any suggestion how this could be done
reliably?

Thanks,
Michal

