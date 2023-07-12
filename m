Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AD3EB64DA
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 08:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18858834F4;
	Wed, 12 Jul 2023 08:31:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18858834F4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J9mTj7GQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S4GfYhpfkYUE; Wed, 12 Jul 2023 08:31:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A241F83417;
	Wed, 12 Jul 2023 08:31:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A241F83417
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64EE6C0072;
	Wed, 12 Jul 2023 08:31:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03CE1C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF5EF403E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:31:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF5EF403E9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J9mTj7GQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YRzrB3pbmoiv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:31:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D31D40142
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D31D40142
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689150710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMY8N4GgkrsaFITZViPaX/26omPvMDOYikNXpePFX8U=;
 b=J9mTj7GQOTLJcGFvm1eoSLDTfJD8IX13x8vaUB4X/N66f3l9SOOVNJGPA0AO0xByuZujFo
 9dwN1MpLM6b8E2stSptCGvXXFmY5SGtdmyzsK8BVjHR2W8CE90YUuCEYt7iMzG0UxlkOa2
 /mGOvcUFGhjCmNujbD7ZBOovPMvTxxs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-c0TrXUgZM2atRYZr0gYdzQ-1; Wed, 12 Jul 2023 04:31:49 -0400
X-MC-Unique: c0TrXUgZM2atRYZr0gYdzQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b7355cab4fso8659981fa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 01:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689150707; x=1691742707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMY8N4GgkrsaFITZViPaX/26omPvMDOYikNXpePFX8U=;
 b=ZCELvxSLa8TRfuKTIxXSvh9e0YcCJy/tAdEyix4rFLJvCPqJee17P19Rbw9spTm4GL
 XUovyFkiptoOZIikaWPi6pL+72Gmx9zlImSqtdKTlaIq4OZMmQ8t4nQDgYP0Ta2/2V0k
 ImEwqKp/KPgpatUWNkjNv+1u0elREmR21Y/aexbpxQA+AT263DgczgvDZvmEz/4W1ULI
 CFg2DQ5XWRHh1FDO5+gtD9cecMIcl8R67cVLbM2yEy6G6SoYQ0Pg0zvQ0zSYpGhwgWao
 Q+H6s3Klr+T48OcELBCD3Ph9NZr8lRiFqI/DklTJfHzn8wcc5CKZ914asoleINjOeJt5
 Scuw==
X-Gm-Message-State: ABy/qLZtXdN2ut3Lh6e+nHqSYEOtz79MoAorxfjTG4mhlLo0PjRKH7bs
 1W7WOSYLdltAtjxEHMiXzztXbcK8UmARFpasnC9EYgddxr4Z8F4vBTlmtI21ZOrw6zlvv/AeJWB
 DpsB90H8EHdkjCEjEpgd6rqi7ia7S0Ju2LU0ThBhVEa81N7tgJX/qCo3JyA==
X-Received: by 2002:a2e:b0c7:0:b0:2b6:ec69:7c3b with SMTP id
 g7-20020a2eb0c7000000b002b6ec697c3bmr14248592ljl.46.1689150707782; 
 Wed, 12 Jul 2023 01:31:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH8VQdPippc4jzXJqOkjPYz7uzhQc4c9Zm733Etko9K6J3AzHieVFvn79o9Yal5pESop9imlfRDh3vOC46gGBc=
X-Received: by 2002:a2e:b0c7:0:b0:2b6:ec69:7c3b with SMTP id
 g7-20020a2eb0c7000000b002b6ec697c3bmr14248566ljl.46.1689150707490; Wed, 12
 Jul 2023 01:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230710034237.12391-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jul 2023 16:31:35 +0800
Message-ID: <CACGkMEu16kUX02L+zb=hcX_sMW-s6wBFtiCRC_3H4ky4iDdy4Q@mail.gmail.com>
Subject: Re: [PATCH vhost v11 04/10] virtio_ring: support add premapped buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMTE6NDLigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IElmIHRoZSB2cSBpcyB0aGUgcHJlbWFwcGVkIG1v
ZGUsIHVzZSB0aGUgc2dfZG1hX2FkZHJlc3MoKSBkaXJlY3RseS4KPgo+IFNpZ25lZC1vZmYtYnk6
IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxOSArKysrKysrKysrKysrKysrKy0tCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gaW5kZXggNWFjZTQ1MzkzNDRjLi5kNDcxZGVlM2Y0ZjcgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMKPiBAQCAtMzYxLDYgKzM2MSwxMSBAQCBzdGF0aWMgc3RydWN0IGRldmljZSAqdnJpbmdf
ZG1hX2Rldihjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkKPiAgc3RhdGljIGludCB2
cmluZ19tYXBfb25lX3NnKGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLCBzdHJ1Y3Qg
c2NhdHRlcmxpc3QgKnNnLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGRtYV9k
YXRhX2RpcmVjdGlvbiBkaXJlY3Rpb24sIGRtYV9hZGRyX3QgKmFkZHIpCj4gIHsKPiArICAgICAg
IGlmICh2cS0+cHJlbWFwcGVkKSB7Cj4gKyAgICAgICAgICAgICAgICphZGRyID0gc2dfZG1hX2Fk
ZHJlc3Moc2cpOwo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPiArICAgICAgIH0KPiArCj4g
ICAgICAgICBpZiAoIXZxLT51c2VfZG1hX2FwaSkgewo+ICAgICAgICAgICAgICAgICAvKgo+ICAg
ICAgICAgICAgICAgICAgKiBJZiBETUEgaXMgbm90IHVzZWQsIEtNU0FOIGRvZXNuJ3Qga25vdyB0
aGF0IHRoZSBzY2F0dGVybGlzdAo+IEBAIC02MzksOCArNjQ0LDEyIEBAIHN0YXRpYyBpbmxpbmUg
aW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICAgICAgICAg
ICAgICAgICBkbWFfYWRkcl90IGFkZHIgPSB2cmluZ19tYXBfc2luZ2xlKAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHZxLCBkZXNjLCB0b3RhbF9zZyAqIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVz
YyksCj4gICAgICAgICAgICAgICAgICAgICAgICAgRE1BX1RPX0RFVklDRSk7Cj4gLSAgICAgICAg
ICAgICAgIGlmICh2cmluZ19tYXBwaW5nX2Vycm9yKHZxLCBhZGRyKSkKPiArICAgICAgICAgICAg
ICAgaWYgKHZyaW5nX21hcHBpbmdfZXJyb3IodnEsIGFkZHIpKSB7Cj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKHZxLT5wcmVtYXBwZWQpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBnb3RvIGZyZWVfaW5kaXJlY3Q7CgpVbmRlciB3aGljaCBjYXNlIGNvdWxkIHdlIGhpdCB0
aGlzPyBBIGJ1ZyBvZiB0aGUgZHJpdmVyPwoKVGhhbmtzCgo+ICsKPiAgICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7Cj4gKyAgICAgICAgICAgICAgIH0KPgo+ICAgICAg
ICAgICAgICAgICB2aXJ0cXVldWVfYWRkX2Rlc2Nfc3BsaXQoX3ZxLCB2cS0+c3BsaXQudnJpbmcu
ZGVzYywKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhlYWQsIGFk
ZHIsCj4gQEAgLTcwNiw2ICs3MTUsNyBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRk
X3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgICAgICAgICAgICAgICAgICAgICAgICBp
ID0gdnJpbmdfdW5tYXBfb25lX3NwbGl0KHZxLCBpKTsKPiAgICAgICAgIH0KPgo+ICtmcmVlX2lu
ZGlyZWN0Ogo+ICAgICAgICAgaWYgKGluZGlyZWN0KQo+ICAgICAgICAgICAgICAgICBrZnJlZShk
ZXNjKTsKPgo+IEBAIC0xMzA3LDggKzEzMTcsMTIgQEAgc3RhdGljIGludCB2aXJ0cXVldWVfYWRk
X2luZGlyZWN0X3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAgICAgICAgIGFk
ZHIgPSB2cmluZ19tYXBfc2luZ2xlKHZxLCBkZXNjLAo+ICAgICAgICAgICAgICAgICAgICAgICAg
IHRvdGFsX3NnICogc2l6ZW9mKHN0cnVjdCB2cmluZ19wYWNrZWRfZGVzYyksCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgRE1BX1RPX0RFVklDRSk7Cj4gLSAgICAgICBpZiAodnJpbmdfbWFwcGlu
Z19lcnJvcih2cSwgYWRkcikpCj4gKyAgICAgICBpZiAodnJpbmdfbWFwcGluZ19lcnJvcih2cSwg
YWRkcikpIHsKPiArICAgICAgICAgICAgICAgaWYgKHZxLT5wcmVtYXBwZWQpCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBmcmVlX2Rlc2M7Cj4gKwo+ICAgICAgICAgICAgICAgICBnb3Rv
IHVubWFwX3JlbGVhc2U7Cj4gKyAgICAgICB9Cj4KPiAgICAgICAgIHZxLT5wYWNrZWQudnJpbmcu
ZGVzY1toZWFkXS5hZGRyID0gY3B1X3RvX2xlNjQoYWRkcik7Cj4gICAgICAgICB2cS0+cGFja2Vk
LnZyaW5nLmRlc2NbaGVhZF0ubGVuID0gY3B1X3RvX2xlMzIodG90YWxfc2cgKgo+IEBAIC0xMzY2
LDYgKzEzODAsNyBAQCBzdGF0aWMgaW50IHZpcnRxdWV1ZV9hZGRfaW5kaXJlY3RfcGFja2VkKHN0
cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAgICAgICAgZm9yIChpID0gMDsgaSA8IGVycl9p
ZHg7IGkrKykKPiAgICAgICAgICAgICAgICAgdnJpbmdfdW5tYXBfZGVzY19wYWNrZWQodnEsICZk
ZXNjW2ldKTsKPgo+ICtmcmVlX2Rlc2M6Cj4gICAgICAgICBrZnJlZShkZXNjKTsKPgo+ICAgICAg
ICAgRU5EX1VTRSh2cSk7Cj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
