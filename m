Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F51CDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 07:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A27860BF1;
	Thu, 12 Oct 2023 07:50:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A27860BF1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i8ErYKva
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z-GR24gzCQWr; Thu, 12 Oct 2023 07:50:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CD3AC60F9B;
	Thu, 12 Oct 2023 07:50:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD3AC60F9B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B416C0039;
	Thu, 12 Oct 2023 07:50:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE3CBC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 07:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5F898146E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 07:50:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5F898146E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i8ErYKva
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d_pR_dpBJ5AJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 07:50:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F2878146D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 07:50:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F2878146D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697097028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FiG13da8k/ZbjjqgCy1pf25ts3THBZ36xeSgrel6qHw=;
 b=i8ErYKva0Z0GYhkPx14724ZbwMHt9+lYYUeGWJl0lNQ0pspH9TsAuq51HnYIF/FLwsRky6
 95m+m46hiSG7gsAcG0zzTNdKKD9OWiCvJOexy2eHC8O9J8RAIs2oG1NH4I6zYwizJRJ/Ao
 TTdE58KWtnMGHq3XfYQkL/jpYeyYNMU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-JhL6Pci3OYauSb9Q_c_yrA-1; Thu, 12 Oct 2023 03:50:26 -0400
X-MC-Unique: JhL6Pci3OYauSb9Q_c_yrA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c296e650easo6264681fa.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 00:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697097025; x=1697701825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FiG13da8k/ZbjjqgCy1pf25ts3THBZ36xeSgrel6qHw=;
 b=CcSfL09Cxh2z57Lel2M8fuTB7nGxBCL2nrh55ZRSvOyvtIPReRijVodQnXLE1+dCV/
 o6XXdWlU2sL4iW51lfLg3GrpobRdpBjd8fwcs9TPFMO8IERTA8DgpEtCx1yt9zF3DjXe
 HVe98NkFVo2eTktqMzPDeFNNZCbm++FSOZr34BIAYaD33rrUUDhLpFDUxWs+Zdm9ypDw
 bu6poJXtlyceJak39ZnmgWQrYsQMDJS4AxBFI0jpoY8n7NBQatUo8h1ZLYfjU0K31uJM
 PTAZnXwHwpqEYoUowbkJrkNbxVJShIMAz/LMuTNbEHEH5Uqf+YD+aBGWSnYpj0lysUv/
 lehQ==
X-Gm-Message-State: AOJu0YyML2Vl7tkPfAoLsQkHdZ07WI0o5v1rcET789vjFUaFmGR/FGa7
 TmC+nQM20uZUHhQv1OW1/LVAtlnCcG1mOzGp+w+W936MwmRoGF90YObvlsLnN1euzJFaM6jnngl
 v5fQqCjSLSLUV7PRuD80yOz6Fa6khwKe0Dl1R3E3R0nPO8+n1xVftvCgM+g==
X-Received: by 2002:a2e:2c1a:0:b0:2bc:e470:1405 with SMTP id
 s26-20020a2e2c1a000000b002bce4701405mr18183616ljs.46.1697097025335; 
 Thu, 12 Oct 2023 00:50:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzYu7Lfht/V4Rj2WUdNomulK6QlCD6ZyUl6D/Bh+QtwT3mYue+hyDIjXaThrj7GL3e+cS6zO8ebpAqF5FI2rI=
X-Received: by 2002:a2e:2c1a:0:b0:2bc:e470:1405 with SMTP id
 s26-20020a2e2c1a000000b002bce4701405mr18183602ljs.46.1697097025022; Thu, 12
 Oct 2023 00:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011100057.535f3834@kernel.org>
 <1697075634.444064-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1697075634.444064-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Oct 2023 15:50:13 +0800
Message-ID: <CACGkMEsadYH8Y-KOxPX6vPic7pBqzj2DLnog5osuBDtypKgEZA@mail.gmail.com>
Subject: Re: [PATCH vhost 00/22] virtio-net: support AF_XDP zero copy
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

T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgOTo1OOKAr0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCAxMSBPY3QgMjAyMyAxMDowMDo1NyAt
MDcwMCwgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiBPbiBXZWQs
IDExIE9jdCAyMDIzIDE3OjI3OjA2ICswODAwIFh1YW4gWmh1byB3cm90ZToKPiA+ID4gIyMgQUZf
WERQCj4gPiA+Cj4gPiA+IFhEUCBzb2NrZXQoQUZfWERQKSBpcyBhbiBleGNlbGxlbnQgYnlwYXNz
IGtlcm5lbCBuZXR3b3JrIGZyYW1ld29yay4gVGhlIHplcm8KPiA+ID4gY29weSBmZWF0dXJlIG9m
IHhzayAoWERQIHNvY2tldCkgbmVlZHMgdG8gYmUgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIuIFRo
ZQo+ID4gPiBwZXJmb3JtYW5jZSBvZiB6ZXJvIGNvcHkgaXMgdmVyeSBnb29kLiBtbHg1IGFuZCBp
bnRlbCBpeGdiZSBhbHJlYWR5IHN1cHBvcnQKPiA+ID4gdGhpcyBmZWF0dXJlLCBUaGlzIHBhdGNo
IHNldCBhbGxvd3MgdmlydGlvLW5ldCB0byBzdXBwb3J0IHhzaydzIHplcm9jb3B5IHhtaXQKPiA+
ID4gZmVhdHVyZS4KPiA+Cj4gPiBZb3UncmUgbW92aW5nIHRoZSBkcml2ZXIgYW5kIGFkZGluZyBh
IG1ham9yIGZlYXR1cmUuCj4gPiBUaGlzIHJlYWxseSBuZWVkcyB0byBnbyB2aWEgbmV0IG9yIGJw
Zi4KPiA+IElmIHlvdSBoYXZlIGRlcGVuZGVuY2llcyBpbiBvdGhlciB0cmVlcyBwbGVhc2Ugd2Fp
dCBmb3IKPiA+IGFmdGVyIHRoZSBtZXJnZSB3aW5kb3cuCj4KPgo+IElmIHNvLCBJIGNhbiByZW1v
dmUgdGhlIGZpcnN0IHR3byBjb21taXRzLgo+Cj4gVGhlbiwgdGhlIHNxIHVzZXMgdGhlIHByZW1h
cHBlZCBtb2RlIGJ5IGRlZmF1bHQuCj4gQW5kIHdlIGNhbiB1c2UgdGhlIGFwaSB2aXJ0cXVldWVf
ZG1hX21hcF9zaW5nbGVfYXR0cnMgdG8gcmVwbGFjZSB0aGUKPiB2aXJ0cXVldWVfZG1hX21hcF9w
YWdlX2F0dHJzLgo+Cj4gQW5kIHRoZW4gSSB3aWxsIGZpeCB0aGF0IG9uIHRoZSB0b3AuCj4KPiBI
aSBNaWNoZWFsIGFuZCBKYXNvbiwgaXMgdGhhdCBvayBmb3IgeW91PwoKSSB3b3VsZCBnbyB3aXRo
IHdoYXQgbG9va3MgZWFzeSBmb3IgeW91IGJ1dCBJIHRoaW5rIEpha3ViIHdhbnRzIHRoZQpzZXJp
ZXMgdG8gZ28gd2l0aCBuZXh0LW5leHQgKHRoaXMgaXMgd2hhdCB3ZSBkaWQgaW4gdGhlIHBhc3Qg
Zm9yCm5ldHdvcmtpbmcgc3BlY2lmaWMgZmVhdHVyZXMgdGhhdCBpcyBkb25lIGluIHZpcnRpby1u
ZXQpLiBTbyB3ZSBuZWVkCnRvIHR3ZWFrIHRoZSBwcmVmaXggdG8gdXNlIG5ldC1uZXh0IGluc3Rl
YWQgb2Ygdmhvc3QuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
