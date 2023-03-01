Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0CFC64EC4
	for <virtualization@archiver.kernel.org>; Wed,  1 Mar 2023 03:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C77DB81A92;
	Wed,  1 Mar 2023 03:07:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C77DB81A92
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZxbgVhau
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Edstc7_aBPW; Wed,  1 Mar 2023 03:07:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E79281A4E;
	Wed,  1 Mar 2023 03:07:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E79281A4E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05D54C0033;
	Wed,  1 Mar 2023 03:07:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78318C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 03:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5977460AD4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 03:07:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5977460AD4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZxbgVhau
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SJz2UyirlUtA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 03:07:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FE2A607DE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2FE2A607DE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 03:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677640030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+vAPtXXMjEgI8QMMfzd18RHzDoZyhEmlj8SjpkMiKQ=;
 b=ZxbgVhauPUzX/hv4y6iVTbA92FUsk2uHM7t9nJydeesdChSMz5mqj73WENoLeY4PnSUnJA
 KyFtsKUHRJr462e6m6WjDDP/7biO2igHxYY8agr9jfooY8eIHkkfljakPY9GYuNEN75TR0
 qj0jArjYkXzf14u/0HnlL8TL1avWcvo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-527-GrLkZRxMPdipCKI39XkL2w-1; Tue, 28 Feb 2023 22:07:08 -0500
X-MC-Unique: GrLkZRxMPdipCKI39XkL2w-1
Received: by mail-pf1-f197.google.com with SMTP id
 b8-20020aa78708000000b005eaa50faa35so5944710pfo.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 19:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N+vAPtXXMjEgI8QMMfzd18RHzDoZyhEmlj8SjpkMiKQ=;
 b=64jybK2gU27Yo95ELm6cD33eDW6tGBdxy8bytxTgAYzS9KRX71bUqRVcS6Ugj6mpWC
 CrN0w2iJ8Lk7r5fCmsnLpDGP74powgsSFmKJ2KhtfIWaU0nMkxuzCdqYTsPKfMa0G3z4
 ULhC/XENFBgtnFRHvHGUDBUMHep3f8nUExs05WOWkJnT5tMUdJhyKFuv2YG+Maky/BWc
 XDScJMEIDqsIUWFUcY2cEeb4uDr7aL8IUcjt0D6PTt2bscoE6izKdeJ3qE4/wMaZJq4S
 tQo8H0o6stMDv9D2yxu4keTszVhcp09OGCMHR5/P+Ul4gHcYcPH0gwt1vnpPjWeB3Us7
 h5YQ==
X-Gm-Message-State: AO0yUKWIzhVOA447P7orIgzNpO82s+9q6qNZFS4nNop/qibe7f13dIgI
 bD0Tk4jVSaE3Vh35tXQIAZExgV81xc4q1V/8T8eDgLp4ylmburXCMD0jm4bXImMoT0TsAwQMQ1w
 NLry+Y/NLh5jH+CG7Adr9d26qssvQRGl3hEz801lgxA==
X-Received: by 2002:a62:30c1:0:b0:5e5:e066:2304 with SMTP id
 w184-20020a6230c1000000b005e5e0662304mr3909223pfw.31.1677640027420; 
 Tue, 28 Feb 2023 19:07:07 -0800 (PST)
X-Google-Smtp-Source: AK7set/6cwgsr0hpoW1bLHJ5QpvR2yfmgT61MQvq6b3YIvuRMo2Nt47kFh6KZMpcwXFqW6bZG3iQaA==
X-Received: by 2002:a62:30c1:0:b0:5e5:e066:2304 with SMTP id
 w184-20020a6230c1000000b005e5e0662304mr3909206pfw.31.1677640027056; 
 Tue, 28 Feb 2023 19:07:07 -0800 (PST)
Received: from [10.72.13.209] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a62ae17000000b0059416691b64sm6917990pff.19.2023.02.28.19.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Feb 2023 19:07:06 -0800 (PST)
Message-ID: <f69f7614-5450-bcce-83c7-c5ec5d3a6149@redhat.com>
Date: Wed, 1 Mar 2023 11:06:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/2] vdpasim: support doorbell mapping
To: "Longpeng(Mike)" <longpeng2@huawei.com>, mst@redhat.com
References: <20230227091857.2406-1-longpeng2@huawei.com>
 <20230227091857.2406-3-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230227091857.2406-3-longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, yechuan@huawei.com, eperezma@redhat.com,
 huangzhichao@huawei.com, stefanha@redhat.com,
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

CuWcqCAyMDIzLzIvMjcgMTc6MTgsIExvbmdwZW5nKE1pa2UpIOWGmemBkzoKPiBGcm9tOiBMb25n
cGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4KPiBTdXBwb3J0IGRvb3JiZWxsIG1hcHBpbmcg
Zm9yIHZkcGFzaW0gZGV2aWNlcywgdGhlbiB3ZSBjYW4gdGVzdCB0aGUgbm90aWZ5Cj4gcGFzc3Ro
cm91Z2ggZmVhdHVyZSBldmVuIGlmIHRoZXJlJ3Mgbm8gcmVhbCBoYXJkd2FyZSBvbiBoYW5kLgo+
Cj4gQWxsb2NhdGVzIGEgZHVtbXkgcGFnZSB3aGljaCBpcyB1c2VkIHRvIGVtdWxhdGUgdGhlIG5v
dGlmeSBwYWdlIG9mIHRoZSBkZXZpY2UsCj4gYWxsIFZRcyBzaGFyZSB0aGUgc2FtZSBub3RpZnkg
cmVnaXN0ZXIgIHRoYXQgaW5pdGlhdGVkIHRvIDB4ZmZmZi4gQSAgcGVyaW9kaWMKPiB3b3JrIHdp
bGwgY2hlY2sgd2hldGhlciB0aGVyZSdyZSByZXF1ZXN0cyBuZWVkIHRvIHByb2Nlc3MgKCB0aGUg
dmFsdWUgb2YgdGhlCj4gbm90aWZ5IHJlZ2lzdGVyIGlzIDB4ZmZmZiBvciBub3QgKS4KPgo+IFdl
IGNhbiB0ZXN0IG9uIFFFTVUgd2l0aDoKPiAgIC1kZXZpY2Ugdmhvc3QtdmRwYS1kZXZpY2UtcGNp
LHZob3N0ZGV2PS9kZXYvdmhvc3QtdmRwYS0wLHBhZ2UtcGVyLXZxPW9uCj4KPiBTaWduZWQtb2Zm
LWJ5OiBMb25ncGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltLmMgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kwo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmggfCAgMyArKwo+ICAgMiBmaWxl
cyBjaGFuZ2VkLCA3MCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+
IGluZGV4IGNiODg4OTFiNDRhOC4uNWE4YzgyMGIxNzlmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltLmMKPiBAQCAtMzksNiArMzksOCBAQCBNT0RVTEVfUEFSTV9ERVNDKG1heF9pb3RsYl9l
bnRyaWVzLAo+ICAgI2RlZmluZSBWRFBBU0lNX1FVRVVFX0FMSUdOIFBBR0VfU0laRQo+ICAgI2Rl
ZmluZSBWRFBBU0lNX1FVRVVFX01BWCAyNTYKPiAgICNkZWZpbmUgVkRQQVNJTV9WRU5ET1JfSUQg
MAo+ICsjZGVmaW5lIFZEUEFTSU1fVlJJTkdfUE9MTF9QRVJJT0QgMTAwIC8qIG1zICovCj4gKyNk
ZWZpbmUgVkRQQVNJTV9OT1RJRllfREVGVkFMIDB4ZmZmZgo+ICAgCj4gICBzdGF0aWMgc3RydWN0
IHZkcGFzaW0gKnZkcGFfdG9fc2ltKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiAgIHsKPiBA
QCAtMjQ1LDYgKzI0NywyOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzIHZkcGFz
aW1fZG1hX29wcyA9IHsKPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHZk
cGFzaW1fY29uZmlnX29wczsKPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3Bz
IHZkcGFzaW1fYmF0Y2hfY29uZmlnX29wczsKPiAgIAo+ICtzdGF0aWMgdm9pZCB2ZHBhc2ltX25v
dGlmeV93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiArewo+ICsJc3RydWN0IHZkcGFz
aW0gKnZkcGFzaW07Cj4gKwl1MTYgKnZhbDsKPiArCj4gKwl2ZHBhc2ltID0gY29udGFpbmVyX29m
KHdvcmssIHN0cnVjdCB2ZHBhc2ltLCBub3RpZnlfd29yay53b3JrKTsKPiArCj4gKwlpZiAoISh2
ZHBhc2ltLT5zdGF0dXMgJiBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSkKPiArCQlnb3RvIG91
dDsKPiArCj4gKwlpZiAoIXZkcGFzaW0tPnJ1bm5pbmcpCj4gKwkJZ290byBvdXQ7Cj4gKwo+ICsJ
dmFsID0gKHUxNiAqKXZkcGFzaW0tPm5vdGlmeTsKPiArCWlmICh4Y2hnKHZhbCwgVkRQQVNJTV9O
T1RJRllfREVGVkFMKSAhPSBWRFBBU0lNX05PVElGWV9ERUZWQUwpCj4gKwkJc2NoZWR1bGVfd29y
aygmdmRwYXNpbS0+d29yayk7Cj4gKwo+ICtvdXQ6Cj4gKwlzY2hlZHVsZV9kZWxheWVkX3dvcmso
JnZkcGFzaW0tPm5vdGlmeV93b3JrLAo+ICsJCQkgICAgICBtc2Vjc190b19qaWZmaWVzKFZEUEFT
SU1fVlJJTkdfUE9MTF9QRVJJT0QpKTsKPiArfQo+ICsKPiAgIHN0cnVjdCB2ZHBhc2ltICp2ZHBh
c2ltX2NyZWF0ZShzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciAqZGV2X2F0dHIsCj4gICAJCQkgICAg
ICAgY29uc3Qgc3RydWN0IHZkcGFfZGV2X3NldF9jb25maWcgKmNvbmZpZykKPiAgIHsKPiBAQCAt
Mjg2LDYgKzMxMCwxMyBAQCBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbV9jcmVhdGUoc3RydWN0IHZk
cGFzaW1fZGV2X2F0dHIgKmRldl9hdHRyLAo+ICAgCXNldF9kbWFfb3BzKGRldiwgJnZkcGFzaW1f
ZG1hX29wcyk7Cj4gICAJdmRwYXNpbS0+dmRwYS5tZGV2ID0gZGV2X2F0dHItPm1nbXRfZGV2Owo+
ICAgCj4gKwlJTklUX0RFTEFZRURfV09SSygmdmRwYXNpbS0+bm90aWZ5X3dvcmssIHZkcGFzaW1f
bm90aWZ5X3dvcmspOwo+ICsKPiArCXZkcGFzaW0tPm5vdGlmeSA9ICh1MTYgKilfX2dldF9mcmVl
X3BhZ2UoR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8pOwo+ICsJaWYgKCF2ZHBhc2ltLT5ub3RpZnkp
Cj4gKwkJZ290byBlcnJfaW9tbXU7Cj4gKwlXUklURV9PTkNFKCp2ZHBhc2ltLT5ub3RpZnksIFZE
UEFTSU1fTk9USUZZX0RFRlZBTCk7Cj4gKwo+ICAgCXZkcGFzaW0tPmNvbmZpZyA9IGt6YWxsb2Mo
ZGV2X2F0dHItPmNvbmZpZ19zaXplLCBHRlBfS0VSTkVMKTsKPiAgIAlpZiAoIXZkcGFzaW0tPmNv
bmZpZykKPiAgIAkJZ290byBlcnJfaW9tbXU7Cj4gQEAgLTMyMCw2ICszNTEsMTMgQEAgc3RydWN0
IHZkcGFzaW0gKnZkcGFzaW1fY3JlYXRlKHN0cnVjdCB2ZHBhc2ltX2Rldl9hdHRyICpkZXZfYXR0
ciwKPiAgIAo+ICAgCXZkcGFzaW0tPnZkcGEuZG1hX2RldiA9IGRldjsKPiAgIAo+ICsJLyoKPiAr
IAkgKiBTdGFydCBwZXJpb2RpYyAoZXZlcnkgMTAwbXMpIG5vdGlmeSB3b3JrLCBpdCB3b24ndCBp
bnRyb2R1Y2UKPiArIAkgKiBhbnkgb3ZlcmhlYWQgaWYgdGhlIGRldmljZSBpcyBub3Qgc3RhcnRl
ZC4KPiArCSAqLwo+ICsJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2ZHBhc2ltLT5ub3RpZnlfd29y
aywKPiArCQkJICAgICAgbXNlY3NfdG9famlmZmllcyhWRFBBU0lNX1ZSSU5HX1BPTExfUEVSSU9E
KSk7Cj4gKwo+ICAgCXJldHVybiB2ZHBhc2ltOwo+ICAgCj4gICBlcnJfaW9tbXU6Cj4gQEAgLTY3
MSwxMSArNzA5LDM0IEBAIHN0YXRpYyBpbnQgdmRwYXNpbV9kbWFfdW5tYXAoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZHBhLCB1bnNpZ25lZCBpbnQgYXNpZCwKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAg
IAo+ICtzdGF0aWMgcGdwcm90X3QgdmRwYXNpbV9nZXRfdnFfbm90aWZpY2F0aW9uX3BncHJvdChz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsCj4gKwkJCQkJCSAgIHUxNiBxaWQsIHBncHJvdF90IHBy
b3QpCj4gK3sKPiArCS8qCj4gKwkgKiBXZSB1c2Ugbm9ybWFsIFJBTSBwYWdlcyB0byBlbXVsYXRl
IHRoZSB2cSBub3RpZmljYXRpb24gYXJlYSwgc28KPiArCSAqIGp1c3Qga2VlcCB0aGUgcGdwcm90
IGFzIGl0IG1tYXBlZC4KPiArCSAqLwo+ICsJcmV0dXJuIHByb3Q7Cj4gK30KPiArCj4gK3N0YXRp
YyBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYQo+ICt2ZHBhc2ltX2dldF92cV9ub3RpZmlj
YXRpb24oc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1MTYgcWlkKQo+ICt7Cj4gKwlzdHJ1Y3Qg
dmRwYXNpbSAqdmRwYXNpbSA9IHZkcGFfdG9fc2ltKHZkcGEpOwo+ICsJc3RydWN0IHZkcGFfbm90
aWZpY2F0aW9uX2FyZWEgbm90aWZ5Owo+ICsKPiArCW5vdGlmeS5hZGRyID0gdmlydF90b19waHlz
KCh2b2lkICopdmRwYXNpbS0+bm90aWZ5KTsKPiArCW5vdGlmeS5zaXplID0gUEFHRV9TSVpFOwo+
ICsKPiArCXJldHVybiBub3RpZnk7Cj4gK30KPiArCj4gICBzdGF0aWMgdm9pZCB2ZHBhc2ltX2Zy
ZWUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICAgewo+ICAgCXN0cnVjdCB2ZHBhc2ltICp2
ZHBhc2ltID0gdmRwYV90b19zaW0odmRwYSk7Cj4gICAJaW50IGk7Cj4gICAKPiArCWNhbmNlbF9k
ZWxheWVkX3dvcmtfc3luYygmdmRwYXNpbS0+bm90aWZ5X3dvcmspOwo+ICAgCWNhbmNlbF93b3Jr
X3N5bmMoJnZkcGFzaW0tPndvcmspOwo+ICAgCj4gICAJZm9yIChpID0gMDsgaSA8IHZkcGFzaW0t
PmRldl9hdHRyLm52cXM7IGkrKykgewo+IEBAIC02OTQsNiArNzU1LDggQEAgc3RhdGljIHZvaWQg
dmRwYXNpbV9mcmVlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiAgIAlrZnJlZSh2ZHBhc2lt
LT5pb21tdSk7Cj4gICAJa2ZyZWUodmRwYXNpbS0+dnFzKTsKPiAgIAlrZnJlZSh2ZHBhc2ltLT5j
b25maWcpOwo+ICsJaWYgKHZkcGFzaW0tPm5vdGlmeSkKPiArCQlmcmVlX3BhZ2UoKHVuc2lnbmVk
IGxvbmcpdmRwYXNpbS0+bm90aWZ5KTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGNvbnN0IHN0cnVj
dCB2ZHBhX2NvbmZpZ19vcHMgdmRwYXNpbV9jb25maWdfb3BzID0gewo+IEBAIC03MDUsNiArNzY4
LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgdmRwYXNpbV9jb25maWdf
b3BzID0gewo+ICAgCS5nZXRfdnFfcmVhZHkgICAgICAgICAgID0gdmRwYXNpbV9nZXRfdnFfcmVh
ZHksCj4gICAJLnNldF92cV9zdGF0ZSAgICAgICAgICAgPSB2ZHBhc2ltX3NldF92cV9zdGF0ZSwK
PiAgIAkuZ2V0X3ZxX3N0YXRlICAgICAgICAgICA9IHZkcGFzaW1fZ2V0X3ZxX3N0YXRlLAo+ICsJ
LmdldF92cV9ub3RpZmljYXRpb24gICAgPSB2ZHBhc2ltX2dldF92cV9ub3RpZmljYXRpb24sCj4g
KwkuZ2V0X3ZxX25vdGlmaWNhdGlvbl9wZ3Byb3QgPSB2ZHBhc2ltX2dldF92cV9ub3RpZmljYXRp
b25fcGdwcm90LAo+ICAgCS5nZXRfdnFfYWxpZ24gICAgICAgICAgID0gdmRwYXNpbV9nZXRfdnFf
YWxpZ24sCj4gICAJLmdldF92cV9ncm91cCAgICAgICAgICAgPSB2ZHBhc2ltX2dldF92cV9ncm91
cCwKPiAgIAkuZ2V0X2RldmljZV9mZWF0dXJlcyAgICA9IHZkcGFzaW1fZ2V0X2RldmljZV9mZWF0
dXJlcywKPiBAQCAtNzM4LDYgKzgwMyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25m
aWdfb3BzIHZkcGFzaW1fYmF0Y2hfY29uZmlnX29wcyA9IHsKPiAgIAkuZ2V0X3ZxX3JlYWR5ICAg
ICAgICAgICA9IHZkcGFzaW1fZ2V0X3ZxX3JlYWR5LAo+ICAgCS5zZXRfdnFfc3RhdGUgICAgICAg
ICAgID0gdmRwYXNpbV9zZXRfdnFfc3RhdGUsCj4gICAJLmdldF92cV9zdGF0ZSAgICAgICAgICAg
PSB2ZHBhc2ltX2dldF92cV9zdGF0ZSwKPiArCS5nZXRfdnFfbm90aWZpY2F0aW9uICAgID0gdmRw
YXNpbV9nZXRfdnFfbm90aWZpY2F0aW9uLAo+ICsJLmdldF92cV9ub3RpZmljYXRpb25fcGdwcm90
ID0gdmRwYXNpbV9nZXRfdnFfbm90aWZpY2F0aW9uX3BncHJvdCwKPiAgIAkuZ2V0X3ZxX2FsaWdu
ICAgICAgICAgICA9IHZkcGFzaW1fZ2V0X3ZxX2FsaWduLAo+ICAgCS5nZXRfdnFfZ3JvdXAgICAg
ICAgICAgID0gdmRwYXNpbV9nZXRfdnFfZ3JvdXAsCj4gICAJLmdldF9kZXZpY2VfZmVhdHVyZXMg
ICAgPSB2ZHBhc2ltX2dldF9kZXZpY2VfZmVhdHVyZXMsCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
LmgKPiBpbmRleCAwZTc4NzM3ZGNjMTYuLjc4NmU5MDJkZTBiMiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbS5oCj4gQEAgLTY5LDYgKzY5LDkgQEAgc3RydWN0IHZkcGFzaW0gewo+ICAgCWJv
b2wgcnVubmluZzsKPiAgIAkvKiBzcGlubG9jayB0byBzeW5jaHJvbml6ZSBpb21tdSB0YWJsZSAq
Lwo+ICAgCXNwaW5sb2NrX3QgaW9tbXVfbG9jazsKPiArCS8qIGR1bW15IG5vdGlmeSBwYWdlICov
Cj4gKwl1MTYgKm5vdGlmeTsKPiArCXN0cnVjdCBkZWxheWVkX3dvcmsgbm90aWZ5X3dvcms7Cj4g
ICB9Owo+ICAgCj4gICBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbV9jcmVhdGUoc3RydWN0IHZkcGFz
aW1fZGV2X2F0dHIgKmF0dHIsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
