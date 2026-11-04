Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793798844;
	b=tcrEKah/wNP16IQ7TyRryHyxBCMltghXsN2g3WHuzZO2CbV81aZCW/tx6vcfv3QVexDT
	 9jM2wbhdTHb/VoFsd3+vZh7rkJNSv3vOI7iE+82s+bTlbaN47GTmocq8Favh3gV2m3M51
	 JlaUw0FuHzzZfaUy3iLNs89FvToeKp0rTle7t3eoZCAyck8jhB+VKWSrRjBx6QRd0fSEC
	 /i3ME9ntxtwRxkvE0+28VyFVFffMXwAOwtzi8Y9z0If0XkX7/HXiPXh0r5ABdQQhlrZx7
	 cWmfUsSEsnet25sVG5rs9ieIUErmL3MgWDnc8rCCwjdcg1XzmhrPNYwEMNP3bp82vEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798844;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hhq5EOa6Odz+K2vaBaOuOYmvWaBTRJ+kEF4fefMeYnQ=;
	b=YurBkG6yTiVMlpMYwlHZtKAa/JH7075eSrxNmEe0nHKhTYmZr3ms6I/6N3TWzpOqEcIM
	 t+i/TAZ/LBMcUoVNZvFtCwwwMFzgo91swRmbdKOrBGAO14tJQ2LcohjpURbAxN+eLGrDi
	 74oBxjOk6tPbvdqDP/1H6dhXj0UGdOZtoa4lDGCLQf0EXiLzl+RtleZKafQlyZNM+D2z8
	 +l+jgxaA7JCf7jvMjKlm9Vpr44kJVwu7iz3Su9bTHCcIVmedRN9eJwJJ7FcjJL6a6ttqA
	 B4Gjou5oFrjv0PwKJudk/syIJNa6oIdoiC8PIdS5xpMjTVV3zfmN6MssI/KjZG2OlVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=LokHz1aa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.137
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5D606A33F
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Nov 2026 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=LokHz1aa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 727DE403F6
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Nov 2026 13:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.05
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G6_Ln3u7IaIX for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2026 13:27:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 31255403AA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.9.206.169
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793798842;
	b=CtO4RHirMEngo3ZvI0HiAZhkuPcdVEAoEs0mjHPRWuvIXddpfb9wXjrPCUZef8DPkxRl
	 fBGBgvl07SXu0JwLjeEnzE+FU0SINgNO3N2b3pQLavAWjENwk2iTdTsiLqjSMRL8Um95T
	 Vz2FoQn2rfQXDoYp0rnboJh8WBOgD5MTY4mAPbC1KSHRE/+stS4UmwUTc1BQUMAllUekc
	 QRByJyQb9FT/xnu1DBXq537hYZ2S3ZmNfB1cAVjwd21otJqolXhqXyV+QpXbmxThgjF/+
	 CPsFKl9ZAsfeNzmJi3ow2JpKcGPuWUS7QOs1lUZnBbeR/K28QE8oci0HHWT16hzqWSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793798842;
	h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hhq5EOa6Odz+K2vaBaOuOYmvWaBTRJ+kEF4fefMeYnQ=;
	b=jNr7uEUHDVXEnMfX5FioWS9gQgXpZhlB8bt38Ica0B3P0mtx9Qb7Ri4RxoTc9KRxVHKg
	 wWRLSToAEVUmBOazmlE7u0yNDULIovuKjJknkYiGqHEdV0rKkQS6J6G3Wk/YwB7+kG7xi
	 H8Ue/DP41OpsAWbb2TSTCUJ3az54Z5xvuO6qNu/DUmrXya0Wu+rvJ7Dk1GG9FJLY/58jn
	 Qv8uzKC+4Haolg0h0YOFUgoadKP+jRRtjQKDg7weXi/kXycvU876pdxPp3kVwXNqxO0KP
	 Pv9qDowdOVp54R5BwES/seL0s6vr0PZ72UBNdtSp51aqKOJv7Sw1cYJK7L2GuGk6X3w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=LokHz1aa;
	arc=none smtp.remote-ip=85.9.206.169
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.206.169; helo=mail-05.mail-europe.com; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=LokHz1aa
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 31255403AA
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Nov 2026 13:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793798828; x=1794058028;
	bh=hhq5EOa6Odz+K2vaBaOuOYmvWaBTRJ+kEF4fefMeYnQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LokHz1aag6PaSNFE8C27kBJ0WZ6M+UPGHXO+rQSR0cNM/2otH80f1ijoMEGuR55gW
	 b4QL7QYt40r1A8rSZ8mzFMAVGBkEd24hvQwLCMm6b9DUZ6oO38XXyaeHg/Zqg/w9Mr
	 Xuzjd10Gz32YbH9HD3+dR2GhiETXDW2tWFiKkRse7s5HA+nLsh+tlNfkFT6xTRz7OH
	 B7Of+E4TFuHrasbBSkEP4d0F18omzemN55swOa82ZMF3ORRlcHiCmy96DQ2IPNw7RB
	 /58u7U5RPNRi7lV3nvfCIDzzkKizj1Kur0hi39lOpH+lVckEaQkoQjOVtZalGAswbE
	 M2/BI/0Nr6GVQ==
Date: Wed, 04 Nov 2026 13:26:56 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Paul Moses <p@1g4.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 2312891301@qq.com, blum@kernel.org, co+6dcbccedc9ec6452@bugs.sh, eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com, kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lirongqing@baidu.com, longpareto@gmail.com, oss.patchbox@gmail.com, phx0fer@gmail.com, physicalmtea@gmail.com, sergiiushakov@google.com, shubham@octane.security, stable@vger.kernel.org, stjepan.poljak@gmail.com, syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com, tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu, xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com, zenghui.yu@linux.dev, zhaimingbing@cmss.chinamobile.com, zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <boz9jnakQM6uAhZfWbN75Fy90K5NZ8XCEXBRlhjkqDryEgBVXwJzIPrq1giWoitEnsZPiK4FyKlYBVHioGorKSw4JzSVd8kxw9RIhEz0-kE=@1g4.org>
In-Reply-To: <20261104081535-mutt-send-email-mst@kernel.org>
References: <20261104081535-mutt-send-email-mst@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: e60a96041563db78786d8f092c9f5e833f03cb84
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 06:56:40AM +0000, Paul Moses wrote:
> > On Wed, Mar 11, 2026 at 08:00:45PM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Mar 11, 2026 at 02:12:17PM +0000, Paul Moses wrote:
> > > > >
> > > > > Indeed, seems legit, thanks!
> > > > >
> > > > > The only thing is that I dislike two error handling paths here.
> > > > > So I wonder why isn't this as simple as fixing the double free
> > > > > directly:
> > > > >
> > > >
> > > > That works for me, should I send it out?
> > > >
> > > > Thanks,
> > > > Paul
> > >
> > >
> > > Please do.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Oh and I forgot
> >
> > Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
> >
> >
> > >
> > > --
> > > MST
> >
> >
>
> Considering that this pattern has occurred in multiple independent source=
 files,
> maybe it is worth it to make intent more clear? What about this?
>
> >From c3b9431dc736cec60c0b288b13d9fa718341f46a Mon Sep 17 00:00:00 2001
> From: Paul Moses <p@1g4.org>
> Date: Tue, 10 Mar 2026 15:23:58 -0500
> Subject: [PATCH] vdpa: don't free reply skb after genlmsg_reply()
>
> genlmsg_reply() hands the reply skb to netlink, and
> netlink_unicast() consumes it on all return paths, whether the
> skb is queued successfully or freed on an error path.
>
> vdpa_nl_cmd_dev_config_get_doit() currently jumps to nlmsg_free(msg)
> after genlmsg_reply() fails, which can hit the same skb twice.
>
> Return the genlmsg_reply() error directly and keep nlmsg_free()
> only for pre-reply failures.
>
> Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Paul Moses <p@1g4.org>

I like crediting people for their work.  Let's do this. Pls post as a
proper patch starting a new thread, so all 0day tooling catches this,
and I'll apply. I'll then apply a rework removing the duplication, on
top.  Thanks!


> ---
>  drivers/vdpa/vdpa.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 34874beb0152e..702d3a7772219 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1352,15 +1352,19 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct=
 sk_buff *skb, struct genl_info
>  =09}
>  =09err =3D vdpa_dev_config_fill(vdev, msg, info->snd_portid, info->snd_s=
eq,
>  =09=09=09=09   0, info->extack);
> -=09if (!err)
> -=09=09err =3D genlmsg_reply(msg, info);
> +=09if (err)
> +=09=09goto mdev_err;
> +
> +=09put_device(dev);
> +=09up_read(&vdpa_dev_lock);
> +
> +=09return genlmsg_reply(msg, info);
>
>  mdev_err:
>  =09put_device(dev);
>  dev_err:
>  =09up_read(&vdpa_dev_lock);
> -=09if (err)
> -=09=09nlmsg_free(msg);
> +=09nlmsg_free(msg);
>  =09return err;
>  }
>
> --
> 2.53.GIT
>


It's obvious now your intention was always to diminish my=20
contribution. This really only reflects negatively on you.

You or claude didn't even disassemble it. It's slop. My
patch is objectively superior both in human readability
and performance.
