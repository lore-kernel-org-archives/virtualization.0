Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183369;
	b=wgwdLFNWioWLfp0SO8jPdC/geJeCGnYUnUvEWWTyJxQpaOayeB3anzs5t3cGaqR6eCnj
	 GGqVCUHAyMLAT3qT5KUgGP1uJ5tIxicIHZb1eDZqogZiCBEA6JiORIJjq3zC52hFZ3Xdt
	 Amy/IOLbTpmIpZa69IoPxHg2DktG2gMMdVEmVxz30ofHiXxFelwvwVXhH46OAnhVKksU+
	 +DgDQO6fS9/qlJb07nrtVAY9/2UEBMoy6Y0m7eFXSjEdRsce/zpo6qff9ornfvmucfmRe
	 Agl5/Q7UYF0iRhSpetvM0uC3RBdRMiz5+IyHiwciXC0atqbCwGyZJD62gK32NW4rL4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183369;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mJ+S+yvsqhaCB8n9aaszyP7eunvu86hd1xGXatKIzB4=;
	b=IwOM3PeY+nKQt4kLaQxlIcx771+1HAJeh8oIw8bPWa54i4tsoVpkzZHgTZSdRYM6P95c
	 BaH2FKyIOiWHNEDwrVMNgd/0yuy5+m9XAO7E0pge5G21JJpsU9xGdLgbX9OPCiE1yHmku
	 YpQohuCvqNEF1HpS34FqTu8wslnHbZeRubcdX1xhahYHWvQymIOdYz3w/SL/afuMGnT69
	 bj3sJkvYD+1MMEIjXHvVZl2j0ZnSwotS0J6ptSdbYSW4IwdYqVlgfj97dz0dDDXJikwOE
	 if1wlwETFL8JuNlajqG/yBlcoxwK/8BvB01Kcyx27gdNbVzhx9R0s+mD0lsRnBatWtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlMVZJE4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E34606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlMVZJE4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38A21F0089F;
	Mon,  9 Nov 2026 00:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794183368;
	bh=mJ+S+yvsqhaCB8n9aaszyP7eunvu86hd1xGXatKIzB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jlMVZJE4IS9j2pkhb45zfg5o2wCQngBjQbiygyYiJtehUysJQcQb2UH4wv1CmoS+I
	 erqk+Ted/4CQXXUCHvu9poapCJWjlX1hyvDhEi/UNYtwMYdF+LKOKS08xejTTh1+cU
	 Osv57ULNGVKIJycLeNXxkfEKztb6JOCp3Yth7IOXuuRiGfAVtNrjOwysg+8IIY6YAN
	 xUyFbfbz+NjljFrii767if7LubEaLRETLIxtF4c+SFaO6/5oQVRtu7dz1rtauWq8Zv
	 1gcvrx+96J7wRV5rBoO7yrD/rDlcxzC78lr5Q4wkss9bidl3RxOz3ZvQzL0kFo0Pgo
	 2cnE2zDI/bW4g==
Message-ID: <sashiko-outbox-204204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 06/12] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-7-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:16:08 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Keep the control queue available through snd_card_free() so close-time
> STOP and RELEASE commands can still be submitted. Block new control
> requests and mark pending messages canceled before reset, then release
> their queue references only after reset and queue deletion.
>=20
> For PCM queues, detach each remaining virtqueue buffer after the device
> has stopped DMA and retire its message without reporting a normal
> completion. Detach all queues before deleting them so outstanding DMA
> mappings are unmapped and no token remains for a late device completion.
>=20
> Protect event callback admission with the event queue lock. Disabling
> events waits for an active dispatch, and later callbacks see a closed
> gate before ALSA objects are freed. Enable and pending-event draining
> share the same lock.
>=20
> Reclaim pending event buffers after a failed probe without dispatching
> notifications into ALSA objects that have not been constructed. Record
> the queue's prior enabled state under its lock before closing admission.
>=20
> Track successful virtqueue initialization so teardown and failed restore =
cleanup call del_vqs() only for an initialized queue set.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D6

