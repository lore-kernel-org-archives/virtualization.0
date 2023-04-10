Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4DAC76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 11:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB07A81F08;
	Mon, 10 Apr 2023 11:01:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB07A81F08
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=UhkOI50i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XsgV6jHGhNoY; Mon, 10 Apr 2023 11:01:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 19ACA81F09;
	Mon, 10 Apr 2023 11:01:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19ACA81F09
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E669AC0036;
	Mon, 10 Apr 2023 11:01:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C798CC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92A55410B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:01:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92A55410B0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=UhkOI50i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sLdInQ9jYSXk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:01:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75D3740338
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75D3740338
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:01:32 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 60-20020a17090a09c200b0023fcc8ce113so6896518pjo.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 04:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681124492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vHUR/cT/p+Bdo1OvjDaF/vJAnET+Cck8N9vYs357g6k=;
 b=UhkOI50iI0W1wlRXpnku3ulk1L1jq+Zwd3HePmNJaQi8pZe+GUDdseF5xv5vPmFAFo
 hyHsE0HF2j28mIXiwj+IKXPL5TdtyAe15riQqFS1GEHvyxapg0NLshmYD3ANoECqE7ZP
 QHYuYJ+pONyP6zIUdfPWgqsZmzC7pI06GILF1BdOE+WpoCqkz087xp1Muw6WRB4AmGSa
 GyDQWpfD7RRXYhzoxaV/nLGWZDfgMK5s/aYiVwhpfxXQzagZ2lqDg7iI/1Pxixboi03x
 G/ULdId+nKzY9pDhcAx81WRRslQmyoGrQLU3qewM0KqXwavd/U8IMjo4DpuZcwnVtQcF
 F+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681124492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vHUR/cT/p+Bdo1OvjDaF/vJAnET+Cck8N9vYs357g6k=;
 b=aj9vvWjbyVFSl4t8aQ+o1bsYLTJooAkJZg3zURLMjeSJV3aNYnsWtMfnErta7qJjAY
 5KVrsTXNfaqwi13m+qGRg+Zn7OYtSnX4drqihrPoi96XesHZvLBRqBu5DtwKf4BIgARN
 eubz481yq6XeTZPDLjyK+Cs/n9IqOJM+g3jW+HMH3yAHbCfUZIc65OA1jt4TWOtQVCKt
 mIPO3Voh08klPnbpdQedZRoNjh4R0nMePUO9wFSVPxEEbAP6qjlL+B0pDC+Uy2KOv4eQ
 wB0+ZB5VPBkx1W6Epbk5pLKmLVIh/noEdGzZHkWvOvUDcoqhJqfA7/bg4GXulnW4GY9K
 3zgA==
X-Gm-Message-State: AAQBX9cQmh3vkk5gAtl/DMhprcZQrKlHiwtJrRR3REViXi1nPSLQZmYJ
 +LBxsynVEv9A8O5yIuRo4EiHIw==
X-Google-Smtp-Source: AKy350bE/CwNUHEPaYuhWuQ0agUkJ0fFbr6BIZPJjWcujqi0Tsj0XjJL/sHWKACP6KyZsgoO33/BQw==
X-Received: by 2002:a17:902:c401:b0:1a0:48c6:3b43 with SMTP id
 k1-20020a170902c40100b001a048c63b43mr10178281plk.37.1681124491794; 
 Mon, 10 Apr 2023 04:01:31 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 bd1-20020a170902830100b0019ac7319ed1sm7511848plb.126.2023.04.10.04.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Apr 2023 04:01:31 -0700 (PDT)
Message-ID: <cc61e2c5-a109-2f18-04e2-cfb010ba6b8a@igel.co.jp>
Date: Mon, 10 Apr 2023 20:01:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] tools/virtio: fix build caused by virtio_ring changes
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230410092419.302932-1-mie@igel.co.jp>
 <20230410054259-mutt-send-email-mst@kernel.org>
 <cd2619b1-5d0b-1e7e-12bd-bcb9dcb5c533@igel.co.jp>
 <a7332e82-27f6-8acd-2ff2-498eb66ea6e7@igel.co.jp>
 <20230410064435-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230410064435-mutt-send-email-mst@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Ck9uIDIwMjMvMDQvMTAgMTk6NTgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBNb24s
IEFwciAxMCwgMjAyMyBhdCAwNzo1NjoxM1BNICswOTAwLCBTaHVuc3VrZSBNaWUgd3JvdGU6Cj4+
IE9uIDIwMjMvMDQvMTAgMTk6MDAsIFNodW5zdWtlIE1pZSB3cm90ZToKPj4+IE9uIDIwMjMvMDQv
MTAgMTg6NDYsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+PiBPbiBNb24sIEFwciAxMCwg
MjAyMyBhdCAwNjoyNDoxOVBNICswOTAwLCBTaHVuc3VrZSBNaWUgd3JvdGU6Cj4+Pj4+IEZpeCB0
aGUgYnVpbGQgZGVwZW5kZW5jeSBmb3IgdmlydGlvX3Rlc3QuIHZpcnRpb19yaW5nIHJlcXVpcmVz
Cj4+Pj4+IGNvbnRhaW5lcl9vZl9jb25zdCgpIGFuZCBzdHJ1Y2UgZGV2aWNlLgo+Pj4+Pgo+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBTaHVuc3VrZSBNaWUgPG1pZUBpZ2VsLmNvLmpwPgo+Pj4+PiAtLS0K
Pj4+Pj4gIMKgIHRvb2xzL2luY2x1ZGUvbGludXgvY29udGFpbmVyX29mLmggfCAzNgo+Pj4+PiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4+Pj4gIMKgIHRvb2xzL3ZpcnRpby9saW51
eC9jb21waWxlci5owqDCoMKgwqDCoCB8wqAgMyArKysKPj4+Pj4gIMKgIHRvb2xzL3ZpcnRpby9s
aW51eC9rZXJuZWwuaMKgwqDCoMKgwqDCoMKgIHzCoCA1ICstLS0tCj4+Pj4+ICDCoCB0b29scy92
aXJ0aW8vbGludXgvbW9kdWxlLmjCoMKgwqDCoMKgwqDCoCB8wqAgMSArCj4+Pj4+ICDCoCA0IGZp
bGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Pj4+ICDCoCBj
cmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvaW5jbHVkZS9saW51eC9jb250YWluZXJfb2YuaAo+Pj4+
Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvaW5jbHVkZS9saW51eC9jb250YWluZXJfb2YuaAo+
Pj4+PiBiL3Rvb2xzL2luY2x1ZGUvbGludXgvY29udGFpbmVyX29mLmgKPj4+Pj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQKPj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi4wNmUyOTNiN2NmZGEKPj4+Pj4g
LS0tIC9kZXYvbnVsbAo+Pj4+PiArKysgYi90b29scy9pbmNsdWRlL2xpbnV4L2NvbnRhaW5lcl9v
Zi5oCj4+Pj4+IEBAIC0wLDAgKzEsMzYgQEAKPj4+Pj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wICovCj4+Pj4+ICsjaWZuZGVmIF9MSU5VWF9DT05UQUlORVJfT0ZfSAo+Pj4+
PiArI2RlZmluZSBfTElOVVhfQ09OVEFJTkVSX09GX0gKPj4+Pj4gKwo+Pj4+PiArI2luY2x1ZGUg
PGxpbnV4L2J1aWxkX2J1Zy5oPgo+Pj4+PiArI2luY2x1ZGUgPGxpbnV4L3N0ZGRlZi5oPgo+Pj4+
PiArCj4+Pj4+ICsvKioKPj4+Pj4gKyAqIGNvbnRhaW5lcl9vZiAtIGNhc3QgYSBtZW1iZXIgb2Yg
YSBzdHJ1Y3R1cmUgb3V0IHRvIHRoZQo+Pj4+PiBjb250YWluaW5nIHN0cnVjdHVyZQo+Pj4+PiAr
ICogQHB0cjrCoMKgwqAgdGhlIHBvaW50ZXIgdG8gdGhlIG1lbWJlci4KPj4+Pj4gKyAqIEB0eXBl
OsKgwqDCoCB0aGUgdHlwZSBvZiB0aGUgY29udGFpbmVyIHN0cnVjdCB0aGlzIGlzIGVtYmVkZGVk
IGluLgo+Pj4+PiArICogQG1lbWJlcjrCoMKgwqAgdGhlIG5hbWUgb2YgdGhlIG1lbWJlciB3aXRo
aW4gdGhlIHN0cnVjdC4KPj4+Pj4gKyAqCj4+Pj4+ICsgKiBXQVJOSU5HOiBhbnkgY29uc3QgcXVh
bGlmaWVyIG9mIEBwdHIgaXMgbG9zdC4KPj4+Pj4gKyAqLwo+Pj4+PiArI2RlZmluZSBjb250YWlu
ZXJfb2YocHRyLCB0eXBlLCBtZW1iZXIpICh7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwKPj4+Pj4gK8KgwqDCoCB2b2lkICpfX21wdHIgPSAodm9pZCAqKShwdHIpO8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+Pj4gK8KgwqDCoCBzdGF0aWNfYXNzZXJ0
KF9fc2FtZV90eXBlKCoocHRyKSwgKCh0eXBlICopMCktPm1lbWJlcikgfHzCoMKgwqAgXAo+Pj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19zYW1lX3R5cGUoKihwdHIpLCB2b2lkKSzC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJwb2ludGVyIHR5cGUgbWlzbWF0Y2ggaW4gY29udGFpbmVyX29mKCkiKTsgXAo+Pj4+PiArwqDC
oMKgICgodHlwZSAqKShfX21wdHIgLSBvZmZzZXRvZih0eXBlLCBtZW1iZXIpKSk7IH0pCj4+Pj4+
ICsKPj4+Pj4gKy8qKgo+Pj4+PiArICogY29udGFpbmVyX29mX2NvbnN0IC0gY2FzdCBhIG1lbWJl
ciBvZiBhIHN0cnVjdHVyZSBvdXQgdG8gdGhlCj4+Pj4+IGNvbnRhaW5pbmcKPj4+Pj4gKyAqwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3R1cmUgYW5kIHByZXNlcnZlIHRoZSBjb25zdC1uZXNz
IG9mIHRoZSBwb2ludGVyCj4+Pj4+ICsgKiBAcHRyOsKgwqDCoMKgwqDCoMKgIHRoZSBwb2ludGVy
IHRvIHRoZSBtZW1iZXIKPj4+Pj4gKyAqIEB0eXBlOsKgwqDCoMKgwqDCoMKgIHRoZSB0eXBlIG9m
IHRoZSBjb250YWluZXIgc3RydWN0IHRoaXMgaXMgZW1iZWRkZWQgaW4uCj4+Pj4+ICsgKiBAbWVt
YmVyOsKgwqDCoMKgwqDCoMKgIHRoZSBuYW1lIG9mIHRoZSBtZW1iZXIgd2l0aGluIHRoZSBzdHJ1
Y3QuCj4+Pj4+ICsgKi8KPj4+Pj4gKyNkZWZpbmUgY29udGFpbmVyX29mX2NvbnN0KHB0ciwgdHlw
ZSwgbWVtYmVyKSBcCj4+Pj4+ICvCoMKgwqAgX0dlbmVyaWMocHRyLMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBjb25zdCB0eXBlb2YoKihwdHIpKSAqOiAoKGNvbnN0IHR5cGUKPj4+Pj4gKiljb250YWlu
ZXJfb2YocHRyLCB0eXBlLCBtZW1iZXIpKSxcCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBkZWZhdWx0
OiAoKHR5cGUgKiljb250YWluZXJfb2YocHRyLCB0eXBlLCBtZW1iZXIpKSBcCj4+Pj4+ICvCoMKg
wqAgKQo+Pj4+PiArCj4+Pj4+ICsjZW5kaWbCoMKgwqAgLyogX0xJTlVYX0NPTlRBSU5FUl9PRl9I
ICovCj4+Pj4gUGxlYXNlIGp1c3QgZG8KPj4+PiAjaW5jbHVkZSAiLi4vLi4vLi4vaW5jbHVkZS9s
aW51eC9jb250YWluZXJfb2YuaCIKPj4+PiBpbnN0ZWFkLgo+Pj4gT2tleSwgSSdsbCBkbyB0aGF0
Lgo+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS90b29scy92aXJ0aW8vbGludXgvY29tcGlsZXIuaAo+
Pj4+PiBiL3Rvb2xzL3ZpcnRpby9saW51eC9jb21waWxlci5oCj4+Pj4+IGluZGV4IDJjNTFiY2Ni
OTdiYi4uYWMyN2IzZWE2ZTY3IDEwMDY0NAo+Pj4+PiAtLS0gYS90b29scy92aXJ0aW8vbGludXgv
Y29tcGlsZXIuaAo+Pj4+PiArKysgYi90b29scy92aXJ0aW8vbGludXgvY29tcGlsZXIuaAo+Pj4+
PiBAQCAtOCw0ICs4LDcgQEAKPj4+Pj4gIMKgICNkZWZpbmUgUkVBRF9PTkNFKHZhcikgKCooKHZv
bGF0aWxlIHR5cGVvZih2YXIpICopKCYodmFyKSkpKQo+Pj4+PiAgwqAgwqAgI2RlZmluZSBfX2Fs
aWduZWQoeCkgX19hdHRyaWJ1dGUoKF9fYWxpZ25lZF9fKHgpKSkKPj4+Pj4gKwo+Pj4+PiArI2Rl
ZmluZSBfX3NhbWVfdHlwZShhLCBiKQo+Pj4+PiBfX2J1aWx0aW5fdHlwZXNfY29tcGF0aWJsZV9w
KHR5cGVvZihhKSwgdHlwZW9mKGIpKQo+Pj4+PiArCj4+Pj4+ICDCoCAjZW5kaWYKPj4+PiAjaW5j
bHVkZSAiLi4vLi4vLi4vaW5jbHVkZS9saW51eC9jb21waWxlcl90eXBlcy5oIiBpbnN0ZWFkPwo+
Pj4gSSdsbCB0cnkgaXQuCj4+Pj4+IGRpZmYgLS1naXQgYS90b29scy92aXJ0aW8vbGludXgva2Vy
bmVsLmggYi90b29scy92aXJ0aW8vbGludXgva2VybmVsLmgKPj4+Pj4gaW5kZXggOGI4NzcxNjc5
MzNkLi4zY2QyMGNiOTI2NDkgMTAwNjQ0Cj4+Pj4+IC0tLSBhL3Rvb2xzL3ZpcnRpby9saW51eC9r
ZXJuZWwuaAo+Pj4+PiArKysgYi90b29scy92aXJ0aW8vbGludXgva2VybmVsLmgKPj4+Pj4gQEAg
LTEwLDYgKzEwLDcgQEAKPj4+Pj4gIMKgICNpbmNsdWRlIDxzdGRhcmcuaD4KPj4+Pj4gIMKgIMKg
ICNpbmNsdWRlIDxsaW51eC9jb21waWxlci5oPgo+Pj4+PiArI2luY2x1ZGUgPGxpbnV4L2NvbnRh
aW5lcl9vZi5oPgo+Pj4+PiAgwqAgI2luY2x1ZGUgPGxpbnV4L2xvZzIuaD4KPj4+Pj4gIMKgICNp
bmNsdWRlIDxsaW51eC90eXBlcy5oPgo+Pj4+PiAgwqAgI2luY2x1ZGUgPGxpbnV4L292ZXJmbG93
Lmg+Cj4+Pj4+IEBAIC0xMDcsMTAgKzEwOCw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmcmVlX3Bh
Z2UodW5zaWduZWQgbG9uZyBhZGRyKQo+Pj4+PiAgwqDCoMKgwqDCoCBmcmVlKCh2b2lkICopYWRk
cik7Cj4+Pj4+ICDCoCB9Cj4+Pj4+ICDCoCAtI2RlZmluZSBjb250YWluZXJfb2YocHRyLCB0eXBl
LCBtZW1iZXIpICh7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4+IC3CoMKgwqAgY29uc3Qg
dHlwZW9mKCAoKHR5cGUgKikwKS0+bWVtYmVyICkgKl9fbXB0ciA9IChwdHIpO8KgwqDCoCBcCj4+
Pj4+IC3CoMKgwqAgKHR5cGUgKikoIChjaGFyICopX19tcHRyIC0gb2Zmc2V0b2YodHlwZSxtZW1i
ZXIpICk7fSkKPj4+Pj4gLQo+Pj4+PiAgwqAgIyBpZm5kZWYgbGlrZWx5Cj4+Pj4+ICDCoCAjwqAg
ZGVmaW5lIGxpa2VseSh4KcKgwqDCoCAoX19idWlsdGluX2V4cGVjdCghISh4KSwgMSkpCj4+Pj4+
ICDCoCAjIGVuZGlmCj4+Pj4+IGRpZmYgLS1naXQgYS90b29scy92aXJ0aW8vbGludXgvbW9kdWxl
LmggYi90b29scy92aXJ0aW8vbGludXgvbW9kdWxlLmgKPj4+Pj4gaW5kZXggOWRmYTk2ZmVhMmIy
Li5lMmU3OTFkYmQxMDQgMTAwNjQ0Cj4+Pj4+IC0tLSBhL3Rvb2xzL3ZpcnRpby9saW51eC9tb2R1
bGUuaAo+Pj4+PiArKysgYi90b29scy92aXJ0aW8vbGludXgvbW9kdWxlLmgKPj4+Pj4gQEAgLTUs
MyArNSw0IEBACj4+Pj4+ICDCoMKgwqDCoMKgIHN0YXRpYyBfX2F0dHJpYnV0ZV9fKCh1bnVzZWQp
KSBjb25zdCBjaGFyCj4+Pj4+ICpfX01PRFVMRV9MSUNFTlNFX25hbWUgPSBcCj4+Pj4+ICDCoMKg
wqDCoMKgwqDCoMKgwqAgX19NT0RVTEVfTElDRU5TRV92YWx1ZQo+Pj4+PiAgwqAgK3N0cnVjdCBk
ZXZpY2U7Cj4+Pj4gSXQncyBub3QgdGhlcmUgaW4gaW5jbHVkZS9saW51eC9tb2R1bGUgLSBwbHMg
cHV0IGl0IGluIHRoZQo+Pj4+IHNhbWUgaGVyZSB3aGVyZSBpdCBpcyBmb3IgbGludXguCj4+PiBJ
IHVuZGVyc3Rvb2QuIEknbGwgYWRkIHNvbWUgZmlsZXMgdGhhdCBoYXMgdGhlIGRlZmluaXRpb24u
Cj4+IEluIHZyaW5naC5jLCAnc3RydWN0IGRldmljZScgaXMgdXNlZCBpbiB2aXJ0aW9fcmluZy5o
LiBVcG9uIGludmVzdGlnYXRpbmcKPj4gdGhlIHByZXByb2Nlc3NlZCBmaWxlLCBpdCB3YXMKPj4K
Pj4gZGlzY292ZXJlZCB0aGF0ICdzdHJ1Y3QgZGV2aWNlJyBpcyBkZWZpbmVkIGluIGJpdG1hcC5o
LCB3aGljaCBpcyBpbmNsdWRlZAo+PiBmcm9tIGFyY2hpdGVjdHVyZS1zcGVjaWZpYyBoZWFkZXJz
Lgo+Pgo+PiBPbiB4ODYsIHRoZSBuZXN0aW5nIGluY2x1ZGVzCj4+Cj4+ICdsaW51eC9tb2R1bGUu
aCcgLT4gLi4uIC0+ICdhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3IuaCcgLT4KPj4gJ2FyY2gveDg2
L2luY2x1ZGUvYXNtL2NwdW1hc2suaCcgLT4gJ2xpbnV4L2NwdW1hc2suaCcgLT4gJ2xpbnV4L2Jp
dG1hcC5oJy4KPj4KPj4gQ291bGQgeW91IGFkdmlzZSBvbiB0aGUgYXBwcm9wcmlhdGUgd2F5IHRv
IGluY2x1ZGUgdGhpcyBmaWxlPwo+IExldCdzIGp1c3QgYWRkIHN0cnVjdCBkZXZpY2U7IGluIHZp
cnRpb19yaW5nLmgsIG1ha2UgaXQKPiBzZWxmLXN1ZmZpY2llbnQuCj4KSSBhZ3JlZS4gVGhhbmtz
IGEgbG90LgoKPj4+Pj4gLS0gCj4+Pj4+IDIuMjUuMQo+Pj4gQmVzdCByZWdhcmRzLAo+Pj4KPj4+
IFNodW5zdWtlLgo+Pj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
