Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4102AC77B7E
	for <virtualization@archiver.kernel.org>; Sun, 28 May 2023 01:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A77EB60BE0;
	Sun, 28 May 2023 01:21:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A77EB60BE0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=HHbEpz/j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wk-uNNtfVw4h; Sun, 28 May 2023 01:21:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2976C60BF4;
	Sun, 28 May 2023 01:21:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2976C60BF4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2C72C0036;
	Sun, 28 May 2023 01:21:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17CB5C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 01:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCADD401D2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 01:21:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CCADD401D2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=HHbEpz/j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vmeGdM_JxyOq
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 01:21:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 743CB4013B
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 743CB4013B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 01:21:24 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-96f6e83e12fso326254366b.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 18:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1685236882; x=1687828882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwTMqNXJxZngfAiFWVhcJnTq6nmvJ33/9Fzz5GiyWWk=;
 b=HHbEpz/jAmDwfuSaARci7RvfCravshRPBIdiwt/tkOEUavTfRyH3qJJpR06h2YRKpF
 abH2xai5w4zSo93xD/9QD1b+zDekAa51egLJ7sCBm+8XWJhntAM3kmlSLTfPYooH6W4b
 s8J3Zhxl2GFGDtq4R0Asiq1H7dl2jdWt3rDLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685236882; x=1687828882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwTMqNXJxZngfAiFWVhcJnTq6nmvJ33/9Fzz5GiyWWk=;
 b=aUfcSrX7CbqKCd1OthX5+/g8OvhZHbTCATJt5645LHtwAtj58XK0yMTPDjGec1Zh9y
 bhDLCAtvcCpL3CUXfsrFtvf7pcPsBgsgbwwROpH8usxer/UBQJKZ37dK+CYtmGCQQtZc
 WTPFmg+cammucT4VCZqE6gTniD/4JLz+NOSeyRIZrFjdBNCyejZlBLaIPy50JVuTE0QR
 InsRhB22ZPrxeLtj8Ybhh+zHzGCP7NyVOfKgedzaiW80Bvf2svZke4QfM24s1Keu4q+d
 3hD1FoKUTe4gi89FX1FOgLIUA9Vl2wJwXHWqUMYvXjsuo20Nz/EoFzIxLiqQyGZ3IiZa
 75CQ==
X-Gm-Message-State: AC+VfDz5Jo22eg/MWfmDfF64GF5+OZJQq+XewtzKVIQ0+1IsBrMRNi5k
 q1ah602fbBeMlYXvxfnCU4I7tFM5LBoxY3fDi7/yJqf+H4k=
X-Google-Smtp-Source: ACHHUZ5MF2G4Hmf/5ZAfMg1M47OThNa6ikhQ1Wru3g4don6h63Ar/DW0c8OcIE/Plnst2q7IPUj9gw==
X-Received: by 2002:a17:907:7208:b0:971:9364:f8cd with SMTP id
 dr8-20020a170907720800b009719364f8cdmr6138577ejc.44.1685236882224; 
 Sat, 27 May 2023 18:21:22 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com.
 [209.85.218.54]) by smtp.gmail.com with ESMTPSA id
 v15-20020a170906338f00b009663cf5dc3bsm4033084eja.53.2023.05.27.18.21.20
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 May 2023 18:21:21 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-96f8d485ef3so326863166b.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 18:21:20 -0700 (PDT)
X-Received: by 2002:a17:907:2682:b0:96a:440b:d5c8 with SMTP id
 bn2-20020a170907268200b0096a440bd5c8mr5866751ejc.59.1685236880680; Sat, 27
 May 2023 18:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
 <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 May 2023 18:21:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkLs3PU+MaF67TBQpUcZZEhoc9MB0iXYamb7FDPH6mOw@mail.gmail.com>
Message-ID: <CAHk-=wjkLs3PU+MaF67TBQpUcZZEhoc9MB0iXYamb7FDPH6mOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fork,
 vhost: Use CLONE_THREAD to fix freezer/ps regression
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 stefanha@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org
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

T24gU2F0LCBNYXkgMjcsIDIwMjMgYXQgNjoxN+KAr1BNIEVyaWMgVy4gQmllZGVybWFuIDxlYmll
ZGVybUB4bWlzc2lvbi5jb20+IHdyb3RlOgo+Cj4gSXQgc2VlbXMgbGlrZSBhIGdvb2QgYXBwcm9h
Y2ggZm9yIGluY2x1ZGluZyBpbiB0aGUgLXJjIHNlcmllcy4KPiBJIHRoaW5rIHRoZSBjaGFuZ2Ug
c2hvdWxkIGxvb2sgbW9yZSBsaWtlIG15IGNoYW5nZSBiZWxvdy4KCkkgaGF2ZSBubyBvYmplY3Rp
b25zLiBNeSBwYXRjaCB3YXMgYSBmYWlybHkgImhhY2sgYW5kIHNsYXNoIiB0aGluZyB0bwpqdXN0
IGRpc2Fzc29jaWF0ZSB0aGUgSU8gd29ya2VycyBlbnRpcmVseSBmcm9tIHRoZSBjb3JlIGR1bXBp
bmcuIFlvdXJzCnNlZW1zIHRvIGJlIHNsaWdodGx5IG1vcmUgc3VyZ2ljYWwuCgogICAgICAgICAg
ICAgICAgICBMaW51cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
