Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBB287272;
	Tue, 20 Jan 2026 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768951131; cv=none; b=XiqP9ujPJYtgZDwibFaSveH1CtU16TzTbMB5mawwYXDlvqycIsUY4u0II/qtneM/gNV4ojPyZ2femea2OEF29W5+CioylEIZpf4tlO5mpyjteYO0GvcGq3rOsYoRNwPfGXZMp2FhUg9C26tYtLN3xsDJ7BjyKDA8zs/EwSF+ilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768951131; c=relaxed/simple;
	bh=rhIdiglnXjC0fp1zFEv/hrjRU01KuohsJ3nh01dHPZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehPcmV7OYPiG7mpB6ZYEM/Gm2ZQ09du3TYVQ0E34MYIxu8bV7YwD3nnPXOa5rzdrfvXTHXuR2xGzQavh+DEDrs7UZr0mt4uaBI42t4dAhPwiJ4FOSTLgKVgZLl35esjjrdGPK5g73N0zdigCA9AmcsyyA9L3t2Uilu5zqRMui5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcuZNz+D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcuZNz+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71E3C16AAE;
	Tue, 20 Jan 2026 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768951130;
	bh=rhIdiglnXjC0fp1zFEv/hrjRU01KuohsJ3nh01dHPZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UcuZNz+Dz5vDY7oXixLokeQoeFSVugCZYHuoQ9XjL/TIMruJqEQAN2pdsC4doEc5t
	 Gh9iS3JA/lfT/CpEf8uK8TmwTD4otAY4BWtkiWz8c9jpq84/y+LSo7CQFdpYJtjNkI
	 YVns2IwOfjfwvkigFuTqCazbh5vijzjaIVQ69T3T/L8DeLdNV55/7enL/PHaaOrkOi
	 fGlqpNmdyka56Qiyx2dqAvakjpcBbuTnPlEESdUiUN5uyINwHWtnSQ4bAo3HVS474z
	 w7+JIMPqFwF4fFzjBnkpTQdAuE+L7JBddUaLegSZCL7ddyBkz1V3TXqqcWn0szFHuI
	 sYkPrXUpBXt4w==
Date: Tue, 20 Jan 2026 15:18:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "Michael S.
 Tsirkin" <mst@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, kvm@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, linux-kernel@vger.kernel.org, Jason Wang
 <jasowang@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Asias He <asias@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RESEND net v5 0/4] vsock/virtio: fix TX credit handling
Message-ID: <20260120151848.3b145279@kernel.org>
In-Reply-To: <aW9L0xiwotBnRMw2@sgarzare-redhat>
References: <20260116201517.273302-1-sgarzare@redhat.com>
	<20260119101734.01cbe934@kernel.org>
	<aW9L0xiwotBnRMw2@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 10:37:12 +0100 Stefano Garzarella wrote:
> If you prefer I can send a v6.

We'll need a v6, patchwork can't do its thing if the series doesn't
apply and last time I applied something without patchwork checks it
broke selftest build: 
https://lore.kernel.org/all/20260120180319.1673271-1-kuba@kernel.org/
:(
