Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA9ACDB474
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 06:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E487040467;
	Tue, 17 Oct 2023 06:26:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E487040467
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=igkcN6FE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mwj04hPsch_l; Tue, 17 Oct 2023 06:26:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 93F514000B;
	Tue, 17 Oct 2023 06:26:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93F514000B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 679F9C0071;
	Tue, 17 Oct 2023 06:26:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD881C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 06:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8AF67612E5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 06:26:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AF67612E5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=igkcN6FE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r7NhwpH5OAKF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 06:26:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03F87612E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 06:26:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03F87612E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697523976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcaG2z5+seD02JuJsqXV0toO2m3nASDln19wJdTBNSA=;
 b=igkcN6FEUZ5558h/h9TLEvHE18jaNLgMdvFJdwoKcn+dv89bOMYw7ewyf8/67alkPAVTkV
 j8IeCI3pIgLC/07UTL8Gq1AEZofIMqf4ot319wW6CNaYELmgFJGnzJg19SMEeHOrDXcpGU
 wmqpXRbstToiM4MD++3dOs2geHJxZHI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-iW4PbjbKOtmUKMd0UJrGLA-1; Tue, 17 Oct 2023 02:26:14 -0400
X-MC-Unique: iW4PbjbKOtmUKMd0UJrGLA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5042eca54a4so5424524e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 23:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523973; x=1698128773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcaG2z5+seD02JuJsqXV0toO2m3nASDln19wJdTBNSA=;
 b=aJH7rDyVGfc4cBMyUaG6JNDvEXV5lJliapgVi5yLKq5CGyAjl16BnzUteAmuoPnvX1
 fFBfMv0uOHpgJYvpzXdQhwpDKs4VEy8SnU6lnyTwD9IJBjgHvyCBRMhevpTVnFJ0TNhW
 8T7HTEI+jzhgaionzm1gYlH4BBHEscItC38seFe3tJhi+yLxbMAQwbIiiKAQonbKiRip
 JE4fS5yJ5wRscIclpf5ZDqrRTMQaL6rC0MRs0gY/i3xRsVrRtLCpH0olr8pfaK7RYg9b
 XFafF6pgIT+W4iTbsBc16vHppEk72RWahcHtCVjYWAfHOnhZuLhQ3LarM7HQh3vMmp87
 ckrg==
X-Gm-Message-State: AOJu0Yw5J72OzACl6+RXHWRfnx3Y11Ii6JFRzo/l+0WyocXKmvTwRO48
 IcOj2nz0ZUmM9Tu9CFCcFfKyuO3k/18Ymhbz/OKZIYqcqqLWUpT2fbADB67aeqxK5kY4b0thOm9
 XfmZGsbQrM4UYOusPQCfGzqbfyPy0ga5I3lpPvr58VA8pnHDdPMHQT+9yvg==
X-Received: by 2002:a05:6512:3136:b0:4fd:c715:5667 with SMTP id
 p22-20020a056512313600b004fdc7155667mr868621lfd.20.1697523973053; 
 Mon, 16 Oct 2023 23:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSUPTSuD1Jm/V+aUhJ3uWkN9SjF1Cht6y1EuRCE2wfX219UUhHhdkSeSqL7RFBkaej7beIxS8ohJcnqrYRbkI=
X-Received: by 2002:a05:6512:3136:b0:4fd:c715:5667 with SMTP id
 p22-20020a056512313600b004fdc7155667mr868609lfd.20.1697523972644; Mon, 16 Oct
 2023 23:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
 <1697511725.2037013-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
 <1697512950.0813534-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtppjoX_WAM+vjzkMKaMQQ0iZL=C_xS4RObuoLbm0udUw@mail.gmail.com>
 <CACGkMEvWAhH3uj2DEo=m7qWg3-pQjE-EtEBvTT8JXzqZ+RYEXQ@mail.gmail.com>
 <1697522771.0390663-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1697522771.0390663-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 14:26:01 +0800
Message-ID: <CACGkMEu4tSHd4RVo0zEp1A6uM-6h42y+yAB2xzHTv8SzYdZPXQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
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

T24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgMjoxN+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCAxNyBPY3QgMjAyMyAxMzoyNzo0NyAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUs
IE9jdCAxNywgMjAyMyBhdCAxMToyOOKAr0FNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBUdWUsIE9jdCAxNywgMjAyMyBhdCAxMToyNuKAr0FN
IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4g
PiA+ID4gT24gVHVlLCAxNyBPY3QgMjAyMyAxMToyMDo0MSArMDgwMCwgSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiBPbiBUdWUsIE9jdCAxNywgMjAyMyBh
dCAxMToxMeKAr0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3Rl
Ogo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiBUdWUsIDE3IE9jdCAyMDIzIDEwOjUzOjQ0ICsw
ODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4g
PiBPbiBNb24sIE9jdCAxNiwgMjAyMyBhdCA4OjAw4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0Bs
aW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
IyMgQUZfWERQCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gWERQIHNvY2tldChBRl9Y
RFApIGlzIGFuIGV4Y2VsbGVudCBieXBhc3Mga2VybmVsIG5ldHdvcmsgZnJhbWV3b3JrLiBUaGUg
emVybwo+ID4gPiA+ID4gPiA+ID4gY29weSBmZWF0dXJlIG9mIHhzayAoWERQIHNvY2tldCkgbmVl
ZHMgdG8gYmUgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIuIFRoZQo+ID4gPiA+ID4gPiA+ID4gcGVy
Zm9ybWFuY2Ugb2YgemVybyBjb3B5IGlzIHZlcnkgZ29vZC4gbWx4NSBhbmQgaW50ZWwgaXhnYmUg
YWxyZWFkeSBzdXBwb3J0Cj4gPiA+ID4gPiA+ID4gPiB0aGlzIGZlYXR1cmUsIFRoaXMgcGF0Y2gg
c2V0IGFsbG93cyB2aXJ0aW8tbmV0IHRvIHN1cHBvcnQgeHNrJ3MgemVyb2NvcHkgeG1pdAo+ID4g
PiA+ID4gPiA+ID4gZmVhdHVyZS4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBBdCBw
cmVzZW50LCB3ZSBoYXZlIGNvbXBsZXRlZCBzb21lIHByZXBhcmF0aW9uOgo+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+IDEuIHZxLXJlc2V0ICh2aXJ0aW8gc3BlYyBhbmQga2VybmVsIGNv
ZGUpCj4gPiA+ID4gPiA+ID4gPiAyLiB2aXJ0aW8tY29yZSBwcmVtYXBwZWQgZG1hCj4gPiA+ID4g
PiA+ID4gPiAzLiB2aXJ0aW8tbmV0IHhkcCByZWZhY3Rvcgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+IFNvIGl0IGlzIHRpbWUgZm9yIFZpcnRpby1OZXQgdG8gY29tcGxldGUgdGhlIHN1
cHBvcnQgZm9yIHRoZSBYRFAgU29ja2V0Cj4gPiA+ID4gPiA+ID4gPiBaZXJvY29weS4KPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBWaXJ0aW8tbmV0IGNhbiBub3QgaW5jcmVhc2UgdGhl
IHF1ZXVlIG51bSBhdCB3aWxsLCBzbyB4c2sgc2hhcmVzIHRoZSBxdWV1ZSB3aXRoCj4gPiA+ID4g
PiA+ID4gPiBrZXJuZWwuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gT24gdGhlIG90
aGVyIGhhbmQsIFZpcnRpby1OZXQgZG9lcyBub3Qgc3VwcG9ydCBnZW5lcmF0ZSBpbnRlcnJ1cHQg
ZnJvbSBkcml2ZXIKPiA+ID4gPiA+ID4gPiA+IG1hbnVhbGx5LCBzbyB3aGVuIHdlIHdha2V1cCB0
eCB4bWl0LCB3ZSB1c2VkIHNvbWUgdGlwcy4gSWYgdGhlIENQVSBydW4gYnkgVFgKPiA+ID4gPiA+
ID4gPiA+IE5BUEkgbGFzdCB0aW1lIGlzIG90aGVyIENQVXMsIHVzZSBJUEkgdG8gd2FrZSB1cCBO
QVBJIG9uIHRoZSByZW1vdGUgQ1BVLiBJZiBpdAo+ID4gPiA+ID4gPiA+ID4gaXMgYWxzbyB0aGUg
bG9jYWwgQ1BVLCB0aGVuIHdlIHdha2UgdXAgbmFwaSBkaXJlY3RseS4KPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiBUaGlzIHBhdGNoIHNldCBpbmNsdWRlcyBzb21lIHJlZmFjdG9yIHRv
IHRoZSB2aXJ0aW8tbmV0IHRvIGxldCB0aGF0IHRvIHN1cHBvcnQKPiA+ID4gPiA+ID4gPiA+IEFG
X1hEUC4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiAjIyBwZXJmb3JtYW5jZQo+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEVOVjogUWVtdSB3aXRoIHZob3N0LXVzZXIocG9s
bGluZyBtb2RlKS4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBTb2NrcGVyZjogaHR0
cHM6Ly9naXRodWIuY29tL01lbGxhbm94L3NvY2twZXJmCj4gPiA+ID4gPiA+ID4gPiBJIHVzZSB0
aGlzIHRvb2wgdG8gc2VuZCB1ZHAgcGFja2V0IGJ5IGtlcm5lbCBzeXNjYWxsLgo+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+IHhtaXQgY29tbWFuZDogc29ja3BlcmYgdHAgLWkgMTAuMC4z
LjEgLXQgMTAwMAo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEkgd3JpdGUgYSB0b29s
IHRoYXQgc2VuZHMgdWRwIHBhY2tldHMgb3IgcmVjdnMgdWRwIHBhY2tldHMgYnkgQUZfWERQLgo+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgIHwgR3Vlc3Qg
QVBQIENQVSB8R3Vlc3QgU29mdGlycSBDUFUgfCBVRFAgUFBTCj4gPiA+ID4gPiA+ID4gPiAtLS0t
LS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0t
LS0tLS0KPiA+ID4gPiA+ID4gPiA+IHhtaXQgYnkgc3lzY2FsbCAgIHwgICAxMDAlICAgICAgICB8
ICAgICAgICAgICAgICAgICAgfCAgIDY3Niw5MTUKPiA+ID4gPiA+ID4gPiA+IHhtaXQgYnkgeHNr
ICAgICAgIHwgICA1OS4xJSAgICAgICB8ICAgMTAwJSAgICAgICAgICAgfCA1LDQ0NywxNjgKPiA+
ID4gPiA+ID4gPiA+IHJlY3YgYnkgc3lzY2FsbCAgIHwgICA2MCUgICAgICAgICB8ICAgMTAwJSAg
ICAgICAgICAgfCAgIDkzMiwyODgKPiA+ID4gPiA+ID4gPiA+IHJlY3YgYnkgeHNrICAgICAgIHwg
ICAzNS43JSAgICAgICB8ICAgMTAwJSAgICAgICAgICAgfCAzLDM0MywxNjgKPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+IEFueSBjaGFuY2Ugd2UgY2FuIGdldCBhIHRlc3RwbWQgcmVzdWx0ICh3
aGljaCBJIGd1ZXNzIHNob3VsZCBiZSBiZXR0ZXIKPiA+ID4gPiA+ID4gPiB0aGFuIFBQUyBhYm92
ZSk/Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IERvIHlvdSBtZWFuIHRlc3RwbWQgKyBEUERLICsg
QUZfWERQPwo+ID4gPiA+ID4KPiA+ID4gPiA+IFllcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+IFllcy4gVGhpcyBpcyBwcm9iYWJseSBiZXR0ZXIgYmVjYXVzZSBteSB0b29sIGRv
ZXMgbW9yZSB3b3JrLiBUaGF0IGlzIG5vdCBhCj4gPiA+ID4gPiA+IGNvbXBsZXRlIHRlc3Rpbmcg
dG9vbCB1c2VkIGJ5IG91ciBidXNpbmVzcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBQcm9iYWJseSwg
YnV0IGl0IHdvdWxkIGJlIGFwcGVhbGluZyBmb3Igb3RoZXJzLiBFc3BlY2lhbGx5IGNvbnNpZGVy
aW5nCj4gPiA+ID4gPiBEUERLIHN1cHBvcnRzIEFGX1hEUCBQTUQgbm93Lgo+ID4gPiA+Cj4gPiA+
ID4gT0suCj4gPiA+ID4KPiA+ID4gPiBMZXQgbWUgdHJ5Lgo+ID4gPiA+Cj4gPiA+ID4gQnV0IGNv
dWxkIHlvdSBzdGFydCB0byByZXZpZXcgZmlyc3RseT8KPiA+ID4KPiA+ID4gWWVzLCBpdCdzIGlu
IG15IHRvZG8gbGlzdC4KPiA+Cj4gPiBTcGVha2luZyB0b28gZmFzdCwgSSB0aGluayBpZiBpdCBk
b2Vzbid0IHRha2UgdG9vIGxvbmcgdGltZSwgSSB3b3VsZAo+ID4gd2FpdCBmb3IgdGhlIHJlc3Vs
dCBmaXJzdCBhcyBuZXRkaW0gc2VyaWVzLiBPbmUgcmVhc29uIGlzIHRoYXQgSQo+ID4gcmVtZW1i
ZXIgY2xhaW1zIHRvIGJlIG9ubHkgMTAlIHRvIDIwJSBsb3NzIGNvbXBhcmluZyB0byB3aXJlIHNw
ZWVkLCBzbwo+ID4gSSdkIGV4cGVjdCBpdCBzaG91bGQgYmUgbXVjaCBmYXN0ZXIuIEkgdmFndWVs
eSByZW1lbWJlciwgZXZlbiBhIHZob3N0Cj4gPiBjYW4gZ2l2ZXMgdXMgbW9yZSB0aGFuIDNNIFBQ
UyBpZiB3ZSBkaXNhYmxlIFNNQVAsIHNvIHRoZSBudW1iZXJzIGhlcmUKPiA+IGFyZSBub3QgYXMg
aW1wcmVzc2l2ZSBhcyBleHBlY3RlZC4KPgo+Cj4gV2hhdCBpcyBTTUFQPyBDbG91ZCB5b3UgZ2l2
ZSBtZSBtb3JlIGluZm8/CgpTdXBlcnZpc29yIE1vZGUgQWNjZXNzIFByZXZlbnRpb24KClZob3N0
IHN1ZmZlcnMgZnJvbSB0aGlzLgoKPgo+IFNvIGlmIHdlIHRoaW5rIHRoZSAzTSBhcyB0aGUgd2ly
ZSBzcGVlZCwgeW91IGV4cGVjdCB0aGUgcmVzdWx0Cj4gY2FuIHJlYWNoIDIuOE0gcHBzL2NvcmUs
IHJpZ2h0PwoKSXQncyBBRl9YRFAgdGhhdCBjbGFpbXMgdG8gYmUgODAlIGlmIG15IG1lbW9yeSBp
cyBjb3JyZWN0LiBTbyBhCmNvcnJlY3QgQUZfWERQIGltcGxlbWVudGF0aW9uIHNob3VsZCBub3Qg
c2l0IGJlaGluZCB0aGlzIHRvbyBtdWNoLgoKPiBOb3cgdGhlIHJlY3YgcmVzdWx0IGlzIDIuNU0o
MjQ2MzY0NikgcHBzL2NvcmUuCj4gRG8geW91IHRoaW5rIHRoZXJlIGlzIGEgaHVnZSBnYXA/CgpZ
b3UgbmV2ZXIgZGVzY3JpYmUgeW91ciB0ZXN0aW5nIGVudmlyb25tZW50IGluIGRldGFpbHMuIEZv
ciBleGFtcGxlLAppcyB0aGlzIGEgdmlydHVhbCBlbnZpcm9ubWVudD8gV2hhdCdzIHRoZSBDUFUg
bW9kZWwgYW5kIGZyZXF1ZW5jeSBldGMuCgpCZWNhdXNlIEkgbmV2ZXIgc2VlIGEgTklDIHdob3Nl
IHdpcmUgc3BlZWQgaXMgM00uCgo+Cj4gTXkgdG9vbCBtYWtlcyB1ZHAgcGFja2V0IGFuZCBsb29r
dXAgcm91dGUsIHNvIGl0IHRha2UgbW9yZSBtdWNoIGNwdS4KClRoYXQncyB3aHkgSSBzdWdnZXN0
IHlvdSB0byB0ZXN0IHJhdyBQUFMuCgpUaGFua3MKCj4KPiBJIGFtIGNvbmZ1c2VkLgo+Cj4KPiBX
aGF0IGlzIFNNQVA/IENvdWxkIHlvdSBnaXZlIG1lIG1vcmUgaW5mb3JtYXRpb24/Cj4KPiBTbyBp
ZiB3ZSB1c2UgM00gYXMgdGhlIHdpcmUgc3BlZWQsIHlvdSB3b3VsZCBleHBlY3QgdGhlIHJlc3Vs
dCB0byBiZSAyLjhNCj4gcHBzL2NvcmUsIHJpZ2h0Pwo+Cj4gTm93IHRoZSByZWN2IHJlc3VsdCBp
cyAyLjVNICgyNDYzNjQ2ID0gMywzNDMsMTY4LzEuMzU3KSBwcHMvY29yZS4gRG8geW91IHRoaW5r
Cj4gdGhlIGRpZmZlcmVuY2UgaXMgYmlnPwo+Cj4gTXkgdG9vbCBtYWtlcyB1ZHAgcGFja2V0cyBh
bmQgbG9va3MgdXAgcm91dGVzLCBzbyBpdCByZXF1aXJlcyBtb3JlIENQVS4KPgo+IEknbSBjb25m
dXNlZC4gSXMgdGhlcmUgc29tZXRoaW5nIEkgbWlzdW5kZXJzdG9vZD8KPgo+IFRoYW5rcy4KPgo+
ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBXaGF0IEkgbm90aWNlZCBpcyB0aGF0IHRoZSBob3RzcG90IGlzIHRo
ZSBkcml2ZXIgd3JpdGluZyB2aXJ0aW8gZGVzYy4gQmVjYXVzZQo+ID4gPiA+ID4gPiB0aGUgZGV2
aWNlIGlzIGluIGJ1c3kgbW9kZS4gU28gdGhlcmUgaXMgcmFjZSBiZXR3ZWVuIGRyaXZlciBhbmQg
ZGV2aWNlLgo+ID4gPiA+ID4gPiBTbyBJIG1vZGlmaWVkIHRoZSB2aXJ0aW8gY29yZSBhbmQgbGF6
aWx5IHVwZGF0ZWQgYXZhaWwgaWR4LiBUaGVuIHBwcyBjYW4gcmVhY2gKPiA+ID4gPiA+ID4gMTAs
MDAwLDAwMC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBDYXJlIHRvIHBvc3QgYSBkcmFmdCBmb3IgdGhp
cz8KPiA+ID4gPgo+ID4gPiA+IFlFUywgSSBpcyB0aGlua2luZyBmb3IgdGhpcy4KPiA+ID4gPiBC
dXQgbWF5YmUgdGhhdCBpcyBqdXN0IHdvcmsgZm9yIHNwbGl0LiBUaGUgcGFja2VkIG1vZGUgaGFz
IHNvbWUgdHJvdWJsZXMuCj4gPiA+Cj4gPiA+IE9rLgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4K
PiA+ID4gPgo+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5r
cwo+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiAjIyBtYWludGFpbgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+IEkgYW0gY3VycmVudGx5IGEgcmV2aWV3ZXIgZm9yIHZpcnRpby1uZXQuIEkgY29t
bWl0IHRvIG1haW50YWluIEFGX1hEUCBzdXBwb3J0IGluCj4gPiA+ID4gPiA+ID4gPiB2aXJ0aW8t
bmV0Lgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFBsZWFzZSByZXZpZXcuCj4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+IHYxOgo+ID4gPiA+ID4gPiA+ID4gICAgIDEuIHJlbW92ZSB0d28gdmlydGlvIGNv
bW1pdHMuIFB1c2ggdGhpcyBwYXRjaHNldCB0byBuZXQtbmV4dAo+ID4gPiA+ID4gPiA+ID4gICAg
IDIuIHNxdWFzaCAidmlydGlvX25ldDogdmlydG5ldF9wb2xsX3R4IHN1cHBvcnQgcmVzY2hlZHVs
ZWQiIHRvIHhzazogc3VwcG9ydCB0eAo+ID4gPiA+ID4gPiA+ID4gICAgIDMuIGZpeCBzb21lIHdh
cm5pbmdzCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gWHVhbiBaaHVvICgxOSk6Cj4g
PiA+ID4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHJlbmFtZSBmcmVlX29sZF94bWl0X3NrYnMgdG8g
ZnJlZV9vbGRfeG1pdAo+ID4gPiA+ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiB1bmlmeSB0aGUgY29k
ZSBmb3IgcmVjeWNsaW5nIHRoZSB4bWl0IHB0cgo+ID4gPiA+ID4gPiA+ID4gICB2aXJ0aW9fbmV0
OiBpbmRlcGVuZGVudCBkaXJlY3RvcnkKPiA+ID4gPiA+ID4gPiA+ICAgdmlydGlvX25ldDogbW92
ZSB0byB2aXJ0aW9fbmV0LmgKPiA+ID4gPiA+ID4gPiA+ICAgdmlydGlvX25ldDogYWRkIHByZWZp
eCB2aXJ0bmV0IHRvIGFsbCBzdHJ1Y3QvYXBpIGluc2lkZSB2aXJ0aW9fbmV0LmgKPiA+ID4gPiA+
ID4gPiA+ICAgdmlydGlvX25ldDogc2VwYXJhdGUgdmlydG5ldF9yeF9yZXNpemUoKQo+ID4gPiA+
ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiBzZXBhcmF0ZSB2aXJ0bmV0X3R4X3Jlc2l6ZSgpCj4gPiA+
ID4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHNxIHN1cHBvcnQgcHJlbWFwcGVkIG1vZGUKPiA+ID4g
PiA+ID4gPiA+ICAgdmlydGlvX25ldDogeHNrOiBiaW5kL3VuYmluZCB4c2sKPiA+ID4gPiA+ID4g
PiA+ICAgdmlydGlvX25ldDogeHNrOiBwcmV2ZW50IGRpc2FibGUgdHggbmFwaQo+ID4gPiA+ID4g
PiA+ID4gICB2aXJ0aW9fbmV0OiB4c2s6IHR4OiBzdXBwb3J0IHR4Cj4gPiA+ID4gPiA+ID4gPiAg
IHZpcnRpb19uZXQ6IHhzazogdHg6IHN1cHBvcnQgd2FrZXVwCj4gPiA+ID4gPiA+ID4gPiAgIHZp
cnRpb19uZXQ6IHhzazogdHg6IHZpcnRuZXRfZnJlZV9vbGRfeG1pdCgpIGRpc3Rpbmd1aXNoZXMg
eHNrIGJ1ZmZlcgo+ID4gPiA+ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiB4c2s6IHR4OiB2aXJ0bmV0
X3NxX2ZyZWVfdW51c2VkX2J1ZigpIGNoZWNrIHhzayBidWZmZXIKPiA+ID4gPiA+ID4gPiA+ICAg
dmlydGlvX25ldDogeHNrOiByeDogaW50cm9kdWNlIGFkZF9yZWN2YnVmX3hzaygpCj4gPiA+ID4g
PiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogcng6IGludHJvZHVjZSByZWNlaXZlX3hzaygpIHRv
IHJlY3YgeHNrIGJ1ZmZlcgo+ID4gPiA+ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiB4c2s6IHJ4OiB2
aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1ZigpIGNoZWNrIHhzayBidWZmZXIKPiA+ID4gPiA+ID4g
PiA+ICAgdmlydGlvX25ldDogdXBkYXRlIHR4IHRpbWVvdXQgcmVjb3JkCj4gPiA+ID4gPiA+ID4g
PiAgIHZpcnRpb19uZXQ6IHhkcF9mZWF0dXJlcyBhZGQgTkVUREVWX1hEUF9BQ1RfWFNLX1pFUk9D
T1BZCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gIE1BSU5UQUlORVJTICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KPiA+ID4gPiA+ID4gPiA+ICBkcml2ZXJz
L25ldC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICstCj4gPiA+ID4gPiA+
ID4gPiAgZHJpdmVycy9uZXQvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiAr
LQo+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby9LY29uZmlnICAgICAgICAgICAg
ICAgICAgfCAgMTMgKwo+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgfCAgIDggKwo+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3t2
aXJ0aW9fbmV0LmMgPT4gdmlydGlvL21haW4uY30gfCA2NTIgKysrKysrKysrLS0tLS0tLS0tLS0K
PiA+ID4gPiA+ID4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25ldC5oICAgICAgICAg
ICAgIHwgMzU5ICsrKysrKysrKysrCj4gPiA+ID4gPiA+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlv
L3hzay5jICAgICAgICAgICAgICAgICAgICB8IDU0NSArKysrKysrKysrKysrKysrCj4gPiA+ID4g
PiA+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvL3hzay5oICAgICAgICAgICAgICAgICAgICB8ICAz
MiArCj4gPiA+ID4gPiA+ID4gPiAgOSBmaWxlcyBjaGFuZ2VkLCAxMjQ3IGluc2VydGlvbnMoKyks
IDM3NCBkZWxldGlvbnMoLSkKPiA+ID4gPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9uZXQvdmlydGlvL0tjb25maWcKPiA+ID4gPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9uZXQvdmlydGlvL01ha2VmaWxlCj4gPiA+ID4gPiA+ID4gPiAgcmVuYW1lIGRy
aXZlcnMvbmV0L3t2aXJ0aW9fbmV0LmMgPT4gdmlydGlvL21haW4uY30gKDkxJSkKPiA+ID4gPiA+
ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQu
aAo+ID4gPiA+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8v
eHNrLmMKPiA+ID4gPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmly
dGlvL3hzay5oCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4g
PiA+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
