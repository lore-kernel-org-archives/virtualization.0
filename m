Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1476C77B70
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 07:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECECB427C7;
	Fri, 14 Apr 2023 07:21:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECECB427C7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TdexjmFg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4DBY39U1JjDo; Fri, 14 Apr 2023 07:21:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9BD6E41F56;
	Fri, 14 Apr 2023 07:21:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BD6E41F56
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50F7BC0036;
	Fri, 14 Apr 2023 07:21:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2785C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 07:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B73778427C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 07:21:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B73778427C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TdexjmFg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F9YipIM-Gyvr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 07:21:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD1F784253
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD1F784253
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 07:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681456905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTjJsirhlxDEZc4I718p3t7VvXQAdTVuI0oKV3etEqI=;
 b=TdexjmFgr916LEWtY7pL8NMoyr4g9u3qm4YyiYXdZelVdzfsy14Z52F+vFtiLVXvZAb7HW
 Lfg9i3slLTWJJY+H+Fjx5B78VMELugk+fnO38ULZgEOMelMiT/7gzfwBdsclcCyKdcQfI0
 EjSiMlJJzd5koRKsO8kZgzWQVjMgCy8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-Wa37eFJrPmeR8x8uB4rgqw-1; Fri, 14 Apr 2023 03:21:43 -0400
X-MC-Unique: Wa37eFJrPmeR8x8uB4rgqw-1
Received: by mail-wr1-f70.google.com with SMTP id
 v16-20020adfa1d0000000b002f64d93cfd4so871365wrv.14
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 00:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681456902; x=1684048902;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JTjJsirhlxDEZc4I718p3t7VvXQAdTVuI0oKV3etEqI=;
 b=YJzRvfaS2tKqEwgrnnYtH0mucx5zfmvqgDcGTXuVszxA2hTxGeNz/boLM3y2OS+4Ao
 2BFjjQRtPMhDJwb69dpfhq2BJeGfxZzP+arv+6GOZ88ebKpthRGMJ/kAV5JFjqTvHLKZ
 ECGTfvOx0olRWY2hKTPLoFVhuplk1nE4PDsWTThZQHC0deklfVCzX8R++GATgELFIUp6
 bRgi11rG6qp9x/+vBlNggIYVyhtGcRShsQ5CI5nKu/1pWh8EM/8IRUtH7aQu09EsnhhS
 wuiGjnOzpAtiL2lvX/OANVb3f23lJ0a7elqHRYs7+UQlYWlVYuIs8plDnAmKZ8VRoxGj
 tdhA==
X-Gm-Message-State: AAQBX9fD7XQzWfCl61PSwxkweP/L/ou0GS/oPAUl9ZmNzOPfkfQkrcys
 ucrPtkYfSfBgMe8mh09I9b4BHiwn7uRXMzctFjF5YWI0LjZxOuHxwXebbsAAAvuj6tJJFBSrBpj
 bDZETEaKsv1/u3475OcjGqlPxmAArkBGsOU8bGmwDqA==
X-Received: by 2002:a5d:4a08:0:b0:2f5:ac53:c04f with SMTP id
 m8-20020a5d4a08000000b002f5ac53c04fmr3170059wrq.28.1681456902559; 
 Fri, 14 Apr 2023 00:21:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350bqKuA6wEn8KG9TLRorONonLbSvcTi6eFu6zegtkFvV5OooP0P7OCyktwlDyHT+JvevAlI3IQ==
X-Received: by 2002:a5d:4a08:0:b0:2f5:ac53:c04f with SMTP id
 m8-20020a5d4a08000000b002f5ac53c04fmr3170036wrq.28.1681456902179; 
 Fri, 14 Apr 2023 00:21:42 -0700 (PDT)
Received: from redhat.com ([2a06:c701:742d:fd00:c847:221d:9254:f7ce])
 by smtp.gmail.com with ESMTPSA id
 h8-20020adfe988000000b002efdf3e5be0sm2905088wrm.44.2023.04.14.00.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Apr 2023 00:21:41 -0700 (PDT)
Date: Fri, 14 Apr 2023 03:21:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230414031947-mutt-send-email-mst@kernel.org>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, maxime.coquelin@redhat.com,
 kuba@kernel.org, pabeni@redhat.com, david.marchand@redhat.com,
 davem@davemloft.net
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

T24gRnJpLCBBcHIgMTQsIDIwMjMgYXQgMDE6MDQ6MTVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBGb3JnZXQgdG8gY2MgbmV0ZGV2LCBhZGRpbmcuCj4gCj4gT24gRnJpLCBBcHIgMTQsIDIw
MjMgYXQgMTI6MjXigK9BTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90
ZToKPiA+Cj4gPiBPbiBUaHUsIEFwciAxMywgMjAyMyBhdCAwMjo0MDoyNlBNICswODAwLCBKYXNv
biBXYW5nIHdyb3RlOgo+ID4gPiBUaGlzIHBhdGNoIGNvbnZlcnQgcnggbW9kZSBzZXR0aW5nIHRv
IGJlIGRvbmUgaW4gYSB3b3JrcXVldWUsIHRoaXMgaXMKPiA+ID4gYSBtdXN0IGZvciBhbGxvdyB0
byBzbGVlcCB3aGVuIHdhaXRpbmcgZm9yIHRoZSBjdnEgY29tbWFuZCB0bwo+ID4gPiByZXNwb25z
ZSBzaW5jZSBjdXJyZW50IGNvZGUgaXMgZXhlY3V0ZWQgdW5kZXIgYWRkciBzcGluIGxvY2suCj4g
PiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
Cj4gPgo+ID4gSSBkb24ndCBsaWtlIHRoaXMgZnJhbmtseS4gVGhpcyBtZWFucyB0aGF0IHNldHRp
bmcgUlggbW9kZSB3aGljaCB3b3VsZAo+ID4gcHJldmlvdXNseSBiZSByZWxpYWJsZSwgbm93IGJl
Y29tZXMgdW5yZWxpYWJsZS4KPiAKPiBJdCBpcyAidW5yZWxpYWJsZSIgYnkgZGVzaWduOgo+IAo+
ICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICgqbmRvX3NldF9yeF9tb2RlKShzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2KTsKPiAKPiA+IC0gZmlyc3Qgb2YgYWxsIGNvbmZpZ3VyYXRpb24gaXMg
bm8gbG9uZ2VyIGltbWVkaWF0ZQo+IAo+IElzIGltbWVkaWF0ZSBhIGhhcmQgcmVxdWlyZW1lbnQ/
IEkgY2FuIHNlZSBhIHdvcmtxdWV1ZSBpcyB1c2VkIGF0IGxlYXN0Ogo+IAo+IG1seDVlLCBpcG9p
YiwgZWZ4LCAuLi4KPiAKPiA+ICAgYW5kIHRoZXJlIGlzIG5vIHdheSBmb3IgZHJpdmVyIHRvIGZp
bmQgb3V0IHdoZW4KPiA+ICAgaXQgYWN0dWFsbHkgdG9vayBlZmZlY3QKPiAKPiBCdXQgd2Uga25v
dyByeCBtb2RlIGlzIGJlc3QgZWZmb3J0IGUuZyBpdCBkb2Vzbid0IHN1cHBvcnQgdmhvc3QgYW5k
IHdlCj4gc3Vydml2ZSBmcm9tIHRoaXMgZm9yIHllYXJzLgo+IAo+ID4gLSBzZWNvbmQsIGlmIGRl
dmljZSBmYWlscyBjb21tYW5kLCB0aGlzIGlzIGFsc28gbm90Cj4gPiAgIHByb3BhZ2F0ZWQgdG8g
ZHJpdmVyLCBhZ2FpbiBubyB3YXkgZm9yIGRyaXZlciB0byBmaW5kIG91dAo+ID4KPiA+IFZEVVNF
IG5lZWRzIHRvIGJlIGZpeGVkIHRvIGRvIHRyaWNrcyB0byBmaXggdGhpcwo+ID4gd2l0aG91dCBi
cmVha2luZyBub3JtYWwgZHJpdmVycy4KPiAKPiBJdCdzIG5vdCBzcGVjaWZpYyB0byBWRFVTRS4g
Rm9yIGV4YW1wbGUsIHdoZW4gdXNpbmcgdmlydGlvLW5ldCBpbiB0aGUKPiBVUCBlbnZpcm9ubWVu
dCB3aXRoIGFueSBzb2Z0d2FyZSBjdnEgKGxpa2UgbWx4NSB2aWEgdkRQQSBvciBjbWEKPiB0cmFu
c3BvcnQpLgo+IAo+IFRoYW5rcwoKSG1tLiBDYW4gd2UgZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRo
ZXNlIHVzZS1jYXNlcz8KCj4gPgo+ID4KPiA+ID4gLS0tCj4gPiA+IENoYW5nZXMgc2luY2UgVjE6
Cj4gPiA+IC0gdXNlIFJUTkwgdG8gc3luY2hyb25pemUgcnggbW9kZSB3b3JrZXIKPiA+ID4gLS0t
Cj4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA1NSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiBpbmRleCBlMjU2
MGI2Zjc5ODAuLjJlNTZiYmY4Njg5NCAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiBAQCAt
MjY1LDYgKzI2NSwxMiBAQCBzdHJ1Y3QgdmlydG5ldF9pbmZvIHsKPiA+ID4gICAgICAgLyogV29y
ayBzdHJ1Y3QgZm9yIGNvbmZpZyBzcGFjZSB1cGRhdGVzICovCj4gPiA+ICAgICAgIHN0cnVjdCB3
b3JrX3N0cnVjdCBjb25maWdfd29yazsKPiA+ID4KPiA+ID4gKyAgICAgLyogV29yayBzdHJ1Y3Qg
Zm9yIGNvbmZpZyByeCBtb2RlICovCj4gPiA+ICsgICAgIHN0cnVjdCB3b3JrX3N0cnVjdCByeF9t
b2RlX3dvcms7Cj4gPiA+ICsKPiA+ID4gKyAgICAgLyogSXMgcnggbW9kZSB3b3JrIGVuYWJsZWQ/
ICovCj4gPiA+ICsgICAgIGJvb2wgcnhfbW9kZV93b3JrX2VuYWJsZWQ7Cj4gPiA+ICsKPiA+ID4g
ICAgICAgLyogRG9lcyB0aGUgYWZmaW5pdHkgaGludCBpcyBzZXQgZm9yIHZpcnRxdWV1ZXM/ICov
Cj4gPiA+ICAgICAgIGJvb2wgYWZmaW5pdHlfaGludF9zZXQ7Cj4gPiA+Cj4gPiA+IEBAIC0zODgs
NiArMzk0LDIwIEBAIHN0YXRpYyB2b2lkIGRpc2FibGVfZGVsYXllZF9yZWZpbGwoc3RydWN0IHZp
cnRuZXRfaW5mbyAqdmkpCj4gPiA+ICAgICAgIHNwaW5fdW5sb2NrX2JoKCZ2aS0+cmVmaWxsX2xv
Y2spOwo+ID4gPiAgfQo+ID4gPgo+ID4gPiArc3RhdGljIHZvaWQgZW5hYmxlX3J4X21vZGVfd29y
ayhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiA+ID4gK3sKPiA+ID4gKyAgICAgcnRubF9sb2Nr
KCk7Cj4gPiA+ICsgICAgIHZpLT5yeF9tb2RlX3dvcmtfZW5hYmxlZCA9IHRydWU7Cj4gPiA+ICsg
ICAgIHJ0bmxfdW5sb2NrKCk7Cj4gPiA+ICt9Cj4gPiA+ICsKPiA+ID4gK3N0YXRpYyB2b2lkIGRp
c2FibGVfcnhfbW9kZV93b3JrKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ID4gPiArewo+ID4g
PiArICAgICBydG5sX2xvY2soKTsKPiA+ID4gKyAgICAgdmktPnJ4X21vZGVfd29ya19lbmFibGVk
ID0gZmFsc2U7Cj4gPiA+ICsgICAgIHJ0bmxfdW5sb2NrKCk7Cj4gPiA+ICt9Cj4gPiA+ICsKPiA+
ID4gIHN0YXRpYyB2b2lkIHZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxlKHN0cnVjdCBuYXBpX3N0cnVj
dCAqbmFwaSwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2
aXJ0cXVldWUgKnZxKQo+ID4gPiAgewo+ID4gPiBAQCAtMjMxMCw5ICsyMzMwLDExIEBAIHN0YXRp
YyBpbnQgdmlydG5ldF9jbG9zZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiAgICAgICBy
ZXR1cm4gMDsKPiA+ID4gIH0KPiA+ID4KPiA+ID4gLXN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4
X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRf
cnhfbW9kZV93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiA+ID4gIHsKPiA+ID4gLSAg
ICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOwo+ID4gPiArICAg
ICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9Cj4gPiA+ICsgICAgICAgICAgICAgY29udGFpbmVy
X29mKHdvcmssIHN0cnVjdCB2aXJ0bmV0X2luZm8sIHJ4X21vZGVfd29yayk7Cj4gPiA+ICsgICAg
IHN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSB2aS0+ZGV2Owo+ID4gPiAgICAgICBzdHJ1Y3Qgc2Nh
dHRlcmxpc3Qgc2dbMl07Cj4gPiA+ICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2N0cmxfbWFjICpt
YWNfZGF0YTsKPiA+ID4gICAgICAgc3RydWN0IG5ldGRldl9od19hZGRyICpoYTsKPiA+ID4gQEAg
LTIzMjUsNiArMjM0Nyw4IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0
IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gICAgICAgaWYgKCF2aXJ0aW9faGFzX2ZlYXR1cmUodmkt
PnZkZXYsIFZJUlRJT19ORVRfRl9DVFJMX1JYKSkKPiA+ID4gICAgICAgICAgICAgICByZXR1cm47
Cj4gPiA+Cj4gPiA+ICsgICAgIHJ0bmxfbG9jaygpOwo+ID4gPiArCj4gPiA+ICAgICAgIHZpLT5j
dHJsLT5wcm9taXNjID0gKChkZXYtPmZsYWdzICYgSUZGX1BST01JU0MpICE9IDApOwo+ID4gPiAg
ICAgICB2aS0+Y3RybC0+YWxsbXVsdGkgPSAoKGRldi0+ZmxhZ3MgJiBJRkZfQUxMTVVMVEkpICE9
IDApOwo+ID4gPgo+ID4gPiBAQCAtMjM0MiwxNCArMjM2NiwxOSBAQCBzdGF0aWMgdm9pZCB2aXJ0
bmV0X3NldF9yeF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ICAgICAgICAgICAg
ICAgZGV2X3dhcm4oJmRldi0+ZGV2LCAiRmFpbGVkIHRvICVzYWJsZSBhbGxtdWx0aSBtb2RlLlxu
IiwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICB2aS0+Y3RybC0+YWxsbXVsdGkgPyAiZW4i
IDogImRpcyIpOwo+ID4gPgo+ID4gPiArICAgICBuZXRpZl9hZGRyX2xvY2tfYmgoZGV2KTsKPiA+
ID4gKwo+ID4gPiAgICAgICB1Y19jb3VudCA9IG5ldGRldl91Y19jb3VudChkZXYpOwo+ID4gPiAg
ICAgICBtY19jb3VudCA9IG5ldGRldl9tY19jb3VudChkZXYpOwo+ID4gPiAgICAgICAvKiBNQUMg
ZmlsdGVyIC0gdXNlIG9uZSBidWZmZXIgZm9yIGJvdGggbGlzdHMgKi8KPiA+ID4gICAgICAgYnVm
ID0ga3phbGxvYygoKHVjX2NvdW50ICsgbWNfY291bnQpICogRVRIX0FMRU4pICsKPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAoMiAqIHNpemVvZihtYWNfZGF0YS0+ZW50cmllcykpLCBHRlBfQVRP
TUlDKTsKPiA+ID4gICAgICAgbWFjX2RhdGEgPSBidWY7Cj4gPiA+IC0gICAgIGlmICghYnVmKQo+
ID4gPiArICAgICBpZiAoIWJ1Zikgewo+ID4gPiArICAgICAgICAgICAgIG5ldGlmX2FkZHJfdW5s
b2NrX2JoKGRldik7Cj4gPiA+ICsgICAgICAgICAgICAgcnRubF91bmxvY2soKTsKPiA+ID4gICAg
ICAgICAgICAgICByZXR1cm47Cj4gPiA+ICsgICAgIH0KPiA+ID4KPiA+ID4gICAgICAgc2dfaW5p
dF90YWJsZShzZywgMik7Cj4gPiA+Cj4gPiA+IEBAIC0yMzcwLDYgKzIzOTksOCBAQCBzdGF0aWMg
dm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ICAg
ICAgIG5ldGRldl9mb3JfZWFjaF9tY19hZGRyKGhhLCBkZXYpCj4gPiA+ICAgICAgICAgICAgICAg
bWVtY3B5KCZtYWNfZGF0YS0+bWFjc1tpKytdWzBdLCBoYS0+YWRkciwgRVRIX0FMRU4pOwo+ID4g
Pgo+ID4gPiArICAgICBuZXRpZl9hZGRyX3VubG9ja19iaChkZXYpOwo+ID4gPiArCj4gPiA+ICAg
ICAgIHNnX3NldF9idWYoJnNnWzFdLCBtYWNfZGF0YSwKPiA+ID4gICAgICAgICAgICAgICAgICBz
aXplb2YobWFjX2RhdGEtPmVudHJpZXMpICsgKG1jX2NvdW50ICogRVRIX0FMRU4pKTsKPiA+ID4K
PiA+ID4gQEAgLTIzNzcsOSArMjQwOCwxOSBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9t
b2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgVklSVElPX05FVF9DVFJMX01BQ19UQUJMRV9TRVQsIHNnKSkKPiA+ID4gICAgICAg
ICAgICAgICBkZXZfd2FybigmZGV2LT5kZXYsICJGYWlsZWQgdG8gc2V0IE1BQyBmaWx0ZXIgdGFi
bGUuXG4iKTsKPiA+ID4KPiA+ID4gKyAgICAgcnRubF91bmxvY2soKTsKPiA+ID4gKwo+ID4gPiAg
ICAgICBrZnJlZShidWYpOwo+ID4gPiAgfQo+ID4gPgo+ID4gPiArc3RhdGljIHZvaWQgdmlydG5l
dF9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiArewo+ID4gPiArICAg
ICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gPiA+ICsKPiA+
ID4gKyAgICAgaWYgKHZpLT5yeF9tb2RlX3dvcmtfZW5hYmxlZCkKPiA+ID4gKyAgICAgICAgICAg
ICBzY2hlZHVsZV93b3JrKCZ2aS0+cnhfbW9kZV93b3JrKTsKPiA+ID4gK30KPiA+ID4gKwo+ID4g
PiAgc3RhdGljIGludCB2aXJ0bmV0X3ZsYW5fcnhfYWRkX3ZpZChzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2LAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2JlMTYgcHJvdG8s
IHUxNiB2aWQpCj4gPiA+ICB7Cj4gPiA+IEBAIC0zMTUwLDYgKzMxOTEsOCBAQCBzdGF0aWMgdm9p
ZCB2aXJ0bmV0X2ZyZWV6ZV9kb3duKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPgo+
ID4gPiAgICAgICAvKiBNYWtlIHN1cmUgbm8gd29yayBoYW5kbGVyIGlzIGFjY2Vzc2luZyB0aGUg
ZGV2aWNlICovCj4gPiA+ICAgICAgIGZsdXNoX3dvcmsoJnZpLT5jb25maWdfd29yayk7Cj4gPiA+
ICsgICAgIGRpc2FibGVfcnhfbW9kZV93b3JrKHZpKTsKPiA+ID4gKyAgICAgZmx1c2hfd29yaygm
dmktPnJ4X21vZGVfd29yayk7Cj4gPiA+Cj4gPiA+ICAgICAgIG5ldGlmX3R4X2xvY2tfYmgodmkt
PmRldik7Cj4gPiA+ICAgICAgIG5ldGlmX2RldmljZV9kZXRhY2godmktPmRldik7Cj4gPgo+ID4g
U28gbm93IGNvbmZpZ3VyYXRpb24gaXMgbm90IHByb3BhZ2F0ZWQgdG8gZGV2aWNlLgo+ID4gV29u
J3QgZGV2aWNlIGxhdGVyIHdha2UgdXAgaW4gd3Jvbmcgc3RhdGU/Cj4gPgo+ID4KPiA+ID4gQEAg
LTMxNzIsNiArMzIxNSw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9yZXN0b3JlX3VwKHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiAgICAgICB2aXJ0aW9fZGV2aWNlX3JlYWR5KHZkZXYp
Owo+ID4gPgo+ID4gPiAgICAgICBlbmFibGVfZGVsYXllZF9yZWZpbGwodmkpOwo+ID4gPiArICAg
ICBlbmFibGVfcnhfbW9kZV93b3JrKHZpKTsKPiA+ID4KPiA+ID4gICAgICAgaWYgKG5ldGlmX3J1
bm5pbmcodmktPmRldikpIHsKPiA+ID4gICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X29wZW4o
dmktPmRldik7Cj4gPiA+IEBAIC0zOTY5LDYgKzQwMTMsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRf
cHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiA+ICAgICAgIHZkZXYtPnByaXYg
PSB2aTsKPiA+ID4KPiA+ID4gICAgICAgSU5JVF9XT1JLKCZ2aS0+Y29uZmlnX3dvcmssIHZpcnRu
ZXRfY29uZmlnX2NoYW5nZWRfd29yayk7Cj4gPiA+ICsgICAgIElOSVRfV09SSygmdmktPnJ4X21v
ZGVfd29yaywgdmlydG5ldF9yeF9tb2RlX3dvcmspOwo+ID4gPiAgICAgICBzcGluX2xvY2tfaW5p
dCgmdmktPnJlZmlsbF9sb2NrKTsKPiA+ID4KPiA+ID4gICAgICAgaWYgKHZpcnRpb19oYXNfZmVh
dHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKSkgewo+ID4gPiBAQCAtNDA3Nyw2ICs0
MTIyLDggQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2
ZGV2KQo+ID4gPiAgICAgICBpZiAodmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBv
cnQpCj4gPiA+ICAgICAgICAgICAgICAgdmlydG5ldF9pbml0X2RlZmF1bHRfcnNzKHZpKTsKPiA+
ID4KPiA+ID4gKyAgICAgZW5hYmxlX3J4X21vZGVfd29yayh2aSk7Cj4gPiA+ICsKPiA+ID4gICAg
ICAgLyogc2VyaWFsaXplIG5ldGRldiByZWdpc3RlciArIHZpcnRpb19kZXZpY2VfcmVhZHkoKSB3
aXRoIG5kb19vcGVuKCkgKi8KPiA+ID4gICAgICAgcnRubF9sb2NrKCk7Cj4gPiA+Cj4gPiA+IEBA
IC00MTc0LDYgKzQyMjEsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3JlbW92ZShzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldikKPiA+ID4KPiA+ID4gICAgICAgLyogTWFrZSBzdXJlIG5vIHdvcmsg
aGFuZGxlciBpcyBhY2Nlc3NpbmcgdGhlIGRldmljZS4gKi8KPiA+ID4gICAgICAgZmx1c2hfd29y
aygmdmktPmNvbmZpZ193b3JrKTsKPiA+ID4gKyAgICAgZGlzYWJsZV9yeF9tb2RlX3dvcmsodmkp
Owo+ID4gPiArICAgICBmbHVzaF93b3JrKCZ2aS0+cnhfbW9kZV93b3JrKTsKPiA+ID4KPiA+ID4g
ICAgICAgdW5yZWdpc3Rlcl9uZXRkZXYodmktPmRldik7Cj4gPiA+Cj4gPiA+IC0tCj4gPiA+IDIu
MjUuMQo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
