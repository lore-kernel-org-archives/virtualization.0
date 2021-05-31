Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A782C47082
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:49:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B28061355
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B28061355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFC6C60A3D;
	Mon, 31 May 2021 06:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5pVVaw0JbF51; Mon, 31 May 2021 06:49:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75776608A4;
	Mon, 31 May 2021 06:49:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47AE8C000E;
	Mon, 31 May 2021 06:49:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53F83C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4200440289
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:49:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lqGoRN5RM840
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:49:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 527384026B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622443758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Yc0uSlr7grz8BAG5Bx+sZyGCLVXp2CTrZfFPky/9/w=;
 b=gZVFTso8CQ2qC9cp2DRumIL1/lDDCAD/G+S+iDvtWR5G1En6mx/UoSEhO3a0IhK8bX5xS6
 xLqV8Pv3rWdpPYHk1iBILTEu4XimGqlDbuoQUf9EZBap93OJmycxWkgWstnKTarzGvOkqz
 KzGnaq0iTEj1oiyvIh7399ScoIymVOo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-MuBJWCzENKKHQFnZe3GApg-1; Mon, 31 May 2021 02:49:16 -0400
X-MC-Unique: MuBJWCzENKKHQFnZe3GApg-1
Received: by mail-pl1-f200.google.com with SMTP id
 j5-20020a170902da85b029010566fc8ed3so526221plx.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 23:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6Yc0uSlr7grz8BAG5Bx+sZyGCLVXp2CTrZfFPky/9/w=;
 b=L6/58phU8csjIgM6qBJHrOSw7XQhW4hIqHZ1uM6xMWnn+bjHrnwZ5abSqs6juWgu0C
 +3SKh0Bj44h3tew3iF2fe+QxECrWvm6WLxoenrjeNE3qWnDCGFIAwIi/T0swJhXzsJa9
 uR97nuCSOR3Jw/lgDgWn8oXf3cglwcsNnvf3xt8y4oroEpN9cNwaa7IRUBsO85ezIoBd
 D+UfI0pUzDs/r2MBslFcSRyFw2lcKXeTNuu+41sHA9NLdtCsXcNFV1/6izeRK2P2U0ai
 TwXEXtDE9p73FZooAoZnexvK/SY/5kF2z3Wq3yfI80v3oEhXepUHIdLZJNkH1vMYTK9v
 up7Q==
X-Gm-Message-State: AOAM5300WOD3uO0gZKpRWLOXHe4ilPMte9FGFBLHgkbNxmY0asJ3hCkA
 83F3UdEqiZ4SMn7QBTTaTBalgAcT0enfo6ZBzwCCy+rH3PW7fvCQIC8KDoJounIKMOf3pyvMwzy
 sfCxxIo8FtduyjarxI/W+EaJEZLGh8H6fKyscaTc52A==
X-Received: by 2002:a17:90b:3796:: with SMTP id
 mz22mr1584921pjb.177.1622443755366; 
 Sun, 30 May 2021 23:49:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9RAl2ySCS8IqAypdqHE7XJCr0ttp2qTK+ufr0FDlpClMk1kWxyYqhd7HsscFqocSEmZPnrg==
X-Received: by 2002:a17:90b:3796:: with SMTP id
 mz22mr1584900pjb.177.1622443755124; 
 Sun, 30 May 2021 23:49:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o139sm2519738pfd.96.2021.05.30.23.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 23:49:14 -0700 (PDT)
Subject: Re: [PATCH v3] virtio-net: Add validation for used length
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, kuba@kernel.org
References: <20210528121157.105-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <49ab3d41-c5d8-a49d-3ff4-28ebfdba0181@redhat.com>
Date: Mon, 31 May 2021 14:49:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528121157.105-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNS8yOCDPws7nODoxMSwgWGllIFlvbmdqaSDQtLXAOgo+IFRoaXMgYWRkcyB2YWxp
ZGF0aW9uIGZvciB1c2VkIGxlbmd0aCAobWlnaHQgY29tZQo+IGZyb20gYW4gdW50cnVzdGVkIGRl
dmljZSkgdG8gYXZvaWQgZGF0YSBjb3JydXB0aW9uCj4gb3IgbG9zcy4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+IC0tLQo+ICAgZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gaW5kZXggMDczZmVjNGMwZGYxLi4wMWYxNWI2NTgyNGMgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4g
QEAgLTczMiw2ICs3MzIsMTcgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX3NtYWxs
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAKPiAgIAlyY3VfcmVhZF9sb2NrKCk7Cj4gICAJ
eGRwX3Byb2cgPSByY3VfZGVyZWZlcmVuY2UocnEtPnhkcF9wcm9nKTsKPiArCWlmICh1bmxpa2Vs
eShsZW4gPiBHT09EX1BBQ0tFVF9MRU4pKSB7Cj4gKwkJcHJfZGVidWcoIiVzOiByeCBlcnJvcjog
bGVuICV1IGV4Y2VlZHMgbWF4IHNpemUgJWRcbiIsCj4gKwkJCSBkZXYtPm5hbWUsIGxlbiwgR09P
RF9QQUNLRVRfTEVOKTsKPiArCQlkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMrKzsKPiArCQlp
ZiAoeGRwX3Byb2cpCj4gKwkJCWdvdG8gZXJyX3hkcDsKPiArCj4gKwkJcmN1X3JlYWRfdW5sb2Nr
KCk7Cj4gKwkJcHV0X3BhZ2UocGFnZSk7Cj4gKwkJcmV0dXJuIE5VTEw7Cj4gKwl9Cj4gICAJaWYg
KHhkcF9wcm9nKSB7Cj4gICAJCXN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYgKmhkciA9
IGJ1ZiArIGhlYWRlcl9vZmZzZXQ7Cj4gICAJCXN0cnVjdCB4ZHBfZnJhbWUgKnhkcGY7Cj4gQEAg
LTg4OCw2ICs4OTksMTYgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJs
ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgCj4gICAJcmN1X3JlYWRfbG9jaygpOwo+ICAg
CXhkcF9wcm9nID0gcmN1X2RlcmVmZXJlbmNlKHJxLT54ZHBfcHJvZyk7Cj4gKwlpZiAodW5saWtl
bHkobGVuID4gdHJ1ZXNpemUpKSB7Cj4gKwkJcHJfZGVidWcoIiVzOiByeCBlcnJvcjogbGVuICV1
IGV4Y2VlZHMgdHJ1ZXNpemUgJWx1XG4iLAo+ICsJCQkgZGV2LT5uYW1lLCBsZW4sICh1bnNpZ25l
ZCBsb25nKWN0eCk7Cj4gKwkJZGV2LT5zdGF0cy5yeF9sZW5ndGhfZXJyb3JzKys7Cj4gKwkJaWYg
KHhkcF9wcm9nKQo+ICsJCQlnb3RvIGVycl94ZHA7Cj4gKwo+ICsJCXJjdV9yZWFkX3VubG9jaygp
Owo+ICsJCWdvdG8gZXJyX3NrYjsKPiArCX0KCgpQYXRjaCBsb29rcyBjb3JyZWN0IGJ1dCBJJ2Qg
cmF0aGVyIG5vdCBib3RoZXIgWERQIGhlcmUuIEl0IHdvdWxkIGJlIApiZXR0ZXIgaWYgd2UganVz
dCBkbyB0aGUgY2hlY2sgYmVmb3JlIHJjdV9yZWFkX2xvY2soKSBhbmQgdXNlIGVycl9za2IgCmRp
cmVjdGx5KCkgdG8gYXZvaWQgUkNVL1hEUCBzdHVmZnMuCgpUaGFua3MKCgo+ICAgCWlmICh4ZHBf
cHJvZykgewo+ICAgCQlzdHJ1Y3QgeGRwX2ZyYW1lICp4ZHBmOwo+ICAgCQlzdHJ1Y3QgcGFnZSAq
eGRwX3BhZ2U7Cj4gQEAgLTEwMTIsMTMgKzEwMzMsNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYg
KnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAJfQo+ICAgCXJj
dV9yZWFkX3VubG9jaygpOwo+ICAgCj4gLQlpZiAodW5saWtlbHkobGVuID4gdHJ1ZXNpemUpKSB7
Cj4gLQkJcHJfZGVidWcoIiVzOiByeCBlcnJvcjogbGVuICV1IGV4Y2VlZHMgdHJ1ZXNpemUgJWx1
XG4iLAo+IC0JCQkgZGV2LT5uYW1lLCBsZW4sICh1bnNpZ25lZCBsb25nKWN0eCk7Cj4gLQkJZGV2
LT5zdGF0cy5yeF9sZW5ndGhfZXJyb3JzKys7Cj4gLQkJZ290byBlcnJfc2tiOwo+IC0JfQo+IC0K
PiAgIAloZWFkX3NrYiA9IHBhZ2VfdG9fc2tiKHZpLCBycSwgcGFnZSwgb2Zmc2V0LCBsZW4sIHRy
dWVzaXplLCAheGRwX3Byb2csCj4gICAJCQkgICAgICAgbWV0YXNpemUsICEhaGVhZHJvb20pOwo+
ICAgCWN1cnJfc2tiID0gaGVhZF9za2I7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
