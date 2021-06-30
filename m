Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6122CC11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 04:31:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D8A610A6
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 04:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D8A610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A147A4061C;
	Wed, 30 Jun 2021 04:31:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZkhbIQf48cS1; Wed, 30 Jun 2021 04:31:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 00C90405F3;
	Wed, 30 Jun 2021 04:31:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4AE5C0010;
	Wed, 30 Jun 2021 04:31:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5201C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 04:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8F0A83A69
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 04:31:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pt_oMlaeZBka
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 04:31:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D109E82848
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 04:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625027504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQwejWf4VvdZkkob0rPttvdUNgW5Vp/WtPa3+eCIxEI=;
 b=KfEBSm9zt8+eDbnq82cjZioOuEt4xVmbVkpPf/sbmqLjTwQJCfgZgnr+E9kYpW0b0n8aL8
 BXZpwiqYSOC03V2yMd2kp7iB+iG9331kC9MSYhZmRbk0n9FAQcfHqxuAJK7AcPRQRazDWI
 ZQe0QXjR8lBm89jP/YzxciOFDyA+i/0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-fxJs0OQWPJyNS1dU70J8Aw-1; Wed, 30 Jun 2021 00:31:42 -0400
X-MC-Unique: fxJs0OQWPJyNS1dU70J8Aw-1
Received: by mail-pf1-f200.google.com with SMTP id
 194-20020a6214cb0000b029030fec1731f6so569150pfu.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 21:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=FQwejWf4VvdZkkob0rPttvdUNgW5Vp/WtPa3+eCIxEI=;
 b=noUE5bkMllrmdSXj7jaAWHg9H7reJcqfOdmPu7IhqAOH5Z8Wgq6CPyzalPRuIYKYKK
 8pPa0AA2gsU8xuPIZ1bAvzwBp7DWPGU6Efk+HAxsOtX2X6gAHzR5Vw8TOWSge6ly0ic2
 QPlIXUSm8D8jRWnFmwF0SMDtBV0+Oc9++eIWhVHBDHN/INDhlkotELTHEqkd9JkHec85
 zH8lb93R/2XmPpCTR2O+Hqtqq1Th1edk99eANVvCtagOBtM5bP0buOvGmBcmv2423FWi
 CRQFk6zwlWC36co646Ggsg+eERhgk+vLkY8fPdcGlGj9/I16V7rivMBdxno281UzvfnS
 6JTw==
X-Gm-Message-State: AOAM530rf/pSYfkbzzW+OrDJJW6ZMjOSbNcHZbhDeI7miu39S8i3esgm
 3JY6u3DooY3t1tT3gCsIDgdWAGbVy31GujoE1KPaVVSg9ONdy6DH0ilwVHXoG0QyRHFTDeItMPX
 Sx9Tnd58lUveXcRxElz20alavz0DAi/Klhi3C50TK8Q==
X-Received: by 2002:a17:90a:e54f:: with SMTP id
 ei15mr2441722pjb.28.1625027501543; 
 Tue, 29 Jun 2021 21:31:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoOhwhJe1J22zBdc237u1/yZG3kCLOOHkGsz8oBg9vKWmQnNMvRLTSHx51yXXM81gEnXprIQ==
X-Received: by 2002:a17:90a:e54f:: with SMTP id
 ei15mr2441702pjb.28.1625027501284; 
 Tue, 29 Jun 2021 21:31:41 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j16sm21369413pgh.69.2021.06.29.21.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 21:31:40 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
 <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
 <PH0PR12MB5481030671D848D951477571DC039@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bf6ec662-b53d-174f-53e2-735589f83d3d@redhat.com>
 <PH0PR12MB548115ACBDA9D76526C370B3DC029@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8c78b8ed-e16c-31dd-7c1c-abd2bef6bb12@redhat.com>
Date: Wed, 30 Jun 2021 12:31:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548115ACBDA9D76526C370B3DC029@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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

CuWcqCAyMDIxLzYvMjkg5LiL5Y2INTo0OSwgUGFyYXYgUGFuZGl0IOWGmemBkzoKPiBIaSBKYXNv
biwKPgo+PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBU
dWVzZGF5LCBKdW5lIDI5LCAyMDIxIDk6MjIgQU0KPgo+Pj4+PiBQYXNzIHRoZSB3aG9sZSB2aXJ0
aW9fbmV0X2NvbmZpZyBhbmQgaW5mb3JtIHZpYSBzaWRlIGNoYW5uZWw/Cj4+Pj4gVGhhdCBjb3Vs
ZCBiZSBhIG1ldGhvZC4KPj4+IEkgcHJlZmVyIHRoZSBtZXRob2QgdG8gcGFzcyBpbmRpdmlkdWFs
IGZpZWxkcyB3aGljaCBoYXMgdGhlIGNsZWFuIGNvZGUKPj4gYXBwcm9hY2ggYW5kIGZ1bGwgZmxl
eGliaWxpdHkuCj4+PiBDbGVhbiBjb2RlID0KPj4+IDEuIG5vIHR5cGVjYXN0aW5nIGJhc2VkIG9u
IGxlbmd0aAo+Pj4gMi4gc2VsZi1kZXNjcmliaW5nIGZpZWxkcywgZG8gbm90IGRlcGVuZHMgb24g
ZmVhdHVyZSBiaXRzIHBhcnNpbmcgMy4KPj4+IHByb29mIGFnYWluc3Qgc3RydWN0dXJlIHNpemUg
aW5jcmVhc2VzIGluIGZ1bGx5IGJhY2t3YXJkL2ZvcndhcmQKPj4+IGNvbXBhdGliaWxpdHkgd2l0
aG91dCBjb2RlIGNoYW5nZXMKPj4KPj4gU28gSSB0aGluayBJIGFncmVlLiBCdXQgSSB0aGluayB3
ZSdkIGJldHRlciB0byB0aGF0IGluIHRoZSB2aXJpdG8gdUFQSQo+PiAoaW5jbHVkZS91YXBpL2xp
bnV4L3Zpcml0b194eHguaCkKPj4KPiBbLi5dCj4KPj4gSSB0aGluayBtYXliZSB3ZSBjYW4gc3Rh
cnQgZnJvbSBpbnZlbnRpbmcgbmV3IHZpcnRpbyB1QVBJIGFuZCBzZWUgaWYgaXQKPj4gaGFzIHNv
bWUgY29udHJhZGljdCB3aXRoIG5ldGxpbmsuIE9yIG1heWJlIHlvdSBjYW4gZ2l2ZSBtZSBzb21l
IGV4YW1wbGU/Cj4+Cj4+Cj4+PiBJIGFtIHVuYWJsZSB0byBjb252aW5jZSBteSBzZWxmIHRvIGJ1
aWxkIHNpZGUgYml0bWFzayBmb3IgY29uZmlnIGZpZWxkcywgdHlwZQo+PiBjYXN0aW5nIGNvZGUg
aW4gc3Bpcml0IG9mIHVzaW5nIGV4aXN0aW5nIHN0cnVjdHVyZSBVQVBJLgo+Pj4gVGhpcyBjcmVh
dGVzIG1lc3N5IGNvZGUgZm9yIGZ1dHVyZS4KPj4KPj4gSnVzdCBhIHF1aWNrIHRob3VnaHQsIGhv
dyBhYm91dCBzaW1wbHkgc29tZXRoaW5nIGxpa2U6Cj4+Cj4+IHN0cnVjdCB2aXJ0aW9fbmV0X2Nv
bmZpZ19idWlsZCB7Cj4+ICAgwqDCoMKgwqDCoMKgwqAgX191OCBtYWNbRVRIX0FMRU5dOwo+PiAg
IMKgwqDCoMKgwqDCoMKgIF9fdmlydGlvMTYgbWF4X3ZpcnRxdWV1ZV9wYWlyczsKPj4gICDCoMKg
wqAgwqDCoMKgIF9fdmlydGlvMTYgcmVzZXJ2ZWRbM107Cj4+IH07Cj4gSW4gdGhpcyBzdHJ1Y3R1
cmUgd2UgbmVlZCB0byBhZGQgYmkgZmllbGQgZmxhZ3MgdG8gaW5kaWNhdGUgd2hpY2ggZW50cnkg
aXMgdmFsaWQuCj4gQW5kIHdoZW4gc3RydWN0dXJlIGxheW91dCBjaGFuZ2VzLCB3ZSBlbmQgdXAg
d2l0aCBzaW1pbGFyIHR5cGVjYXN0IGlzc3VlcywgbGVuZ3RoIGNoZWNrcyBhbmQgbW9yZS4KPiBN
b3N0IG9mIGl0IGlzIGluYnVpbGQgdG8gdGhlIG5ldGxpbmsuCj4KPiBTbyBJIHByb3Bvc2UsCj4g
KGEpIHdlIHBhc3MgY29uZmlnIHBhcmFtZXRlcnMgZHVyaW5nIHZkcGEgZGV2aWNlIGNyZWF0ZQo+
ICQgdmRwYSBkZXYgYWRkIG5hbWUgZm9vIG1nbXRkZXYgcGNpLzAwMDA6MDM6MDAuNCBtYWMgMDA6
MTE6MjI6MzM6NDQ6NTUgbWF4cSAxMAo+Cj4gVGhpcyByZXN1bHRzIGluIGFkZGluZyB0d28gb25l
bmV3IG5ldGxpbmsgb3B0aW9uYWwgYXR0cmlidXRlcyBhcyBWRFBBX0RFVl9ORVRfTUFDLgo+IFZE
UEFfQVRUUl9ERVZfTUFYX1ZRX1NJWkUgaXMgYWxyZWFkeSBkZmluZWQgZm9yIG1heCBxdWV1ZXMu
Cj4gTkxBX1BPTElDWV9FVEhfQUREUiB0YWtlcyBjYXJlIHRvIHZhbGlkYXRlIGxlbmd0aCBzaXpl
IHdoZW4gcGFzc2VkLgo+Cj4+IEl0IGxvb2tzIHRvIHdlIGRvbid0IG5lZWQgdGhlIHJlc3Qgb2Yg
ZmllbGRzIGluIHRoZSB2aXJ0aW9fbmV0X2NvbmZpZyB0bwo+PiBidWlsZCB0aGUgY29uZmlnIHNp
bmNlIHRoZXkgYXJlIGFsbCBoYXJkd2FyZSBhdHRyaWJ1dGVzLgo+IFRvZGF5IGl0IGlzIG9ubHkg
bWFjIGFuZCBtYXggcXVldWVzLiBMYXRlciBvbiB3ZSBtYXkgbmVlZCB0byBkZWZpbmUgcnNzIGhh
c2hpbmcgYXMgaHcvZGV2aWNlIGFkdmFuY2VzLgo+IEFuZCBzdHJ1Y3R1cmUgc2l6ZSB3aWxsIGNo
YW5nZS4KPiBIZW5jZSwgSSBwcm9wb3NlIHRvIGhhdmUgZWFjaCBhcyBpbmRpdmlkdWFsIGF0dHJp
YnV0ZSB0aGF0IGRvZXNu4oCZdCBuZWVkIHRvIGNhc3QgaW4gc3RydWN0LgoKCk9rLCB0aGF0IHNo
b3VsZCB3b3JrLiBJZiBNaWNoYWVsIGFyZSBmaW5lIHdpdGggdGhpcywgSSdtIGFsc28gZmluZS4K
Ckp1c3QgdG8gY2xhcmlmeSwgaWYgSSB1bmRlcnN0YW5kIHRoaXMgY29ycmVjdGx5LCB3aXRoIHRo
ZSBpbmRpdmlkdWFsIAphdHRyaWJ1dGUsIHRoZXJlJ3Mgbm8gbmVlZCBmb3IgdGhlIGJpdCBsaWtl
IHh4eF9pc192YWxpZD8KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
