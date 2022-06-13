Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0329C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 06:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F3EE607C9;
	Mon, 13 Jun 2022 06:56:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NDmklnSkeopS; Mon, 13 Jun 2022 06:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 120BA60BD8;
	Mon, 13 Jun 2022 06:56:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB942C0032;
	Mon, 13 Jun 2022 06:56:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1030FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 06:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE470405BF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 06:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7bXsISnCKuAV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 06:56:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 96C5D40441
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655103400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3Q2pehuhBXfi5bkDbOGjKf18q2aocUNS8Z76bl7jz8=;
 b=Z+JKModrs6hQiQBB7C0uCJ2cQIYPYztZ5/7LncfMgTX9TCLHDBIN9isXYSj0dfPIBpEKQz
 dQyns8xVwfuFKDrcsNDKJ8sf5ZKsHsu038FyRz37p673/hDxOHuwqQEgU9tLhaxd3LQC/X
 ZowOKOMev7vdbK9pxIENXPd/FsYMc6s=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-_8YXGpk6NuC9xpi_uRP0PA-1; Mon, 13 Jun 2022 02:56:33 -0400
X-MC-Unique: _8YXGpk6NuC9xpi_uRP0PA-1
Received: by mail-lf1-f72.google.com with SMTP id
 l12-20020a056512110c00b0047961681d22so2641070lfg.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 23:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l3Q2pehuhBXfi5bkDbOGjKf18q2aocUNS8Z76bl7jz8=;
 b=px9jl9XUGVHrr1huABsmlafrBbUFW8VA3/JJ1KS/Y93UrivdHZs82yEJulqx1m6wwo
 1IdzGc+1mSDGz1c5Muqko3zjIfRsKUjfRIHuFmwdJKwUL/Y13ydQA5fzVCUkROBN8zhD
 c8ntgy4Xe+CUYGGE2Kmkz4oiWH7U4z6Ly2cg3KB1qKPpgvmmSJs72qTNZKsNmn1/gDB0
 JR+h/hgouRQ5ehejmu8/Cp36JhOlHweiKlmO4DXd5t56jKk4Hx4NEc+LR1pEcO18OW05
 yaJ7pfKacjh06EoshiJbuF7DePdWfQoUinP2SGr33ZlJxvB/y9WTEPxxK6yjT+fHv5ml
 Slig==
X-Gm-Message-State: AOAM531j55TKeTdWnPKmnA6g/IhAv5hq1Rk+opq8EF4VTxJpzI4ni6De
 zP0eX6CnoIzX5A3JMbLHALEaLLx/pCiHxTkzHsk+VuyVh2/zNDXnAo0whXg5XIzPX1IJPsLP2lB
 LP0bLe3vWvya79bw2SwI0Gyw4ajY17r76FKiGPzO94aT6LEf73eT3BoYpuw==
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id
 h22-20020a2e3a16000000b0025578112827mr27713648lja.130.1655103391245; 
 Sun, 12 Jun 2022 23:56:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFY9AX45aDkYJg9CKXs31T/1/XX1RpWD3mAClRRslPBBz8geXGj2Iuxnj9PG8EK9wsFHN71rtWZAzXkS5N5qo=
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id
 h22-20020a2e3a16000000b0025578112827mr27713639lja.130.1655103390957; Sun, 12
 Jun 2022 23:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220610103314.61577-1-huangjie.albert@bytedance.com>
 <20220610103905-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220610103905-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jun 2022 14:56:19 +0800
Message-ID: <CACGkMEuTv6HMrKJE9w2y8SJ8cAx6XBSqRxVXgRBrkN7uP3S1pg@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring : fix vring_packed_desc memory out of bounds
 bug
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gRnJpLCBKdW4gMTAsIDIwMjIgYXQgMTA6NTEgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBGcmksIEp1biAxMCwgMjAyMiBhdCAwNjozMzoxNFBN
ICswODAwLCBodWFuZ2ppZS5hbGJlcnQgd3JvdGU6Cj4gPiBrc29mdGlycWQgbWF5IGNvbnN1bWUg
dGhlIHBhY2tldCBhbmQgaXQgd2lsbCBjYWxsOgo+ID4gdmlydG5ldF9wb2xsCj4gPiAgICAgICAt
LT52aXJ0bmV0X3JlY2VpdmUKPiA+ICAgICAgICAgICAgICAgLS0+dmlydHF1ZXVlX2dldF9idWZf
Y3R4Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgLS0+dmlydHF1ZXVlX2dldF9idWZfY3R4X3Bh
Y2tlZAo+ID4gYW5kIGluIHZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9wYWNrZWQ6Cj4gPgo+ID4gdnEt
Pmxhc3RfdXNlZF9pZHggKz0gdnEtPnBhY2tlZC5kZXNjX3N0YXRlW2lkXS5udW07Cj4gPiBpZiAo
dW5saWtlbHkodnEtPmxhc3RfdXNlZF9pZHggPj0gdnEtPnBhY2tlZC52cmluZy5udW0pKSB7Cj4g
PiAgICAgICAgICB2cS0+bGFzdF91c2VkX2lkeCAtPSB2cS0+cGFja2VkLnZyaW5nLm51bTsKPiA+
ICAgICAgICAgIHZxLT5wYWNrZWQudXNlZF93cmFwX2NvdW50ZXIgXj0gMTsKPiA+IH0KPiA+Cj4g
PiBpZiBhdCB0aGUgc2FtZSB0aW1lLCB0aGVyZSBjb21lcyBhIHZyaW5nIGludGVycnVwdO+8jGlu
IHZyaW5nX2ludGVycnVwdDoKPiA+IHdlIHdpbGwgY2FsbDoKPiA+IHZyaW5nX2ludGVycnVwdAo+
ID4gICAgICAgLS0+bW9yZV91c2VkCj4gPiAgICAgICAgICAgICAgIC0tPm1vcmVfdXNlZF9wYWNr
ZWQKPiA+ICAgICAgICAgICAgICAgICAgICAgICAtLT5pc191c2VkX2Rlc2NfcGFja2VkCj4gPiBp
biBpc191c2VkX2Rlc2NfcGFja2VkLCB0aGUgbGFzdF91c2VkX2lkeCBtYXliZSA+PSB2cS0+cGFj
a2VkLnZyaW5nLm51bS4KPiA+IHNvIHRoaXMgY291bGQgY2FzZSBhIG1lbW9yeSBvdXQgb2YgYm91
bmRzIGJ1Zy4KPiA+Cj4gPiB0aGlzIHBhdGNoIGlzIHRvIGZpeCB0aGlzLgo+ID4KPiA+IFNpZ25l
ZC1vZmYtYnk6IGh1YW5namllLmFsYmVydCA8aHVhbmdqaWUuYWxiZXJ0QGJ5dGVkYW5jZS5jb20+
Cj4KPgo+IFRoaXMgcGF0dGVybiB3YXMgYWx3YXlzIGlmZnksIGJ1dCBJIGRvbid0IHRoaW5rIHRo
ZSBwYXRjaAo+IGltcHJvdmVzIHRoZSBzaXR1YXRpb24gbXVjaC4gbGFzdF91c2VkX2lkeCBhbmQg
dnEtPnBhY2tlZC51c2VkX3dyYXBfY291bnRlcgo+IGNhbiBzdGlsbCBnZXQgb3V0IG9mIHN5bmMu
Cj4KPiBNYXliZSByZWZhY3RvciBjb2RlIHRvIGtlZXAgZXZlcnl0aGluZyBpbiB2cS0+bGFzdF91
c2VkX2lkeD8KPgo+IEphc29uIHdoYXQgaXMgeW91ciB0YWtlPwoKSSB0aGluayB3ZSBjYW4gZG8g
dGhpcyBzaW5jZSAxNmJpdC8zMmJpdCBvcGVyYXRpb25zIGFyZSBndWFyYW50ZWVkIHRvIGJlIGF0
b21pYy4KClRoYW5rcwoKPgo+Cj4KPgo+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jIHwgMyArKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBpbmRleCAxM2E3MzQ4Y2VkZmYuLmQyYWJiYjNhODE4
NyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBAIC0xMzk3LDYgKzEzOTcsOSBAQCBz
dGF0aWMgaW5saW5lIGJvb2wgaXNfdXNlZF9kZXNjX3BhY2tlZChjb25zdCBzdHJ1Y3QgdnJpbmdf
dmlydHF1ZXVlICp2cSwKPiA+ICAgICAgIGJvb2wgYXZhaWwsIHVzZWQ7Cj4gPiAgICAgICB1MTYg
ZmxhZ3M7Cj4gPgo+ID4gKyAgICAgaWYgKGlkeCA+PSB2cS0+cGFja2VkLnZyaW5nLm51bSkKPiA+
ICsgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+ID4gKwo+ID4gICAgICAgZmxhZ3MgPSBsZTE2
X3RvX2NwdSh2cS0+cGFja2VkLnZyaW5nLmRlc2NbaWR4XS5mbGFncyk7Cj4gPiAgICAgICBhdmFp
bCA9ICEhKGZsYWdzICYgKDEgPDwgVlJJTkdfUEFDS0VEX0RFU0NfRl9BVkFJTCkpOwo+ID4gICAg
ICAgdXNlZCA9ICEhKGZsYWdzICYgKDEgPDwgVlJJTkdfUEFDS0VEX0RFU0NfRl9VU0VEKSk7Cj4g
PiAtLQo+ID4gMi4yNy4wCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
