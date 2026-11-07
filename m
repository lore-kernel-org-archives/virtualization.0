Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794046277;
	b=cTShmKHDMzejtQwjgoblNtbN9hbXDA0sYfoi4OUSMF8qa1fcpGIAiSV1p0G/f9g/hbP/
	 9RqKOKBMkQsN5MB254yjbhsaD4taSTQQVyTeALo9KiQhujBkGanPtyBkd8LEd0hY2QOsb
	 Wyl73h4GsjkKfYCgjhis5ST4t5ZyAbqg5xbD3qGBexL4D7pRJWofZAhaouiAQ5EDumq6u
	 cG/pImYrO6UNLKDT8QCgsf7YjXwSP1538UUAEKivpg8CimcY2neVrvnPjnsjRFSutbD01
	 X5l7unkJfxHGgzROSFSfYNWCk5AQGx9v9MUq9Uw4sN7tnB+NG5YMUo48SCIFH1tFPBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046277;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=D8qnkZYaP8QEiEnWStUV7Ol/+8QaugHXvxXWg6fF5ic=;
	b=kq9ThaNR1Z3PURM81+173EoqKbtQGLSYyG/h96HlYVGqr5eqpFhPd+gAUv8tRg86JLI0
	 NPnQFWQpCOEJd1J95f/ZQ5ZuXL9ODyGf9H8ARJGDqN40OSdaB6WeBnd4TjzkPlWGRsavx
	 oRkSH8836zW7Cdqr+ln6AjYiC5rDzYkLmxOpqBaVzNTiFy1JblOAQhUmUsGCL2+FqEirE
	 WS0ePDV+OPyw8O3WdIzW7kn6k3C113pe3Ku4kDBVpzGLcLVZkVRlK7Mkzu0QqjU4qnX9+
	 Na/cB3qsR1M0fWqDWWTT8DJkhJIuomUyjAdYqEFuEulwbHWL6+i5K3QRUyA4vrk1QdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b="q+//nBJo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.171
Received: from mail-200171.simplelogin.co (mail-200171.simplelogin.co [176.119.200.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F311606A32C
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 10:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F311606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=q+//nBJo
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1794046269;
	cv=none; b=inMcURBaUnnmiFzBKA0XFDIgVEEXX6wZRINKCIAG6GakaHqeqKniiZkuGe2Hl77ebLtKhQp6gQyV2RBapiDzNs8B4QAMYgxtUtkPgoTH9yB88cTo30qmi5A88N/P9LkXEs/KkS6Ci0ch8L6tCyq7ui22YvPEKZIGNkzxk0Qz4dxnsGhzhSHdevDx/to6ttjyx66JrdfkeiczcGjyrqrF6DxVz4Y86bBOFXKDDHL8ik3cZ9+1gyEfkKrPLBstzbOg2smHdoRhn3WgqZ25M8z4/KIg68uOK1RfT2KzfW+LudGYMAzsLH7kwL/uXLtbfpleusZci3sWuuxna41qcgJ9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1794046269; c=relaxed/simple;
	bh=jVDqDvrRQsAZ22D6DF6i3XHA4gMN1HWL8uRQDdFvR2U=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=LzapzOb5NdiOrSUdwgDyf+5xQCwbWMDd4DY56oaTxXK+EAAVDN2u6ldDaBdJsyL7hTTxv6RrLXnE54UDt2aEGapXY0CyEg5mCxCoS+rzKBA3Sv7zJQHipU0di43i19gE7nP8LeslauPhr+yrzoaD6Pe+MSwzlqFUb0QCKtBstU9dFXe0ffhvONP/XMWd4fEw33EFx8jfSfwp36sBU5+2h0KcvUzJ3X+BOpTkuEGLoivu+JksELgFaCOKWsr2PDtnMrlzy9mAXuLC97l6trOfwUY1RGmJ8WeKCOvFPrtpooEws93grPUv/yGIXgqoZq45kUukBsm3CbR7t/YQjuKj3w==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1794046269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8qnkZYaP8QEiEnWStUV7Ol/+8QaugHXvxXWg6fF5ic=;
	b=q+//nBJoIM/k20Tl2DfPZ86y9MIYto7smEAAHF+Mbho6wezvb9NVx3efTxHoM1gM4akVOI
	GImpZhMCtnE4iNLR79mmLuSp0jX/7jMu3/UPo6mh4+B4EBOA28fiegBaHurnZ259ukBvPl
	vktk03EjoFqtNdVvf+8M0AA6ZnzelbU=
Date: Sat, 07 Nov 2026 10:11:02 +0000
Subject: Re: [PATCH net v4 1/2] vsock/bpf: release sock lock while waiting for
 data in recvmsg
In-Reply-To: <DMOM2SFCFHYK.3BT44IQ90X9UB@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: jrmmhm.kernel@eldare.de
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,Bobby Eshleman
 <bobbyeshleman@meta.com>,"David S. Miller" <davem@davemloft.net>,Eric Dumazet
 <edumazet@kernel.org>,Jakub  Kicinski <kuba@kernel.org>,Paolo Abeni
 <pabeni@redhat.com>,Simon  Horman <horms@kernel.org>,"Michael S. Tsirkin"
 <mst@redhat.com>,Michal Luczaj
 <mhal@rbox.co>,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179404626756.7.5004773530941890450.1753698952@eldare.de>
References: <20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d@eldare.de>
 <20261106-kbh3-1-022-fix-v2-v4-1-c7d36703814d@eldare.de>
 <DMOM2SFCFHYK.3BT44IQ90X9UB@gmail.com>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1753699019
X-SimpleLogin-Want-Signing: yes

On Sat, 07 Nov 2026 02:09:17 +0000, Alexei Starovoitov wrote:
> No need for a 2nd copy of the return values.
[...]
>   recv()                          no sockmap    this series   the diff
>   ------------------------------  ------------  ------------  -----------
>   after a virtio reset            -ENOTCONN     -ECONNRESET   -ENOTCONN
>   after a reset, len =3D=3D 0         -ENOTCONN     0             -ENOTCO=
NN
>   after a reset, MSG_OOB          -ENOTCONN     -EOPNOTSUPP   -ENOTCONN
>   after peer shutdown, SO_INQ on  0 + SCM_INQ   0             0 + SCM_INQ
>   asleep when the reset comes     -ECONNRESET   -ECONNRESET   -ENOTCONN

Agreed. I ran your diff in a guest with the reproducers of this series:
the deadlock, the dataless wakeup, signal, timeout, peer shutdown,
MSG_ERRQUEUE and MSG_OOB cases behave as with v4, with no KASAN, lockdep
or hung task report. In the first four rows of your table the sockmap
socket now returns exactly what a native one returns.

The last row is confirmed as well. I'd accept that and say so in the
commit message, since it only changes which error a reader of an
already reset connection sees.

> None of these tests sleeps in vsock_msg_wait_data().
> The sockmap tests call select() before recv() or pass MSG_DONTWAIT.
> vmtest.sh doesn't use sockmap.

Right. v5 won't cite them as coverage of this change.

v5 will be a single patch based on your diff, with your Suggested-by.

Thanks,
Jerome

