Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BF8C433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 05:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ACD66FC5D;
	Fri,  7 Jan 2022 05:49:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lOgRUHLI-Se8; Fri,  7 Jan 2022 05:49:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC2E56FC5C;
	Fri,  7 Jan 2022 05:49:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66E91C002F;
	Fri,  7 Jan 2022 05:49:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61502C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4619C42479
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KG-Gt95Rh_4j
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:49:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F225E401A4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641534552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYqXS91hOTBdUS0ZUover89cIiyeCMhPqRxOc9sGAS8=;
 b=W9yXKK9kMELWgiQDa0rtByGXKd0gPe3YIA71eVdIN+a+gq+ClJ/p2GOG3whRzwH36Rvj/W
 reRfkIQjvPzmhxPkyO4QFood1fHzI421f+V7yBxXyhIxrB8YYjuWFvMTbNLEe2KkNrJ50z
 fBf1te5CpbhqST/o/xvRVzMo+HxN5bc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-pGuYt0vBMGO3IhuLdbMuLA-1; Fri, 07 Jan 2022 00:49:11 -0500
X-MC-Unique: pGuYt0vBMGO3IhuLdbMuLA-1
Received: by mail-pg1-f197.google.com with SMTP id
 u6-20020a63ef06000000b00341c8aa06d8so3196635pgh.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 21:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OYqXS91hOTBdUS0ZUover89cIiyeCMhPqRxOc9sGAS8=;
 b=TsKHfdf4bvYqteqVfWbW1jUZJsApSbMi9eqFEh6jizrubk7TGQb0WyJdUWbFeu13vr
 Apd5S8MFmV5lrMKZV/Wt/chGiHJPGRn1kN2qrvEliAubV3Wtk24cjLGGX5fHbTH0Gm/D
 IRo+rK5BOxEx8rNbSojaTornUw2stue1SAsfrNPYjwXAym5K9A/22MOmcdOi9Xzo3LwJ
 eiyy4BxTxu5SEI5L88s4jwX5mWCxgIynJCUuW42OYaA079aJos2wQDZoJPpVpMnX2zzg
 Tw2iq+Nzg9jzeVsohrFA6u3PuClc6A+Pp7Pb9cLTWGIubQJDlI2tXjPKFtf4iboXiU37
 43mA==
X-Gm-Message-State: AOAM5339pjs/UKx7QcG1nQH3VpuZ4Isy9eyLSzwbesh+Hr0MA93OFsSu
 vLwgRnbXnBeerjzm2CeWqhh+8SCnqZU9+noA2E27OMwszX+5l6SMTktmq99J21nGdGPfxiq6RJU
 obVVW1bfU+JMSUYT4JG4YmKPT/dAQZir6epyyYwajbQ==
X-Received: by 2002:a62:7b91:0:b0:4ba:d0a2:47c5 with SMTP id
 w139-20020a627b91000000b004bad0a247c5mr63455796pfc.40.1641534550740; 
 Thu, 06 Jan 2022 21:49:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxJ9lmnIAjA0DwT5gJ6SVyNzsRaUTyZZpJv2TlWV4TNJTuv3xGhK/4DAVRmPVmWMrlRxU1aA==
X-Received: by 2002:a62:7b91:0:b0:4ba:d0a2:47c5 with SMTP id
 w139-20020a627b91000000b004bad0a247c5mr63455783pfc.40.1641534550506; 
 Thu, 06 Jan 2022 21:49:10 -0800 (PST)
Received: from [10.72.13.245] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f7sm4532143pfe.71.2022.01.06.21.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jan 2022 21:49:10 -0800 (PST)
Message-ID: <c2f3e368-a364-a61a-6f33-ba2e51af3eb7@redhat.com>
Date: Fri, 7 Jan 2022 13:49:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v7 11/14] vdpa/mlx5: Report max device capabilities
To: Si-Wei Liu <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>,
 mst@redhat.com, virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-12-elic@nvidia.com>
 <a27cf64d-3ce3-bae5-7924-8bb68e318c4f@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <a27cf64d-3ce3-bae5-7924-8bb68e318c4f@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lvivier@redhat.com, eperezma@redhat.com
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

CuWcqCAyMDIyLzEvNyDkuIrljYgxMDoxMiwgU2ktV2VpIExpdSDlhpnpgZM6Cj4KPgo+IE9uIDEv
NS8yMDIyIDM6NDYgQU0sIEVsaSBDb2hlbiB3cm90ZToKPj4gQ29uZmlndXJlIG1heCBzdXBwb3J0
ZWQgdmlydHF1ZXVlcyBhbmQgZmVhdHVyZXMgb24gdGhlIG1hbmFnZW1lbnQKPj4gZGV2aWNlLgo+
PiBUaGlzIGluZm8gY2FuIGJlIHJldHJpZXZlZCB1c2luZzoKPj4KPj4gJCB2ZHBhIG1nbXRkZXYg
c2hvdwo+PiBhdXhpbGlhcnkvbWx4NV9jb3JlLnNmLjE6Cj4+IMKgwqAgc3VwcG9ydGVkX2NsYXNz
ZXMgbmV0Cj4+IMKgwqAgbWF4X3N1cHBvcnRlZF92cXMgMjU3Cj4+IMKgwqAgZGV2X2ZlYXR1cmVz
IENTVU0gR1VFU1RfQ1NVTSBNVFUgSE9TVF9UU080IEhPU1RfVFNPNiBTVEFUVVMgCj4+IENUUkxf
VlEgTVEgXAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ1RSTF9NQUNfQUREUiBW
RVJTSU9OXzEgQUNDRVNTX1BMQVRGT1JNCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8
ZWxpY0BudmlkaWEuY29tPgo+IFJldmlld2VkLWJ5OiBTaS1XZWkgTGl1PHNpLXdlaS5saXVAb3Jh
Y2xlLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+
PiAtLS0KPj4gdjYgLT4gdjc6Cj4+IDEuIEFkZCBzdXBwb3J0ZWQgZmVhdHVyZXMKPj4gwqAgZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMzUgKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTIgZGVs
ZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgCj4+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+IGluZGV4IGFj
NGY2Nzk0YzAzYy4uYTBmODA4ZWUyNGQ2IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMKPj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jCj4+IEBAIC0xODY3LDIyICsxODY3LDI5IEBAIHN0YXRpYyB1NjQgbWx4X3RvX3ZyaXRpb19m
ZWF0dXJlcyh1MTYgCj4+IGRldl9mZWF0dXJlcykKPj4gwqDCoMKgwqDCoCByZXR1cm4gcmVzdWx0
Owo+PiDCoCB9Cj4+IMKgICtzdGF0aWMgdTY0IGdldF9zdXBwb3J0ZWRfZmVhdHVyZXMoc3RydWN0
IG1seDVfY29yZV9kZXYgKm1kZXYpCj4+ICt7Cj4+ICvCoMKgwqAgdTY0IG1seF92ZHBhX2ZlYXR1
cmVzID0gMDsKPj4gK8KgwqDCoCB1MTYgZGV2X2ZlYXR1cmVzOwo+PiArCj4+ICvCoMKgwqAgZGV2
X2ZlYXR1cmVzID0gTUxYNV9DQVBfREVWX1ZEUEFfRU1VTEFUSU9OKG1kZXYsIAo+PiBkZXZpY2Vf
ZmVhdHVyZXNfYml0c19tYXNrKTsKPj4gK8KgwqDCoCBtbHhfdmRwYV9mZWF0dXJlcyB8PSBtbHhf
dG9fdnJpdGlvX2ZlYXR1cmVzKGRldl9mZWF0dXJlcyk7Cj4+ICvCoMKgwqAgaWYgKE1MWDVfQ0FQ
X0RFVl9WRFBBX0VNVUxBVElPTihtZGV2LCB2aXJ0aW9fdmVyc2lvbl8xXzApKQo+PiArwqDCoMKg
wqDCoMKgwqAgbWx4X3ZkcGFfZmVhdHVyZXMgfD0gQklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEp
Owo+PiArwqDCoMKgIG1seF92ZHBhX2ZlYXR1cmVzIHw9IEJJVF9VTEwoVklSVElPX0ZfQUNDRVNT
X1BMQVRGT1JNKTsKPj4gK8KgwqDCoCBtbHhfdmRwYV9mZWF0dXJlcyB8PSBCSVRfVUxMKFZJUlRJ
T19ORVRfRl9DVFJMX1ZRKTsKPj4gK8KgwqDCoCBtbHhfdmRwYV9mZWF0dXJlcyB8PSBCSVRfVUxM
KFZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSKTsKPj4gK8KgwqDCoCBtbHhfdmRwYV9mZWF0dXJl
cyB8PSBCSVRfVUxMKFZJUlRJT19ORVRfRl9NUSk7Cj4+ICvCoMKgwqAgbWx4X3ZkcGFfZmVhdHVy
ZXMgfD0gQklUX1VMTChWSVJUSU9fTkVUX0ZfU1RBVFVTKTsKPj4gK8KgwqDCoCBtbHhfdmRwYV9m
ZWF0dXJlcyB8PSBCSVRfVUxMKFZJUlRJT19ORVRfRl9NVFUpOwo+PiArCj4+ICvCoMKgwqAgcmV0
dXJuIG1seF92ZHBhX2ZlYXR1cmVzOwo+PiArfQo+PiArCj4+IMKgIHN0YXRpYyB1NjQgbWx4NV92
ZHBhX2dldF9kZXZpY2VfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+PiDCoCB7
Cj4+IMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRl
dik7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3Zk
cGFfbmRldihtdmRldik7Cj4+IC3CoMKgwqAgdTE2IGRldl9mZWF0dXJlczsKPj4gLQo+PiAtwqDC
oMKgIGRldl9mZWF0dXJlcyA9IE1MWDVfQ0FQX0RFVl9WRFBBX0VNVUxBVElPTihtdmRldi0+bWRl
diwgCj4+IGRldmljZV9mZWF0dXJlc19iaXRzX21hc2spOwo+PiAtwqDCoMKgIG5kZXYtPm12ZGV2
Lm1seF9mZWF0dXJlcyB8PSBtbHhfdG9fdnJpdGlvX2ZlYXR1cmVzKGRldl9mZWF0dXJlcyk7Cj4+
IC3CoMKgwqAgaWYgKE1MWDVfQ0FQX0RFVl9WRFBBX0VNVUxBVElPTihtdmRldi0+bWRldiwgdmly
dGlvX3ZlcnNpb25fMV8wKSkKPj4gLcKgwqDCoMKgwqDCoMKgIG5kZXYtPm12ZGV2Lm1seF9mZWF0
dXJlcyB8PSBCSVRfVUxMKFZJUlRJT19GX1ZFUlNJT05fMSk7Cj4+IC3CoMKgwqAgbmRldi0+bXZk
ZXYubWx4X2ZlYXR1cmVzIHw9IEJJVF9VTEwoVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKTsKPj4g
LcKgwqDCoCBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMgfD0gQklUX1VMTChWSVJUSU9fTkVUX0Zf
Q1RSTF9WUSk7Cj4+IC3CoMKgwqAgbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzIHw9IEJJVF9VTEwo
VklSVElPX05FVF9GX0NUUkxfTUFDX0FERFIpOwo+PiAtwqDCoMKgIG5kZXYtPm12ZGV2Lm1seF9m
ZWF0dXJlcyB8PSBCSVRfVUxMKFZJUlRJT19ORVRfRl9NUSk7Cj4+IC3CoMKgwqAgbmRldi0+bXZk
ZXYubWx4X2ZlYXR1cmVzIHw9IEJJVF9VTEwoVklSVElPX05FVF9GX1NUQVRVUyk7Cj4+IC3CoMKg
wqAgbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzIHw9IEJJVF9VTEwoVklSVElPX05FVF9GX01UVSk7
Cj4+IMKgIMKgwqDCoMKgwqAgcHJpbnRfZmVhdHVyZXMobXZkZXYsIG5kZXYtPm12ZGV2Lm1seF9m
ZWF0dXJlcywgZmFsc2UpOwo+PiDCoMKgwqDCoMKgIHJldHVybiBuZGV2LT5tdmRldi5tbHhfZmVh
dHVyZXM7Cj4+IEBAIC0yNTcwLDYgKzI1NzcsNyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZf
YWRkKHN0cnVjdCAKPj4gdmRwYV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gLUVOT01FTTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGdvdG8gZXJyX2FsbG9jOwo+PiDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoCBuZGV2LT5tdmRldi5t
bHhfZmVhdHVyZXMgPSBtZ3RkZXYtPm1ndGRldi5zdXBwb3J0ZWRfZmVhdHVyZXM7Cj4+IMKgwqDC
oMKgwqAgbmRldi0+bXZkZXYubWF4X3ZxcyA9IG1heF92cXM7Cj4+IMKgwqDCoMKgwqAgbXZkZXYg
PSAmbmRldi0+bXZkZXY7Cj4+IMKgwqDCoMKgwqAgbXZkZXYtPm1kZXYgPSBtZGV2Owo+PiBAQCAt
MjY5NSw2ICsyNzAzLDkgQEAgc3RhdGljIGludCBtbHg1dl9wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5
X2RldmljZSAKPj4gKmFkZXYsCj4+IMKgwqDCoMKgwqAgbWd0ZGV2LT5tZ3RkZXYuaWRfdGFibGUg
PSBpZF90YWJsZTsKPj4gwqDCoMKgwqDCoCBtZ3RkZXYtPm1ndGRldi5jb25maWdfYXR0cl9tYXNr
ID0gCj4+IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIpIHwKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCSVRfVUxMKFZEUEFfQVRU
Ul9ERVZfTkVUX0NGR19NQVhfVlFQKTsKPj4gK8KgwqDCoCBtZ3RkZXYtPm1ndGRldi5tYXhfc3Vw
cG9ydGVkX3ZxcyA9Cj4+ICvCoMKgwqDCoMKgwqDCoCBNTFg1X0NBUF9ERVZfVkRQQV9FTVVMQVRJ
T04obWRldiwgbWF4X251bV92aXJ0aW9fcXVldWVzKSArIDE7Cj4+ICvCoMKgwqAgbWd0ZGV2LT5t
Z3RkZXYuc3VwcG9ydGVkX2ZlYXR1cmVzID0gZ2V0X3N1cHBvcnRlZF9mZWF0dXJlcyhtZGV2KTsK
Pj4gwqDCoMKgwqDCoCBtZ3RkZXYtPm1hZGV2ID0gbWFkZXY7Cj4+IMKgIMKgwqDCoMKgwqAgZXJy
ID0gdmRwYV9tZ210ZGV2X3JlZ2lzdGVyKCZtZ3RkZXYtPm1ndGRldik7Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
