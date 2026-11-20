Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176207;
	b=aJ839gvPqNYldiZhlyKzn+vbbD1gk5xeqRK/s+I1TfXv7btXPgZEwHBYluuy97A6mNK8
	 /uE46ogOHnOAwBxPeVemC0ZeYXlm84aHd7d6HxVwTEO/KHFpCtLUtPcAk56itRf+mMJJA
	 3WL3Reg/9yGykVKNzIIHpzAcKAyRElJ4str3CaqvdjOvW5+cr2KW9T5NDw5kkXzurTWqb
	 2GjfkCzUDDUhtBU2Z4x+6tK0fIcTTxAER1Y+KgF3PGofvDkctKu0WQJvt1ft+dxVC99zE
	 E4GfsRUhEDgY7qu2ZgiBDeqq/ryTNCxxDXn8p0GMCaJ1R2hPF8P+/NP/Pblen8D03kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176207;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eGV9Euy8NAuiIlpeYy2eLuz9TKYtc048/55XHVFNQzI=;
	b=twFyfLYLLIn5vsym8ddI49/qW2E01GKyxui1AFksDbIDcfyyNOWEhMEGoMCpBA4T9twy
	 t0MIvcVKH0WmdeMuwz4P6JpylWkrtTuC628t6P1DOtiX18uUPTA5Ld9JrVc3rDkwsVS9f
	 8Mi3Bucyl1dzunEq2h3WLAajRF+sfRzIKA1tXSQUpQ9qZJXAU4XrW7APLnSsiRB5e7Vbs
	 1eGUh7PNxZlN5XZ9mMRtc8g79A4mkqNUkG9nIUVB+P4oWXIIKvlK25jcArCwPWfGzaqkH
	 ERsmVfGLn478dIJ0gN0GZnO/dQjutT8R3JVdGgteKir5F/AjK00xHPwtxbijHVkggUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5CUoPg1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2299606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5CUoPg1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559071F000C6;
	Fri, 20 Nov 2026 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176206;
	bh=eGV9Euy8NAuiIlpeYy2eLuz9TKYtc048/55XHVFNQzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i5CUoPg1r5NyBN3Qj3xQDdi9XtnvTfg/4F1M+j6K9wT3N5BzfNp2xXAN27xtyKk84
	 TB1Ol7yd6h5mM75PPp9EqiOOFKTomyi0cWd62wkH3PXaiq+mdw8FtshuFuzQDiWigI
	 /eoWx8MtwbP+tDT+PQaHu5cD7sjUeLjH2TxMotLhchUTX9HhFciWeb0/rBnfHFa3mF
	 tan+4FKk8NfmkPV0Bq7mPodzUn5LQGtG6QDRY7UxIbNavZ5y10/YQeZaQ+dn9bcTic
	 fgDZ+2/SaL8lLfkaHNQvgOYWLNT3/DdvijTxdRL3McGIcgc+39rYG3cFtQfyuM65ys
	 rUDWrUlv6yWxQ==
Message-ID: <sashiko-outbox-225112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/7] mm: skip zeroing in vma_alloc_anon_folio_pmd
 for pre-zeroed pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <37575b5efa8e04527f390eafada7fda928744130.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
 <37575b5efa8e04527f390eafada7fda928744130.1795089715.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:03:25 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Initialize newly allocated anonymous PMD folios through folio_init_user(),
> to skip initialization of PG_zeroed pages.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795089715.gi=
t.mst@redhat.com?part=3D3

