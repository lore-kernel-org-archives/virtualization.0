Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5C7C4708F
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:57:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED90C610A0
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED90C610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A718F4045F;
	Tue,  1 Jun 2021 08:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id apMKyh-iWFIP; Tue,  1 Jun 2021 08:57:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDDBA4044F;
	Tue,  1 Jun 2021 08:57:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7082C000D;
	Tue,  1 Jun 2021 08:57:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20B74C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F3FD607E6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xeB3ZauRl8ZV
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:57:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F83760884
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622537858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5371KIE9OwVDsq1I2cb89rYj8W/Ec/f40mj6nTLkLc=;
 b=YiwkqwxdAkPrdsZc7rK6r74H8CenyoW5LXl4mRxKX+jzOfMkJ8pLSeyo1r3tPU7n/qf81e
 w7oeVKhmnQU406NhSJwbud49GLYs7Yp1ucr913NSVecT9Xr7rWa0sz9hLIYP7zoqM5O/WH
 FqpQjMGZNO+BkkZcs2+8nUybnu1YhoA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-T4nJVlvhM_aiG2-9kmQt-A-1; Tue, 01 Jun 2021 04:57:36 -0400
X-MC-Unique: T4nJVlvhM_aiG2-9kmQt-A-1
Received: by mail-pf1-f198.google.com with SMTP id
 s5-20020aa78d450000b02902ace63a7e93so7005248pfe.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Jun 2021 01:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=u5371KIE9OwVDsq1I2cb89rYj8W/Ec/f40mj6nTLkLc=;
 b=kPVs6+y34xJzyK4msj0DYm5ik0hzI0D5nuchQ9J7Xkq002UOwh6rqFkuMPThLjbpQS
 CbDT3p2DLpJTHcwIgLS9ksey4z3E0PQZYdkVBJbQHwnLCJq5mNsrGyHIrViVngRcOJat
 N3ujN5JG7bUWSk6TabE6d3vay1bZmbluILl2ApUvJ2hysexLy31BLjVOY+bJSb4OdxVe
 XOD3pzTypRxCaP7nnf5uxldoXJ4NIGeAvXHxN/Y1hW3bTmiSKDPly9k4fsaV1vFVNgLX
 b78Lutf16IKR0Qugaf67k8dL4jAa3spwhuhkn8tryym3+xkTy83fqlLldcx9a3LkMsdv
 Uj/w==
X-Gm-Message-State: AOAM533bg4n1VPPOhVGSo3cnT/gI7MSO3r6vjMnXaUYtJqxhtS6YDZtw
 7On2wfk6km2mchcUijw19EmQFPyirKjBP8LbP7CX3AuMKB8N9InvvU9Co9MYI8m501fqa3sFpBN
 ReWdK2epWVxUA0c4XnA+gvd4wiyTaDy476/4cbkaaXA==
X-Received: by 2002:a05:6a00:1a8b:b029:28e:7b62:5118 with SMTP id
 e11-20020a056a001a8bb029028e7b625118mr20998351pfv.49.1622537855932; 
 Tue, 01 Jun 2021 01:57:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5RAxna9+eiIbDEdx3jeizRawOrcnnsGMqdT3iHAvCp1MV5jdQt/byK39HONfjJ2sSpOTDBQ==
X-Received: by 2002:a05:6a00:1a8b:b029:28e:7b62:5118 with SMTP id
 e11-20020a056a001a8bb029028e7b625118mr20998335pfv.49.1622537855709; 
 Tue, 01 Jun 2021 01:57:35 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y6sm6254538pjf.40.2021.06.01.01.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 01:57:35 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] vDPA/ifcvf: implement doorbell mapping for ifcvf
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210601062850.4547-1-lingshan.zhu@intel.com>
 <20210601062850.4547-3-lingshan.zhu@intel.com>
 <d286a8f9-ac5c-ba95-777e-df926ea45292@redhat.com>
 <0e40f29a-5d37-796a-5d01-8594b3afbfdb@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5c8ebd49-59fe-31c3-71bf-44bd0bf64e2a@redhat.com>
Date: Tue, 1 Jun 2021 16:57:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <0e40f29a-5d37-796a-5d01-8594b3afbfdb@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIxLzYvMSDkuIvljYg0OjU2LCBaaHUsIExpbmdzaGFuIOWGmemBkzoKPgo+Cj4gT24g
Ni8xLzIwMjEgNDo1MCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4KPj4g5ZyoIDIwMjEvNi8xIOS4
i+WNiDI6MjgsIFpodSBMaW5nc2hhbiDlhpnpgZM6Cj4+PiBUaGlzIGNvbW1pdCBpbXBsZW1lbnRz
IGRvb3JiZWxsIG1hcHBpbmcgZmVhdHVyZSBmb3IgaWZjdmYuCj4+PiBUaGlzIGZlYXR1cmUgbWFw
cyB0aGUgbm90aWZ5IHBhZ2UgdG8gdXNlcnNwYWNlLCB0byBlbGltaW5hdGUKPj4+IHZtZXhpdCB3
aGVuIGtpY2sgYSB2cS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdz
aGFuLnpodUBpbnRlbC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9tYWluLmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysKPj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAyMSBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMgCj4+PiBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+
IGluZGV4IGFiMGFiNWNmMGY2ZS4uZDQxZGIwNDI2MTJjIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lm
Y3ZmX21haW4uYwo+Pj4gQEAgLTQxMyw2ICs0MTMsMjYgQEAgc3RhdGljIGludCBpZmN2Zl92ZHBh
X2dldF92cV9pcnEoc3RydWN0IAo+Pj4gdmRwYV9kZXZpY2UgKnZkcGFfZGV2LAo+Pj4gwqDCoMKg
wqDCoCByZXR1cm4gdmYtPnZyaW5nW3FpZF0uaXJxOwo+Pj4gwqAgfQo+Pj4gwqAgK3N0YXRpYyBz
dHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSAKPj4+IGlmY3ZmX2dldF92cV9ub3RpZmljYXRp
b24oc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MTYgaWR4
KQo+Pj4gK3sKPj4+ICvCoMKgwqAgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIgPSB2ZHBh
X3RvX2FkYXB0ZXIodmRwYV9kZXYpOwo+Pj4gK8KgwqDCoCBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0g
dmRwYV90b192Zih2ZHBhX2Rldik7Cj4+PiArwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0g
YWRhcHRlci0+cGRldjsKPj4+ICvCoMKgwqAgc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEg
YXJlYTsKPj4+ICsKPj4+ICvCoMKgwqAgYXJlYS5hZGRyID0gdmYtPnZyaW5nW2lkeF0ubm90aWZ5
X3BhOwo+Pj4gK8KgwqDCoCBpZiAoIXZmLT5ub3RpZnlfb2ZmX211bHRpcGxpZXIpCj4+PiArwqDC
oMKgwqDCoMKgwqAgYXJlYS5zaXplID0gUEFHRV9TSVpFOwo+Pj4gK8KgwqDCoCBlbHNlCj4+PiAr
wqDCoMKgwqDCoMKgwqAgYXJlYS5zaXplID0gdmYtPm5vdGlmeV9vZmZfbXVsdGlwbGllcjsKPj4+
ICsKPj4+ICvCoMKgwqAgaWYgKGFyZWEuYWRkciAlIFBBR0VfU0laRSkKPj4+ICvCoMKgwqDCoMKg
wqDCoCBJRkNWRl9EQkcocGRldiwgInZxICV1IGRvb3JiZWxsIGFkZHJlc3MgaXMgbm90IFBBR0Vf
U0laRSAKPj4+IGFsaWduZWRcbiIsIGlkeCk7Cj4+Cj4+Cj4+IEkgZG9uJ3Qgc2VlIHRoZSByZWFz
b24gdG8ga2VlcCB0aGlzLCBvciBnZXRfbm90aWZpY2F0aW9uIGlzIG5vdCB0aGUgCj4+IHByb3Bl
ciBwbGFjZSB0byBkbyB0aGlzIGtpbmQgb2Ygd2FybmluZy4KPj4KPj4gVGhhbmtzCj4gc29tZSBj
dXN0b21lcnMgaGF2ZSBldmVyIGNvbXBsYWluZWQgaGF2ZSB0cm91YmxlcyB0byBlbmFibGUgc3Vj
aCAKPiBmZWF0dXJlcyB3aXRoIHRoZWlyIElQLAo+IEkgdGhpbmsgdGhpcyBjYW4gaGVscCB0aGVt
IGRlYnVnLgoKCklmIHlvdSB3YW50IHRvIGRvIHRoaXMsIHRoZSBpZmN2Zl9pbml0X2h3KCkgaXMg
dGhlIHByb3BlciBwbGFjZS4KCk5vdGUgdGhhdCB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCBieSB1
c2Vyc3BhY2UuCgpUaGFua3MKCgo+Cj4gVGhhbmtzCj4+Cj4+Cj4+PiArCj4+PiArwqDCoMKgIHJl
dHVybiBhcmVhOwo+Pj4gK30KPj4+ICsKPj4+IMKgIC8qCj4+PiDCoMKgICogSUZDVkYgY3VycmVu
dGx5IGRvZXMndCBoYXZlIG9uLWNoaXAgSU9NTVUsIHNvIG5vdAo+Pj4gwqDCoCAqIGltcGxlbWVu
dGVkIHNldF9tYXAoKS9kbWFfbWFwKCkvZG1hX3VubWFwKCkKPj4+IEBAIC00NDAsNiArNDYwLDcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgaWZjX3ZkcGFfb3BzIAo+Pj4g
PSB7Cj4+PiDCoMKgwqDCoMKgIC5nZXRfY29uZmlnwqDCoMKgID0gaWZjdmZfdmRwYV9nZXRfY29u
ZmlnLAo+Pj4gwqDCoMKgwqDCoCAuc2V0X2NvbmZpZ8KgwqDCoCA9IGlmY3ZmX3ZkcGFfc2V0X2Nv
bmZpZywKPj4+IMKgwqDCoMKgwqAgLnNldF9jb25maWdfY2LCoCA9IGlmY3ZmX3ZkcGFfc2V0X2Nv
bmZpZ19jYiwKPj4+ICvCoMKgwqAgLmdldF92cV9ub3RpZmljYXRpb24gPSBpZmN2Zl9nZXRfdnFf
bm90aWZpY2F0aW9uLAo+Pj4gwqAgfTsKPj4+IMKgIMKgIHN0YXRpYyBpbnQgaWZjdmZfcHJvYmUo
c3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCAKPj4+IHBjaV9kZXZpY2VfaWQgKmlk
KQo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
