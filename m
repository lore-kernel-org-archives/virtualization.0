Return-Path: <SRS0=M3O5=LZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B992C11F64
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 07:43:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AC761490
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 07:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AC761490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81A1A83C5A;
	Thu,  1 Jul 2021 07:43:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uLsSbmSSeJmz; Thu,  1 Jul 2021 07:43:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF2AC83B58;
	Thu,  1 Jul 2021 07:43:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB34EC001A;
	Thu,  1 Jul 2021 07:43:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 571DDC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 07:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E4F083B58
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 07:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iE8Esie4w84Q
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 07:43:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E2D383AC5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 07:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625125429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWp6tkGww3BDqu0wvFfm31Zh+esoC3S50fanj1ujtXM=;
 b=QQtIMMPwjtB+f9D6uHzJ4XT9QS/UUayeLiIBLkaAmc4WVpgnl4AT1lpB98rJmrYbtaNku0
 bU6bM1YVuzUeB3KzqaPsVt3RjHk7UVQv+/R8k5H0FHQGlms6izYtfAIS1lGiceJA8s0g5o
 NAbuKS5/yb1re3Dz5W7CbjJKLOkBwlM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-De_IPHM6MWC3756sgCHD-w-1; Thu, 01 Jul 2021 03:43:48 -0400
X-MC-Unique: De_IPHM6MWC3756sgCHD-w-1
Received: by mail-pj1-f70.google.com with SMTP id
 ko19-20020a17090b1713b02901708f700618so5053953pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Jul 2021 00:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WWp6tkGww3BDqu0wvFfm31Zh+esoC3S50fanj1ujtXM=;
 b=Dww7zMLEWJ+INQij9c9VlF8wt1iJ9F237EXo//ke8eRC0YwBwawml+P3y8fpPSQbrm
 59bN3IUFvVM4cqqyFIVfq95PF98aTGoeQA65bQB2jrwcx/21zzNPH7pNZv0vCYW4sA1t
 LN5IEYjxsZnoTDOg5S/ZGENqMGsAKX4hkcSB4ik4RtOlGVXWQtn7LCykKCfa7vkmbHTC
 mQ1sxZsZMWypsxNfrPAFuSa9drWIqhEzPqAxf+NwtWRwwQEYNpa5YYbU/Tz5KYgsB+vg
 kxIsHOq6Ovmea8MgShOLP1ToPmfPHbsIST1nooFmWXTEDg+E2dtJ7IP7XsST+E13yI8R
 XFkw==
X-Gm-Message-State: AOAM5321PtfrEIP1Jr7PforI7d7WyLKIqrWIdXwK1we4UiedEAhlhrdB
 YLx9Gdk3d/kqgIonf9nVGARmkGuZZpCu+KBEiSLePqLXxNFw7SkdKHZ5Y9Vh4DpNNOKtcM8PbZN
 D5yLJseuMk4D4XPyX9cNIfFVaIsxl2h7okvMpObmCvQ==
X-Received: by 2002:a17:902:9685:b029:ef:70fd:a5a2 with SMTP id
 n5-20020a1709029685b02900ef70fda5a2mr36465018plp.20.1625125427662; 
 Thu, 01 Jul 2021 00:43:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGJV1RVfu5l+HMyomwjE7VocZ0mYpRw2GrDzzeHsxemtqgncx1LmEUai3kQoWV0ssGlQSw9Q==
X-Received: by 2002:a17:902:9685:b029:ef:70fd:a5a2 with SMTP id
 n5-20020a1709029685b02900ef70fda5a2mr36464996plp.20.1625125427378; 
 Thu, 01 Jul 2021 00:43:47 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p1sm23376092pfp.137.2021.07.01.00.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jul 2021 00:43:46 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210616191155.102303-1-parav@nvidia.com>
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
 <8c78b8ed-e16c-31dd-7c1c-abd2bef6bb12@redhat.com>
 <PH0PR12MB5481737F058FDE9B947C1ECFDC019@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a23cdc3a-80cb-f5aa-e77c-4b897c8456af@redhat.com>
 <PH0PR12MB5481AC0B0D9D0AC3A62A5EB1DC009@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <da0c4e7f-8b59-51ed-f694-04fe5a9ed0b9@redhat.com>
Date: Thu, 1 Jul 2021 15:43:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481AC0B0D9D0AC3A62A5EB1DC009@PH0PR12MB5481.namprd12.prod.outlook.com>
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

CuWcqCAyMDIxLzcvMSDkuIvljYgzOjAwLCBQYXJhdiBQYW5kaXQg5YaZ6YGTOgo+PiBGcm9tOiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBUaHVyc2RheSwgSnVseSAx
LCAyMDIxIDk6MDQgQU0KPgo+Pj4+IEp1c3QgdG8gY2xhcmlmeSwgaWYgSSB1bmRlcnN0YW5kIHRo
aXMgY29ycmVjdGx5LCB3aXRoIHRoZSBpbmRpdmlkdWFsCj4+Pj4gYXR0cmlidXRlLCB0aGVyZSdz
IG5vIG5lZWQgZm9yIHRoZSBiaXQgbGlrZSB4eHhfaXNfdmFsaWQ/Cj4+PiB4eHhfaXNfdmFsaWQg
aXMgbm90IHByZXNlbnQgaW4gdGhlIGdldCBjYWxscy4KPj4+IEl0IGlzIGFsc28gbm90IHByZXNl
bnQgaW4gVUFQSSBzZXQgY2FsbHMuCj4+PiBJdCBpcyBub3QgYSBVQVBJLgo+Pj4gSXQgaXMgYW4g
aW50ZXJuYWwgYmV0d2VlbiB2ZHBhLmMgYW5kIHZlbmRvciBkcml2ZXIgdG8gdGVsbCB3aGljaCBm
aWVsZHMgdG8gdXNlCj4+IGFzIHRoZXJlIGFyZSBvcHRpb25hbC4KPj4+IElmIHdlIHdhbnQgdG8g
Z2V0IHJpZCBvZiB0aG9zZSB2YWxpZCBmbGFncyBiZWxvdyBjb2RlIHdpbGwgbW92ZSB0byB2ZW5k
b3IKPj4gZHJpdmVyIHdoZXJlIHdlIHBhc3MgbmxfYXR0ciwgZHVyaW5nIGRldmljZSBhZGQgY2Fs
bGJhY2suCj4+Pgo+Pj4gKwlpZiAobmxfYXR0cnNbVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FE
RFJdKSB7Cj4+PiArCQltYWNhZGRyID0KPj4gbmxhX2RhdGEobmxfYXR0cnNbVkRQQV9BVFRSX0RF
Vl9ORVRfQ0ZHX01BQ0FERFJdKTsKPj4+ICsJCW1lbWNweShjb25maWcubmV0Lm1hYywgbWFjYWRk
ciwgc2l6ZW9mKGNvbmZpZy5uZXQubWFjKSk7Cj4+PiArCQljb25maWcubmV0X21hc2subWFjX3Zh
bGlkID0gdHJ1ZTsKPj4+ICsJfQo+Pj4gKwlpZiAobmxfYXR0cnNbVkRQQV9BVFRSX0RFVl9ORVRf
Q0ZHX01UVV0pIHsKPj4+ICsJCWNvbmZpZy5uZXQubXR1ID0KPj4+ICsKPj4gCW5sYV9nZXRfdTE2
KG5sX2F0dHJzW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFVdKTsKPj4+ICsJCWNvbmZpZy5uZXRf
bWFzay5tdHVfdmFsaWQgPSB0cnVlOwo+Pj4gKwl9Cj4+Cj4+IEhhdmUgYSBoYXJkIHRob3VnaHQg
b24gdGhpcy4gSSBzdGlsbCB0aGluayByZS1pbnZlbnQgKGR1cGxpY2F0ZSkgdGhlIHZpcnRpby1u
ZXQKPj4gY29uZmlnIGZpbGVkIGlzIG5vdCBhIGdvb2QgY2hvaWNlIChlLmcgZm9yIGJsb2NrIHdl
IG5lZWQgdG8gZHVwbGljYXRlIG1vcmUKPj4gdGhhbiAyMCBhdHRyaWJ1dGVzKS4KPiBXZSBhcmUg
cmUtaW52ZW50aW5nIGJ5IGRlZmluaW5nIGEgbmV3IHN0cnVjdHVyZSBiZWxvdy4KCgpBY3R1YWxs
eSBpdCBkZXBlbmRzIG9uIHdoYXQgYXR0cmlidXRlcyBpcyByZXF1aXJlZCBmb3IgYnVpbGRpbmcg
dGhlIGNvbmZpZy4KCldlIGNhbiBzaW1wbHkgcmV1c2UgdGhlIGV4aXN0aW5nIHZpcnRpb19uZXRf
Y29uZmlnLCBpZiBtb3N0IG9mIHRoZSAKZmllbGRzIGFyZSByZXF1aXJlZC4KCnN0cnVjdCB2aXJ0
aW9fbmV0X2NvbmZpZ19zZXQgewogwqDCoMKgIMKgwqDCoCBfX3ZpcnRpbzY0IGZlYXR1cmVzOwog
wqDCoMKgIMKgwqDCoCB1bmlvbiB7CiDCoMKgwqAgwqDCoMKgIMKgwqDCoCBzdHJ1Y3QgdmlydGlv
X25ldF9jb25maWc7CiDCoMKgwqAgwqDCoMKgIMKgwqDCoCBfX3ZpcnRpbzY0IHJlc2VydmVkWzY0
XTsKIMKgwqDCoCDCoMKgwqAgfQp9OwoKSWYgb25seSBmZXcgb2YgdGhlIGlzIHJlcXVpcmVkLCB3
ZSBjYW4ganVzdCBwaWNrIHRoZW0gYW5kIHVzZSBhbm90aGVyIApzdHJ1Y3R1cmUuCgpBY3R1YWxs
eSwgSSB0aGluayBqdXN0IHBhc3MgdGhlIHdob2xlIGNvbmZpZyB3aXRoIHRoZSBkZXZpY2VfZmVh
dHVyZXMgCmR1cmluZyBkZXZpY2UgY3JlYXRpb24gaXMgYSBnb29kIGNob2ljZSB0aGF0IGNhbiBz
aW1wbGlmeSBhIGxvdCBvZiB0aGluZ3MuCgpXZSBjYW4gZGVmaW5lIHdoYXQgaXMgbmVlZGVkIGFu
ZCBpZ25vcmUgdGhlIG90aGVycyBpbiB0aGUgdmlydGlvIHNwZWMuIApUaGVuIHRoZXJlJ3Mgbm8g
bmVlZCB0byB3b3JyeSBhYm91dCBhbnkgb3RoZXIgdGhpbmdzLiB2RFBBIGNvcmUgY2FuIGp1c3Qg
CmRvIHNhbnRpeSB0ZXN0IGxpa2UgY2hlY2tpbmcgc2l6ZSB2cyBmZWF0dXJlcy4KCgo+IEluc3Rl
YWQgb2YgZG9pbmcgdGhlbSBhcyBpbmRpdmlkdWFsIG5ldGxpbmsgYXR0cmlidXRlcywgaXRzIGx1
bXBlZCB0b2dldGhlciBpbiBhIHN0cnVjdCBvZiBhcmJpdHJhcnkgbGVuZ3RoLiA6LSkKCgpJIHRo
aW5rIG5vdD8gV2Ugd2FudCB0byBoYXZlIGEgZml4ZWQgbGVuZ3RoIG9mIHRoZSBzdHJ1Y3R1cmUg
d2hpY2ggbmV2ZXIgCmdyb3cuCgpTbyB0aGUgZGlmZmVyZW50IGlzOgoKMSkgdXNpbmcgbmV0bGlu
ayBkZWRpY2F0ZWQgZmllbGRzCgppZiAobmxfYXR0cnNbVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01B
Q0FERFJdKQoKMikgdXNpbmcgbmV0bGluayBhcyB0cmFuc3BvcnQKCmlmIChmZWF0dXJlcyAmIFZJ
UlRJT19ORVRfRl9NQUMpCgoKPgo+IEkgbm90aWNlIHNldmVyYWwgZmllbGRzIG9mIHRoZSB2ZHVz
ZSBkZXZpY2UgaXMgc2V0dXAgdmlhIGlvY3RsLCB3aGljaCBJIHRoaW5rIHNob3VsZCBiZSBzZXR1
cCB2aWEgdGhpcyB2ZHBhIGRldmljZSBhZGQgaW50ZXJmYWNlLgo+Cj4gQWxzbyB3ZSBjYW4gYWx3
YXlzIHdyYXAgYWJvdmUgbmxfYXR0ciBjb2RlIGluIGEgaGVscGVyIEFQSSBzbyB0aGF0IGRyaXZl
cnMgdG8gbm90IGhhbmQtY29kZSBpdC4KCgpUaGVuIGl0IHdvdWxkIGJlIHN0aWxsIG1vcmUgbGlr
ZSAyKSBhYm92ZSAod3JhcCBuZXRsaW5rIGJhY2sgdG8gCnNvbWV0aGluZyBsaWtlIHZpcnRpb19u
ZXRfY29uZmlnKT8KCgo+Cj4+IFdlIG1heSBtZWV0IHNpbWlsYXIgaXNzdWUgd2hlbiBwcm92aXNp
b24gVkYvU0YgaW5zdGFuY2UgYXQgdGhlIGhhcmR3YXJlCj4+IGxldmVsLiBTbyBJIHRoaW5rIHdl
IG1heSBuZWVkIHNvbWV0aGluZyBpbiB0aGUgdmlydGlvIHNwZWMgaW4gdGhlIG5lYXIgZnV0dXJl
Lgo+IERvIHlvdSBtZWFuIGluIGEgdmlydGlvIHZmIGFuZCB2aXJ0aW8gc2Y/CgoKWWVzLgoKCj4g
SWYgc28sIHByb2JhYmx5IHllcy4KPiBHaXZlbiB0aGF0IHdlIGhhdmUgdGhlIGFiaWxpdHkgdG8g
dHJhbnNwb3J0IGluZGl2aWR1YWwgZmllbGRzLCB3ZSBkb24ndCBuZWVkIHRvIGF0dGFjaCB0aGUg
VS0+SyBVQVBJIHRvIGEgdW5kZWZpbmVkIGFuZCBldm9sdmluZyBzdHJ1Y3R1cmUuCgoKSSBkb24n
dCBvYmplY3QgYnV0IGl0IG5lZWRzIHRvIGJlIGRvbmUgaW4gdmlydGlvIHVBUEkgaW5zdGVhZCBv
ZiAKbmV0bGluaywgc2luY2UgaXQncyB0aGUgZGV2aWNlIEFCSS4KCgo+Cj4+IFNvIGFzc3VtaW5n
IHdlIGRvbid0IHdhbnQgYSBzaW5nbGUgYXR0cmlidXRlcyB0byBiZSBtb2RpZmllZCBhbmQgd2Ug
d2FudCB0bwo+PiBsZXQgdXNlciB0byBzcGVjaWZ5IGFsbCB0aGUgYXR0cmlidXRlcyBhdCBvbmUg
dGltZSBkdXJpbmcgY3JlYXRpb24uCj4+Cj4+IE1heWJlIHdlIGNhbiB0d2VhayB2aXJ0aW9fbmV0
X2NvbmZpZ19zZXQgYSBsaXR0bGUgYml0Ogo+Pgo+PiBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWdf
c2V0IHsKPj4gICDCoMKgwqAgwqDCoMKgIF9fdmlydGlvNjQgZmVhdHVyZXM7Cj4+ICAgwqDCoMKg
wqDCoMKgwqAgX191OCBtYWNbRVRIX0FMRU5dOwo+PiAgIMKgwqDCoMKgwqDCoMKgIF9fdmlydGlv
MTYgbWF4X3ZpcnRxdWV1ZV9wYWlyczsKPj4gICDCoMKgwqAgwqDCoMKgIF9fdmlydGlvMTYgbXR1
Owo+PiAgIMKgwqDCoCDCoMKgwqAgX192aXJ0aW8xNiByZXNlcnZlZFs2Ml07Cj4+IH0KPj4KPj4g
U28gd2UgaGF2ZToKPj4KPj4gLSBib3RoIGZlYXR1cmVzIGFuZCBjb25maWcgZmllbGRzLCB3ZSdy
ZSBzZWxmIGNvbnRhaW5lZAo+PiAtIHJlc2VydmVkIGZpZWxkcyB3aGljaCBzaG91bGQgYmUgc3Vm
ZmljaWVudCBmb3IgdGhlIG5leHQgMTAgeWVhcnMsIHNvIHdlIGRvbid0Cj4+IG5lZWQgdG8gY2Fy
ZSBhYm91dCB0aGUgZ3Jvd2luZy4KPiBUaGlzIGlzIHRoZSByZXZlcnNlIG9mIG5ldGxpbmsgd2hp
Y2ggb2ZmZXJzIHRvIG5vdCByZXNlcnZlIGFueSBhcmJpdHJhcnkgc2l6ZSBzdHJ1Y3R1cmUuCgoK
SXQncyBub3QgYXJiaXRyYXJ5IGJ1dCB3aXRoIGZpeGVkIGxlbmd0aC4KCgo+ICAgVGhvdWdoIEkg
YWdyZWUgdGhhdCBpdCBtYXkgbm90IGdyb3cuCj4KPj4gT3IgYWN0dWFsbHkgaXQgYWxzbyBhbGxv
d3MgcGVyIGZpZWxkIG1vZGlmaWNhdGlvbi4KPj4KPj4gRS5nIGlmIHdlIGRvbid0IHNwZWNpZnkg
VklSVElPX05FVF9GX01BQywgaXQgbWVhbnMgbWFjIGZpZWxkIGlzIGludmFsaWQuCj4+IFNvIGRp
ZCBmb3IgcXBzIGFuZCBtdHUuCj4+Cj4+IFRoZSBhZHZhbnRhZ2UgaXMgdGhhdCB3ZSBjYW4gc3Rh
bmRhcmRpemUgdGhpcyBpbiB0aGUgdmlydGlvIHNwZWMgd2hpY2ggY291bGQKPj4gYmUgdXNlZCBm
b3IgU0YvVkYgcHJvdmlzaW9uaW5nLgo+IFZpcnRpbyBzcGVjIGNhbiBiZSBzdGlsbCBzdGFuZGFy
ZGl6ZWQgYWJvdXQgd2hpY2ggZmllbGRzIG9mIGNvbmZpZyBzcGFjZSBzaG91bGQgYmUgc2V0dXAu
Cj4gVG8gZG8gc28sIHdlIGRvbid0IG5lZWQgdG8gbHVtcCB0aGVtIGluIG9uZSBzdHJ1Y3R1cmUu
CgoKWWVzLCBhZ3JlZS4KCgo+Cj4+IEZvciBnZXQsIHdlIHByb2JhYmx5IG5lZWQgbW9yZSB3b3Jr
Ogo+Pgo+PiBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWdfZ2V0IHsKPj4gICDCoMKgwqAgwqDCoMKg
IF9fdmlydGlvNjQgZmVhdHVyZXM7Cj4+ICAgwqDCoMKgIMKgwqDCoCB1bmlvbiB7Cj4+ICAgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZzsKPj4gICDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgX192aXJ0aW82NCByZXNlcnZlZFsxNl07Cj4+ICAg
wqDCoMKgIMKgwqDCoCB9Cj4+IH0KPj4KPj4gT3IganVzdCBmb2xsb3cgaG93IGl0IGlzIHdvcmsg
dG9kYXksIHNpbXBseSBwYXNzIHRoZSBjb25maWcgcGx1cyB0aGUKPj4gZGV2aWNlX2ZlYXR1cmVz
Lgo+IElmIHdlIGdvIHdpdGggaW5kaXZpZHVhbCBhdHRyaWJ1dGUgZ2V0IGFuZCBhZGQgYm90aCBz
b3J0ZWQgb3V0IG5lYXRseSwgZXhwYW5kYWJsZS4KCgpJdCBtYXkgb25seSB3b3JrIGZvciBuZXRs
aW5rICh3aXRoIHNvbWUgZHVwbGljYXRpb24gd2l0aCB0aGUgZXhpc3RpbmcgCnZpcnRpbyB1QVBJ
KS4gSWYgd2UgY2FuIHNvbHZlIGl0IGF0IGdlbmVyYWwgdmlydGlvIGxheWVyLCBpdCB3b3VsZCBi
ZSAKYmV0dGVyLiBPdGhlcndpc2Ugd2UgbmVlZCB0byBpbnZlbnQgdGhlbSBhZ2FpbiBpbiB0aGUg
dmlydGlvIHNwZWMuCgpFLmcgdmlyaXRvIGlzIGV4cGVjdGVkIHRvIHN1cHBvcnQgc29tZXRoaW5n
IHNpbWlsYXIgdG8gU0YsIGl0IHJlcXVpcmVzIAp0aGUgU0YgdG8gYmUgY3JlYXRlZC9wcm92aXNp
b25lZCB2aWEgdGhlIGFkbWluIHZpcnRxdWV1ZSBpbiB0aGUgUEYuCgpJbiB0aGlzIGNhc2UsIHdl
IHN0aWxsIG5lZWQgdG8gZGVmaW5lIHdoYXQgaXMgcmVxdWlyZWQgaXQgY3JlYXRlIGEgCnZpcnRp
byAiU0YiLiBOZXRsaW5rIGNhbid0IGJlIHVzZWQgaW4gdGhpcyBjb250ZXh0LgoKSSB0aGluayBl
dmVuIGZvciB0aGUgY3VycmVudCBtbHg1ZSB2RFBBIGl0IHdvdWxkIGJlIGJldHRlciwgb3RoZXJ3
aXNlIHdlIAptYXkgaGF2ZToKCnZEUEEgdG9vbCAtPiBbbmV0bGluayBzcGVjaWZpYyB2RFBBIGF0
dHJpYnV0ZXMoMSldIC0+IHZEUEEgY29yZSAtPiBbdkRQQSAKY29yZSBzcGVjaWZpYyBWRFBBIGF0
dHJpYnV0ZXMoMildIC0+IG1seDVlX3ZEUEEgLT4gW21seDVlIHNwZWNpZmljIHZEUEEgCmF0dHJp
YnV0ZXMoMyldIC0+IG1seDVlX2NvcmUKCldlIG5lZWQgdG8gdXNlIGEgc2luZ2xlIGFuZCB1bmlm
aWVkIHZpcnRpbyBzdHJ1Y3R1cmUgaW4gYWxsIHRoZSAoMSksICgyKSAKYW5kICgzKS4KCgo+Cj4g
WW91IGFscmVhZHkgZXhwbGFpbmVkIHRoYXQgdGhlcmUgaXNuJ3Qgb25lIHRvIG9uZSBtYXBwaW5n
IG9mIGZlYXR1cmVzIHRvIGNvbmZpZyBmaWVsZHMgZm9yIG90aGVyIGRldmljZSB0eXBlcyB0b28u
CgoKWWVzLCBidXQgZmVhdHVyZXMgKyBjb25maWcgaXMgc2VsZiBjb250YWluZWQuIFRoYXQgaXMg
dG8gc2F5LCBpdCdzIApzdWZmaWNpZW50IHRvIGV4cGxhaW4gYSBzcGVjaWZpYyBmaWxlZCBpZiB3
ZSBoYWQgZGV2aWNlIGZlYXR1cmVzLgoKVGhhbmtzCgoKPiBOZXRsaW5rIGFscmVhZHkgZW5hYmxl
cyB1cyB0byBhdm9pZCBub24gc3ltbWV0cmljIHU2NCByZXNlcnZlZFsxNl0gaW4gZ2V0IGFuZCB1
MTYgcmVzZXJ2ZWRbMTZdIGluIHNldC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
