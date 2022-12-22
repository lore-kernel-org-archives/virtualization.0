Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24DFC4332F
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 04:19:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EA948133A;
	Thu, 22 Dec 2022 04:19:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6EA948133A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PKPk6Hvc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fC6Ju8NAsh2N; Thu, 22 Dec 2022 04:19:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D47DE812D9;
	Thu, 22 Dec 2022 04:19:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D47DE812D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1855C0071;
	Thu, 22 Dec 2022 04:19:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD555C0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 04:19:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B814360AC3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 04:19:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B814360AC3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PKPk6Hvc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id prPVAZ6OHlMQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 04:19:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0F09607F7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0F09607F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 04:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671682769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0mH3oOfXNbjXLHYuolZ32GbumyIJzP4ESKq36TBA8l8=;
 b=PKPk6HvcWvLHZToHdnQvOPNwuYOcd5hXmM32Uf0W2mjMpT0SrhrKM7NqmkLAWPov+VknUw
 uiuEYJJ2ppJc75TsLH5kqJBdn1o8GMJ+64TUiufCSsvT2fgINiHO1hKfAh0XCo3HINuA8z
 bjhJebhpACKF2aLJ4Cxp5aBQBpEhd24=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-155-gSD5bhOKPH2QF28jmaj8FQ-1; Wed, 21 Dec 2022 23:19:23 -0500
X-MC-Unique: gSD5bhOKPH2QF28jmaj8FQ-1
Received: by mail-pl1-f199.google.com with SMTP id
 b17-20020a170903229100b00189da3b178bso651473plh.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 20:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0mH3oOfXNbjXLHYuolZ32GbumyIJzP4ESKq36TBA8l8=;
 b=rHP4PSbDn8+WHo96vcRph65oxNT9ZUUOKCTGHW2qErhnJrPqa34e8ZTbYcwtMAM8u3
 Kg4W8R9mFJvvpDONaNOCjq+nfYFpuSFc1d3lUjbGP5Nbtc4AAxggFDQivbDzRobcgjwO
 c9y6u/VbNgP8JPvVOa4Q646RdoqVS6nyNmD+jnXT103ouSUR8ZjlmWT7nZ8WJ7mhlgtb
 uRLX+DObSxFy70C1LfKP6yBctyj159EuX0ztEDnQxneu/rxjULF3esjR8DnBzkEq9Zc2
 rddlszdOLtTP+z3LEGr4JpvPzp5PH1K+qJHPfHL0nbQ+tnzINvu9nfBWlfsns7SSdJe1
 j5hA==
X-Gm-Message-State: AFqh2kpjqsFgYplrRhf4aZD9Ub85rneU+CNFOA/HHpAp0UgC+U1J2Xrt
 FNycke77f+POHRD6zRRHXEE93wtL/oPaq+T49ozaL7B0etj3Wpkg5CqsllQdcuXMhAnHPg3Cc5l
 DqO1mt9z8XfEANjlTzUoI17ISoGWiEzSeznrisXfiNA==
X-Received: by 2002:aa7:96ec:0:b0:574:3b4e:1cbf with SMTP id
 i12-20020aa796ec000000b005743b4e1cbfmr4892997pfq.6.1671682762518; 
 Wed, 21 Dec 2022 20:19:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuKWT574oUOFYNCMz80T1Z1j80xvWLo+SP9Aqhw3A+inWm0X9J2tfCjbK+qrt2KsSY5h33Dpw==
X-Received: by 2002:aa7:96ec:0:b0:574:3b4e:1cbf with SMTP id
 i12-20020aa796ec000000b005743b4e1cbfmr4892982pfq.6.1671682762208; 
 Wed, 21 Dec 2022 20:19:22 -0800 (PST)
Received: from [10.72.13.15] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 i22-20020aa796f6000000b0057630286100sm11183084pfq.164.2022.12.21.20.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Dec 2022 20:19:21 -0800 (PST)
Message-ID: <11aa3331-a262-bc97-193c-d1c9a9214541@redhat.com>
Date: Thu, 22 Dec 2022 12:19:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH 3/4] vdpa_sim: support vendor satistics
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20221221061652.15202-1-jasowang@redhat.com>
 <20221221061652.15202-4-jasowang@redhat.com>
 <20221221133414.teizf56exrf5tqvj@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221221133414.teizf56exrf5tqvj@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

CuWcqCAyMDIyLzEyLzIxIDIxOjM0LCBTdGVmYW5vIEdhcnphcmVsbGEg5YaZ6YGTOgo+IE9uIFdl
ZCwgRGVjIDIxLCAyMDIyIGF0IDAyOjE2OjUxUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4K
PiBMaXR0bGUgdHlwbyBpbiB0aGUgdGl0bGUgcy9zYXRpc3RpY3Mvc3RhdGlzdGljcwoKCkZpeGVk
LgoKCj4KPj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IGNvbmZpZyBvcHMgY2FsbGJhY2sgdG8gYWxs
b3cgaW5kaXZpZHVhbAo+PiBzaW11bGF0b3IgdG8gaW1wbGVtZW50IHRoZSB2ZW5kb3Igc3RhdHMg
Y2FsbGJhY2suCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+Cj4+IC0tLQo+PiBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyB8IDEzICsr
KysrKysrKysrKysKPj4gZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmggfMKgIDMgKysr
Cj4+IDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgCj4+IGIvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltLmMKPj4gaW5kZXggNTVhYWEwMjNhNmUyLi4wMmU4OTJmODE5ZTcgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+ICsrKyBiL2RyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+IEBAIC00MjYsNiArNDI2LDE4IEBAIHN0YXRp
YyBpbnQgdmRwYXNpbV9nZXRfdnFfc3RhdGUoc3RydWN0IAo+PiB2ZHBhX2RldmljZSAqdmRwYSwg
dTE2IGlkeCwKPj4gwqDCoMKgwqByZXR1cm4gMDsKPj4gfQo+Pgo+PiArc3RhdGljIGludCB2ZHBh
c2ltX2dldF92cV9zdGF0cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHUxNiBpZHgsCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNrX2J1ZmYgKm1zZywKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbmV0bGlua19leHRfYWNrICpleHRh
Y2spCj4+ICt7Cj4+ICvCoMKgwqAgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3Np
bSh2ZHBhKTsKPj4gKwo+PiArwqDCoMKgIGlmICh2ZHBhc2ltLT5kZXZfYXR0ci5nZXRfc3RhdHMp
Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gdmRwYXNpbS0+ZGV2X2F0dHIuZ2V0X3N0YXRzKHZk
cGFzaW0sIGlkeCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbXNnLCBleHRhY2spOwo+PiArwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Cj4g
TWF5YmUgLUVPUE5PVFNVUFAgaXMgYmV0dGVyIHdoZW4gdGhlIGRldmljZSBkb2Vzbid0IHN1cHBv
cnQgaXQuCj4gTGlrZSB3ZSBkbyBpbiB2ZW5kb3Jfc3RhdHNfZmlsbCgpIGluIGRyaXZlcnMvdmRw
YS92ZHBhLmMKPgoKVGhhdCdzIHJpZ2h0LgoKCj4+ICt9Cj4+ICsKPj4gc3RhdGljIHUzMiB2ZHBh
c2ltX2dldF92cV9hbGlnbihzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4+IHsKPj4gwqDCoMKg
wqByZXR1cm4gVkRQQVNJTV9RVUVVRV9BTElHTjsKPj4gQEAgLTcxMCw2ICs3MjIsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAKPj4gdmRwYXNpbV9jb25maWdfb3BzID0g
ewo+PiDCoMKgwqDCoC5zZXRfdnFfcmVhZHnCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IHZkcGFzaW1f
c2V0X3ZxX3JlYWR5LAo+PiDCoMKgwqDCoC5nZXRfdnFfcmVhZHnCoMKgwqDCoMKgwqDCoMKgwqDC
oCA9IHZkcGFzaW1fZ2V0X3ZxX3JlYWR5LAo+PiDCoMKgwqDCoC5zZXRfdnFfc3RhdGXCoMKgwqDC
oMKgwqDCoMKgwqDCoCA9IHZkcGFzaW1fc2V0X3ZxX3N0YXRlLAo+PiArwqDCoMKgIC5nZXRfdmVu
ZG9yX3ZxX3N0YXRzwqDCoMKgID0gdmRwYXNpbV9nZXRfdnFfc3RhdHMsCj4KPiBTaG91bGQgd2Ug
YWRkIHRoaXMgY2FsbGJhY2sgYWxzbyBpbiB2ZHBhc2ltX2JhdGNoX2NvbmZpZ19vcHM/CgoKWWVz
LgoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBTdGVmYW5vCj4KPj4gwqDCoMKgwqAuZ2V0X3ZxX3N0
YXRlwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX2dldF92cV9zdGF0ZSwKPj4gwqDCoMKg
wqAuZ2V0X3ZxX2FsaWduwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX2dldF92cV9hbGln
biwKPj4gwqDCoMKgwqAuZ2V0X3ZxX2dyb3VwwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2lt
X2dldF92cV9ncm91cCwKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5oIAo+PiBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oCj4+IGluZGV4IDUx
YzA3MGE1NDNmMS4uZDJhMDhjMGFiYWQ3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW0uaAo+PiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0u
aAo+PiBAQCAtNDgsNiArNDgsOSBAQCBzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciB7Cj4+IMKgwqDC
oMKgd29ya19mdW5jX3Qgd29ya19mbjsKPj4gwqDCoMKgwqB2b2lkICgqZ2V0X2NvbmZpZykoc3Ry
dWN0IHZkcGFzaW0gKnZkcGFzaW0sIHZvaWQgKmNvbmZpZyk7Cj4+IMKgwqDCoMKgdm9pZCAoKnNl
dF9jb25maWcpKHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCBjb25zdCB2b2lkICpjb25maWcpOwo+
PiArwqDCoMKgIGludCAoKmdldF9zdGF0cykoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sIHUxNiBp
ZHgsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNrX2J1ZmYgKm1zZywKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbmV0bGlua19leHRfYWNrICpleHRhY2sp
Owo+PiB9Owo+Pgo+PiAvKiBTdGF0ZSBvZiBlYWNoIHZkcGFzaW0gZGV2aWNlICovCj4+IC0tIAo+
PiAyLjI1LjEKPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
