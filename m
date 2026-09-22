Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A7541453;
	Tue, 22 Sep 2026 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080743; cv=none; b=UoMqdtW+Tk4R8ijY0ecgHQ4XQdJckbCNzSMMP3mh2pYWoaCdgY+H0WgccYJS2u2TAi6a+EM9/l7C1aISv24jNPw6l+sqFeYJ7kIZVDkZs9XHsQzzgbRRDAMrnlSOoh9xM+8FkHEZVqmeBwT3/1XauQwmtoEQpvz+DF/bqMfhd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080743; c=relaxed/simple;
	bh=VEjE6b8h4E4HlfCS0e032OTd998pQ/SYzqyPGOuFZpM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ejfJOI9p/myWDSj93/FepbaX2u6Q4y3myOcaNIi3lgnn+tS0v+jC6NDexzjBdFPzTPFT6AD3xOaFnSz11A/owwoUKbRx1lLUTk9ZEe8AREk2RNT4YfsMKdV+h3PrZHLLC9x/qYY12fIST2QAX5s9j/P9d9uL8uTdPEc8GHBKgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzN18SW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzN18SW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774D71F00893;
	Tue, 22 Sep 2026 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080741;
	bh=VEjE6b8h4E4HlfCS0e032OTd998pQ/SYzqyPGOuFZpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TzN18SW83ljTbCDlk8edySNXc0oZYu3cDWFny5D7k2rVKalTa2fE/eAtqnCH1zbp3
	 nHmct9dle8GGGlZ8/9giliENIDXy2IjGyBiwN31PfqUmRG3CPv8trF00lJ4hNvrczr
	 wrDw26EGTZEGtCpJyPY9vUjKm1VX3cThPqWFhXsWFYXrYEZHxmKoAkKPHH+ire5dYo
	 OtjovunoXj4qpO6Jbd0yXfZyRpdxHdqFgdj1vt6qPr3pvYEcopqGBX923a1NT/woPU
	 2aunjTGzSSnF+uG1L3R3tdxS4tz8F5EuHkXtcVF4pb+zychd0ubKwNYuPdyvcvXT6X
	 akNUA2/EKFt2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] vringh: add regression test for cyclic indirect
 descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260922122955.69433-3-fangxy@xiaopeng.com>
References: <20260922122955.69433-1-fangxy@xiaopeng.com>
 <20260922122955.69433-3-fangxy@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:39:01 +0000
Message-Id: <20260922123901.774D71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add a case to tools/virtio/vringh_test.c that builds a top-level
> indirect descriptor whose NEXT points back at itself and checks that
> vringh_getdesc_user() rejects it with -ELOOP.
>=20
> Without the preceding fix, the walk re-enters the same top-level
> descriptor without making forward progress: count stays flat, so the
> traversal limit is never reached and -ELOOP is never returned. With the
> fix, the top-level count advances on each re-entry and
> vringh_getdesc_user() returns -ELOOP once the traversal limit is reached.
>=20
> Use index 1 rather than 0 for the self-cycle, since returning from an
> indirect table is only performed for a positive up_next value. A
> self-cycle at index 0 would instead terminate the walk and would not
> reproduce the bug.
>=20
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922122955.6943=
3-1-fangxy@xiaopeng.com?part=3D2

