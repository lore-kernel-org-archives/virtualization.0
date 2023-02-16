Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231E4C61DA4
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 04:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92E6780DF9;
	Thu, 16 Feb 2023 04:43:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92E6780DF9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VTkjZLv4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bc4T9pSe4d3t; Thu, 16 Feb 2023 04:43:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BCB8780D47;
	Thu, 16 Feb 2023 04:43:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCB8780D47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D22BC0033;
	Thu, 16 Feb 2023 04:43:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBD69C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 04:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C037B600BA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 04:43:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C037B600BA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VTkjZLv4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Hk-EMsPkdnT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 04:43:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 010B960B8C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 010B960B8C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 04:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676522589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DDHO8i0zvrnMlu2LxipZBzY2ZSSiL5SyYkVWHiaTdo=;
 b=VTkjZLv4aDGdghk9qh2B1loERMLXGSuuiNwNJDRNq6xYYJxjU+ng44yk/8UncSWzcvYAeU
 cKzDyTgnLPXOQHRvMKJnUBGf7AOPalBqKyKj610Eg8YUd3ddz12iEH4TegLdul71+F7ppr
 XkEi05UPVUDKpER5V8bTfDl7+dBMYVs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-404-HxrxBWPhO_G6YcTkknCKLw-1; Wed, 15 Feb 2023 23:43:08 -0500
X-MC-Unique: HxrxBWPhO_G6YcTkknCKLw-1
Received: by mail-pf1-f198.google.com with SMTP id
 x2-20020a056a000bc200b005a8ea29c7a6so589205pfu.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 20:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3DDHO8i0zvrnMlu2LxipZBzY2ZSSiL5SyYkVWHiaTdo=;
 b=OM/EHklnzWAkJpXCSCxMiwPQ7CdRG8v2FxCUY851+Y1e0Id1i7vnNXb9SwwQz2Kx+0
 weEX6BlNCkRcDdQHhGjB/uEIqVzD74Tm6Flta4NgxLkEXbo1YKSMIJ3uDrJ9BDmuhJCi
 Q7FXw0tAUpjNapQXHVvEfdXN38t3knJz2x/qvqheGKyiXyIQortPsQY+Iw2Qc70G5xW9
 h2fu3GqBuoPhq0GVfzIHAg+MkAi+CyfhXHjcSq4j2erTHC56S3djsBLm7LIVc5i5iW/d
 llN613wCa9aC9lwBesoKlm8IsLK6QfZZq7VwfXA8rINmpKg7MulhlsAr8janf2VBdwSF
 9oLg==
X-Gm-Message-State: AO0yUKU7SkShDOMelz+TtyePTqMaHWn0HOqNZsl6jF6PimgY8SR0N0PR
 fhDSrgOntWwjAE/fQZeryx44GNv81aMDMa/EF0yIL6yUYglziIDN+n3lTy53UHE78JAKCOtRlcr
 Xgu/e02CJJzAm62fmfjgj7tisAIL+UeU2bt1zBTID9g==
X-Received: by 2002:a17:90b:4c04:b0:234:bf0:86bc with SMTP id
 na4-20020a17090b4c0400b002340bf086bcmr5369922pjb.31.1676522587176; 
 Wed, 15 Feb 2023 20:43:07 -0800 (PST)
X-Google-Smtp-Source: AK7set/qQ5O/TZ0PJALyrxA2Lethp9rxzMGA6y2yAhomtgRtTLlXGq4nNUzsUdYKVT2TS5pjlJl+Xw==
X-Received: by 2002:a17:90b:4c04:b0:234:bf0:86bc with SMTP id
 na4-20020a17090b4c0400b002340bf086bcmr5369907pjb.31.1676522586789; 
 Wed, 15 Feb 2023 20:43:06 -0800 (PST)
Received: from [10.72.12.253] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a17090aec0200b00233b5d6b4b5sm2306741pjy.16.2023.02.15.20.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Feb 2023 20:43:06 -0800 (PST)
Message-ID: <3bb88db8-1283-f16d-d16a-5d3fb958b584@redhat.com>
Date: Thu, 16 Feb 2023 12:43:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: Nanyong Sun <sunnanyong@huawei.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, mst@redhat.com
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230207120843.1580403-1-sunnanyong@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, wangrong68@huawei.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev
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

CuWcqCAyMDIzLzIvNyAyMDowOCwgTmFueW9uZyBTdW4g5YaZ6YGTOgo+IEZyb206IFJvbmcgV2Fu
ZyA8d2FuZ3Jvbmc2OEBodWF3ZWkuY29tPgo+Cj4gT25jZSBlbmFibGUgaW9tbXUgZG9tYWluIGZv
ciBvbmUgZGV2aWNlLCB0aGUgTVNJCj4gdHJhbnNsYXRpb24gdGFibGVzIGhhdmUgdG8gYmUgdGhl
cmUgZm9yIHNvZnR3YXJlLW1hbmFnZWQgTVNJLgo+IE90aGVyd2lzZSwgcGxhdGZvcm0gd2l0aCBz
b2Z0d2FyZS1tYW5hZ2VkIE1TSSB3aXRob3V0IGFuCj4gaXJxIGJ5cGFzcyBmdW5jdGlvbiwgY2Fu
IG5vdCBnZXQgYSBjb3JyZWN0IG1lbW9yeSB3cml0ZSBldmVudAo+IGZyb20gcGNpZSwgd2lsbCBu
b3QgZ2V0IGlycXMuCj4gVGhlIHNvbHV0aW9uIGlzIHRvIG9idGFpbiB0aGUgTVNJIHBoeSBiYXNl
IGFkZHJlc3MgZnJvbQo+IGlvbW11IHJlc2VydmVkIHJlZ2lvbiwgYW5kIHNldCBpdCB0byBpb21t
dSBNU0kgY29va2llLAo+IHRoZW4gdHJhbnNsYXRpb24gdGFibGVzIHdpbGwgYmUgY3JlYXRlZCB3
aGlsZSByZXF1ZXN0IGlycS4KPgo+IENoYW5nZSBsb2cKPiAtLS0tLS0tLS0tCj4KPiB2MS0+djI6
Cj4gLSBhZGQgcmVzdiBpb3RsYiB0byBhdm9pZCBvdmVybGFwIG1hcHBpbmcuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBSb25nIFdhbmcgPHdhbmdyb25nNjhAaHVhd2VpLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBOYW55b25nIFN1biA8c3VubmFueW9uZ0BodWF3ZWkuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9p
b21tdS9pb21tdS5jIHwgIDEgKwo+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgIHwgNTkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQo+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCA1NyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+IGluZGV4IDVmNmE4NWFl
YTUwMS4uYWY5YzA2NGFkOGIyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+
ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+IEBAIC0yNjIzLDYgKzI2MjMsNyBAQCB2b2lk
IGlvbW11X2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9o
ZWFkICpsaXN0KQo+ICAgCWlmIChvcHMtPmdldF9yZXN2X3JlZ2lvbnMpCj4gICAJCW9wcy0+Z2V0
X3Jlc3ZfcmVnaW9ucyhkZXYsIGxpc3QpOwo+ICAgfQo+ICtFWFBPUlRfU1lNQk9MKGlvbW11X2dl
dF9yZXN2X3JlZ2lvbnMpOwo+ICAgCj4gICAvKioKPiAgICAqIGlvbW11X3B1dF9yZXN2X3JlZ2lv
bnMgLSByZWxlYXNlIHJlc2VyZWQgcmVnaW9ucwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0
L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5kZXggZWMzMmY3ODVkZmRlLi5hNTg5
NzlkYThhY2QgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2
ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC00OSw2ICs0OSw3IEBAIHN0cnVjdCB2aG9zdF92ZHBhIHsK
PiAgIAlzdHJ1Y3QgY29tcGxldGlvbiBjb21wbGV0aW9uOwo+ICAgCXN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRwYTsKPiAgIAlzdHJ1Y3QgaGxpc3RfaGVhZCBhc1tWSE9TVF9WRFBBX0lPVExCX0JVQ0tF
VFNdOwo+ICsJc3RydWN0IHZob3N0X2lvdGxiIHJlc3ZfaW90bGI7CgoKTml0OiBpdCBtaWdodCBi
ZSBiZXR0ZXIgdG8gcmVuYW1lIHRoaXMgYXMgcmVzdl9yZWdpb25zLgoKCj4gICAJc3RydWN0IGRl
dmljZSBkZXY7Cj4gICAJc3RydWN0IGNkZXYgY2RldjsKPiAgIAlhdG9taWNfdCBvcGVuZWQ7Cj4g
QEAgLTIxNiw2ICsyMTcsOCBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVzZXQoc3RydWN0IHZo
b3N0X3ZkcGEgKnYpCj4gICAKPiAgIAl2LT5pbl9iYXRjaCA9IDA7Cj4gICAKPiArCXZob3N0X2lv
dGxiX3Jlc2V0KCZ2LT5yZXN2X2lvdGxiKTsKPiArCj4gICAJcmV0dXJuIHZkcGFfcmVzZXQodmRw
YSk7Cj4gICB9Cj4gICAKPiBAQCAtMTAxMyw2ICsxMDE2LDEwIEBAIHN0YXRpYyBpbnQgdmhvc3Rf
dmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAgIAkgICAg
bXNnLT5pb3ZhICsgbXNnLT5zaXplIC0gMSA+IHYtPnJhbmdlLmxhc3QpCj4gICAJCXJldHVybiAt
RUlOVkFMOwo+ICAgCj4gKwlpZiAodmhvc3RfaW90bGJfaXRyZWVfZmlyc3QoJnYtPnJlc3ZfaW90
bGIsIG1zZy0+aW92YSwKPiArCQkJCQltc2ctPmlvdmEgKyBtc2ctPnNpemUgLSAxKSkKPiArCQly
ZXR1cm4gLUVJTlZBTDsKPiArCj4gICAJaWYgKHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0KGlvdGxi
LCBtc2ctPmlvdmEsCj4gICAJCQkJICAgIG1zZy0+aW92YSArIG1zZy0+c2l6ZSAtIDEpKQo+ICAg
CQlyZXR1cm4gLUVFWElTVDsKPiBAQCAtMTEwMyw2ICsxMTEwLDQ1IEBAIHN0YXRpYyBzc2l6ZV90
IHZob3N0X3ZkcGFfY2hyX3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLAo+ICAgCXJldHVy
biB2aG9zdF9jaHJfd3JpdGVfaXRlcihkZXYsIGZyb20pOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBp
bnQgdmhvc3RfdmRwYV9yZXN2X2lvbW11X3JlZ2lvbihzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21h
aW4sIHN0cnVjdCBkZXZpY2UgKmRtYV9kZXYsCj4gKwlzdHJ1Y3Qgdmhvc3RfaW90bGIgKnJlc3Zf
aW90bGIpCj4gK3sKPiArCXN0cnVjdCBsaXN0X2hlYWQgZGV2X3Jlc3ZfcmVnaW9uczsKPiArCXBo
eXNfYWRkcl90IHJlc3ZfbXNpX2Jhc2UgPSAwOwo+ICsJc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9u
ICpyZWdpb247Cj4gKwlpbnQgcmV0ID0gMDsKPiArCWJvb2wgd2l0aF9zd19tc2kgPSBmYWxzZTsK
PiArCWJvb2wgd2l0aF9od19tc2kgPSBmYWxzZTsKPiArCj4gKwlJTklUX0xJU1RfSEVBRCgmZGV2
X3Jlc3ZfcmVnaW9ucyk7Cj4gKwlpb21tdV9nZXRfcmVzdl9yZWdpb25zKGRtYV9kZXYsICZkZXZf
cmVzdl9yZWdpb25zKTsKPiArCj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KHJlZ2lvbiwgJmRldl9y
ZXN2X3JlZ2lvbnMsIGxpc3QpIHsKPiArCQlyZXQgPSB2aG9zdF9pb3RsYl9hZGRfcmFuZ2VfY3R4
KHJlc3ZfaW90bGIsIHJlZ2lvbi0+c3RhcnQsCj4gKwkJCQlyZWdpb24tPnN0YXJ0ICsgcmVnaW9u
LT5sZW5ndGggLSAxLAo+ICsJCQkJMCwgMCwgTlVMTCk7Cj4gKwkJaWYgKHJldCkgewo+ICsJCQl2
aG9zdF9pb3RsYl9yZXNldChyZXN2X2lvdGxiKTsKPiArCQkJYnJlYWs7Cj4gKwkJfQo+ICsKPiAr
CQlpZiAocmVnaW9uLT50eXBlID09IElPTU1VX1JFU1ZfTVNJKQo+ICsJCQl3aXRoX2h3X21zaSA9
IHRydWU7Cj4gKwo+ICsJCWlmIChyZWdpb24tPnR5cGUgPT0gSU9NTVVfUkVTVl9TV19NU0kpIHsK
PiArCQkJcmVzdl9tc2lfYmFzZSA9IHJlZ2lvbi0+c3RhcnQ7Cj4gKwkJCXdpdGhfc3dfbXNpID0g
dHJ1ZTsKPiArCQl9Cj4gKwl9Cj4gKwo+ICsJaWYgKCFyZXQgJiYgIXdpdGhfaHdfbXNpICYmIHdp
dGhfc3dfbXNpKQo+ICsJCXJldCA9IGlvbW11X2dldF9tc2lfY29va2llKGRvbWFpbiwgcmVzdl9t
c2lfYmFzZSk7Cj4gKwo+ICsJaW9tbXVfcHV0X3Jlc3ZfcmVnaW9ucyhkbWFfZGV2LCAmZGV2X3Jl
c3ZfcmVnaW9ucyk7Cj4gKwo+ICsJcmV0dXJuIHJldDsKPiArfQoKCkFzIGRpc2N1c3NlZCBpbiB2
MSwgSSBzdGlsbCBwcmVmZXIgdG8gZmFjdG9yIG91dCB0aGUgY29tbW9uIGxvZ2ljIGFuZCAKbW92
ZSB0aGVtIHRvIGlvbW11LmMuIEl0IGhlbHBzIHRvIHNpbXBsaWZ5IHRoZSBmdXR1cmUgYnVnIGZp
eGluZyBhbmQgCmVuaGFuY2VtZW50LgoKCj4gKwo+ICAgc3RhdGljIGludCB2aG9zdF92ZHBhX2Fs
bG9jX2RvbWFpbihzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+IEBAIC0xMTI4LDExICsxMTc0LDE2IEBAIHN0YXRpYyBp
bnQgdmhvc3RfdmRwYV9hbGxvY19kb21haW4oc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gICAKPiAg
IAlyZXQgPSBpb21tdV9hdHRhY2hfZGV2aWNlKHYtPmRvbWFpbiwgZG1hX2Rldik7Cj4gICAJaWYg
KHJldCkKPiAtCQlnb3RvIGVycl9hdHRhY2g7Cj4gKwkJZ290byBlcnJfYWxsb2NfZG9tYWluOwo+
ICAgCj4gLQlyZXR1cm4gMDsKPiArCXJldCA9IHZob3N0X3ZkcGFfcmVzdl9pb21tdV9yZWdpb24o
di0+ZG9tYWluLCBkbWFfZGV2LCAmdi0+cmVzdl9pb3RsYik7Cj4gKwlpZiAocmV0KQo+ICsJCWdv
dG8gZXJyX2F0dGFjaF9kZXZpY2U7Cj4gICAKPiAtZXJyX2F0dGFjaDoKPiArCXJldHVybiAwOwo+
ICtlcnJfYXR0YWNoX2RldmljZToKPiArCWlvbW11X2RldGFjaF9kZXZpY2Uodi0+ZG9tYWluLCBk
bWFfZGV2KTsKPiArZXJyX2FsbG9jX2RvbWFpbjoKPiAgIAlpb21tdV9kb21haW5fZnJlZSh2LT5k
b21haW4pOwo+ICAgCXJldHVybiByZXQ7Cj4gICB9Cj4gQEAgLTEzODUsNiArMTQzNiw4IEBAIHN0
YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9iZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4gICAJ
CWdvdG8gZXJyOwo+ICAgCX0KPiAgIAo+ICsJdmhvc3RfaW90bGJfaW5pdCgmdi0+cmVzdl9pb3Rs
YiwgMCwgMCk7Cj4gKwo+ICAgCXIgPSBkZXZfc2V0X25hbWUoJnYtPmRldiwgInZob3N0LXZkcGEt
JXUiLCBtaW5vcik7Cj4gICAJaWYgKHIpCj4gICAJCWdvdG8gZXJyOwoKCldlIG5lZWQgY2xlYW4g
cmVzdl9pb3RsYiBkdXJpbmcgcmVsZWFzZSgpLgoKT3RoZXIgbG9va3MgZ29vZC4KClRoYW5rcwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
