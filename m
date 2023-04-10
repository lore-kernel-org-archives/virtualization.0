Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D0DC76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 10:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D3B8610EA;
	Mon, 10 Apr 2023 10:56:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D3B8610EA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=NY9rrM2W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W4N4H_Cz31s0; Mon, 10 Apr 2023 10:56:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4E22760ACA;
	Mon, 10 Apr 2023 10:56:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E22760ACA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D034C0036;
	Mon, 10 Apr 2023 10:56:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17040C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFEFC409AD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:56:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFEFC409AD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=NY9rrM2W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qn7vFdiRsf_T
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:56:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEAAE400D3
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DEAAE400D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:56:17 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6323e36064aso500766b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681124177;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kUfYBMfNg0SmC86dn/fX5bWORs6cZUYHg91rhQn2QYM=;
 b=NY9rrM2WqjnhPe5auMnkJCTfiUe8zdxsNyUTjnmfZsN0G+rXISnMe2IP7OsZctLnLe
 YFdDteT3xd3ow+4c57SOE4Qq6MpxH7e/xV96fuy6qO5X5tk1PaW4ZCgzPCLALIXuM69C
 Nse0dLyuKfMscFlouF83z7WmDLL8FP55MnuirOXdBk1NaL4Zc30uZkB1vgsalevvGW8v
 hqRSxadVW3y2FTwI1+4E679pGyPaCdZOjOTmpShYHoUaPSfjHF8IibTiRfl39xc2Xask
 k6fj9due2CuUr5nbzo2/q95SriiepbkwQVhZfCzVwMaDz1osf5S2OMHmLjFAEzqhChbQ
 Vjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681124177;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kUfYBMfNg0SmC86dn/fX5bWORs6cZUYHg91rhQn2QYM=;
 b=fkQasSKC8DxaEQN4v8F7w4G0cyzfd/GbSXPzBZauReO+pCfeRS5c2sBPH5pNC8EIRk
 ooPrd5jNWW/nSiN986EjHsut4FObMr28EvRePIbu9ASVr3rajFn+kFiFPIn63ypO6lkQ
 ouT7vTidTMtyleaDYkYCyB9ZXHDvTMzDwESyzJvV+GESpbGuN6XVwuYMt/sNv2qMfjZJ
 WlB7mBYKgQBVoYgfT1NZWNEdwXzPranyT0AjElRzvALZ5wVYmCbX5s57KI3aX4ifih2W
 FMJaknCy5QthbOM8P7LUqzQGNWOFpf9vD9sU5BK+C+L0g2BxqazmG6PyrtwT16lX5sMc
 EMXA==
X-Gm-Message-State: AAQBX9ery6FY5hFXZ87NfXwfVJXaHmnBRfO9ibHeYSfhNc3+HAyXeZ2e
 TEdaMRi0dOuEm2/kcf4nGP6rgg==
X-Google-Smtp-Source: AKy350bFJfjMDeTrfzeTBW9bSfARNeu5n7yZBzOfGNll/E4rYYyfS5lmYSbNejLk8E9JFoeDCA9IlA==
X-Received: by 2002:a62:1d8e:0:b0:626:166f:6db1 with SMTP id
 d136-20020a621d8e000000b00626166f6db1mr10098940pfd.13.1681124177282; 
 Mon, 10 Apr 2023 03:56:17 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 w5-20020aa78585000000b006348cb791f4sm3357460pfn.192.2023.04.10.03.56.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Apr 2023 03:56:16 -0700 (PDT)
Message-ID: <a7332e82-27f6-8acd-2ff2-498eb66ea6e7@igel.co.jp>
Date: Mon, 10 Apr 2023 19:56:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] tools/virtio: fix build caused by virtio_ring changes
Content-Language: en-US
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230410092419.302932-1-mie@igel.co.jp>
 <20230410054259-mutt-send-email-mst@kernel.org>
 <cd2619b1-5d0b-1e7e-12bd-bcb9dcb5c533@igel.co.jp>
In-Reply-To: <cd2619b1-5d0b-1e7e-12bd-bcb9dcb5c533@igel.co.jp>
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

Ck9uIDIwMjMvMDQvMTAgMTk6MDAsIFNodW5zdWtlIE1pZSB3cm90ZToKPgo+IE9uIDIwMjMvMDQv
MTAgMTg6NDYsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4gT24gTW9uLCBBcHIgMTAsIDIw
MjMgYXQgMDY6MjQ6MTlQTSArMDkwMCwgU2h1bnN1a2UgTWllIHdyb3RlOgo+Pj4gRml4IHRoZSBi
dWlsZCBkZXBlbmRlbmN5IGZvciB2aXJ0aW9fdGVzdC4gdmlydGlvX3JpbmcgcmVxdWlyZXMKPj4+
IGNvbnRhaW5lcl9vZl9jb25zdCgpIGFuZCBzdHJ1Y2UgZGV2aWNlLgo+Pj4KPj4+IFNpZ25lZC1v
ZmYtYnk6IFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28uanA+Cj4+PiAtLS0KPj4+IMKgIHRvb2xz
L2luY2x1ZGUvbGludXgvY29udGFpbmVyX29mLmggfCAzNiAKPj4+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+Pj4gwqAgdG9vbHMvdmlydGlvL2xpbnV4L2NvbXBpbGVyLmjCoMKgwqDC
oMKgIHzCoCAzICsrKwo+Pj4gwqAgdG9vbHMvdmlydGlvL2xpbnV4L2tlcm5lbC5owqDCoMKgwqDC
oMKgwqAgfMKgIDUgKy0tLS0KPj4+IMKgIHRvb2xzL3ZpcnRpby9saW51eC9tb2R1bGUuaMKgwqDC
oMKgwqDCoMKgIHzCoCAxICsKPj4+IMKgIDQgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKPj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9pbmNsdWRl
L2xpbnV4L2NvbnRhaW5lcl9vZi5oCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2luY2x1ZGUv
bGludXgvY29udGFpbmVyX29mLmggCj4+PiBiL3Rvb2xzL2luY2x1ZGUvbGludXgvY29udGFpbmVy
X29mLmgKPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjA2
ZTI5M2I3Y2ZkYQo+Pj4gLS0tIC9kZXYvbnVsbAo+Pj4gKysrIGIvdG9vbHMvaW5jbHVkZS9saW51
eC9jb250YWluZXJfb2YuaAo+Pj4gQEAgLTAsMCArMSwzNiBAQAo+Pj4gKy8qIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wICovCj4+PiArI2lmbmRlZiBfTElOVVhfQ09OVEFJTkVSX09G
X0gKPj4+ICsjZGVmaW5lIF9MSU5VWF9DT05UQUlORVJfT0ZfSAo+Pj4gKwo+Pj4gKyNpbmNsdWRl
IDxsaW51eC9idWlsZF9idWcuaD4KPj4+ICsjaW5jbHVkZSA8bGludXgvc3RkZGVmLmg+Cj4+PiAr
Cj4+PiArLyoqCj4+PiArICogY29udGFpbmVyX29mIC0gY2FzdCBhIG1lbWJlciBvZiBhIHN0cnVj
dHVyZSBvdXQgdG8gdGhlIAo+Pj4gY29udGFpbmluZyBzdHJ1Y3R1cmUKPj4+ICsgKiBAcHRyOsKg
wqDCoCB0aGUgcG9pbnRlciB0byB0aGUgbWVtYmVyLgo+Pj4gKyAqIEB0eXBlOsKgwqDCoCB0aGUg
dHlwZSBvZiB0aGUgY29udGFpbmVyIHN0cnVjdCB0aGlzIGlzIGVtYmVkZGVkIGluLgo+Pj4gKyAq
IEBtZW1iZXI6wqDCoMKgIHRoZSBuYW1lIG9mIHRoZSBtZW1iZXIgd2l0aGluIHRoZSBzdHJ1Y3Qu
Cj4+PiArICoKPj4+ICsgKiBXQVJOSU5HOiBhbnkgY29uc3QgcXVhbGlmaWVyIG9mIEBwdHIgaXMg
bG9zdC4KPj4+ICsgKi8KPj4+ICsjZGVmaW5lIGNvbnRhaW5lcl9vZihwdHIsIHR5cGUsIG1lbWJl
cikgKHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4gK8KgwqDCoCB2b2lkICpf
X21wdHIgPSAodm9pZCAqKShwdHIpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPj4+ICvCoMKgwqAgc3RhdGljX2Fzc2VydChfX3NhbWVfdHlwZSgqKHB0ciksICgodHlw
ZSAqKTApLT5tZW1iZXIpIHx8wqDCoMKgIFwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBfX3NhbWVfdHlwZSgqKHB0ciksIHZvaWQpLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJwb2ludGVyIHR5cGUgbWlzbWF0Y2ggaW4gY29u
dGFpbmVyX29mKCkiKTsgXAo+Pj4gK8KgwqDCoCAoKHR5cGUgKikoX19tcHRyIC0gb2Zmc2V0b2Yo
dHlwZSwgbWVtYmVyKSkpOyB9KQo+Pj4gKwo+Pj4gKy8qKgo+Pj4gKyAqIGNvbnRhaW5lcl9vZl9j
b25zdCAtIGNhc3QgYSBtZW1iZXIgb2YgYSBzdHJ1Y3R1cmUgb3V0IHRvIHRoZSAKPj4+IGNvbnRh
aW5pbmcKPj4+ICsgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0dXJlIGFuZCBwcmVzZXJ2
ZSB0aGUgY29uc3QtbmVzcyBvZiB0aGUgcG9pbnRlcgo+Pj4gKyAqIEBwdHI6wqDCoMKgwqDCoMKg
wqAgdGhlIHBvaW50ZXIgdG8gdGhlIG1lbWJlcgo+Pj4gKyAqIEB0eXBlOsKgwqDCoMKgwqDCoMKg
IHRoZSB0eXBlIG9mIHRoZSBjb250YWluZXIgc3RydWN0IHRoaXMgaXMgZW1iZWRkZWQgaW4uCj4+
PiArICogQG1lbWJlcjrCoMKgwqDCoMKgwqDCoCB0aGUgbmFtZSBvZiB0aGUgbWVtYmVyIHdpdGhp
biB0aGUgc3RydWN0Lgo+Pj4gKyAqLwo+Pj4gKyNkZWZpbmUgY29udGFpbmVyX29mX2NvbnN0KHB0
ciwgdHlwZSwgbWVtYmVyKSBcCj4+PiArwqDCoMKgIF9HZW5lcmljKHB0cizCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4gK8KgwqDCoMKg
wqDCoMKgIGNvbnN0IHR5cGVvZigqKHB0cikpICo6ICgoY29uc3QgdHlwZSAqKWNvbnRhaW5lcl9v
ZihwdHIsIAo+Pj4gdHlwZSwgbWVtYmVyKSksXAo+Pj4gK8KgwqDCoMKgwqDCoMKgIGRlZmF1bHQ6
ICgodHlwZSAqKWNvbnRhaW5lcl9vZihwdHIsIHR5cGUsIG1lbWJlcikpIFwKPj4+ICvCoMKgwqAg
KQo+Pj4gKwo+Pj4gKyNlbmRpZsKgwqDCoCAvKiBfTElOVVhfQ09OVEFJTkVSX09GX0ggKi8KPj4K
Pj4gUGxlYXNlIGp1c3QgZG8KPj4gI2luY2x1ZGUgIi4uLy4uLy4uL2luY2x1ZGUvbGludXgvY29u
dGFpbmVyX29mLmgiCj4+IGluc3RlYWQuCj4gT2tleSwgSSdsbCBkbyB0aGF0Lgo+Pgo+Pgo+Pj4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL3ZpcnRpby9saW51eC9jb21waWxlci5oIAo+Pj4gYi90b29scy92
aXJ0aW8vbGludXgvY29tcGlsZXIuaAo+Pj4gaW5kZXggMmM1MWJjY2I5N2JiLi5hYzI3YjNlYTZl
NjcgMTAwNjQ0Cj4+PiAtLS0gYS90b29scy92aXJ0aW8vbGludXgvY29tcGlsZXIuaAo+Pj4gKysr
IGIvdG9vbHMvdmlydGlvL2xpbnV4L2NvbXBpbGVyLmgKPj4+IEBAIC04LDQgKzgsNyBAQAo+Pj4g
wqAgI2RlZmluZSBSRUFEX09OQ0UodmFyKSAoKigodm9sYXRpbGUgdHlwZW9mKHZhcikgKikoJih2
YXIpKSkpCj4+PiDCoCDCoCAjZGVmaW5lIF9fYWxpZ25lZCh4KSBfX2F0dHJpYnV0ZSgoX19hbGln
bmVkX18oeCkpKQo+Pj4gKwo+Pj4gKyNkZWZpbmUgX19zYW1lX3R5cGUoYSwgYikgX19idWlsdGlu
X3R5cGVzX2NvbXBhdGlibGVfcCh0eXBlb2YoYSksIAo+Pj4gdHlwZW9mKGIpKQo+Pj4gKwo+Pj4g
wqAgI2VuZGlmCj4+ICNpbmNsdWRlICIuLi8uLi8uLi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5
cGVzLmgiIGluc3RlYWQ/Cj4gSSdsbCB0cnkgaXQuCj4+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdmly
dGlvL2xpbnV4L2tlcm5lbC5oIGIvdG9vbHMvdmlydGlvL2xpbnV4L2tlcm5lbC5oCj4+PiBpbmRl
eCA4Yjg3NzE2NzkzM2QuLjNjZDIwY2I5MjY0OSAxMDA2NDQKPj4+IC0tLSBhL3Rvb2xzL3ZpcnRp
by9saW51eC9rZXJuZWwuaAo+Pj4gKysrIGIvdG9vbHMvdmlydGlvL2xpbnV4L2tlcm5lbC5oCj4+
PiBAQCAtMTAsNiArMTAsNyBAQAo+Pj4gwqAgI2luY2x1ZGUgPHN0ZGFyZy5oPgo+Pj4gwqAgwqAg
I2luY2x1ZGUgPGxpbnV4L2NvbXBpbGVyLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L2NvbnRhaW5l
cl9vZi5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L2xvZzIuaD4KPj4+IMKgICNpbmNsdWRlIDxs
aW51eC90eXBlcy5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L292ZXJmbG93Lmg+Cj4+PiBAQCAt
MTA3LDEwICsxMDgsNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZnJlZV9wYWdlKHVuc2lnbmVkIGxv
bmcgYWRkcikKPj4+IMKgwqDCoMKgwqAgZnJlZSgodm9pZCAqKWFkZHIpOwo+Pj4gwqAgfQo+Pj4g
wqAgLSNkZWZpbmUgY29udGFpbmVyX29mKHB0ciwgdHlwZSwgbWVtYmVyKSAoe8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgXAo+Pj4gLcKgwqDCoCBjb25zdCB0eXBlb2YoICgodHlwZSAqKTApLT5tZW1i
ZXIgKSAqX19tcHRyID0gKHB0cik7wqDCoMKgIFwKPj4+IC3CoMKgwqAgKHR5cGUgKikoIChjaGFy
ICopX19tcHRyIC0gb2Zmc2V0b2YodHlwZSxtZW1iZXIpICk7fSkKPj4+IC0KPj4+IMKgICMgaWZu
ZGVmIGxpa2VseQo+Pj4gwqAgI8KgIGRlZmluZSBsaWtlbHkoeCnCoMKgwqAgKF9fYnVpbHRpbl9l
eHBlY3QoISEoeCksIDEpKQo+Pj4gwqAgIyBlbmRpZgo+Pj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Zp
cnRpby9saW51eC9tb2R1bGUuaCBiL3Rvb2xzL3ZpcnRpby9saW51eC9tb2R1bGUuaAo+Pj4gaW5k
ZXggOWRmYTk2ZmVhMmIyLi5lMmU3OTFkYmQxMDQgMTAwNjQ0Cj4+PiAtLS0gYS90b29scy92aXJ0
aW8vbGludXgvbW9kdWxlLmgKPj4+ICsrKyBiL3Rvb2xzL3ZpcnRpby9saW51eC9tb2R1bGUuaAo+
Pj4gQEAgLTUsMyArNSw0IEBACj4+PiDCoMKgwqDCoMKgIHN0YXRpYyBfX2F0dHJpYnV0ZV9fKCh1
bnVzZWQpKSBjb25zdCBjaGFyIAo+Pj4gKl9fTU9EVUxFX0xJQ0VOU0VfbmFtZSA9IFwKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBfX01PRFVMRV9MSUNFTlNFX3ZhbHVlCj4+PiDCoCArc3RydWN0IGRl
dmljZTsKPj4KPj4gSXQncyBub3QgdGhlcmUgaW4gaW5jbHVkZS9saW51eC9tb2R1bGUgLSBwbHMg
cHV0IGl0IGluIHRoZQo+PiBzYW1lIGhlcmUgd2hlcmUgaXQgaXMgZm9yIGxpbnV4Lgo+IEkgdW5k
ZXJzdG9vZC4gSSdsbCBhZGQgc29tZSBmaWxlcyB0aGF0IGhhcyB0aGUgZGVmaW5pdGlvbi4KCklu
IHZyaW5naC5jLCAnc3RydWN0IGRldmljZScgaXMgdXNlZCBpbiB2aXJ0aW9fcmluZy5oLiBVcG9u
IAppbnZlc3RpZ2F0aW5nIHRoZSBwcmVwcm9jZXNzZWQgZmlsZSwgaXQgd2FzCgpkaXNjb3ZlcmVk
IHRoYXQgJ3N0cnVjdCBkZXZpY2UnIGlzIGRlZmluZWQgaW4gYml0bWFwLmgsIHdoaWNoIGlzIApp
bmNsdWRlZCBmcm9tIGFyY2hpdGVjdHVyZS1zcGVjaWZpYyBoZWFkZXJzLgoKT24geDg2LCB0aGUg
bmVzdGluZyBpbmNsdWRlcwoKJ2xpbnV4L21vZHVsZS5oJyAtPiAuLi4gLT4gJ2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL21zci5oJyAtPiAKJ2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdW1hc2suaCcgLT4g
J2xpbnV4L2NwdW1hc2suaCcgLT4gJ2xpbnV4L2JpdG1hcC5oJy4KCkNvdWxkIHlvdSBhZHZpc2Ug
b24gdGhlIGFwcHJvcHJpYXRlIHdheSB0byBpbmNsdWRlIHRoaXMgZmlsZT8KCj4+PiAtLSAKPj4+
IDIuMjUuMQo+Cj4gQmVzdCByZWdhcmRzLAo+Cj4gU2h1bnN1a2UuCj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
