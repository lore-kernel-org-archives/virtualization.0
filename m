Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF3494839;
	Sat, 10 Oct 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643162; cv=none; b=CxT/xNFvieiyiDhpFwJvvPyB8bQKr6aixAOByPDvD0iOeUGx8+mGQ1kz+ITjlALMdUpXk4nzYzycZTqkbxbj+c2BW1QdCEJkS+4jtcH2Hv99uoe2+e1Du+XfttwLfaPRG1pBTxD7681frxWiFQGdNRWJ3KuAYFEwuj1RM6zjQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643162; c=relaxed/simple;
	bh=cj7EeLNB4lbuK9SplFUF1u7CWMe2Zksnn0wBMcilLXc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mrgzAHakdHRCApQ5raQKTizE6XpR6Cvesc+2Bym/qF9QbFt7HqeqhPGcbqrhXAI/PKXoR7j4Ip5Yp3U5H0BNh7MCSdyOVoRYmIEu3K4FBioOBpyl3X+jqQAuOF2qElmnla2BWl2wiwMl77Jc3H7AqflRjkOfX8rgrMWwZaqWkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbMgnK8e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbMgnK8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD251F000FF;
	Sat, 10 Oct 2026 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791643161;
	bh=cj7EeLNB4lbuK9SplFUF1u7CWMe2Zksnn0wBMcilLXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bbMgnK8e925OEUKp147JUdA2XOmFmL83DQT+KENcxznvUybDphLgntlC0zPzqLHYW
	 yAfzJjQ+i/pJQkNr4pKTcUCRqEqBXdJ0PKwgsqL5QGLAHnGlmbrp3k/6qP4meupL0/
	 Fv4wCnsNisdpTlUwbpUz5brcu1k8jZCRrSwUKZPcNTV7yBqdlg5zC0+FSuNRRBkAqI
	 mDVRvGe8FHuhkSVoRlrqXZyA8lXZzpLwlKh2CqX4A/DyBQEVRT0F9FhluZBp/pvGa2
	 /rnPhsH99mUW4Ku41IqwVhqb5bou+txBiVLidoAxmqb2/2TGozX9D9ZRs6Tx23MSk8
	 2/aSZKPtDhwyg==
Message-ID: <sashiko-outbox-166650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org, bpf@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261010142247.99223-2-physicalmtea@gmail.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 14:39:20 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Split virtio_transport_recv_pkt() so socket lookup is separate from the
> receive state machine that runs under the socket lock.
>=20
> Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> Pass the source and destination addresses used for lookup to the locked
> receive path so they are decoded only once.
>=20
> Pass the network namespace and decoded address tuple through a packet
> context to the locked receive path.
>=20
> Preserve source validation and failure handling. Keep the lookup reference
> separate from the skb owner reference so the locked receive path can mana=
ge
> the two lifetimes independently.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010142247.9922=
3-1-physicalmtea@gmail.com?part=3D1

