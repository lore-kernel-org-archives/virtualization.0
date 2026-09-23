Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5696133B6E8;
	Wed, 23 Sep 2026 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126323; cv=none; b=Hdr5XI7ejb1+qsmNVYjNDmEO7Ct5B0i9Ugtc0nsrUvLxstkCZqlkeDwLlBvGtd0J/WQtuxswzAg2Zu9McUu7iqOHG5pGikz3XostcvPCeTlYEM7QIOJ69KZuBz0RGn5kpVbrg1kgRS6jjpTMBz7hCRVUBTGhX3gVz7wfl/1llIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126323; c=relaxed/simple;
	bh=Nn9KzeVnOxFnHibMEgKzsJuC9/dQr9fB/Oav78R9TnQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LJ1sa99qoxyyNIMcrI/u+M55kaHv2Xq1oRDl/imCwqpQGgOUDzPkCpOZ+uBLRp0Xc9by1lbVIeew6VMt1IQQNOvT5wOb/zYxSyT6ihdMsFZBu4SVS4EqzI0gmC/dP31incw+o5xsluyzvbYyaoEXXgBjN9RhlIjJUYep+/AYhoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQYosCsf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQYosCsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0741F00898;
	Wed, 23 Sep 2026 01:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126322;
	bh=1PK3G1KnZvsoW1B5GsbYd75XVhxEAS1swYn7dvM3jno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BQYosCsfpPBSXb8PjEZQI7KyCNXoCnK+k/h0rZsF61n/4GWjJhR8NbvoFIHJ514Zx
	 TYmjnaDMIMViJp6mjkqpxtxNFNRN8SDeOg5MkC2vruWBADB4una4VV6JJKhJGWaOji
	 2rvHRkyWyX3Gz8ydBlTWqSMEsqnJ2gUqWN9CSVJmaxEygzk+hJpetAJ0cb2RusbJld
	 5NUXZAYlPNVVeeQDKF3VFAh3fmM3UWu060bgdXWtpq08loF/YT1yiLhiCM3AgQK+uf
	 XvUdmQ4l3bhvnHSNY0qLa08gh/YPzZGpuYfhF3zrXAR8AI2ybV6RJANNIHg3zIeUhJ
	 yV3+YEezplyZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 3/6] vsock: add a netlink command to assign
 the g2h device to a netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260921-vsock-guest-ns-v2-3-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
 <20260921-vsock-guest-ns-v2-3-693bd78fde9e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:18:41 +0000
Message-Id: <20260923011841.BA0741F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vsock: unprotected socket state modification in vsock_g2h_reset_un=
reachable()
--

commit 22f9613466fe3520fb04ad3d32779638f9afe30e
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock: add a netlink command to assign the g2h device to a netns

This commit introduces a vsock generic netlink family and a command to
assign the guest-to-host (g2h) device to a specific network namespace.
It aims to allow isolation of a guest's vsock traffic to a namespace by
requiring CAP_NET_ADMIN in the initial user namespace. Connections made
before the move from an unreachable namespace are reset.

Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
[ ... ]
> +static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
> +{
> +	struct vsock_sock *vsk, *tmp;
> +	LIST_HEAD(reset_list);
> +	struct sock *sk;
> +	int i;
> +
> +	/* The calling context must hold vsock_register_mutex, which serializes
> +	 * concurrent netns assignments' use of vsk->pending_reset.
> +	 */
> +	lockdep_assert_held(&vsock_register_mutex);
> +
> +	spin_lock_bh(&vsock_table_lock);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vsock_connected_table); i++) {
> +		list_for_each_entry(vsk, &vsock_connected_table[i],
> +				    connected_table) {
> +			sk =3D sk_vsock(vsk);
> +
> +			if (vsk->transport !=3D t ||
> +			    sk->sk_state =3D=3D TCP_CLOSE ||
> +			    vsock_g2h_reachable_sk(vsk))
> +				continue;
> +
> +			sk->sk_state =3D TCP_CLOSE;
> +			sk->sk_err =3D ECONNRESET;
> +			sk_error_report(sk);

[Severity: High]
Does this code modify the socket state and error locklessly?

Modifying sk->sk_state and sk->sk_err without holding the socket lock
(lock_sock()) can introduce data races and TOCTOU vulnerabilities. Concurre=
nt
operations such as sendmsg() or recvmsg() that hold lock_sock() expect the
socket state to remain stable.

If the state is unexpectedly changed to TCP_CLOSE underneath them, it can l=
ead
to inconsistent state transitions or invalid packets being queued to the
transport. A privileged user with CAP_NET_ADMIN in the initial user namespa=
ce
could trigger this via the VSOCK_CMD_DEV_NETNS_SET netlink command.

Could we acquire lock_sock() for the socket before updating these fields?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vsock-gues=
t-ns-v2-0-693bd78fde9e@meta.com?part=3D3
