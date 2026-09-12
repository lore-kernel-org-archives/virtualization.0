Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ADD3E00AA
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789250482; cv=none; b=StULcTHOaMHc1ddBNWKVmAuk3Ijm5znCBPLy8vRtk1or7YyPmWM73BvBLhs8Hu58+NkfhlLM0RLsdbY5XUMfJcmtbHwWw9ikIDv7M6KAWAAUqMimAUQtXVAg8yzpjaIgn4r8XTo1MIKpZ1N398vI/XKqknT8Pc1fNv93Nu3yKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789250482; c=relaxed/simple;
	bh=LdjsuDBT/VLIPb5KepaYu3U9fHZqQlhrBHWNXvOqg+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EzkTXZKCfjXFN2CGBLwqq+aD29kHX7QafZ4dY4Qos50Hbdgwa8nfJRctyD1DkxPs+I7bs0orw7YRQoWUgxQHC/RNHgISWrwQOdYhbcZKB+PAkAF4GiyQC8sdhJW9QJ7EydKGvZ7bGCju8cK7CZKo1weGbYOqSOKrav6fVF7HAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGCFZi/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGCFZi/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A611D1F00893;
	Sat, 12 Sep 2026 22:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789250479;
	bh=c+p4ujK0eifT0GerhdeJHbn/Bkg+EIvvk9HshHnfWos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGCFZi/RmwY4PxlBwGVR4aNlffD+KZsqOC/11JpQkXicpNyUFFsoHoRdsOAv97ogn
	 Zs11Z3PHYlSUlKjCSmbXJdEKm33TWJfnU3iypg2eWpPDU49GJk0ab5bOmfKdoDkNxd
	 JU3yinrOcK69qMwbYinf2MEDmwH16XOgicDW3UlzKTeoIBLMIngJ/9hYj1lKEirqfi
	 Hz8wydOSSBtRemSrvArTnfwuCmXBFXpHW5/D8iD2W4qSsrHhdxGIiAdCrzCiIyxREU
	 zyXte64ApB99Wwn339eaCXBT06G6fEVpu+ZeQwxG8gbD7ln30lTSL9gla74a0jHR4W
	 OTUYodBeXxcrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vdpa: fix double free of the reply skb in
 vdpa_nl_cmd_dev_config_get_doit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Mei" <xmei5@asu.edu>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260912215401.126194-1-xmei5@asu.edu>
References: <20260912215401.126194-1-xmei5@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 22:01:19 +0000
Message-Id: <20260912220119.A611D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> genlmsg_reply() consumes the reply skb on every outcome: netlink_unicast()
> frees it whether it queues it, drops it, or bails out early.
> vdpa_nl_cmd_dev_config_get_doit() lets its return value fall through to t=
he
> shared error label, which calls nlmsg_free(msg) again and double-frees the
> sk_buff on any reply failure. The failure is reachable unprivileged:
> VDPA_CMD_DEV_CONFIG_GET carries no GENL_ADMIN_PERM, so batching several
> requests into one sendto() on a socket with a shrunken SO_RCVBUF fills the
> receive queue, and netlink_attachskb() then takes its MSG_DONTWAIT path,
> freeing the skb and returning -EAGAIN.
>=20
> Set msg to NULL once genlmsg_reply() has consumed it so the shared exit
> path frees the skb only on the early error gotos that still own it;
> nlmsg_free(NULL) is a no-op.
>=20
>   BUG: KASAN: slab-use-after-free in sk_skb_reason_drop (net/core/skbuff.=
c:1220)
> [ ... ]
> Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
> Reported-by: co+6dcbccedc9ec6452@bugs.sh
> Closes: https://lore.kernel.org/all/ILTHcT8oe1HP47sY25JVxssvKmkCTjYlX9Hs%=
40bugs.sh/
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912215401.1261=
94-1-xmei5@asu.edu?part=3D1

