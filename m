Return-Path: <SRS0=SGc/=MY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347ADC4338F
	for <virtualization@archiver.kernel.org>; Sun,  1 Aug 2021 09:24:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C554661058
	for <virtualization@archiver.kernel.org>; Sun,  1 Aug 2021 09:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C554661058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89AC983C97;
	Sun,  1 Aug 2021 09:24:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gGTdzEvZJVxz; Sun,  1 Aug 2021 09:24:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 37A8A83C9E;
	Sun,  1 Aug 2021 09:24:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04B5BC001B;
	Sun,  1 Aug 2021 09:24:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2C38C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Aug 2021 09:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3A166078D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Aug 2021 09:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fv0p7sdhXMYl
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Aug 2021 09:24:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94227605BC
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Aug 2021 09:24:35 +0000 (UTC)
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MeUPU-1miMb64AUu-00aXSI for <virtualization@lists.linux-foundation.org>;
 Sun, 01 Aug 2021 11:24:33 +0200
Received: by mail-wm1-f42.google.com with SMTP id
 k38-20020a05600c1ca6b029025af5e0f38bso768147wms.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 01 Aug 2021 02:24:32 -0700 (PDT)
X-Gm-Message-State: AOAM530rbkIJ9pHM88NKSse8OOViGDtio37IScb9AeDsEgrBmr9ixAGX
 qu+8r9lFv/m6vPouVIZtvAy+lyPhOz3+egfz62I=
X-Google-Smtp-Source: ABdhPJzm+d+GUJq55lf66fORA7zJHnwG96B/E2RUvkJawwTVMsCLwoBqiUjM0EJRl1uPz7IdzGuPR7PXCL0i1oa8StU=
X-Received: by 2002:a05:600c:3641:: with SMTP id
 y1mr2673903wmq.43.1627809872298; 
 Sun, 01 Aug 2021 02:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210801051627.78999-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20210801051627.78999-1-xianting.tian@linux.alibaba.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 1 Aug 2021 11:24:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2_ip1zGMe=EeAA7Xpkvi8iQGWw6=0sGvLqv02Mj4LrmA@mail.gmail.com>
Message-ID: <CAK8P3a2_ip1zGMe=EeAA7Xpkvi8iQGWw6=0sGvLqv02Mj4LrmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tty: hvc: pass DMA capable memory to put_chars()
To: Xianting Tian <xianting.tian@linux.alibaba.com>
X-Provags-ID: V03:K1:QXcnG5LIyM9CSaYZNO0F42yGARqvqXWKUH0B4yekahH4XBgNESy
 AlV9Bmyt0GUESr4f9fMT4mIdtiIHop8dZ8jw8pgK/8I0XJ0bzml7RGQ9+yaqt15KbLLqIFd
 h/YhpRL/4FY+jKVByapBz7B8+Fus/eNCyhZr9t2fgZOPBGJUDjByzidwdfXK9ph4Lm+Jm0l
 bk3Aj+5GwXui8rxrUKwsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/JbHlm4cYHY=:JbWmf6Zm1td6dakwNJ7VY/
 ATB1fG2RCH0P3qbEjHHrw5Vy4SKo6K+0fi0Yh5A4S/sATl3l7NOw42WyfZ7jShbRpJv7I8ndP
 51r/WIY5S1qEaVj8kkZj6vOztVNd0R7gJszPgi6uSBJq4VK77W8QJHDV3ThM/J9Y4YazoC8bY
 KjR/7ATMlbyEOqaWETrwWtk4z/IN2Aat6rV9hsWbgK1vB6cVu9D3pVx3VJ3U98b7nt24N1vVF
 uCcJfUK11fDdmEv3+abzs9IMed5YFMJf26ThUJufOIyNsPmR4szMWTlOfb+10+rcztFVZszcW
 fHvSuvpn11oblK5pGrLNWS1mzkbg+OGJKYjivITNe08/LwzUHQ65HWrOvmgu1R5n/Nszn5479
 fuqHtsIDf6J5NAGpgf9yE5o6jcR9w8hBI9gsJ0s2phdKLuodrqGLuNh5DD1go6KSCb82p4/ZW
 uGmYBXLY+l114e2R08RvbnLzPBa65VEYoulabFAnrj4Ai9gfMVm6e4MSLis04nj/dNSE+ASfK
 GE/u5YyN5AT/OcqcSNZII2ygLIvbGZfnBI08/a5tReGm0bQgPLjR4lTM7yoIaB+4dbKOC9+Vt
 jgezMghZgNIopqB1CGH9i9kOd3wk+HTtfLFft5Otvw84Rd3/R9/iI7Wl7y2dtQ5yIy6ZvpEUt
 OeoftlnqSH7cQt7Ldegztwcg88CoT1YI+wlWryr0fEr9oHydhIie7GMz4Ty5bbW/ngaXIQ12k
 byTXvFpeqEQzuAFapUkymHFUmyRl4nYWZSa/LPphWzxhWYQHXxv8Ga0fFevqTfeKXs5BZVUlS
 4ZpoT+E3TqOOqJBbrUolv/ui4XMs+TYGcooaUAxZTiz/7B542V0qkOxvzJbHuyRhenaT0dQ
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 gregkh <gregkh@linuxfoundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

T24gU3VuLCBBdWcgMSwgMjAyMSBhdCA3OjE2IEFNIFhpYW50aW5nIFRpYW4KPHhpYW50aW5nLnRp
YW5AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgoKPiBDb25zaWRlcmluZyBsb2NrIGNvbXBldGl0
aW9uIG9mIGhwLT5vdXRidWYgYW5kIHRoZSBjb21wbGljYXRlZCBsb2dpYyBpbgo+IGh2Y19jb25z
b2xlX3ByaW50KCksIEkgZGlkbuKAmXQgdXNlIGhwLT5vdXRidWYsIGp1c3QgYWxsb2NhdGUgYWRk
aXRpb25hbAo+IG1lbW9yeShsZW5ndGggTl9PVVRCVUYpIGFuZCBhcHBlbmQgaXQgdG8gaHAtPm91
dGJ1Zi4KPiBGb3IgdGhlIGlzc3VlIGluIGh2Y19wb2xsX3B1dF9jaGFyKCksIEkgdXNlIGEgc3Rh
dGljIGNoYXIgdG8gcmVwbGFjZQo+IHRoZSBjaGFyIGluIHN0YWNrLgoKV2hpbGUgdGhpcyBtYXkg
d29yaywgaXQgc291bmRzIHJhdGhlciBvYnNjdXJlIHRvIG1lLCBJIGRvbid0IHRoaW5rCml0J3Mg
YSBnb29kIGlkZWEKdG8gYXBwZW5kIHRoZSBidWZmZXIgYXQgdGhlIGJhY2suCgpJZiB5b3UgbmVl
ZCBhIHNlcGFyYXRlIGZpZWxkIGJlc2lkZXMgaHAtPm91dGJ1ZiwgSSB3b3VsZCBtYWtlIHRoYXQg
cGFydCBvZiB0aGUKc3RydWN0dXJlIGl0c2VsZiwgYW5kIGdpdmUgaXQgdGhlIGNvcnJlY3QgYWxp
Z25tZW50IGNvbnN0cmFpbnRzIHRvIGVuc3VyZSBpdCBpcwppbiBhIGNhY2hlIGxpbmUgYnkgaXRz
ZWxmLiBUaGUgc2l6ZSBvZiB0aGlzIGZpZWxkIGlzIGEgY29tcGlsZS10aW1lCmNvbnN0YW50LCBz
byBJCmRvbid0IHNlZSBhIG5lZWQgdG8gcGxheSB0cmlja3Mgd2l0aCBwb2ludGVyIGFyaXRobWV0
aWMuCgpJJ20gbm90IHN1cmUgYWJvdXQgdGhlIGxvY2tpbmcgZWl0aGVyOiBJcyBpdCBwb3NzaWJs
ZSBmb3IgdHdvIENQVXMgdG8gZW50ZXIKaHZjX2NvbnNvbGVfcHJpbnQoKSBhdCB0aGUgc2FtZSB0
aW1lLCBvciBpcyB0aGVyZSBsb2NraW5nIGF0IGEgaGlnaGVyIGxldmVsCmFscmVhZHk/IEl0IHdv
dWxkIGJlIGdvb2QgdG8gZG9jdW1lbnQgdGhpcyBpbiB0aGUgc3RydWN0dXJlIGRlZmluaXRpb24g
bmV4dAp0byB0aGUgZmllbGQuCgo+IEBAIC04NzgsNiArODg1LDcgQEAgc3RhdGljIHZvaWQgaHZj
X3BvbGxfcHV0X2NoYXIoc3RydWN0IHR0eV9kcml2ZXIgKmRyaXZlciwgaW50IGxpbmUsIGNoYXIg
Y2gpCj4gICAgICAgICBzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5ID0gZHJpdmVyLT50dHlzWzBdOwo+
ICAgICAgICAgc3RydWN0IGh2Y19zdHJ1Y3QgKmhwID0gdHR5LT5kcml2ZXJfZGF0YTsKPiAgICAg
ICAgIGludCBuOwo+ICsgICAgICAgc3RhdGljIGNoYXIgY2ggPSBjaDsKPgo+ICAgICAgICAgZG8g
ewo+ICAgICAgICAgICAgICAgICBuID0gaHAtPm9wcy0+cHV0X2NoYXJzKGhwLT52dGVybW5vLCAm
Y2gsIDEpOwoKVGhpcyBkb2VzIG5vdCBjb21waWxlLCBhbmQgaXQncyBuZWl0aGVyIHRocmVhZC1z
YWZlIG5vciBkbWEgc2FmZSBpZiB5b3UgZ2V0IGl0CnRvIGJ1aWxkIGJ5IHJlbmFtaW5nIHRoZSB2
YXJpYWJsZS4KCiAgICAgICAgQXJuZApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
