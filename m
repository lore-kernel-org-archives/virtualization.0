Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053703D88F6;
	Thu, 15 Oct 2026 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051010; cv=none; b=iOOt6JcLRDASt28u3XrMA6+ub5/19kZ1WclJbUz7gZ43oD/UCZUl7FUs8iNqmhrE0wb41LXEZw7W8amNWLuxITf8L5wPgMxqBnNVoDM0T2NGC/RdjoqqNr9c8gXEw5911ivQ7NH9qnRQQET/fYTx4FCdLOUH4I8ZRaIKBkmu2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051010; c=relaxed/simple;
	bh=Wyg17WNlQE6joAcGlgj7Y1rX80Gx8nlvbkQUnvJXI7o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SJ3g2zvYkJDksfqsG5KN+2qMfHvzEWcg/ovOftHiGP25JR+D7yQbYUjZMuddwCGrB6+kiUNI9pHJ6KvmwdAUY2+mXg84oIgQtHCIiL6crXFAiY2qU4ya/H8uEMTC9uyoT+W4vvP+d6Cry1ArEUZxXqkKGmAYxf7U6XczeEoMz0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL6Nko0o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL6Nko0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5D61F000C5;
	Thu, 15 Oct 2026 07:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792051008;
	bh=6vMCrrpixPqM1N2cFgOpKi14AhtedTWIOBF40enE8GI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CL6Nko0oB/6QP1dfKEwV8coOKK0iDF/u/C2tzMijfOYpCKn4NnBlMov8PMxh+Fb4P
	 OICssyqja4xpRD2RoJxqwiEZj3qQ3R3myHuyTNCThsYG0wupe0MjL3DBguLBZsclGb
	 EVZwtY50lDcNfm9RdmulIpKYrGFD47QElbRAzeG3eWUxrG7ucNypECHOue7LSL1HLz
	 QuwXzGibCGZSRD/FFkSqzJuZTmXtXbbNHaHECB7mAfuZsQ72tRtM8ShxthOk9MgmuI
	 Xro4870Dq/m0bhjOZs5aRICmUOhFXghk8O7qPiYmpxtSoNKDxYCYmbhhaDKu4xj7Eo
	 Amiq5ASQkCBSw==
Message-ID: <sashiko-outbox-172439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH nf v8 1/3] netfilter: nf_dup: preserve guard across
 NFQUEUE reinjection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, virtualization@lists.linux.dev, intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <1eca65f844ea4eaefa9ea4a852f1db27aacc10b9.1792048855.git.zihanx@nebusec.ai>
References: <cover.1792048855.git.zihanx@nebusec.ai>
 <1eca65f844ea4eaefa9ea4a852f1db27aacc10b9.1792048855.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 07:56:47 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] netfilter: nf_queue synchronous bypass triggers false DEBUG_NET_WA=
RN_ONCE
--

commit 6ab1ebe7cd71aef0c99fc87d28ca2657ffc20779
Author: Zihan Xi <zihanx@nebusec.ai>

netfilter: nf_dup: preserve guard across NFQUEUE reinjection
   =20
This commit saves the task-local in_nf_duplicate guard into struct
nf_queue_entry when queuing a packet and restores it during reinjection. It
also adds a warning in nf_reinject() to ensure it is not called with the
guard already set.

> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_qu=
eue.c
> index 477fc632657f4..1ec9c1fbae843 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
[ ... ]
> @@ -369,17 +370,24 @@ static void nf_reinject(struct nf_queue_entry *entr=
y, unsigned int verdict)
>  	unsigned int i;
>  	int err;
>  	u8 pf;
> +	bool old_in_nf_duplicate;
> +
> +	DEBUG_NET_WARN_ONCE(current->in_nf_duplicate,
> +			    "%s called with duplication guard set", __func__);

[Severity: High]
Does this warning falsely trigger when a packet is synchronously reinjected
during queue bypass?

When an NFQUEUE rule is configured with queue-bypass (fail-open), packets
are synchronously reinjected if the netlink queue is full. This synchronous
reinjection path (nfqnl_enqueue_packet() -> nfqnl_reinject() ->
nf_reinject()) executes in the same task context as the original hook
traversal.

If the packet was originally duplicated via xt_TEE or nft_dup,
current->in_nf_duplicate will already be true.

Because this can be triggered by remote traffic intentionally filling a
bypass-enabled queue with duplicated packets, could this introduce a remote=
ly
triggerable regression on systems with panic_on_warn enabled?

> +	local_bh_disable();
> +	old_in_nf_duplicate =3D current->in_nf_duplicate;
> =20
>  	net =3D entry->state.net;
>  	pf =3D entry->state.pf;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792048855.gi=
t.zihanx@nebusec.ai?part=3D1
