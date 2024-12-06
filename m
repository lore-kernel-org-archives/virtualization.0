Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB271D515D
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510390; cv=none; b=Yq3mluztCpUXasG9NaeMMno/rsxD/UAZC9T8dByITlW6DyfZgJYlZm0iaRMHQmhxDVvP1QQO8GR5rbnuz6YXQjdANnXDMO/ZY3EA9/8WZ/D3KfgtWEibhPwfbx91RDPtKQ4DG+iHWTelFlIaePNobztIT0tiC+SeOfma5JAHbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510390; c=relaxed/simple;
	bh=E2wWjI99kdWUXdSegLXUSROKPLL4L2v5K+qdOzZZzGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cD47IdhRzC7e/z5HAlWLz0aHBbAcxRSwSaQ5jSQF74JPDAY0x3VzHfS2+OkXiCRMcii9yb+VHEX8O6SRX45uGAcQWSpfQhsO92/YkNs1v01/spWC4eRnm7fWdSP16CnU69E2HzaCL3XP69jJvGF79J4WL6QUotuxeqKVf6IAegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=o62otV5b; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="o62otV5b"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tJdEo-004Rdt-SN; Fri, 06 Dec 2024 19:39:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=+NIUr4L2/mU5OspHum2ca0kQMsGCg5gpDhpnV9PRV+M=; b=o62otV5bl0SQMLz+SN+ibPxsqd
	kjTHf9j6JhCKoTGv1TbGQBT+UAPymNXJMjClPAQu/33v4bjmxsdMqBGfiov0L//2uJ0mt/9bCKsYw
	ntV5Oq08QTShWIZ4diA2FeMm01JeP0ij+VzlTLa5mUN13bJp826ljtSinv+UWXODwDGsZXnY2J0fB
	ZdZmF2z0c7UHwWaeCzuO8by/x7rwnALpmStpGPtEmprHSEUIl49UdpHUBRClXGBlDQ3tQMHt1LLV3
	XGz9TQuQLrgmQg5hvM31GZctuFq8pewOKUdKr3x4psyoUUJRHnYcLyZLV3po45DDtphFilp5+Emh/
	pStHfjtw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tJdEi-0008Vd-IT; Fri, 06 Dec 2024 19:39:32 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tJdEd-008J3Y-58; Fri, 06 Dec 2024 19:39:27 +0100
Message-ID: <3f1054f1-bb3a-4345-a58d-272704c76f4c@rbox.co>
Date: Fri, 6 Dec 2024 19:39:25 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/3] virtio/vsock: Fix memory leaks
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jia He <justin.he@arm.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>,
 George Zhang <georgezhang@vmware.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
References: <20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co>
 <7wixs5lrstuggf2xwgu6qva2t6atqnthcxycg6mpfpx52gl6fq@qmwb6gtgpad2>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <7wixs5lrstuggf2xwgu6qva2t6atqnthcxycg6mpfpx52gl6fq@qmwb6gtgpad2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 11:31, Stefano Garzarella wrote:
> Hi Michal,
> 
> On Thu, Nov 07, 2024 at 09:46:11PM +0100, Michal Luczaj wrote:
>> Short series fixing some memory leaks that I've stumbled upon while 
>> toying
>> with the selftests.
> 
> Are these tests already upstream?
> I would like to add them to my suite, can you tell me how to run them?

CC got accidentally stripped, sorry.
Long story short: https://lore.kernel.org/netdev/20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co/

Thanks,
Michal

