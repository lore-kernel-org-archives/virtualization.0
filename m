Return-Path: <SRS0=vACO=LP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17870C48BE5
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 06:21:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3426101D
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 06:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3426101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C9C982ECF;
	Mon, 21 Jun 2021 06:21:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lpqIk9AIt8ag; Mon, 21 Jun 2021 06:21:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 42BFE82EB4;
	Mon, 21 Jun 2021 06:21:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1273EC000E;
	Mon, 21 Jun 2021 06:21:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F093C000C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 06:21:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7028082EB5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 06:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9MM4nqVDQrAq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 06:21:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EC7382EB4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 06:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624256487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCe0XqT7hlnzVykEXgQZZ3co5Ktu3F1QMr/REXMNOgY=;
 b=i69JJff6apgf6Dr1RBxCEj3y1aP9Z7+IxN3UAxGnKih4hcBy6xhoXh4j5IjXvQjb+czr0r
 ypzj1eY3hb2rJy1kQ3g1LtbeikBvzZ2uT5oOpfw7ZbGj2WedaYod1nGiVW+XbpZEOHxlQJ
 6JFexDFXkUvr7m9aDatfWTSOPzolZ0k=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-r-7qExHKPZeFapDXAbmpUA-1; Mon, 21 Jun 2021 02:21:23 -0400
X-MC-Unique: r-7qExHKPZeFapDXAbmpUA-1
Received: by mail-pg1-f197.google.com with SMTP id
 i8-20020a633c480000b0290223167334a7so6130949pgn.19
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Jun 2021 23:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=eCe0XqT7hlnzVykEXgQZZ3co5Ktu3F1QMr/REXMNOgY=;
 b=I4ewSbHtDQhu9HbXG/aswyIHb2Zwm2XSsAFmOXW5oWoer5Dzcl7cbYycg0iUYJygNy
 0hr9i3BIkM+fG6F9cNyumhoIEs/h9hgpmQnV1fNDynRck84CbJoRVtha8Qx5AirUN+YM
 TKlJ2j8AwYsX7OS9gLo/lROVHi+posE6GHvShrNKvF/JEXRXwsVaCBE3qv6QgcOuKv27
 e4CEzyCx1cXpVRE1n8MAoaVA8VjJuFX0HT1dBG9E6NqjzceegxPTteUvZgXet2HH4vsI
 pT47mzs7klam7Xb+5KRRnWlsqCB3sBUnxzzo2px1j/GdC60qDF0SOjpjqYpPOCuwFpIC
 iq6w==
X-Gm-Message-State: AOAM533/Bji5WLznE0/w68rttfY735CdF83EP7I5KSHQcSJLCLa+MdPo
 58AcnqjT/DxoIboGWNozR9Q+yUKptw0c3PgUYou34aSTd4uSX/r4HbhycE+fmy2whOvLxGr3jN1
 Y4RObyTjm1U/lr6YIzCQkqWKIhWtVUPVIRkhGouqvow==
X-Received: by 2002:a17:902:aa8d:b029:11a:9225:3ea with SMTP id
 d13-20020a170902aa8db029011a922503eamr16511416plr.49.1624256482767; 
 Sun, 20 Jun 2021 23:21:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJeu9sPwDlIU9dv9ukuvBcRNyJ/YNl903d3lts/alsUMOf5sU5/MEufbhvdpGykP1ZvZWlSQ==
X-Received: by 2002:a17:902:aa8d:b029:11a:9225:3ea with SMTP id
 d13-20020a170902aa8db029011a922503eamr16511400plr.49.1624256482597; 
 Sun, 20 Jun 2021 23:21:22 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j8sm7324717pfu.60.2021.06.20.23.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Jun 2021 23:21:22 -0700 (PDT)
Subject: Re: [PATCH] virtio_net: Enable MSI-X vector for ctrl queue
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Keiichi Watanabe <keiichiw@chromium.org>
References: <20210618072625.957837-1-keiichiw@chromium.org>
 <20210618083650-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0933f13d-b52e-321e-4be1-1b0e3cfb346b@redhat.com>
Date: Mon, 21 Jun 2021 14:21:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618083650-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: chirantan@chromium.org, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
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

CtTaIDIwMjEvNi8xOCDPws7nODozOCwgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gT24gRnJp
LCBKdW4gMTgsIDIwMjEgYXQgMDQ6MjY6MjVQTSArMDkwMCwgS2VpaWNoaSBXYXRhbmFiZSB3cm90
ZToKPj4gV2hlbiB3ZSB1c2Ugdmhvc3QtdXNlciBiYWNrZW5kIG9uIHRoZSBob3N0LCBNU0ktWCB2
ZWN0b3Igc2hvdWxkIGJlIHNldAo+PiBzbyB0aGF0IHRoZSB2bW0gY2FuIGdldCBhbiBpcnEgRkQg
YW5kIHNlbmQgaXQgdG8gdGhlIGJhY2tlbmQgZGV2aWNlCj4+IHByb2Nlc3Mgd2l0aCB2aG9zdC11
c2VyIHByb3RvY29sLgo+PiBTaW5jZSB3aGV0aGVyIHRoZSB2ZWN0b3IgaXMgc2V0IGZvciBhIHF1
ZXVlIGlzIGRldGVybWluZWQgZGVwZW5kaW5nIG9uCj4+IHRoZSBxdWV1ZSBoYXMgYSBjYWxsYmFj
aywgdGhpcyBjb21taXQgc2V0cyBhbiBlbXB0eSBjYWxsYmFjayBmb3IKPj4gdmlydGlvLW5ldCdz
IGNvbnRyb2wgcXVldWUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEtlaWljaGkgV2F0YW5hYmUgPGtl
aWljaGl3QGNocm9taXVtLm9yZz4KPiBJJ20gY29uZnVzZWQgYnkgdGhpcyBleHBsYW5hdGlvbi4g
SWYgdGhlIHZtbSB3YW50cyB0byBnZXQKPiBhbiBpbnRlcnJ1cHQgaXQgY2FuIGRvIHNvIC0gd2h5
IGNoYW5nZSB0aGUgZ3Vlc3QgZHJpdmVyPwoKCisxLCBpdCBzb3VuZHMgbGlrZSBhIGJ1ZyBpbiB0
aGUgYmFja2VuZCBvciB3ZSBwcm9iYWJseSBuZWVkIG1vcmUgY29udGV4dCAKaGVyZS4KClRoYW5r
cwoKCj4KPj4gLS0tCj4+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNyArKysrKystCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4+IGluZGV4IDExZjcyMjQ2MDUxMy4uMDAyZTM2OTVkNGIzIDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4+IEBAIC0yNjk2LDYgKzI2OTYsMTEgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9kZWxfdnFz
KHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+PiAgIAl2aXJ0bmV0X2ZyZWVfcXVldWVzKHZpKTsK
Pj4gICB9Cj4+ICAgCj4+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X2N0cmxxX2RvbmUoc3RydWN0IHZp
cnRxdWV1ZSAqcnZxKQo+PiArewo+PiArCS8qIERvIG5vdGhpbmcgKi8KPj4gK30KPj4gKwo+PiAg
IC8qIEhvdyBsYXJnZSBzaG91bGQgYSBzaW5nbGUgYnVmZmVyIGJlIHNvIGEgcXVldWUgZnVsbCBv
ZiB0aGVzZSBjYW4gZml0IGF0Cj4+ICAgICogbGVhc3Qgb25lIGZ1bGwgcGFja2V0Pwo+PiAgICAq
IExvZ2ljIGJlbG93IGFzc3VtZXMgdGhlIG1lcmdlYWJsZSBidWZmZXIgaGVhZGVyIGlzIHVzZWQu
Cj4+IEBAIC0yNzQ4LDcgKzI3NTMsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfZmluZF92cXMoc3Ry
dWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4+ICAgCj4+ICAgCS8qIFBhcmFtZXRlcnMgZm9yIGNvbnRy
b2wgdmlydHF1ZXVlLCBpZiBhbnkgKi8KPj4gICAJaWYgKHZpLT5oYXNfY3ZxKSB7Cj4+IC0JCWNh
bGxiYWNrc1t0b3RhbF92cXMgLSAxXSA9IE5VTEw7Cj4+ICsJCWNhbGxiYWNrc1t0b3RhbF92cXMg
LSAxXSA9IHZpcnRuZXRfY3RybHFfZG9uZTsKPj4gICAJCW5hbWVzW3RvdGFsX3ZxcyAtIDFdID0g
ImNvbnRyb2wiOwo+PiAgIAl9Cj4+ICAgCj4+IC0tIAo+PiAyLjMyLjAuMjg4Lmc2MmE4ZDIyNGU2
LWdvb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
