Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B56C77B72
	for <virtualization@archiver.kernel.org>; Tue, 18 Apr 2023 01:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 868AE417B4;
	Tue, 18 Apr 2023 01:07:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 868AE417B4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KPmO78J6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CxUwq6tXSmMm; Tue, 18 Apr 2023 01:07:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B365C4176D;
	Tue, 18 Apr 2023 01:07:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B365C4176D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 949BEC0036;
	Tue, 18 Apr 2023 01:07:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72A83C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 01:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39E2160FAF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 01:07:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39E2160FAF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KPmO78J6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8SkLicj71hhL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 01:07:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACE596060A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACE596060A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 01:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681780070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJ5eAv/wPSjHQtCSmc7/SAtq7IJeARTquIRQEcE2Hzo=;
 b=KPmO78J6gY1FUqYfGY2DeAYLCWaRIVnz9yyj7EOBCF72lQaJ3I7iSFErZ8dk6N7HpICuOv
 dpWxyonRlETYI1R+bKFpGPfqPjrWiIdNIOmT6FqMLrCGu7EQcoZFkrmlD58H+wkWVjFnap
 UCWS/tXLnFo8k5vTufnkYlu8QBNrofA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-Lg0TY-gPPB66yx1SftasBA-1; Mon, 17 Apr 2023 21:07:43 -0400
X-MC-Unique: Lg0TY-gPPB66yx1SftasBA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-38c4e0b3466so70053b6e.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 18:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681780062; x=1684372062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJ5eAv/wPSjHQtCSmc7/SAtq7IJeARTquIRQEcE2Hzo=;
 b=keeTDN1OF3++aVBKUl4SmEXo00YHxhP7S73FXLEbEiLMJyxy2Tjhs9WsurnewrVnCR
 LlWsCPwAdm2Uph10wi9hFH0/0+m0u8NjlN/Q1R6+qfELdNPSrQoA2o/5pNqPROyqNy1P
 ullH8Xa4Hlrn5LjGjz/IxnfhVSZlSigf6lAwG1Sf6YA1uMDQA6I2H1O2KCh7Wen0RXJT
 PxGQJRvjsd/THpxA7pVG8A9f2mvNH63lL2GAhNKeopRLRSOe+C0IkzHAKE5tkrDjTe5B
 /ZESgzKTephW4mcOert6PVDX3hEVMaEn9vGdqKOSxNYRVluDg4q8FpxNLSR5WxOPIZnv
 2oyw==
X-Gm-Message-State: AAQBX9csYhvOuDiebxgqMwo8WJdBFwsacMD7t4GRWQNrShNF6Bj+lNK7
 yNdR+oIllRM2Y/A7if9DK/6DFEex2nrOf6ShrSTm1t3V4WSLj/oOpQObnMJGfVJCQ+HO+ruCcZg
 uf1KQ6+7sRDqUZtP9p5k1gBa9sZWzv6cIeewgD4n3wNTfhz7zv0QR0R45bw==
X-Received: by 2002:aca:a90f:0:b0:38c:2e50:7ba1 with SMTP id
 s15-20020acaa90f000000b0038c2e507ba1mr70570oie.9.1681780062177; 
 Mon, 17 Apr 2023 18:07:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZqCb2yI8XjPtu0T702ZUJh3g15tnGze7/cYh3km5B2h6oWo65vgswsQUHg5Pv5UfUHzBzjLVKg/U5tifRvxHw=
X-Received: by 2002:aca:a90f:0:b0:38c:2e50:7ba1 with SMTP id
 s15-20020acaa90f000000b0038c2e507ba1mr70553oie.9.1681780061908; Mon, 17 Apr
 2023 18:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
 <ZDzKAD2SNe1q/XA6@infradead.org>
 <1681711081.378984-2-xuanzhuo@linux.alibaba.com>
 <20230417115610.7763a87c@kernel.org> <20230417115753.7fb64b68@kernel.org>
In-Reply-To: <20230417115753.7fb64b68@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Apr 2023 09:07:30 +0800
Message-ID: <CACGkMEtPNPXFThHt4aNm4g-fC1DqTLcDnB_iBWb9-cAOHMYV_A@mail.gmail.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
To: Jakub Kicinski <kuba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

T24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgMjo1OOKAr0FNIEpha3ViIEtpY2luc2tpIDxrdWJhQGtl
cm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gTW9uLCAxNyBBcHIgMjAyMyAxMTo1NjoxMCAtMDcwMCBK
YWt1YiBLaWNpbnNraSB3cm90ZToKPiA+ID4gTWF5IG1pc3VuZGVyc3RhbmQsIGhlcmUgdGhlICJk
bWFfb3BzIiBpcyBub3QgdGhlICJkbWFfb3BzIiBvZiBETUEgQVBJLgo+ID4gPgo+ID4gPiBJIG1l
YW4gdGhlIGNhbGxiYWNrcyBmb3IgeHNrIHRvIGRvIGRtYS4KPiA+ID4KPiA+ID4gTWF5YmUsIEkg
c2hvdWxkIHJlbmFtZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgo+ID4KPiA+IFdvdWxkIHlvdSBt
aW5kIGV4cGxhaW5pbmcgdGhpcyBhIGJpdCBtb3JlIHRvIGZvbGtzIGxpa2UgbWUgd2hvIGFyZSBu
b3QKPiA+IGZhbWlsaWFyIHdpdGggVmlydElPPyAgRE1BIEFQSSBpcyBzdXBwb3NlZCB0byBoaWRl
IHRoZSBETUEgbWFwcGluZwo+ID4gZGV0YWlscyBmcm9tIHRoZSBzdGFjaywgd2h5IGlzIGl0IG5v
dCBzdWZmaWNpZW50IGhlcmUuCgpUaGUgcmVhc29uIGlzIHRoYXQgbGVnYWN5IHZpcnRpbyBkZXZp
Y2UgZG9uJ3QgdXNlIERNQSh2cmluZ191c2VfZG1hX2FwaSgpKS4KClRoZSBBRl9YRFAgYXNzdW1l
cyBETUEgZm9yIG5ldGRldiBkb2Vzbid0IHdvcmsgaW4gdGhpcyBjYXNlLiBXZSBuZWVkIGEKd2F5
IHRvIG1ha2UgaXQgd29yay4KClRoYW5rcwoKPgo+IFVtbS4uIGFsc28gaXQnZCBoZWxwIHRvIHBv
c3QgdGhlIHVzZXIgb2YgdGhlIEFQSSBpbiB0aGUgc2FtZSBzZXJpZXMuCj4gSSBvbmx5IHNlZSB0
aGUgWFNLIGNoYW5nZXMsIG1heWJlIGlmIHRoZSB2aXJ0aW8gY2hhbmdlcyB3ZXJlIGluCj4gdGhl
IHNhbWUgc2VyaWVzIEkgY291bGQgYW5zd2VyIG15IG93biBxdWVzdGlvbi4KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
