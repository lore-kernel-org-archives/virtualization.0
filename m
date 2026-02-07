Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EF20C461;
	Sat,  7 Feb 2026 04:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770439301; cv=none; b=X6qofRPYXn/cOomcWXnNZC5j9fflDT4JAWll/da2ifVgOhScxDSkdgk9QxmWkHC5OPyMmcZhifxFwIilE19i2JvvNg4RuDxyltO9WOs+75xuhER0QZVdjJjFqNiQtJ8iCwmRxAZu2ulELShdY/FaFCEZUC5PMNvl3ugItoA5C4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770439301; c=relaxed/simple;
	bh=Bps4dB7zojge3m+VhMUwtjavry0zUr6oxG+5LcJmDEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBkNzs4V2D4j2eGy/CWJNo3tIK/19jcS9C7wCnQDqNb8qm+ax6LH7J60KxfRToUBqpef0Jz4UAuwD+N9C4vbRk8L/EnzPNaOLp9Ij0g30T0SF6qRilQd6jXJxku9gVkCUtqnUm7QyktE/JbJQU8upycwp2iJVz4CUpjH01NRix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siAztOuW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siAztOuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F63C116D0;
	Sat,  7 Feb 2026 04:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770439301;
	bh=Bps4dB7zojge3m+VhMUwtjavry0zUr6oxG+5LcJmDEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=siAztOuW58jinMapwARV9wIQMMQsZefQBj+0ZjDLuYPFX7niS35KxecFdecAwD70m
	 cEUSg7J1pPWhNgu6CTjKgAhI5XYvlqELBmL8HjWd0wrE8r0nrQ8+NAmfSK6+DMx/5G
	 x4V+Skn1EMj4ooELVqbc3dCMYtMn9MgrG4wbHoeTYHlUVLDL+/xoetrlV3F/ookI2G
	 Z7YlvZAg0I4uTTXJN0bOzcGjM6d2B7ITbjE4bOyWSVanYnZrh5Getkw3YO4VvB4lQ0
	 N2JPCsLcip2y5SYu3pxozwkhUJYrC1lfj8IG9dJM7DfkjDsVtRBr0jw7EyTaKcgYio
	 TkY61jv2PnhYA==
Date: Fri, 6 Feb 2026 20:41:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Wei
 <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH net-next v5 2/2] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260206204140.56d85273@kernel.org>
In-Reply-To: <20260206002715.1885869-3-vishs@meta.com>
References: <20260206002715.1885869-1-vishs@meta.com>
	<20260206002715.1885869-3-vishs@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Feb 2026 16:27:15 -0800 Vishwanath Seshagiri wrote:
> +	page = page_pool_alloc_frag(rq->page_pool, &offset, len + room, gfp);
> +	if (unlikely(!page))
>  		return -ENOMEM;
>  
> +	buf = page_address(page) + offset;

Please take a look at page_pool_alloc_va()

I mean all the way down until you reach page_pool_alloc_netmem()
and realize the helper you're adding in patch 1 is a solved problem
-- 
pw-bot: cr
