Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59773EB64DD
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 02:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E40F260BF5;
	Tue,  8 Aug 2023 02:31:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E40F260BF5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H7KwxRMb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AQ32hlzAwlop; Tue,  8 Aug 2023 02:31:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4972660BC5;
	Tue,  8 Aug 2023 02:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4972660BC5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB0DC0071;
	Tue,  8 Aug 2023 02:31:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6C3FC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 979AF81EB3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:31:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 979AF81EB3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H7KwxRMb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TDs8Ap_OERFO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:31:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23FE681EB2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:31:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23FE681EB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691461871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LeABWAIqA3NR/jSM0/v+3WWsrOAd6qgiAGCX11jVSJU=;
 b=H7KwxRMbTsv7yjfgkx0gHA2zIrBdxWIKXVPVJ9q2lT4xxU5PmaEPEDQtoSYjafYC4NV8c/
 4IYm7qwMcmjuDPkAWlW3+bcI328yJ/h3ULwWRDneIiVDj4zca0EEvEp8q+sh0BLkBsnlUA
 8mUaVB4EMAMZwFGkwvX0lK2EkBC/rcc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-BZPLiCZYO4-bE-TDRfKaaQ-1; Mon, 07 Aug 2023 22:31:09 -0400
X-MC-Unique: BZPLiCZYO4-bE-TDRfKaaQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9ba3d6191so49131781fa.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Aug 2023 19:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691461868; x=1692066668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeABWAIqA3NR/jSM0/v+3WWsrOAd6qgiAGCX11jVSJU=;
 b=emQRkv5GEPtHh5SFMGYBdGkJ5qNxlAZfPN7FcIuHmVEO76f3X43FXd9nQkOzNe6bCO
 naII65GSBGYc3jkXxdy2NBDWJjTnXNyOQS2v43CClGZ0OofIogxwk+aS8jl+azdNm3Hz
 NrickIFaRSIskaYhlUZq+BnHG+abhW0nJLo0mg5b881RV2N+JXfWSdGaPR9DDhXgOcJP
 OGD9uA1iY/KYPDcbAKsyHFelhfOOCPmMnfU/fhflLKxKNVlSe809Bmg/uRQYAP50/0QE
 Ouj0yebvD1OVHhtdRqls+X+8+1/jA0MmpM2ShOLdGlf6+AYR+aCxULMq0rrhoUHprad7
 tu2w==
X-Gm-Message-State: AOJu0YzwOjvzEtYKRXlJEqZ912oBx6o387/lIbpMfrKkhzL6vTz5RSA/
 dXcvl4eVS82Dr/cPDvgfp1tWr788k26SQaCpU7n21eYsVsuMdWb3gd97644JQr7Ulw4KX+wfa/H
 yILt36F00jsWova5QCN1cLhPV5lyRCOZi0IMLGJ4rL/l8zrPzBlRdBfG4rw==
X-Received: by 2002:a2e:97c9:0:b0:2b9:b1b2:f97a with SMTP id
 m9-20020a2e97c9000000b002b9b1b2f97amr7713162ljj.0.1691461868041; 
 Mon, 07 Aug 2023 19:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf6wmUz9KD7Pm40wOolwzcO4hKLwPojzVOso6zb90KU8To2voaONAyiIwO5firUf/hF/21vH+T0rjab6rKFwg=
X-Received: by 2002:a2e:97c9:0:b0:2b9:b1b2:f97a with SMTP id
 m9-20020a2e97c9000000b002b9b1b2f97amr7713147ljj.0.1691461867765; Mon, 07 Aug
 2023 19:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
In-Reply-To: <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 10:30:56 +0800
Message-ID: <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gTW9uLCBKdWwgMzEsIDIwMjMgYXQgMjozMOKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgNTo0NuKAr1BNIE1p
Y2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRodSwg
SnVsIDI3LCAyMDIzIGF0IDA0OjU5OjMzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+
ID4gVGhleSByZWFsbHkgc2hvdWxkbid0IC0gYW55IE5JQyB0aGF0IHRha2VzIGZvcmV2ZXIgdG8K
PiA+ID4gPiBwcm9ncmFtIHdpbGwgY3JlYXRlIGlzc3VlcyBpbiB0aGUgbmV0d29ya2luZyBzdGFj
ay4KPiA+ID4KPiA+ID4gVW5mb3J0dW5hdGVseSwgaXQncyBub3QgcmFyZSBhcyB0aGUgZGV2aWNl
L2N2cSBjb3VsZCBiZSBpbXBsZW1lbnRlZAo+ID4gPiB2aWEgZmlybXdhcmUgb3Igc29mdHdhcmUu
Cj4gPgo+ID4gQ3VycmVudGx5IHRoYXQgbWVhbiBvbmUgZWl0aGVyIGhhcyBzYW5lIGZpcm13YXJl
IHdpdGggYSBzY2hlZHVsZXIgdGhhdAo+ID4gY2FuIG1lZXQgZGVhZGxpbmVzLCBvciBsb3NlcyBh
YmlsaXR5IHRvIHJlcG9ydCBlcnJvcnMgYmFjay4KPiA+Cj4gPiA+ID4gQnV0IGlmIHRoZXkgZG8g
dGhleSBjYW4gYWx3YXlzIHNldCB0aGlzIGZsYWcgdG9vLgo+ID4gPgo+ID4gPiBUaGlzIG1heSBo
YXZlIGZhbHNlIG5lZ2F0aXZlcyBhbmQgbWF5IGNvbmZ1c2UgdGhlIG1hbmFnZW1lbnQuCj4gPiA+
Cj4gPiA+IE1heWJlIHdlIGNhbiBleHRlbmQgdGhlIG5ldHdvcmtpbmcgY29yZSB0byBhbGxvdyBz
b21lIGRldmljZSBzcGVjaWZpYwo+ID4gPiBjb25maWd1cmF0aW9ucyB0byBiZSBkb25lIHdpdGgg
ZGV2aWNlIHNwZWNpZmljIGxvY2sgd2l0aG91dCBydG5sLiBGb3IKPiA+ID4gZXhhbXBsZSwgc3Bs
aXQgdGhlIHNldF9jaGFubmVscyB0bwo+ID4gPgo+ID4gPiBwcmVfc2V0X2NoYW5uZWxzCj4gPiA+
IHNldF9jaGFubmVscwo+ID4gPiBwb3N0X3NldF9jaGFubmVscwo+ID4gPgo+ID4gPiBUaGUgZGV2
aWNlIHNwZWNpZmljIHBhcnQgY291bGQgYmUgZG9uZSBpbiBwcmUgYW5kIHBvc3Qgd2l0aG91dCBh
IHJ0bmwgbG9jaz8KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPgo+ID4KPiA+IFdvdWxkIHRoZSBiZW5l
Zml0IGJlIHRoYXQgZXJyb3JzIGNhbiBiZSByZXBvcnRlZCB0byB1c2Vyc3BhY2UgdGhlbj8KPiA+
IFRoZW4gbWF5YmUuICBJIHRoaW5rIHlvdSB3aWxsIGhhdmUgdG8gc2hvdyBob3cgdGhpcyB3b3Jr
cyBmb3IgYXQgbGVhc3QKPiA+IG9uZSBjYXJkIGJlc2lkZXMgdmlydGlvLgo+Cj4gRXZlbiBmb3Ig
dmlydGlvLCB0aGlzIHNlZW1zIG5vdCBlYXN5LCBhcyBlLmcgdGhlCj4gdmlydG5ldF9zZW5kX2Nv
bW1hbmQoKSBhbmQgbmV0aWZfc2V0X3JlYWxfbnVtX3R4X3F1ZXVlcygpIG5lZWQgdG8KPiBhcHBl
YXIgdG8gYmUgYXRvbWljIHRvIHRoZSBuZXR3b3JraW5nIGNvcmUuCj4KPiBJIHdvbmRlciBpZiB3
ZSBjYW4gcmUtY29uc2lkZXIgdGhlIHdheSBvZiBhIHRpbWVvdXQgaGVyZSBhbmQgY2hvb3NlIGEK
PiBzYW5lIHZhbHVlIGFzIGEgc3RhcnQuCgpNaWNoYWVsLCBhbnkgbW9yZSBpbnB1dCBvbiB0aGlz
PwoKVGhhbmtzCgo+Cj4gVGhhbmtzCj4KPiA+Cj4gPgo+ID4gLS0KPiA+IE1TVAo+ID4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
