Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAE7C47082
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 03:03:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2A86135C
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 03:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2A86135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 579B64025D;
	Tue,  1 Jun 2021 03:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0-zEstnECJn7; Tue,  1 Jun 2021 03:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B02D8400A9;
	Tue,  1 Jun 2021 03:03:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C775C000D;
	Tue,  1 Jun 2021 03:03:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D5D7C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 271354025D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SgaaXc15ffMs
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:03:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA64C400A9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622516630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REw0v4febqRmEtFGcSxpH//nxKz4Tay3APYlxK2qeL0=;
 b=Ww14bjsL3oEAHCdXjPjHW9ypBD2iZnbBxabswAsGqOWwlv4/x9Jf3pTsnSqC8p/jia6NkI
 rn1NDnCeQbONzndgIF9pn2KDoJf5h0bJw2cNQuTkodlHx/TC2fHsYpyB3WUJEBpTLir5sx
 D68hMojL9jUxEEjFIaEeNiUr7eQF9cU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-H3LjPMfZM2qum8q_C2Vqng-1; Mon, 31 May 2021 23:03:48 -0400
X-MC-Unique: H3LjPMfZM2qum8q_C2Vqng-1
Received: by mail-pl1-f199.google.com with SMTP id
 x7-20020a1709027c07b02900e6489d6231so3899281pll.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 20:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=REw0v4febqRmEtFGcSxpH//nxKz4Tay3APYlxK2qeL0=;
 b=I6L+RGDScIq1w+n9HofB1wYzwfFwJhAt6sJcYLZ4uCDrbAMsHoNgEZv6Plvmbx5gCV
 rVZj96mpjpJbmYuFeOLnmwdFD2ob+9i71LFrXo7osZMcwRhgUX3bZF1bJsSgXLfS56Dm
 oZvgZlmoMaA5/NGoXxT/md31+aJ3RoRWlVQR76rGV8wqx3dT8j1uTIto6iVg8HNvTbdr
 EWmjTvZH+c2q35vycVGltnjpEY0V8TXDtxGkNbxZWnLHlCrK8w5JqPxCanVJwD65ybdY
 E9WmulspSx434wMgAl6Bq8G+S88Kinv/QZRcUclho+SbLqYxZylIy8WK/D8KGynDmqpg
 ApXA==
X-Gm-Message-State: AOAM5329jwXD0d8EOt30kCgDdyY80S7iyUfNyTPvw89Hskz/JKKru4Kr
 FvxywKFW8MISGyNaVhqCNHGtmsO1d20g7P23Zxy9s9tcMH91TB/Yk082FaajB9Z4fQCjq4hrJvk
 kVVgCeOqG/43C8QD5gXAL2VhLEt2O0pAraofgvAMXWQ==
X-Received: by 2002:a62:b419:0:b029:2e8:e879:5d1e with SMTP id
 h25-20020a62b4190000b02902e8e8795d1emr19485923pfn.3.1622516627550; 
 Mon, 31 May 2021 20:03:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwijnmAPYgjp24Pwd1POSPKg866XSvy+/QLq5Mw1wyVqQP2ac01uC1sNGM6GQWkFNmElLpNQQ==
X-Received: by 2002:a62:b419:0:b029:2e8:e879:5d1e with SMTP id
 h25-20020a62b4190000b02902e8e8795d1emr19485904pfn.3.1622516627295; 
 Mon, 31 May 2021 20:03:47 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 76sm2669467pfy.82.2021.05.31.20.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 20:03:46 -0700 (PDT)
Subject: Re: [PATCH net 2/2] virtio-net: get build_skb() buf by data ptr
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1622458734.837168-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b7dde035-b770-35c2-5e08-d81df4023a90@redhat.com>
Date: Tue, 1 Jun 2021 11:03:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622458734.837168-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzUvMzEg5LiL5Y2INjo1OCwgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBNb24sIDMx
IE1heSAyMDIxIDE0OjEwOjU1ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4g5ZyoIDIwMjEvNS8xNCDkuIvljYgxMToxNiwgWHVhbiBaaHVvIOWGmemBkzoK
Pj4+IEluIHRoZSBjYXNlIG9mIG1lcmdlLCB0aGUgcGFnZSBwYXNzZWQgaW50byBwYWdlX3RvX3Nr
YigpIG1heSBiZSBhIGhlYWQKPj4+IHBhZ2UsIG5vdCB0aGUgcGFnZSB3aGVyZSB0aGUgY3VycmVu
dCBkYXRhIGlzIGxvY2F0ZWQuCj4+Cj4+IEkgZG9uJ3QgZ2V0IGhvdyB0aGlzIGNhbiBoYXBwZW4/
Cj4+Cj4+IE1heWJlIHlvdSBjYW4gZXhwbGFpbiBhIGxpdHRsZSBiaXQgbW9yZT8KPj4KPj4gcmVj
ZWl2ZV9tZXJnZWFibGUoKSBjYWxsIHBhZ2VfdG9fc2tiKCkgaW4gdHdvIHBsYWNlczoKPj4KPj4g
MSkgWERQX1BBU1MgZm9yIGxpbmVhcml6ZWQgcGFnZSAsIGluIHRoaXMgY2FzZSB3ZSB1c2UgeGRw
X3BhZ2UKPj4gMikgcGFnZV90b19za2IoKSBmb3IgIm5vcm1hbCIgcGFnZSwgaW4gdGhpcyBjYXNl
IHRoZSBwYWdlIGNvbnRhaW5zIHRoZSBkYXRhCj4gVGhlIG9mZnNldCBtYXkgYmUgZ3JlYXRlciB0
aGFuIFBBR0VfU0laRSwgYmVjYXVzZSBwYWdlIGlzIG9idGFpbmVkIGJ5Cj4gdmlydF90b19oZWFk
X3BhZ2UoKSwgbm90IHRoZSBwYWdlIHdoZXJlIGJ1ZiBpcyBsb2NhdGVkLiBBbmQgIm9mZnNldCIg
aXMgdGhlIG9mZnNldAo+IG9mIGJ1ZiByZWxhdGl2ZSB0byBwYWdlLgo+Cj4gCXRhaWxyb29tID0g
dHJ1ZXNpemUgLSBsZW4gLSBvZmZzZXQ7Cj4KPiBJbiB0aGlzIGNhc2UsIHRoZSB0YWlscm9vbSBt
dXN0IGJlIGxlc3MgdGhhbiAwLiBBbHRob3VnaCB0aGVyZSBtYXkgYmUgZW5vdWdoCj4gY29udGVu
dCBvbiB0aGlzIHBhZ2UgdG8gc2F2ZSBza2Jfc2hhcmVkX2luZm8uCgoKSW50ZXJlc3RpbmcsIEkg
dGhpbmsgd2UgZG9uJ3QgdXNlIGNvbXBvdW5kIHBhZ2VzIGZvciB2aXJ0aW8tbmV0LiAoV2UgCmRv
bid0IGRlZmluZSBTS0JfRlJBR19QQUdFX09SREVSKS4KCkFtIEkgd3Jvbmc/CgpUaGFua3MKCgo+
Cj4gVGhhbmtzLgo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4gU28gd2hlbiB0cnlpbmcgdG8KPj4+IGdl
dCB0aGUgYnVmIHdoZXJlIHRoZSBkYXRhIGlzIGxvY2F0ZWQsIHlvdSBzaG91bGQgZGlyZWN0bHkg
dXNlIHRoZQo+Pj4gcG9pbnRlcihwKSB0byBnZXQgdGhlIGFkZHJlc3MgY29ycmVzcG9uZGluZyB0
byB0aGUgcGFnZS4KPj4+Cj4+PiBBdCB0aGUgc2FtZSB0aW1lLCB0aGUgb2Zmc2V0IG9mIHRoZSBk
YXRhIGluIHRoZSBwYWdlIHNob3VsZCBhbHNvIGJlCj4+PiBvYnRhaW5lZCB1c2luZyBvZmZzZXRf
aW5fcGFnZSgpLgo+Pj4KPj4+IFRoaXMgcGF0Y2ggc29sdmVzIHRoaXMgcHJvYmxlbS4gQnV0IGlm
IHlvdSBkb27igJl0IHVzZSB0aGlzIHBhdGNoLCB0aGUKPj4+IG9yaWdpbmFsIGNvZGUgY2FuIGFs
c28gcnVuLCBiZWNhdXNlIGlmIHRoZSBwYWdlIGlzIG5vdCB0aGUgcGFnZSBvZiB0aGUKPj4+IGN1
cnJlbnQgZGF0YSwgdGhlIGNhbGN1bGF0ZWQgdGFpbHJvb20gd2lsbCBiZSBsZXNzIHRoYW4gMCwg
YW5kIHdpbGwgbm90Cj4+PiBlbnRlciB0aGUgbG9naWMgb2YgYnVpbGRfc2tiKCkgLiBUaGUgc2ln
bmlmaWNhbmNlIG9mIHRoaXMgcGF0Y2ggaXMgdG8KPj4+IG1vZGlmeSB0aGlzIGxvZ2ljYWwgcHJv
YmxlbSwgYWxsb3dpbmcgbW9yZSBzaXR1YXRpb25zIHRvIHVzZQo+Pj4gYnVpbGRfc2tiKCkuCj4+
Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNv
bT4KPj4+IEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+Pj4g
LS0tCj4+PiAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA4ICsrKysrKy0tCj4+PiAgICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPj4+IGluZGV4IDNlNDZjMTJkZGUwOC4uMDczZmVjNGMwZGYxIDEwMDY0NAo+Pj4gLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPj4+IEBAIC00MDcsOCArNDA3LDEyIEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFn
ZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4+PiAgICAJCSAqIHNlZSBhZGRfcmVj
dmJ1Zl9tZXJnZWFibGUoKSArIGdldF9tZXJnZWFibGVfYnVmX2xlbigpCj4+PiAgICAJCSAqLwo+
Pj4gICAgCQl0cnVlc2l6ZSA9IFBBR0VfU0laRTsKPj4+IC0JCXRhaWxyb29tID0gdHJ1ZXNpemUg
LSBsZW4gLSBvZmZzZXQ7Cj4+PiAtCQlidWYgPSBwYWdlX2FkZHJlc3MocGFnZSk7Cj4+PiArCj4+
PiArCQkvKiBwYWdlIG1heWJlIGhlYWQgcGFnZSwgc28gd2Ugc2hvdWxkIGdldCB0aGUgYnVmIGJ5
IHAsIG5vdCB0aGUKPj4+ICsJCSAqIHBhZ2UKPj4+ICsJCSAqLwo+Pj4gKwkJdGFpbHJvb20gPSB0
cnVlc2l6ZSAtIGxlbiAtIG9mZnNldF9pbl9wYWdlKHApOwo+Pj4gKwkJYnVmID0gKGNoYXIgKiko
KHVuc2lnbmVkIGxvbmcpcCAmIFBBR0VfTUFTSyk7Cj4+PiAgICAJfSBlbHNlIHsKPj4+ICAgIAkJ
dGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbjsKPj4+ICAgIAkJYnVmID0gcDsKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
