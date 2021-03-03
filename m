Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ACFC433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 09:25:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023B564EE6
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 09:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023B564EE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BAF46F536;
	Wed,  3 Mar 2021 09:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1HipA4PtuRa; Wed,  3 Mar 2021 09:25:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00FBD605E5;
	Wed,  3 Mar 2021 09:25:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C23A1C000A;
	Wed,  3 Mar 2021 09:25:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9679C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9071247CA5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wU7i-Z12nhG1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:25:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F19CB40175
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614763498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PUA2LbWW0ntOrP+7jkbiQ3+0eb5XzlTChG/ctH5yJpk=;
 b=ELn70s9dH/1abE6xJ7iJYHo8NwJPuJLoHt69mhU+g616KurMOvB4yi8IvnOyIWv096Xg3z
 6YPZhcash+2igX8CqGUb6MSWGdnhq6SypbIaYW4/H5kAyA6M6kwDORDF2r+/as15ZaNqfT
 TV5BphS6th097rorSGFYWNlaV0ympow=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-rB4r5XuQNhm4nMlRb3ot_Q-1; Wed, 03 Mar 2021 04:24:55 -0500
X-MC-Unique: rB4r5XuQNhm4nMlRb3ot_Q-1
Received: by mail-wm1-f71.google.com with SMTP id a3so1544212wmm.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Mar 2021 01:24:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PUA2LbWW0ntOrP+7jkbiQ3+0eb5XzlTChG/ctH5yJpk=;
 b=HLox50L9y7qcD06exxiFTATmkyf+/p0Fd7PsrRRJZZ2S2FVFp6e7rVOlO53NBHF01f
 SfB4p5UyxXYnr0kKg/HYjrN5DRsEUTNsaXDFZ2r//vJKSMp5zVeah0NMNRvwX9A9FIp/
 j1+tHUKoOfGZYDQ18MuNvgVJkxhQfTKlmKAyY8i+f+AU0iag7iB2hDs/glTQqbxwa12r
 Fo5yE5tFkMbQMPuXtdsgSFjiQSzZx9XZO/TwPC579FMXBB9eaTWCUZ4roV5SC0wTcQhB
 mYZBk1jNbUMKo83URd5szGKKNC1FV2bAkv/oqf7dZe6QwzDNnmzTc7UMFPXKFynjRpO+
 taoQ==
X-Gm-Message-State: AOAM530yM0S0W0mQn3iiRrRmCfQU0Wnb/yeswrsa2qnquw+IVndoKrCV
 uSG/duRfHNf9TQh3rATZSS/G/hv4K8smmJicyOEX5BGElnnxPKi5IKUc83BL6/XsYtAcRz6MaJX
 kK3OBoeRkqLwYS/yXCTJh8bvqk8PX7o7n+BVNkS5TZg==
X-Received: by 2002:a7b:ca50:: with SMTP id m16mr7986997wml.113.1614763494563; 
 Wed, 03 Mar 2021 01:24:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+ntTGmSKjMFt2fmqCl5Q6QWIDiH5E9v4PNEhemaICY5/EvSY5guE8FIwoWKPTih6RnIgPUw==
X-Received: by 2002:a7b:ca50:: with SMTP id m16mr7986968wml.113.1614763494198; 
 Wed, 03 Mar 2021 01:24:54 -0800 (PST)
Received: from amorenoz.users.ipa.redhat.com ([94.73.62.62])
 by smtp.gmail.com with ESMTPSA id m11sm18773186wrz.40.2021.03.03.01.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Mar 2021 01:24:53 -0800 (PST)
Subject: Re: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
To: Jason Wang <jasowang@redhat.com>, Sean Mooney <smooney@redhat.com>,
 Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-3-parav@nvidia.com>
 <1a9f4f3c-4581-35cc-5d3a-1495bb00257a@redhat.com>
 <BY5PR12MB4322AF919B1BF71DA31C53FFDC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <bfb3a5d2-d335-c4f2-20cb-65d53fc4b216@redhat.com>
 <BY5PR12MB4322010113CCDCA1BB81F766DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <a1836031-9240-b835-13c3-42dab92d06fa@redhat.com>
 <BY5PR12MB4322917EA142EA37DFAA53EADC9A9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <bbed2011-b0f7-82ba-0e85-0ee455595e5e@redhat.com>
 <afe9f219-1247-173f-e93a-cfe083e5cfbd@redhat.com>
 <abc1d3d7cd321620f6ae7f9ac0bb92fcce30a474.camel@redhat.com>
 <b4ff75a4-c773-fdfa-d056-ec569b0eef69@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
Message-ID: <35ca5eab-4d25-3358-479a-1494454fff20@redhat.com>
Date: Wed, 3 Mar 2021 10:24:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b4ff75a4-c773-fdfa-d056-ec569b0eef69@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=amorenoz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
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

CgpPbiAzLzIvMjEgNToyNSBBTSwgSmFzb24gV2FuZyB3cm90ZToKPiAKPiBPbiAyMDIxLzMvMSA4
OjA2IOS4i+WNiCwgU2VhbiBNb29uZXkgd3JvdGU6Cj4+IE9uIE1vbiwgMjAyMS0wMy0wMSBhdCAx
MToyOCArMDEwMCwgQWRyaWFuIE1vcmVubyB3cm90ZToKPj4+IE9uIDMvMS8yMSA4OjUwIEFNLCBK
YXNvbiBXYW5nIHdyb3RlOgo+Pj4+IE9uIDIwMjEvMy8xIDM6Mjkg5LiL5Y2ILCBQYXJhdiBQYW5k
aXQgd3JvdGU6Cj4+Pj4+PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+
Pj4+Pj4gU2VudDogTW9uZGF5LCBNYXJjaCAxLCAyMDIxIDk6MjkgQU0KPj4+Pj4+Cj4+Pj4+PiBP
biAyMDIxLzIvMjYgNDo1MCDkuIvljYgsIFBhcmF2IFBhbmRpdCB3cm90ZToKPj4+Pj4+Pj4gRnJv
bTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4+Pj4+Pj4gU2VudDogRnJpZGF5
LCBGZWJydWFyeSAyNiwgMjAyMSAxOjU2IFBNCj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IE9u
IDIwMjEvMi8yNiAxOjMyIOS4i+WNiCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Pj4+Pj4+Pj4+IEZy
b206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+Pj4+Pj4+Pj4gU2VudDogV2Vk
bmVzZGF5LCBGZWJydWFyeSAyNCwgMjAyMSAyOjE4IFBNCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBP
biAyMDIxLzIvMjQgMjoxOCDkuIvljYgsIFBhcmF2IFBhbmRpdCB3cm90ZToKPj4+Pj4+Pj4+Pj4g
Kwo+Pj4+Pj4+Pj4+PiArwqDCoMKgIGlmIChubGFfcHV0X3UxNihtc2csCj4+Pj4+PiBWRFBBX0FU
VFJfREVWX05FVF9DRkdfTUFYX1ZRUCwKPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29uZmlnLT5tYXhfdmlydHF1ZXVlX3BhaXJzKSkKPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+Pj4+Pj4gV2UgcHJvYmFibHkgbmVlZCB0byBjaGVj
ayBWSVJUSU9fTkVUX0ZfUlNTIGhlcmUuCj4+Pj4+Pj4+PiBZZXMuIFdpbGwgdXNlIGl0IGluIHYy
Lgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gK8KgwqDCoCBpZiAobmxhX3B1dF91OChtc2csCj4+Pj4+
PiBWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX01BWF9LRVlfTEVOLAo+Pj4+Pj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25maWctPnJzc19tYXhfa2V5X3NpemUpKQo+Pj4+
Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTVNHU0laRTsKPj4+Pj4+Pj4+Pj4gKwo+
Pj4+Pj4+Pj4+PiArwqDCoMKgIHJzc19maWVsZCA9IGxlMTZfdG9fY3B1KGNvbmZpZy0+cnNzX21h
eF9rZXlfc2l6ZSk7Cj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgaWYgKG5sYV9wdXRfdTE2KG1zZywKPj4+
Pj4+IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19SU1NfTUFYX0lUX0xFTiwKPj4+Pj4+Pj4+PiByc3Nf
ZmllbGQpKQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTVNHU0laRTsKPj4+
Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+PiArwqDCoMKgIGhhc2hfdHlwZXMgPSBsZTMyX3RvX2NwdShj
b25maWctPnN1cHBvcnRlZF9oYXNoX3R5cGVzKTsKPj4+Pj4+Pj4+Pj4gK8KgwqDCoCBpZiAobmxh
X3B1dF91MzIobXNnLAo+Pj4+Pj4gVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX1JTU19IQVNIX1RZUEVT
LAo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25maWctPnN1cHBvcnRlZF9o
YXNoX3R5cGVzKSkKPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7
Cj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4+Pj4+Pj4+ICt9Cj4+Pj4+Pj4+Pj4+
ICsKPj4+Pj4+Pj4+Pj4gK3N0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X2NvbmZpZ19maWxsKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwKPj4+Pj4+Pj4+Pj4gK3N0cnVjdCBza19idWZmICptc2cpIHsK
Pj4+Pj4+Pj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgY29uZmlnID0ge307
Cj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4gK8KgwqDCoCB2ZGV2LT5jb25maWctPmdldF9jb25m
aWcodmRldiwgMCwgJmNvbmZpZywgc2l6ZW9mKGNvbmZpZykpOwo+Pj4+Pj4+Pj4+IERvIHdlIG5l
ZWQgdG8gc3luYyB3aXRoIG90aGVyIHBvc3NpYmxlIGdldF9jb25maWcgY2FsbHMgaGVyZT8KPj4+
Pj4+Pj4+IFRvIHJlYWRlcnMgb2YgZ2V0X2NvbmZpZygpIGlzIG9rLiBObyBuZWVkIHRvIHN5bmMu
Cj4+Pj4+Pj4+PiBIb3dldmVyLCBJIHRoaW5rIHNldF9jb25maWcoKSBhbmQgZ2V0X2NvbmZpZygp
IHNob3VsZCBzeW5jIG90aGVyd2lzZQo+Pj4+Pj4+PiBnZXRfY29uZmlnIGNhbiBnZXQgcGFydGlh
bCB2YWx1ZS4KPj4+Pj4+Pj4+IFdpbGwgcHJvYmFibHkgaGF2ZSB0byBhZGQgdmRwYV9kZXZpY2Ut
PmNvbmZpZ19hY2Nlc3NfbG9jaygpLgo+Pj4+Pj4+PiBQcm9iYWJseS4gQW5kIHRoZSBzZXRfY29u
ZmlnKCkgc2hvdWxkIGJlIHN5bmNocm9uaXplZCB3aXRoIHRoZQo+Pj4+Pj4+PiByZXF1cmVzdCB0
aGF0IGNvbWVzIGZyb20gdkRQQSBidXMuCj4+Pj4+Pj4gWWVzLCBhIHJ3IHNlbWFwaG9yZSBpcyBn
b29kIGVub3VnaC4KPj4+Pj4+PiBEZXZpY2UgY29uZmlnIGZpZWxkcyBjYW4gYmUgY2hhbmdlIGZy
b20gdGhlIGRldmljZSBzaWRlIGFueXdheSwgc3VjaCBhcwo+Pj4+Pj4gbGluayBzdGF0dXMgYW55
d2F5Lgo+Pj4+Pj4+IFN5bmMgdXNpbmcgbG9jayBzaG91bGRu4oCZdCBiZSBwcm9ibGVtLgo+Pj4+
Pj4+Cj4+Pj4+Pj4+IFRoaXMgbWFrZXMgbWUgdGhpbmsgd2hldGhlciB3ZSBzaG91bGQgZ28gYmFj
ayB0byB0d28gcGhhc2VzIG1ldGhvZCwKPj4+Pj4+Pj4gY3JlYXRlIGFuZCBlbmFibGUuCj4+Pj4+
Pj4+Cj4+Pj4+Pj4+IFRoZSB2RFBBIGRldmljZSBpcyBvbmx5IHJlZ2lzdHJlZCBhZnRlciBlbmFi
bGluZywgdGhlbiB0aGVyZSdzIG5vCj4+Pj4+Pj4+IG5lZWQgdG8gc3luYyB3aXRoIHZEUEEgYnVz
LCBhbmQgbWdtdCBpcyBub3QgYWxsb3dlZCB0byBjaGFuZ2UgY29uZmlnCj4+Pj4+PiBhZnRlciBl
bmFsYmluZz8KPj4+Pj4+PiBJbiB0aGF0IGNhc2Ugd2Ugc2hvdWxkIGJlIGFibGUgdG8gZGlzYWJs
ZSBpdCBhcyB3ZWxsLiBEaXNhYmxlIHNob3VsZCB0YWtlCj4+Pj4+Pj4gdGhlCj4+Pj4+PiBkZXZp
Y2Ugb2YgdGhlIGJ1cy4KPj4+Pj4+PiBJIGZpbmQgaXQgd2VpcmQgdG8gaGF2ZSB0aGlzIG1vZGVs
IHRvIGxpbmdlciBhcm91bmQgdGhlIGRldmljZSB3aXRob3V0Cj4+Pj4+PiBhbmNob3Jpbmcgb24g
dGhlIGJ1cy4KPj4+Pj4+PiBGb3IgZXhhbXBsZSBkZXZpY2UgaXMgbm90IHlldCBlbmFibGVkLCBz
byBpdCBpcyBub3QgYW5jaG9yZWQgb24gdGhlIGJ1cywgYnV0Cj4+Pj4+PiBpdHMgbmFtZSBpcyBz
dGlsbCBoYXZlIHRvIHJlbWFpbiB1bmlxdWUuCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IENhbiB3ZSBk
byBzb21lIHN5bmNob3JuaXphdGlvbiBiZXR3ZWVuIHZkcGEgZGV2aWNlIGFsbG9jYXRpb24gYW5k
IHZkcGEKPj4+Pj4+IGRldmljZSByZWdpc3RpZXIgdG8gc29sdmUgdGhlIG5hbWluZyBpc3N1ZT8K
Pj4+Pj4gbWdtdCB0b29sIHF1ZXJ5aW5nIHRoZSBkZXZpY2UgY29uZmlnIHNwYWNlIGFmdGVyIHZk
cGEgZGV2aWNlIGlzIGluIHVzZSBpcwo+Pj4+PiByZWFsLgo+Pj4+PiBTbyBJIGRvbid0IHNlZSBz
b2x2aW5nIGl0IGFueSBkaWZmZXJlbnRseS4KPj4+Pj4KPj4+Pj4gTm93IHVwcGVyIGxheWVycyBv
ZiB2ZHBhIHRvIG5vdCBhY2Nlc3MgdGhlIGRldmljZSBvbiB0aGUgcGxhY2VkIG9uIHRoZSB2ZHBh
Cj4+Pj4+IGJ1cywgY2FuIGJlIHRha2VuIGNhcmUgYnkgZXhpc3RpbmcgZHJpdmVyIGNvZGUgdXNp
bmcKPj4+Pj4gZWNobyAwID4gL3N5cy9idXMvdmRwYS9kcml2ZXJzX2F1dG9wcm9iZQo+Pj4+Pgo+
Pj4+PiBCeSBkZWZhdWx0IHZkcGEgZGV2aWNlIHBsYWNlZCBvbiB0aGUgYnVzIHdvbnQgYmluZCB0
byBhbnkgZHJpdmVyIChuZXQvdmhvc3QKPj4+Pj4gZXRjKS4KPj4+Pj4gMS4gRGVjaXNpb24gdG8g
YmluZCB0byB3aGljaCBkcml2ZXIgaXMgZG9uZSBhZnRlciBjb25maWcgb2YgdGhlIHZkcGEgZGV2
aWNlIGlzCj4+Pj4+IGRvbmUuCj4+Pj4+IDIuIG9yY2hlc3RyYXRpb24gc3cgZG9lcyBjcmVhdGUg
YW5kIGNvbmZpZyBiZWZvcmUgaXQgYmluZHMgdG8gdGhlIHJpZ2h0IGRyaXZlcgo+Pj4+PiAzLiB3
aGljaCBkcml2ZXIgdG8gYmluZCB0byBkZWNpZGVkIGJhc2VkIG9uIHRoZSB1c2UgY2FzZSBvZiB0
aGF0IGluZGl2aWR1YWwKPj4+Pj4gdmRwYSBkZXZpY2UKPj4+Pj4gRm9yIGV4YW1wbGUsCj4+Pj4+
IChhKSB2ZHBhMCBiaW5kcyB0byBuZXQgZHJpdmVyIHRvIGhhdmUgTmV0ZGV2IGZvciBjb250YWlu
ZXIKPj4+Pj4gKGIpIHZkcGExIGJpbmRzIHRvIHZob3N0IGRyaXZlciB0byBtYXAgdmRwYSBkZXZp
Y2UgdG8gVk0KPj4+Pgo+Pj4+IEkgdGhpbmsgaXQgc2hvdWxkIHdvcmsuCj4+Pj4+IEFkZGluZyBB
ZHJpYW4sIE1heGltZSBhbmQgU2VhbiBmb3IgbW9yZSBjb21tZW50cy4KPj4+IElzIHRoaXMgYSBz
dHJvbmcgcmVxdWlyZW1lbnQgb3IganVzdCBhIG9wdGlvbmFsIG9wZXJhdGlvbj8KPiAKPiAKPiBT
byBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgc29tZXRoaW5nIG5lZWRzIHRvIGJlIGRvbmUgdG8g
bWFrZSBzdXJlOgo+IAoKPiAxKSB0aGUgdnBkYSBkZXZpY2UgaXMgbm90IGJvdW5kIHRvIHZpcnRp
by12ZHBhVGhpcyBpcyBhIHByb2JsZW0gb2YgYXBpIG5vdCBiZWluZyB1bmlmaWVkLCByaWdodD8g
SWYgdmRwYSBkZXZpY2UgaXMgYm91bmQgdG8KdmlydGlvLXZkcGEgSSB3b3VsZCBleHBlY3Qgc29t
ZSBuZXQtc3BlY2lmaWMgb3B0aW9ucyAobGlrZSBtYWMgb3IgdHNvKSB3b3VsZCBiZQptb2RpZmlh
YmxlIHRocm91Z2ggbmV0X2RldmljZV9vcHMgaWYgdGhlIG5lZWRlZCBjYXBhYmlsaXRpZXMgYXJl
IGhlbGQuCgo+IDIpIGNvbmZpZyBpcyBub3QgY2hhbmdlZCBpZiBpdCBoYXMgYmVlbiBzZXQgYnkg
bWFuYWdlbWVudAo+Rm9yIHZpcnRpby12ZHBhICh2aXJ0aW8tbmV0KSBkZXZpY2VzLCB0aGF0IHdv
dWxkIGJlIGNvbnRyb2xsZWQgdmlhIENBUF9ORVRfQURNSU4uCkZvciB2aG9zdC12ZHBhIGNhc2Us
IGFyZSB5b3UgdGhpbmtpbmcgb2YgYSB3YXkgb2Ygc3RvcHBpbmcgYSB1c2VyIGZyb20gc2VuZGlu
ZwpWSE9TVF9WRFBBX1NFVF9DT05GSUcgbWVzc2FnZXM/IG9yIG1ha2luZyBpdCBmYWlsIGlmIG1h
bmFnZW1lbnQgaGFzIG1hZGUgc29tZQpjb25maWcgYXQgdGhlIHZkcGEgbGV2ZWw/Cgo+IAo+Pj4g
VGhpcyBtaWdodCBicmVhayBzb21lIGV4aXN0aW5nIGxvZ2ljIHRoYXQgZXhwZWN0cyBuZXRkZXYg
b3Igdmhvc3QtdmRwYSBkZXZpY2UgdG8KPj4+IGV4aXN0IGJlZm9yZSB0aGUgc29tZSBjb25maWcg
KGUuZzptYWMgYWRkcmVzcykgaXMgc2V0Lgo+PiB0aGUgb3JjZXN0cmF0aW9uIHNvZnR3YXJlIHNo
b3VsZCBub3QgcmVxdWlyZSBwZXJtaXNzaW9uIHRvIGRvIGRpcnZlciBiaW5kaW5nCj4+IGFuZCBp
biB0aGUgY2FzZSBvZiBvcGVuc3RhY2sgd2lsbAo+PiBub3QgaGF2ZSB0aGUgY2FwYWJsaXR5IHRv
IGJpbmQgdGhlIHZkcGEgZGV2aWNlIHRvIGEgZGlydmllciBpbiB0aGUgY3VycmVudAo+PiBwcm9w
b3NlZCBkZXNpZ24uCj4+IHRoZSBvcmRlcmluZyB3ZSBhcmUgZXhwZWN0aW5nIHRvIHN1cHBvcnQg
aW4gb3BlbnN0YWNrIGF0IGxlYXN0IGluaXRhbGx5IGlzCj4+IHRoYXQgdGhlIGFkbWluc2l0cmF0
b3IKPj4gd2lsbCB1c2UgZWl0aGVyIHN5c3RlbWQgc2VydmljZSBmaWxlcyBvciB1ZGV2IHJ1bGVz
IHRvIGFsbG9jYXRlIHRoZSBWRiBhbmQKPj4gdmRwYSBkZXZpY2Ugc3RhaWN0bHkgYXQgYm9vdC4K
Pj4KPj4gaW4gdGhlIGNhc2Ugb2Ygb3BlbnN0YWNrIHdlIHdpbGwgZXhwZWN0IGFsbCB2ZHBhIGRl
dmllcyB0aGF0IHdpbGwgYmUgdXNlZCBieQo+PiBvcGVuc3RhY2sobm92YSkgZm9yIGFzc2lnbm1l
bnQKPj4gdG8gdm1zIHdpbGwgYmUgcHJlYm91bmQgYnkgdGhlIGFkbWluc3RyYXRvcnMgdG8gdmhv
c3QtdmRwYS4gb3BlbnN0YWNrIHdpbGwKPj4gc2ltcGx5IHRyYWNrIHRoZSAvZGV2L3Zob3N0KiBw
YXRocwo+PiBjb3JhbGxhdGVkIHRvIHRoZSB2ZHBhIGRldmljZXMgd2hvc2UgcGFyZW50IFZGIGFy
ZSBhbGxvd2VkIGJ5IHRoZSBwY2kKPj4gcGFzc3Rob3VnaCB3aGl0ZWxpc3QuCj4+Cj4+IGlmIHRo
ZSBhZG1pbnN0cmF0b3IgYmluZHMgdGhlIHZkcGEgZGV2aWNlIHRvIHZpcnRpby12ZHBhIHNvIHRo
YXQKPj4gdmlydGlvLW5ldC1wY2kgaXMgdXNlZCBvbiB0aGUgaG9zdCBub3ZhIGFuZCBsaWJ2aXJ0
Cj4+IHdpbGwgbm90IGNvcnJlY3QgdGhhdCBhbmQgdGhlIHZtIGJvb3Qgd2lsbCBmYWlsLiBidXQg
cHJvdmlkZWQgeW91IGRvIG5vdCBsaXN0Cj4+IHRoYXQgcGFyZW50IFZGIGluIHRoZSB3aGl0ZWxp
c3Qgbm92YQo+PiB3aWxsIGFsc28gaWdub3JlIGl0LiBzbyBpZiB5b3Ugd2FudCB0byBtaXggYW5k
IG1hdGNoIHRoZSB2ZHBhIGRldmljZSBkcml2ZXIKPj4gdGhhdCBzaG91bGQgbm90IGJyZWFrIGFu
eXRoaW5nIHByb3ZpZGVkCj4+IHlvdSBkbyBub3QgbGlzdCBpdHMgcGFyZW50IGluIHRoZSBwY2kg
d2hpdGVsaXN0Lgo+Pgo+PiBidXQgb25lIHRoaW5nIHRvIGtlZXAgaW4gbWluZCBpcyB3aGxpZSB3
ZSBhcmUgbm90IHBsYW5uaW5nIHRvIGNyZWF0ZSBWRi9WRFBBCj4+IGRldmljZXMgZHluYW1pY2xh
bHkgYXQgbGVzYXQgbm90IGZvciB0aGUgaW5pdGFsbAo+PiBpbXBsZW50YXRpb24gd2UgZG8gZXhw
YWN0IHRvIGJlIGFibGUgdG8gY29uZmlndXJlIGF0dGlidXRlIG9mIHRoZSB2ZHBhIGRldmljZQo+
PiBhZnRlciB0ZWh5IGFyZSBjcmVhdGUgbGlrZSBhbnkgb3RoZXIgbmljLgo+PiBmb3IgZXhhbXBs
ZSB0aGUgbWFjLCBtdHUsIGxpbmstc3RhdGUgc2hvdWxkIGFsbCBiZSBjb25maWd1cmVhYmxlIGF0
IHJ1bnRpbWUKPj4gdmlhIG5vcm1hbCBpcCByb3V0ZTIgY29tbWFuZHMuCj4gCj4gCj4gU28gaW4g
dGhlIGNhc2Ugb2YgdkRQQSwgdGhpcyB0YXNrIGlzIGV4cGVjdGVkIHRvIGJlIGRvbmUgYnkgdmRw
YSB0b29sLiAoVGhlcmUncwo+IG5vIGd1YXJhbnRlZSB0aGF0IHZEUEEgaXMgYSBWRikuCj4gCj4g
Cj4+Cj4+IGF0IHRoZSBtb3JtZW50IHdlIGFyZSBlbmNvdW50ZXJuZyBpc3N1ZSB3aXRoIHRoZSBt
YWMgYWRyZXNzIHNwZWNpZmljbHkgd2hpY2gKPj4gcWVtdSBpcyBob3BlZnVsbHkgZ29pbmcgdG8g
d29yayBhcm91bmQgc2luY2UKPj4gbGlidmlydCBhbmQgbm92YSBjYW5ub3QgY3VycmVudGx5IGNv
bmZpZ3VyZSB0aGUgbWFjIGFkZHJlc3Mgb2YgYSB2aG9zdC12ZHBhCj4+IGRldmljZSBzbyB3ZSBh
cmUgcmVseWluZyBvbiBxZW11Cj4+IHRvIHRha2UgdGhlIG1hYyBhZHJlc3MgZm9ybSB0aGUgcWVt
dSBjb21tYW5kIGxpbmUgc28gdGhhdCBpdCBkb2VzIG5vdCBlbmQgdXAKPj4gYXMgYWxsIDAgbWFj
cyBpbiB0aGUgZ3Vlc3QuCj4gCj4gCj4gTm90ZSB0aGF0IGEga2VybmVsIHBhdGNoIGlzIHBvc3Rl
ZCBieSBFbGlbMV0gd2hpY2ggYXNzaWduIGEgcmFuZG9taXplZCBtYWMuIFRoaXMKPiBzaG91bGQg
c29sdmUgdGhlIGlzc3VlIGluIGFub3RoZXIgd2F5Lgo+IAo+IAo+PiBhcyBzb21lIG9uZSB0aGF0
IHdvcmtzIG9uIG9yY2VzdHJhdGlvbiBsZXZlbCBpIHdvdWxkIGhhdmUgZXhwZWN0IHRoYXQgc2V0
dGluZwo+PiB0aGUgbWFjL210dSBvbiBlaXRoZXIgdGhlIHZmIG9yIHRoZSBuZXRkZXYKPj4gcmVw
cmVzZW50b3IgdG8gbWF0Y2ggdGhlIGRlaXJlZWQgbWFjL210dSBpbiB0aGUgZ3Vlc3Qgd291bGQg
aGF2ZSBiZWVuCj4+IHN1ZmZpY2VudCB0byBhbHRlciB0aGUgdmRwYSBkZXZpY2UgY29uZmlydXRh
dGlvbi4KPj4gbGlrZWx5wqAgdGhlIG5ldGRldiByZXByZXNlbnRvciB3b3VsZCBtYWtlIHRoZSBt
b3N0IHNlbmNlIHRvIGFsdGVyIHRvIG1hdGNoIHRoZQo+PiBkZXNpcmVkIG1hYyBzbyB0aGF0IHRo
ZSBtYWMgYWRyZXNzIHNlZSBvbiB0aGUgb3ZzCj4+IGJyaWRnZSBtYXRjaGVzIHRoZSBtYWMgb2Yg
dGhlIHZtLgo+IAo+IAo+IFNwZWFraW5nIGZvciBnZW5yZWFsIHZEUEEsIGl0J3Mgbm90IGd1YXJh
bnRlZWQgdGhhdCB0aGUgdmVuZG9yIHdpbGwgaW1wbG1lbmV0Cj4gdGhlIGRldmljZSB3aXRoIGEg
cmVwcmVzZW50b3IuIFNvIHZEUEEgdG9vbCBpcyBleHBlY3RlZCB0byBiZSB0aGUgb25seSB3YXkg
dG8KPiBjb25maWd1cmUgdGhlIGRldmljZS4KPiAKPiBUaGFua3MKPiAKPiBbMV0gaHR0cHM6Ly93
d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtdmlydHVhbGl6YXRpb24vbXNnNDg0NTEuaHRtbAo+
IAo+IAo+PiB0aGUgY3VycmVudCBjYXNlIHdoZXJlIHRoZSB2ZHBhIHJlcHJlc2VudG9yIG5ldGRl
diBzZWFtcyB0byBoYXZlIG5vIGJhcmVpbmcgb24KPj4gdGhlIHZkcGEgZGV2aWNlCj4+IGNvbmZp
ZyBtYWtlcyBkZWJ1Z2dpbmcgbXVjaCBtb3JlIGRpZmZpY2FsdCBhbmQgaXMgbGlrZWx5IHRvIGNv
bmZ1c2UgbW9uaXRvcmluZwo+PiBzb2Z0d2FyZS4gZm9ydHVuZXRseSBvcGVuc3RhY2sgaXMgbm90
IG1hdGNoaW5nIG9uIHRoZSBtYWMKPj4gYWRkcmVzcyBpbiB0aGlzIHNwZWZpYyBjYXNlIHRvIGlk
ZW50aWZ5IHRoZSBuZXRkZXYgcmVwcmVzbnRvciBwb3J0IGJ1dCB3ZSBoYXZlCj4+IG90aGVyIGJh
Y2tlbmQgdGhhdCBkbyBsb29rIGF0IHRoZSBtYWMuIGluIHRoZSBjYXNlIG9mIG92cwo+PiB3ZSBz
dG9yZSB0aGUgdXVpZCBvZiB0aGUgbmV1dHJvbiBwb3J0IGluIHRoZSBvdnNkYiB3aGVuIGFkZGlu
ZyBhIHBvcnQgdG8gb3ZzCj4+IHNvIHdlIHJlbHkgb24gdGhhdCBub3QgdGhlIG1hYyBidXTCoCBm
b3IgbGVnYWN5IG1vZGUKPj4gc3Jpb3Ygd2hpY2ggd2UgaG9wZSB0byBzdXBwb3J0IHdpdGggdmRw
YSBldmVudHVsYWxseSBhZnRlciB3ZSBjb21wbGUgdGhlCj4+IGhhcmR3YXJlIG9mZmxvYWVkIG92
cyBzdXBwb3J0LCBjdXJyZW5sdHkgcmVseXMgb24gdGhlIG1hYyBpbiBzb21lIGNhc2VzLgo+Pgo+
PiBpIGhvcGUgdGhhdCBhbnN3ZXJlZCB5b3VyIHF1ZXN0aW9ucz8KPj4gd2UgYXJlIGF3YXJlIHRo
YXQgd2UgbGlrZWx5IHdpbGwgaGF2ZSB0byBzdXBwb3J0IHZkcGEgZGV2aWNlIGNyZWF0aW9uIGF0
IHNvbWUKPj4gcG9pbnQgaWYgd2UgaW50ZW5kIHRvIGFkZCBzdXBwb3J0IGZvciB2ZHBhIGRldmlj
ZXMKPj4gY3JlYXRlZCBmb3JtIHN1YmZ1bmN0aW9ucyBvciBpbnRlbHMgc2lvdiBob3d2ZXIgdGhh
dCB3YXMgbm90IHJlYWR5IHdoZW4gd2UKPj4gc3RhcnRlZCB0aGlzIHdvcmsgc28gaXQgd2FzIGRl
Y2xhcmVkIG91dCBvZiBzY29wZSBhbmQKPj4gdGhlIGN1cmVybnQgc3RhdGljIGFwcHJvY2ggd2Fz
IHRha2VuIGFzIHRoZSBvbmx5IHBhdGggd2UgY291bGQgZW5hYmxlIGJlZm9yZQo+PiBjb2RlIGZy
ZWUgaW4gMTAgZGF5cy4KPj4KPj4gcmVnYXJkcyBzZWFuLgo+Pgo+Pj4KPj4+IFRoYW5rcwo+Pj4K
Pj4KPj4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtdmlydHVhbGl6YXRpb24v
bXNnNDg0NTEuaHRtbAo+IAoKLS0gCkFkcmnDoW4gTW9yZW5vCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
