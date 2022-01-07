Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFD4C433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 05:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D8778332A;
	Fri,  7 Jan 2022 05:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rgl2Joe5qnfZ; Fri,  7 Jan 2022 05:47:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2117281BF5;
	Fri,  7 Jan 2022 05:47:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4E67C002F;
	Fri,  7 Jan 2022 05:47:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1697AC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1A34831A7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7S1cpFzroktL
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:47:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 41CB381BF5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641534420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVeLccMWk7cjALKc0FiZJ8jeRwXIPPqlQk5Io9/jYg8=;
 b=GUXZ3MQGDBGZUIxAAZsaO5f2GxKUcEvGfzRxzVzH3JubkDWQXMPLEARsiQylGlMie/ryJi
 yewLh1nrhB1+lsSU4cxf8Kq37fT9PXKSqDKvEjsw8AugjKvB7K4+NKZnK+W0TOeUQ7XPYr
 pyyCs+EKCH5O68gc8hG2sL+AkLZguTg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-bfVKsCKYNXGVjvn7z_rJ8w-1; Fri, 07 Jan 2022 00:46:58 -0500
X-MC-Unique: bfVKsCKYNXGVjvn7z_rJ8w-1
Received: by mail-pj1-f72.google.com with SMTP id
 a4-20020a17090a70c400b001b21d9c8bc8so6680551pjm.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 21:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=TVeLccMWk7cjALKc0FiZJ8jeRwXIPPqlQk5Io9/jYg8=;
 b=vSEl0hS+hcdxOXTq3/LNOWNl8iUI6BNXanIVwOIs6FJXw2Q7iHx3zLnHMUlJYsUy85
 irerDRphY91V9eTXBD/5h7aGT85VfMBAfI+7cUX1p5nFXkLZiDOklM1dxjgx99CADhqI
 nCX72vQ9AxL+80BIDTb6j22giDssMc1JdzqK3OAU7LUTdat0qMEBJcS0fwZNWJeCyP2+
 2aStyc801guMpmz/IWxzY4l+K9Pb2AVtqs/9/nfRCwpDnQiKr+eRjtgu1O7+oVU05OvZ
 ph85Po+0kp2mTk9arGGR6uB1BeJGGOzzebsDbhRKjxSOkX3LM3R+cnK7Yo7Q2YYw0AGR
 RAYg==
X-Gm-Message-State: AOAM530j9jAX19omu+g//dal/7MLlAebRhu12ZGPoEBr1rNNa4pNVrHx
 dkaXH92AwqlEdDb9iAA/JcgNGSN5Gx9D3eI0bnL6+lWK67Wai8BvcUpY+T8tuAUoGqirzvCSNXU
 8XdUHGADyCQUYmHa6rUg43QmIlYX6Ca72atdNsHw7qw==
X-Received: by 2002:a17:902:f68a:b0:149:51c0:60a1 with SMTP id
 l10-20020a170902f68a00b0014951c060a1mr60581871plg.31.1641534417752; 
 Thu, 06 Jan 2022 21:46:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwm1EtOJ9DudqmHy5eBxdJMeu2o7DYiyJKh7yHrlsQ94+Zk83aBGBtv9qBlaLD32UTFTFaHxg==
X-Received: by 2002:a17:902:f68a:b0:149:51c0:60a1 with SMTP id
 l10-20020a170902f68a00b0014951c060a1mr60581846plg.31.1641534417399; 
 Thu, 06 Jan 2022 21:46:57 -0800 (PST)
Received: from [10.72.13.245] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f12sm4285322pfe.127.2022.01.06.21.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jan 2022 21:46:57 -0800 (PST)
Message-ID: <23ad316c-453f-4305-be93-07cc71d5eb9a@redhat.com>
Date: Fri, 7 Jan 2022 13:46:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v7 08/14] vdpa: Add support for returning device
 configuration information
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-9-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220105114646.577224-9-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lvivier@redhat.com, eperezma@redhat.com, si-wei.liu@oracle.com
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

CuWcqCAyMDIyLzEvNSDkuIvljYg3OjQ2LCBFbGkgQ29oZW4g5YaZ6YGTOgo+IEFkZCBuZXRsaW5r
IGF0dHJpYnV0ZSB0byBzdG9yZSB0aGUgbmVnb3RpYXRlZCBmZWF0dXJlcy4gVGhpcyBjYW4gYmUg
dXNlZAo+IGJ5IHVzZXJzcGFjZSB0byBnZXQgdGhlIGN1cnJlbnQgc3RhdGUgb2YgdGhlIHZkcGEg
aW5zdGFuY2UuCj4KPiBFeGFtcGxlczoKPgo+ICQgdmRwYSBkZXYgY29uZmlnIHNob3cgdmRwYS1h
Cj4gdmRwYS1hOiBtYWMgMDA6MDA6MDA6MDA6ODg6ODggbGluayB1cCBsaW5rX2Fubm91bmNlIGZh
bHNlIG1heF92cV9wYWlycyAxNiBtdHUgMTUwMAo+ICAgIG5lZ290aWF0ZWRfZmVhdHVyZXMgQ1NV
TSBHVUVTVF9DU1VNIE1UVSBNQUMgSE9TVF9UU080IEhPU1RfVFNPNiBTVEFUVVMgXAo+ICAgIENU
UkxfVlEgTVEgQ1RSTF9NQUNfQUREUiBWRVJTSU9OXzEgQUNDRVNTX1BMQVRGT1JNCj4KPiAkIHZk
cGEgLWogZGV2IGNvbmZpZyBzaG93IHZkcGEtYQo+IHsiY29uZmlnIjp7InZkcGEtYSI6eyJtYWMi
OiIwMDowMDowMDowMDo4ODo4OCIsImxpbmsgIjoidXAiLCJsaW5rX2Fubm91bmNlIjpmYWxzZSwg
XAo+ICAgIm1heF92cV9wYWlycyI6MTYsIm10dSI6MTUwMCwibmVnb3RpYXRlZF9mZWF0dXJlcyI6
WyJDU1VNIiwiR1VFU1RfQ1NVTSIsIk1UVSIsIk1BQyIsIFwKPiAgICJIT1NUX1RTTzQiLCJIT1NU
X1RTTzYiLCJTVEFUVVMiLCJDVFJMX1ZRIiwiTVEiLCJDVFJMX01BQ19BRERSIiwiVkVSU0lPTl8x
IiwgXAo+ICAgIkFDQ0VTU19QTEFURk9STSJdfX19Cj4KPiAkIHZkcGEgLWpwIGRldiBjb25maWcg
c2hvdyB2ZHBhLWEKPiB7Cj4gICAgICAiY29uZmlnIjogewo+ICAgICAgICAgICJ2ZHBhLWEiOiB7
Cj4gICAgICAgICAgICAgICJtYWMiOiAiMDA6MDA6MDA6MDA6ODg6ODgiLAo+ICAgICAgICAgICAg
ICAibGluayAiOiAidXAiLAo+ICAgICAgICAgICAgICAibGlua19hbm5vdW5jZSAiOiBmYWxzZSwK
PiAgICAgICAgICAgICAgIm1heF92cV9wYWlycyI6IDE2LAo+ICAgICAgICAgICAgICAibXR1Ijog
MTUwMCwKPiAgICAgICAgICAgICAgIm5lZ290aWF0ZWRfZmVhdHVyZXMiOiBbCj4gIkNTVU0iLCJH
VUVTVF9DU1VNIiwiTVRVIiwiTUFDIiwiSE9TVF9UU080IiwiSE9TVF9UU082IiwiU1RBVFVTIiwi
Q1RSTF9WUSIsIk1RIiwgXAo+ICJDVFJMX01BQ19BRERSIiwiVkVSU0lPTl8xIiwiQUNDRVNTX1BM
QVRGT1JNIgo+IF0KPiAgICAgICAgICB9Cj4gICAgICB9Cj4gfQo+Cj4gU2lnbmVkLW9mZi1ieTog
RWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhLmMgICAgICAgfCAz
ICsrKwo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZkcGEuaCB8IDQgKysrKwo+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRw
YS5jIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+IGluZGV4IDk2ZDMxYjgwZmRjZS4uNjBjZjgyMTE3
NWZhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zk
cGEvdmRwYS5jCj4gQEAgLTg0Niw2ICs4NDYsOSBAQCBzdGF0aWMgaW50IHZkcGFfZGV2X25ldF9j
b25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCBza19idWZmICptcwo+
ICAgCQlyZXR1cm4gLUVNU0dTSVpFOwo+ICAgCj4gICAJZmVhdHVyZXMgPSB2ZGV2LT5jb25maWct
PmdldF9kcml2ZXJfZmVhdHVyZXModmRldik7Cj4gKwlpZiAobmxhX3B1dF91NjRfNjRiaXQobXNn
LCBWRFBBX0FUVFJfREVWX05FR09USUFURURfRkVBVFVSRVMsIGZlYXR1cmVzLAo+ICsJCQkgICAg
ICBWRFBBX0FUVFJfUEFEKSkKPiArCQlyZXR1cm4gLUVNU0dTSVpFOwo+ICAgCj4gICAJcmV0dXJu
IHZkcGFfZGV2X25ldF9tcV9jb25maWdfZmlsbCh2ZGV2LCBtc2csIGZlYXR1cmVzLCAmY29uZmln
KTsKPiAgIH0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZkcGEuaCBiL2luY2x1
ZGUvdWFwaS9saW51eC92ZHBhLmgKPiBpbmRleCBhMjUyZjA2ZjlkZmQuLmRiMzczOGVmM2JlYiAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmRwYS5oCj4gKysrIGIvaW5jbHVkZS91
YXBpL2xpbnV4L3ZkcGEuaAo+IEBAIC0yMyw2ICsyMyw5IEBAIGVudW0gdmRwYV9jb21tYW5kIHsK
PiAgIGVudW0gdmRwYV9hdHRyIHsKPiAgIAlWRFBBX0FUVFJfVU5TUEVDLAo+ICAgCj4gKwkvKiBQ
YWQgYXR0cmlidXRlIGZvciA2NGIgYWxpZ25tZW50ICovCj4gKwlWRFBBX0FUVFJfUEFEID0gVkRQ
QV9BVFRSX1VOU1BFQywKPiArCj4gICAJLyogYnVzIG5hbWUgKG9wdGlvbmFsKSArIGRldiBuYW1l
IHRvZ2V0aGVyIG1ha2UgdGhlIHBhcmVudCBkZXZpY2UgaGFuZGxlICovCj4gICAJVkRQQV9BVFRS
X01HTVRERVZfQlVTX05BTUUsCQkvKiBzdHJpbmcgKi8KPiAgIAlWRFBBX0FUVFJfTUdNVERFVl9E
RVZfTkFNRSwJCS8qIHN0cmluZyAqLwo+IEBAIC00MCw2ICs0Myw3IEBAIGVudW0gdmRwYV9hdHRy
IHsKPiAgIAlWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUCwJCS8qIHUxNiAqLwo+ICAgCVZE
UEFfQVRUUl9ERVZfTkVUX0NGR19NVFUsCQkvKiB1MTYgKi8KPiAgIAo+ICsJVkRQQV9BVFRSX0RF
Vl9ORUdPVElBVEVEX0ZFQVRVUkVTLAkvKiB1NjQgKi8KPiAgIAkvKiBuZXcgYXR0cmlidXRlcyBt
dXN0IGJlIGFkZGVkIGFib3ZlIGhlcmUgKi8KPiAgIAlWRFBBX0FUVFJfTUFYLAo+ICAgfTsKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
