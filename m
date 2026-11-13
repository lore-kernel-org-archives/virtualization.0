Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584974;
	b=w5HyJcxyYtrkjb22ZHFLQErWPFOhK0IECMmExADURTKc9ivVcflGyRwdpHO7XpjScQdj
	 Y2zUH79+qNriTptObjImL/lqVSwG3HNLIwfR/QMzpSvBpEe7KdYbi4YIp9tJz9e0luPUa
	 DIoTsv6NT33qoN4yDeKEU9HUwZNBrALrLiLITDZnClVUjBDgDt47BJixOmVUMLTXaZOBO
	 zgFyjZIshJvr9qRoeQeIwRzN7EyQd/d5+aJDVkXMGVkdxPKNB6u9F6vA7VRKz7KGBi+SW
	 ZVNttcNGaG+mWqefwq37r0SYEFVMWyHKuBnVLV9boezrm+I7s15c7FlSLbkV9E8w7ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mzDsiiojiL4mTOXt/Vv/wvxDj7rKGKQvTT/mc7baEn0=;
	b=TjCLgNN06f2dn5Amvo02EBX/0Kw+pOva/P187DUgqBJlhEXRnYMHPLgYoo0WWEFHWB9I
	 sYIGwO9y8+/yM5et/dTmgnZBRAZkbO36jMyWOWAf/i47l+TIGcqRCGwaBo0mvwKpK7Lf9
	 1cK/YRB9jFqMhRuXPGF3Q80LxjUXbWy/Wsl2w3k49Qgj6kP+y83U8KfWkpPInW7B6JdCY
	 yMKGpNT5ahHBeJBk+gZ/DdDUNmpkKwyYf6x0JTZ3+0+TXMH6ID+uh98yNdLtwnZre2Q+q
	 Oy2tB+FjPVbuggDNzkyUbCmZD31Yn0+pwczVxiYYEgHwDphNN6GytRHJTmYpIwp7iTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=mgRZV9rX;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1B606A327;
	Fri, 13 Nov 2026 15:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37D1B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=mgRZV9rX
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xRtWs-008Tir-Ic; Fri, 13 Nov 2026 16:49:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=mzDsiiojiL4mTOXt/Vv/wvxDj7rKGKQvTT/mc7baEn0=; b=mgRZV9rXzB2J0fYuHh7DZs2H6s
	lSWUEO7wSTWvrW4gDWtt4Ms1XKThMoKzRfm/ElfCh3bl9QSmSaWBtPP4Eu0vA4tyyp/zDFLAN9q+k
	mLTqtPBGrNGtqFCpgAtcBMiH+B5wfBKR7PWhcJwAykGOntZc+yttVToJAPGyBgty2eyyI4V6NFOEJ
	rwM9Ojhf7fTJroiSBg+IkkY+bmVa3MQVfvNqnOQJYHAoT6EV8WogVFyOhYeKxibkl4DPBiJzBNrrW
	yrSlODVfTePQ7q7LJjVv3Ov/cj9/EKNrd+iRWYSReFdl3dxTGHwr2oxvW5eu0DIZObq8OglNoqZFO
	oMq3aGIQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xRtWs-0004Ct-1U; Fri, 13 Nov 2026 16:49:30 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xRtWq-009Xqv-6J;
	Fri, 13 Nov 2026 16:49:28 +0100
Message-ID: <75c6fec6-7323-494a-9bd2-905e9dc52f5e@rbox.co>
Date: Fri, 13 Nov 2026 16:49:25 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net] vhost/vsock: Fix socket state constant
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez <eperezma@redhat.com>
References: <20261112-transport-reset-state-fix-v1-1-5698375f52a9@rbox.co>
 <sashiko-outbox-212625@kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <sashiko-outbox-212625@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 11:34, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] vhost/vsock: vhost_vsock_reset_orphans() TCP_CLOSE breaks
>   vsock_connect()

Yes, a known issue. Fix is coming.

> It also noticed 1 related pre-existing issue this patch does not
> introduce:
> - [High] vhost/vsock: data race in vhost_vsock_reset_orphans() [1]

Right, also known. Not sure why it's "high", but I'll try to tackle it.

thanks,
Michal

