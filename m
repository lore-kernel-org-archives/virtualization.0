Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B67C7618D
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 08:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8094960F1A;
	Thu, 16 Mar 2023 08:31:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8094960F1A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IYJprkW1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 59b6am-Tb9we; Thu, 16 Mar 2023 08:31:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EFF0C60B89;
	Thu, 16 Mar 2023 08:31:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFF0C60B89
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3E1EC0071;
	Thu, 16 Mar 2023 08:31:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFC3DC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B64E660F1A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:31:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B64E660F1A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lDA7VVjlOMFQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:31:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E81CF60B89
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E81CF60B89
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678955488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X/1UEGyWZZrbvStEgLaSVShuWDRxe0yPRa+3kY6NxaI=;
 b=IYJprkW1OtGCrEF2tI/Z48yXTIZTz1RV8Ys1KgziE+F6Spy8wYk5KyvU/G00TEf+LSxOi6
 EoDiEYpSUsvIZji2VjKObgxeUmt9QR+Q1/ZPsz8OW5VoMTSCT0uTuP0Yg9mLypM4BGZWSR
 urjd+943k1XIGiGc1s8dDiFSomMDxc4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-bUDq5XyLMOGIjGdZjksleQ-1; Thu, 16 Mar 2023 04:31:27 -0400
X-MC-Unique: bUDq5XyLMOGIjGdZjksleQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 i25-20020adfaad9000000b002cff37de14fso119623wrc.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 01:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678955486;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X/1UEGyWZZrbvStEgLaSVShuWDRxe0yPRa+3kY6NxaI=;
 b=UjCLYV5yz2xr6UKnEJ7xidkrsrgGvqm7N05q9VFRWXk8+9IqlYNn3SrO4wodtKShcF
 fW8UslhrYWonqLe33m1PqKSP9W/bp8qBeLz4ZMNWwjb/49ogWtcfG+9orgydIMu5Svdu
 ZimA7L12+k2ZaLq2zCsXNA4lAJu4SohZfMRHqH3bundgy5NQwtdykKKAUYkrLisEZhim
 ZFXlNWbAZUFAC3anYhQU3R3XE1qBMoMGFkp90sdOn5mUyJ44kMo27jlckwEVE+DCq6HK
 IXbx4av4RWVkRxSaSh9HnHoepNKald7KlwhVQpf4bo6gWir1YGfNS3QEnQQ4kiZZNLFr
 nInA==
X-Gm-Message-State: AO0yUKUzAK/Zc9HBd2srTrRje+6BMjV+Hot77PdcUzTQh1yFkvjf6I8g
 DGn+XUxKrE+Qito/xHjTqSlS49NyCWTEoVmY0IDwn1/VBLqKMJ1rxy/n40OdlEoc0B7cJTp3BYX
 IKKRE9a86j6vz7QXe7QIXfuE21M4Tfp8wjQYW4taWlw==
X-Received: by 2002:a5d:5955:0:b0:2cf:e29f:d7f5 with SMTP id
 e21-20020a5d5955000000b002cfe29fd7f5mr3576308wri.25.1678955486053; 
 Thu, 16 Mar 2023 01:31:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set8XgT/fkEa6oyHpuwgit2NX40Fpv+7C8AxfojZlS6SqwfkBRFQgzp3vx+Buq6H4mrLWafU74w==
X-Received: by 2002:a5d:5955:0:b0:2cf:e29f:d7f5 with SMTP id
 e21-20020a5d5955000000b002cfe29fd7f5mr3576292wri.25.1678955485799; 
 Thu, 16 Mar 2023 01:31:25 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 c10-20020adffb0a000000b002d1bfe3269esm1518738wrr.59.2023.03.16.01.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Mar 2023 01:31:25 -0700 (PDT)
Date: Thu, 16 Mar 2023 09:31:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/8] vhost-vdpa: use bind_mm/unbind_mm device callbacks
Message-ID: <20230316083122.hliiktgsymrfpozy@sgarzare-redhat>
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-3-sgarzare@redhat.com>
 <CACGkMEttgd82xOxV8WLdSFdfhRLZn68tSaV4APSDh8qXxf4OEw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEttgd82xOxV8WLdSFdfhRLZn68tSaV4APSDh8qXxf4OEw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVHVlLCBNYXIgMTQsIDIwMjMgYXQgMTE6NDg6MzNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPk9uIFRodSwgTWFyIDIsIDIwMjMgYXQgNzozNOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8
c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IFdoZW4gdGhlIHVzZXIgY2FsbCBWSE9T
VF9TRVRfT1dORVIgaW9jdGwgYW5kIHRoZSB2RFBBIGRldmljZQo+PiBoYXMgYHVzZV92YWAgc2V0
IHRvIHRydWUsIGxldCdzIGNhbGwgdGhlIGJpbmRfbW0gY2FsbGJhY2suCj4+IEluIHRoaXMgd2F5
IHdlIGNhbiBiaW5kIHRoZSBkZXZpY2UgdG8gdGhlIHVzZXIgYWRkcmVzcyBzcGFjZQo+PiBhbmQg
ZGlyZWN0bHkgdXNlIHRoZSB1c2VyIFZBLgo+Pgo+PiBUaGUgdW5iaW5kX21tIGNhbGxiYWNrIGlz
IGNhbGxlZCBkdXJpbmcgdGhlIHJlbGVhc2UgYWZ0ZXIKPj4gc3RvcHBpbmcgdGhlIGRldmljZS4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQu
Y29tPgo+PiAtLS0KPj4KPj4gTm90ZXM6Cj4+ICAgICB2MjoKPj4gICAgIC0gY2FsbCB0aGUgbmV3
IHVuYmluZF9tbSBjYWxsYmFjayBkdXJpbmcgdGhlIHJlbGVhc2UgW0phc29uXQo+PiAgICAgLSBh
dm9pZCB0byBjYWxsIGJpbmRfbW0gY2FsbGJhY2sgYWZ0ZXIgdGhlIHJlc2V0LCBzaW5jZSB0aGUg
ZGV2aWNlCj4+ICAgICAgIGlzIG5vdCBkZXRhY2hpbmcgaXQgbm93IGR1cmluZyB0aGUgcmVzZXQK
Pj4KPj4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiBpbmRl
eCBkYzEyZGJkNWI0M2IuLjFhYjg5ZmNjZDgyNSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aG9z
dC92ZHBhLmMKPj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gQEAgLTIxOSw2ICsyMTks
MjggQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Jlc2V0KHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+
PiAgICAgICAgIHJldHVybiB2ZHBhX3Jlc2V0KHZkcGEpOwo+PiAgfQo+Pgo+PiArc3RhdGljIGxv
bmcgdmhvc3RfdmRwYV9iaW5kX21tKHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+PiArewo+PiArICAg
ICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+ICsgICAgICAgY29uc3Qg
c3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+PiArCj4+ICsgICAg
ICAgaWYgKCF2ZHBhLT51c2VfdmEgfHwgIW9wcy0+YmluZF9tbSkKPj4gKyAgICAgICAgICAgICAg
IHJldHVybiAwOwo+PiArCj4+ICsgICAgICAgcmV0dXJuIG9wcy0+YmluZF9tbSh2ZHBhLCB2LT52
ZGV2Lm1tKTsKPj4gK30KPj4gKwo+PiArc3RhdGljIHZvaWQgdmhvc3RfdmRwYV91bmJpbmRfbW0o
c3RydWN0IHZob3N0X3ZkcGEgKnYpCj4+ICt7Cj4+ICsgICAgICAgc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhID0gdi0+dmRwYTsKPj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3Bz
ICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4+ICsKPj4gKyAgICAgICBpZiAoIXZkcGEtPnVzZV92YSB8
fCAhb3BzLT51bmJpbmRfbW0pCj4+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4+ICsKPj4gKyAg
ICAgICBvcHMtPnVuYmluZF9tbSh2ZHBhKTsKPj4gK30KPj4gKwo+PiAgc3RhdGljIGxvbmcgdmhv
c3RfdmRwYV9nZXRfZGV2aWNlX2lkKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKmFy
Z3ApCj4+ICB7Cj4+ICAgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsK
Pj4gQEAgLTcxMSw2ICs3MzMsMTMgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9p
b2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4+ICAgICAgICAgICAgICAgICBicmVhazsKPj4gICAg
ICAgICBkZWZhdWx0Ogo+PiAgICAgICAgICAgICAgICAgciA9IHZob3N0X2Rldl9pb2N0bCgmdi0+
dmRldiwgY21kLCBhcmdwKTsKPj4gKyAgICAgICAgICAgICAgIGlmICghciAmJiBjbWQgPT0gVkhP
U1RfU0VUX09XTkVSKSB7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHIgPSB2aG9zdF92ZHBh
X2JpbmRfbW0odik7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChyKSB7Cj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdmhvc3RfZGV2X3Jlc2V0X293bmVyKCZ2LT52ZGV2
LCBOVUxMKTsKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgfQo+PiArICAgICAgICAgICAgICAgfQo+Cj5OaXQ6IGlzIGl0
IGJldHRlciB0byBoYXZlIGEgbmV3IGNvbmRpdGlvbi9zd2l0Y2ggYnJhbmNoIGluc3RlYWQgb2YK
PnB1dHRpbmcgdGhlbSB1bmRlciBkZWZhdWx0PyAoYXMgd2hhdCB2cmluZ19pb2N0bCBkaWQpLgoK
WWVwLCBJIGFncmVlIQoKSSdsbCBjaGFuZ2UgaXQuCgpUaGFua3MsClN0ZWZhbm8KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
