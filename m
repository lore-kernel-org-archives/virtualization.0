Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EDBC4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 14:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C86BC827C6;
	Mon,  6 Nov 2023 14:33:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C86BC827C6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eS6Z-PZQx5aU; Mon,  6 Nov 2023 14:33:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0065E82335;
	Mon,  6 Nov 2023 14:33:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0065E82335
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB331C008C;
	Mon,  6 Nov 2023 14:33:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07F28C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 14:33:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D32D0827C6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 14:33:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D32D0827C6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FCdHAuM0gySp
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 14:33:03 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EA02827A0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 14:33:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EA02827A0
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-5841a3ffd50so1009636eaf.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Nov 2023 06:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699281182; x=1699885982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hdHOkDDDq2uDsqnfkV1g2ITyJ/uBNt8L8qaNucWn9Lg=;
 b=eBK1Imnufk4qwPSKs3q4As6elL9LVQ6Lem7Tzu1EON5GIPyh72ErLKwOwx7JKWSodE
 mp7x612R4ufnR7rQj0yogNJHf6/8M8LFmHRaEnwWDe/5ihd6CrVb6PGQzXN2Iz/oJwDm
 RBqJH+LPLMR0ovkFHCVn17PWjUKJh6zqFzZM/es16xy+t3/FJNmyptslTKQLI9ZBT1SO
 8vW686XiukX1XLcjHhEZkqu4Tpy7GMqqjTgmj8gaJP0c454SGlqY2T8k/HGi3ufi53dh
 Owy6ssNNl3dRFIfM+CqMsI/GB5B5LSEDUVFTmvZEfXtr5TynFhtx67NzKDPF++4y8V0F
 dAvg==
X-Gm-Message-State: AOJu0YxbZ5QB496SFyd+mW4GD6X/TUsjt2lTayWyG8NjLGq6AXr2GEgl
 h7BX/8gdxMDQz3InI5Dss+UMxOXLtFy5JKAFeqw=
X-Google-Smtp-Source: AGHT+IHyHB4kzvcjkEhTb+3sUVIPXXX0cO5Y7IiQxSg2gu4OXnnfVIuOscNqmkEqJcDtSiyYa7NRTI4+Cg8Mb+uLm9Y=
X-Received: by 2002:a4a:d68a:0:b0:584:1080:f0a5 with SMTP id
 i10-20020a4ad68a000000b005841080f0a5mr31132550oot.1.1699281182420; Mon, 06
 Nov 2023 06:33:02 -0800 (PST)
MIME-Version: 1.0
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <4-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <4-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Nov 2023 15:32:51 +0100
Message-ID: <CAJZ5v0hepKO0QKuBF3d38r=7nG0tjTtEwXdPNPv_2jYPnToUsg@mail.gmail.com>
Subject: Re: [PATCH RFC 04/17] acpi: Do not return struct iommu_ops from
 acpi_iommu_configure_id()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-hyperv@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Robert Moore <robert.moore@intel.com>,
 Thierry Reding <thierry.reding@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 acpica-devel@lists.linuxfoundation.org, Christoph Hellwig <hch@lst.de>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Dexuan Cui <decui@microsoft.com>, Russell King <linux@armlinux.org.uk>,
 linux-riscv@lists.infradead.org, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
 Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org,
 Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
 Albert Ou <aou@eecs.berkeley.edu>, Sven Peter <sven@svenpeter.dev>,
 Haiyang Zhang <haiyangz@microsoft.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Rob Herring <robh+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Robin Murphy <robin.murphy@arm.com>, Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 Hector Martin <marcan@marcan.st>, linux-mips@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, asahi@lists.linux.dev,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
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

T24gRnJpLCBOb3YgMywgMjAyMyBhdCA1OjQ14oCvUE0gSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZp
ZGlhLmNvbT4gd3JvdGU6Cj4KPiBOb3RoaW5nIG5lZWRzIHRoaXMgcG9pbnRlci4gUmV0dXJuIGEg
bm9ybWFsIGVycm9yIGNvZGUgd2l0aCB0aGUgdXN1YWwKPiBJT01NVSBzZW1hbnRpYyB0aGF0IEVO
T0RFViBtZWFucyAndGhlcmUgaXMgbm8gSU9NTVUgZHJpdmVyJy4KPgo+IFNpZ25lZC1vZmYtYnk6
IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+CgpBY2tlZC1ieTogUmFmYWVsIEouIFd5
c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgoKPiAtLS0KPiAgZHJpdmVycy9hY3Bp
L3NjYW4uYyB8IDI0ICsrKysrKysrKysrKysrKy0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwg
MTUgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2FjcGkvc2Nhbi5jIGIvZHJpdmVycy9hY3BpL3NjYW4uYwo+IGluZGV4IGE2ODkxYWQwY2VlZTJj
Li5mYmFiZGUwMDFhMjNhMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2FjcGkvc2Nhbi5jCj4gKysr
IGIvZHJpdmVycy9hY3BpL3NjYW4uYwo+IEBAIC0xNTYyLDggKzE1NjIsNyBAQCBzdGF0aWMgaW5s
aW5lIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKmFjcGlfaW9tbXVfZndzcGVjX29wcyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYpCj4gICAgICAgICByZXR1cm4gZndzcGVjID8gZndzcGVjLT5vcHMgOiBOVUxM
Owo+ICB9Cj4KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKmFjcGlfaW9tbXVfY29u
ZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwKPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgdTMyICppZF9pbikKPiArc3RhdGlj
IGludCBhY3BpX2lvbW11X2NvbmZpZ3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IHUz
MiAqaWRfaW4pCj4gIHsKPiAgICAgICAgIGludCBlcnI7Cj4gICAgICAgICBjb25zdCBzdHJ1Y3Qg
aW9tbXVfb3BzICpvcHM7Cj4gQEAgLTE1NzQsNyArMTU3Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgaW9tbXVfb3BzICphY3BpX2lvbW11X2NvbmZpZ3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYs
Cj4gICAgICAgICAgKi8KPiAgICAgICAgIG9wcyA9IGFjcGlfaW9tbXVfZndzcGVjX29wcyhkZXYp
Owo+ICAgICAgICAgaWYgKG9wcykKPiAtICAgICAgICAgICAgICAgcmV0dXJuIG9wczsKPiArICAg
ICAgICAgICAgICAgcmV0dXJuIDA7Cj4KPiAgICAgICAgIGVyciA9IGlvcnRfaW9tbXVfY29uZmln
dXJlX2lkKGRldiwgaWRfaW4pOwo+ICAgICAgICAgaWYgKGVyciAmJiBlcnIgIT0gLUVQUk9CRV9E
RUZFUikKPiBAQCAtMTU4OSwxMiArMTU4OCwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11
X29wcyAqYWNwaV9pb21tdV9jb25maWd1cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LAo+Cj4gICAg
ICAgICAvKiBJZ25vcmUgYWxsIG90aGVyIGVycm9ycyBhcGFydCBmcm9tIEVQUk9CRV9ERUZFUiAq
Lwo+ICAgICAgICAgaWYgKGVyciA9PSAtRVBST0JFX0RFRkVSKSB7Cj4gLSAgICAgICAgICAgICAg
IHJldHVybiBFUlJfUFRSKGVycik7Cj4gKyAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4gICAg
ICAgICB9IGVsc2UgaWYgKGVycikgewo+ICAgICAgICAgICAgICAgICBkZXZfZGJnKGRldiwgIkFk
ZGluZyB0byBJT01NVSBmYWlsZWQ6ICVkXG4iLCBlcnIpOwo+IC0gICAgICAgICAgICAgICByZXR1
cm4gTlVMTDsKPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7Cj4gICAgICAgICB9Cj4g
LSAgICAgICByZXR1cm4gYWNwaV9pb21tdV9md3NwZWNfb3BzKGRldik7Cj4gKyAgICAgICBpZiAo
IWFjcGlfaW9tbXVfZndzcGVjX29wcyhkZXYpKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVO
T0RFVjsKPiArICAgICAgIHJldHVybiAwOwo+ICB9Cj4KPiAgI2Vsc2UgLyogIUNPTkZJR19JT01N
VV9BUEkgKi8KPiBAQCAtMTYyMyw3ICsxNjI0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpb21t
dV9vcHMgKmFjcGlfaW9tbXVfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwKPiAgaW50
IGFjcGlfZG1hX2NvbmZpZ3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsIGVudW0gZGV2X2RtYV9h
dHRyIGF0dHIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB1MzIgKmlucHV0X2lk
KQo+ICB7Cj4gLSAgICAgICBjb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICppb21tdTsKPiArICAgICAg
IGludCByZXQ7Cj4KPiAgICAgICAgIGlmIChhdHRyID09IERFVl9ETUFfTk9UX1NVUFBPUlRFRCkg
ewo+ICAgICAgICAgICAgICAgICBzZXRfZG1hX29wcyhkZXYsICZkbWFfZHVtbXlfb3BzKTsKPiBA
QCAtMTYzMiwxMCArMTYzMywxNSBAQCBpbnQgYWNwaV9kbWFfY29uZmlndXJlX2lkKHN0cnVjdCBk
ZXZpY2UgKmRldiwgZW51bSBkZXZfZG1hX2F0dHIgYXR0ciwKPgo+ICAgICAgICAgYWNwaV9hcmNo
X2RtYV9zZXR1cChkZXYpOwo+Cj4gLSAgICAgICBpb21tdSA9IGFjcGlfaW9tbXVfY29uZmlndXJl
X2lkKGRldiwgaW5wdXRfaWQpOwo+IC0gICAgICAgaWYgKFBUUl9FUlIoaW9tbXUpID09IC1FUFJP
QkVfREVGRVIpCj4gKyAgICAgICByZXQgPSBhY3BpX2lvbW11X2NvbmZpZ3VyZV9pZChkZXYsIGlu
cHV0X2lkKTsKPiArICAgICAgIGlmIChyZXQgPT0gLUVQUk9CRV9ERUZFUikKPiAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FUFJPQkVfREVGRVI7Cj4KPiArICAgICAgIC8qCj4gKyAgICAgICAgKiBI
aXN0b3JpY2FsbHkgdGhpcyByb3V0aW5lIGRvZXNuJ3QgZmFpbCBkcml2ZXIgcHJvYmluZyBkdWUg
dG8gZXJyb3JzCj4gKyAgICAgICAgKiBpbiBhY3BpX2lvbW11X2NvbmZpZ3VyZSgpCj4gKyAgICAg
ICAgKi8KPiArCj4gICAgICAgICBhcmNoX3NldHVwX2RtYV9vcHMoZGV2LCAwLCBVNjRfTUFYLCBh
dHRyID09IERFVl9ETUFfQ09IRVJFTlQpOwo+Cj4gICAgICAgICByZXR1cm4gMDsKPiAtLQo+IDIu
NDIuMAo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
