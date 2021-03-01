Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA30C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 15:51:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBCC64DDF
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 15:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBCC64DDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7801260683;
	Mon,  1 Mar 2021 15:51:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8P-NonRq7lk; Mon,  1 Mar 2021 15:51:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14C1060677;
	Mon,  1 Mar 2021 15:51:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E76EAC000B;
	Mon,  1 Mar 2021 15:51:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4BE0C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:51:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9394283D40
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:51:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ge4pCoMdyf65
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:51:42 +0000 (UTC)
X-Greylist: delayed 00:05:10 by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6124883C54
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:51:42 +0000 (UTC)
Received: from mail-oo1-f48.google.com ([209.85.161.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MFKX3-1l17hT2ZeD-00Flbm for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Mar 2021 16:46:26 +0100
Received: by mail-oo1-f48.google.com with SMTP id x19so4044389ooj.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Mar 2021 07:46:26 -0800 (PST)
X-Gm-Message-State: AOAM533FUsXQ1QK2x5CIcgShSNY0nngQnm3+H48HRIT1ll8yKst9MWif
 uvqshCa1H/NcVWcs7XcD7yF4qH+Cy+q5382rTqI=
X-Google-Smtp-Source: ABdhPJw0OM1qORDnXV+EKE2QP/KObZBe+Vec/OkUJU8Ke2XG/5KY1Nlmlqd3W8x9whtxHu0HY7uuwZ88TRZ7BZlo1Jw=
X-Received: by 2002:a4a:304a:: with SMTP id z10mr13363525ooz.26.1614613584991; 
 Mon, 01 Mar 2021 07:46:24 -0800 (PST)
MIME-Version: 1.0
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <20210301115441.a4s5xzwm6d6ohz7f@vireshk-i7>
 <YDzZdc9+6hEvIDS1@smile.fi.intel.com>
 <YDzZocYCA8UC1FCW@smile.fi.intel.com>
In-Reply-To: <YDzZocYCA8UC1FCW@smile.fi.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 1 Mar 2021 16:46:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1g_UXKVnDfDEfj=swqgUNb+bu+1O7mDMfCt55o0w0jxw@mail.gmail.com>
Message-ID: <CAK8P3a1g_UXKVnDfDEfj=swqgUNb+bu+1O7mDMfCt55o0w0jxw@mail.gmail.com>
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Provags-ID: V03:K1:NkCRrSmTQv1FFWrqdwWBJLmG6rouSEhPo+nIdn0kDqsTnLBUHJe
 p+DER/p5fGKC/tYFcgUzyZ8jpf29/PQVoWBgXi5zmoSFKECYlwV0AUUKX3Oflbv04sQQC58
 lUFNRDApBRYa/lKwP+gSYRDuMrBfeJJr0dZGNEdqpZrmTaFCSLWSwUzpH6bA9+LkQ9k/9KB
 cN50ohULhSan6o+vQ2J+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MnyFKrelTGs=:Eot6P2lnWxLpFasAGR241J
 7BtXMVbJqXH9RSdin6ojVXlBl99G5cBPVKj5wX+VkJBg5QOYxBTuOYOVoafQq1rkz5g9NIBda
 iJHwrTriBtZgo+kRzTYN+hF8QSOQ52cFHBZ1WXabfxy6imkf7RXgkBd0F6AgnjuQMugxWwl6+
 9F7Flz1OIrAb7jEyI2G4QBzEHIpPbzKG3sST9F2xGCDT2mD+3feySwvNgjQIU4+5E6JCfabKp
 Jq+/kVOZ5WIvvgIh7VGypKv2arCe76lyel5rqalHLyou2ThgkjAPYrf5M5R1f1u+dgroXqI4L
 zzDpjHMxYBniue+iQTasghZhLBRYqSUYxOrwFXoYmMF0Mfs0369dyO/EvAjU6Qpk1zEsG43Xd
 Sxgriwxdv2fqu6fIhCQjtChHfZBUiSiwUra0ZJ1KUGLm0fyA/ewhz/5njkwmCLAWINyzVefpG
 3nzKCNf/M7R5E8FlyyMauwLUgwOoaVya35dWtmbJeeIeyE/9aKG16aWN7dEX5qb6aRDvqSLCm
 o16vGnXUSKu4vrbdMiXe8qhNkQVUTHuu0L73vTs2jYVxsKZr5f0E9hWDHv6iti6pzFPKuTtGG
 OaVKL5AZVyTiyDI8RgLRqCeOtmy5TTyrvy
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 shuo.a.liu@intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, Tali Perry <tali.perry1@gmail.com>,
 conghui.chen@intel.com, Mike Rapoport <rppt@kernel.org>, yu1.wang@intel.com
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

T24gTW9uLCBNYXIgMSwgMjAyMSBhdCAxOjEwIFBNIEFuZHkgU2hldmNoZW5rbwo8YW5kcml5LnNo
ZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3cm90ZToKPiBPbiBNb24sIE1hciAwMSwgMjAyMSBh
dCAwMjowOToyNVBNICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4gPiBPbiBNb24sIE1h
ciAwMSwgMjAyMSBhdCAwNToyNDo0MVBNICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6Cj4gPiA+
IE9uIDAxLTAzLTIxLCAxNDo0MSwgSmllIERlbmcgd3JvdGU6Cj4gPiA+ID4gKy8qKgo+ID4gPiA+
ICsgKiBzdHJ1Y3QgdmlydGlvX2kyY19yZXEgLSB0aGUgdmlydGlvIEkyQyByZXF1ZXN0IHN0cnVj
dHVyZQo+ID4gPiA+ICsgKiBAb3V0X2hkcjogdGhlIE9VVCBoZWFkZXIgb2YgdGhlIHZpcnRpbyBJ
MkMgbWVzc2FnZQo+ID4gPiA+ICsgKiBAd3JpdGVfYnVmOiBjb250YWlucyBvbmUgSTJDIHNlZ21l
bnQgYmVpbmcgd3JpdHRlbiB0byB0aGUgZGV2aWNlCj4gPiA+ID4gKyAqIEByZWFkX2J1ZjogY29u
dGFpbnMgb25lIEkyQyBzZWdtZW50IGJlaW5nIHJlYWQgZnJvbSB0aGUgZGV2aWNlCj4gPiA+ID4g
KyAqIEBpbl9oZHI6IHRoZSBJTiBoZWFkZXIgb2YgdGhlIHZpcnRpbyBJMkMgbWVzc2FnZQo+ID4g
PiA+ICsgKi8KPiA+ID4gPiArc3RydWN0IHZpcnRpb19pMmNfcmVxIHsKPiA+ID4gPiArIHN0cnVj
dCB2aXJ0aW9faTJjX291dF9oZHIgb3V0X2hkcjsKPiA+ID4gPiArIHU4ICp3cml0ZV9idWY7Cj4g
PiA+ID4gKyB1OCAqcmVhZF9idWY7Cj4gPiA+ID4gKyBzdHJ1Y3QgdmlydGlvX2kyY19pbl9oZHIg
aW5faGRyOwo+ID4gPiA+ICt9Owo+ID4gPgo+ID4gPiBJIGFtIG5vdCBhYmxlIHRvIGFwcHJlY2lh
dGUgdGhlIHVzZSBvZiB3cml0ZS9yZWFkIGJ1ZnMgaGVyZSBhcyB3ZQo+ID4gPiBhcmVuJ3QgdHJ5
aW5nIHRvIHJlYWQvd3JpdGUgZGF0YSBpbiB0aGUgc2FtZSB0cmFuc2FjdGlvbi4gV2h5IGRvIHdl
Cj4gPiA+IGhhdmUgdHdvIGJ1ZnMgaGVyZSBhcyB3ZWxsIGFzIGluIHNwZWNzID8KPiA+Cj4gPiBJ
5raOIGFuZCBTTUJ1cyBzdXBwb3J0IGJpZGlyZWN0aW9uYWwgdHJhbnNmZXJzIGFzIHdlbGwuIEkg
dGhpbmsgdHdvIGJ1ZmZlcnMgaXMKPiA+IHRoZSByaWdodCB0aGluZyB0byBkby4KPgo+IFN0cmlj
dGx5IHNwZWFraW5nICJoYWxmIGR1cGxleCIuCgpCdXQgdGhlIGRyaXZlciBkb2VzIG5vdCBzdXBw
b3J0IHRoaXMgYXQgYWxsOiB0aGUgc2dsaXN0IGFsd2F5cyBoYXMgdGhyZWUKbWVtYmVycyBhcyBW
aXJlc2ggc2F5czogb3V0aGRyLCBtc2didWYgYW5kIGluaGRyLiBJdCB0aGVuIHVzZXMgYQpib3Vu
Y2UgYnVmZmVyIGZvciB0aGUgYWN0dWFsIGRhdGEgdHJhbnNmZXIsIGFuZCB0aGlzIGFsd2F5cyBn
b2VzIGVpdGhlcgpvbmUgd2F5IG9yIHRoZSBvdGhlci4KCkkgdGhpbmsgdGhlIG1vcmUgaW1wb3J0
YW50IHF1ZXN0aW9uIGlzOiBkb2VzIHRoaXMgZHJpdmVyIGFjdHVhbGx5IG5lZWQKdGhlIGJvdW5j
ZSBidWZmZXI/IEl0IGRvZXNuJ3QgaGF2ZSB0byB3b3JyeSBhYm91dCBhZGphY2VudCBzdGFjawpk
YXRhIGJlaW5nIGNsb2JiZXJlZCBieSBjYWNoZSBtYWludGVuYW5jZSBiZWNhdXNlIHZpcnRpbyBp
cyBhbHdheXMKY2FjaGUgY29oZXJlbnQgYW5kLCBzbyBJIHN1c3BlY3QgdGhlIGJvdW5jZSBidWZm
ZXIgY2FuIGJlIGxlZnQgb3V0LgoKSXQgbWlnaHQgYWN0dWFsbHkgYmUgc2ltcGxlciB0byBqdXN0
IGhhdmUgYSBmaXhlZC1sZW5ndGggYXJyYXkgb2YKaGVhZGVycyBvbiB0aGUgc3RhY2sgYW5kIGF0
IG1vc3QgdGhlIGNvcnJlc3BvbmRpbmcgbnVtYmVyIG9mCnRyYW5zZmVycyBmb3Igb25lIHZpcnRx
dWV1ZV9raWNrKCkuCgpJcyB0aGVyZSBhIHJlYXNvbmFibGUgbGltaXQgb24gaG93IG1hbnkgdHJh
bnNmZXJzIHdlIHdvdWxkCmV4cGVjdCB0byBoYW5kbGUgYXQgb25jZT8gSSBzZWUgdGhhdCBtb3N0
IGNhbGxlcnMgb2YgaTJjX3RyYW5zZmVyKCkKaGFyZGNvZGUgdGhlIG51bWJlciB0byAnMScgb3Ig
JzInLCByYXJlbHkgJzMnIG9yICc0Jywgd2hpbGUgdGhlIHByb3Bvc2VkCmltcGxlbWVudGF0aW9u
IHNlZW1zIHRvIGJlIG9wdGltaXplZCBmb3IgbXVjaCBsYXJnZXIgbnVtYmVycy4KCiAgICAgICBB
cm5kCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
