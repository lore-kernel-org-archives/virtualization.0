Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2F9C001DB
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 02:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE9DA813FF;
	Fri, 11 Aug 2023 02:23:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE9DA813FF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ehn27Mfk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J4bIcx4nzMio; Fri, 11 Aug 2023 02:23:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5BB8080E3E;
	Fri, 11 Aug 2023 02:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BB8080E3E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A27BC0072;
	Fri, 11 Aug 2023 02:23:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA3C6C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7091D40144
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7091D40144
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ehn27Mfk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zpo35DB-vgsq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:23:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8D0D40012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8D0D40012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691720610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7D37ElFMOkv2Rqdz6YAnt7dHay6F9maPARWJ5mfivcc=;
 b=ehn27MfkfZOpPFADhh0CjVhq2du8bcLfRHFx+tjg6/CYuk/asTXuE0B7Mv7dBMMrS7YirU
 ntrSL9nGyM1Ow3LH3gVPE71sbT8qO6gu0Tcq14q2WG8+KzkzPZ2UHvhFdVvty1pNEhnyxB
 k8NNQLq7wG1utN/palmvHWzo/O1Qi3g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-jXlDufKtMMmblcMqpVPA_g-1; Thu, 10 Aug 2023 22:23:28 -0400
X-MC-Unique: jXlDufKtMMmblcMqpVPA_g-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fe43c2562aso933989e87.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691720607; x=1692325407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7D37ElFMOkv2Rqdz6YAnt7dHay6F9maPARWJ5mfivcc=;
 b=WmSvd9HkneKJIynV2H7bMv+E8n6ToWw21v+QtVKLPiZhFQ6lwnBcYgWvWWNYZ351g8
 X8slv0UyWCE/2Pahdqy+nR3OPaFm7nzjEqcOKuTLrZAOXny7+LuDzC472l2nCTAD/cPy
 zVI5vsYif7wQnHPHlrjDOUGqjBF4T3tiBKqWfNPqJpntqGu1ERnl9hcZNsOdnhiHPisj
 MbtD1dn1j54itU49USmzunU0bsUW92mx3uUr4TRL8h/t28MFCHhDnRshnTlkrcmlvt3b
 5v1dvQiOLhyUNA1A6/M2TZAzjVRwEqik+qPJRpcwZLc8QHZRETEEkN7sGIKtsUsKKiJX
 oZTg==
X-Gm-Message-State: AOJu0YzoT6Aw1L6coSKBSNh8s0RQixDXqHAKPZqr1+qgYUE/cQN8/zM/
 sAk0v5G7YzRsA0wu7hhzcdpe1hwSPKG+Kjx0ILuZ8If3BkYOpTRbr/YZlSV+ifMRrBKk/+I5K64
 Fy2cGNGQuqt6dDi6cixdjyDolAuN8ilkBtg+rJZey6ffCqNL/uZAyhmIckA==
X-Received: by 2002:a05:6512:304e:b0:4fe:2528:8c69 with SMTP id
 b14-20020a056512304e00b004fe25288c69mr1494417lfb.17.1691720607281; 
 Thu, 10 Aug 2023 19:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9bhvRnWdFdZzH2mLHHS/f9qS8dsddE0dVWoiLOjokFCRtwhM9EwRnP5PT2q5ckgU0A6v+qiyAldx3w+fyy9Y=
X-Received: by 2002:a05:6512:304e:b0:4fe:2528:8c69 with SMTP id
 b14-20020a056512304e00b004fe25288c69mr1494412lfb.17.1691720606914; Thu, 10
 Aug 2023 19:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230810153744-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 Aug 2023 10:23:15 +0800
Message-ID: <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMzo0MeKAr0FNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBBdWcgMDgsIDIwMjMgYXQgMTA6MzA6NTZB
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIE1vbiwgSnVsIDMxLCAyMDIzIGF0IDI6
MzDigK9QTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4KPiA+
ID4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgNTo0NuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gVGh1LCBKdWwgMjcsIDIw
MjMgYXQgMDQ6NTk6MzNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gVGhl
eSByZWFsbHkgc2hvdWxkbid0IC0gYW55IE5JQyB0aGF0IHRha2VzIGZvcmV2ZXIgdG8KPiA+ID4g
PiA+ID4gcHJvZ3JhbSB3aWxsIGNyZWF0ZSBpc3N1ZXMgaW4gdGhlIG5ldHdvcmtpbmcgc3RhY2su
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVW5mb3J0dW5hdGVseSwgaXQncyBub3QgcmFyZSBhcyB0aGUg
ZGV2aWNlL2N2cSBjb3VsZCBiZSBpbXBsZW1lbnRlZAo+ID4gPiA+ID4gdmlhIGZpcm13YXJlIG9y
IHNvZnR3YXJlLgo+ID4gPiA+Cj4gPiA+ID4gQ3VycmVudGx5IHRoYXQgbWVhbiBvbmUgZWl0aGVy
IGhhcyBzYW5lIGZpcm13YXJlIHdpdGggYSBzY2hlZHVsZXIgdGhhdAo+ID4gPiA+IGNhbiBtZWV0
IGRlYWRsaW5lcywgb3IgbG9zZXMgYWJpbGl0eSB0byByZXBvcnQgZXJyb3JzIGJhY2suCj4gPiA+
ID4KPiA+ID4gPiA+ID4gQnV0IGlmIHRoZXkgZG8gdGhleSBjYW4gYWx3YXlzIHNldCB0aGlzIGZs
YWcgdG9vLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoaXMgbWF5IGhhdmUgZmFsc2UgbmVnYXRpdmVz
IGFuZCBtYXkgY29uZnVzZSB0aGUgbWFuYWdlbWVudC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBNYXli
ZSB3ZSBjYW4gZXh0ZW5kIHRoZSBuZXR3b3JraW5nIGNvcmUgdG8gYWxsb3cgc29tZSBkZXZpY2Ug
c3BlY2lmaWMKPiA+ID4gPiA+IGNvbmZpZ3VyYXRpb25zIHRvIGJlIGRvbmUgd2l0aCBkZXZpY2Ug
c3BlY2lmaWMgbG9jayB3aXRob3V0IHJ0bmwuIEZvcgo+ID4gPiA+ID4gZXhhbXBsZSwgc3BsaXQg
dGhlIHNldF9jaGFubmVscyB0bwo+ID4gPiA+ID4KPiA+ID4gPiA+IHByZV9zZXRfY2hhbm5lbHMK
PiA+ID4gPiA+IHNldF9jaGFubmVscwo+ID4gPiA+ID4gcG9zdF9zZXRfY2hhbm5lbHMKPiA+ID4g
PiA+Cj4gPiA+ID4gPiBUaGUgZGV2aWNlIHNwZWNpZmljIHBhcnQgY291bGQgYmUgZG9uZSBpbiBw
cmUgYW5kIHBvc3Qgd2l0aG91dCBhIHJ0bmwgbG9jaz8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGFu
a3MKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gV291bGQgdGhlIGJlbmVmaXQgYmUgdGhhdCBlcnJv
cnMgY2FuIGJlIHJlcG9ydGVkIHRvIHVzZXJzcGFjZSB0aGVuPwo+ID4gPiA+IFRoZW4gbWF5YmUu
ICBJIHRoaW5rIHlvdSB3aWxsIGhhdmUgdG8gc2hvdyBob3cgdGhpcyB3b3JrcyBmb3IgYXQgbGVh
c3QKPiA+ID4gPiBvbmUgY2FyZCBiZXNpZGVzIHZpcnRpby4KPiA+ID4KPiA+ID4gRXZlbiBmb3Ig
dmlydGlvLCB0aGlzIHNlZW1zIG5vdCBlYXN5LCBhcyBlLmcgdGhlCj4gPiA+IHZpcnRuZXRfc2Vu
ZF9jb21tYW5kKCkgYW5kIG5ldGlmX3NldF9yZWFsX251bV90eF9xdWV1ZXMoKSBuZWVkIHRvCj4g
PiA+IGFwcGVhciB0byBiZSBhdG9taWMgdG8gdGhlIG5ldHdvcmtpbmcgY29yZS4KPiA+ID4KPiA+
ID4gSSB3b25kZXIgaWYgd2UgY2FuIHJlLWNvbnNpZGVyIHRoZSB3YXkgb2YgYSB0aW1lb3V0IGhl
cmUgYW5kIGNob29zZSBhCj4gPiA+IHNhbmUgdmFsdWUgYXMgYSBzdGFydC4KPiA+Cj4gPiBNaWNo
YWVsLCBhbnkgbW9yZSBpbnB1dCBvbiB0aGlzPwo+ID4KPiA+IFRoYW5rcwo+Cj4gSSB0aGluayB0
aGlzIGlzIGp1c3QgbWlzc2lvbiBjcmVlcC4gV2UgYXJlIHRyeWluZyB0byBmaXgKPiB2ZHVzZSAt
IGxldCdzIGRvIHRoYXQgZm9yIHN0YXJ0ZXJzLgo+Cj4gUmVjb3ZlcmluZyBmcm9tIGZpcm13YXJl
IHRpbWVvdXRzIGlzIGZhciBmcm9tIHRyaXZpYWwgYW5kCj4ganVzdCBhc3N1bWluZyB0aGF0IGp1
c3QgYmVjYXVzZSBpdCB0aW1lZCBvdXQgaXQgd2lsbCBub3QKPiBhY2Nlc3MgbWVtb3J5IGlzIGp1
c3QgYXMgbGlrZWx5IHRvIGNhdXNlIG1lbW9yeSBjb3JydXB0aW9uCj4gd2l0aCB3b3JzZSByZXN1
bHRzIHRoYW4gYW4gaW5maW5pdGUgc3Bpbi4KClllcywgdGhpcyBtaWdodCByZXF1aXJlIHN1cHBv
cnQgbm90IG9ubHkgaW4gdGhlIGRyaXZlcgoKPgo+IEkgcHJvcG9zZSB3ZSBmaXggdGhpcyBmb3Ig
dmR1c2UgYW5kIGFzc3VtZSBoYXJkd2FyZS9maXJtd2FyZQo+IGlzIHdlbGwgYmVoYXZlZC4KCk9u
ZSBtYWpvciBjYXNlIGlzIHRoZSByZS1jb25uZWN0aW9uLCBpbiB0aGF0IGNhc2UgaXQgbWlnaHQg
dGFrZQp3aGF0ZXZlciBsb25nZXIgdGhhdCB0aGUga2VybmVsIHZpcml0by1uZXQgZHJpdmVyIGV4
cGVjdHMuCgpTbyB3ZSBjYW4gaGF2ZSBhIHRpbWVvdXQgaW4gVkRVU0UgYW5kIHRyYXAgQ1ZRIHRo
ZW4gVkRVU0UgY2FuIHJldHVybgphbmQgZmFpbCBlYXJseT8KCj4gT3IgbWF5YmUgbm90IHdlbGwg
YmVoYXZlZCBmaXJtd2FyZSB3aWxsCj4gc2V0IHRoZSBmbGFnIGxvc2luZyBlcnJvciByZXBvcnRp
bmcgYWJpbGl0eS4KClRoaXMgbWlnaHQgYmUgaGFyZCBzaW5jZSBpdCBtZWFucyBub3Qgb25seSB0
aGUgc2V0IGJ1dCBhbHNvIHRoZSBnZXQgaXMKdW5yZWxpYWJsZS4KClRoYW5rcwoKPgo+Cj4KPiA+
ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IC0tCj4gPiA+ID4g
TVNUCj4gPiA+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
