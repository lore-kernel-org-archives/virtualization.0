Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1CCECAAA1
	for <virtualization@archiver.kernel.org>; Tue,  6 Sep 2022 13:26:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B41240C11;
	Tue,  6 Sep 2022 13:26:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B41240C11
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Md31Jahc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 85eqN8_gml7o; Tue,  6 Sep 2022 13:26:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2E2AC40C0B;
	Tue,  6 Sep 2022 13:26:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E2AC40C0B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09888C0033;
	Tue,  6 Sep 2022 13:26:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A859C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 13:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47FB181A2B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 13:26:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47FB181A2B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Md31Jahc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4spgKildcaxn
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 13:26:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84BF380BE7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84BF380BE7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662470800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cG+EMJYQC9dpJwtmnpabIGTtF9jjQR1GUpVCWiATrrQ=;
 b=Md31JahcKMsadYLO0WJ5EFkFr/jJ/HDITKyBMED7RbQt43gMbQoM7DzCtjLtZl/tPWDZ8F
 N0mSn09fEpiUdA75nblk6dpCCfHLwmznImEAWS+M47B7wcawZmQ+tTcGBAffH4QTn3upUT
 IYKfneN6DigazVd9h9gfLSLvPW/lRTM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-kAuUCntzO02DdqDuwRNM8A-1; Tue, 06 Sep 2022 09:26:37 -0400
X-MC-Unique: kAuUCntzO02DdqDuwRNM8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 907501C006AA;
 Tue,  6 Sep 2022 13:26:35 +0000 (UTC)
Received: from localhost (unknown [10.39.193.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EAEC2026D4C;
 Tue,  6 Sep 2022 13:26:34 +0000 (UTC)
Date: Tue, 6 Sep 2022 09:26:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Message-ID: <YxdKiUzlfpHs3h3q@fedora>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <cover.1660362668.git.bobby.eshleman@bytedance.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Wei Liu <wei.liu@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7136653742471412879=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============7136653742471412879==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ffA3zeJuYjNdcnmP"
Content-Disposition: inline


--ffA3zeJuYjNdcnmP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bobby,
If you are attending Linux Foundation conferences in Dublin, Ireland
next week (Linux Plumbers Conference, Open Source Summit Europe, KVM
Forum, ContainerCon Europe, CloudOpen Europe, etc) then you could meet
Stefano Garzarella and others to discuss this patch series.

Using netdev and sk_buff is a big change to vsock. Discussing your
requirements and the future direction of vsock in person could help.

If you won't be in Dublin, don't worry. You can schedule a video call if
you feel it would be helpful to discuss these topics.

Stefan

--ffA3zeJuYjNdcnmP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMXSogACgkQnKSrs4Gr
c8iC8wf/WGQyOwxcifRrsvIy43xkZiginzOzlIJEAkBPO1lbTUzCLMkjeiaOgOkO
7VOexEKxi3S67NVq1vUyAzKPB6HFERheGtQOQtkhrmKDKfhVH14zU6t/bHSVeoAe
UfM2UaaO4nF/XRVuO6g6sKsVAqVFWQxpdBjVrsg4B4v8k/1q7W/tiAy//WJHCZc9
6dJCJ+qoPxICjfqc0bw56xbERbh0TG+xneBkGVjp7nLLq/NG/tV7LoIb7xs3EXxq
wB/WYW+bZBtO378tl7SxMksYKv1DFPuYjU52vuUw2X0bz6jgoFn3/rB5ndoHg/o0
D8YtdthVM/GJqXQtJAhIIqbPdUV7Dg==
=DJmj
-----END PGP SIGNATURE-----

--ffA3zeJuYjNdcnmP--


--===============7136653742471412879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7136653742471412879==--

