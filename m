Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8003C4707F
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 01:14:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A58361423
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 01:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A58361423
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB3C860BD9;
	Wed, 26 May 2021 01:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ma4kRNK9n7n7; Wed, 26 May 2021 01:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8868F6060B;
	Wed, 26 May 2021 01:14:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 615B8C000E;
	Wed, 26 May 2021 01:14:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08AEBC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E410A401DF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M-PBzeSsxUgA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:14:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B0604000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621991659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zc/pzU0LDlXuq/PIlZ7jK1sYLaLur/xPSpS8UXayb8A=;
 b=farizbO/CbiFfxS7qcLfCkNB+fpXUfOtEUbJpg2aOffspbEx8xTft32DI1WHXnu2yO3ilR
 //C373ZQallnun9hGfjC66TyJOGonNoqS7ehoqZcNQEyx+vOccRAd5xxo+2E6O55LwgdwK
 e/WrbKwo3AIH6IpeM1ySB/8eX3KJONc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-UIW8fQFwOail6HHcR-6AZQ-1; Tue, 25 May 2021 21:14:17 -0400
X-MC-Unique: UIW8fQFwOail6HHcR-6AZQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 m7-20020a6545c70000b029020f6af21c77so22264761pgr.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 18:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Zc/pzU0LDlXuq/PIlZ7jK1sYLaLur/xPSpS8UXayb8A=;
 b=LgTQV51HiPVJwYotqOTp9mWXnqEN9OxgXl9pPM46CiT2ovth5gOBtiSecnBMhWxV42
 gX6T0GzS43UeKeTIyU/8PnShGqCFSCgAlSleU27OCfqlEonYr10XRQ82R2euixEIq2Mt
 LC6xILZaXX6a4jI+V3l15MQQBHU8ppMjq6JWNafQFUrD22B+BvqUPEvmyrf6hjW1J2Ig
 Fla9gsuWWEzFt/j5P6mCqvV5ylMkaHseW0AyEYf5vWNirEICGwOtGAOHMwwqfyXAhkgc
 /VI44vCTPJ3GKv9ZJNEhiK4MXNnO39E1cQUxLnKiq7ZNIpuaSjF0SlPgtj9S0p50lJV/
 YWAA==
X-Gm-Message-State: AOAM532l+eqyDRFGbjBfRhyog/Xuvqy+vYTN7nKBSIPhP5Hdj0tWdFQg
 FrS6sUPtlb6h+GQNPQFfB+iwWMQrJjetGJ7hOLPQ+PFbvoSr3MvQIHx2FrAPdaGaKyQo4k7ljFw
 RyJQoQXtUdonpZEbP/60V885stuF/r70t4IjSqB9KZaAUKKde0YgYlcArU/qOYQrdRZVX+AjAsf
 M56EQyBqxPxz1F0+F18A==
X-Received: by 2002:a62:a517:0:b029:2dc:9daf:5e91 with SMTP id
 v23-20020a62a5170000b02902dc9daf5e91mr32828793pfm.39.1621991656021; 
 Tue, 25 May 2021 18:14:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOD/3JYTfEoVMD++1TY4++AgHy4qjn0MHC2pyUmBme10b4t14OHRl0TmQrSIAakxht72bzGQ==
X-Received: by 2002:a62:a517:0:b029:2dc:9daf:5e91 with SMTP id
 v23-20020a62a5170000b02902dc9daf5e91mr32828755pfm.39.1621991655615; 
 Tue, 25 May 2021 18:14:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c20sm2141408pjr.35.2021.05.25.18.14.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 May 2021 18:14:15 -0700 (PDT)
Subject: Re: [RFC v3 13/29] vhost: Add vhost_get_iova_range operation
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210519162903.1172366-1-eperezma@redhat.com>
 <20210519162903.1172366-14-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e0114c64-2620-7a72-6445-3035ceb748ac@redhat.com>
Date: Wed, 26 May 2021 09:14:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210519162903.1172366-14-eperezma@redhat.com>
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

CuWcqCAyMDIxLzUvMjAg5LiK5Y2IMTI6MjgsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBGb3Ig
c2ltcGxpY2l0eSwgSWYgYSBkZXZpY2UgZG9lcyBub3Qgc3VwcG9ydCB0aGlzIG9wZXJhdGlvbiBp
dCBtZWFucwo+IHRoYXQgaXQgY2FuIGhhbmRsZSBmdWxsICh1aW50NjRfdCktMSBpb3ZhIGFkZHJl
c3MuCgoKTm90ZSB0aGF0LCB3ZSBwcm9iYWJseSBuZWVkIGEgc2VwYXJhdGVkIHBhdGNoIGZvciB0
aGlzLgoKQW5kIHdlIG5lZWQgdG8gdGhpcyBkdXJpbmcgdmhvc3QtdmRwYSBpbml0aWFsaXphdGlv
bi4gSWYgR1BBIGlzIG91dCBvZiAKdGhlIHJhbmdlLCB3ZSBuZWVkIHRvIGZhaWwgdGhlIHN0YXJ0
IG9mIHZob3N0LXZkcGEuCgpUSGFua3MKCgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6ly
ZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBpbmNsdWRlL2h3L3ZpcnRpby92aG9z
dC1iYWNrZW5kLmggfCAgNSArKysrKwo+ICAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyAgICAgICAg
ICAgIHwgMTggKysrKysrKysrKysrKysrKysrCj4gICBody92aXJ0aW8vdHJhY2UtZXZlbnRzICAg
ICAgICAgICAgfCAgMSArCj4gICAzIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC1iYWNrZW5kLmggYi9pbmNsdWRl
L2h3L3ZpcnRpby92aG9zdC1iYWNrZW5kLmgKPiBpbmRleCA5NGQzMzIzOTA1Li5iY2IxMTJjMTY2
IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuaAo+ICsrKyBi
L2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuaAo+IEBAIC0zNiw2ICszNiw3IEBAIHN0
cnVjdCB2aG9zdF92cmluZ19hZGRyOwo+ICAgc3RydWN0IHZob3N0X3Njc2lfdGFyZ2V0Owo+ICAg
c3RydWN0IHZob3N0X2lvdGxiX21zZzsKPiAgIHN0cnVjdCB2aG9zdF92aXJ0cXVldWU7Cj4gK3N0
cnVjdCB2aG9zdF92ZHBhX2lvdmFfcmFuZ2U7Cj4gICAKPiAgIHR5cGVkZWYgaW50ICgqdmhvc3Rf
YmFja2VuZF9pbml0KShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHZvaWQgKm9wYXF1ZSk7Cj4gICB0
eXBlZGVmIGludCAoKnZob3N0X2JhY2tlbmRfY2xlYW51cCkoc3RydWN0IHZob3N0X2RldiAqZGV2
KTsKPiBAQCAtMTI3LDYgKzEyOCw5IEBAIHR5cGVkZWYgYm9vbCAoKnZob3N0X2ZvcmNlX2lvbW11
X29wKShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpOwo+ICAgCj4gICB0eXBlZGVmIGludCAoKnZob3N0
X3ZyaW5nX3BhdXNlX29wKShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpOwo+ICAgCj4gK3R5cGVkZWYg
aW50ICgqdmhvc3RfZ2V0X2lvdmFfcmFuZ2UpKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyICpmaXJzdCwgaHdhZGRyICps
YXN0KTsKPiArCj4gICB0eXBlZGVmIHN0cnVjdCBWaG9zdE9wcyB7Cj4gICAgICAgVmhvc3RCYWNr
ZW5kVHlwZSBiYWNrZW5kX3R5cGU7Cj4gICAgICAgdmhvc3RfYmFja2VuZF9pbml0IHZob3N0X2Jh
Y2tlbmRfaW5pdDsKPiBAQCAtMTczLDYgKzE3Nyw3IEBAIHR5cGVkZWYgc3RydWN0IFZob3N0T3Bz
IHsKPiAgICAgICB2aG9zdF9nZXRfZGV2aWNlX2lkX29wIHZob3N0X2dldF9kZXZpY2VfaWQ7Cj4g
ICAgICAgdmhvc3RfdnJpbmdfcGF1c2Vfb3Agdmhvc3RfdnJpbmdfcGF1c2U7Cj4gICAgICAgdmhv
c3RfZm9yY2VfaW9tbXVfb3Agdmhvc3RfZm9yY2VfaW9tbXU7Cj4gKyAgICB2aG9zdF9nZXRfaW92
YV9yYW5nZSB2aG9zdF9nZXRfaW92YV9yYW5nZTsKPiAgIH0gVmhvc3RPcHM7Cj4gICAKPiAgIGV4
dGVybiBjb25zdCBWaG9zdE9wcyB1c2VyX29wczsKPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zo
b3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBpbmRleCAwMWQyMTAxZDA5Li43
NGZlOTI5MzVlIDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiArKysgYi9o
dy92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gQEAgLTU3OSw2ICs1NzksMjMgQEAgc3RhdGljIGJvb2wg
IHZob3N0X3ZkcGFfZm9yY2VfaW9tbXUoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICAgICAgIHJl
dHVybiB0cnVlOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9nZXRfaW92YV9y
YW5nZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBod2FkZHIgKmZpcnN0LCBod2FkZHIgKmxhc3QpCj4gK3sKPiArICAgIGludCBy
ZXQ7Cj4gKyAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9pb3ZhX3JhbmdlIHJhbmdlOwo+ICsKPiArICAg
IHJldCA9IHZob3N0X3ZkcGFfY2FsbChkZXYsIFZIT1NUX1ZEUEFfR0VUX0lPVkFfUkFOR0UsICZy
YW5nZSk7Cj4gKyAgICBpZiAocmV0ICE9IDApIHsKPiArICAgICAgICByZXR1cm4gcmV0Owo+ICsg
ICAgfQo+ICsKPiArICAgICpmaXJzdCA9IHJhbmdlLmZpcnN0Owo+ICsgICAgKmxhc3QgPSByYW5n
ZS5sYXN0Owo+ICsgICAgdHJhY2Vfdmhvc3RfdmRwYV9nZXRfaW92YV9yYW5nZShkZXYsICpmaXJz
dCwgKmxhc3QpOwo+ICsgICAgcmV0dXJuIHJldDsKPiArfQo+ICsKPiAgIGNvbnN0IFZob3N0T3Bz
IHZkcGFfb3BzID0gewo+ICAgICAgICAgICAuYmFja2VuZF90eXBlID0gVkhPU1RfQkFDS0VORF9U
WVBFX1ZEUEEsCj4gICAgICAgICAgIC52aG9zdF9iYWNrZW5kX2luaXQgPSB2aG9zdF92ZHBhX2lu
aXQsCj4gQEAgLTYxMSw0ICs2MjgsNSBAQCBjb25zdCBWaG9zdE9wcyB2ZHBhX29wcyA9IHsKPiAg
ICAgICAgICAgLnZob3N0X2dldF9kZXZpY2VfaWQgPSB2aG9zdF92ZHBhX2dldF9kZXZpY2VfaWQs
Cj4gICAgICAgICAgIC52aG9zdF92cV9nZXRfYWRkciA9IHZob3N0X3ZkcGFfdnFfZ2V0X2FkZHIs
Cj4gICAgICAgICAgIC52aG9zdF9mb3JjZV9pb21tdSA9IHZob3N0X3ZkcGFfZm9yY2VfaW9tbXUs
Cj4gKyAgICAgICAgLnZob3N0X2dldF9pb3ZhX3JhbmdlID0gdmhvc3RfdmRwYV9nZXRfaW92YV9y
YW5nZSwKPiAgIH07Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby90cmFjZS1ldmVudHMgYi9ody92
aXJ0aW8vdHJhY2UtZXZlbnRzCj4gaW5kZXggYzYyNzI3Zjg3OS4uNWRlYmUzYTY4MSAxMDA2NDQK
PiAtLS0gYS9ody92aXJ0aW8vdHJhY2UtZXZlbnRzCj4gKysrIGIvaHcvdmlydGlvL3RyYWNlLWV2
ZW50cwo+IEBAIC01Miw2ICs1Miw3IEBAIHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2NhbGwodm9pZCAq
ZGV2LCB1bnNpZ25lZCBpbnQgaW5kZXgsIGludCBmZCkgImRldjogJXAgaW5kZXg6Cj4gICB2aG9z
dF92ZHBhX2dldF9mZWF0dXJlcyh2b2lkICpkZXYsIHVpbnQ2NF90IGZlYXR1cmVzKSAiZGV2OiAl
cCBmZWF0dXJlczogMHglIlBSSXg2NAo+ICAgdmhvc3RfdmRwYV9zZXRfb3duZXIodm9pZCAqZGV2
KSAiZGV2OiAlcCIKPiAgIHZob3N0X3ZkcGFfdnFfZ2V0X2FkZHIodm9pZCAqZGV2LCB2b2lkICp2
cSwgdWludDY0X3QgZGVzY191c2VyX2FkZHIsIHVpbnQ2NF90IGF2YWlsX3VzZXJfYWRkciwgdWlu
dDY0X3QgdXNlZF91c2VyX2FkZHIpICJkZXY6ICVwIHZxOiAlcCBkZXNjX3VzZXJfYWRkcjogMHgl
IlBSSXg2NCIgYXZhaWxfdXNlcl9hZGRyOiAweCUiUFJJeDY0IiB1c2VkX3VzZXJfYWRkcjogMHgl
IlBSSXg2NAo+ICt2aG9zdF92ZHBhX2dldF9pb3ZhX3JhbmdlKHZvaWQgKmRldiwgdWludDY0X3Qg
Zmlyc3QsIHVpbnQ2NF90IGxhc3QpICJkZXY6ICVwIGZpcnN0OiAweCUiUFJJeDY0IiBsYXN0OiAw
eCUiUFJJeDY0Cj4gICAKPiAgICMgdmlydGlvLmMKPiAgIHZpcnRxdWV1ZV9hbGxvY19lbGVtZW50
KHZvaWQgKmVsZW0sIHNpemVfdCBzeiwgdW5zaWduZWQgaW5fbnVtLCB1bnNpZ25lZCBvdXRfbnVt
KSAiZWxlbSAlcCBzaXplICV6ZCBpbl9udW0gJXUgb3V0X251bSAldSIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
