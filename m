Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=140.211.166.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795609538;
	b=eNeMLJSLVTyoBHWxRmvDr5MuiCe18LrFVBCQNqOv/d7AiidibITfgihpYCm1E9KxfAXx
	 D703/rG3RvvcQzz6ANaNmSqzf29hhimhCD/7K35UcPyPLIDAH1jG+acge53C0lL470ato
	 eLCLlj3QFcvFOF0b2gSqq0xbRqLmr/qEfk2kpLO44RdwDgycXKTHdgE9r2WjF03aipodu
	 SXcb3UQyjPEGIdSLUlh9aB3z1m6sYhT5Zizrm/aiqXuubn/CXjiGjAOJPGzYSynEBarnf
	 6XNlHhue6HWTKJFpqhC24yivF25i3VDEcVkzetqwQEjAk7T4z0qBKwqsWdJzD0cBOwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609538;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nxtDC3jdfJKgfps5gESrfwqzSgq84MOBPAMS/1JAwyE=;
	b=M0BKFsDxJRnWdtXjAMw5U03kvvDupGgs8Na7lLXsXIUfxnWh0omYgdcWL7G7GDXuuI1v
	 4egvNwiDr3WbYsKh93LF5LkF5Tl8vDBu9I+3BDc2A5+bBHHglfAuGHl510EhB852Y3X51
	 JCep0DCGv95KT/jCE4i1d2b/DnG1iJWhOdwrkrtk+/Kszk/Wm9YOn4TZNhETqFdwXEarp
	 QDcjYIIliUwLpFzW6w3dnGUtR7rvdwqw79XIIpW0oGY3U1ps//TlivgZt7L0C19e+0MWk
	 OambTVUqQfEQ7wlkzm/yieCxKdHAAWafwiu0rkLKjYWYcHZQfDd6kRhHdtSoLEqe94g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCeAj4a8;
	arc=fail smtp.remote-ip=140.211.166.138
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE726606A32A
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCeAj4a8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB9E680CA6
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 12:25:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.651
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jh_tiJJ-O9SY for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2026 12:25:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E55E780C64
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795609537;
	b=g+L2pzBLcyVi3suyJRgR+ZIp0Xc0EygaU3DPZ46dI4EaudvlabOfaHGuKw3rB7gm4nng
	 zqvqsszMqYPrmK1aEuYzw9rcc3086xfwVWbBC8xceCR15Na9XBPCdEg2i/6GYx+ftRS0D
	 peSF1GjsSlULmq92fn/oo1EGz8c8XFZ72c0BX0eNt0u/3ejZvmm+69UWENG0NTUEGFUkr
	 s1zIau2yAlud36NGBBBe+Bf0rJbyBAPGlgl2qarrKCc1aNe5SmM4/3SM02YTLbH54Qgll
	 PMdwmrggT9HrlK3D6+3km3UxOzfxE6ml92Zvp00X6T/qNcJtJ/CL6otvYhClLQwsgHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795609537;
	h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nxtDC3jdfJKgfps5gESrfwqzSgq84MOBPAMS/1JAwyE=;
	b=HUikBjOdBYNbqHkFB2ZkXkM4mvUNVpbMro33zmbPvnPU9OvvxoeGbdbJO+spalivVDes
	 7gwarw9rgrFYV000rZ7J6wDlF7qGq88YkS+ijkVt3LdNL6dd2ezO+tu1HxAqtVg7ZAP98
	 BB5/MmUBkiJkc+B2Si+TlXvGkDM07Pt0KYEyVBckky5Bbu/zh5AAhM8ZEaUd/X84IS5FA
	 JAILO7GJXGoGfsNCso7DEugfG3ADPubLdprIeliS5BGE09yogxlQYtRelXDM6nG3yN409
	 R9sy+nkA4Pc9nG8RvmxhW9p7XZcSn7vzwbW7jZAV2cud0CMSDiaUEl5XmRzMOnEqsBQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCeAj4a8;
	arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCeAj4a8
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E55E780C64
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 12:25:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 273C062978;
	Wed, 25 Nov 2026 12:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C3A1F000D1;
	Wed, 25 Nov 2026 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795609534;
	bh=nxtDC3jdfJKgfps5gESrfwqzSgq84MOBPAMS/1JAwyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MCeAj4a8W7rINlxO/Of5E3o7tRlESKGuvFS6zHS9be26Y/3Nbmh3vUMQGLAuJwNxI
	 /utv0W/IsWq31cCt0HDg/L8zSW6eUVRMyQnFJTHAQJk9B0p0lJgC6hcIdq8SDVekcC
	 KMjb1cXYE8CBE+n+BkVzwWAVR7j/vXMExEsJwCPwlpmpk5wGJZEm2BlFFVh6jxSvBh
	 yTjOBg0FIH/cIj/5J1+BWS2AYpL9nkiAU0ktUFUyUDYfvUazGOWHeoNlwwZiVDzLb+
	 uOkybob6UmN3C/mTY1Qt2VY00p/jG1DUv0GCZ6uYil8F+4/K2hB3Sy52TCqevWFob6
	 lcZtlj3N/NWDw==
Date: Wed, 25 Nov 2026 12:25:24 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "chenglong.ma" <longpareto@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 2312891301@qq.com, blum@kernel.org, 
	co+6dcbccedc9ec6452@bugs.sh, eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com, 
	kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lirongqing@baidu.com, 
	oss.patchbox@gmail.com, p@1g4.org, phx0fer@gmail.com, physicalmtea@gmail.com, 
	sergiiushakov@google.com, shubham@octane.security, stable@vger.kernel.org, 
	stjepan.poljak@gmail.com, syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com, 
	tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu, 
	xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com, zenghui.yu@linux.dev, 
	zhaimingbing@cmss.chinamobile.com, zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <awbTgufgR4Uge1kJ@gremlin>
References: <20261104081535-mutt-send-email-mst@kernel.org>
 <awWOpS3HR_2FTN3I@gremlin>
 <20261125060533.1296-1-longpareto@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125060533.1296-1-longpareto@gmail.com>

On Wed, Nov 25, 2026 at 02:05:32PM +0800, chenglong.ma wrote:
> On Tue, Nov 24, 2026 at 01:51:29PM +0000, Lorenzo Stoakes (ARM) wrote:
> > It looks like it doesn't need VM_IO anyway, the other changes in the patch
> > make it redundant AFAICT, so you should send something like the below with
> > a Fixes pointing at bb2e6f166547:
>
> Sorry about that: it went to security@kernel.org (hence no lore thread),
> I did not test it on 7.4-rc, and you're right that VM_IO is redundant,
> since vduse_domain_set_map() is the only way vhost-vdpa entries reach
> the domain iotlb and it already rejects anything backed by the domain
> file.

Please, in future, when you submit something for a kernel release, test your
change against that kernel release :) or get your LLM to ;)

>
> I'll send the one-liner with Fixes: bb2e6f166547 and your Reported-by
> and Suggested-by once I have actually run it on current mainline.

Thanks!

>
> Thanks for catching this.

--
Cheers, Lorenzo
