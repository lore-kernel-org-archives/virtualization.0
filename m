Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71A2D2394;
	Sat, 19 Sep 2026 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789824600; cv=none; b=MLgFJ3DByOc+RLgp7mCYSxDRp5Ftl/QLLCOAZqmy55m2+lNxVg0I7LobqeC5wB1ZPMOArdsy+EO5bcKV7/T5vB+7qUiVd+SB4AijhZ+TmWkrO387SgTlmrDi3s4bgcnRRb6DLv4kzOTDYIBW3FD6raEfBzRhAdafuHjP/CEUeYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789824600; c=relaxed/simple;
	bh=sSLKwqr+47zSvK1oukfiqPQ+tfSc1nFaCD8dE5sMPdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=COpjoVRrGaRwgLAgEopDKgP8ervHybzeqTZ2yyxm+56gBEy8/qDHf1Vx4s+ybKvkFn143E+z3hT3ClG9C51XNCPANPRmdJ3fHPjhuAkA1OSKVLCSpM7SkBxwQFPvm+rCjklXRHW2E7E6OkNerTSEcuqqhnepL004Jt0TjdoZAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBEutq8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBEutq8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA071F000FF;
	Sat, 19 Sep 2026 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789824599;
	bh=VHJUohlR+K5vmAPFr+atr7PDdgi776ptC2P8Sj1sJ2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBEutq8QWKoVR14MeRmz+IjWgfczLf35kiBExPt7jdQdPzEtYqdYKjZm8VQ+DIKh2
	 Am7TO4vFRYGvfMx8Xgpnf91fncgQNt85k2839iNNNsuIWOTnANiQqVL9y8Yx3le4pR
	 DZ14QtzkERS2OTtkU9DNzxdSN02Wf3XVaMy2EU0J6ygmMiMb4h1VLesgH0aCsy1Yoi
	 xTA2CJIdhq4uM0a4krm42Q3ZMWhUEiyQ+UzeTFBb9l40deLpwF/7Ltt+jTDFnPkdZN
	 Rfw4MlyQsMMyRlATltglGge1BxIiklZQhaNjl00UEGT9z9xjiiKsWvSC4/9/W8qoit
	 dinB3SjU5vFgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost: keep vring addresses stable while the backend is
 attached
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20260919131744.131030-1-physicalmtea@gmail.com>
References: <20260919131744.131030-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 13:29:58 +0000
Message-Id: <20260919132958.CFA071F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> vhost-scsi keeps the response and bounce-buffer iovecs until the backend
> completes the command.  If userspace changes the vring addresses while the
> command is in flight, the completion data is copied through the old iovecs
> while vhost_add_used() updates the new used ring.  The guest then no long=
er
> sees the completion.
>=20
> Reject changes to the vring addresses while a backend is attached to the
> queue.  Keep accepting the current addresses so userspace can update
> VHOST_VRING_F_LOG or log_guest_addr without stopping the backend.  Queues
> that have not been attached retain the existing setup behavior; userspace
> must detach the backend before changing their addresses.
>=20
> Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fab=
ric driver")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919131744.1310=
30-1-physicalmtea@gmail.com?part=3D1

