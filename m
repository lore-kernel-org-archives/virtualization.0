Received: from mail.noirlang.tr (mail.noirlang.tr [217.18.210.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69304973AD
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.18.210.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400333; cv=none; b=Tg8TcHwUec3G5nbCOAdFMtOs73uSLrtC3owbJBg2z7vt1Y7gJAB5NUvw7QUGRUQC0cIqeAXVbd4C/d6nKKV/VxF59mZcYmJBLSz3V03F0Ez5IGYGP1mWHhpW1P2wDiXLcO+MruPBDHAQdcy+VkS6b2SWUWyVRiOC0vrsQlWG8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400333; c=relaxed/simple;
	bh=vy/QfJwvOl5NZkN6GRHZUnAWaidHniVzTUyIxztUz5A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID; b=M46LoAHssczL9OhOmFgd89dhNO1IRQ+IjQ3fEcUX3UmfCEbI5T46dQGPeBugS26Y2ixCz4R1YGquYVbQTAUqbR9GvPMQEbOv2skrY3V65LXQ6Mh3v/fwjnNPhnkpzTEo8lodvqp0LrdDKOY8oLI+zrotGrBliiVZM/xg2g5GBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=noirlang.tr; spf=pass smtp.mailfrom=noirlang.tr; dkim=pass (2048-bit key) header.d=noirlang.tr header.i=@noirlang.tr header.b=rWwqLpRQ; arc=none smtp.client-ip=217.18.210.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=noirlang.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noirlang.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noirlang.tr header.i=@noirlang.tr header.b="rWwqLpRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=noirlang.tr; s=mail;
	t=1792400329; bh=vy/QfJwvOl5NZkN6GRHZUnAWaidHniVzTUyIxztUz5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rWwqLpRQNbqu1C6KCGrBhcGyE42MBBklQIH10/nPIR45sOm9V/TEohudTUIWHBnaQ
	 H9QRhNjEViIsbj9nxumsdjkOO8Eli/w8cPHplN0KppING18R5o1M4EEEJMV/UmUW4i
	 p2MhkJ1yP8bV144CSx0l1c2XbgCTQDQFDJ7f+HBgpFe2m1ts3f/D03O2ejrGUfg2oc
	 kWbvzgGx5cwx6zlMR+uErBTvQzlvYnYeeH/2kuLfaxbW3SIYkfjATEobq/lQn62z1d
	 meI56C+1v8IUYzAj6ZyN4jUszLCU3zTItVkr+d3FRlMVYAG0WjUaGX+OwQ93qddDNT
	 fRHFDSOiewYbQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Melih Emik <melihemik@noirlang.tr>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, gurchetansingh@chromium.org, olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: inline drm_simple_encoder_init()
In-Reply-To: <f91ca908-689f-4732-bfb3-0e254c22361d@suse.de>
References: <20261018112844.360262-1-melihemik@noirlang.tr> <f91ca908-689f-4732-bfb3-0e254c22361d@suse.de>
Date: Mon, 19 Oct 2026 11:58:44 +0300
Message-ID: <179240032411.5720.11612713342126517911@noirlang.tr>

SGkgVGhvbWFzLAoKVGhhbmtzIGZvciB0aGUgcG9pbnRlciEgSSB3aWxsIGJhc2UgZnV0dXJlIERS
TSB3b3JrIG9uIGRybS1taXNjL2RybS10aXAuCgpCZXN0IHJlZ2FyZHMsCk1lbGloCg==
