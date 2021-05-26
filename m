Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CA8C4707F
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 01:10:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66FB613F1
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 01:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66FB613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 946A86060F;
	Wed, 26 May 2021 01:10:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fvbshDNRkemV; Wed, 26 May 2021 01:10:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2EBC60BB8;
	Wed, 26 May 2021 01:10:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1DDCC000E;
	Wed, 26 May 2021 01:10:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ED0AC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 760F9401DF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:10:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iuW-qaW_vdR1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:10:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90C634000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621991436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KzC2CKBPK975eq6q132gtNtHNlTGt5fuCv74AVDmyA=;
 b=GqATHnmlrYonnjkgHUt10C++wqmUte9d1RFyGYr/D+s0Ar0BfiGO3j21TEvdZnzGudCEuo
 3K5EtOW8N5jFnPsZByUbvwlU4+wzZxp/+p4oY57afhoUuiyxZhJOTh7ztLE/mEef8lNB8X
 SWzi5sfvwAyH70suv2qcmN9DQ7lD+Bk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-XG8t0UhvMCyBWn5HYY3KSw-1; Tue, 25 May 2021 21:10:34 -0400
X-MC-Unique: XG8t0UhvMCyBWn5HYY3KSw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d14-20020a056a00198eb029028eb1d4a555so21389206pfl.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 18:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1KzC2CKBPK975eq6q132gtNtHNlTGt5fuCv74AVDmyA=;
 b=dwGfU6G5I9WzluNIuc+QILGV9ye+CdVRNA0dzx4jOdVWTrWNliXfSgh1mOYY7LvyS8
 YoxONRywlXqz/pMXdIL3aXmI19suHnHT5jxlF19TtEkbOVzCfwOIPkO9m9qybo5ffnz3
 ovccEAD4335KLgE67PhjYMAgpO5EKQ4bpvQ10e72K4izlBxNRM+Gcz2u8jotrJzbU6p3
 Le9jPbmFD2z4jtKkhbbPyL9fAlK8VU00pvjIKXpfLjeemhhChiDoAIgXKf9Ar04M4mm2
 6CL37iK7XrHJTzK+52yDy3fwxQtyGzcPC2cJfOQAVuzqifZPpZCIR4WX03A7SJvy++CL
 Ma/A==
X-Gm-Message-State: AOAM533etAbAciW9tEcNVKx3IVaTsPCGYTTdKwmR6hUX7GdWO5xbtxvO
 AvykBhQAH+NRPQSVDPKKHOqY9OcDC0LNjxKo3oUE/omaSuFUpwmIT1byaNSEPcXBI1SOkVpjiTg
 xntTrlhOQC+c/kEBpKl0lHuGZ1y+KervPRq1TjjrmJm3kqrlwrI3xaszhetFXgz12lxxMuKWso+
 H+v7Kv1EcYuk0OfpV3qQ==
X-Received: by 2002:a17:90b:88f:: with SMTP id
 bj15mr1197094pjb.46.1621991433339; 
 Tue, 25 May 2021 18:10:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfIURnNz5xynGV72WQBQLr7VHqkPZS3HYnoN69JL+cPCVdyCs+Wsg+rlGczLW6tqrbJEBBMg==
X-Received: by 2002:a17:90b:88f:: with SMTP id
 bj15mr1197046pjb.46.1621991432976; 
 Tue, 25 May 2021 18:10:32 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 11sm14105812pfh.182.2021.05.25.18.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 May 2021 18:10:32 -0700 (PDT)
Subject: Re: [RFC v3 06/29] virtio-net: Honor VIRTIO_CONFIG_S_DEVICE_STOPPED
From: Jason Wang <jasowang@redhat.com>
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210519162903.1172366-1-eperezma@redhat.com>
 <20210519162903.1172366-7-eperezma@redhat.com>
 <e64b9813-66e5-2417-3feb-65f0376db7e0@redhat.com>
Message-ID: <4146c924-e871-5a94-253e-e9e09456f74b@redhat.com>
Date: Wed, 26 May 2021 09:10:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <e64b9813-66e5-2417-3feb-65f0376db7e0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzUvMjYg5LiK5Y2IOTowNiwgSmFzb24gV2FuZyDlhpnpgZM6Cj4KPiDlnKggMjAy
MS81LzIwIOS4iuWNiDEyOjI4LCBFdWdlbmlvIFDDqXJleiDlhpnpgZM6Cj4+IFNvIHRoZSBndWVz
dCBjYW4gc3RvcCBhbmQgc3RhcnQgbmV0IGRldmljZS4gSXQgaW1wbGVtZW50cyB0aGUgUkZDCj4+
IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAy
MDEyL21zZzAwMDI3Lmh0bWwgCj4+Cj4+Cj4+IFRvIHN0b3AgKGFzICJwYXVzZSIpIHRoZSBkZXZp
Y2UgaXMgcmVxdWlyZWQgdG8gbWlncmF0ZSBzdGF0dXMgYW5kIHZyaW5nCj4+IGFkZHJlc3NlcyBi
ZXR3ZWVuIGRldmljZSBhbmQgU1ZRLgo+Pgo+PiBUaGlzIGlzIGEgV0lQIGNvbW1pdDogYXMgd2l0
aCBWSVJUSU9fRl9RVUVVRV9TVEFURSwgaXMgaW50cm9kdWNlZCBpbgo+PiB2aXJ0aW9fY29uZmln
LmggYmVmb3JlIG9mIGV2ZW4gcHJvcG9zaW5nIGZvciB0aGUga2VybmVsLCB3aXRoIG5vIGZlYXR1
cmUKPj4gZmxhZywgYW5kLCB3aXRoIG5vIGNoZWNraW5nIGluIHRoZSBkZXZpY2UuIEl0IGFsc28g
bmVlZHMgYSBtb2RpZmllZAo+PiB2cF92ZHBhIGRyaXZlciB0aGF0IHN1cHBvcnRzIHRvIHNldCBh
bmQgcmV0cmlldmUgc3RhdHVzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8
ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPj4gLS0tCj4+IMKgIGluY2x1ZGUvc3RhbmRhcmQtaGVhZGVy
cy9saW51eC92aXJ0aW9fY29uZmlnLmggfCAyICsrCj4+IMKgIGh3L25ldC92aXJ0aW8tbmV0LmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0
ICsrKy0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPj4KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0
aW9fY29uZmlnLmggCj4+IGIvaW5jbHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3ZpcnRpb19j
b25maWcuaAo+PiBpbmRleCA1OWZhZDNlYjQ1Li5iM2Y2YjEzNjVkIDEwMDY0NAo+PiAtLS0gYS9p
bmNsdWRlL3N0YW5kYXJkLWhlYWRlcnMvbGludXgvdmlydGlvX2NvbmZpZy5oCj4+ICsrKyBiL2lu
Y2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fY29uZmlnLmgKPj4gQEAgLTQwLDYg
KzQwLDggQEAKPj4gwqAgI2RlZmluZSBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LwqDCoMKgIDQK
Pj4gwqAgLyogRHJpdmVyIGhhcyBmaW5pc2hlZCBjb25maWd1cmluZyBmZWF0dXJlcyAqLwo+PiDC
oCAjZGVmaW5lIFZJUlRJT19DT05GSUdfU19GRUFUVVJFU19PS8KgwqDCoCA4Cj4+ICsvKiBEZXZp
Y2UgaXMgc3RvcHBlZCAqLwo+PiArI2RlZmluZSBWSVJUSU9fQ09ORklHX1NfREVWSUNFX1NUT1BQ
RUQgMzIKPj4gwqAgLyogRGV2aWNlIGVudGVyZWQgaW52YWxpZCBzdGF0ZSwgZHJpdmVyIG11c3Qg
cmVzZXQgaXQgKi8KPj4gwqAgI2RlZmluZSBWSVJUSU9fQ09ORklHX1NfTkVFRFNfUkVTRVTCoMKg
wqAgMHg0MAo+PiDCoCAvKiBXZSd2ZSBnaXZlbiB1cCBvbiB0aGlzIGRldmljZS4gKi8KPj4gZGlm
ZiAtLWdpdCBhL2h3L25ldC92aXJ0aW8tbmV0LmMgYi9ody9uZXQvdmlydGlvLW5ldC5jCj4+IGlu
ZGV4IDk2YTNjYzgzNTcuLjJkM2NhZWEyODkgMTAwNjQ0Cj4+IC0tLSBhL2h3L25ldC92aXJ0aW8t
bmV0LmMKPj4gKysrIGIvaHcvbmV0L3ZpcnRpby1uZXQuYwo+PiBAQCAtMTk4LDcgKzE5OCw5IEBA
IHN0YXRpYyBib29sIHZpcnRpb19uZXRfc3RhcnRlZChWaXJ0SU9OZXQgKm4sIAo+PiB1aW50OF90
IHN0YXR1cykKPj4gwqAgewo+PiDCoMKgwqDCoMKgIFZpcnRJT0RldmljZSAqdmRldiA9IFZJUlRJ
T19ERVZJQ0Uobik7Cj4+IMKgwqDCoMKgwqAgcmV0dXJuIChzdGF0dXMgJiBWSVJUSU9fQ09ORklH
X1NfRFJJVkVSX09LKSAmJgo+PiAtwqDCoMKgwqDCoMKgwqAgKG4tPnN0YXR1cyAmIFZJUlRJT19O
RVRfU19MSU5LX1VQKSAmJiB2ZGV2LT52bV9ydW5uaW5nOwo+PiArwqDCoMKgwqDCoMKgwqAgKCEo
bi0+c3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RFVklDRV9TVE9QUEVEKSkgJiYKPj4gK8KgwqDC
oMKgwqDCoMKgIChuLT5zdGF0dXMgJiBWSVJUSU9fTkVUX1NfTElOS19VUCkgJiYKPj4gK8KgwqDC
oMKgwqDCoMKgIHZkZXYtPnZtX3J1bm5pbmc7Cj4+IMKgIH0KPj4gwqAgwqAgc3RhdGljIHZvaWQg
dmlydGlvX25ldF9hbm5vdW5jZV9ub3RpZnkoVmlydElPTmV0ICpuZXQpCj4KPgo+IEl0IGxvb2tz
IHRvIG1lIHRoaXMgaXMgb25seSB0aGUgcGFydCBvZiBwYXVzZS4gCgoKQW5kIGV2ZW4gZm9yIHBh
dXNlLCBJIGRvbid0IHNlZSBhbnl0aGluZyB0aGF0IHByZXZlbnRzIHJ4L3R4IGZyb20gYmVpbmcg
CmV4ZWN1dGVkPyAoRS5nIHZpcnRpb19uZXRfaGFuZGxlX3R4X2JoIG9yIHZpcnRpb19uZXRfaGFu
ZGxlX3J4KS4KClRoYW5rcwoKCj4gV2Ugc3RpbGwgbmVlZCB0aGUgcmVzdW1lPwo+Cj4gVGhhbmtz
Cj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
