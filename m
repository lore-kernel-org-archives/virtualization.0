Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262BF1F471F;
	Thu,  5 Feb 2026 05:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269113; cv=none; b=d7Kqt/7NyPLIJmATiYHNrY43A1eyH3hLJ0jEoqWGGc5VtH1lKYrfjJJ6vv7TeZG8j8uCNX2+MdHgjqy0uAOeXDcdd9iaI22hCJJCB0wquO6j0zamNoe8wLN6hMKiCwsIe4QlcUmHJb05hf3vwdrhO24e1BfqNSyx4JLbqQXhOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269113; c=relaxed/simple;
	bh=yGdsgCTf1QDzagy1MDmADcs/xYLOANpJBIngoj1gkM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUJCFDCXYHNUliqHCTsozZaZLQvGJFoaQYF0sTUS7J3rDhQiK6GpSpelgJ7LE5aOl/kg75mdFEbApO7sGtBAZCTDjG4R5rx8DWLW0uaOlu0njZjQZMXKol57Ejn0i0RNd9JFR1b5Jp86vZV3ZCLMMvmedByTnRa/woF35p3k5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otZ6UgEc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otZ6UgEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFD3C4CEF7;
	Thu,  5 Feb 2026 05:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770269113;
	bh=yGdsgCTf1QDzagy1MDmADcs/xYLOANpJBIngoj1gkM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=otZ6UgEcQaXANvWbc/+4y7DpYVVXlME57f/FfVI4OXTkjmbdbw6ixPbJKwOuFFUCB
	 ulkZiRgmc/HXBm9HhxVJr4zE1PVmuAj7MuaorztuF0yfjCXRE3WLX7pomnXkch8OWk
	 He9zqfThzs8i+Ph6kqTEHn8jkMji3B2wshA3O/5sNuOzgZEGCthdrm5u75Ru68PSd4
	 ciFV14yeyhrcsaJr+7pxnVxIkzQ1W6jQmS+ApmcpRkSFR379U+vGpExvG2bsCakiZK
	 Ctt8iadUOjO+Zp7HpzMWnQcplEpz6NcPRO0553sfaRpeL+CXYBekYcLR099hwEEZ3u
	 AWf9yCnbd7Cbw==
Date: Wed, 4 Feb 2026 21:25:11 -0800
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
Subject: Re: [PATCH net-next v4 2/2] selftests: virtio_net: add buffer
 circulation test
Message-ID: <20260204212511.017153cd@kernel.org>
In-Reply-To: <20260204193617.1200752-3-vishs@meta.com>
References: <20260204193617.1200752-1-vishs@meta.com>
	<20260204193617.1200752-3-vishs@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 11:36:17 -0800 Vishwanath Seshagiri wrote:
> Add iperf3-based test to verify RX buffer handling under load.
> Optionally logs page_pool tracepoints when available.

TBH I wouldn't bother with this.

We run full battery of driver tests in netdev CI, there's not much
value in a dedicated virtio test that just runs iperf...
-- 
pw-bot: cr
