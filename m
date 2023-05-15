Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2650DC77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 22:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AC124162C;
	Mon, 15 May 2023 22:55:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AC124162C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=QzhLLxSL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AhD-nkT7NPTk; Mon, 15 May 2023 22:55:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C6C8C416AA;
	Mon, 15 May 2023 22:55:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6C8C416AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86C0BC0037;
	Mon, 15 May 2023 22:55:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C09BC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 22:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4F1F4161C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 22:55:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4F1F4161C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kF1OCf4BDGHV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 22:55:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C3454161B
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C3454161B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 22:55:09 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-50bc456cc39so19689614a12.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1684191307; x=1686783307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10cFuMF+WVG9ce0NQecfKwGM15VTiPed2+yziwbzR84=;
 b=QzhLLxSLDSOm8zn3F9vU02nreJUjrm5+t1iiVT3ONXuaNIkDnlnX8jS46D8RS2fb9O
 tRv76mvChW792PvAArgkudclcTcPQJTe3O1cJNYlcmmslb1rDJq3bNDLoLivNWT5LjYG
 SHAD7BkznDtm8AWE53Kf/MkPoh+F832/g1M3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684191307; x=1686783307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=10cFuMF+WVG9ce0NQecfKwGM15VTiPed2+yziwbzR84=;
 b=BYwkYv13n8Zl/A+CuI54ZOTdznjx5eVX6P0+Hrzk9d1DRIilK2zSLPhzhtWDgKrFEH
 sTOdPpYZNg0HJHdFN4N0bJaGSxHksubOq3bzSmF9kjGWAea/euOZrRpidIuRaP0cmpZZ
 /VxPWUNHe7JkpeGqgj7fE+Uy8fxNn7fnuHfQL/WAkYsi3kU5VwW39iBKe2QtxKuEJet0
 8RKA2JoNrhYed+eb9sFVaWUJfLtXCrahiDbDAdJsFxnfmkoHbP832gJmnaN3/LcBbs/0
 4D7zeQwjDq3B8uPqx/3MDLbqn1SokU2FD0wBUNpHCoJKFbERcO5MJkGB1ynOJaVUuOnY
 DE0Q==
X-Gm-Message-State: AC+VfDxQ+eO/naiTcd4Sv2tHuId2kr5TGz0olH62vNJJ4cQOa+vepgzC
 uAaPHLDd5fX8mU6+V3TJjryNlZmtOnd0q57cDEsZPrJTH0E=
X-Google-Smtp-Source: ACHHUZ5qvfC58WIz9W4mbPfVxdIYcJ8ryxzLgcn4GqedtU9sD62W/XMJT+IFYM//EzlwmCSHGN0vZw==
X-Received: by 2002:a17:906:da8e:b0:94f:7c4e:24ea with SMTP id
 xh14-20020a170906da8e00b0094f7c4e24eamr29806049ejb.38.1684191307054; 
 Mon, 15 May 2023 15:55:07 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com.
 [209.85.218.49]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa7c695000000b0050bdd7fafd8sm7792281edq.29.2023.05.15.15.55.06
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 15:55:06 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-965ab8ed1c0so2245919566b.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:55:06 -0700 (PDT)
X-Received: by 2002:a17:907:6d8e:b0:966:5c04:2c61 with SMTP id
 sb14-20020a1709076d8e00b009665c042c61mr26963047ejc.8.1684191305862; Mon, 15
 May 2023 15:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
In-Reply-To: <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 May 2023 15:54:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
Message-ID: <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To: Mike Christie <michael.christie@oracle.com>,
 Oleg Nesterov <oleg@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, nicolas.dichtel@6wind.com
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

T24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgMzoyM+KAr1BNIE1pa2UgQ2hyaXN0aWUKPG1pY2hhZWwu
Y2hyaXN0aWVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBUaGUgdmhvc3QgbGF5ZXIgcmVhbGx5IGRv
ZXNuJ3Qgd2FudCBhbnkgc2lnbmFscyBhbmQgd2FudHMgdG8gd29yayBsaWtlIGt0aHJlYWRzCj4g
Zm9yIHRoYXQgY2FzZS4gVG8gbWFrZSBpdCByZWFsbHkgc2ltcGxlIGNhbiB3ZSBkbyBzb21ldGhp
bmcgbGlrZSB0aGlzIHdoZXJlIGl0Cj4gc2VwYXJhdGVzIHVzZXIgYW5kIGlvIHdvcmtlciBiZWhh
dmlvciB3aGVyZSB0aGUgbWFqb3IgZGlmZiBpcyBob3cgdGhleSBoYW5kbGUKPiBzaWduYWxzIGFu
ZCBleGl0LiBJIGFsc28gaW5jbHVkZWQgYSBmaXggZm9yIHRoZSBmcmVlemUgY2FzZToKCkkgZG9u
J3QgbG92ZSB0aGUgU0lHS0lMTCBzcGVjaWFsIGNhc2UsIGJ1dCBJIGFsc28gZG9uJ3QgZmluZCB0
aGlzCmRlZXBseSBvZmZlbnNpdmUuIFNvIGlmIHRoaXMgaXMgd2hhdCBpdCB0YWtlcywgSSdtIG9r
IHdpdGggaXQuCgpJIHdvbmRlciBpZiB3ZSBjb3VsZCBtYWtlIHRoYXQgc3BlY2lhbCBjYXNlIHNp
bXBseSBjaGVjayBmb3IgImlzClNJR0tJTEwgYmxvY2tlZCIgaW5zdGVhZD8gTm8gbm9ybWFsIGNh
c2Ugd2lsbCBjYXVzZSB0aGF0LCBhbmQgaXQgbWVhbnMKdGhhdCBhIFBGX1VTRVJfV09SS0VSIHRo
cmVhZCBjb3VsZCBkZWNpZGUgcGVyLXRocmVhZCB3aGF0IGl0IHdhbnRzIHRvCmRvIHdydCBTSUdL
SUxMLgoKQ2hyaXN0aWFuPyBBbmQgSSBndWVzcyB3ZSBzaG91bGQgQ2M6IE9sZWcgdG9vLCBzaW5j
ZSB0aGUgc2lnbmFsIHBhcnRzCmFyZSBhbiBhcmVhIGhlJ3MgZmFtaWxpYXIgd2l0aCBhbmQgaGFz
IHdvcmtlZCBvbi4uIEVyaWMgQmllZGVybWFuIGhhcwphbHJlYWR5IGJlZW4gb24gdGhlIGxpc3Qg
YW5kIGhhcyBhbHNvIGJlZW4gaW52b2x2ZWQKCk9sZWc6IHNlZQoKICBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzEyMmI1OTdlLWE1ZmEtZGFmNy0yN2JiLTZmMDRmYTk4ZDQ5NkBvcmFjbGUu
Y29tLwoKZm9yIHRoZSBjb250ZXh0IGhlcmUuCgogICAgICAgICAgICAgIExpbnVzCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
