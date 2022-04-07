Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BF0C433EF
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 06:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02CEB408E3;
	Thu,  7 Apr 2022 06:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KC4sJPX3c3So; Thu,  7 Apr 2022 06:25:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3396540529;
	Thu,  7 Apr 2022 06:25:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02A03C002C;
	Thu,  7 Apr 2022 06:25:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2B30C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D70AC83E06
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 43SxOKcbYr6y
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:25:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21F6083DB7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649312751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLlHrE4/3Q5dXoiIyxRCC0oUmaF9F+xq6LvaySDB8mM=;
 b=CbRgjWtzmMFEodKY241pi2fUvf6ueaZYQMUabYe8mP8Ln7zovRemtbxfj6IYe7Wqr2Ttit
 q/Q79Aq+xiQiU2P186yHkGCsQhESraYzq/Wt6OzEjClIUHn3B7+mZp9SQfso9pEIncvaO3
 4ViTWSGf3W6tSkXdEQEA/B9StV5f7iA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-jrOp-zg5OrSn3vcefJgVxg-1; Thu, 07 Apr 2022 02:25:50 -0400
X-MC-Unique: jrOp-zg5OrSn3vcefJgVxg-1
Received: by mail-pf1-f198.google.com with SMTP id
 h131-20020a628389000000b005056723a9dcso604506pfe.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 23:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=BLlHrE4/3Q5dXoiIyxRCC0oUmaF9F+xq6LvaySDB8mM=;
 b=HHD7XcEEesjAF+ny395E68pTIw5m49D9bi9GZnTFe9DZbpcZI/E4uh41H0no7uS0Ka
 6Hif1lxzQrzTokmezb9YOUrBpe87Rt8FjuHx7z+kSzh79/2MLn8jToOlWqIlWwHqywWb
 TFhrIs5LzgRYdSCa1AIk6yNiOuwt+TEXpKflw/nDkMo56mpTcWYfx8X/rVqUX0tE3dOD
 EVfsNDE1G/RLsc/UxewqfAG/ZAkK5y1lii1waMB65vxswMMNZu6xbDn0LLxqF6xBWPQ2
 Mh/Zi5EbGqJwXxzGaoH9FcZ2yk6/njwzIsfwnurDYsiMIUl6mZV+S/Flw5sQnmlN8e2a
 t23Q==
X-Gm-Message-State: AOAM533bbVkBQoR4sErBM5mc2kBSfppgsLf2HM2Vu3ppTpcb9Mlf909n
 qgShS7ojFTZcZ7NBP4ggfuvdxJ3DkQm7KCmxWsr2Kq96UlmyQ3ClKvvd+aBTWITnKLaSLLDTnKL
 DUH1ENiNqhxoPLrlg1Vd46zab4mXESptuqpozZ9Va3Q==
X-Received: by 2002:a63:150c:0:b0:39c:c255:27c1 with SMTP id
 v12-20020a63150c000000b0039cc25527c1mr2456713pgl.293.1649312749689; 
 Wed, 06 Apr 2022 23:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7Urc0kd92WlKyjtKSL1EBQ8HS2giXe/92fnhicU5/VPPQiUq4Uydc1QmX44+8VB5bkRQFGQ==
X-Received: by 2002:a63:150c:0:b0:39c:c255:27c1 with SMTP id
 v12-20020a63150c000000b0039cc25527c1mr2456702pgl.293.1649312749437; 
 Wed, 06 Apr 2022 23:25:49 -0700 (PDT)
Received: from [10.72.13.105] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a637a56000000b003984be1f515sm17860519pgn.69.2022.04.06.23.25.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Apr 2022 23:25:48 -0700 (PDT)
Message-ID: <53831b99-6c63-7ca9-9b95-bc3f8c5e015c@redhat.com>
Date: Thu, 7 Apr 2022 14:25:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH V2 3/5] virtio: introduce config op to synchronize vring
 callbacks
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-4-jasowang@redhat.com>
 <20220406075405-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406075405-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de
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

CuWcqCAyMDIyLzQvNiDkuIvljYg3OjU5LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IE9u
IFdlZCwgQXByIDA2LCAyMDIyIGF0IDA0OjM1OjM2UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlCj4gaW50cm9kdWNlcwo+Cj4+IGEgbmV3Cj4gbmV3Cj4K
Pj4gdmlydGlvIGNvbmZpZyBvcHMgdG8gdnJpbmcKPj4gY2FsbGJhY2tzLiBUcmFuc3BvcnQgc3Bl
Y2lmaWMgbWV0aG9kIGlzIHJlcXVpcmVkIHRvIGNhbGwKPj4gc3luY2hvcm5pemVfaXJxKCkgb24g
dGhlIElSUXMuIEZvciB0aGUgdHJhbnNwb3J0IHRoYXQgZG9lc24ndCBwcm92aWRlCj4+IHN5bmNo
cm9uaXplX3ZxcygpLCB1c2Ugc3luY2hvcm5pemVfcmN1KCkgYXMgYSBmYWxsYmFjay4KPj4KPj4g
Q2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+PiBDYzogUGV0ZXIgWmlq
bHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPgo+PiBDYzogIlBhdWwgRS4gTWNLZW5uZXkiIDxw
YXVsbWNrQGtlcm5lbC5vcmc+Cj4+IENjOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPgo+
PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiAtLS0K
Pj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaCB8IDE2ICsrKysrKysrKysrKysrKysK
Pj4gICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25m
aWcuaAo+PiBpbmRleCBiMzQxZGQ2MmFhNGQuLjA4YjczZDliYmZmMiAxMDA2NDQKPj4gLS0tIGEv
aW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0
aW9fY29uZmlnLmgKPj4gQEAgLTU3LDYgKzU3LDggQEAgc3RydWN0IHZpcnRpb19zaG1fcmVnaW9u
IHsKPj4gICAgKgkJaW5jbHVkZSBhIE5VTEwgZW50cnkgZm9yIHZxcyB1bnVzZWQgYnkgZHJpdmVy
Cj4+ICAgICoJUmV0dXJucyAwIG9uIHN1Y2Nlc3Mgb3IgZXJyb3Igc3RhdHVzCj4+ICAgICogQGRl
bF92cXM6IGZyZWUgdmlydHF1ZXVlcyBmb3VuZCBieSBmaW5kX3ZxcygpLgo+PiArICogQHN5bmNo
cm9uaXplX3Zxczogc3luY2hyb25pemUgd2l0aCB0aGUgdmlydHF1ZXVlIGNhbGxiYWNrcy4KPj4g
KyAqCXZkZXY6IHRoZSB2aXJ0aW9fZGV2aWNlCj4gSSB0aGluayBJIHByZWZlciBzeW5jaHJvbml6
ZV9jYWxsYmFja3MKCgpPaywgSSB3aWxsIHJlbmFtZSBpdC4KCgo+Cj4+ICAgICogQGdldF9mZWF0
dXJlczogZ2V0IHRoZSBhcnJheSBvZiBmZWF0dXJlIGJpdHMgZm9yIHRoaXMgZGV2aWNlLgo+PiAg
ICAqCXZkZXY6IHRoZSB2aXJ0aW9fZGV2aWNlCj4+ICAgICoJUmV0dXJucyB0aGUgZmlyc3QgNjQg
ZmVhdHVyZSBiaXRzIChhbGwgd2UgY3VycmVudGx5IG5lZWQpLgo+PiBAQCAtODksNiArOTEsNyBA
QCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgewo+PiAgIAkJCWNvbnN0IGNoYXIgKiBjb25zdCBu
YW1lc1tdLCBjb25zdCBib29sICpjdHgsCj4+ICAgCQkJc3RydWN0IGlycV9hZmZpbml0eSAqZGVz
Yyk7Cj4+ICAgCXZvaWQgKCpkZWxfdnFzKShzdHJ1Y3QgdmlydGlvX2RldmljZSAqKTsKPj4gKwl2
b2lkICgqc3luY2hyb25pemVfdnFzKShzdHJ1Y3QgdmlydGlvX2RldmljZSAqKTsKPj4gICAJdTY0
ICgqZ2V0X2ZlYXR1cmVzKShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldik7Cj4+ICAgCWludCAo
KmZpbmFsaXplX2ZlYXR1cmVzKShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldik7Cj4+ICAgCWNv
bnN0IGNoYXIgKigqYnVzX25hbWUpKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KTsKPj4gQEAg
LTIxNyw2ICsyMjAsMTkgQEAgaW50IHZpcnRpb19maW5kX3Zxc19jdHgoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYsIHVuc2lnbmVkIG52cXMsCj4+ICAgCQkJCSAgICAgIGRlc2MpOwo+PiAgIH0K
Pj4gICAKPj4gKy8qKgo+PiArICogdmlydGlvX3N5bmNocm9uaXplX3ZxcyAtIHN5bmNocm9uaXpl
IHdpdGggdmlydHF1ZXVlIGNhbGxiYWNrcwo+PiArICogQHZkZXY6IHRoZSBkZXZpY2UKPj4gKyAq
Lwo+PiArc3RhdGljIGlubGluZQo+PiArdm9pZCB2aXJ0aW9fc3luY2hyb25pemVfdnFzKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICpkZXYpCj4+ICt7Cj4+ICsJaWYgKGRldi0+Y29uZmlnLT5zeW5jaHJv
bml6ZV92cXMpCj4+ICsJCWRldi0+Y29uZmlnLT5zeW5jaHJvbml6ZV92cXMoZGV2KTsKPj4gKwll
bHNlCj4+ICsJCXN5bmNocm9uaXplX3JjdSgpOwo+IEkgYW0gbm90IHN1cmUgYWJvdXQgdGhpcyBm
YWxsYmFjayBhbmQgdGhlIGxhdGVuY3kgaW1wYWN0LgoKClVubGVzcyBlYWNoIHRyYW5zcG9ydCBj
YW4gaW1wbGVtZW50IHRoZWlyIG93biBzeW5jaHJvbml6YXRpb24gcm91dGluZSwgCndlIG5lZWQg
c29tZXRoaW5nIHRoYXQgY2FuIGRvIGJlc3QgZWZmb3J0IGFzIGZhbGxiYWNrIGhlcmUuCgoKPiBN
YXliZSBzeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkIGlzIGJldHRlciBoZXJlLgoKCk5vdCBzdXJl
LCBpdCBtaWdodCBsZWFkIElQSXMgYW5kIGFjY29yZGluZyB0byB0aGUgCkRvY3VtZW50YXRpb24v
UkNVL2NoZWNrbGlzdC5yc3Q6CgoKIiIiCgogwqDCoMKgwqDCoMKgwqAgVGhlIGV4cGVkaXRlZCBm
b3JtcyBvZiB0aGVzZSBwcmltaXRpdmVzIGhhdmUgdGhlIHNhbWUgc2VtYW50aWNzCiDCoMKgwqDC
oMKgwqDCoCBhcyB0aGUgbm9uLWV4cGVkaXRlZCBmb3JtcywgYnV0IGV4cGVkaXRpbmcgaXMgYm90
aCBleHBlbnNpdmUgYW5kCiDCoMKgwqDCoMKgwqDCoCAod2l0aCB0aGUgZXhjZXB0aW9uIG9mIHN5
bmNocm9uaXplX3NyY3VfZXhwZWRpdGVkKCkpIHVuZnJpZW5kbHkKIMKgwqDCoMKgwqDCoMKgIHRv
IHJlYWwtdGltZSB3b3JrbG9hZHMuwqAgVXNlIG9mIHRoZSBleHBlZGl0ZWQgcHJpbWl0aXZlcyBz
aG91bGQKIMKgwqDCoMKgwqDCoMKgIGJlIHJlc3RyaWN0ZWQgdG8gcmFyZSBjb25maWd1cmF0aW9u
LWNoYW5nZSBvcGVyYXRpb25zIHRoYXQgd291bGQKIMKgwqDCoMKgwqDCoMKgIG5vdCBub3JtYWxs
eSBiZSB1bmRlcnRha2VuIHdoaWxlIGEgcmVhbC10aW1lIHdvcmtsb2FkIGlzIHJ1bm5pbmcuCiDC
oMKgwqDCoMKgwqDCoCBIb3dldmVyLCByZWFsLXRpbWUgd29ya2xvYWRzIGNhbiB1c2UgcmN1cGRh
dGUucmN1X25vcm1hbCBrZXJuZWwKIMKgwqDCoMKgwqDCoMKgIGJvb3QgcGFyYW1ldGVyIHRvIGNv
bXBsZXRlbHkgZGlzYWJsZSBleHBlZGl0ZWQgZ3JhY2UgcGVyaW9kcywKIMKgwqDCoMKgwqDCoMKg
IHRob3VnaCB0aGlzIG1pZ2h0IGhhdmUgcGVyZm9ybWFuY2UgaW1wbGljYXRpb25zLgoKIiIiCgpJ
dCB3aWxsIGJlIGV4cGVuc2l2ZSBmb3IgcmVhbCB0aW1lIHdvcmtsb2Fkcy4KClRoYW5rcwoKCj4K
Pj4gK30KPj4gKwo+PiAgIC8qKgo+PiAgICAqIHZpcnRpb19kZXZpY2VfcmVhZHkgLSBlbmFibGUg
dnEgdXNlIGluIHByb2JlIGZ1bmN0aW9uCj4+ICAgICogQHZkZXY6IHRoZSBkZXZpY2UKPj4gLS0g
Cj4+IDIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
