Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F216EC433DB
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 03:13:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F4664E67
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 03:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F4664E67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26D376F4A4;
	Mon, 15 Mar 2021 03:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N__e7vvOERvr; Mon, 15 Mar 2021 03:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7E3060586;
	Mon, 15 Mar 2021 03:13:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB58C000B;
	Mon, 15 Mar 2021 03:13:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63301C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 03:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39A0C4866D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 03:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xFxzIS9m7U20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 03:13:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99401485E1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 03:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615778007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KQvhWT/uEAJYmXyLme3QfbVxRoW/9wvj83xMof6nwU=;
 b=P1t1axGhYQ8wXkvGz6/S4CQu/ucCZ/lj6C941omahqR+QwYo4XeXkLB+V3DEu1Cob4MWOD
 gvfQ7CVIbI5zqzTDJuipHOtTqV7i/SYAVnw0Mp5vMpci2m0nD1r9uLBw4KnfCgnXxIPzWY
 b9wIdSjZaXC3ZtUa7esLD4Az7jrbEIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-rc4aCGvfNxeJ8CCy2hzIpg-1; Sun, 14 Mar 2021 23:13:25 -0400
X-MC-Unique: rc4aCGvfNxeJ8CCy2hzIpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9F5A107B02A;
 Mon, 15 Mar 2021 03:13:21 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-199.pek2.redhat.com
 [10.72.13.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0A3A1C4;
 Mon, 15 Mar 2021 03:13:07 +0000 (UTC)
Subject: Re: [PATCH v7] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>, Arnd Bergmann <arnd@arndb.de>
References: <cd3b0c9138824b0a5fad9d3bc872d8836e829946.1615554673.git.jie.deng@intel.com>
 <CAK8P3a0zQG3pH91emqAUsaRx4AZeuOEvSrPzXP9w_XhjU6w3ng@mail.gmail.com>
 <8070f03d-8233-636b-5ea9-395e723f7a2c@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <503b88c9-1e82-a3a3-0536-d710ddc834a5@redhat.com>
Date: Mon, 15 Mar 2021 11:13:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8070f03d-8233-636b-5ea9-395e723f7a2c@intel.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>, yu1.wang@intel.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 shuo.a.liu@intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Paolo Bonzini <pbonzini@redhat.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 conghui.chen@intel.com, Mike Rapoport <rppt@kernel.org>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMy8xNSA5OjE0IOS4iuWNiCwgSmllIERlbmcgd3JvdGU6Cj4KPiBPbiAyMDIxLzMv
MTIgMTY6NTgsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4+IE9uIEZyaSwgTWFyIDEyLCAyMDIxIGF0
IDI6MzMgUE0gSmllIERlbmcgPGppZS5kZW5nQGludGVsLmNvbT4gd3JvdGU6Cj4+Cj4+PiArCj4+
PiArLyoqCj4+PiArICogc3RydWN0IHZpcnRpb19pMmNfcmVxIC0gdGhlIHZpcnRpbyBJMkMgcmVx
dWVzdCBzdHJ1Y3R1cmUKPj4+ICsgKiBAb3V0X2hkcjogdGhlIE9VVCBoZWFkZXIgb2YgdGhlIHZp
cnRpbyBJMkMgbWVzc2FnZQo+Pj4gKyAqIEBidWY6IHRoZSBidWZmZXIgaW50byB3aGljaCBkYXRh
IGlzIHJlYWQsIG9yIGZyb20gd2hpY2ggaXQncyAKPj4+IHdyaXR0ZW4KPj4+ICsgKiBAaW5faGRy
OiB0aGUgSU4gaGVhZGVyIG9mIHRoZSB2aXJ0aW8gSTJDIG1lc3NhZ2UKPj4+ICsgKi8KPj4+ICtz
dHJ1Y3QgdmlydGlvX2kyY19yZXEgewo+Pj4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgdmlydGlvX2ky
Y19vdXRfaGRyIG91dF9oZHI7Cj4+PiArwqDCoMKgwqDCoMKgIHVpbnQ4X3QgKmJ1ZjsKPj4+ICvC
oMKgwqDCoMKgwqAgc3RydWN0IHZpcnRpb19pMmNfaW5faGRyIGluX2hkcjsKPj4+ICt9Owo+PiBU
aGUgc2ltcGxlciByZXF1ZXN0IHN0cnVjdHVyZSBjbGVhcmx5IGxvb2tzIGJldHRlciB0aGFuIHRo
ZSBwcmV2aW91cyAKPj4gdmVyc2lvbiwKPj4gYnV0IEkgdGhpbmsgSSBmb3VuZCBhbm90aGVyIHBy
b2JsZW0gaGVyZSwgYXQgbGVhc3QgYSB0aGVvcmV0aWNhbCBvbmU6Cj4+Cj4+IFdoZW4geW91IG1h
cCB0aGUgaGVhZGVycyBpbnRvIHRoZSBETUEgYWRkcmVzcyBzcGFjZSwgdGhleSBzaG91bGQKPj4g
YmUgaW4gc2VwYXJhdGUgY2FjaGUgbGluZXMsIHRvIGFsbG93IHRoZSBETUEgbWFwcGluZyBpbnRl
cmZhY2VzIHRvCj4+IHBlcmZvcm0gY2FjaGUgbWFuYWdlbWVudCBvbiBlYWNoIG9uZSB3aXRob3V0
IGFjY2lkZW50YWxseSBjbG9iYmVyaW5nCj4+IGFub3RoZXIgbWVtYmVyLgo+Pgo+PiBTbyBmYXIg
SSB0aGluayB0aGVyZSBpcyBhbiBhc3N1bXB0aW9uIHRoYXQgdmlydGlvIGJ1ZmZlcnMgYXJlIGFs
d2F5cwo+PiBvbiBjYWNoZS1jb2hlcmVudCBkZXZpY2VzLCBidXQgaWYgeW91IGV2ZXIgaGF2ZSBh
IHZpcnRpby1pMmMgZGV2aWNlCj4+IGJhY2tlbmQgb24gYSBwaHlzaWNhbCBpbnRlcmNvbm5lY3Qg
dGhhdCBpcyBub3QgY2FjaGUgY29oZXJlbnQgKGUuZy4gYQo+PiBtaWNyb2NvbnRyb2xsZXIgdGhh
dCBzaGFyZXMgdGhlIG1lbW9yeSBidXMpLCB0aGlzIGJyZWFrcyBkb3duLgo+Pgo+PiBZb3UgY291
bGQgYXZvaWQgdGhpcyBieSBlaXRoZXIgYWxsb2NhdGluZyBhcnJheXMgb2YgZWFjaCB0eXBlIAo+
PiBzZXBhcmF0ZWx5LAo+PiBvciBieSBtYXJraW5nIGVhY2ggbWVtYmVyIHRoYXQgeW91IHBhc3Mg
dG8gdGhlIGRldmljZSBhcwo+PiBfX19fY2FjaGVsaW5lX2FsaWduZWQuCj4+Cj4+IMKgwqDCoMKg
wqDCoCBBcm5kCj4gVGhlIHZpcnRpbyBkZXZpY2VzIGFyZSBzb2Z0d2FyZSBlbXVsYXRlZC4KCgpU
aGlzIGlzIG5vdCBjb3JyZWN0LiBUaGVyZSdyZSBhbHJlYWR5IGEgYnJ1bmNoIGhhcmR3YXJlIHZp
cnRpbyBkZXZpY2VzLgoKVGhhbmtzCgoKPiBUaGUgYmFja2VuZCBzb2Z0d2FyZSBtYXkgbmVlZCB0
bwo+IGNvbnNpZGVyIHRoaXMgc2luY2UgaXQgbWF5IGV4Y2hhbmdlIGRhdGEgd2l0aCBwaHlzaWNh
bCBkZXZpY2VzLiBCdXQgSSAKPiBkb24ndCB0aGluawo+IHdlIG5lZWQgaXQgZm9yIHRoaXMgaW50
ZXJmYWNlLCBiZWNhdXNlIG5vIERNQSBvcGVyYXRpb24gaXMgaW52b2x2ZWQgCj4gYmV0d2VlbiB0
aGUKPiBmcm9udGVuZCBkcml2ZXIgYW5kIGJhY2tlbmQgZHJpdmVyLgo+Cj4gUmVnYXJkcywKPgo+
IEppZQo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
