Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305F480336
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157786; cv=none; b=pPdkrHl6R99G9utYuv58kziqEzzDVWJuFnFQVGRTrzbMPZLm9B2lTMYxRouv72wl3LfQd/hHnJa/Nu+OyiJW8enPN0RSKyxgE9yWsnkCl8Qj3SeUB1J2can/AL/LdRnHAxtPznXxgXU1yDdvgC3zJbI7G3coy/+d9o7tayaVm18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157786; c=relaxed/simple;
	bh=VBWQpnvc14wY79YI9sRBtamxhet+SBfBXTxpOMVJVqg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MdFsLoUTZqsRM14PHD6eFcejaKjsFlIPkq24A4kOgU9maeUvmNNpvtly45nBS0aPeEeaMQoGlPu/eHGRw2uSiNJrdZwIWGYnx3QTIXiQAIeahiwf3kj6J5LtirF1jzKnUNznxPkpHr7UflOxdLIwb0EodLhJYADCG1hmgF28n2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO9U/dfQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO9U/dfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4517C1F000C5;
	Fri, 16 Oct 2026 13:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792157785;
	bh=VBWQpnvc14wY79YI9sRBtamxhet+SBfBXTxpOMVJVqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BO9U/dfQtk3Kd+ZzTIPtY3xnxeF1g7qdqKlChFKyms70X6Rq/+LDyLyvKVWUuAWwh
	 SXGEGKHfHzV2iDMtKXsJ+jCQrQtyqP49rfITr2OWVWErJMd3BRAhUienzOjFXfuHJ8
	 THE8bEkIYIA31/y43q7amgF7fyg2fqeEKqlA7TYGZBlrVlHJeywIV+X76IXISap3b3
	 A5eei43DOLq8l3AxE5wGmoTGHHE15iXQ8sQ+zKO4pgsgqQjzO5a8cSGWQrdAePASUA
	 fO5HQwHo01mcbe7ftezvjBSdlzlk/s4BQIueUJC6zgEpvi5qfgKWF8TN/MfwMRf40t
	 cQPEofsZ+FfBw==
Message-ID: <sashiko-outbox-174385@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/3] vsock: move SOL_SOCKET options to
 vsock_sol_socket_setsockopt()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261016132716.272018-2-devnexen@gmail.com>
References: <20261016132716.272018-1-devnexen@gmail.com>
 <20261016132716.272018-2-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 13:36:24 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> SO_ZEROCOPY is handled inline in vsock_connectible_setsockopt(). Move it
> to a helper with a switch on optname, so other SOL_SOCKET options can be
> added as new cases. The value parsing goes to its own helper too, so each
> option can do its own checks before it.
>=20
> No functional change.
>=20
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016132716.2720=
18-1-devnexen@gmail.com?part=3D1

