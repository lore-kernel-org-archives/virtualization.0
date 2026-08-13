Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691E3B71C0;
	Thu, 13 Aug 2026 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634965; cv=none; b=rCkrj2zx/vVJ3AvGIid/TqZwfXWdl4cyZg25YGd6ea/WTaPd7Z5Aad+yRqGDYamCwkkSGDEXSU+sZXnF2KgP+XvVMQLZ1vc1DWOn9cGa7wksoWhd/gbzYzrHEkNXLA2VkfFFMuRWmSArcMLMVpiwujZh+v4nWwyVL2EngNPx/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634965; c=relaxed/simple;
	bh=hPTFqUWtuZiGVbJaJeZh1GEXRkIOuWjk1cToAtx1WBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3aZ0zikaSmwqyfBgK8BubDx7Sy35RC8Fzy4brN0+1vCW0pu5lXhX8nMlt01eYMvsWs2oRUgDqeLUdZbqGzJfktRFWzI+Fz6RAwUlFsLT3ca/HgrDEtlnnZte/s/8SXO4JDgW1ZMl65j06F+xY8QNj8Dc7g+chEswJ3gECTuUDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJyldb3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJyldb3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF821F000E9;
	Thu, 13 Aug 2026 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786634963;
	bh=hPTFqUWtuZiGVbJaJeZh1GEXRkIOuWjk1cToAtx1WBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AJyldb3GPtDqLRh5LeeOLFWFeOiyPPryZ/tUji8lqboLG7bHCwBOwGisLppEfdspF
	 CdKAt0kDSz4do4xWdJkzRbwg5ALafMPKYlBZB6/C8gU3+NurFi+ATDoQ/Xnl/tK9Uh
	 kIQGB1hPl4ujdckYTjwJhte+NKV+L8J2P18pi1g0TuvRM7RgzoTGKowrOLUcRQYj0K
	 tblKrsFmC+TXIwJv4QqZ7QWg4JrKvYjFedRqr4YMQe1QwefBlh5/Xj5xctq1da8Fqc
	 o9tGV1GQlBz8Qi3dN7mol0/AFHDtFQBkjf+aT938d5z3BacywBchk5K9MXJwrrYPQ1
	 +pZOxGCVQCE7w==
Date: Thu, 13 Aug 2026 08:29:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Lange Tang" <lange_tang@163.com>
Cc: "mst@redhat.com" <mst@redhat.com>, jasowangio@gmail.com,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Tang Longjun"
 <tanglongjun@kylinos.cn>
Subject: Re: [PATCH] virtio_net: add rx-alloc-fail counter
Message-ID: <20260813082922.19194916@kernel.org>
In-Reply-To: <290bce53.25b3.19ff90e755a.Coremail.lange_tang@163.com>
References: <20260812012254.27668-1-lange_tang@163.com>
	<20260812163427.3c44ac4d@kernel.org>
	<290bce53.25b3.19ff90e755a.Coremail.lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 10:58:22 +0800 (CST) Lange Tang wrote:
> Regarding why i didn't into virtnet_get_base_stats, TBH i didn't give it
> much thought. If you think it's necessary ,i can add it in the next version.

It'd be ideal if you were the one doing the thinking if you are the one
sending the patches. Think about it and include what you concluded in
the commit msg for v2.
