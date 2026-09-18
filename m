Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B34C2260
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726074; cv=none; b=fsCloR4D4+//E18wqB3X5M6uR3mu2NUhOHruWGSCUZFv3hF/Ak7PkDKPAGy1kj8YqOgvuQX3uk163kSxI5cyJ79P6+iN4mOVw/+Fwodgr0+zbgCeLYfFRBby2/w6cXAsHnTbY1wfPr5CLellzl2E4hhTx1zqyAyFeFcykUSCPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726074; c=relaxed/simple;
	bh=amWrtF5YylKYTYBTBd4Z2A61U41PRF0nvZIEGJTnREs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j5tbU+fH+K5vvPLIz42heSq5c27Wtyz7Ca8o0JCXlT5jtNjKRZtV3y72we5uowoapNO6po3oV200qQGfpGF35yldKyTY/nNwtLuZ2sghxVcfUaWeaLrDPFlh+Fh/lp6EPB2HjdhB9HuWTnHBnu49NJbGIGpoTmy2OOGQyFXqiCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBj9YTS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBj9YTS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BB01F000FF;
	Fri, 18 Sep 2026 10:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726072;
	bh=amWrtF5YylKYTYBTBd4Z2A61U41PRF0nvZIEGJTnREs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jBj9YTS8i5+YAis0sKvOENC6wd7w/keLU/NsLRzfHumk3aaEt44dW6ji7QvsLz8iO
	 fSABgNUZoC0Du3u+gWmqNK7CYi2XTLVGJ0f2o6dVMn4Eei5fW09EPenIQNzKzGvq5Y
	 CGmwL2JjdJSixTMSs2Gb08DQQjHfwudjVi+Hlf/P1x2Xj2WS0k+jYU6jhyZjrLezzG
	 4tg3SudQIAanZzCn/HpZzrb/FY7rgU78QYJXBprXUYTn5fNEk9j50u2Gk8JuNeDy2u
	 C8NfTANxkHt5FwwG1Ha8CtlIrlucAEd2OSh/zlDShErQYV+swxCJQ7ZUUcu2cy1HAh
	 FugeQGaBNyqUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] drm/virtgpu api: add blob userptr resource
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260918095940.2253018-3-honghuan@amd.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-3-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:07:51 +0000
Message-Id: <20260918100751.E1BB01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add a userptr address field so userspace can request a blob backed
> by an existing process mapping. A non-zero userptr selects that
> path; probe VIRTGPU_PARAM_USERPTR before using the field.
>=20
> GPU-readonly backing is requested with the virtio CREATE_BLOB wire
> flag VIRTIO_GPU_BLOB_FLAG_USE_READONLY (also
> VIRTGPU_BLOB_FLAG_USE_READONLY). The device MUST NOT write such a
> resource. The guest pins without FOLL_WRITE only when the device
> advertised VIRTIO_GPU_F_BLOB_READONLY (VIRTGPU_PARAM_BLOB_READONLY).
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918095940.2253=
018-1-honghuan@amd.com?part=3D2

