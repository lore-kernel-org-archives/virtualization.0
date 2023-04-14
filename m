Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CACC77B70
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 05:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F46E427C2;
	Fri, 14 Apr 2023 05:40:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F46E427C2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A99CjgY6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DOEZ1SCEYmAy; Fri, 14 Apr 2023 05:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D5FE427B8;
	Fri, 14 Apr 2023 05:40:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D5FE427B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AB3FC0036;
	Fri, 14 Apr 2023 05:40:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A4BBC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1502B40114
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:40:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1502B40114
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=A99CjgY6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CRtqkn65TYKu
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:40:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34E40400FC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34E40400FC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681450847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36R8yA5JwrX0XhwM8RvPweATRjX3s/5NTOfHCOBnG08=;
 b=A99CjgY6KZ81xDou8SF6ub5X8pEpGlhkSgXY8Rx20C/ji+KIDY4elj3XYVUDwEJuzHUHKo
 pDs8zdx1qHdRE43Y2vzgc1eqiIFpcK7n2v6EGyo6V2GXFlgF2oPAQg+97A8HUD8HxSEESN
 kGEKsarWf+EFrccFpvttOrDHLY8i9K0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-IxZpaAVNPfWoms4kpQ_17g-1; Fri, 14 Apr 2023 01:40:44 -0400
X-MC-Unique: IxZpaAVNPfWoms4kpQ_17g-1
Received: by mail-oi1-f198.google.com with SMTP id
 q10-20020acac00a000000b0038c38b8cd2cso298135oif.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 22:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681450844; x=1684042844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36R8yA5JwrX0XhwM8RvPweATRjX3s/5NTOfHCOBnG08=;
 b=S0jJrFAyvcUMLq918GIy/vGQMpUtBRlEjcf/3EZNHY1GKZAv9CFWNFlte0qlfQVxo6
 o2Zgzd2SUSdY5dQC1nNEyhtrU/Syz5zWNxUnunCAEfr6I1yFpxV4P2KcoSI2y0Q7twev
 aHJaDr3A51KBk7ji9RvHFZV6w4T4q7kAQeRT2vi0ni1rh1K5r9xySvXSx8TDo7yWcozr
 1pjTRn+MRxY0B+yRRl/SbtF2hPvINGTrAGy9+VdiQGu7OQYeKd3ewEf/kX0qf9gXyCSD
 we8HuGoSEJ5LM1VBVqeGZ6iWuRSdcJJs78pVTrsrcUAABK2oe9H0U52bHptSuzci5xmk
 Nu7A==
X-Gm-Message-State: AAQBX9dR1Xzs/fSbVxlWd78U8qstrCoKEDVkjt1hhb8fL+zPUp1zrJpI
 mYBdpp71Xb8P7jAEshPAFP8TbG5IYC7Ja/yBf3mvISU/IyswC12HeMKK3KT4BwxxlHKfiCeRCvH
 7/4S+HlJ9Tndut43vyqSSUQ3RxdIc3BfUomoo6QgalRlh2lTN+XbOMf+Kag==
X-Received: by 2002:a05:6870:5627:b0:17d:1287:1b5c with SMTP id
 m39-20020a056870562700b0017d12871b5cmr2524970oao.9.1681450843900; 
 Thu, 13 Apr 2023 22:40:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350YUPuw9qHFJb/CWKg4l7nwBYVM6AmHM+j+mUdqLLHmDT2abxvGjtVUB/vr6+CVJxJ2HGXu46UgbDiYuS5Oy9R4=
X-Received: by 2002:a05:6870:5627:b0:17d:1287:1b5c with SMTP id
 m39-20020a056870562700b0017d12871b5cmr2524956oao.9.1681450843735; Thu, 13 Apr
 2023 22:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230413121937.46135-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230413121937.46135-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Apr 2023 13:40:32 +0800
Message-ID: <CACGkMEsE8TosCxyf4GwmsBzo1Ot9FiLtsWt16oz0f0J99DGYCg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: bugfix overflow inside
 xdp_linearize_page()
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

T24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgODoxOeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gSGVyZSB3ZSBjb3B5IHRoZSBkYXRhIGZyb20gdGhl
IG9yaWdpbmFsIGJ1ZiB0byB0aGUgbmV3IHBhZ2UuIEJ1dCB3ZQo+IG5vdCBjaGVjayB0aGF0IGl0
IG1heSBiZSBvdmVyZmxvdy4KPgo+IEFzIGxvbmcgYXMgdGhlIHNpemUgcmVjZWl2ZWQoaW5jbHVk
aW5nIHZuZXRoZHIpIGlzIGdyZWF0ZXIgdGhhbiAzODQwCj4gKFBBR0VfU0laRSAtVklSVElPX1hE
UF9IRUFEUk9PTSkuIFRoZW4gdGhlIG1lbWNweSB3aWxsIG92ZXJmbG93Lgo+Cj4gQW5kIHRoaXMg
aXMgY29tcGxldGVseSBwb3NzaWJsZSwgYXMgbG9uZyBhcyB0aGUgTVRVIGlzIGxhcmdlLCBzdWNo
Cj4gYXMgNDA5Ni4gSW4gb3VyIHRlc3QgZW52aXJvbm1lbnQsIHRoaXMgd2lsbCBjYXVzZSBjcmFz
aC4gU2luY2UgY3Jhc2ggaXMKPiBjYXVzZWQgYnkgdGhlIHdyaXR0ZW4gbWVtb3J5LCBpdCBpcyBt
ZWFuaW5nbGVzcywgc28gSSBkbyBub3QgaW5jbHVkZSBpdC4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgpNaXNzaW5nIGZpeGVzIHRhZz8K
Ck90aGVyIHRoYW4gdGhpcywKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgoKVGhhbmtzCgo+IC0tLQo+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA4ICsrKysr
Ky0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gaW5kZXggMjM5NmMyOGMwMTIyLi5lYTFiZDRiYjMyNmQgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gQEAgLTgxNCw4ICs4MTQsMTMgQEAgc3RhdGljIHN0cnVjdCBwYWdlICp4ZHBfbGluZWFy
aXplX3BhZ2Uoc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLAo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGludCBwYWdlX29mZiwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgKmxlbikKPiAgewo+IC0gICAgICAgc3RydWN0
IHBhZ2UgKnBhZ2UgPSBhbGxvY19wYWdlKEdGUF9BVE9NSUMpOwo+ICsgICAgICAgaW50IHRhaWxy
b29tID0gU0tCX0RBVEFfQUxJR04oc2l6ZW9mKHN0cnVjdCBza2Jfc2hhcmVkX2luZm8pKTsKPiAr
ICAgICAgIHN0cnVjdCBwYWdlICpwYWdlOwo+ICsKPiArICAgICAgIGlmIChwYWdlX29mZiArICps
ZW4gKyB0YWlscm9vbSA+IFBBR0VfU0laRSkKPiArICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7
Cj4KPiArICAgICAgIHBhZ2UgPSBhbGxvY19wYWdlKEdGUF9BVE9NSUMpOwo+ICAgICAgICAgaWYg
KCFwYWdlKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKPgo+IEBAIC04MjMsNyArODI4
LDYgQEAgc3RhdGljIHN0cnVjdCBwYWdlICp4ZHBfbGluZWFyaXplX3BhZ2Uoc3RydWN0IHJlY2Vp
dmVfcXVldWUgKnJxLAo+ICAgICAgICAgcGFnZV9vZmYgKz0gKmxlbjsKPgo+ICAgICAgICAgd2hp
bGUgKC0tKm51bV9idWYpIHsKPiAtICAgICAgICAgICAgICAgaW50IHRhaWxyb29tID0gU0tCX0RB
VEFfQUxJR04oc2l6ZW9mKHN0cnVjdCBza2Jfc2hhcmVkX2luZm8pKTsKPiAgICAgICAgICAgICAg
ICAgdW5zaWduZWQgaW50IGJ1ZmxlbjsKPiAgICAgICAgICAgICAgICAgdm9pZCAqYnVmOwo+ICAg
ICAgICAgICAgICAgICBpbnQgb2ZmOwo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
