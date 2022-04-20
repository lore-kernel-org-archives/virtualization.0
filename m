Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D94C433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 03:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4363342544;
	Wed, 20 Apr 2022 03:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id frKm_gIHagYM; Wed, 20 Apr 2022 03:07:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A9AB42528;
	Wed, 20 Apr 2022 03:07:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B362C002F;
	Wed, 20 Apr 2022 03:07:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 842CCC002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 03:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 798D44023B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 03:07:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0PqCa05_Mrwr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 03:07:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 759AF400A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 03:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650424035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lbouQ/Yuz0qhjAitkgqiIQtPXTub98ZuiHZ7oIDZX9w=;
 b=SW137IlpYw4j+71WvdyKbU8sd1UIricvQTI5RN0M8dFDjMxJpop4FEFpCrvO0WLac35DLj
 mNT9LmIKerQ07khD367yfxgtVkpCywlkF9GTy1Kf+jgkGHUGck3fe/E4fKzSIxYnB/Y0/Y
 yQRe/qFiW0Mk3ssgrkFQqQpQj8Wf0g4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-bTeRYXAFNN6UdzOCrPE8XA-1; Tue, 19 Apr 2022 23:07:13 -0400
X-MC-Unique: bTeRYXAFNN6UdzOCrPE8XA-1
Received: by mail-lj1-f197.google.com with SMTP id
 20-20020a05651c009400b002462f08f8d2so93370ljq.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 20:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lbouQ/Yuz0qhjAitkgqiIQtPXTub98ZuiHZ7oIDZX9w=;
 b=DBrjfphVj4Ja9nXeCu0aTI43cAGABAJne3tOCq9f2pBk1+ey/YoTqN4cQVabh5KSoH
 uwpiOI7mfA8SvT+wnV0zyeF7O+QYBR+Oy4h53NF4Ry33m8r//qvlRIofWbZUKvsaO6pw
 5HGKCeD0rsN7eOUfKiivvhNslnluqjV9pq4sve4GQ1xNBnBO+kJVUs6s61nxMqNL1gct
 6+uSUxgpH0r28IfeK4a/EMuM+QnSMHvu2DHa+C2/TNyFOMjSqFQSRY7gv5WqIX3Re0ZT
 EcrikEZh2kDr62hYKxSLNdv49IQlX+xpmqMLz98VmbtlnmcYTTDrhyU7w+1dwJzmOPW9
 w1hA==
X-Gm-Message-State: AOAM532GWHf/lTNptmhEEW4aJf6FYtYzpgI8+veLZ0Ft+mh3ZWAZrdjm
 nNDxJ45s07XnfSzr6Dox5r3E2l5t2bzgMJvf+EEN1tE4ELOHQhzfXJ6ORpDXuR79GUOA3RAx1GA
 h/Jrn4coj2exps4LGZQAXQdaMGJ0u54wmwBJEjTV/7zJiXF2WfAnTh+Nh2A==
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id
 e10-20020a05651c090a00b002495d82fe9cmr11973578ljq.300.1650424032079; 
 Tue, 19 Apr 2022 20:07:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2iY8r/rBfCmRSQ4iE2fw8xEiwfvqgCD0hlMhc+Zn7upTa5zoybRzcRQPE+cZMJqJ0ytbwi6K1r4bacjOhuZI=
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id
 e10-20020a05651c090a00b002495d82fe9cmr11973567ljq.300.1650424031826; Tue, 19
 Apr 2022 20:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <c0c17b91-747e-ab58-83e5-b6f7dfa55e75@opensynergy.com>
 <20220419103826-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220419103826-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Apr 2022 11:07:00 +0800
Message-ID: <CACGkMEvJu8ADk=+QJryDfuh9y8pXzfYQ3KRg0Lq0POH3Z-SHuQ@mail.gmail.com>
Subject: Re: virtio-net: Unpermitted usage of virtqueue before virtio driver
 initialization
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Willem de Bruijn <willemb@google.com>,
 =?UTF-8?Q?Maciej_Szyma=C5=84ski?= <maciej.szymanski@opensynergy.com>,
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

T24gVHVlLCBBcHIgMTksIDIwMjIgYXQgMTE6MDMgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEFwciAxOSwgMjAyMiBhdCAwNDoxMjozMVBN
ICswMjAwLCBNYWNpZWogU3p5bWHFhHNraSB3cm90ZToKPiA+IEhlbGxvLAo+ID4KPiA+IEkndmUg
Zm91bmQgYSBwcm9ibGVtIGluIHZpcnRpby1uZXQgZHJpdmVyLgo+ID4gSWYgdmlydGlvLW5ldCBi
YWNrZW5kIGRldmljZSBhZHZlcnRpc2VzIGd1ZXN0IG9mZmxvYWQgZmVhdHVyZXMsIHRoZXJlIGlz
Cj4gPiBhbiB1bnBlcm1pdHRlZCB1c2FnZSBvZiBjb250cm9sIHZpcnRxdWV1ZSBiZWZvcmUgZHJp
dmVyIGlzIGluaXRpYWxpemVkLgo+ID4gQWNjb3JkaW5nIHRvIFZJUlRJTyBzcGVjaWZpY2F0aW9u
IDIuMS4yIDoKPiA+ICJUaGUgZGV2aWNlIE1VU1QgTk9UIGNvbnN1bWUgYnVmZmVycyBvciBzZW5k
IGFueSB1c2VkIGJ1ZmZlcgo+ID4gbm90aWZpY2F0aW9ucyB0byB0aGUgZHJpdmVyIGJlZm9yZSBE
UklWRVJfT0suIgo+Cj4gUmlnaHQuCj4KPiA+IER1cmluZyBhbiBpbml0aWFsaXphdGlvbiwgZHJp
dmVyIGNhbGxzIHJlZ2lzdGVyX25ldGRldmljZSB3aGljaCBpbnZva2VzCj4gPiBjYWxsYmFjayBm
dW5jdGlvbiB2aXJ0bmV0X3NldF9mZWF0dXJlcyBmcm9tIF9fbmV0ZGV2X3VwZGF0ZV9mZWF0dXJl
cy4KPiA+IElmIGd1ZXN0IG9mZmxvYWQgZmVhdHVyZXMgYXJlIGFkdmVydGlzZWQgYnkgdGhlIGRl
dmljZSwKPiA+IHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzIGlzIHVzaW5nIHZpcnRuZXRfc2Vu
ZF9jb21tYW5kIHRvIHdyaXRlIGFuZAo+ID4gcmVhZCBmcm9tIFZRLgo+ID4gVGhhdCBsZWFkcyB0
byBpbml0aWFsaXphdGlvbiBzdHVjayBhcyBkZXZpY2UgaXMgbm90IHBlcm1pdHRlZCB5ZXQgdG8g
dXNlIFZRLgo+Cj4KPgo+IEhtbSBzbyB3ZSBoYXZlIHRoaXM6Cj4KPgo+ICAgICAgICAgaWYgKChk
ZXYtPmZlYXR1cmVzIF4gZmVhdHVyZXMpICYgTkVUSUZfRl9HUk9fSFcpIHsKPiAgICAgICAgICAg
ICAgICAgaWYgKHZpLT54ZHBfZW5hYmxlZCkKPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVCVVNZOwo+Cj4gICAgICAgICAgICAgICAgIGlmIChmZWF0dXJlcyAmIE5FVElGX0ZfR1JP
X0hXKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIG9mZmxvYWRzID0gdmktPmd1ZXN0X29mZmxv
YWRzX2NhcGFibGU7Cj4gICAgICAgICAgICAgICAgIGVsc2UKPiAgICAgICAgICAgICAgICAgICAg
ICAgICBvZmZsb2FkcyA9IHZpLT5ndWVzdF9vZmZsb2Fkc19jYXBhYmxlICYKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIH5HVUVTVF9PRkZMT0FEX0dST19IV19NQVNLOwo+Cj4g
ICAgICAgICAgICAgICAgIGVyciA9IHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzKHZpLCBvZmZs
b2Fkcyk7Cj4gICAgICAgICAgICAgICAgIGlmIChlcnIpCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIGVycjsKPiAgICAgICAgICAgICAgICAgdmktPmd1ZXN0X29mZmxvYWRzID0gb2Zm
bG9hZHM7Cj4gICAgICAgICB9Cj4KPiB3aGljaCBJIGd1ZXNzIHNob3VsZCBoYXZlIHByZXZlbnRl
ZCB2aXJ0bmV0X3NldF9ndWVzdF9vZmZsb2FkcyBmcm9tIGV2ZXIgcnVubmluZy4KPgo+IEZyb20g
eW91ciBkZXNjcmlwdGlvbiBpdCBzb3VuZHMgbGlrZSB5b3UgaGF2ZSBvYnNlcnZlZCB0aGlzCj4g
aW4gcHJhY3RpY2UsIHJpZ2h0Pwo+Cj4KPgo+ID4gSSBoYXZlIGF0dGFjaGVkIGEgcGF0Y2ggZm9y
IGtlcm5lbCA1LjE4LXJjMyB3aGljaCBmaXhlcyB0aGUgcHJvYmxlbSBieQo+ID4gZGVmZXJyaW5n
IGZlYXR1cmUgc2V0IGFmdGVyIHZpcnRpbyBkcml2ZXIgaW5pdGlhbGl6YXRpb24uCj4gPgo+ID4g
QmVzdCBSZWdhcmRzLAo+ID4KPiA+IC0tCj4gPiBNYWNpZWogU3p5bWHFhHNraQo+ID4gU2VuaW9y
IFN0YWZmIEVuZ2luZWVyCj4gPgo+ID4gT3BlblN5bmVyZ3kgR21iSAo+ID4gUm90aGVyc3RyLiAy
MCwgMTAyNDUgQmVybGluCj4gPgo+ID4gUGhvbmU6ICAgICs0OSAzMCA2MCA5OCA1NCAwIC04Ngo+
ID4gRmF4OiAgICAgICs0OSAzMCA2MCA5OCA1NCAwIC05OQo+ID4gRS1NYWlsOiAgIG1hY2llai5z
enltYW5za2lAb3BlbnN5bmVyZ3kuY29tCj4gPgo+ID4gd3d3Lm9wZW5zeW5lcmd5LmNvbQo+ID4K
PiA+IEhhbmRlbHNyZWdpc3Rlci9Db21tZXJjaWFsIFJlZ2lzdHJ5OiBBbXRzZ2VyaWNodCBDaGFy
bG90dGVuYnVyZywgSFJCIDEwODYxNkIKPiA+IEdlc2Now6RmdHNmw7xocmVyL01hbmFnaW5nIERp
cmVjdG9yOiBSZWdpcyBBZGphbWFoCj4gPgo+ID4gUGxlYXNlIG1pbmQgb3VyIHByaXZhY3kgbm90
aWNlPGh0dHBzOi8vd3d3Lm9wZW5zeW5lcmd5LmNvbS9kYXRlbnNjaHV0emVya2xhZXJ1bmcvcHJp
dmFjeS1ub3RpY2UtZm9yLWJ1c2luZXNzLXBhcnRuZXJzLXB1cnN1YW50LXRvLWFydGljbGUtMTMt
b2YtdGhlLWdlbmVyYWwtZGF0YS1wcm90ZWN0aW9uLXJlZ3VsYXRpb24tZ2Rwci8+IHB1cnN1YW50
IHRvIEFydC4gMTMgR0RQUi4gLy8gVW5zZXJlIEhpbndlaXNlIHp1bSBEYXRlbnNjaHV0eiBnZW0u
IEFydC4gMTMgRFNHVk8gZmluZGVuIFNpZSBoaWVyLjxodHRwczovL3d3dy5vcGVuc3luZXJneS5j
b20vZGUvZGF0ZW5zY2h1dHplcmtsYWVydW5nL2RhdGVuc2NodXR6aGlud2Vpc2UtZnVlci1nZXNj
aGFlZnRzcGFydG5lci1nZW0tYXJ0LTEzLWRzZ3ZvLz4KPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gaW5kZXgg
ODc4MzhjYi4uYTQ0NDYyZCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBAQCAtMjY0LDYgKzI2NCw4
IEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gewo+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIGd1ZXN0
X29mZmxvYWRzOwo+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIGd1ZXN0X29mZmxvYWRzX2NhcGFi
bGU7Cj4gPgo+ID4gKyAgICAgICBuZXRkZXZfZmVhdHVyZXNfdCBmZWF0dXJlczsKPiA+ICsKPgo+
IEkgZG9uJ3QgbXVjaCBsaWtlIGhvdyB3ZSBhcmUgZm9yY2VkIHRvIGtlZXAgYSBjb3B5IG9mIGZl
YXR1cmVzCj4gaGVyZSA6KCBBdCBsZWFzdCBwbHMgYWRkIGEgY29tbWVudCBleHBsYWluaW5nIHdo
YXQncyBnb2luZyBvbiwKPiB3aG8gb3ducyB0aGlzIGV0Yy4KPgo+ID4gICAgICAgICAvKiBmYWls
b3ZlciB3aGVuIFNUQU5EQlkgZmVhdHVyZSBlbmFibGVkICovCj4gPiAgICAgICAgIHN0cnVjdCBm
YWlsb3ZlciAqZmFpbG92ZXI7Cj4gPiAgfTsKPiA+IEBAIC0yOTc2LDYgKzI5NzgsMTUgQEAgc3Rh
dGljIGludCB2aXJ0bmV0X2dldF9waHlzX3BvcnRfbmFtZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
LCBjaGFyICpidWYsCj4gPgo+ID4gIHN0YXRpYyBpbnQgdmlydG5ldF9zZXRfZmVhdHVyZXMoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bmV0ZGV2X2ZlYXR1cmVzX3QgZmVhdHVyZXMpCj4gPiArewo+ID4gKyAgICAgICBzdHJ1Y3Qgdmly
dG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gPiArICAgICAgIHZpLT5mZWF0dXJl
cyA9IGZlYXR1cmVzOwo+ID4gKwo+ID4gKyAgICAgICByZXR1cm4gMDsKPiA+ICt9Cj4KPgo+IExv
b2tzIGxpa2UgdGhpcyBicmVha3MgY2hhbmdpbmcgZmVhdHVyZXMgYWZ0ZXIgaW5pdGlhbGl6YXRp
b24gLQo+IHRoZXNlIHdpbGwgbmV2ZXIgYmUgcHJvcGFnYXRlZCB0byBoYXJkd2FyZSBub3cuCgpZ
ZXMsIEkgdGhpbmsgd2UgbmVlZCB0byBoYXZlIGEgY2hlY2sgYW5kIG9ubHkgZGVmZXIgdGhlIHNl
dHRpbmcgd2hlbgp2aXJ0aW8gZGV2aWNlIGlzIG5vdCByZWFkeS4KClRoYW5rcwoKPgo+ID4gKwo+
ID4gK3N0YXRpYyBpbnQgdmlydG5ldF9zZXRfZmVhdHVyZXNfZGVmZXJyZWQoc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmV0ZGV2X2Zl
YXR1cmVzX3QgZmVhdHVyZXMpCj4gPiAgewo+ID4gICAgICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZv
ICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gPiAgICAgICAgIHU2NCBvZmZsb2FkczsKPiA+IEBA
IC0zNjQ0LDYgKzM2NTUsMTMgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2KQo+ID4KPiA+ICAgICAgICAgdmlydGlvX2RldmljZV9yZWFkeSh2ZGV2
KTsKPiA+Cj4gPiArICAgICAgIC8qIERlZmVycmVkIGZlYXR1cmUgc2V0IGFmdGVyIGRldmljZSBy
ZWFkeSAqLwo+ID4gKyAgICAgICBlcnIgPSB2aXJ0bmV0X3NldF9mZWF0dXJlc19kZWZlcnJlZChk
ZXYsIHZpLT5mZWF0dXJlcyk7Cj4KPgo+IEl0IHNlZW1zIHRoYXQgaWYgdGhpcyBpcyBjYWxsZWQg
ZS5nLiBmb3IgYSBkZXZpY2Ugd2l0aG91dCBhIENWUSBhbmQKPiB0aGVyZSBhcmUgdGhpbmdzIHRo
YXQgYWN0dWFsbHkgbmVlZCB0byBjaGFuZ2UgdGhlbiBpdCB3aWxsIEJVR19PTi4KPgo+Cj4gPiAr
ICAgICAgIGlmIChlcnIpIHsKPiA+ICsgICAgICAgICAgICAgICBwcl9kZWJ1ZygidmlydGlvX25l
dDogc2V0IGZlYXR1cmVzIGZhaWxlZFxuIik7Cj4gPiArICAgICAgICAgICAgICAgZ290byBmcmVl
X3VucmVnaXN0ZXJfbmV0ZGV2Owo+ID4gKyAgICAgICB9Cj4gPiArCj4gPiAgICAgICAgIGVyciA9
IHZpcnRuZXRfY3B1X25vdGlmX2FkZCh2aSk7Cj4gPiAgICAgICAgIGlmIChlcnIpIHsKPiA+ICAg
ICAgICAgICAgICAgICBwcl9kZWJ1ZygidmlydGlvX25ldDogcmVnaXN0ZXJpbmcgY3B1IG5vdGlm
aWVyIGZhaWxlZFxuIik7Cj4gPgo+Cj4gLS0KPiBNU1QKPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
