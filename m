Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5492CC433F5
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 08:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E071A40361;
	Mon, 17 Jan 2022 08:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dhKWz6eBltea; Mon, 17 Jan 2022 08:26:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1695A40360;
	Mon, 17 Jan 2022 08:26:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D44B9C0031;
	Mon, 17 Jan 2022 08:26:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6741C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1A3380C2B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bmwJddN6yy7c
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:26:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 400FB80BDD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642407988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNQKbEtegSIWSosG5uGlKNCts0oURQOmirK/2YJ0xMQ=;
 b=iX1TAAZNjHMfP/vuRE5cWqb2e7Y2531l04a/QiaN04BYU7aeAjwuVa8T2SB588g8ftnvFU
 QMtXcRQZHc6I5864vE97a2LnV9Xekuzl5REkBieqlKwwoLnfCxT0McDBM9D+mfZnCbmuHY
 9/HQo4EKhqCDpg15sPmn+osJwhU+uks=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-xTyFcfccNWisVr2o2XyBqQ-1; Mon, 17 Jan 2022 03:26:26 -0500
X-MC-Unique: xTyFcfccNWisVr2o2XyBqQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 i81-20020a1c3b54000000b003467c58cbddso13397817wma.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 00:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=DNQKbEtegSIWSosG5uGlKNCts0oURQOmirK/2YJ0xMQ=;
 b=xDa11/AWKepAoNJxnBq6xhg7THn+nHWBSA4tttnf/C9dgciQ5Z/6x1eekApVrbWj7c
 sPt7aMGLKYU+LLGxtmsa4WJg7g3eERIFxGjXV/rcomAkWHUc/bv0Oi2pCxirU0JKZwQ8
 hK4/Z+CI2R6kv1mG3sg4wBmSofdh+CQ/MnfYiZ6LJNcZioXwgvtORwdaRR2ekZMU+sKn
 Dd822EooJzLcikH44723VEopYHncyS1ScA8a3IQ3/BuVn6p77T2GxHqRHdSLsiWKNTNv
 vRDj4wtbFRaZk1DceOz1WbQAryr6JD3bZa1Cp6ErWt6PjcfEYWpJB6B2Ja2izjvfhR4+
 723g==
X-Gm-Message-State: AOAM532/WvTEb4dHMbVlA4GacGWGB+z4uzOGXiQBmtLxIs6BP5ls4EWZ
 kxbOlFEpS9Cnich9Nbjfom2Gnk4NPsJm/bWZNPb8toNXJWK3yjFj3s6Qwpy1ZZvaOBfqe1DH5hw
 ePBSvelxiNmyrBoFOq8gONrorOMhS0Sp+omP2Tvk/Hw==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr26121317wmj.132.1642407985530; 
 Mon, 17 Jan 2022 00:26:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyGOrrGupepsSg3nWADHPX7L3TERLID7WqvxnbS25Vx07PFaNvht3nsEkdR5w3oAVH1VcL8g==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr26121303wmj.132.1642407985332; 
 Mon, 17 Jan 2022 00:26:25 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id p10sm1776322wrr.10.2022.01.17.00.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jan 2022 00:26:24 -0800 (PST)
Date: Mon, 17 Jan 2022 03:26:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: acknowledge all features before access
Message-ID: <20220117032429-mutt-send-email-mst@kernel.org>
References: <20220114200744.150325-1-mst@redhat.com>
 <d6c4e521-1538-bbbf-30e6-f658a095b3ae@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d6c4e521-1538-bbbf-30e6-f658a095b3ae@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBKYW4gMTcsIDIwMjIgYXQgMDI6MzE6NDlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMi8xLzE1IOS4iuWNiDQ6MDksIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnp
gZM6Cj4gPiBUaGUgZmVhdHVyZSBuZWdvdGlhdGlvbiB3YXMgZGVzaWduZWQgaW4gYSB3YXkgdGhh
dAo+ID4gbWFrZXMgaXQgcG9zc2libGUgZm9yIGRldmljZXMgdG8ga25vdyB3aGljaCBjb25maWcK
PiA+IGZpZWxkcyB3aWxsIGJlIGFjY2Vzc2VkIGJ5IGRyaXZlcnMuCj4gPiAKPiA+IFRoaXMgaXMg
YnJva2VuIHNpbmNlIGNvbW1pdCA0MDQxMjNjMmRiNzkgKCJ2aXJ0aW86IGFsbG93IGRyaXZlcnMg
dG8KPiA+IHZhbGlkYXRlIGZlYXR1cmVzIikgd2l0aCBmYWxsb3V0IGluIGF0IGxlYXN0IGJsb2Nr
IGFuZCBuZXQuCj4gPiBXZSBoYXZlIGEgcGFydGlhbCB3b3JrLWFyb3VuZCBpbiBjb21taXQgMmY5
YTE3NGY5MThlICgidmlydGlvOiB3cml0ZQo+ID4gYmFjayBGX1ZFUlNJT05fMSBiZWZvcmUgdmFs
aWRhdGUiKSB3aGljaCBhdCBsZWFzdCBsZXRzIGRldmljZXMKPiA+IGZpbmQgb3V0IHdoaWNoIGZv
cm1hdCBzaG91bGQgY29uZmlnIHNwYWNlIGhhdmUsIGJ1dCB0aGlzCj4gPiBpcyBhIHBhcnRpYWwg
Zml4OiBndWVzdHMgc2hvdWxkIG5vdCBhY2Nlc3MgY29uZmlnIHNwYWNlCj4gPiB3aXRob3V0IGFj
a25vd2xlZGdpbmcgZmVhdHVyZXMgc2luY2Ugb3RoZXJ3aXNlIHdlJ2xsIG5ldmVyCj4gPiBiZSBh
YmxlIHRvIGNoYW5nZSB0aGUgY29uZmlnIHNwYWNlIGZvcm1hdC4KPiA+IAo+ID4gQXMgYSBzaWRl
IGVmZmVjdCwgdGhpcyBhbHNvIHJlZHVjZXMgdGhlIGFtb3VudCBvZiBoeXBlcnZpc29yIGFjY2Vz
c2VzIC0KPiA+IHdlIG5vdyBvbmx5IGFja25vd2xlZGdlIGZlYXR1cmVzIG9uY2UgdW5sZXNzIHdl
IGFyZSBjbGVhcmluZyBhbnkKPiA+IGZlYXR1cmVzIHdoZW4gdmFsaWRhdGluZy4KPiA+IAo+ID4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiA+IEZpeGVzOiA0MDQxMjNjMmRiNzkgKCJ2aXJ0
aW86IGFsbG93IGRyaXZlcnMgdG8gdmFsaWRhdGUgZmVhdHVyZXMiKQo+ID4gRml4ZXM6IDJmOWEx
NzRmOTE4ZSAoInZpcnRpbzogd3JpdGUgYmFjayBGX1ZFUlNJT05fMSBiZWZvcmUgdmFsaWRhdGUi
KQo+ID4gQ2M6ICJIYWxpbCBQYXNpYyIgPHBhc2ljQGxpbnV4LmlibS5jb20+Cj4gPiBTaWduZWQt
b2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAK
PiA+IEhhbGlsLCBJIHRob3VnaHQgaGFyZCBhYm91dCBvdXIgc2l0dWF0aW9uIHdpdGggdHJhbnNp
dGlvbmFsIGFuZAo+ID4gdG9kYXkgSSBmaW5hbGx5IHRob3VnaHQgb2Ygc29tZXRoaW5nIEkgYW0g
aGFwcHkgd2l0aC4KPiA+IFBscyBsZXQgbWUga25vdyB3aGF0IHlvdSB0aGluay4gVGVzdGluZyBv
biBiaWcgZW5kaWFuIHdvdWxkCj4gPiBhbHNvIGJlIG11Y2ggYXBwcmVjaWF0ZWQhCj4gPiAKPiA+
ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvLmMgfCAzMSArKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlv
bnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpby5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvLmMKPiA+IGluZGV4IGQ4OTFiMGEzNTRiMC4uMmVkNmUyNDUxZmQ4
IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvLmMKPiA+ICsrKyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpby5jCj4gPiBAQCAtMTY4LDEyICsxNjgsMTAgQEAgRVhQT1JUX1NZTUJP
TF9HUEwodmlydGlvX2FkZF9zdGF0dXMpOwo+ID4gICBzdGF0aWMgaW50IHZpcnRpb19maW5hbGl6
ZV9mZWF0dXJlcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQo+ID4gICB7Cj4gPiAtCWludCBy
ZXQgPSBkZXYtPmNvbmZpZy0+ZmluYWxpemVfZmVhdHVyZXMoZGV2KTsKPiA+ICAgCXVuc2lnbmVk
IHN0YXR1czsKPiA+ICsJaW50IHJldDsKPiA+ICAgCW1pZ2h0X3NsZWVwKCk7Cj4gPiAtCWlmIChy
ZXQpCj4gPiAtCQlyZXR1cm4gcmV0Owo+ID4gICAJcmV0ID0gYXJjaF9oYXNfcmVzdHJpY3RlZF92
aXJ0aW9fbWVtb3J5X2FjY2VzcygpOwo+ID4gICAJaWYgKHJldCkgewo+ID4gQEAgLTI0NCwxNyAr
MjQyLDYgQEAgc3RhdGljIGludCB2aXJ0aW9fZGV2X3Byb2JlKHN0cnVjdCBkZXZpY2UgKl9kKQo+
ID4gICAJCWRyaXZlcl9mZWF0dXJlc19sZWdhY3kgPSBkcml2ZXJfZmVhdHVyZXM7Cj4gPiAgIAl9
Cj4gPiAtCS8qCj4gPiAtCSAqIFNvbWUgZGV2aWNlcyBkZXRlY3QgbGVnYWN5IHNvbGVseSB2aWEg
Rl9WRVJTSU9OXzEuIFdyaXRlCj4gPiAtCSAqIEZfVkVSU0lPTl8xIHRvIGZvcmNlIExFIGNvbmZp
ZyBzcGFjZSBhY2Nlc3NlcyBiZWZvcmUgRkVBVFVSRVNfT0sgZm9yCj4gPiAtCSAqIHRoZXNlIHdo
ZW4gbmVlZGVkLgo+ID4gLQkgKi8KPiA+IC0JaWYgKGRydi0+dmFsaWRhdGUgJiYgIXZpcnRpb19s
ZWdhY3lfaXNfbGl0dGxlX2VuZGlhbigpCj4gPiAtCQkJICAmJiBkZXZpY2VfZmVhdHVyZXMgJiBC
SVRfVUxMKFZJUlRJT19GX1ZFUlNJT05fMSkpIHsKPiA+IC0JCWRldi0+ZmVhdHVyZXMgPSBCSVRf
VUxMKFZJUlRJT19GX1ZFUlNJT05fMSk7Cj4gPiAtCQlkZXYtPmNvbmZpZy0+ZmluYWxpemVfZmVh
dHVyZXMoZGV2KTsKPiA+IC0JfQo+ID4gLQo+ID4gICAJaWYgKGRldmljZV9mZWF0dXJlcyAmICgx
VUxMIDw8IFZJUlRJT19GX1ZFUlNJT05fMSkpCj4gPiAgIAkJZGV2LT5mZWF0dXJlcyA9IGRyaXZl
cl9mZWF0dXJlcyAmIGRldmljZV9mZWF0dXJlczsKPiA+ICAgCWVsc2UKPiA+IEBAIC0yNjUsMTAg
KzI1MiwyMiBAQCBzdGF0aWMgaW50IHZpcnRpb19kZXZfcHJvYmUoc3RydWN0IGRldmljZSAqX2Qp
Cj4gPiAgIAkJaWYgKGRldmljZV9mZWF0dXJlcyAmICgxVUxMIDw8IGkpKQo+ID4gICAJCQlfX3Zp
cnRpb19zZXRfYml0KGRldiwgaSk7Cj4gPiArCWVyciA9IGRldi0+Y29uZmlnLT5maW5hbGl6ZV9m
ZWF0dXJlcyhkZXYpOwo+ID4gKwlpZiAoZXJyKQo+ID4gKwkJZ290byBlcnI7Cj4gPiArCj4gPiAg
IAlpZiAoZHJ2LT52YWxpZGF0ZSkgewo+ID4gKwkJdTY0IGZlYXR1cmVzID0gZGV2LT5mZWF0dXJl
czsKPiA+ICsKPiA+ICAgCQllcnIgPSBkcnYtPnZhbGlkYXRlKGRldik7Cj4gPiAgIAkJaWYgKGVy
cikKPiA+ICAgCQkJZ290byBlcnI7Cj4gPiArCj4gPiArCQlpZiAoZmVhdHVyZXMgIT0gZGV2LT5m
ZWF0dXJlcykgewo+ID4gKwkJCWVyciA9IGRldi0+Y29uZmlnLT5maW5hbGl6ZV9mZWF0dXJlcyhk
ZXYpOwo+ID4gKwkJCWlmIChlcnIpCj4gPiArCQkJCWdvdG8gZXJyOwo+ID4gKwkJfQo+ID4gICAJ
fQo+ID4gICAJZXJyID0gdmlydGlvX2ZpbmFsaXplX2ZlYXR1cmVzKGRldik7Cj4gPiBAQCAtNDk1
LDYgKzQ5NCwxMCBAQCBpbnQgdmlydGlvX2RldmljZV9yZXN0b3JlKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICpkZXYpCj4gPiAgIAkvKiBXZSBoYXZlIGEgZHJpdmVyISAqLwo+ID4gICAJdmlydGlvX2Fk
ZF9zdGF0dXMoZGV2LCBWSVJUSU9fQ09ORklHX1NfRFJJVkVSKTsKPiA+ICsJcmV0ID0gZGV2LT5j
b25maWctPmZpbmFsaXplX2ZlYXR1cmVzKGRldik7Cj4gPiArCWlmIChyZXQpCj4gPiArCQlnb3Rv
IGVycjsKPiAKPiAKPiBJcyB0aGlzIHBhcnQgb2YgY29kZSByZWxhdGVkPwo+IAo+IFRoYW5rcwo+
IAoKWWVzLiB2aXJ0aW9fZmluYWxpemVfZmVhdHVyZXMgbm8gbG9uZ2VyIGNhbGxzIGRldi0+Y29u
ZmlnLT5maW5hbGl6ZV9mZWF0dXJlcy4KCkkgdGhpbmsgdGhlIGRldi0+Y29uZmlnLT5maW5hbGl6
ZV9mZWF0dXJlcyBjYWxsYmFjayBpcyBhY3R1YWxseQphIG1pc25vbWVyIG5vdywgaXQganVzdCBz
ZW5kcyB0aGUgZmVhdHVyZXMgdG8gZGV2aWNlLApmaW5hbGl6ZSBpcyBGRUFUVVJFU19PSy4gUmVu
YW1pbmcgdGhhdCBpcyBhIGJpZ2dlcgpwYXRjaCB0aG91Z2gsIGFuZCBJJ2QgbGlrZSB0aGlzIG9u
ZSB0byBiZSBjaGVycnktcGlja2FibGUKdG8gc3RhYmxlLgoKPiA+ICsKPiA+ICAgCXJldCA9IHZp
cnRpb19maW5hbGl6ZV9mZWF0dXJlcyhkZXYpOwo+ID4gICAJaWYgKHJldCkKPiA+ICAgCQlnb3Rv
IGVycjsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
