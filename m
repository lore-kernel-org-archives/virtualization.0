Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3382CC77B6E
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 01:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8ADE24057B;
	Mon, 10 Apr 2023 01:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8ADE24057B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0l2ofjY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xhg7npbVjJWz; Mon, 10 Apr 2023 01:53:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BA626400BA;
	Mon, 10 Apr 2023 01:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA626400BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69234C0036;
	Mon, 10 Apr 2023 01:53:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61384C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 01:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 239638129B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 01:53:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 239638129B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0l2ofjY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pmjFhTX86gLh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 01:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5769081292
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5769081292
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 01:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681091629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Ewfh0KYYOrMcavttBVF2ItHZjIa0z4xpWCwN8lKwek=;
 b=M0l2ofjYCiB0Rt6BAzTa5KodEJa+rF7DEq9XRRByVSvHYvGTia57tDhk1NvNUnhI5oKdAG
 c+A5r5L/aq9jaK88HzsB+NPbwgDKR+tyfRWoC+xYvclVck0ilzlAGOkpXzG+dQ0GVhbSlc
 RwF+HgcOvAHA/pXOT2AgJMg2hhKER6o=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Eeoj4WQVM5O4SXKz3hrjMg-1; Sun, 09 Apr 2023 21:53:48 -0400
X-MC-Unique: Eeoj4WQVM5O4SXKz3hrjMg-1
Received: by mail-oi1-f200.google.com with SMTP id
 r4-20020a056808210400b003897356756bso7710867oiw.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Apr 2023 18:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681091627; x=1683683627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Ewfh0KYYOrMcavttBVF2ItHZjIa0z4xpWCwN8lKwek=;
 b=qfF3EC0S/R5ALOTbkF8Cf0111QrG8AM2OeQJI2HVmn2UVqMX61dJNtxq+wE8eb0s28
 0LZC8PC59wMcOwDdK/NVWj1NqL3ryuWz9eWUIbZKIipWlXm0nxfwO8I4EeDDh9/TL4aA
 PYq97JVkNlwdOr7Bka477ARGgfPM0USwaTHlYPF5k5wJ/hfr7s36wKFcYyi3jA2IGTPT
 RkAqq6v97jeIQBnn+nCJnQUgGBT2MpJAQS10rHskYaIwRsgBIQ0jlGVTSEAboKClWt7g
 pM0iywIT7US9yq1EEs/kNdt0w2S2PQXGOuK73EvQ2KpRvcQEpBWStHF4MrE5BJ76QNe4
 tOFA==
X-Gm-Message-State: AAQBX9ecrx4Di88l++6P5+2Q5VKv9A4DKji6mKMBKnkZSgWHAv9oS1oz
 zXcLVrlCmQ0GAEUm9a5qtCd8aVRinsuxbqUavj8qozazf2b6m2VM705R2K5KDhp9nbpvl3YmkqM
 gOGvZHY9wqSvs8B0epuejWNnElqUphK7++lqQU1oW/YHp9srQPuZH+HNJkw==
X-Received: by 2002:a05:6870:5627:b0:184:c14:a685 with SMTP id
 m39-20020a056870562700b001840c14a685mr2767689oao.9.1681091627414; 
 Sun, 09 Apr 2023 18:53:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350YpfA2mxMBAcH4TPDlXzAHkAw2xmtyG2o1/ecKq0FVHMCgVIFkDe34Rmk4fhfv5vEJgNBJ4/k3TkcXE99waXks=
X-Received: by 2002:a05:6870:5627:b0:184:c14:a685 with SMTP id
 m39-20020a056870562700b001840c14a685mr2767676oao.9.1681091627228; Sun, 09 Apr
 2023 18:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
 <20230402125219.1084754-2-alvaro.karsz@solid-run.com>
 <CACGkMEuQpJyQNuYTs2TwCc8SmvynbVwqtcZnF2EEzPEBQnpo5w@mail.gmail.com>
 <AM0PR04MB47239379BDB27553EB5D1E30D4929@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <CACGkMEvOcaRB4eUOUy=GzuGnfeba3wWHWFDNdOgxXVbqyX+wkA@mail.gmail.com>
 <AM0PR04MB4723EA323FFB308A290725FFD4939@AM0PR04MB4723.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4723EA323FFB308A290725FFD4939@AM0PR04MB4723.eurprd04.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Apr 2023 09:53:35 +0800
Message-ID: <CACGkMEsFVidKuqmKghZyQv=YnmcfaUt=ZFwv3Wf=MXs0ypCggA@mail.gmail.com>
Subject: Re: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ state
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBBcHIgNCwgMjAyMyBhdCAzOjM14oCvUE0gQWx2YXJvIEthcnN6IDxhbHZhcm8ua2Fy
c3pAc29saWQtcnVuLmNvbT4gd3JvdGU6Cj4KPiA+ID4gU28gaXQgd2lsbCBhcnJpdmUgdG8gdGhl
IHBjaSBzdWJzeXN0ZW0gaW4gcHJvZ3JhbSBvcmRlciwgYnV0IHRoZSBwY2kgc3Vic3lzdGVtIG1h
eSByZW9yZGVyLCByaWdodD8KPiA+Cj4gPiBUaGlzIGlzIG5vdCB3aGF0IEkgcmVhZCBmcm9tIHRo
ZSBhYm92ZSBkb2MuIEl0IHNhaWQgInRvIGEgcGFydGljdWxhcgo+ID4gZGV2aWNlIHdpbGwgYXJy
aXZlIGluIHByb2dyYW0gb3JkZXIiLgo+Cj4gSW4gdGhpcyBjYXNlLCBJIGNhbiBqdXN0IHJlbW92
ZSB0aGUgd21iIGFuZCB0aGF0J3MgaXQsIHJpZ2h0PwoKQnV0IHdobyBvciBob3cgdG8gcHJldmVu
dCB0aGUgcHJlZW1wdGlvbj8KClRoYW5rcwoKPgo+IFRoYW5rcwo+Cj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
