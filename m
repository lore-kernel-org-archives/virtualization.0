Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4E3B71B1
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907561; cv=none; b=PmorS6XALNYp4oJ5ImISH8WZ0geS5LeMfe5SC2hzj1MCTb9zppW0QHrHCJNUcT/vubFBF+BaAx5doFk4Dsr9UcmPlgshrPyMKMfaE+cuSTmhVFS9wXHSNtnDmOV984NG+4jbBN6XngYpFHgtshg0WOFd5gPW2M8lTjbK6pQ2oWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907561; c=relaxed/simple;
	bh=mMJp3I3WjyYRnTe0NmhwpaO5FETyEiAWEOprGpM7DKo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LSyRrUolysFkFhI9oToYaIUdr1ezXpysE4vFu7gJocYhjdQxmOsVTDkBmvg5WAwT/sIx8hptqZqyHBid61oFF9Sq9N9wgz9Xddb5QuK1K0IO7r4CyT6efEkMtYQkmZrqLJ55KjUbyiUF/36JBBHvYiBcv0j1Z9XEfma48lecCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+MOnguk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+MOnguk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF601F00898;
	Sun, 20 Sep 2026 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789907543;
	bh=F80wczGCl0OVKAKKMWuCEa2f/h4S/W0T0Vw9jcICzKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N+MOngukP1L9XwQ18yIE4nJ1GnoXl27Kmow90Fj4DAy+Q4i2uWwcYnNyvFzRiI4gp
	 ZNDhciXuRxxnaSyrsmw7hsbyHKnDXWmIJSa4zQFedg5Z3h5DYbe++4cDoYeQpjfDdt
	 /bHl0bAPcKFZY8TRYAX+pzE+1zCLKI2Tc/EONoBId6nP52mNvvzrmTySuvkmnou3z/
	 9Qz9UPtJqNiS04fgp2zkiJENya6uABkgJIO+icCql68u0J1fBHl8byu9af5GkVUP/u
	 Cxm+BGlCf604JLIN+dNkxkkPcMHr02OZ2lGOkvT+Z2Moh8/R2mgWApvAvTWqNslMiM
	 BBj1w9XFpsSBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] vsock/vmci: make the cached_peer dgram decision
 race-safe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmFydMWCb21pZWogRG1pdHJ1aw==?= <bartlomiej.dmitruk@isec.pl>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
References: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 12:32:22 +0000
Message-Id: <20260920123223.6FF601F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vsock/vmci: data tearing on 32-bit allows restricted peer bypass
--

commit 06ed034dbe2daae869975406fc5bbc586f43bfe2
Author: Bart=C5=82omiej Dmitruk <bartlomiej.dmitruk@isec.pl>

vsock/vmci: make the cached_peer dgram decision race-safe

vmci_transport_allow_dgram() cached its result in vsock->cached_peer and
vsock->cached_peer_allow_dgram with an unsynchronized check-then-set. The
function runs both in the lockless receive tasklet
(vmci_transport_recv_dgram_cb(), no socket lock) and in the lock_sock() send
path; lock_sock() does not exclude bottom halves, so the two contexts race =
on
those fields and can return a stale 'allow' for a VMCI_PRIVILEGE_FLAG_RESTR=
ICTED
peer. It is also a plain data race. The in-code comment claiming the fields
are never modified outside create/destruct is contradicted by the send path.

Keep the O(1) cache -- it avoids an O(N) vmci_ctx_get() lookup on every
datagram in the bottom-half receive path -- but pack the peer CID and the
decision into a single word accessed with READ_ONCE()/WRITE_ONCE(). A race
then only forces a recompute and can never return a stale allow.

> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 5549298c1ec6b..9d59b8fe28532 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
[ ... ]
> @@ -39,10 +39,13 @@ struct vsock_sock {
>  	 * modified outsided of socket create or destruct.
>  	 */
>  	bool trusted;
> -	bool cached_peer_allow_dgram;	/* Dgram communication allowed to
> -					 * cached peer?
> -					 */
> -	u32 cached_peer;  /* Context ID of last dgram destination check. */
> +	/* Cached dgram access decision for the last peer, packed as
> +	 * (cid << 32) | VALID | ALLOW and accessed via READ_ONCE()/
> +	 * WRITE_ONCE() so the lockless receive tasklet and the
> +	 * lock_sock() send path cannot race to a stale decision.
> +	 * See vmci_transport_allow_dgram().
> +	 */
> +	u64 cached_peer_access;

[Severity: High]
Can using a 64-bit field here lead to data tearing on 32-bit architectures?

Generic READ_ONCE() and WRITE_ONCE() macros cannot safely read or write
a 64-bit value atomically on 32-bit systems.

>  	const struct cred *owner;
>  	/* Rest are SOCK_STREAM only. */
>  	long connect_timeout;
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 1f186e8f83640..31728e26a7705 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
[ ... ]
> @@ -524,23 +524,38 @@ static bool vmci_transport_is_trusted(struct vsock_=
sock *vsock, u32 peer_cid)
>   * only if it is trusted as described in vmci_transport_is_trusted.
>   */
> =20
> +/* Packing for vsk->cached_peer_access. */
> +#define VMCI_DGRAM_ACCESS_VALID		BIT_ULL(0)
> +#define VMCI_DGRAM_ACCESS_ALLOW		BIT_ULL(1)
> +#define VMCI_DGRAM_ACCESS_CID_SHIFT	32
> +
>  static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 pee=
r_cid)
>  {
> +	u64 access;
> +
>  	if (VMADDR_CID_HYPERVISOR =3D=3D peer_cid)
>  		return true;
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
> -
> -	return vsock->cached_peer_allow_dgram;
> +	/* Cache the trusted/restricted decision for the last peer to avoid the
> +	 * O(N) vmci_ctx_get() lookup on every datagram.  Read/update it through
> +	 * a single word so a race between the lockless receive tasklet and the
> +	 * lock_sock() send path only forces a recompute -- it can never return=
 a
> +	 * stale allow for a restricted peer.
> +	 */
> +	access =3D READ_ONCE(vsock->cached_peer_access);

[Severity: High]
Might this read expose partially updated cache states to the lockless recei=
ve
tasklet on 32-bit architectures?

Because READ_ONCE() on a 64-bit value can be split into two 32-bit reads,
the tasklet could read a torn state containing the new upper 32 bits (the=20
restricted peer's CID) and the old lower 32 bits (with the ALLOW flag from=
=20
a trusted peer).

If the tasklet matches the new CID and sees the ALLOW flag, could it=20
incorrectly authorize access?

> +	if ((access & VMCI_DGRAM_ACCESS_VALID) &&
> +	    (u32)(access >> VMCI_DGRAM_ACCESS_CID_SHIFT) =3D=3D peer_cid)
> +		return !!(access & VMCI_DGRAM_ACCESS_ALLOW);
> +
> +	access =3D VMCI_DGRAM_ACCESS_VALID |
> +		 ((u64)peer_cid << VMCI_DGRAM_ACCESS_CID_SHIFT);
> +	if (vmci_transport_is_trusted(vsock, peer_cid) ||
> +	    !(vmci_context_get_priv_flags(peer_cid) &
> +	      VMCI_PRIVILEGE_FLAG_RESTRICTED))
> +		access |=3D VMCI_DGRAM_ACCESS_ALLOW;
> +
> +	WRITE_ONCE(vsock->cached_peer_access, access);

[Severity: High]
Is it possible for this write to compile into two 32-bit stores on 32-bit
systems?

If a datagram is sent from a restricted peer while the host socket concurre=
ntly
communicates with a trusted peer, the lock_sock() send path updates this fi=
eld
using WRITE_ONCE().

If these stores interleave with concurrent readers from the lockless receive
tasklet, it could leave the cache in a torn state.

Could this race allow a restricted VM to bypass datagram access controls and
communicate with a host socket, circumventing VM isolation?

> +	return !!(access & VMCI_DGRAM_ACCESS_ALLOW);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919123208.2903=
2-1-bartlomiej.dmitruk@isec.pl?part=3D1
