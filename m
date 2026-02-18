Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7ADC2EA
	for <virtualization@lists.linux.dev>; Wed, 18 Feb 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431345; cv=none; b=mgaI92B5GyU+pyDX7edX0xO0KC8DGwim8M8/l4uhSfaYELl9BSBZpOURAIYFaHVxMCT9EhFjn33HfeM2Tb7q6SybXOMshD+9TGxICVoJFcoEXSsJZS5zLjDg6e1H/ZvtTMvQo+F4zf0YCrIRMVejDZ5cIjixOeHfBQZBmIDwvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431345; c=relaxed/simple;
	bh=M8x3Eta6dsHBZmEiqBxFrizv2ZeW28diPeGIt7lnfCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8VZ8qsgNbmUgT4KivZHqJ9b7ACAbkTX0DcyUCjvwB42+lInjUU1VpfzniGI88smuln8GosjNoFuGCaYuUfAQPIbg9FukQ/oSg2j6XcJzeY1NTRS2QVJMD6MHLl1GGnkkIbELW6qi1RQGD/ThWeEGtOPnkEC2U4dFMgnEgoQbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsVzepUm; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsVzepUm"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-649278a69c5so4985998d50.3
        for <virtualization@lists.linux.dev>; Wed, 18 Feb 2026 08:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771431341; x=1772036141; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2QPsjXZQUdipsGNcNiU7XkuEdRr5aKeXHMLyIc5cKOk=;
        b=PsVzepUmtrfxR9MXKRtjKK3T1F0u4upgqDmmXjNwF5etdFwBCcjsYqHjnmmmorWAdy
         ViaUMthsi8l/bBlm5bHlo0oedbf5X30BbmrqftgOxI3ttUscrAudX0K7zCBIMOT9zd53
         gSBV66Iq69TZWFayHF3e+ixTMviGh4eq6ax9jv4C9f0x3xU0Xmi/GkTr0C9FinclJt1V
         GT233m3SUR3bKRgJgivKPeDu21ZX3C99JIJYNYBzKNebH8m0V6VmFrZMZiRSsrkN+OBs
         v6T/PLmZHBikmSdRVe0Ai3ngt5Nm8uWTnj+53qr2XAd4MNCTsmdzhE9JgzopPQ9sUVO2
         KpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771431341; x=1772036141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QPsjXZQUdipsGNcNiU7XkuEdRr5aKeXHMLyIc5cKOk=;
        b=qr4ANY3zjxKpohgzrXaDFKoWGv22R4xLwPuOTXqNuc8P1/ZSaBlLuQlNGYHUSPbG1K
         5Olrle//0NfKSiFvGhlt4IO66kVeeIYMu3cQURsXO1Bdgz2qxqfHHuypyfwgRdZ1G/ji
         dMmOiDmStR0uyOgNR53VXkf2obbftVs2yNoM8+2VwQ/M+yor7izykQy1YsT/ZwRneU80
         lpC/finmyS3fXoqhvo3YAmcNpu7Q+JTsyEdyc2LHaLAHEZ5JgUmv+K4/JvFfR2QLXVUG
         qyaROQu8G6OhywLw8/vwWU6pbBxhVWHS9zO4XZBJlR7i8v50RY/JMn2tMa1PM+ElNOtW
         On9g==
X-Forwarded-Encrypted: i=1; AJvYcCXbJRWx4RElPQbArRq8vV/E9sqaryzrL9klAyD8zbASlUtGUQg8uhSc6Z1YES+4x3zOM5jQwzpocN1x6e7aDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJq8njxmRUzCpLeaMcbzKW3mEVpszImS88osj9KQ7pBPmbAm4y
	/JjrcH9VKVGrQLSPrnA3lMjOzOngtrQcfp0T0q9U444CQFIMYLkT93VC
X-Gm-Gg: AZuq6aLXaEJzmwEz2fLKu+/h2CJRPk0yCncYDZXN2PH3xNDaTjfuo0M5NQjFOOf2i5J
	1Fk9GsyjcowItw5kHD5pfHNODzt1ZeXRkRZmY+tUseT5+wG9SqGvCBSQj6Akv442q2aar9oTWiT
	sMJ6+RifxWWRyvVIQqMo5iuCaXd8SCEg0nULCT61NoZ/DfJz742QEkBjHiTHcwdiVSN2eroGWNF
	RjK0AUQO1sUvPUqWByLwA6pVIT4dGM1nNNnp4Ak462SrP/A0y0CaVHROG7n81Q5HLL23uRNr+7f
	bR+W2WS7miA4haE0daqlzwNuapoEUZpiDvoVuZSGDXpgcp2HlX/+DLDOWuKQyrEdEWYKM+Tatrp
	G27/VDaydituk1YB5JGGnrYmb6hnj7PX+bn90PoDAPzHUTxmXaz19kd7L6hwToWlnWy0HNqQdXX
	+ZvjxF++OvzO0xAN+crQdJPmeEJS/sfuXUxjFa3wMwkzNHk4I=
X-Received: by 2002:a53:de11:0:b0:649:3897:ba21 with SMTP id 956f58d0204a3-64c14d381f8mr13378167d50.52.1771431341018;
        Wed, 18 Feb 2026 08:15:41 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22ea3ddfsm5898507d50.8.2026.02.18.08.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:15:40 -0800 (PST)
Date: Wed, 18 Feb 2026 08:15:38 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net] vsock: lock down child_ns_mode as write-once
Message-ID: <aZXlqv5ukWymz/NI@devvm11784.nha0.facebook.com>
References: <20260217-vsock-ns-write-once-v1-1-a1fb30f289a9@meta.com>
 <aZV6HRAIsf_rNRM2@sgarzare-redhat>
 <aZWUmbiH11Eh3Y4v@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZWUmbiH11Eh3Y4v@sgarzare-redhat>

On Wed, Feb 18, 2026 at 11:43:42AM +0100, Stefano Garzarella wrote:
> On Wed, Feb 18, 2026 at 11:02:02AM +0100, Stefano Garzarella wrote:
> > On Tue, Feb 17, 2026 at 05:45:10PM -0800, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > To improve the security posture of vsock namespacing, this patch locks
> > > down the vsock child_ns_mode sysctl setting with a write-once policy.
> > > The user may write to child_ns_mode only once in each namespace, making
> > > changes to either local or global mode be irreversible.
> > > 
> > > This avoids security breaches where a process in a local namespace may
> > > attempt to jailbreak into the global vsock ns space by setting
> > > child_ns_mode to "global", creating a new namespace, and accessing the
> > > global space through the new namespace.
> > 
> > Commit 6a997f38bdf8 ("vsock: prevent child netns mode switch from local
> > to global") should avoid exactly that, so I don't get this. Can you
> > elaborate more how this can happen without this patch?
> > 
> > I think here we should talk more about what we described in
> > https://lore.kernel.org/netdev/aZNNBc390y6V09qO@sgarzare-redhat/ which
> > is that two administrator processes could compete in setting
> > `child_ns_mode` and end up creating a namespace with an `ns_mode`
> > different from the one set in `child_ns_mode`. But I would also explain
> > that this can still be detected by the process by looking at `ns_mode`
> > and trying again.  With this patch, we avoid this and allow the
> > namespace manager to set it once and be sure that it cannot be changed
> > again.

Oh that's right, I lost track of the original intent when writing this.

> > 
> > > 
> > > Additionally, fix the test functions that this change would otherwise
> > > break by adding "global-parent" and "local-parent" namespaces and using
> > > them as intermediaries to spawn namespaces in the given modes. This
> > > avoids the need to change "child_ns_mode" in the init_ns. nsenter must
> > > be used because ip netns unshares the mount namespace so nested "ip
> > > netns add" breaks exec calls from the init ns.
> > 
> > I'm not sure what the policy is in netdev, but I would prefer to have
> > selftest changes in another patch (I think earlier in the series so as
> > not to break the bisection), in order to simplify backporting (e.g. in
> > CentOS Stream, to keep the backport small, I didn't backport the dozens
> > of patches for selftest that we did previously).

Sounds good! I wasn't sure if breakage so tightly coupled should be in
the same patch or not, I'm happy to split it up to ease backporting.

> > 
> > Obviously, if it's not possible and breaks the bisection, I can safely
> > skip these changes during the backport.
> > 
> > > 
> > > Test run:
> > > 
> > > 1..25
> > > ok 1 vm_server_host_client
> > > ok 2 vm_client_host_server
> > > ok 3 vm_loopback
> > > ok 4 ns_host_vsock_ns_mode_ok
> > > ok 5 ns_host_vsock_child_ns_mode_ok
> > > ok 6 ns_global_same_cid_fails
> > > ok 7 ns_local_same_cid_ok
> > > ok 8 ns_global_local_same_cid_ok
> > > ok 9 ns_local_global_same_cid_ok
> > > ok 10 ns_diff_global_host_connect_to_global_vm_ok
> > > ok 11 ns_diff_global_host_connect_to_local_vm_fails
> > > ok 12 ns_diff_global_vm_connect_to_global_host_ok
> > > ok 13 ns_diff_global_vm_connect_to_local_host_fails
> > > ok 14 ns_diff_local_host_connect_to_local_vm_fails
> > > ok 15 ns_diff_local_vm_connect_to_local_host_fails
> > > ok 16 ns_diff_global_to_local_loopback_local_fails
> > > ok 17 ns_diff_local_to_global_loopback_fails
> > > ok 18 ns_diff_local_to_local_loopback_fails
> > > ok 19 ns_diff_global_to_global_loopback_ok
> > > ok 20 ns_same_local_loopback_ok
> > > ok 21 ns_same_local_host_connect_to_local_vm_ok
> > > ok 22 ns_same_local_vm_connect_to_local_host_ok
> > > ok 23 ns_delete_vm_ok
> > > ok 24 ns_delete_host_ok
> > > ok 25 ns_delete_both_ok
> > > SUMMARY: PASS=25 SKIP=0 FAIL=0
> > 
> > IMO this can be removed from the commit message, doesn't add much value
> > other than say that all test passes.

sgtm!

> > 
> > > 
> > > Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> > > Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > include/net/af_vsock.h                  |  6 +++++-
> > > include/net/netns/vsock.h               |  1 +
> > > net/vmw_vsock/af_vsock.c                | 10 ++++++----
> > > tools/testing/selftests/vsock/vmtest.sh | 35
> > > +++++++++++++++------------------
> > > 4 files changed, 28 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > > index d3ff48a2fbe0..c7de33039907 100644
> > > --- a/include/net/af_vsock.h
> > > +++ b/include/net/af_vsock.h
> > > @@ -276,10 +276,14 @@ static inline bool vsock_net_mode_global(struct vsock_sock *vsk)
> > > 	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
> > > }
> > > 
> > > -static inline void vsock_net_set_child_mode(struct net *net,
> > > +static inline bool vsock_net_set_child_mode(struct net *net,
> > > 					    enum vsock_net_mode mode)
> > > {
> > > +	if (xchg(&net->vsock.child_ns_mode_locked, 1))
> > > +		return false;
> > > +
> > > 	WRITE_ONCE(net->vsock.child_ns_mode, mode);
> > > +	return true;
> > > }
> > > 
> > > static inline enum vsock_net_mode vsock_net_child_mode(struct net *net)
> > > diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
> > > index b34d69a22fa8..8c855fff8039 100644
> > > --- a/include/net/netns/vsock.h
> > > +++ b/include/net/netns/vsock.h
> > > @@ -17,5 +17,6 @@ struct netns_vsock {
> > > 
> > > 	enum vsock_net_mode mode;
> > > 	enum vsock_net_mode child_ns_mode;
> > > +	int child_ns_mode_locked;
> > > };
> > > #endif /* __NET_NET_NAMESPACE_VSOCK_H */
> > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > > index 9880756d9eff..35e097f4fde8 100644
> > > --- a/net/vmw_vsock/af_vsock.c
> > > +++ b/net/vmw_vsock/af_vsock.c
> > > @@ -90,14 +90,15 @@
> > > *
> > > *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
> > > *     mode, which is set at namespace creation and immutable thereafter.
> > > - *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
> > > + *   - /proc/sys/net/vsock/child_ns_mode (write-once) controls what mode future
> > > *     child namespaces will inherit when created. The initial value matches
> > > *     the namespace's own ns_mode.
> > > *
> > > *   Changing child_ns_mode only affects newly created namespaces, not the
> > > *   current namespace or existing children. A "local" namespace cannot set
> > > - *   child_ns_mode to "global". At namespace creation, ns_mode is inherited
> > > - *   from the parent's child_ns_mode.
> > > + *   child_ns_mode to "global". child_ns_mode is write-once, so that it may
> > > + *   be configured and locked down by a namespace manager. At namespace
> > > + *   creation, ns_mode is inherited from the parent's child_ns_mode.
> > 
> > We just merged commit a07c33c6f2fc ("vsock: document namespace mode
> > sysctls") in the net tree, so we should update also
> > Documentation/admin-guide/sysctl/net.rst

Indeed.

> > 
> > > *
> > > *   The init_net mode is "global" and cannot be modified.
> > 
> > Maybe we should also emphasise in the documentation and in the commit
> > description that `child_ns_mode` in `init_net` also is write-once, so
> > writing `local` to that one by the init process (e.g. systemd),
> > essentially will make all the new namespaces in `local` mode. This could
> > be useful for container/namespace managers.
> > 

Sounds good.

> > > *
> > > @@ -2853,7 +2854,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> > > 		    new_mode == VSOCK_NET_MODE_GLOBAL)
> > > 			return -EPERM;
> > > 
> > > -		vsock_net_set_child_mode(net, new_mode);
> > > +		if (!vsock_net_set_child_mode(net, new_mode))
> > > +			return -EPERM;
> > 
> > So, if `child_ns_mode` is set to `local` but locked, writing `local`
> > again will return -EPERM, is this really what we want?
> > 
> > I'm not sure if we can relax it a bit, but then we may race between
> > reader and writer, so maybe it's fine like it is in this patch, but we
> > should document better that any writes (even same value) after the first
> > one will return -EPERM.
> 
> I think we can try in this way:
> 
> static inline bool vsock_net_set_child_mode(struct net *net,
> 					    enum vsock_net_mode mode)
> {
> 	int new_locked = mode + 1;
> 	int old_locked = 0;
> 
> 	if (try_cmpxchg(&net->vsock.child_ns_mode_locked,
> 			&old_locked, new_locked)) {
> 		WRITE_ONCE(net->vsock.child_ns_mode, mode);
> 		return true;
> 	}
> 
> 	return old_locked == new_locked;
> }
> 
> With a comment like this near child_ns_mode_locked in struct netns_vsock:
> /* 0 = unlocked
>  * 1 = locked to GLOBAL (VSOCK_NET_MODE_GLOBAL + 1)
>  * 2 = locked to LOCAL  (VSOCK_NET_MODE_LOCAL + 1)
>  */

This looks good to me. Will change.

> 
> While writing that, I thought that we can even remove `child_ns_mode_locked`
> and use a single variable where encode the value and the state, but maybe
> it's an unnecessary extra complexity.
> 
> Stefano
> 
> > 
> > About that, should we return something different, like -EBUSY ?
> > Not a strong opinion, just to differentiate with the other check before.
> > 
> > Thanks,
> > Stefano
> 

Differentiating with -EBUSY sounds useful. Will add that and document.

Best,
Bobby
