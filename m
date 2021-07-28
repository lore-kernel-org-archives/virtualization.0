Return-Path: <SRS0=JFNa=MU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B18BC4338F
	for <virtualization@archiver.kernel.org>; Wed, 28 Jul 2021 07:25:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3862560F9C
	for <virtualization@archiver.kernel.org>; Wed, 28 Jul 2021 07:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3862560F9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3C8F402E2;
	Wed, 28 Jul 2021 07:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rPcSXPm_cOR7; Wed, 28 Jul 2021 07:25:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9BBC740297;
	Wed, 28 Jul 2021 07:25:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CC41C0010;
	Wed, 28 Jul 2021 07:25:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C82F9C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 07:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A2354402E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 07:25:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bJjYof5OXC59
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 07:25:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88F0840297
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 07:25:35 +0000 (UTC)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQNF3-1mUSBo29oX-00MIOw for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 09:25:33 +0200
Received: by mail-wr1-f48.google.com with SMTP id e2so1261942wrq.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 00:25:33 -0700 (PDT)
X-Gm-Message-State: AOAM530FFzM76bKd2hnr07KGeu3Ste4HVSUsjiY+RvXUZvNe7KcPWcIh
 2kRyI5kWD+274XRGs6jC8jbiwkGZzRTAIEWJ2XY=
X-Google-Smtp-Source: ABdhPJxRtBMlwAWq2x2oW4ouDDNGxilMuC5slRThWpCJx/8ezTD4ks0L6nleI6zL5AuFJ1FQqnpb2Wkpoc+jh716+ts=
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr19772907wrr.286.1627457132895; 
 Wed, 28 Jul 2021 00:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
 <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
 <be29127d-8cec-c7b8-ac96-4da94198dc03@linux.alibaba.com>
In-Reply-To: <be29127d-8cec-c7b8-ac96-4da94198dc03@linux.alibaba.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Jul 2021 09:25:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1O02Ho2dM3F+bUXf9Ze8uRKYzY5fFmRGpszUXg_nrH4w@mail.gmail.com>
Message-ID: <CAK8P3a1O02Ho2dM3F+bUXf9Ze8uRKYzY5fFmRGpszUXg_nrH4w@mail.gmail.com>
Subject: Re: [PATCH] virtio-console: avoid DMA from vmalloc area
To: Xianting Tian <xianting.tian@linux.alibaba.com>
X-Provags-ID: V03:K1:QIwJevY6ZWUPgRd0R4KrgyoM62n9HWxR2tI3qgQhSyY3AHRPiWT
 awWYdFeEpuFn3kJJ0j01qkKwMyR+FsFsO+nDJt/O0xLYTJJ0BAQz8eZpaosrV/cbRqmEmlP
 xJ9dfGT/cKL/Nncty/6m+jreiXVHPqBYvEajjcE7WA9k4hiGdzXJ6DQKxmss4fa/aLXR5Ey
 dIAw4CRVg7XJPQGYaOaUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1xTGo5jXeHE=:ieJTL3IfwY+PtTiF14EhGO
 LOXpUl3qI+w2+YwMwsYm7Y6j9EdAqNGtCWKqvBw2KrcAx3AsoKZn3pIV+OQdyUVIoF4UR5/fs
 tRgtp0lqskcvcBJzNSpR/S6J2A/XL04KlW4A/xo8fw/CO3wPasw00eSHeoW90Nmpw7ToBToHZ
 UiXspaKQVBZBRvFCJ7tEKtqf4fIOFEuEL9QoXw9SSrCrABn1lgIiA0SU5/PetZkxOVFDyboW0
 W7dIupizuzqSS9vAnXhfmDmrEnZBl3WNzTMx+M/hKDelprBWBDgix2ShvYAjykQGq5NENzuDS
 v7WtRa7MH4yNFMp//SrJWMMDumTc4SNuMKQ6ouEH7oGWDAtsGTezmGOQ4eK7gb8kTINkJmAnh
 bY20NUm6CRlp7Mg07+rKh1V5y6Qhme9eVTIC4rU6pDX0J9tKpvQpDdaPlqH5MTGv/o5pJPRst
 yqnOtruDojcHNVfKLOvElFcV2lqzIxvuKzfdsN/DRiUlLK3rrKi5ERnKMQRMGKY/mUGpnNMaX
 vVBW4CGtk1HL7Dq+m+KufJ+Yd9tO2dDJJUJfbdcUOOjcZiysdnBVT/ohqv/fOQAtpyeWJZ3WU
 hs/Ob6Q1rCj8uKRAi+oW3/3RbIrpTI1AFECWd9PjDkg7SI5MDw2aLNzxF2yroiQMrVU1uWhB7
 PXCYrjxXpugt5kiCTEaUQPh5ow4zsJboONszOXMsp1YhSKRq5LlbI61RsJg6xLHoGCdpVazsk
 zDUZmyF/xDcmHHUGwblbGhxuXr6G5m+RSJSMs6CMeCookAQxuUnkpK8Jj4VQkq1KJMsSGYuNn
 QZHv+t/YZjn0uz6ZCpqyWLTe00UsPPY7AXvU7w8YB2FFuGrhCMoX8/wX7yb2uE6w3A+dQAj8G
 KPu7Nhav7jKAk/l2fRX/hNGYMKTNp5V/m2vVC7sTfoOO/DnekDiV/mwItgx03lZGkHSgVAN/I
 zllgAA2OlZ/3bLVgdqiP5jKi25ngo5yogikhmkFkgSbluR5R/0YMv
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 gregkh <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, Omar Sandoval <osandov@fb.com>
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

T24gV2VkLCBKdWwgMjgsIDIwMjEgYXQgNDo1OSBBTSBYaWFudGluZyBUaWFuCjx4aWFudGluZy50
aWFuQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IEFybmQsIHRoYW5rcyBmb3IgeW91ciBx
dWljayByZXBseSwKPgo+IEFzIHdlIGtub3cgcHV0X2NoYXJzKCkgb2YgdmlydGlvLWNvbnNvbGUg
aXMgcmVnaXN0ZXJlZCB0byBodmMgZnJhbWV3b3JrLgo+IEkgZ28gdGhyb3VnaGVkIHRoZSBjb2Rl
LCBhY3R1YWxseSB0aGVyZSBhcmUgdG90YWxseSB0aHJlZSBwbGFjZXMgdGhhdAo+IHB1dF9jaGFy
cygpIGlzIGNhbGxlZCBpbiBodmMgZHJpdmVyLCAgYnV0IG9ubHkgMSBoYXMgaXNzdWUgd2hpY2gg
aXMKPiBmaXhlZCBieSBjb21taXQgYzRiYWFkNTAyOS4KCkFoLCBnb29kLiBLbm93aW5nIHdoYXQg
dGhlIGNhbGxlcnMgYXJlIGRlZmluaXRlbHkgaGVscHMuIDstKQoKPiBTbyBJIHRoaW5rIHRoZSBz
Y2VuYXJpbyB0aGF0IHRoZSBidWYgaXMgZnJvbSAiaW9yZW1hcCgpLCBrbWFwX2F0b21pYygpICwK
PiBmaXhtYXAsIGxvYWRhYmxlIG1vZHVsZSIgZG9lc24ndCBleGlzdCBmb3IgdmlydGlvLWNvbnNv
bGUuCj4gSWYgdGhlcmUgaXMgc29tZXRoaW5nIHdyb25nIGFib3V0IGFib3ZlIGRlc2NyaXB0aW9u
LCBwbGVhc2UgY29ycmVjdCBtZSwKPiB0aGFua3MuCgpUaGUgZGVzY3JpcHRpb24gaXMgZ29vZCB0
aGVuLgoKPiBUaHJlZSBwbGFjZXMgdGhhdCBwdXRfY2hhcnMoKSBpcyBjYWxsZWQgaW4gaHZjIGRy
aXZlcjoKPiAx77yMIGl0IGlzIG9uIHN0YWNrIGJ1ZiwgIGl0IGlzIG5vdCBvayBmb3IgZG1hCj4g
ICAgICBodmNfY29uc29sZV9wcmludCgpOgo+ICAgICAgICAgIGNoYXIgY1tOX09VVEJVRl0gX19B
TElHTkVEX187Cj4gICAgICAgICAgY29uc19vcHNbaW5kZXhdLT5wdXRfY2hhcnModnRlcm1ub3Nb
aW5kZXhdLCBjLCBpKTsKPgo+IDLvvIwganVzdCBvbmUgYnl0ZSwgbm8gaXNzdWUgZm9yIGRtYQo+
ICAgICAgc3RhdGljIHZvaWQgaHZjX3BvbGxfcHV0X2NoYXIoc3RydWN0IHR0eV9kcml2ZXIgKmRy
aXZlciwgaW50IGxpbmUsCj4gY2hhciBjaCkKPiAgICAgIHsKPiAgICAgICAgICBzdHJ1Y3QgdHR5
X3N0cnVjdCAqdHR5ID0gZHJpdmVyLT50dHlzWzBdOwo+ICAgICAgICAgIHN0cnVjdCBodmNfc3Ry
dWN0ICpocCA9IHR0eS0+ZHJpdmVyX2RhdGE7Cj4gICAgICAgICAgaW50IG47Cj4KPiAgICAgICAg
ICBkbyB7Cj4gICAgICAgICAgICAgIG4gPSBocC0+b3BzLT5wdXRfY2hhcnMoaHAtPnZ0ZXJtbm8s
ICZjaCwgMSk7Cj4gICAgICAgICAgfSB3aGlsZSAobiA8PSAwKTsKPiAgICAgIH0KClRoaXMgaXMg
YWN0dWFsbHkgdGhlIHNhbWUgYXMgdGhlIGZpcnN0LCB0YWtpbmcgdGhlIGFkZHJlc3Mgb2YgYQpm
dW5jdGlvbiBhcmd1bWVudCBmb3JjZXMgaXQgb250byB0aGUgc3RhY2suCgo+IDMsICBocC0+b3V0
YnVmIGlzIGFsbG9jYXRlZCBpbiBodmNfYWxsb2MoKSB2aWEga3phbGxvYygpLCBubyBpc3N1ZSBm
b3IgZG1hCj4gICAgICBzdGF0aWMgaW50IGh2Y19wdXNoKHN0cnVjdCBodmNfc3RydWN0ICpocCkK
PiAgICAgIHsKPiAgICAgICAgICBpbnQgbjsKPgo+ICAgICAgICAgIG4gPSBocC0+b3BzLT5wdXRf
Y2hhcnMoaHAtPnZ0ZXJtbm8sIGhwLT5vdXRidWYsIGhwLT5uX291dGJ1Zik7Cj4gICAgICAgICAg
4oCmCj4gICAgICB9Cgpvay4KCkkgaGF2ZSBhIG5ldyBxdWVzdGlvbiB0aGVuOiBhcmUgdGhlcmUg
YW55IG90aGVyIGh2YyBiYWNrZW5kcyB0aGF0IGRvCkRNQSwgb3IgaXMgdGhlIHZpcnRpby1jb25z
b2xlIGRyaXZlciB0aGUgb25seSBvbmU/IElmIHRoZXJlIGFyZSBhbnkgb3RoZXJzLApJIHRoaW5r
IHRoaXMgc2hvdWxkIGJldHRlciBiZSBmaXhlZCBpbiB0aGUgaHZjIGZyYW1ld29yaywgYnkgY2hh
bmdpbmcgaXQKdG8gbmV2ZXIgcGFzcyBzdGFjayBkYXRhIGludG8gdGhlIHB1dF9jaGFycygpIGZ1
bmN0aW9uIGluIHRoZSBmaXJzdCBwbGFjZS4KCkl0IG1heSBiZSBwb3NzaWJsZSB0byBqdXN0IHVz
ZSB0aGUgJ2hwLT5uX291dGJ1ZicgYnVmZmVyIGluIGFsbCB0aHJlZSBjYXNlcy4KCiAgICAgICBB
cm5kCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
