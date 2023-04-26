Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105EDC77B73
	for <virtualization@archiver.kernel.org>; Wed, 26 Apr 2023 03:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F1DD408CF;
	Wed, 26 Apr 2023 03:13:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F1DD408CF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G2PUcJvD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HUmdrLQDEDdJ; Wed, 26 Apr 2023 03:13:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8FA26408C6;
	Wed, 26 Apr 2023 03:13:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8FA26408C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66BD3C0037;
	Wed, 26 Apr 2023 03:13:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00F77C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D666F812FD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:13:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D666F812FD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G2PUcJvD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id apyLnKgL8y9Y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:13:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9ABB0812D8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9ABB0812D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682478827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBu915H8CYkTjrtvIiCsbssLWyRdiWGP5IQleYTqxXw=;
 b=G2PUcJvDq0HL5ez0jqFHbd9AMHmMZu14gwTuwVPvp8Tl7nTzguflKEj47DYzPxB7vJBdRi
 anTwCcezaBF3hQYZetLqPMduNPkD4zrbTexCv1PgrdAy7YwmXr6gEw6Eu6vCLYlMaPRm3w
 ZwFFCWbBSLMyXTPFnJ+Rn7umDTlqKBg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-biS7PYUKOlmkypIaZJHjPg-1; Tue, 25 Apr 2023 23:13:44 -0400
X-MC-Unique: biS7PYUKOlmkypIaZJHjPg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4ec9e0761c6so7915042e87.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 20:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682478822; x=1685070822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xBu915H8CYkTjrtvIiCsbssLWyRdiWGP5IQleYTqxXw=;
 b=d4T+K3UyqdXFiLCmTn0SHiRYe2u9/r97zw/zXJRhcAiH/v8fmyxnfFBUFfVPTJqFdW
 rzPiCxbR5YLzHzB5b2bPt7UFS4FmmoUKADfg0YibXjuxFppg220c38B5gn9LSnWtvYKI
 SGH+ACZgjBDCBWz6RrQ03YkY2d17JbUzLHTWdz2ZFqbqlJHX9lCOIctYAMT0OE+wgaoz
 E1CGvkiX5sb38xh/qjBzF5uRfFBLPa0rqN9QdPUBtYdLcnnBEctvmz3pKMPNIZowfig2
 nCXPteSfTa/zaRcftR306WalE6qvQT8jBXh6Q3NJ/0mpclJmtKE0gMu1CC+7pkxb7Bxm
 M8mg==
X-Gm-Message-State: AC+VfDwojmEIDrGst8QITHTZhlcJrtFME3kp0LllNTTqWyEBru0EWd3H
 FAlleByCHo/kc1FI8n3zt950PRT1ENzxWQ2pR5xjC0f6miHfGZlLuzcGJrljVUvuCiPJ5GMM1V0
 OFlVA4jOI5KhKweKvcphjlckOqkmI7exJQUVIEN478NB+9V9qyU0y+uNzCg==
X-Received: by 2002:ac2:4f01:0:b0:4ed:c758:6b5a with SMTP id
 k1-20020ac24f01000000b004edc7586b5amr221574lfr.4.1682478822791; 
 Tue, 25 Apr 2023 20:13:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bzDuPAoLkRvJ6hXcx6xfJgVJ4CQKsoGORFUb4ySVnfNMcZWlRncRle3bnaBr2mCupDi+qJ0ruKkuAQvpkksQ=
X-Received: by 2002:ac2:4f01:0:b0:4ed:c758:6b5a with SMTP id
 k1-20020ac24f01000000b004edc7586b5amr221565lfr.4.1682478822513; Tue, 25 Apr
 2023 20:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
 <20230423105736.56918-14-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230423105736.56918-14-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Apr 2023 11:13:31 +0800
Message-ID: <CACGkMEuL8nACFdFQamOm-u+iDiMPHL9X8Dta86OtVvOV-u0P0A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 13/15] virtio_net: small: remove skip_xdp
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gU3VuLCBBcHIgMjMsIDIwMjMgYXQgNjo1OOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gbm93LCB0aGUgcHJvY2VzcyBvZiB4ZHAgaXMgc2lt
cGxlLCB3ZSBjYW4gcmVtb3ZlIHRoZSBza2lwX3hkcC4KCkkgd291bGQgc2F5IHRoZSByZWFzb24g
d2h5IHhkcCBpcyBzaW1wbGUsIEkgdGhpbmsgaXQgaXMgYmVjYXVzZSB0aGUKc2tiIGJ1aWxkIHBh
dGggaXMgbm90IHNoYXJlZCBiZXR3ZWVuIFhEUCBhbmQgbm9uLVhEUCBjYXNlLgoKT3RoZXIgdGhh
biB0aGlzCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5r
cwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPgo+IC0tLQo+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyNiArKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTQgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggNjAxYzBlN2ZjMzJiLi5kMjk3M2M4ZmE0OGMg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gQEAgLTEwMjgsMTMgKzEwMjgsMTIgQEAgc3RhdGljIHN0cnVjdCBz
a19idWZmICpyZWNlaXZlX3NtYWxsKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCAqeGRwX3htaXQsCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0bmV0X3JxX3N0YXRz
ICpzdGF0cykKPiAgewo+IC0gICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYjsKPiAtICAgICAgIHN0
cnVjdCBicGZfcHJvZyAqeGRwX3Byb2c7Cj4gICAgICAgICB1bnNpZ25lZCBpbnQgeGRwX2hlYWRy
b29tID0gKHVuc2lnbmVkIGxvbmcpY3R4Owo+ICAgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSB2
aXJ0X3RvX2hlYWRfcGFnZShidWYpOwo+ICAgICAgICAgdW5zaWduZWQgaW50IGhlYWRlcl9vZmZz
ZXQ7Cj4gICAgICAgICB1bnNpZ25lZCBpbnQgaGVhZHJvb207Cj4gICAgICAgICB1bnNpZ25lZCBp
bnQgYnVmbGVuOwo+ICsgICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYjsKPgo+ICAgICAgICAgbGVu
IC09IHZpLT5oZHJfbGVuOwo+ICAgICAgICAgc3RhdHMtPmJ5dGVzICs9IGxlbjsKPiBAQCAtMTA0
NiwyMiArMTA0NSwyMSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfc21hbGwoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgICAgICAgICAgICAgICAgZ290byBlcnI7Cj4gICAgICAg
ICB9Cj4KPiAtICAgICAgIGlmIChsaWtlbHkoIXZpLT54ZHBfZW5hYmxlZCkpIHsKPiAtICAgICAg
ICAgICAgICAgeGRwX3Byb2cgPSBOVUxMOwo+IC0gICAgICAgICAgICAgICBnb3RvIHNraXBfeGRw
Owo+IC0gICAgICAgfQo+ICsgICAgICAgaWYgKHVubGlrZWx5KHZpLT54ZHBfZW5hYmxlZCkpIHsK
PiArICAgICAgICAgICAgICAgc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZzsKPgo+IC0gICAgICAg
cmN1X3JlYWRfbG9jaygpOwo+IC0gICAgICAgeGRwX3Byb2cgPSByY3VfZGVyZWZlcmVuY2UocnEt
PnhkcF9wcm9nKTsKPiAtICAgICAgIGlmICh4ZHBfcHJvZykgewo+IC0gICAgICAgICAgICAgICBz
a2IgPSByZWNlaXZlX3NtYWxsX3hkcChkZXYsIHZpLCBycSwgeGRwX3Byb2csIGJ1ZiwgeGRwX2hl
YWRyb29tLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsZW4sIHhk
cF94bWl0LCBzdGF0cyk7Cj4gKyAgICAgICAgICAgICAgIHJjdV9yZWFkX2xvY2soKTsKPiArICAg
ICAgICAgICAgICAgeGRwX3Byb2cgPSByY3VfZGVyZWZlcmVuY2UocnEtPnhkcF9wcm9nKTsKPiAr
ICAgICAgICAgICAgICAgaWYgKHhkcF9wcm9nKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
c2tiID0gcmVjZWl2ZV9zbWFsbF94ZHAoZGV2LCB2aSwgcnEsIHhkcF9wcm9nLCBidWYsCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGRwX2hlYWRyb29t
LCBsZW4sIHhkcF94bWl0LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0YXRzKTsKPiArICAgICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxv
Y2soKTsKPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gc2tiOwo+ICsgICAgICAgICAg
ICAgICB9Cj4gICAgICAgICAgICAgICAgIHJjdV9yZWFkX3VubG9jaygpOwo+IC0gICAgICAgICAg
ICAgICByZXR1cm4gc2tiOwo+ICAgICAgICAgfQo+IC0gICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7
Cj4KPiAtc2tpcF94ZHA6Cj4gICAgICAgICBoZWFkZXJfb2Zmc2V0ID0gVklSVE5FVF9SWF9QQUQg
KyB4ZHBfaGVhZHJvb207Cj4gICAgICAgICBoZWFkcm9vbSA9IHZpLT5oZHJfbGVuICsgaGVhZGVy
X29mZnNldDsKPiAgICAgICAgIGJ1ZmxlbiA9IFNLQl9EQVRBX0FMSUdOKEdPT0RfUEFDS0VUX0xF
TiArIGhlYWRyb29tKSArCj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
