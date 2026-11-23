Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416182;
	b=o2ZORWq1ogbGLwFI9/iS9d2odEoMAb5VMJc7CWvcqrDpKDh2wMaEdYmAQIeAaZbz0szl
	 1rt9IKuSobacYfQfeeuukhQrRyNYZfc+jouhBwKLHFfpdDSSWRHEcqaGv7Qigz1bL9+sn
	 HwHKRZ1RHuvbXhSCn+RY9sGlxRjted87O3HkuwrigvduaYKli9qQJfuxr8lepNMFD+xlp
	 VEmZjZcV5AQpsQ+hdAAfMeUmKNni55o2+wmOJo7w1wOobT1VbladmbE1uw3Zg02MVhtNa
	 WVLnq68hcwyt5WH2ut6JaLspXzsho3fZvPggb0N5Q2L9saFEbevMqjVItbjP5o1lFLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416182;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/JHD3sfJKMSRlIckrZpAwBP9cQ+RX1R1Rfl+YF8bLVM=;
	b=EMwZiACW5jjHn9dnVA0IHvR2SvZgLnEeH9QO06I1IcC/mVDoLnCk0RAbCCqqaJQ+uk4W
	 AFUleaagAEQHY4RxhWTDbq4m7NSDJWBv0qz+vDXyRYcISPdWdlNNUmTHe35TnV5LKoZja
	 6vty3pLbgqjYk5x7upVtXPb0ZeboqexF77aE10JmfJXRYvYH8MKXdwKWaotvW8T3IH2a0
	 XAeUBnWHKbUYgHIGlr8elOygl2fe5aHnoQ0yFPy3CsPnp8hIKjTfDAybmaYuSfYCnYBvD
	 TwEvyJMHj6/uWnLPLesX+4hqA9lswaRkzpXlg1oi+vOMCQfokQdsM0oqHpMuJ96N/sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNEaFgmD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794C606A31A
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNEaFgmD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9261F000D1;
	Mon, 23 Nov 2026 06:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795416181;
	bh=/JHD3sfJKMSRlIckrZpAwBP9cQ+RX1R1Rfl+YF8bLVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QNEaFgmD9oMGpefKgx2lh3T2XwWJVcDYa/qBCV4gqTvpGX51fHVyD7d5GYdCiLhid
	 ClNP/hKL8na4VjdA6/0QKKuWx4YgmhDx7A8ePgy9jNhM9KwNK8G6fpfatDLW7WkteE
	 nqib45m+fLCNI+LW//XMAiZCATVpfPrarOQMRMjV9dtc8j3E6+mdNHtFD5VpQf93/m
	 uZguGbnfSQEPKCU28GzoS9/49SeLtVHrpfSj1LQBm3+Sj7ObGgyZ9FFU3sVGIV+RFv
	 C6wcOJBqF/cj1X2Nliy/jPIc95ybhPbazaxvsKSjXUN+cjMUGOjKJNsvTJbkiNDX3I
	 BQO/DW3R+5ALg==
Message-ID: <sashiko-outbox-228776@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] fuse: virtio-fs: fix lost wakeup on a full virtqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: Qihang <q.h.hack.winter@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261123063609.82014-1-q.h.hack.winter@gmail.com>
References: <6c6cea56-1af2-4a37-b081-83244d5e09cd@kylinos.cn>
 <20261123063609.82014-1-q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 06:43:01 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtio_fs_enqueue_req() drops fsvq->lock when virtqueue_add_sgs() fails
> with -ENOSPC, and the caller requeues the request in a second critical
> section.  Completion processing can run in between: it reaps a
> completion, finds queued_reqs empty, and does not schedule dispatch.  If
> the queue then goes idle, the request can remain on queued_reqs and keep
> in_flight above zero.  A subsequent virtio_fs_drain_queue() can wait
> indefinitely.
>=20
> On -ENOSPC, add the request to queued_reqs before releasing fsvq->lock,
> as send_forget_request() does.  This prevents
> virtio_fs_requests_done_work() from checking queued_reqs between the
> failed submission and the insertion.  Both callers can then return
> immediately on -ENOSPC.
>=20
> Free req->argbuf before adding the request to queued_reqs.  Once
> fsvq->lock is released, the dispatch worker may already have taken the
> request, so the -ENOSPC return path must skip any further access to req.
>=20
> Count the request in in_flight on its first submission.  A retry keeps
> the existing count.
>=20
> Fixes: 106e4df1206b ("virtio-fs: improved request latencies when Virtio q=
ueue is full")
> Cc: stable@vger.kernel.org # 6.11+
> Link: https://lore.kernel.org/all/sashiko-outbox-204365@kernel.org/
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123063609.8201=
4-1-q.h.hack.winter@gmail.com?part=3D1
