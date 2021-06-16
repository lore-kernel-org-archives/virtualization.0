Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1AAC48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 15:29:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085AC60041
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 15:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085AC60041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B295260A6E;
	Wed, 16 Jun 2021 15:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hXS_NO3_gylf; Wed, 16 Jun 2021 15:29:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3652360A5E;
	Wed, 16 Jun 2021 15:29:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05C7DC000D;
	Wed, 16 Jun 2021 15:29:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9CD6C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9895560A5E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rt-kh5m8YiLp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:29:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC4C360A5B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623857345;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loHXjaH+snUizquVOGFXdAGS2wFtAssCuoNUK+zEZXk=;
 b=LzhhIgt+/E8KhfaBKmgaYP14W8n/tYM/sER23rCmbPJxqWEmQ+Ol48veRHPaGCmt8NjPY/
 mDNl45BVFlqKwGJSdE8gJI25NM1g6epuglbOxP8N5t7wYWVa6AhzEqztw8hQTtDAph2Jyy
 nI2HF9ZxnGPGvjV4jt2KCLpaBjVqfdY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-ubj1oNs8Oeqzx82t7Rbj0A-1; Wed, 16 Jun 2021 11:29:03 -0400
X-MC-Unique: ubj1oNs8Oeqzx82t7Rbj0A-1
Received: by mail-wr1-f71.google.com with SMTP id
 q15-20020adfc50f0000b0290111f48b865cso1430903wrf.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 08:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=loHXjaH+snUizquVOGFXdAGS2wFtAssCuoNUK+zEZXk=;
 b=h8ifM5QBRbDkLDNjbXg2tJNgkbwfcHR5saZrF/mvqZP8n5M1bbANiSo8cWOexpwVkP
 V4n+db0L1y1M5Njs5pCl1Grfrn19da0Ib2/kBuXF6UaAYEnUufb9D6Nr+Ak4UYHcw44W
 xJJ+CtXaDaFlsWJF7oc/p6mekEEKZvPjplj0pzOI7l/gnFuJU7i8Kw1dlnlJ7gRFsVLe
 oFwkBWbTgsxoLDfX3CGYaNDrrUNy5HWRN/huCLH1Em+/tDQlok09i8DbI1L6BjP/mt0B
 c6DJaMX+9NxfCtvWYCLmxl0fYdoA0UuSuU8bZB0Vc4UZbfxSfX+X63gBb2QDtgYk8X1O
 1Xfw==
X-Gm-Message-State: AOAM532x/7LK2QB/D8snFRG1ohCcibsC5se6bBaWYitUmaVFO6dFV6SM
 /eFy7k9d6jyk+E9x6aWsiDwzNoBDzK+qQQ/XGTPXSaufy0vlidDWwsLm7Ol1faURV98tUZ+Odsu
 AvuKOU4Mv/znmwAwwcwob5JaTMi3kJ2POsTLy9q1rtA==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr6214502wru.77.1623857342707;
 Wed, 16 Jun 2021 08:29:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJww2Pu5vVjE6MjPOz8ZmDG/gXcWdwBxOIwn5bdbiZvyd47pKBtqNWTde6Bs/ZdGOQmWSbzHnw==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr6214481wru.77.1623857342495;
 Wed, 16 Jun 2021 08:29:02 -0700 (PDT)
Received: from [192.168.43.95] ([37.172.247.238])
 by smtp.gmail.com with ESMTPSA id 25sm5158567wmk.20.2021.06.16.08.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 08:29:02 -0700 (PDT)
Subject: Re: [PATCH v4 4/6] iommu/dma: Pass address limit rather than size to
 iommu_setup_dma_ops()
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rjw@rjwysocki.net,
 lenb@kernel.org, joro@8bytes.org, mst@redhat.com
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-5-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <6d139529-9539-fbe4-8f85-da39461047ba@redhat.com>
Date: Wed, 16 Jun 2021 17:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-5-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, sudeep.holla@arm.com,
 robin.murphy@arm.com, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, guohanjun@huawei.com, will@kernel.org,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
 baolu.lu@linux.intel.com
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgSmVhbiwKCk9uIDYvMTAvMjEgOTo1MSBBTSwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3Rl
Ogo+IFBhc3NpbmcgYSA2NC1iaXQgYWRkcmVzcyB3aWR0aCB0byBpb21tdV9zZXR1cF9kbWFfb3Bz
KCkgaXMgdmFsaWQgb24KPiB2aXJ0dWFsIHBsYXRmb3JtcywgYnV0IGlzbid0IGN1cnJlbnRseSBw
b3NzaWJsZS4gVGhlIG92ZXJmbG93IGNoZWNrIGluCj4gaW9tbXVfZG1hX2luaXRfZG9tYWluKCkg
cHJldmVudHMgdGhpcyBldmVuIHdoZW4gQGRtYV9iYXNlIGlzbid0IDAuIFBhc3MKPiBhIGxpbWl0
IGFkZHJlc3MgaW5zdGVhZCBvZiBhIHNpemUsIHNvIGNhbGxlcnMgZG9uJ3QgaGF2ZSB0byBmYWtl
IGEgc2l6ZQo+IHRvIHdvcmsgYXJvdW5kIHRoZSBjaGVjay4KPgo+IFNpZ25lZC1vZmYtYnk6IEpl
YW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPgo+IC0tLQo+ICBp
bmNsdWRlL2xpbnV4L2RtYS1pb21tdS5oICAgfCAgNCArKy0tCj4gIGFyY2gvYXJtNjQvbW0vZG1h
LW1hcHBpbmcuYyB8ICAyICstCj4gIGRyaXZlcnMvaW9tbXUvYW1kL2lvbW11LmMgICB8ICAyICst
Cj4gIGRyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgICB8IDEyICsrKysrKy0tLS0tLQo+ICBkcml2
ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCAgMiArLQo+ICA1IGZpbGVzIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvZG1hLWlvbW11LmggYi9pbmNsdWRlL2xpbnV4L2RtYS1pb21tdS5oCj4gaW5kZXggNmU3NWEy
ZDY4OWI0Li43NThjYTQ2OTQyNTcgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9kbWEtaW9t
bXUuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvZG1hLWlvbW11LmgKPiBAQCAtMTksNyArMTksNyBA
QCBpbnQgaW9tbXVfZ2V0X21zaV9jb29raWUoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLCBk
bWFfYWRkcl90IGJhc2UpOwo+ICB2b2lkIGlvbW11X3B1dF9kbWFfY29va2llKHN0cnVjdCBpb21t
dV9kb21haW4gKmRvbWFpbik7Cj4gIAo+ICAvKiBTZXR1cCBjYWxsIGZvciBhcmNoIERNQSBtYXBw
aW5nIGNvZGUgKi8KPiAtdm9pZCBpb21tdV9zZXR1cF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRl
diwgdTY0IGRtYV9iYXNlLCB1NjQgc2l6ZSk7Cj4gK3ZvaWQgaW9tbXVfc2V0dXBfZG1hX29wcyhz
dHJ1Y3QgZGV2aWNlICpkZXYsIHU2NCBkbWFfYmFzZSwgdTY0IGRtYV9saW1pdCk7Cj4gIAo+ICAv
KiBUaGUgRE1BIEFQSSBpc24ndCBfcXVpdGVfIHRoZSB3aG9sZSBzdG9yeSwgdGhvdWdoLi4uICov
Cj4gIC8qCj4gQEAgLTUwLDcgKzUwLDcgQEAgc3RydWN0IG1zaV9tc2c7Cj4gIHN0cnVjdCBkZXZp
Y2U7Cj4gIAo+ICBzdGF0aWMgaW5saW5lIHZvaWQgaW9tbXVfc2V0dXBfZG1hX29wcyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHU2NCBkbWFfYmFzZSwKPiAtCQl1NjQgc2l6ZSkKPiArCQkJCSAgICAgICB1
NjQgZG1hX2xpbWl0KQo+ICB7Cj4gIH0KPiAgCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbW0v
ZG1hLW1hcHBpbmcuYyBiL2FyY2gvYXJtNjQvbW0vZG1hLW1hcHBpbmcuYwo+IGluZGV4IDRiZjFk
ZDNlYjA0MS4uN2JkMWQyMTk5MTQxIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvbW0vZG1hLW1h
cHBpbmcuYwo+ICsrKyBiL2FyY2gvYXJtNjQvbW0vZG1hLW1hcHBpbmcuYwo+IEBAIC01MCw3ICs1
MCw3IEBAIHZvaWQgYXJjaF9zZXR1cF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IGRt
YV9iYXNlLCB1NjQgc2l6ZSwKPiAgCj4gIAlkZXYtPmRtYV9jb2hlcmVudCA9IGNvaGVyZW50Owo+
ICAJaWYgKGlvbW11KQo+IC0JCWlvbW11X3NldHVwX2RtYV9vcHMoZGV2LCBkbWFfYmFzZSwgc2l6
ZSk7Cj4gKwkJaW9tbXVfc2V0dXBfZG1hX29wcyhkZXYsIGRtYV9iYXNlLCBzaXplIC0gZG1hX2Jh
c2UgLSAxKTsKSSBkb24ndCBnZXTCoCBzaXplIC0gZG1hX2Jhc2UgLSAxPwo+ICAKPiAgI2lmZGVm
IENPTkZJR19YRU4KPiAgCWlmICh4ZW5fc3dpb3RsYl9kZXRlY3QoKSkKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvYW1kL2lvbW11LmMKPiBp
bmRleCAzYWM0MmJiZGVmYzYuLjk0Yjk2ZDgxZmNmZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lv
bW11L2FtZC9pb21tdS5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuYwo+IEBAIC0x
NzEzLDcgKzE3MTMsNyBAQCBzdGF0aWMgdm9pZCBhbWRfaW9tbXVfcHJvYmVfZmluYWxpemUoc3Ry
dWN0IGRldmljZSAqZGV2KQo+ICAJLyogRG9tYWlucyBhcmUgaW5pdGlhbGl6ZWQgZm9yIHRoaXMg
ZGV2aWNlIC0gaGF2ZSBhIGxvb2sgd2hhdCB3ZSBlbmRlZCB1cCB3aXRoICovCj4gIAlkb21haW4g
PSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYoZGV2KTsKPiAgCWlmIChkb21haW4tPnR5cGUgPT0g
SU9NTVVfRE9NQUlOX0RNQSkKPiAtCQlpb21tdV9zZXR1cF9kbWFfb3BzKGRldiwgSU9WQV9TVEFS
VF9QRk4gPDwgUEFHRV9TSElGVCwgMCk7Cj4gKwkJaW9tbXVfc2V0dXBfZG1hX29wcyhkZXYsIElP
VkFfU1RBUlRfUEZOIDw8IFBBR0VfU0hJRlQsIFU2NF9NQVgpOwo+ICAJZWxzZQo+ICAJCXNldF9k
bWFfb3BzKGRldiwgTlVMTCk7Cj4gIH0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9kbWEt
aW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPiBpbmRleCA3YmNkZDEyMDU1MzUu
LmM2MmUxOWJlZDMwMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCj4g
KysrIGIvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwo+IEBAIC0zMTksMTYgKzMxOSwxNiBAQCBz
dGF0aWMgYm9vbCBkZXZfaXNfdW50cnVzdGVkKHN0cnVjdCBkZXZpY2UgKmRldikKPiAgICogaW9t
bXVfZG1hX2luaXRfZG9tYWluIC0gSW5pdGlhbGlzZSBhIERNQSBtYXBwaW5nIGRvbWFpbgo+ICAg
KiBAZG9tYWluOiBJT01NVSBkb21haW4gcHJldmlvdXNseSBwcmVwYXJlZCBieSBpb21tdV9nZXRf
ZG1hX2Nvb2tpZSgpCj4gICAqIEBiYXNlOiBJT1ZBIGF0IHdoaWNoIHRoZSBtYXBwYWJsZSBhZGRy
ZXNzIHNwYWNlIHN0YXJ0cwo+IC0gKiBAc2l6ZTogU2l6ZSBvZiBJT1ZBIHNwYWNlCj4gKyAqIEBs
aW1pdDogTGFzdCBhZGRyZXNzIG9mIHRoZSBJT1ZBIHNwYWNlCj4gICAqIEBkZXY6IERldmljZSB0
aGUgZG9tYWluIGlzIGJlaW5nIGluaXRpYWxpc2VkIGZvcgo+ICAgKgo+IC0gKiBAYmFzZSBhbmQg
QHNpemUgc2hvdWxkIGJlIGV4YWN0IG11bHRpcGxlcyBvZiBJT01NVSBwYWdlIGdyYW51bGFyaXR5
IHRvCj4gKyAqIEBiYXNlIGFuZCBAbGltaXQgKyAxIHNob3VsZCBiZSBleGFjdCBtdWx0aXBsZXMg
b2YgSU9NTVUgcGFnZSBncmFudWxhcml0eSB0bwo+ICAgKiBhdm9pZCByb3VuZGluZyBzdXJwcmlz
ZXMuIElmIG5lY2Vzc2FyeSwgd2UgcmVzZXJ2ZSB0aGUgcGFnZSBhdCBhZGRyZXNzIDAKPiAgICog
dG8gZW5zdXJlIGl0IGlzIGFuIGludmFsaWQgSU9WQS4gSXQgaXMgc2FmZSB0byByZWluaXRpYWxp
c2UgYSBkb21haW4sIGJ1dAo+ICAgKiBhbnkgY2hhbmdlIHdoaWNoIGNvdWxkIG1ha2UgcHJpb3Ig
SU9WQXMgaW52YWxpZCB3aWxsIGZhaWwuCj4gICAqLwo+ICBzdGF0aWMgaW50IGlvbW11X2RtYV9p
bml0X2RvbWFpbihzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIGRtYV9hZGRyX3QgYmFzZSwK
PiAtCQl1NjQgc2l6ZSwgc3RydWN0IGRldmljZSAqZGV2KQo+ICsJCQkJIGRtYV9hZGRyX3QgbGlt
aXQsIHN0cnVjdCBkZXZpY2UgKmRldikKPiAgewo+ICAJc3RydWN0IGlvbW11X2RtYV9jb29raWUg
KmNvb2tpZSA9IGRvbWFpbi0+aW92YV9jb29raWU7Cj4gIAl1bnNpZ25lZCBsb25nIG9yZGVyLCBi
YXNlX3BmbjsKPiBAQCAtMzQ2LDcgKzM0Niw3IEBAIHN0YXRpYyBpbnQgaW9tbXVfZG1hX2luaXRf
ZG9tYWluKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgZG1hX2FkZHJfdCBiYXNlLAo+ICAJ
LyogQ2hlY2sgdGhlIGRvbWFpbiBhbGxvd3MgYXQgbGVhc3Qgc29tZSBhY2Nlc3MgdG8gdGhlIGRl
dmljZS4uLiAqLwo+ICAJaWYgKGRvbWFpbi0+Z2VvbWV0cnkuZm9yY2VfYXBlcnR1cmUpIHsKPiAg
CQlpZiAoYmFzZSA+IGRvbWFpbi0+Z2VvbWV0cnkuYXBlcnR1cmVfZW5kIHx8Cj4gLQkJICAgIGJh
c2UgKyBzaXplIDw9IGRvbWFpbi0+Z2VvbWV0cnkuYXBlcnR1cmVfc3RhcnQpIHsKPiArCQkgICAg
bGltaXQgPCBkb21haW4tPmdlb21ldHJ5LmFwZXJ0dXJlX3N0YXJ0KSB7Cj4gIAkJCXByX3dhcm4o
InNwZWNpZmllZCBETUEgcmFuZ2Ugb3V0c2lkZSBJT01NVSBjYXBhYmlsaXR5XG4iKTsKPiAgCQkJ
cmV0dXJuIC1FRkFVTFQ7Cj4gIAkJfQo+IEBAIC0xMzA4LDcgKzEzMDgsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGRtYV9tYXBfb3BzIGlvbW11X2RtYV9vcHMgPSB7Cj4gICAqIFRoZSBJT01NVSBj
b3JlIGNvZGUgYWxsb2NhdGVzIHRoZSBkZWZhdWx0IERNQSBkb21haW4sIHdoaWNoIHRoZSB1bmRl
cmx5aW5nCj4gICAqIElPTU1VIGRyaXZlciBuZWVkcyB0byBzdXBwb3J0IHZpYSB0aGUgZG1hLWlv
bW11IGxheWVyLgo+ICAgKi8KPiAtdm9pZCBpb21tdV9zZXR1cF9kbWFfb3BzKHN0cnVjdCBkZXZp
Y2UgKmRldiwgdTY0IGRtYV9iYXNlLCB1NjQgc2l6ZSkKPiArdm9pZCBpb21tdV9zZXR1cF9kbWFf
b3BzKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IGRtYV9iYXNlLCB1NjQgZG1hX2xpbWl0KQo+ICB7
Cj4gIAlzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9k
ZXYoZGV2KTsKPiAgCj4gQEAgLTEzMjAsNyArMTMyMCw3IEBAIHZvaWQgaW9tbXVfc2V0dXBfZG1h
X29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHU2NCBkbWFfYmFzZSwgdTY0IHNpemUpCj4gIAkgKiB1
bmRlcmx5aW5nIElPTU1VIGRyaXZlciBuZWVkcyB0byBzdXBwb3J0IHZpYSB0aGUgZG1hLWlvbW11
IGxheWVyLgo+ICAJICovCj4gIAlpZiAoZG9tYWluLT50eXBlID09IElPTU1VX0RPTUFJTl9ETUEp
IHsKPiAtCQlpZiAoaW9tbXVfZG1hX2luaXRfZG9tYWluKGRvbWFpbiwgZG1hX2Jhc2UsIHNpemUs
IGRldikpCj4gKwkJaWYgKGlvbW11X2RtYV9pbml0X2RvbWFpbihkb21haW4sIGRtYV9iYXNlLCBk
bWFfbGltaXQsIGRldikpCj4gIAkJCWdvdG8gb3V0X2VycjsKPiAgCQlkZXYtPmRtYV9vcHMgPSAm
aW9tbXVfZG1hX29wczsKPiAgCX0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9p
b21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4gaW5kZXggYmUzNTI4NGEyMDE2
Li44NWYxODM0MjYwM2MgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
Cj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4gQEAgLTUxNzEsNyArNTE3MSw3
IEBAIHN0YXRpYyB2b2lkIGludGVsX2lvbW11X3Byb2JlX2ZpbmFsaXplKHN0cnVjdCBkZXZpY2Ug
KmRldikKPiAgCj4gIAlpZiAoZG9tYWluICYmIGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5f
RE1BKQo+ICAJCWlvbW11X3NldHVwX2RtYV9vcHMoZGV2LCBiYXNlLAo+IC0JCQkJICAgIF9fRE9N
QUlOX01BWF9BRERSKGRtYXJfZG9tYWluLT5nYXcpIC0gYmFzZSk7Cj4gKwkJCQkgICAgX19ET01B
SU5fTUFYX0FERFIoZG1hcl9kb21haW4tPmdhdykpOwo+ICAJZWxzZQo+ICAJCXNldF9kbWFfb3Bz
KGRldiwgTlVMTCk7Cj4gIH0KVGhhbmtzCgpFcmljCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
