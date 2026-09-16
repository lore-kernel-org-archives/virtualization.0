Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5549EC43;
	Wed, 16 Sep 2026 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564563; cv=none; b=s4aLQDL4jhO4wY3kiDx1jpe27zmPvbcAStcYtN3xSxz6i7+lm9XSxHvUiBXbc4rKtu6hmyjpwyhhOhLIq464avqIb44BkkfZNnVLkW5MR6ONPSNsR9wnHWcUKUdhwpnYdCobsHOTJuEP4IKQ6Qy5nS0KegG7pfuFX0XlKyqZwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564563; c=relaxed/simple;
	bh=bAtCDD/mwsW4CyUsSWE1ScFTfRzyijjwx/6X4yhWOqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RLyYcBYUrDEIiIJS7PzBI0KUb4Kl60DPhG3On8AaRNOqR9tso97wQdM2Jgncr/tkUU3OBYM++T/bil+yKj/0vO1Ntuk9wDxsviYuLYdSITIiwpdlZB/9CPJAQlQTWiEQ5xP7KBF643CB3B5DPF3/E6bDAkEwYG+GWuHAsfBQSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUQtMHO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUQtMHO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD25A1F00898;
	Wed, 16 Sep 2026 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789564562;
	bh=vfa7vr64XtHcDOiw8sG0Aev6/zHCvqj4/4FyHyiXGNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kUQtMHO/wOkY8Opb8uZ2HZYbXoRpXXoAU7tpsa61n3C8vhdZrw1kfTIdLAmJzvioe
	 l5fGad4CNoYsbtDTY3oNSBTATDfSLCDxelm+fpoatZzS1Pfzb0JLLaYL+Qh+E+yihe
	 MDRmeI40RHTSCUT6ZxbCCj9zfEqoG6m0AcINw7PqrXcjUKc3hd42o0+FwM2JgUi2Dk
	 pLePQ1dNkNxGQdaOEwrn2Q6R9S+zqRlTEEGJN/V7GSV2nxoL50EMnCYIbfDIq7II8O
	 GdjgyLN1DxTfedd97VMfG1b7HEPRa+gees+K21JtOSczUogCzZ/BjPrhIrI126Ms2Y
	 rHr6I54hbL3zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 5/5] vsock: Handle sudden TCP_CLOSE during
 connect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-5-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-5-a1d9abb472f7@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 13:16:01 +0000
Message-Id: <20260916131601.AD25A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Virtio/PM events are serviced by virtio_vsock_reset_sock(), which resets
> each connected socket. The reset is done under vsock_table_lock but witho=
ut
> taking lock_sock(), so from the point of view of vsock_connect() -
> locklessly. The same pattern exists in VMCI's
> vmci_transport_handle_detach() and vhost's vhost_vsock_reset_orphans().
>=20
> The complexity of connect() comes from the fact that:
> 1. the virtio transport can be reassigned, so the old transport must be
>    safely released;
> 2. a failed connect can be followed by a retry, so the socket must be
>    reverted to a sensible state.
> Both cases apply only as long as the socket has not yet established a
> connection.
>=20
> While connect() waits for TCP_SYN_SENT -> TCP_ESTABLISHED, other
> transitions can also occur:
>=20
>   TCP_SYN_SENT -> TCP_CLOSE on connection failure, timeout or signal
>   TCP_SYN_SENT -> TCP_ESTABLISHED -> TCP_CLOSING on VIRTIO_VSOCK_OP_RST
>   TCP_SYN_SENT -> TCP_ESTABLISHED -> [TCP_CLOSING ->] TCP_CLOSE on event
>=20
> This further complicates connect(). Rather than making every event handler
> drop the socket from connected_table or adapting connect() to handle more
> transitions (while missing proper locking), use vsk->peer_shutdown as a
> poison flag. Whatever state an event leaves the socket in, the flag bricks
> it and prevents suspicious transport reassignments or TCP_SYN_SENT
> retransmissions.
>=20
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-vsock-conn=
ect-reset-closing-v2-0-a1d9abb472f7@rbox.co?part=3D5

