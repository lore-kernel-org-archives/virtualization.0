Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5E314A9E;
	Fri, 18 Sep 2026 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704959; cv=none; b=iZWT1G/wA8nEL2RCEj2OV5PPsoTPx/WUFYcTfdhHZl9TkXKRmGHtWm+aMqnxITHeUUoTq0cIabSHySRd0HZHWXxbSMPhE2HiXmPvAWAfVDGGUHD1FzP9x35pLCnzaKhCKxUy3Dj+y2Xr3PX6V28JEBsSlUMEnUe2P1BRX/+ys34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704959; c=relaxed/simple;
	bh=9j6mHaQpo5U3EuIfgF73AsQ0J0+h9ZfkWXrRY6rm8mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=moE6hxHmGCNLPrzboY5GHZVG/VBNaffVvRjtbfUWSRqljC/laeLoXseX4u5OcOz5HIb7voJ8R42PbWeNg5qcdeGrE+fHEn0mFza0umx+/lEMtMdI/S/+IexpiJlbO0zdFe7fDZ8f8CmepLUqqeKhOfUs89NWyKPcpnTv4Vz40Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFihkrKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFihkrKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44E41F000FF;
	Fri, 18 Sep 2026 04:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789704957;
	bh=9j6mHaQpo5U3EuIfgF73AsQ0J0+h9ZfkWXrRY6rm8mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iFihkrKce1aJTsdopnPf/R9WDC32mTHHC9pQsGOe8kMaC0SlHR7yRYmceahBAaT1K
	 LisGCWtBg5WkWbmUv4P7ZG6UB4lQLqmd7KskAPmDVhTpYxd121U87N+UuC7sjh1/vn
	 aoSepOWKAjyDN8/JzB+Sk3cxoXZ0FmXp3yshO6MThU/yvFTqgrQ/2KmEQaXQpss65f
	 4Tl5Lf9PILOocfg71VZSl086/XSORbaj8j4mEZa7pyuMBlogoysulqBAR3HxuKSqDk
	 osolCWyTGsD91yql4ICTdKu97bxKS+HELltGa6uhB46PBbe9wf71nH1rvibALfeH7d
	 gJZ9WKbAIDvyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost-vdpa: drop the parent's vq callback before the
 call fd is released
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <yuz08559@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
In-Reply-To: <20260918040436.47982-1-yuz08559@gmail.com>
References: <20260907173931-mutt-send-email-mst@kernel.org>
 <20260918040436.47982-1-yuz08559@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 04:15:57 +0000
Message-Id: <20260918041557.A44E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> VHOST_SET_VRING_CALL releases the previous call eventfd inside
> vhost_vring_ioctl() -- it swaps the new context into vq->call_ctx.ctx
> and then eventfd_ctx_put()s the old one, which is a synchronous
> kfree(). The parent vdpa device is only told about the change
> afterwards, when vhost_vdpa_vring_ioctl() reaches ops->set_vq_cb().
>=20
> Parent drivers cache the pointer handed to them in
> vdpa_callback::trigger and do not take a reference on it, so
> throughout that window the parent holds a dangling eventfd_ctx and may
> signal it. The documentation added with the field describes what
> signalling it means but says nothing about how long it stays valid.
>=20
> This is the same hazard that "vhost_vdpa: assign irq bypass producer
> token correctly" addressed for the irq bypass producer token, by
> moving vhost_vdpa_unsetup_vq_irq() ahead of the vhost_vring_ioctl()
> [ ... ]
> the vq's irq. VDUSE does not implement get_vq_irq, so that case stays
> covered by the teardown above.
>=20
> Fixes: 5e68470f4e80 ("vdpa: Add eventfd for the vdpa callback")
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918040436.4798=
2-1-yuz08559@gmail.com?part=3D1

