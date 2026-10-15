Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581553D0BB
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080143; cv=none; b=aFvVYre1R/bUVe+WELYgJKgEn2P5zSZRqy9Jsc6r+IKUGfU4D7XQZPdQotAjYrRQ4R9y2xUbsfWT00rDCOEEAA54o4OKYLOCVuCj1qNbsWGCzdYubLTAIskhoZU0vNcXON2lN6VIpcAC6I2P+801VxH0G/IpLq+6EqmSWZpFrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080143; c=relaxed/simple;
	bh=CJ8bXOjl3pBCOmo51eF5N37IW0GDJAhBlWPMRN0R1Q8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pcLkznqs+XL6zH66jjQcauRX10G30G6Ke8N7CRLNvaPgXIaQ0NucN9t7UG1nfqPmTxchHg25ZFZ4wjg+7g67pZvsCvDqYgRqCWXYj5ssay0niRXFJljm/OX1P/r/zbK5JkmGDm37y/P7vK52DWjnkPaflsLuc08gNTxf6F3r9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQFWe4mT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQFWe4mT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18FD1F000C4;
	Thu, 15 Oct 2026 16:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080131;
	bh=CJ8bXOjl3pBCOmo51eF5N37IW0GDJAhBlWPMRN0R1Q8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oQFWe4mT9Z+zK0xAhYZ8eoHydqJFbKhnGRzinPX2Of32miz/XqH8tvl0qNwBgSqBr
	 zklhqU/cIKtCjVG67zRmWNAgTGrFGpeqrnKEd9u6Rfrrv+m8Up8lSC+4ni10YWXFff
	 8NGUdk77KEB0B/pzQ+AquZS8H6x9U4Ru69KGh25e4wuV6JpwTd5k+tWKLN5myszKT0
	 gC/vHTof6nm9eLJsRk1VWS6oc1RQ3h4KqKZjkrM47wZkq+F8BZ4V6HRIGpmPVxb+nT
	 eI5Ubc8Rvn0dm98GsywJnzo3p61IXjY/+yAGMA5M8t+OAUPuPepsiEqzh6v2cfACzh
	 Xg5ASh1YUD/cQ==
Message-ID: <sashiko-outbox-173124@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/2] vsock/test: cover SO_INQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261015154334.3217358-3-devnexen@gmail.com>
References: <20261015154334.3217358-1-devnexen@gmail.com>
 <20261015154334.3217358-3-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:02:10 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Check the SCM_INQ value after a partial receive, after draining the
> queue and at EOF, that no cmsg is sent while the option is off, that
> accepted sockets inherit it from the listener, and that out of range
> values and SOCK_SEQPACKET are rejected.
>=20
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015154334.3217=
358-1-devnexen@gmail.com?part=3D2

