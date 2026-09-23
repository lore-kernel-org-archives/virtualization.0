Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82F8635D;
	Wed, 23 Sep 2026 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126321; cv=none; b=cM7EpNzCIZE9EIcuWWRUOXpgzjffR/HbbB0vl9oLGBq0jczuoD78R676jkhZ+mBxiHVVeSdpFBH6zpsiTTvVfqvXkAGoBpqcfd2lfXEfo32PIWoU1/tS6Z97klwfyinZbgOaT0IAvZNPw3IPOnGzDBQl2WOxnz6T1Guoent/3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126321; c=relaxed/simple;
	bh=JkfNOugQqpUgSLTyR/cXfk7+S1E1KMJ9mf8/T8MOHEk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ESs3h46O2bx6rV5hY/sWYrKbZzuV6qsJN3fnyKZS4+PKdazxKtkmshe4zURFPzNGttlKtBiAuUpvv8X5ARzWkZ5KXB9EIbl1qchHo6dzTzTQCNxaLpqe834oZr6cuIAgb/Tn/eNOFovgFgxXw4o8EfynnMb76lA0+CVR89FQWgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6FamZUG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6FamZUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8A81F000FF;
	Wed, 23 Sep 2026 01:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126320;
	bh=JkfNOugQqpUgSLTyR/cXfk7+S1E1KMJ9mf8/T8MOHEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y6FamZUGXQPv5AKE6JVKqK85hOpgXFsxMKS2lxT0wqzDZdyokf7lmnYVjR9VDI3Js
	 G39sg08Yq7ouemw3xRPVyixV/CAojXZNsR5iK6EZX92ShA5ihWrEgI3gJCUJw1pvhC
	 j3R9hpXqo9DKAc2jXb8QAAQHVtZkiO20+x33GiDsBatH8L841jXikYUhJB2yYomqwM
	 r3dEfVsX6j61fIGaQxH/pNqw02CHvjzUtbS59t5ikHmNufK3AojanrO/7esS/ftxIl
	 VnkaZyz+DUCYmtJipEYEUjNCnHkPfoNMxVYYaDCdCFmmtFYGhInAY5sK8IwCEvD5Wj
	 5DL2zCfbzx4jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/6] vsock: constify the transport in
 vsock_for_each_connected_socket()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: kvm@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260921-vsock-guest-ns-v2-1-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
 <20260921-vsock-guest-ns-v2-1-693bd78fde9e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:18:39 +0000
Message-Id: <20260923011840.1F8A81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Bobby Eshleman <bobbyeshleman@meta.com>
>=20
> Allow const transports to be passed too. The function only compares the
> pointer against vsk->transport, which is itself const, and never writes
> through it.
>=20
> No functional change.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vsock-gues=
t-ns-v2-0-693bd78fde9e@meta.com?part=3D1

