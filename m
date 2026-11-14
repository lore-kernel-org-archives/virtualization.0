Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682230;
	b=mlBsYmlWzyXqYQmNVlKFyySaSPBp0my3C5zInPilNCk08uYkOI+SHK+QYfAhtOxqvc5j
	 4oUcPDn7R/SIwlkcngorlTExWxWW2y7oTn40aIZIOomKWVS6GgzJOquO+mxt+lWvON21x
	 Ty4RHpP7fqJMO74DYxDgFPz4IBbC/X5lDPNoCpqZuAMlCr6CilcRfr89Z4V0KkJwEFvqS
	 6Bxis+sSpGi8V37b9Mm0whlRV0J8OhIcIg8DinaO/vE6dbXaIZnPPK3wvj2CMmUGN976k
	 kE8gISeUzTIz1jzIkNI4kpMPP4emFUlg7lYYsOdtkeeK/CpmjyDPeXstvHi21qWEqMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=J7v9/YPEzjxZ/LGBEzvQ09s+gFXT8pS/d7xVKdjrCoE=;
	b=d6G7iCINWRwFX1uM3yAe+LVD62gkg7ENRdAQsVGKkVRtqoc4dxr5D2Dy3bRs2jR8v03A
	 HdHXbPO1tFOn+SGeq2c0azI27FJFJayEfLzdyPFDYCbKsSbD2I9ub1mB3w5gvB6a0QgiU
	 44Vv6JycEUCxPJZt1cBnlhv/ANU/9b60l2MxUfyQ12RxOEGDSiYmOFgTWgoNVnsCOQeJy
	 zR+pnASn9YOFr0bAwkJToIlkJqTFK0Hu1WDsYwtkVoazAASDCCMbjc7dNHJpXmVkH6Rsj
	 AUHnS0KW/YJHf+ZDn4gByamC+ydtSE1squvac5bMQegxj+7uJ9iB9edzlGsVqBh9BOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYNxHMon;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840D606A88A
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 18:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D840D606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYNxHMon
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e977109392so11968715ad.0
        for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794682229; x=1795287029; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J7v9/YPEzjxZ/LGBEzvQ09s+gFXT8pS/d7xVKdjrCoE=;
        b=qYNxHMonIOEvpHyXqeloK1vmr51pHI7xtgymi7jwXqfA+yErSGgfenymGAsN3UzE52
         VW0XNy2JwpCG9HuPpyJEwWh+O44o1c+lC6dnlQi/WIfqEK24OF0hjsCOc0XEFFphYlvg
         fYJ94zo7RHwrM4DGCQ5/N7+39RIWu2QGxrfuRYUtQfIFTjt9FLxwHDJauK5pe3fmyHbL
         qwEwm9mEQibVIimY4nqAS3vNMJ+Vuk+/kPqPVifW1XrlM5jy8dfVkcdHFiQ4B4rrUSEl
         zlbMpm1JEYF04cevP4Pb9R6TgKgdgiuxhaiRHqqOPxiamLjvw67Ni3GEXw2eZ2+qjcAe
         tEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794682229; x=1795287029;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7v9/YPEzjxZ/LGBEzvQ09s+gFXT8pS/d7xVKdjrCoE=;
        b=KJt6cx3j1lxVv9jkVqlAj4nlmpHmWLJeRSRyFzQKBtAVB+0xHtvnXJZviORD+6wFc0
         wY4OzmxJxS0eC9djr2TqRXKbZaC6TmzLu2+5gEfNBuPCgPurFBx+XxVahedkUQi5MMsH
         0iNbQlN7aaPc4GskWE5wr5/3x/S55ZWS4rQN65RokUOigkRYqQAYh9xl5EPlOv6wMcf2
         i5/5/qIiC1ioq1ppw+OJOHNjPasuTHgvmqH9uG2HrFGPUa5eystit4Gw7C2MZTKw3PfM
         ABxKFE6eHdiZihaEoCJntEmdpYAH+KGpT0BzYAyfe/UiaUxNqomdUFpisF2WOien/W7s
         Z81g==
X-Forwarded-Encrypted: i=1; AL+hErFjYh5xduhvBSarqhfB5sRqYgxHWSXrw6lIdn+jraiT5hv+pdnZ3Ply5QesgWvBFkD/aibUKfk7CZnHWZO6lQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+wWxhcjP/3by3GfgNa4rYV069B1+95DohxV/3vjA6tIbs7O1Yg
	reEZQkrH3ynVDztXusdHEg0hBnvp8Gfwdg7wUboZfkqdBeHmqXoRULwe
X-Gm-Gg: AYBFou1AZJMwOM4a9hAl31lVyERqJil7kpbDVKEYxOUDc55WJ7U5vPz75V+v8pezXfR
	CwvQVNGykfhnIa/8raTQdKJPmkOnX9OCk3o7cCMktc31xyapkjAFaWWCnE1KbOoQrQrZWFyIWTM
	37o7Jdb85g99qeyiUqZ/5o2Qc0qaNCljSZJbeRx9dCe8I7HDXPTh0I474MOibpjUeRIsyJMRjnw
	JApN6x2p1dV5W64zj/eDKNjMXK5M98F88VEEFntFOULMarLHkAoBZl1yQ5IR9Gx7P1TYxn35wjC
	VnZK3efn/7lLvnmvGotP51R0+lMWjrLQkdzLjRxNiGfc4e44o5EuJwW7PHdMw/SjNGPEdl7ZUWY
	N6AsvJdxilKllo6ylONC3H/04XR3y2XzMr4Lcj0XocmQD1snzBW4BZNH8s5Auqyfzct9SHc0wxL
	HUtNGKkYj8hnEbuTNBsBHANyFKo2J3DZ7SLA9QUe6spQw0KJIw8fb3XO/DKPsqegUI8eX4ehdkp
	py3aF5qEgTADOMIWajNzif1uY5jrtwW88k8snGUaJg7EvxCxzTgk5eOezvW3QkbWm1XF3XsMDNN
	GBkNOEd0QRZUEj7r2DrLk+jNFs8azwosgVX6OiI6ZpVx1QT6R7HDJKs6U1DknXlsqYEuos2rY0v
	sKYDi2Oj5ctWP0jSPubGUEEQRCMci/uXu2A==
X-Received: by 2002:a17:902:db04:b0:2ed:2b43:483c with SMTP id d9443c01a7336-2ee0dc2a5bfmr60623615ad.38.1794682228921;
        Sat, 14 Nov 2026 10:50:28 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75c980sm22473765ad.25.2026.11.14.10.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 10:50:26 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 18:50:24 +0000
Message-Id: <DMV5R4A5D4UE.CX5X9T3GM3GL@gmail.com>
Cc: "Michal Luczaj" <mhal@rbox.co>, <virtualization@lists.linux.dev>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v6 0/2] vsock/bpf: fix recvmsg deadlock and
 zero-length, OOB, errqueue reads
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <jrmmhm.kernel@eldare.de>, "Stefano Garzarella" <sgarzare@redhat.com>,
 "Bobby Eshleman" <bobbyeshleman@meta.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>

On Sat Nov 14, 2026 at 11:59 AM UTC, Jerome Mohm via B4 Relay wrote:
> On a vsock socket in a sockmap, a blocking recv() deadlocks with the
> virtio delivery worker and stops all vsock rx on that worker, and
> zero-length, MSG_OOB and MSG_ERRQUEUE reads spin with the lock held,
> wait, or consume stream bytes. Both come from the commit that added
> sockmap support. Patch 1 hands those reads to __vsock_recvmsg(), and
> patch 2 releases the lock around the wait and makes the wait loop.
>
> The deadlock and the MSG_ERRQUEUE case were found with the help of
> Anthropic's Claude, with Stefano adding the stream-byte part; the other
> cases come from the netdev Sashiko reviews and Alexei. The reproducers
> are available on request.
>
> Changes in v6:
> - Split into two patches, the zero-length, MSG_OOB and MSG_ERRQUEUE
>   early return first, as Stefano preferred; the deadlock fix does not
>   need it. This is the reverse of the v3 and v4 order, and 2/2 no
>   longer argues for one patch.
> - 2/2: check the transport in the wait loop before the data, so a
>   reader that wakes after a failed connect() has dropped the transport
>   no longer calls the data check, which warns (netdev Sashiko review).
>   I check the transport instead of swapping the two tests because
>   hv_sock reports the peer's FIN from its has_data() callback. The
>   WARN_ON_ONCE() at the top of vsock_bpf_recvmsg() is unchanged.
> - 2/2: reword the comment above vsock_rx_done() (Sashiko).
> - 2/2: leave Sashiko's signal-and-timeout point as is: such a reader
>   gets -EAGAIN where a native one gets -EINTR (see my v5 reply).
> - Rebase onto current net.
> - Link to v5: https://patch.msgid.link/20261109-kbh3-1-022-fix-v2-v5-1-4d=
9af04f0fad@eldare.de

thanks. lgtm.
