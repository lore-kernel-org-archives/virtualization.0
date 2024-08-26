Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658F88827
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 01:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724636926; cv=none; b=jbhpe/7r5l51MRYoUCRh2wvT+U9vA+IGNBTvQ++n8RsDKfOclMrzZjzJxCE54x6qfwW0dmXbasy+8eZgisLcJokraDijmTRt/p4NQdtyI/XYts18ucWSIp8DbrAubUZOtK9tvrNVn1jzJ8dGwI1bCRdMgW+dMoWTvIpMP/zXT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724636926; c=relaxed/simple;
	bh=IFpIjq7M4Q8HeW5xUDg2Mnv7OtXsD56oTLv+w/F+s04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6VmeIC8Aoeq8awmtiIqDRnaBiWf0/3zRzEUoNQ7qdaq5+2STbAKyD4qDp/tIoEFSI2C7cH/6FybUqYxsox9Hx/Mp3JotO8b+IaBBtN4cqzAF9EjA/0LD75q0h+6XHlDdNWOFvg1olT3VMuxCal6/VHut3V1IP/Vfte93OeNgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mXdr6Rlm; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mXdr6Rlm"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1B7480FA0
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 01:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rgu5OlRVg6Mc for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Aug 2024 01:48:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EB6B880F76
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB6B880F76
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mXdr6Rlm
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EB6B880F76
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 01:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iv6ZEUuPPqeOj8zp4uUVvcR1G/kNOJR6TPjSTE0A0Eg=; b=mX
	dr6RlmAgSezIxhXPY1aayBO0uRGpArjLeF6sACQPASjHPD8v4kQLI3PbIlXtOJ3fSBSAwgDAtApa/
	0yHr8iHZI/XuKlK65/scrLyh4ksw8AUNjt8kwIqQBquFqJfoQbxl5pxZgTee+j6mP2LB3lKEF5cht
	2NPQFr6ggugHuw4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siOqK-005fFg-NM; Mon, 26 Aug 2024 03:48:28 +0200
Date: Mon, 26 Aug 2024 03:48:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Carlos Bilbao <cbilbao@digitalocean.com>
Cc: eli@mellanox.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	eperezma@redhat.com, sashal@kernel.org, yuehaibing@huawei.com,
	steven.sistare@oracle.com
Subject: Re: [RFC] Why is set_config not supported in mlx5_vnet?
Message-ID: <d9695755-c0e6-4bbd-af5a-9fc78fac4512@lunn.ch>
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>

On Fri, Aug 23, 2024 at 11:54:13AM -0500, Carlos Bilbao wrote:
> Hello,
> 
> I'm debugging my vDPA setup, and when using ioctl to retrieve the
> configuration, I noticed that it's running in half duplex mode:
> 
> Configuration data (24 bytes):
>   MAC address: (Mac address)
>   Status: 0x0001
>   Max virtqueue pairs: 8
>   MTU: 1500
>   Speed: 0 Mb
>   Duplex: Half Duplex

If the speed is 0, does duplex even matter?

	Andrew
