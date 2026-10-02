Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803B471CF5;
	Fri,  2 Oct 2026 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932430; cv=none; b=TJW5qdPHVrg1n8ZLEiwM2178XiYAonphvn7OeW0ATbbeLWk3F70fRx9mjgTXixAdJLwdBneVaA6V6Vw9GQrj5mX3qGB4KsoFACvlxGHJ++gN6rZmEVNNNcMVQI3s4HT0uDIlDm6I4MrBxEJfydTLA7xVEEyRkJRmkDz6eSderOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932430; c=relaxed/simple;
	bh=ip8uEEGd2i/sloSlBTYKL4V0rTbW1FiNGUJxxvZcG44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RQG9MmuLTdBfkjKeT30p2UiPUfgKUR7ArwJFWzJE9JMmNorW9PS83DlP9dqZcQT9ybB+wPsJxTU8JwTDSQxMNv17vKAD6zRdm9qLE6AS5W45s1Lzgwp4LRiVOCybzMmZVJKDRTY6dlY0b/58dh6cgJaRS9hOgrwmBnmJ+83blSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7BQYgiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7BQYgiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA10A1F000FF;
	Fri,  2 Oct 2026 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932429;
	bh=q5ovX5k/4FYWByFr9SRmFa2RyzHBD6wYNHg8fQf0rEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q7BQYgiQpvztwQKPBiLSFlEsX+i5LO6TKD0DvFbwL2tgraNY5XFmN9z0e7gUrlHaA
	 tUFaxxTH9O+a0D8oMneuiBN/2m1Y0KP0k8WCriFvR2ZYDOCbWLsfrpsXMgwjefTen3
	 Sn0t/H06jIQ5q4YPkMeLbrzsuta1Hlt68qR1GmWA+U50MAVhRfbIRlYDm7iCI420xi
	 8Hf4tDxGSnsEVPMSGysh44RvEg5v+EcQikzSoHF8TFIPV048WQHbCTce/hcdhPKyg3
	 kgrDxi6ON+B24urTdZi/6fF0pOIfvxLzu6E4FOCvecitGNYWKmVG/cpTQN9W87JqYA
	 36Yyff8zI+CWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] vsock/bpf: release sock lock while waiting for
 data in recvmsg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Mohm" <jrmmhm.kernel@eldare.de>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, bpf@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261001-kbh3-1-022-fix-v2-v1-1-cfae958a1976@eldare.de>
References: <20261001-kbh3-1-022-fix-v2-v1-1-cfae958a1976@eldare.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:48 +0000
Message-Id: <20261002091348.DA10A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>=20
> vsock_bpf_recvmsg() takes lock_sock(sk) and holds it across the receive
> loop, including vsock_msg_wait_data(), which slept in wait_woken() without
> dropping the lock. When data arrived the transport's delivery context (the
> vsock-loopback worker, or the virtio/vhost rx path) called
> virtio_transport_recv_pkt() -> lock_sock() on the same socket and blocked,
> so neither side made progress and a blocking recv() hung; the hung-task
> watchdog reported the delivery worker in D state.
>=20
> Dropping the socket lock around the wait is necessary but not sufficient:
> vsock_msg_wait_data() also did not loop and checked too few conditions,
> which left three further problems in the same helper.
>=20
>  - It did not loop. Once the lock is dropped, a wakeup that is not for new
> [ ... ]
>=20
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-kbh3-1-022=
-fix-v2-v1-1-cfae958a1976@eldare.de?part=3D1

