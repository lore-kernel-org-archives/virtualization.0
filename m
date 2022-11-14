Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337EEC4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 04:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9B7E60C27;
	Mon, 14 Nov 2022 04:21:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9B7E60C27
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B6avhRT8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KAk_YKl3hm3n; Mon, 14 Nov 2022 04:21:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1802C60C21;
	Mon, 14 Nov 2022 04:21:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1802C60C21
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7B64C0032;
	Mon, 14 Nov 2022 04:21:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5503EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A6A6400F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:21:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A6A6400F6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B6avhRT8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x6gfs3E5UGWI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:21:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A4FB400DA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A4FB400DA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668399703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/PxqSB+ZWaAy0kr4u8QvCLujCShnQRTc22NQiRK9IMQ=;
 b=B6avhRT8qoBLMeMDfNXHVUNmROMCvOmU3tq877bM5yzpf+mJ6YhXZQwXpKpgO3U/8k9MP3
 lk+t+wEEZwBFHRm7VT9NpA1Svgrhry38X/7TtYvLXerfqgOZ1AroXqwnVD+ibl196j/qXc
 n+sm0c7ZySMPjPHp2u9V218VKSpB/dI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-267-Y9zu_UcjPquEyGNUGHacVA-1; Sun, 13 Nov 2022 23:21:41 -0500
X-MC-Unique: Y9zu_UcjPquEyGNUGHacVA-1
Received: by mail-pl1-f199.google.com with SMTP id
 o7-20020a170902d4c700b001868cdac9adso8130550plg.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 20:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/PxqSB+ZWaAy0kr4u8QvCLujCShnQRTc22NQiRK9IMQ=;
 b=QB5HYWXbmxVB1IMEBIFohHu6+u00kNvK0ACM5UR3Is0oclj3Dji1bHQ2BFCCRigT1F
 2tDdJqG+AsDd/ngFFefiBjMm7uWYnkp7otdR3XmlK9F71UZ5OFriXr8lwq214pUH8Rdg
 o8vrkMNH2a+p6gsrBIvkRGEEbNngeUSoXMDMaJw6Bm1tfnuKfQQwLqSwjQvUlGmI/iWO
 HlC9hKefUmW8Bn3FqcIG1rkPddg20ogGpdQyyFRgJnRnDT4ruvAhPKxqYaujEaaRDVC0
 Bzbfk91CX/+rNRciDn43jW+7dBDzQMO1GsvHyiaKx3EHap039DRTZNm0C883ksbMzOQG
 INRQ==
X-Gm-Message-State: ANoB5pmwWll1abQnLG9JJk4XaDhw9xnrdy4KBy5AKkbAOWFQtuWYQUAY
 eCJfUmhg4oWTN2YJy7uBmvbxSnTJEmr7y/46HOLTDgW5ZCq3UGSWmqLsQHW4kRRj/k3QuOVfkxt
 q3RZyMyIG2JGirSk/+HySzyqD69AaOptHFXdNZhSD/Q==
X-Received: by 2002:a63:d642:0:b0:46f:d2d4:bac4 with SMTP id
 d2-20020a63d642000000b0046fd2d4bac4mr10220117pgj.178.1668399700797; 
 Sun, 13 Nov 2022 20:21:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ZM3CWWgOmrZsKXz+1lD6ieOkbU4UzqcrePVHDGP1OMS0RtsVteexvjrcHSmdn+J+iulaunA==
X-Received: by 2002:a63:d642:0:b0:46f:d2d4:bac4 with SMTP id
 d2-20020a63d642000000b0046fd2d4bac4mr10220096pgj.178.1668399700432; 
 Sun, 13 Nov 2022 20:21:40 -0800 (PST)
Received: from [10.72.13.180] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 jj3-20020a170903048300b001714c36a6e7sm6005269plb.284.2022.11.13.20.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Nov 2022 20:21:39 -0800 (PST)
Message-ID: <11062911-270a-6018-34a4-8edd50674999@redhat.com>
Date: Mon, 14 Nov 2022 12:21:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] vp_vdpa: harden the logic of set status
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>, Stefano Garzarella <sgarzare@redhat.com>
References: <20221111145505.1232-1-longpeng2@huawei.com>
 <20221111151459.dyz42jclq26ai26q@sgarzare-redhat>
 <0f25506f-b9ca-1578-f944-cfb3936ced50@huawei.com>
 <20221111163548.x6yy2w74gk6biykw@sgarzare-redhat>
 <f8650844-1b28-92f0-5330-c164c95ee7ec@huawei.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <f8650844-1b28-92f0-5330-c164c95ee7ec@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: xiehong@huawei.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 yechuan@huawei.com, huangzhichao@huawei.com, stefanha@redhat.com,
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

CuWcqCAyMDIyLzExLzEyIDE1OjMzLCBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1
cmUgU2VydmljZSBQcm9kdWN0IApEZXB0Likg5YaZ6YGTOgo+Cj4KPiDlnKggMjAyMi8xMS8xMiAw
OjM1LCBTdGVmYW5vIEdhcnphcmVsbGEg5YaZ6YGTOgo+PiBPbiBGcmksIE5vdiAxMSwgMjAyMiBh
dCAxMTo0OToxMFBNICswODAwLCBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgCj4+IEluZnJhc3RydWN0
dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0Likgd3JvdGU6Cj4+Pgo+Pj4KPj4+IOWcqCAyMDIyLzEx
LzExIDIzOjE0LCBTdGVmYW5vIEdhcnphcmVsbGEg5YaZ6YGTOgo+Pj4+IE9uIEZyaSwgTm92IDEx
LCAyMDIyIGF0IDEwOjU1OjA1UE0gKzA4MDAsIExvbmdwZW5nKE1pa2UpIHdyb3RlOgo+Pj4+PiBG
cm9tOiBMb25ncGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4+Pj4+Cj4+Pj4+IDEuIFdlIHNo
b3VsZCBub3Qgc2V0IHN0YXR1cyB0byAwIHdoZW4gaW52b2tpbmcgdnBfdmRwYV9zZXRfc3RhdHVz
KCkuCj4+Pj4+Cj4+Pj4+IDIuIFRoZSBkcml2ZXIgTVVTVCB3YWl0IGZvciBhIHJlYWQgb2YgZGV2
aWNlX3N0YXR1cyB0byByZXR1cm4gMCAKPj4+Pj4gYmVmb3JlCj4+Pj4+IMKgIHJlaW5pdGlhbGl6
aW5nIHRoZSBkZXZpY2UuCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IExvbmdwZW5nIDxsb25n
cGVuZzJAaHVhd2VpLmNvbT4KPj4+Pj4gLS0tCj4+Pj4+IGRyaXZlcnMvdmRwYS92aXJ0aW9fcGNp
L3ZwX3ZkcGEuYyB8IDExICsrKysrKysrKystCj4+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMgCj4+Pj4+IGIvZHJpdmVycy92ZHBhL3ZpcnRpb19w
Y2kvdnBfdmRwYS5jCj4+Pj4+IGluZGV4IGQ0NDhkYjBjNGRlMy4uZDM1ZmFjNWNkZTExIDEwMDY0
NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPj4+Pj4gKysr
IGIvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jCj4+Pj4+IEBAIC0yMTIsOCArMjEy
LDEyIEBAIHN0YXRpYyB2b2lkIHZwX3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgCj4+Pj4+IHZkcGFf
ZGV2aWNlICp2ZHBhLCB1OCBzdGF0dXMpCj4+Pj4+IHsKPj4+Pj4gwqDCoMKgwqBzdHJ1Y3QgdnBf
dmRwYSAqdnBfdmRwYSA9IHZkcGFfdG9fdnAodmRwYSk7Cj4+Pj4+IMKgwqDCoMKgc3RydWN0IHZp
cnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldiA9IHZwX3ZkcGFfdG9fbWRldih2cF92ZHBhKTsK
Pj4+Pj4gLcKgwqDCoCB1OCBzID0gdnBfdmRwYV9nZXRfc3RhdHVzKHZkcGEpOwo+Pj4+Cj4+Pj4g
SXMgdGhpcyBjaGFuZ2UgcmVhbGx5IG5lZWRlZD8KPj4+Pgo+Pj4gTm8gbmVlZCB0byBnZXQgdGhl
IHN0YXR1cyBpZiB3ZSB0cnkgdG8gc2V0IHN0YXR1cyB0byAwICh0cmlnZ2VyIEJVRykuCj4+Pgo+
Pgo+PiBPa2F5LCBidXQgdGhhdCdzIHRoZSBjYXNlIHRoYXQgc2hvdWxkIG5ldmVyIGhhcHBlbiwg
c28gSU1ITyB3ZSBjYW4gCj4+IGxlYXZlIGl0IGFzIGl0IGlzLgo+Pgo+IE9LLgo+Cj4+Pj4+ICvC
oMKgwqAgdTggczsKPj4+Pj4gKwo+Pj4+PiArwqDCoMKgIC8qIFdlIHNob3VsZCBuZXZlciBiZSBz
ZXR0aW5nIHN0YXR1cyB0byAwLiAqLwo+Pj4+PiArwqDCoMKgIEJVR19PTihzdGF0dXMgPT0gMCk7
Cj4+Pj4KPj4+PiBJTUhPIHBhbmlja2luZyB0aGUga2VybmVsIHNlZW1zIGV4Y2Vzc2l2ZSBpbiB0
aGlzIGNhc2UsIHBsZWFzZSB1c2UgCj4+Pj4gV0FSTl9PTiBhbmQgbWF5YmUgcmV0dXJuIGVhcmxp
ZXIuCj4+Pj4KPj4+IFVtLi4uSSByZWZlcmVuY2VkIHRoZSB2cF9yZXNldC92cF9zZXRfc3RhdHVz
LAo+Pgo+PiBBaCBJIHNlZSwgbWF5YmUgaXQncyBhbiBvbGQgY29kZSwgYmVjYXVzZSByZWNlbnRs
eSB3ZSBhbHdheXMgdHJ5IHRvIAo+PiBhdm9pZCBCVUdfT04oKS4KPj4KPiBPSy4gVGhlIGNoZWNr
cGF0Y2gucGwgc2NyaXB0IGFsc28gdHJpZ2dlcmVkIGEgd2FyaW5nIGFib3V0IGl0Lgo+IEknbGwg
dXNlIFdBUk5fT04gaW4gbmV4dCB2ZXJzaW9uLgo+Cj4+Pgo+Pj4+Pgo+Pj4+PiArwqDCoMKgIHMg
PSB2cF92ZHBhX2dldF9zdGF0dXModmRwYSk7Cj4+Pj4+IMKgwqDCoMKgaWYgKHN0YXR1cyAmIFZJ
UlRJT19DT05GSUdfU19EUklWRVJfT0sgJiYKPj4+Pj4gwqDCoMKgwqDCoMKgwqAgIShzICYgVklS
VElPX0NPTkZJR19TX0RSSVZFUl9PSykpIHsKPj4+Pj4gwqDCoMKgwqDCoMKgwqAgdnBfdmRwYV9y
ZXF1ZXN0X2lycSh2cF92ZHBhKTsKPj4+Pj4gQEAgLTIyOSw2ICsyMzMsMTEgQEAgc3RhdGljIGlu
dCB2cF92ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAKPj4+Pj4gKnZkcGEpCj4+Pj4+IMKg
wqDCoMKgdTggcyA9IHZwX3ZkcGFfZ2V0X3N0YXR1cyh2ZHBhKTsKPj4+Pj4KPj4+Pj4gwqDCoMKg
wqB2cF9tb2Rlcm5fc2V0X3N0YXR1cyhtZGV2LCAwKTsKPj4+Pj4gK8KgwqDCoCAvKiBBZnRlciB3
cml0aW5nIDAgdG8gZGV2aWNlX3N0YXR1cywgdGhlIGRyaXZlciBNVVNUIHdhaXQgZm9yIAo+Pj4+
PiBhIHJlYWQgb2YKPj4+Pj4gK8KgwqDCoMKgICogZGV2aWNlX3N0YXR1cyB0byByZXR1cm4gMCBi
ZWZvcmUgcmVpbml0aWFsaXppbmcgdGhlIGRldmljZS4KPj4+Pj4gK8KgwqDCoMKgICovCj4+Pj4+
ICvCoMKgwqAgd2hpbGUgKHZwX21vZGVybl9nZXRfc3RhdHVzKG1kZXYpKQo+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgbXNsZWVwKDEpOwo+Pj4+Cj4+Pj4gU2hvdWxkIHdlIHNldCBhIGxpbWl0IGFmdGVy
IHdoaWNoIHdlIGdpdmUgdXA/IEEgbWFsZnVuY3Rpb25pbmcgCj4+Pj4gZGV2aWNlIGNvdWxkIGtl
ZXAgdXMgaGVyZSBmb3JldmVyLgo+Pj4+Cj4+PiBZZXMsIGJ1dCB0aGUgbWFsZnVuY3Rpb25pbmcg
ZGV2aWNlIG1heWJlIGNhbiBub3Qgd29yayBhbnltb3JlLCBob3cgCj4+PiB0byBoYW5kbGUgaXQ/
Cj4+Cj4+IE1heWJlIHdlIHNob3VsZCBzZXQgdGhlIHN0YXR1cyB0byBicm9rZW4sIGJ1dCBpbiB0
aGlzIGNhc2Ugd2UgY291bGQgCj4+IGp1c3QgcmV0dXJuIGFuIGVycm9yIGlmIHdlIGNvdWxkbid0
IHJlc2V0IGl0LCBob3cgYWJvdXQgdGhhdD8KPj4KPiBJdCBjYW4gd29yaywgYnV0IGl0IHNlZW1z
IHRvIHZpb2xhdGUgdGhlIHNwZWNpZmljYXRpb24uIE1heWJlIHdlIGNhbiAKPiBhbHNvIHdhaXQg
Zm9yIG90aGVyIGd1eXMnIHN1Z2dlc3Rpb25zIGFuZCB0aGVuIGRlY2lkZSBob3cgdG8gaGFuZGxl
IAo+IHRoZSBleGNlcHRpb24uCgoKTmVlZCBtb3JlIHRob3VnaHQgYnV0IGl0J3Mgbm90IGFuIGlz
c3VlIHRoYXQgaXMgaW50cm9kdWNlZCBpbiB0aGlzIApwYXRjaCwgd2UgY2FuIGRvIG9wdGltaXph
dGlvbiBvbiB0b3AuCgpQcm9iYWJseSBhIHdhcm5pbmcgcGx1cyBGQUlMRUQuIFRoZW4gYXQgbGVh
c3QgdGhlIGRldmljZSBjYW4gRE9TIHRoZSAKZHJpdmVyIHdoaWNoIGlzIGdvb2QgZm9yIGhhcmRl
bmluZyBhcyB3ZWxsLgoKVGhhbmtzCgoKPgo+PiBUaGFua3MsCj4+IFN0ZWZhbm8KPj4KPj4gLgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
