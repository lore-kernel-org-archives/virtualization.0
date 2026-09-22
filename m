Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F65505F6;
	Tue, 22 Sep 2026 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084628; cv=none; b=WG8f/t64LXJROX0k3wjVeql8AmgAVeter1uUpuwGhDzmh+rw0bu38cXiKR8KwpHPw+Qee8IefM2CJb0iiwORtJjqPaQf2JGB1keag6Y/Z5GTWbNbTze2DLxbgI/9iXdWuuix8QL1icITRYdvxFWZK/1J2HSvCs+HwheDP7F4cz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084628; c=relaxed/simple;
	bh=ovVnefA02WkoJ658KVzJ3jVZ7Mbf7IPhNzlKxgzPjd4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GicnIF13nDBHXud+LUyPdmnSRiFDODn7C6yGERezFcb44kJ0PPSPs/Rql0W5MV2uH8IDfeLpdELMkH/cbz64Rq/KmgaifEeH75ffD50qL9TWxMgJfwxftl7eLZ/vzLQfTb79R4gqB/SjMwA36TL711fj3uffZAcGmCC1nWt0KOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFkoYbWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFkoYbWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ECA1F00893;
	Tue, 22 Sep 2026 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084626;
	bh=ovVnefA02WkoJ658KVzJ3jVZ7Mbf7IPhNzlKxgzPjd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jFkoYbWjY9F1rni2wRbuelGiUAvksSZ+XvCXsPftsoZ/JglQTstaoKfGhNCEEKqCM
	 QHK1I80nJw0EvIMblJjchJWj4P53dG9iJ1/m44NYRBqYsKesXpEJKJcIvTF/0zBXXj
	 63QBamNHA0F74gSsQC4fgqUwwjIv/A7eqGykDgajdjSpRfSwiv/9TBy65aUx5mv81o
	 CIgF71pFXkLLBt4G7civNxa4VjFptIM5phXAMdu0NmXdk5CZtL6Rv6A6eEMXC3pg3Q
	 dNsIFmrh6YI4XE5ABNQJyKmXSAtCcyHHc99BOyuKEZg/sLqqgK27oxAfi1/Yad1j/j
	 mT9NacuQgb62g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 8/8] vsock: enforce no-transport invariant for
 TCP_LISTEN sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-8-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
 <20260922-vsock-connect-reset-closing-v3-8-78907b8200d4@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:43:46 +0000
Message-Id: <20260922134346.50ECA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> In the past, listener socket could carry an assigned transport (uselessly,
> but harmlessly, except for unnecessarily hogging the kernel module refcnt=
).
> That's not the case anymore. Express/enforce the invariant.
>=20
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-vsock-conn=
ect-reset-closing-v3-0-78907b8200d4@rbox.co?part=3D8

