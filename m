Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B14C433E0
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 07:53:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB8864E67
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 07:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB8864E67
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42A524891B;
	Mon, 15 Mar 2021 07:53:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dikWEplMaKMG; Mon, 15 Mar 2021 07:53:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id D654F483DE;
	Mon, 15 Mar 2021 07:53:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B10E9C000A;
	Mon, 15 Mar 2021 07:53:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE55BC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 07:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C7B140146
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 07:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oimDP1yF77Uu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 07:53:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6798A4013F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 07:53:14 +0000 (UTC)
Received: from mail-oi1-f172.google.com ([209.85.167.172]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MEmMt-1lVuNI2w9r-00GEV5 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 08:53:11 +0100
Received: by mail-oi1-f172.google.com with SMTP id u6so26278067oic.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 00:53:11 -0700 (PDT)
X-Gm-Message-State: AOAM53248SvQaw3vF6iIZfeePTAc1ZXSH5wxx8XpQQE6UI+C1ReWz+PR
 AVc2NhJHJLe10+XN9TXMhNYMuVM+FPSHTUXaubI=
X-Google-Smtp-Source: ABdhPJxqDGNRsuLazrikYSqY8ylkAVcvSJoIRj7d/B6mgsATUAgDvUWymXPVOUo2C8fqtGFewM/hJKdAajbaWjVXu4k=
X-Received: by 2002:a05:6808:313:: with SMTP id
 i19mr8744619oie.67.1615794790530; 
 Mon, 15 Mar 2021 00:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <cd3b0c9138824b0a5fad9d3bc872d8836e829946.1615554673.git.jie.deng@intel.com>
 <CAK8P3a0zQG3pH91emqAUsaRx4AZeuOEvSrPzXP9w_XhjU6w3ng@mail.gmail.com>
 <8070f03d-8233-636b-5ea9-395e723f7a2c@intel.com>
 <503b88c9-1e82-a3a3-0536-d710ddc834a5@redhat.com>
 <e388b344-a815-aed3-c076-3651b18c39d1@intel.com>
In-Reply-To: <e388b344-a815-aed3-c076-3651b18c39d1@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 15 Mar 2021 08:52:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0LjcSs7gvU-jRdZJCFrfxQcSUWqL_fgH_71VjC027M0w@mail.gmail.com>
Message-ID: <CAK8P3a0LjcSs7gvU-jRdZJCFrfxQcSUWqL_fgH_71VjC027M0w@mail.gmail.com>
Subject: Re: [PATCH v7] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>
X-Provags-ID: V03:K1:kFw70mkU9xiSbjKuKP8HDte3bjUg63D5MSUMC89iOWRk7aSz58y
 d+RAiVbc8j8wWNO0cHjUN63rUcEG1GPNLJydQ5vMmX8q5NPy7FLxdCEfsgBQPiq9l8sNPlw
 5T7BmHF4HRqM9+scvL/ND3vHgyJffzbB4zWe0LHNRah9GT3J+lwz1wAdRPTLV8KpVpsZxYb
 daoZL4mijPE4VdPwM3SZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cUWitUD7iYE=:dQV3VpaLtCKGa47YH6rkui
 iOJUn6N0MC8bYFOegAKZ5dA4bW2FRacfZL5+T3F+zTMYEa57Q8RTeqleTbQQn7A7MqkGPilt5
 gMuGUQ7Fn0Irmgi5SMv7epPQdtzhQtZa1qZSxt9DGvg5KbAeWGjW5S0zHH04lhB1KXk7cf1nA
 OtR2YaqqllXa3Zuhlp7BIt4zyOgni3ezAMntGnL1OU0harTWyAW3jSukDsrMpDstydVGYQrMF
 UYR8j48WSNQNQHubCgz4RpCoMIn7YIFFlMO7ll57aTKVm0OUfvrsR1hjpnnHhevr+CYECPVbJ
 6TgI2yxnxeXHYnrpBw01LIyAa1QRLf7LS5FvktFB6EBKtkgqvVosgHB+w9yH6GKon49vO54wK
 sDsX345mqfBRf5f1YhSTNilaC2t1vrgmvWUX+FTBF7CExqO5EYOV6LCrRIMmWaCxzH/87s808
 S3L7lIb7m7gRH+2FGRg4GtPFEQ/GjsriAubnFmbUk/MFM8otfEGwqNz+Zp3LQYSQ27wh4kYxJ
 RilSA+uMHheOYIG9MtTEkTXK6ToJ9P7syYeobzgeDcy
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, yu1.wang@intel.com,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Tali Perry <tali.perry1@gmail.com>,
 conghui.chen@intel.com, loic.poulain@linaro.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 jarkko.nikula@linux.intel.com, shuo.a.liu@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>
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

T24gTW9uLCBNYXIgMTUsIDIwMjEgYXQgNjo1NCBBTSBKaWUgRGVuZyA8amllLmRlbmdAaW50ZWwu
Y29tPiB3cm90ZToKPiBPbiAyMDIxLzMvMTUgMTE6MTMsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBP
biAyMDIxLzMvMTUgOToxNCDkuIrljYgsIEppZSBEZW5nIHdyb3RlOgo+ID4+IE9uIDIwMjEvMy8x
MiAxNjo1OCwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiA+Cj4gVGhlbiBkbyB5b3UgdGhpbmsgaXQg
aXMgbmVjZXNzYXJ5IHRvIG1hcmsgdGhlIHZpcnRpbyBidWZzIHdpdGgKPiBfX19fY2FjaGVsaW5l
X2FsaWduZWQgPwoKSSB0aGluayBzbywgeWVzLgoKPiBJIGhhdmVuJ3Qgc2VlbiBhbnkgdmlydGlv
IGludGVyZmFjZSBiZWluZyBtYXJrZWQgeWV0LiBJZiB0aGlzIGlzIGEKPiBwcm9ibGVtLCBJIGJl
bGlldmUgaXQgc2hvdWxkICBiZSBjb21tb24gZm9yIGFsbCB2aXJ0aW8gZGV2aWNlcywgcmlnaHQg
PwoKWWVzLCBidXQgaXQncyBub3QgYSBwcm9ibGVtIGlmIHRoZSBidWZmZXJzIGFyZSBhbGxvY2F0
ZWQgc2VwYXJhdGVseQpiZWNhdXNlIGttYWxsb2MgcHJvdmluY2VzIGEgY2FjaGVsaW5lbiBhbGln
bmVkIGJ1ZmZlciBvbiBhcmNoaXRlY3R1cmVzCnRoYXQgbmVlZCBpdC4KCkl0J3Mgb25seSBhIHBy
b2JsZW0gaGVyZSBiZWNhdXNlIHRoZXJlIGlzIGEgc2luZ2xlIGFsbG9jYXRpb24gZm9yIHRocmVl
Cm9iamVjdHMgdGhhdCBoYXZlIGRpZmZlcmVudCBvd25lcnNoaXAgc3RhdGVzIGR1cmluZyB0aGUg
RE1BIChkZXZpY2UKb3duZWQgdG8tZGV2aWNlLCBjcHUtb3duZWQsIGRldmljZSBvd25lZCB0by1j
cHUpLgoKICAgICAgIEFybmQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
