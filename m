Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0339D6EC;
	Mon, 19 Oct 2026 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411761; cv=none; b=W5y4q5lHONc8qPevePH7Sl8r77t8R3JihDde1q7ud79uQ/at5ZDQZe85a7rcqZPalYSwa4CmqETKbCW++IBrZTrMAOvHiZTk1ESVQ6LgDJ7wVwpfmutz8FiOYwAAxxiycqByqVsSnMqViMxjX0yE0W7YcgfYcFcHl5RPYpuUTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411761; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZKPsdh2OilWOxDNJpPpFkkaqiVpn5/Al5m3yeRXatSNKa8F/EwFbtMxlzBvzYnMt2RdrtqHl3sgibInzWDro5Rrdu1+FOBkBG94+tgZ5pcqAZ/qn37DpfbWxFz10bZjgeZV/bdebzJHvyWgEnboJbunN8EVTFX06NCla9pQTr58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnHVZ5Kg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnHVZ5Kg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18411F000C4;
	Mon, 19 Oct 2026 12:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792411760;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DnHVZ5KgwF0FuzGzKxVAuLEnxZVfDJaKjDmRXGmrgX/IFQTk6aWiJu3g4IjlXOyyb
	 Sz0JfH0yvBGPxvDS0owJdrRoTS2nRyHesFOjP6QOIll1J5XXqHaLIi0QhHfojgsbbB
	 g0cCB6XpGfVkYDkdvYswz/aiPVlhcIrjb7pbigCiO34TsbG+uIxwpyhXs/hQOyI8nH
	 SQP7wl+YyGX0XkhZph3HeoeWAg1omKTT7Srm/20VrLGiEAPZBeBuqoBHhZ+wQYiOKk
	 78saLiE9gyI6Q/aMGFBfs+syotUOKjvCPuOG3DZxZ4B8RAOx20hvXGPNa3awHyomNu
	 2mstGVliOv3gQ==
From: netdev-bot+sinfo@kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Chris Arges <carges@cloudflare.com>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Max Krasnyansky <maxk@qualcomm.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net v3 0/8] more virtio-net csum hardening
Date: Mon, 19 Oct 2026 12:09:19 +0000
Message-ID: <179241175916.3290.3107334544259481724@kernel.org>
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
