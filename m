Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626549;
	b=rNgp5z3ZM1m3laLR1WE+hg5eRCZF6ezNJsF49EU0DL87DSB0fyAeKY2fp4RCq2/eq5iw
	 w5V55yTyIhrEGOLUoeNgjLRspZ2NxIekfbjStAaTxwcQbCjHEDrGdLZATY0XokNplfB8H
	 F+L72Uw08OsqXzGYfFdF0x3uTR3WIQd3bFIu45dFFPYAHtDOocQv7cAVlP4OApxUK/bPF
	 hryt2ljMYoQVuBpzxJJb8cQbLnCRj/FMMw+B5NMwD2aBoO99qhzCKSK6DQL6AXYRHsMDp
	 1nkv+BFQ3y5ykigTgfNF3H8JlkysS2nvVKaUQL/0bKHuep9KkfLh3OOaYlxHGH+kDSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=SR2NjE0gtvnG0bwEqpkc3VMdKp7EaTmX3l69R8N2M8ESjPQOzXfC2hOkHb+Cx8gA97Rj
	 9BZAKiZP0RMRifFxFG/5pZGCsErS/T8cOWXMP/s7lpyFnU/9ON2sr1+U5uez52AZqE2su
	 +mwVGNMVgcffSvAdtHzYvhY2G9y7brprIpMSXOf12lsSLfZrbj08JC0rkrsgLHjk9njaU
	 naA0Yv5jdIGIzRazDImmxsggmiH6NT8oS9FNupOkjL4I3H+fpMTa9ZLuUdm+V2JRH/qD5
	 LXJkFcXL8iB4MuYOd2ZBBf5DeTJsrtU+f/xKFscqnZKEqGP57Kt8Kr5xRIQ12f+XPtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TIy/8/QR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE7606A330;
	Sat, 14 Nov 2026 03:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIy/8/QR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E051F000C4;
	Sat, 14 Nov 2026 03:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626549;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TIy/8/QR+2mlmACX84mPKLSgJxGh4qT76lUA4A3S1YpdyK77CzZC68FU7aL2FIFBQ
	 jae7Dpulhl2CHjlCq01tazNkJXGreqxHnTqkgo0hs/EIn8qKYi7lwYGqAeadKFUgkQ
	 mA0rbZwDZGDF4Kc0u31SjgQAebM6rnTjqiUwMzET07rHjG+pF0XORy3f9TcJAsPyOk
	 xeGkim+ufquQcsHVJav6pkh8bnOupmwr7GMYldXT1JijUcHxB8kMMbW/uR6NN9mU/4
	 hE3WJ2CDjnxweiqtJcOs5oumz0u04v+Q5xeqJV84Xq6jrOV/ZzoC9Qj0adQGVRmXpg
	 qHzl77KcUcUvw==
From: netdev-bot+sinfo@kernel.org
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>,
 George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
 Bobby Eshleman <bobbyeshleman@gmail.com>, Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next v6 0/8] vsock: assign the guest vsock device to a
 network namespace
Date: Sat, 14 Nov 2026 03:22:27 +0000
Message-ID: <179462654726.2168702.15872918295479571326@kernel.org>
In-Reply-To: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
