Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2F4C433FE
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 06:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EF92408DB;
	Mon, 10 Jan 2022 06:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MSO6tL6WMCem; Mon, 10 Jan 2022 06:19:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E83B8408C2;
	Mon, 10 Jan 2022 06:19:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8537C002F;
	Mon, 10 Jan 2022 06:19:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EED0CC001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CFC4960B87
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sWVdz82gLJMU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:19:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A25E1605BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641795571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgoG/9iyv10MV0Vvi9DPPbDgvq8/kqCRzBpMtGOZn0o=;
 b=ASy1aiErRXbHfLdFsiDxrJgsGs56VRr1qI2Xu4IvsWx3bd51LKgBGf53hfS6irkICkoqDb
 fzxplNkTDB11y/mvA7hk/8D6DWhlVvTXS2YU98y1XiVerHMxTnJQmRTPmK9JkysrHUL7ih
 7eHTJv9moGHm3c6T+4DoNHoJZOQQ0zM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-P8s5yUC6PHmjxlM4vKH-_A-1; Mon, 10 Jan 2022 01:19:30 -0500
X-MC-Unique: P8s5yUC6PHmjxlM4vKH-_A-1
Received: by mail-pf1-f200.google.com with SMTP id
 f9-20020a623809000000b004bd0fd5e057so3059895pfa.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 22:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=CgoG/9iyv10MV0Vvi9DPPbDgvq8/kqCRzBpMtGOZn0o=;
 b=RxuOAOjt32JhUUV+9a6XCTuqFXDilx2oKH9PPyrss0YU17VC8HPTVfXSo1nH9rPliv
 JhRPoLnIaaD+25E4Ns9w8S1blcviMaA6UP+tfYNlo+dmJSzmOMXzviJvEG0jQkiZjO4I
 Zss2AOY7v+G4TwS+r9dzN69WAiRhavTvw+RG+T1723BRLISrAE42HuwzlkHpRQB1Mz/h
 Ho/oARHzqr93OfhgwBP3SeMUFwlz1P7mnBon+E6RhMyL32zLe9c/XZ6KVu1mjo2wuWas
 n1i5EuckJ3vrQURwVcWA8ir71Qzje1kVCT2spDV5OwJLj5ueCETX2vBu5q8xgRVTH8qX
 xn5Q==
X-Gm-Message-State: AOAM532R+i0zq5dKNEm4jiSPfDp5fbnOztYBtjUNbWk9AwpYY7v3MZvs
 MidRSWVVrHRl5ZX1b+WvjVdGCDwsRigCrs8r6JDmDtQoy/3EoPIYv9CNIU3UOCDj9hRB2ynUqoG
 u0fWtp/E5bDxSilVKQDN7UHHjxW1YL8/ZlIeeNrDMTw==
X-Received: by 2002:a63:79c4:: with SMTP id u187mr486183pgc.27.1641795568361; 
 Sun, 09 Jan 2022 22:19:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqqgw2Q0/qFBGiWk329K0p3ow3jt8I//Xhmx2F9pfGB0bvwuUSc2jb9WW89iIqI0mlhXEaRQ==
X-Received: by 2002:a63:79c4:: with SMTP id u187mr486172pgc.27.1641795568149; 
 Sun, 09 Jan 2022 22:19:28 -0800 (PST)
Received: from [10.72.13.131] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l18sm969160pfu.63.2022.01.09.22.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jan 2022 22:19:27 -0800 (PST)
Message-ID: <d7734715-ff89-fe04-fc39-55d5f5a7a747@redhat.com>
Date: Mon, 10 Jan 2022 14:19:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 1/6] virtio: rename vring_unmap_state_packed() to
 vring_unmap_extra_packed()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
 <20220107063306.23240-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220107063306.23240-2-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzEvNyDkuIvljYgyOjMzLCBYdWFuIFpodW8g5YaZ6YGTOgo+IFRoZSBhY3R1YWwg
cGFyYW1ldGVyIGhhbmRsZWQgYnkgdnJpbmdfdW5tYXBfc3RhdGVfcGFja2VkKCkgaXMgdGhhdAo+
IHZyaW5nX2Rlc2NfZXh0cmEsIHNvIHRoaXMgZnVuY3Rpb24gc2hvdWxkIHVzZSAiZXh0cmEiIGlu
c3RlYWQgb2YgInN0YXRlIi4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9A
bGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxNyArKysr
KysrKy0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDAyOGIwNWQ0NDU0Ni4uODE1MzFj
YmIwOGE3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTk4NCwyNCArOTg0LDI0IEBAIHN0
YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ICAg
ICogUGFja2VkIHJpbmcgc3BlY2lmaWMgZnVuY3Rpb25zIC0gKl9wYWNrZWQoKS4KPiAgICAqLwo+
ICAgCj4gLXN0YXRpYyB2b2lkIHZyaW5nX3VubWFwX3N0YXRlX3BhY2tlZChjb25zdCBzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlICp2cSwKPiAtCQkJCSAgICAgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEg
KnN0YXRlKQo+ICtzdGF0aWMgdm9pZCB2cmluZ191bm1hcF9leHRyYV9wYWNrZWQoY29uc3Qgc3Ry
dWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gKwkJCQkgICAgIHN0cnVjdCB2cmluZ19kZXNjX2V4
dHJhICpleHRyYSkKPiAgIHsKPiAgIAl1MTYgZmxhZ3M7Cj4gICAKPiAgIAlpZiAoIXZxLT51c2Vf
ZG1hX2FwaSkKPiAgIAkJcmV0dXJuOwo+ICAgCj4gLQlmbGFncyA9IHN0YXRlLT5mbGFnczsKPiAr
CWZsYWdzID0gZXh0cmEtPmZsYWdzOwo+ICAgCj4gICAJaWYgKGZsYWdzICYgVlJJTkdfREVTQ19G
X0lORElSRUNUKSB7Cj4gICAJCWRtYV91bm1hcF9zaW5nbGUodnJpbmdfZG1hX2Rldih2cSksCj4g
LQkJCQkgc3RhdGUtPmFkZHIsIHN0YXRlLT5sZW4sCj4gKwkJCQkgZXh0cmEtPmFkZHIsIGV4dHJh
LT5sZW4sCj4gICAJCQkJIChmbGFncyAmIFZSSU5HX0RFU0NfRl9XUklURSkgPwo+ICAgCQkJCSBE
TUFfRlJPTV9ERVZJQ0UgOiBETUFfVE9fREVWSUNFKTsKPiAgIAl9IGVsc2Ugewo+ICAgCQlkbWFf
dW5tYXBfcGFnZSh2cmluZ19kbWFfZGV2KHZxKSwKPiAtCQkJICAgICAgIHN0YXRlLT5hZGRyLCBz
dGF0ZS0+bGVuLAo+ICsJCQkgICAgICAgZXh0cmEtPmFkZHIsIGV4dHJhLT5sZW4sCj4gICAJCQkg
ICAgICAgKGZsYWdzICYgVlJJTkdfREVTQ19GX1dSSVRFKSA/Cj4gICAJCQkgICAgICAgRE1BX0ZS
T01fREVWSUNFIDogRE1BX1RPX0RFVklDRSk7Cj4gICAJfQo+IEBAIC0xMzAxLDggKzEzMDEsNyBA
QCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEsCj4gICAJZm9yIChuID0gMDsgbiA8IHRvdGFsX3NnOyBuKyspIHsKPiAgIAkJaWYgKGkg
PT0gZXJyX2lkeCkKPiAgIAkJCWJyZWFrOwo+IC0JCXZyaW5nX3VubWFwX3N0YXRlX3BhY2tlZCh2
cSwKPiAtCQkJCQkgJnZxLT5wYWNrZWQuZGVzY19leHRyYVtjdXJyXSk7Cj4gKwkJdnJpbmdfdW5t
YXBfZXh0cmFfcGFja2VkKHZxLCAmdnEtPnBhY2tlZC5kZXNjX2V4dHJhW2N1cnJdKTsKPiAgIAkJ
Y3VyciA9IHZxLT5wYWNrZWQuZGVzY19leHRyYVtjdXJyXS5uZXh0Owo+ICAgCQlpKys7Cj4gICAJ
CWlmIChpID49IHZxLT5wYWNrZWQudnJpbmcubnVtKQo+IEBAIC0xMzgxLDggKzEzODAsOCBAQCBz
dGF0aWMgdm9pZCBkZXRhY2hfYnVmX3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwK
PiAgIAlpZiAodW5saWtlbHkodnEtPnVzZV9kbWFfYXBpKSkgewo+ICAgCQljdXJyID0gaWQ7Cj4g
ICAJCWZvciAoaSA9IDA7IGkgPCBzdGF0ZS0+bnVtOyBpKyspIHsKPiAtCQkJdnJpbmdfdW5tYXBf
c3RhdGVfcGFja2VkKHZxLAo+IC0JCQkJJnZxLT5wYWNrZWQuZGVzY19leHRyYVtjdXJyXSk7Cj4g
KwkJCXZyaW5nX3VubWFwX2V4dHJhX3BhY2tlZCh2cSwKPiArCQkJCQkJICZ2cS0+cGFja2VkLmRl
c2NfZXh0cmFbY3Vycl0pOwo+ICAgCQkJY3VyciA9IHZxLT5wYWNrZWQuZGVzY19leHRyYVtjdXJy
XS5uZXh0Owo+ICAgCQl9Cj4gICAJfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
