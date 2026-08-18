Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944742E8FA;
	Tue, 18 Aug 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073232; cv=none; b=teHK2HQwEy22YYX0Gv6l6p5MMW/SY1sR1uNQqvHFA1jLWOW8duxABcfjHKrd0NDXCBzb9zQS191KA9/M6HeO5pbmTGt4Qg+MtkgAqsX3gnliulzGg7/bOjr7S6AK9WUkgV72MUeC8jg2ZjDJqUhLhaRyz5CNRfDHnIoqm3G/RlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073232; c=relaxed/simple;
	bh=lVebo+yy+MYi+1KDP4SQDlB87QU8PilaapWnJMupzCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaNhsE+MOLRnezH2WGqvp6Cnuj30r4HX32aYMKupgbI1/7hGTLGfFk13XgkGGNurSfC/kBNMuVvOYTZ4Y6+d5vkuo+F2Rz0oLCHl9skyVItKkj2BljbOCtCSmjF60KhEP8MI5sZJegj2d5aDJQJs/6p3rQ6o3VhfzE3sEVTPsXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqsbnfDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqsbnfDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D051F000E9;
	Tue, 18 Aug 2026 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787073230;
	bh=exy8tCyjH4qq6b9KIMiZmFaUSgJu+qjUSjqFhbLG+b4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eqsbnfDYWg5w1uyGk7UqGDUATDSBLag5uuml8r7tuYv55TBAWxuycyiEGTszO0Ky1
	 D9JuOYM0a+h25VZ2a9Jj3pCwOG03rOz6asSsiY5ZLkD+zcj8tCIM5eXat3yxsulRZA
	 cztmJBeFXi6py9DKBHRaF0F07EShRPfJCjUXfT8z1+S9fvfDyCvCp+pZ0tyWKL3A5f
	 xZJEjVbWC5Z4Ch7xpG3CRZWWeeroDe3M6Ejc4Cfc7IIAuS+QeZisv+T33esh5nIrI9
	 ZBbhqM8d1E/YhwcTt47N8rMhJ3KhzVX63IeGMJ3+hv6Cdc2LNzkSgHbBok92DxafaW
	 mQDDzsdRo2F1A==
Date: Tue, 18 Aug 2026 10:13:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com, gal@nvidia.com, tariqt@nvidia.com
Subject: Re: [PATCH net-next v22 00/14] virtio_net: Add ethtool flow rules
 support
Message-ID: <20260818101349.377d9351@kernel.org>
In-Reply-To: <20260816122111.2495240-1-shshitrit@nvidia.com>
References: <20260816122111.2495240-1-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 15:20:57 +0300 Shahar Shitrit wrote:
> This series implements ethtool flow rules support for virtio_net using the
> virtio flow filter (FF) specification. The implementation allows users to
> configure packet filtering rules through ethtool commands, directing
> packets to specific receive queues, or dropping them based on various
> header fields.

Missing some acks from virtio maintainers and we gotta wrap up 7.3
please repost after the merge window
-- 
pw-bot: defer
