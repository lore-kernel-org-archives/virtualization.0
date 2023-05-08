Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89425C77B73
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 06:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1D0741AE2;
	Mon,  8 May 2023 06:47:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1D0741AE2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YFNOKMBs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wUVb61xzKttj; Mon,  8 May 2023 06:47:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 395E64182C;
	Mon,  8 May 2023 06:47:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 395E64182C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13042C0037;
	Mon,  8 May 2023 06:47:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1872DC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAC6B408B6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:47:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAC6B408B6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YFNOKMBs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dH6BXhPgSdZc
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:47:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17DB340643
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17DB340643
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683528435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPcE+tPXUEU9Pj6uvbRoX+sGl02xWP0SMsbFFZ3dcbg=;
 b=YFNOKMBsD5Bzpd6pPlLaYpcgz7E3wwQ/nuNw/phv4JQ7VHJUUIigynI2W/YWtCqe9fCNA2
 bB2tt0+ARGGvITydKiU3wYen1rYIj5mr1oBrHW0HFssHwlBdn0ZRszpBq/dbxGKoOTu19n
 KEmtIf+k0lz7aOL8KlFAis/hAadngB4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-1GwNmW77P2mJIcFU7cmxoQ-1; Mon, 08 May 2023 02:47:14 -0400
X-MC-Unique: 1GwNmW77P2mJIcFU7cmxoQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f32b3835e9so15131255e9.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 23:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683528433; x=1686120433;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iPcE+tPXUEU9Pj6uvbRoX+sGl02xWP0SMsbFFZ3dcbg=;
 b=JsXBlfHTLk0caBmvpm4kap/2GyWH20rN5eINtmYjHfjedBLyUID0LxxnkSvLXj6wG9
 Quv5VvfbVrvhLAsYAUhOtrdYUjlkrzpn4+i89+AphnrL01rdXej2WBx1eGvzCf3BHLVq
 7Acf744TaW1hqFcNcZ29UQBDEMhitxrNtbzUFCx8L/liuHEBrncCScRdm8mrC2P1REWv
 4m3PhMzlKDeXe4+f+iTFeewy2eFzWYW0HwWOnolL1CzoZwV0SvMddEKe2EsTeLolnBun
 0eTF71XuIRHgugQWYga+XZIQKtSIOkmaguwGt6+zgjqNxEhzZSuNzBqxmjMzn7GTuKCC
 wmog==
X-Gm-Message-State: AC+VfDxImrNvHiBPRNlhScKw7/MiWcslAeU6hCLuzYqLnxs+FCBOSDkt
 qg4Ph2nnOh/+mvDvllNlrE6E79FCTSOfgNfyBLhpGed8E/mlz2RGabOCWW0GJDDRyAqq+Iel/Vh
 0yJBV2vldHXgMNU7Kq3WpLjkqwYuzEiDTpwiAI9jC/g==
X-Received: by 2002:a1c:f704:0:b0:3f1:9526:22be with SMTP id
 v4-20020a1cf704000000b003f1952622bemr6095770wmh.23.1683528433438; 
 Sun, 07 May 2023 23:47:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vYeuFr5Bz2rslLpzPqeYDEDuyU1V6E3rGgoS88aNCbpJ9YMyQlWE3PZrEOwea2SRvN6MNbQ==
X-Received: by 2002:a1c:f704:0:b0:3f1:9526:22be with SMTP id
 v4-20020a1cf704000000b003f1952622bemr6095754wmh.23.1683528433143; 
 Sun, 07 May 2023 23:47:13 -0700 (PDT)
Received: from redhat.com ([31.187.78.15]) by smtp.gmail.com with ESMTPSA id
 2-20020a05600c22c200b003f42328b5d9sm3729073wmg.39.2023.05.07.23.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 May 2023 23:47:12 -0700 (PDT)
Date: Mon, 8 May 2023 02:47:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
Message-ID: <20230508024433-mutt-send-email-mst@kernel.org>
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
 <20230507093328-mutt-send-email-mst@kernel.org>
 <2b5cf90a-efa8-52a7-9277-77722622c128@redhat.com>
 <20230508020717-mutt-send-email-mst@kernel.org>
 <CACGkMEuQdy8xi=eD4v7-UNQ12xOUdnuyQ73vvC6vdGXUfeasug@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuQdy8xi=eD4v7-UNQ12xOUdnuyQ73vvC6vdGXUfeasug@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, willemdebruijn.kernel@gmail.com,
 Wenliang Wang <wangwenliang.1995@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gTW9uLCBNYXkgMDgsIDIwMjMgYXQgMDI6MTM6NDJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIE1heSA4LCAyMDIzIGF0IDI6MDjigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIE1heSAwOCwgMjAyMyBhdCAx
MToxMjowM0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPgo+ID4gPiDlnKggMjAyMy81
LzcgMjE6MzQsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4gT24gRnJpLCBNYXkg
MDUsIDIwMjMgYXQgMTE6Mjg6MjVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+
IE9uIFRodSwgTWF5IDQsIDIwMjMgYXQgMTA6MjfigK9BTSBXZW5saWFuZyBXYW5nCj4gPiA+ID4g
PiA8d2FuZ3dlbmxpYW5nLjE5OTVAYnl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+IEZv
ciBtdWx0aS1xdWV1ZSBhbmQgbGFyZ2UgcmluZy1zaXplIHVzZSBjYXNlLCB0aGUgZm9sbG93aW5n
IGVycm9yCj4gPiA+ID4gPiA+IG9jY3VycmVkIHdoZW4gZnJlZV91bnVzZWRfYnVmczoKPiA+ID4g
PiA+ID4gcmN1OiBJTkZPOiByY3Vfc2NoZWQgc2VsZi1kZXRlY3RlZCBzdGFsbCBvbiBDUFUuCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEZpeGVzOiA5ODZhNGY0ZDQ1MmQgKCJ2aXJ0aW9fbmV0OiBt
dWx0aXF1ZXVlIHN1cHBvcnQiKQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXZW5saWFuZyBX
YW5nIDx3YW5nd2VubGlhbmcuMTk5NUBieXRlZGFuY2UuY29tPgo+ID4gPiA+ID4gPiAtLS0KPiA+
ID4gPiA+ID4gdjI6Cj4gPiA+ID4gPiA+IC1hZGQgbmVlZF9yZXNjaGVkIGNoZWNrLgo+ID4gPiA+
ID4gPiAtYXBwbHkgc2FtZSBsb2dpYyB0byBzcS4KPiA+ID4gPiA+ID4gdjM6Cj4gPiA+ID4gPiA+
IC11c2UgY29uZF9yZXNjaGVkIGluc3RlYWQuCj4gPiA+ID4gPiA+IHY0Ogo+ID4gPiA+ID4gPiAt
YWRkIGZpeGVzIHRhZwo+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gICBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgfCAyICsrCj4gPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+IGluZGV4
IDhkODAzODUzOGZjNC4uYTEyYWUyNmRiMGUyIDEwMDY0NAo+ID4gPiA+ID4gPiAtLS0gYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gPiA+ID4gPiA+IEBAIC0zNTYwLDEyICszNTYwLDE0IEBAIHN0YXRpYyB2b2lkIGZy
ZWVfdW51c2VkX2J1ZnMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgc3RydWN0IHZpcnRxdWV1ZSAqdnEgPSB2aS0+c3FbaV0udnE7Cj4gPiA+ID4g
PiA+ICAgICAgICAgICAgICAgICAgd2hpbGUgKChidWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNl
ZF9idWYodnEpKSAhPSBOVUxMKQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
dmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYodnEsIGJ1Zik7Cj4gPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICBjb25kX3Jlc2NoZWQoKTsKPiA+ID4gPiA+IERvZXMgdGhpcyByZWFsbHkgYWRkcmVz
cyB0aGUgY2FzZSB3aGVuIHRoZSB2aXJ0cXVldWUgaXMgdmVyeSBsYXJnZT8KPiA+ID4gPiA+Cj4g
PiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+IGl0IGRvZXMgaW4gdGhhdCBhIHZlcnkgbGFy
Z2UgcXVldWUgaXMgc3RpbGwganVzdCA2NGsgaW4gc2l6ZS4KPiA+ID4gPiB3ZSBtaWdodCBob3dl
dmVyIGhhdmUgNjRrIG9mIHRoZXNlIHF1ZXVlcy4KPiA+ID4KPiA+ID4KPiA+ID4gT2ssIGJ1dCB3
ZSBoYXZlIG90aGVyIHNpbWlsYXIgbG9vcHMgZXNwZWNpYWxseSB0aGUgcmVmaWxsLCBJIHRoaW5r
IHdlIG1heQo+ID4gPiBuZWVkIGNvbmRfcmVzY2hlZCgpIHRoZXJlIGFzIHdlbGwuCj4gPiA+Cj4g
PiA+IFRoYW5rcwo+ID4gPgo+ID4KPiA+IFJlZmlsbCBpcyBhbHJlYWR5IHBlciB2cSBpc24ndCBp
dD8KPiAKPiBOb3QgZm9yIHRoZSByZWZpbGxfd29yaygpLgo+IAo+IFRoYW5rcwoKR29vZCBwb2lu
dCwgcmVmaWxsX3dvcmsgcHJvYmFibHkgbmVlZHMgY29uZF9yZXNjaGVkLCB0b28uCkFuZCBJIGd1
ZXNzIHZpcnRuZXRfb3Blbj8KCgo+ID4KPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ID4gICAgICAgICAg
fQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgdmktPm1h
eF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgc3RydWN0
IHZpcnRxdWV1ZSAqdnEgPSB2aS0+cnFbaV0udnE7Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgd2hpbGUgKChidWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYodnEpKSAhPSBOVUxM
KQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydG5ldF9ycV9mcmVlX3Vu
dXNlZF9idWYodnEsIGJ1Zik7Cj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBjb25kX3Jlc2No
ZWQoKTsKPiA+ID4gPiA+ID4gICAgICAgICAgfQo+ID4gPiA+ID4gPiAgIH0KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4gMi4yMC4xCj4gPiA+ID4gPiA+Cj4gPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
