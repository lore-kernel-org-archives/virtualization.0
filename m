Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECFDEB64DC
	for <virtualization@archiver.kernel.org>; Mon,  3 Jul 2023 06:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F5B14054B;
	Mon,  3 Jul 2023 06:25:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F5B14054B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L21xEHAP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1_r2vU5u-xtd; Mon,  3 Jul 2023 06:25:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0D5B6400B9;
	Mon,  3 Jul 2023 06:25:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D5B6400B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0251C0072;
	Mon,  3 Jul 2023 06:25:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 018B8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 06:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C23B040474
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 06:25:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C23B040474
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XOe1r3YiyNOd
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 06:25:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15FB5400B9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15FB5400B9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 06:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688365540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tpk/m1ehmImz7zaLy3aO5+IqtB88CsrdqBSdTDk04so=;
 b=L21xEHAP78Z+Silct1kf4hjqkR84vUVrWJUGwlcdxBAyj60v54e8ckZr2T55Bc+74RHRVI
 0Ix2naKtmyVvsVyBdGbKfdnqNAk5yVLtuJjnd0ItoCtEEXu0r87tCNiS6DKrcWABTgjHYo
 T4UUMqitC2DoJJwKU8SHB02HP3MiDLY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-dX056NaMMOihaIMWr4UFTA-1; Mon, 03 Jul 2023 02:25:38 -0400
X-MC-Unique: dX056NaMMOihaIMWr4UFTA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6a679df26so35376971fa.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 02 Jul 2023 23:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688365537; x=1690957537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tpk/m1ehmImz7zaLy3aO5+IqtB88CsrdqBSdTDk04so=;
 b=hNOP/bDxk4h1V1HGxX4zsLxmy3RQ+tW/EQzL48mpdhA8xcGHl2t3+NHLQQ/DkN7mEM
 X7Z6AIUcjx6j4BAG262zlKhXwRosIiZXh9ywZBtIF79KspJNld2iD9FuwzSARUoPKn4t
 k39JDB/t+c02AZISIrG5rkTQERtnbHG2YZFJpGrIeV1TkP4v8qIVaxK9gJrL61OA+wMe
 egjdQDrJwBw3GX+klvtvvLfUEdM2VYMpWTA0Uy5V3ZYa2luzNSnBe8XffY3nEymKx1XG
 pxN3rylyrBydHBiydzNJ9oNq+9IyknRiRmqa8m9Mo0lqXk7kxDchVLGsxEoxAum2vK2R
 lw+Q==
X-Gm-Message-State: ABy/qLbJTj5BjXcXko37gZRbazvX0NcbC/9nZfg86Vbi/02dl/8Ax+y6
 Eno1xM9ainDvOEP8L8lF5PF8p6ZEHheWUkzPvQv4Me7mpw+kVOAW5GB9n+dWQTDtyMf4Yeu9uFe
 kW5grck7yfUlgeKB3l0OUv99vWMRcfxltiOWSYGmYQsG6aVzbSnOU3MO8rw==
X-Received: by 2002:a2e:3a0f:0:b0:2b6:decf:5cbf with SMTP id
 h15-20020a2e3a0f000000b002b6decf5cbfmr2575347lja.32.1688365537527; 
 Sun, 02 Jul 2023 23:25:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEtiFAUSLVKli3ZwlIzEtafXVEMpeIGVKp2Qav8LglWDEDQNJ63BHWuk/72EPyDX1VfTOgZd7pUWMPp5sL01kw=
X-Received: by 2002:a2e:3a0f:0:b0:2b6:decf:5cbf with SMTP id
 h15-20020a2e3a0f000000b002b6decf5cbfmr2575331lja.32.1688365537255; Sun, 02
 Jul 2023 23:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com>
 <20230628065919.54042-2-lulu@redhat.com>
 <CACGkMEvTyxvEkdMbYqZG3T4ZGm2G36hYqPidbTNzLB=bUgSr0A@mail.gmail.com>
 <CACLfguWx2hjNyyVC_JM1VBCGj3AqRZsygHJ3JGcb8erknBo-sA@mail.gmail.com>
In-Reply-To: <CACLfguWx2hjNyyVC_JM1VBCGj3AqRZsygHJ3JGcb8erknBo-sA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Jul 2023 14:25:25 +0800
Message-ID: <CACGkMEtowYUowpsBvkYe3AUADwYgOcxbHW=-f=45u2vNTz9CUA@mail.gmail.com>
Subject: Re: [RFC 1/4] vduse: Add the struct to save the vq reconnect info
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, maxime.coquelin@redhat.com
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

T24gU2F0LCBKdWwgMSwgMjAyMyBhdCA1OjI14oCvUE0gQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEp1biAyOCwgMjAyMyBhdCA0OjA04oCvUE0gSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gV2VkLCBKdW4gMjgsIDIw
MjMgYXQgMjo1OeKAr1BNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+
ID4gPiBGcm9tOiBZb3VyIE5hbWUgPHlvdUBleGFtcGxlLmNvbT4KPiA+Cj4gPiBJdCBsb29rcyB0
byBtZSB5b3VyIGdpdCBpcyBub3QgcHJvcGVybHkgY29uZmlndXJlZC4KPiA+Cj4gPiA+Cj4gPiA+
IHRoaXMgc3RydWN0IGlzIHRvIHNhdmUgdGhlIHJlY29ubmVjdCBpbmZvIHN0cnVjdCwgaW4gdGhp
cwo+ID4gPiBzdHJ1Y3Qgc2F2ZWQgdGhlIHBhZ2UgaW5mbyB0aGF0IGFsbG9jIHRvIHNhdmUgdGhl
Cj4gPiA+IHJlY29ubmVjdCBpbmZvCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IENpbmR5IEx1
IDxsdWx1QHJlZGhhdC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy92ZHBhL3ZkcGFfdXNl
ci92ZHVzZV9kZXYuYyB8IDcgKysrKysrKwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92
ZHVzZV9kZXYuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiA+ID4gaW5k
ZXggMjZiN2UyOWNiOTAwLi5mODQ1ZGM0NmIxZGIgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMv
dmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFf
dXNlci92ZHVzZV9kZXYuYwo+ID4gPiBAQCAtNzIsNiArNzIsMTIgQEAgc3RydWN0IHZkdXNlX3Vt
ZW0gewo+ID4gPiAgICAgICAgIHN0cnVjdCBwYWdlICoqcGFnZXM7Cj4gPiA+ICAgICAgICAgc3Ry
dWN0IG1tX3N0cnVjdCAqbW07Cj4gPiA+ICB9Owo+ID4gPiArc3RydWN0IHZkcGFfcmVjb25uZWN0
X2luZm8gewo+ID4gPiArICAgICAgIHUzMiBpbmRleDsKPiA+ID4gKyAgICAgICBwaHlzX2FkZHJf
dCBhZGRyOwo+ID4gPiArICAgICAgIHVuc2lnbmVkIGxvbmcgdmFkZHI7Cj4gPiA+ICsgICAgICAg
cGh5c19hZGRyX3Qgc2l6ZTsKPiA+ID4gK307Cj4gPgo+ID4gUGxlYXNlIGFkZCBjb21tZW50cyB0
byBleHBsYWluIGVhY2ggZmllbGQuIEFuZCBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlCj4gPiBhIHBh
cnQgb2YgdUFQST8KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gV2lsbCBhZGQgdGhlIG5ldyBpb2N0bCBm
b3IgdGhpcyBpbmZvcm1hdGlvbgoKSSBtYXkgbWlzcyBzb21ldGhpbmcgYnV0IGhhdmluZyB0aGlz
IHRvIGJlIHBhcnQgb2YgdGhlIHVBUEkgc2VlbXMgbW9yZQp0aGFuIGVub3VnaC4KCk9yIHdoYXQg
d291bGQgdGhpcyBuZXcgaW9jdGwgZG8/CgpUaGFua3MKCj4gVGhhbmtzCj4gQ2luZHkKPiA+ID4K
PiA+ID4gIHN0cnVjdCB2ZHVzZV9kZXYgewo+ID4gPiAgICAgICAgIHN0cnVjdCB2ZHVzZV92ZHBh
ICp2ZGV2Owo+ID4gPiBAQCAtMTA2LDYgKzExMiw3IEBAIHN0cnVjdCB2ZHVzZV9kZXYgewo+ID4g
PiAgICAgICAgIHUzMiB2cV9hbGlnbjsKPiA+ID4gICAgICAgICBzdHJ1Y3QgdmR1c2VfdW1lbSAq
dW1lbTsKPiA+ID4gICAgICAgICBzdHJ1Y3QgbXV0ZXggbWVtX2xvY2s7Cj4gPiA+ICsgICAgICAg
c3RydWN0IHZkcGFfcmVjb25uZWN0X2luZm8gcmVjb25uZWN0X2luZm9bNjRdOwo+ID4gPiAgfTsK
PiA+ID4KPiA+ID4gIHN0cnVjdCB2ZHVzZV9kZXZfbXNnIHsKPiA+ID4gLS0KPiA+ID4gMi4zNC4z
Cj4gPiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
