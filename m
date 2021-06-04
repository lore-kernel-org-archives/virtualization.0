Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B978BC47082
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:34:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BB061406
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BB061406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29FA26F94A;
	Fri,  4 Jun 2021 02:34:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EiRpLHT3ydjw; Fri,  4 Jun 2021 02:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B769E606E5;
	Fri,  4 Jun 2021 02:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E09DC000D;
	Fri,  4 Jun 2021 02:34:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFF22C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B641A6F945
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nRiy_RwHEtj6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:34:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 049E8606E5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622774077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ATIV3lDYkeBG2ItauQh63eZvgnQmlyDQqyjAxJgLIM4=;
 b=C01Yf7MLm9HR3mUQGr6wviSl8t6J1gqohdAMFmHlMKRd3GeX9Zo/Lg5eS9JmjL1cppKHYY
 OPxE1XNJWiieAW/KGw7EdDESl39Ir4w2rrzwPx4MtpNK+42ZTToe/+Iex58PDYTioaXTzX
 Deb2BH6jDfaBlLLJNKubo0m60g/rEG0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-VuFqy9YgOtiP2wY1q85hBw-1; Thu, 03 Jun 2021 22:34:34 -0400
X-MC-Unique: VuFqy9YgOtiP2wY1q85hBw-1
Received: by mail-pg1-f200.google.com with SMTP id
 k9-20020a63d1090000b029021091ebb84cso5098537pgg.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 19:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ATIV3lDYkeBG2ItauQh63eZvgnQmlyDQqyjAxJgLIM4=;
 b=tpO2/1rDx45odUElS+6AJplfPMeTQkiff44voaeTpY6nOUQDVTFnorfjxFM4O3SFdt
 PCiYne2Idna+B4atcCjA6nTpxe9H54qJyBxKNwQ/2K8nSQpnE6PsYbykuSpE8s0Ouebp
 dAMbUqFlIKcndgcoeTzhm12ibH3emY2gpzCciwa5OmrIq2mlJPD8pX3EIwLVDWC9TqYo
 wt2MUyAk2stTo4FCPC7WiY2y1OtkOFrrUzwQvmxGBgWjsIKhJbeQDUHcC7hygKaq/wVM
 paUEuYSIvsfgS4aVfdWNBdyqBzKIdBx5ajF/HEhXInxdvmPBGWhtpMYkRQ9GD/Q8T5iB
 REPw==
X-Gm-Message-State: AOAM5314SGy9JhR/1TRplRk1n1Hyp3RiXQrlo+eWXJCiyYVWzWq7PGQz
 SJkWw/sLdNMeKt4LKzaymzsFZTUX0cceZEOVnmdvDKDiU/rUaVvvEGrRHs8r4DrSofGG0rX6RkN
 BdfutP8DrUjbUypRzOcdOkmzm0ACWJsyRSEce90wp5Q==
X-Received: by 2002:a17:90a:5649:: with SMTP id
 d9mr14107889pji.98.1622774073276; 
 Thu, 03 Jun 2021 19:34:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+Q0BWP9i4OnI6AKwpvD0HX9L9iAxi9+TEns1urhL0IXPFrDoiP/Mia4Ml/0TabthZet7qBw==
X-Received: by 2002:a17:90a:5649:: with SMTP id
 d9mr14107874pji.98.1622774073089; 
 Thu, 03 Jun 2021 19:34:33 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 11sm318521pfh.182.2021.06.03.19.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 19:34:32 -0700 (PDT)
Subject: Re: [PATCH v1] vdpa/mlx5: Clear vq ready indication upon device reset
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210603081026.5640-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9ec6480d-3eee-c644-2a06-8a180aa9fb07@redhat.com>
Date: Fri, 4 Jun 2021 10:34:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603081026.5640-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8zIM/Czuc0OjEwLCBFbGkgQ29oZW4g0LS1wDoKPiBBZnRlciBkZXZpY2UgcmVz
ZXQsIHRoZSB2aXJ0cXVldWVzIGFyZSBub3QgcmVhZHkgc28gY2xlYXIgdGhlIHJlYWR5Cj4gZmll
bGQuCj4KPiBGYWlsaW5nIHRvIGRvIHNvIGNhbiByZXN1bHQgaW4gdmlydGlvX3ZkcGEgZmFpbGlu
ZyB0byBsb2FkIGlmIHRoZSBkZXZpY2UKPiB3YXMgcHJldmlvdXNseSB1c2VkIGJ5IHZob3N0X3Zk
cGEgYW5kIHRoZSBvbGQgdmFsdWVzIGFyZSByZWFkeS4KPiB2aXJ0aW9fdmRwYSBleHBlY3RzIHRv
IGZpbmQgVlFzIGluICJub3QgcmVhZHkiIHN0YXRlLgo+Cj4gRml4ZXM6IDFhODZiMzc3YWEyMSAo
InZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikK
PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KPiB2MCAt
LT4gdjE6Cj4gICAgTWFrZSBzdXJlIGNsZWFyIG9mIHJlYWR5IGlzIGRvbmUgb25seSBpbiByZXNl
dCBmbG93Cj4KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDkgKysrKysr
KysrCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jCj4gaW5kZXggMDJhMDU0OTIyMDRjLi5lYWVhZTY3ZTBmZjAgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gQEAgLTE3NjYsNiArMTc2NiwxNCBAQCBzdGF0aWMg
dm9pZCB0ZWFyZG93bl9kcml2ZXIoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gICAJbXV0
ZXhfdW5sb2NrKCZuZGV2LT5yZXNsb2NrKTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCBjbGVh
cl92cXNfcmVhZHkoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gK3sKPiArCWludCBpOwo+
ICsKPiArCWZvciAoaSA9IG5kZXYtPm12ZGV2Lm1heF92cXMgLSAxOyBpID49IDA7IGktLSkKPiAr
CQluZGV2LT52cXNbaV0ucmVhZHkgPSBmYWxzZTsKCgpUaGUgcGF0Y2ggbG9va3MgY29ycmVjdCBi
dXQgSSB3b25kZXIgdGhlIHJlYXNvbiBmb3IgdGhlIGRlY3JlYXNpbmcgdXNlZCAKaW4gdGhlIGxv
b3AuCgpVc3VhbGx5LCBpdCBtZWFucyBpdCBoYXMgc29tZSByZWFzb24gdGhhdCBtdXN0IGJlIGRv
bmUgaW4gdGhhdCB3YXkuCgpUaGFua3MKCgo+ICt9Cj4gKwo+ICAgc3RhdGljIHZvaWQgbWx4NV92
ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpCj4gICB7
Cj4gICAJc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4gQEAg
LTE3NzYsNiArMTc4NCw3IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKQo+ICAgCWlmICghc3RhdHVzKSB7Cj4gICAJ
CW1seDVfdmRwYV9pbmZvKG12ZGV2LCAicGVyZm9ybWluZyBkZXZpY2UgcmVzZXRcbiIpOwo+ICAg
CQl0ZWFyZG93bl9kcml2ZXIobmRldik7Cj4gKwkJY2xlYXJfdnFzX3JlYWR5KG5kZXYpOwo+ICAg
CQltbHg1X3ZkcGFfZGVzdHJveV9tcigmbmRldi0+bXZkZXYpOwo+ICAgCQluZGV2LT5tdmRldi5z
dGF0dXMgPSAwOwo+ICAgCQluZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMgPSAwOwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
