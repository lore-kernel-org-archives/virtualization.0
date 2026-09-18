Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E232B10F
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768962; cv=none; b=bXSLtXpEpsuiokPY4311OJw4qittfd3u3cM/YYhhqKtz0pNtudOJjcTLZpyCU6n9SyL3yoRkj3OYp1S/XiaJ0ebPnuXdy+mclhZ6/1I5tkVA5gClfq+GYfUK1NJ05CPHEWoyMUsTOW3uHbOuEzIW8kbiQZdEeS3AAjjKLwmf4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768962; c=relaxed/simple;
	bh=g1kcyfN/fG9LzkEapxWLnT10JzboaK56Ml+qrY40l64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I33pVFj9/DieRBjaYn7AtX5+sfRjjIBTUKFEOmD10amg2f2s1xucuQaq/0+Jaak/FbIUMNF5Z9CNhtbZsITZo2FrkGuAYvSAvzfE7VrpBS7nzM+Ae9mZ8SG43a5XhPveMRVwNzbzc5XDDf9znuD+rpTkaZZo17rS2bGGj1lk11M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z47cdPTF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z47cdPTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779461F000FF;
	Fri, 18 Sep 2026 22:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789768960;
	bh=HlsLd8O7sRcRNWfdrpwuWMCI0wvTMXoBPzlS/hYW9SQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z47cdPTFAuU3Qz6g+52+vFPiCYEZmfVCfvy1mR5bWS1/qSC92LplXEd4ETl0cK3eP
	 eXW215v5+eKbcjHfiFB5dvGLuRQUm0lRsrsmyzHvERwWpE37JKjWMiMJkAjEOp4S+Y
	 1EdKU0RaEvlPqDJuIL0vHKB0gmhs2SAQKBm2YH2+RL3/Y1u9/BoVfsAU1Mx42FVpii
	 Q4YcI3RIwTlnoHx+n6YyXgJI5CtMu+slCxuTWmwFXgJNiVGLrNVADdYaO8qLlzc+4A
	 3aXa08wXzQb2W+AL2cdGMoxvgTDLE3xWpITajpqGcTTCsUelEWonhv6xHmu5qG4O8n
	 gx9f014FJ5XVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vsock/vmci: harden datagram receive access check (netns
 bypass + cached_peer race)
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmFydMWCb21pZWogRG1pdHJ1aw==?= <bartlomiej.dmitruk@isec.pl>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>
References: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 22:02:40 +0000
Message-Id: <20260918220240.779461F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net/vsock: severe receive fast-path performance regression
--

commit d73a7bc02ed525e8162b0e1c12fa4585af2535c6
Author: Bart=C5=82omiej Dmitruk <bartlomiej.dmitruk@isec.pl>

vsock/vmci: harden datagram receive access check (netns bypass + cached_pee=
r race)

This patch fixes a namespace bypass by enforcing vsock_net_mode_global
on the receive path. It also removes the unsynchronized vsock->cached_peer
cache to avoid data races between the lockless receive tasklet and the send
path.

> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 1f186e8f83640..37b6f6eca962b 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -529,18 +529,25 @@ static bool vmci_transport_allow_dgram(struct vsock=
_sock *vsock, u32 peer_cid)
>  	if (VMADDR_CID_HYPERVISOR =3D=3D peer_cid)
>  		return true;

[Severity: Medium]
This is a pre-existing issue, but does this early return for the hypervisor
CID skip the newly added netns isolation check below?

A socket bound to a non-global netns could still receive datagrams from the
hypervisor while being blocked from sending to it, which would leave a
namespace isolation boundary partially bypassed.

> =20
> -	if (vsock->cached_peer !=3D peer_cid) {
> -		vsock->cached_peer =3D peer_cid;
> -		if (!vmci_transport_is_trusted(vsock, peer_cid) &&
> -		    (vmci_context_get_priv_flags(peer_cid) &
> -		     VMCI_PRIVILEGE_FLAG_RESTRICTED)) {
> -			vsock->cached_peer_allow_dgram =3D false;
> -		} else {
> -			vsock->cached_peer_allow_dgram =3D true;
> -		}
> -	}
> +	/* Enforce the per-netns mode on the receive path, symmetrically with
> +	 * the send hook vmci_transport_dgram_allow(): a socket in a non-global
> +	 * (local) netns must not receive datagrams it could never send.
> +	 */
> +	if (!vsock_net_mode_global(vsock))
> +		return false;
> =20
> -	return vsock->cached_peer_allow_dgram;
> +	/* Evaluate on every datagram instead of caching the decision in
> +	 * vsock->cached_peer{,_allow_dgram}: those fields were an
> +	 * unsynchronized check-then-set shared between the lockless receive
> +	 * tasklet and the lock_sock() send path, which could return a stale
> +	 * 'allow' for a restricted peer.
> +	 */
> +	if (!vmci_transport_is_trusted(vsock, peer_cid) &&
> +	    (vmci_context_get_priv_flags(peer_cid) &
> +	     VMCI_PRIVILEGE_FLAG_RESTRICTED))

[Severity: High]
Does evaluating this unconditionally for every incoming datagram cause a se=
vere
receive fast-path performance regression?

Both vmci_transport_is_trusted and vmci_context_get_priv_flags call
vmci_ctx_get, which executes a linear scan of the global ctx_list under
rcu_read_lock:

drivers/misc/vmw_vmci/vmci_context.c:vmci_ctx_get() {
    ...
    rcu_read_lock();
    list_for_each_entry_rcu(c, &ctx_list.head, list_item) {
    ...
}

Executing two O(N) list traversals per datagram in the bottom-half (tasklet)
receive path could cause high CPU overhead, increase latency, and risk soft
lockups under high packet rates, replacing what was previously an O(1) cache
check.

> +		return false;
> +
> +	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917220225.5620=
0-1-bartlomiej.dmitruk@isec.pl?part=3D1
