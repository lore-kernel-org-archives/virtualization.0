Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EEB368D55;
	Thu, 21 May 2026 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330230; cv=none; b=mHVY0rL5LlzT63jnN9utHF5u7E+xKNTT/DMD7ae/xbMhZ0u8R8F4TzPOMPIp6tRDRssEnZ/qePq7OQHj48Hq47YvXeYrNWdyj/4clsi5MKmtUoZh4TFJJiQ+JveXtJkvVuWCvYHkwAyymJuA85qjBo6i2C6bvoaUjffjYJ8RPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330230; c=relaxed/simple;
	bh=vjD7QP+F8UtbNNzbw+Gn1YXbvKp50UxS0eIUj76kOxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bps/qi0njaoUigdGtEfUaaLtzTKV2/1//5r70cwC+9B8tPVxB4ERtTxRuAMopAR1yfU6ulbQ9SuIt6qJ7R8xO3etCA9yDP8KKzCFG9lGjAbs7olGMEK3xiq4a5H+7vwL6ea2LBQk8L6QW4OLmfv4kjmFQTBhXdnRldyxrGW24ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4WSv3b1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4WSv3b1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B631F000E9;
	Thu, 21 May 2026 02:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779330219;
	bh=NZp6P8lPPZbAifBf0Dh9aAsJwHiBG50LhLLFbg82cBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T4WSv3b1epuU0Gh0LGbVAt/2OHobGbzRnWplrWx7FyeaD0+oymf4p6HoElIuVU+Gj
	 FOMQLSF4JoaYr+C9Fnckle3E03GnUNs7lawjXD6VcWFWkP/ohwDoFetpU6lTA6ZdtF
	 IB3k3Y0YjIVJBDgSyFXvM+5HcZflQT/ZO1jIRXUgjr2+VB2xiBlkIRkSMChxpZCjt5
	 n35eAjloQPuuj3neak3uGxH1JvWM1RPP+UZ7GdlhYLfZOCQP0nfPAubJTSPEtfBYAL
	 Z9hfrqbADmFJHj9rh2lP3k8Q11RjrHrAK2caNF45giGg0ivKNJ31s3tlfdLV4WUm8R
	 LEJzXrcO6rOnA==
Date: Wed, 20 May 2026 19:23:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org, Simon
 Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Wang
 <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH net v4 0/2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260520192337.626ba49c@kernel.org>
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
References: <20260518090656.134588-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 11:06:54 +0200 Stefano Garzarella wrote:
> Patch 1 resets the connection when we can no longer queue packets,
> this prevents silent data loss, and both peers are notified.
> 
> Patch 2 increases the total budget to `buf_alloc * 2` for payload
> plus skb overhead similar to how SO_RCVBUF is doubled to reserve
> space for sk_buff metadata. This preserves the full buf_alloc for
> payload under normal operation, while still bounding the skb queue
> growth.

Hi Michael!

Are you okay with these fixes? A bandaid but not too outrageous..
