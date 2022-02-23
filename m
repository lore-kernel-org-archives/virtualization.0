Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F267EC433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 03:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82CDE81764;
	Wed, 23 Feb 2022 03:01:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y9YJP3pUHTX4; Wed, 23 Feb 2022 03:01:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 20DE58174F;
	Wed, 23 Feb 2022 03:01:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1EE9C001A;
	Wed, 23 Feb 2022 03:01:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D09ECC0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0F1281767
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:01:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Jz5EINNksk4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:01:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88B358174F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645585263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=87HIviIErcqqhqJKQfoiRmSG0HTj6c9q30hQ+yWQHNM=;
 b=XVPm+S5/3Dt+Nhg/t+R+xSstweETzUrSaZjycOSyphDu4VE+SRY4UUNL+zcsPiK+MiEbRJ
 50h0NRyyxlx4qXJO7woSNooEKRGqYzKHwj6I9EqKVn8Ly7fSSdx/sWValH36urINs4hX4X
 XxebGn4iq55toIom0zcamhqpwk3+oTo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-USMrIEAFNVqfDlVhDmemGQ-1; Tue, 22 Feb 2022 22:01:02 -0500
X-MC-Unique: USMrIEAFNVqfDlVhDmemGQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 t134-20020a62788c000000b004e1367caccaso8155603pfc.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 19:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=87HIviIErcqqhqJKQfoiRmSG0HTj6c9q30hQ+yWQHNM=;
 b=WTjkE7JvU7qLYsWLR/yBka5zXaqiL0TZETB9QKhs2bpTRCm3Et0b2+JbAYsTyYxrcz
 VsjlNSoMyUUoXssPXkg0qkdrJ36Lb5q/kJzPu2CBJ7z383yQszuup1OKxU0HR4iYstpV
 V/59uNw8C0liA0/rqf/LDja7IAnkwk2lcqHi9Y1x73MUwrQzQlrfvpCKw+FX902huFSY
 tIPPcfhElB6rPJqyVeGxhg4GtXaad+bzmYZfCNmENFOnd6GKCCW41CuuEUIiyxJwVIGS
 0LeW5x76++DrF8by88ooxoGv8IhDWfn7NnHYrxoZkAum2TmkUs586Gf6TFH5MEzAPN38
 gPUA==
X-Gm-Message-State: AOAM533Gdk2bYYmDT3LTxJm3FWosgzJY7+H6yYJmp6LYA4JkVdWKXQY5
 hjCKgwD9cDUyVp+YimejIBzTnyGZ2EgjeMSAkbTG/Ehfb+Q8bkSg6XZ1BKwbZeABdgCBz16b4MW
 L0iDGecdPLnO9ecU+wNNkKzA2G3wAJ9YR9bADiFQbxg==
X-Received: by 2002:a05:6a00:1691:b0:4e1:935f:94dd with SMTP id
 k17-20020a056a00169100b004e1935f94ddmr27654612pfc.83.1645585260705; 
 Tue, 22 Feb 2022 19:01:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFop1CRXbrlIaFWKYPyn7M1tXqqMOhFvFiAU8+vn85xPBCiKaLUTO9YncpOcIwkxwwEGuYnA==
X-Received: by 2002:a05:6a00:1691:b0:4e1:935f:94dd with SMTP id
 k17-20020a056a00169100b004e1935f94ddmr27654590pfc.83.1645585260409; 
 Tue, 22 Feb 2022 19:01:00 -0800 (PST)
Received: from [10.72.13.161] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z7sm1012741pjr.3.2022.02.22.19.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Feb 2022 19:00:59 -0800 (PST)
Message-ID: <8415ceb8-310f-f6be-9de9-2742810f2a21@redhat.com>
Date: Wed, 23 Feb 2022 11:00:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v1 4/6] virtio: virtqueue_add() support predma
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <20220210085124.15466-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220210085124.15466-5-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzIvMTAg5LiL5Y2INDo1MSwgWHVhbiBaaHVvIOWGmemBkzoKPiB2aXJ0dXF1ZV9h
ZGQoKSBhZGRzIHBhcmFtZXRlciBwcmVkbWEuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8g
PHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYyB8IDExICsrKysrKy0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggY2ZiMDI4
Y2EyMzhlLi5jZjlkMTE4NjY4ZjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMTc4MCw3
ICsxNzgwLDggQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZChzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEsCj4gICAJCQkJdW5zaWduZWQgaW50IGluX3NncywKPiAgIAkJCQl2b2lkICpkYXRh
LAo+ICAgCQkJCXZvaWQgKmN0eCwKPiAtCQkJCWdmcF90IGdmcCkKPiArCQkJCWdmcF90IGdmcCwK
PiArCQkJCWJvb2wgcHJlZG1hKQoKCnNnIGlzIGFzc3VtZWQgdG8gdXNlIGRtYSBhZGRyZXNzLCBz
byBJIHdvbmRlciB3aGV0aGVyICJzZ19pc19waHlzIiBpcyBhIApiZXR0ZXIgbmFtZT8KClRoYW5r
cwoKCj4gICB7Cj4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsK
PiAgIAo+IEBAIC0xODIxLDcgKzE4MjIsNyBAQCBpbnQgdmlydHF1ZXVlX2FkZF9zZ3Moc3RydWN0
IHZpcnRxdWV1ZSAqX3ZxLAo+ICAgCQkJdG90YWxfc2crKzsKPiAgIAl9Cj4gICAJcmV0dXJuIHZp
cnRxdWV1ZV9hZGQoX3ZxLCBzZ3MsIHRvdGFsX3NnLCBvdXRfc2dzLCBpbl9zZ3MsCj4gLQkJCSAg
ICAgZGF0YSwgTlVMTCwgZ2ZwKTsKPiArCQkJICAgICBkYXRhLCBOVUxMLCBnZnAsIGZhbHNlKTsK
PiAgIH0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9hZGRfc2dzKTsKPiAgIAo+IEBA
IC0xODQzLDcgKzE4NDQsNyBAQCBpbnQgdmlydHF1ZXVlX2FkZF9vdXRidWYoc3RydWN0IHZpcnRx
dWV1ZSAqdnEsCj4gICAJCQkgdm9pZCAqZGF0YSwKPiAgIAkJCSBnZnBfdCBnZnApCj4gICB7Cj4g
LQlyZXR1cm4gdmlydHF1ZXVlX2FkZCh2cSwgJnNnLCBudW0sIDEsIDAsIGRhdGEsIE5VTEwsIGdm
cCk7Cj4gKwlyZXR1cm4gdmlydHF1ZXVlX2FkZCh2cSwgJnNnLCBudW0sIDEsIDAsIGRhdGEsIE5V
TEwsIGdmcCwgZmFsc2UpOwo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX2Fk
ZF9vdXRidWYpOwo+ICAgCj4gQEAgLTE4NjUsNyArMTg2Niw3IEBAIGludCB2aXJ0cXVldWVfYWRk
X2luYnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLAo+ICAgCQkJdm9pZCAqZGF0YSwKPiAgIAkJCWdm
cF90IGdmcCkKPiAgIHsKPiAtCXJldHVybiB2aXJ0cXVldWVfYWRkKHZxLCAmc2csIG51bSwgMCwg
MSwgZGF0YSwgTlVMTCwgZ2ZwKTsKPiArCXJldHVybiB2aXJ0cXVldWVfYWRkKHZxLCAmc2csIG51
bSwgMCwgMSwgZGF0YSwgTlVMTCwgZ2ZwLCBmYWxzZSk7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9M
X0dQTCh2aXJ0cXVldWVfYWRkX2luYnVmKTsKPiAgIAo+IEBAIC0xODg5LDcgKzE4OTAsNyBAQCBp
bnQgdmlydHF1ZXVlX2FkZF9pbmJ1Zl9jdHgoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4gICAJCQl2
b2lkICpjdHgsCj4gICAJCQlnZnBfdCBnZnApCj4gICB7Cj4gLQlyZXR1cm4gdmlydHF1ZXVlX2Fk
ZCh2cSwgJnNnLCBudW0sIDAsIDEsIGRhdGEsIGN0eCwgZ2ZwKTsKPiArCXJldHVybiB2aXJ0cXVl
dWVfYWRkKHZxLCAmc2csIG51bSwgMCwgMSwgZGF0YSwgY3R4LCBnZnAsIGZhbHNlKTsKPiAgIH0K
PiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9hZGRfaW5idWZfY3R4KTsKPiAgIAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
