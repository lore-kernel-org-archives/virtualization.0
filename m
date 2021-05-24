Return-Path: <SRS0=LFKT=KT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69397C47080
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 02:53:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066A761159
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 02:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066A761159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B338B606ED;
	Mon, 24 May 2021 02:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c8To2iW1XHUX; Mon, 24 May 2021 02:53:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3162160677;
	Mon, 24 May 2021 02:53:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02DF9C000E;
	Mon, 24 May 2021 02:53:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9DF3C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90CDB40340
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:53:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aF2wdaYBF_oQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:53:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0046402EB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621824802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHCpWszk2k0MKGSbz/oMp6Y4c3mTJaXAiLMSobPSgQg=;
 b=OPHQRZ2A7IxtTiPAm+MKXusQrNsyOv6GnyhqkYhrxNBWszbvC9Hz1NofnIBOZl+R0ugFn3
 s05lQlaX8KAWNeNlA7ZjhggjyF1KOK1zVNsGbfI91HphCdaCs1eRg2Cl/k4joE58YCXybl
 ef3erKpiy5UcHcZHlS6BcE6xycMrcAQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-8DEfBaSfMQ25d__jU5ZTZg-1; Sun, 23 May 2021 22:53:18 -0400
X-MC-Unique: 8DEfBaSfMQ25d__jU5ZTZg-1
Received: by mail-pj1-f72.google.com with SMTP id
 h23-20020a17090aa897b029015cc61ef388so12708979pjq.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 May 2021 19:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=OHCpWszk2k0MKGSbz/oMp6Y4c3mTJaXAiLMSobPSgQg=;
 b=Cakfr0BM995+Oeuc6wz68vXlknKPtOFBHv/DHcOEqiOwmLU54qoph41ljb9g3jAl7q
 Zwdyf/PZPJxVabKND1aGGM1eBOvxBbV/mJhsZ0QzvJEmeyTtkOHGUUGGpGdhgwnRZymB
 fQawmE+6HP5HoYyFD8/7ArsUS2ddEvCoCwmgcVzDfs/W8uD9XCSrC+IIiPiQl6WSBMED
 yicIwsbFfrFLefOB88290DDPOBRpMWotr174rzSbqow1o/qkCigJ+4ijKDBCKeglvhaV
 aAPKcVAqN5HH43Mrcp2YxC5Wb4WBu2f6G+zo5s1Hh0//oxKvUGzgPxRuIFcNqeQmyVba
 jVDA==
X-Gm-Message-State: AOAM531skvKdzvMIFDHVxfEJgFvQwB3vKUpJJugEZ3xHjXjpO2nbRm2p
 oqQxv7m/vH6zenItiNHSUMQMaRvjPj/MzgQjQUK3JpG2mOjUaeOzczbP6qoW0Sw8iISJwWdPM+f
 O4/kk6H7DhfxEHXTAlvTavJgl5XSmPOPWRP6eavtMDQ==
X-Received: by 2002:a63:74e:: with SMTP id 75mr7415335pgh.200.1621824797355;
 Sun, 23 May 2021 19:53:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP1ngdwvFX7GKxWKgZ4m6yITaZWeGU+YceEWcYXFbWXp51SlQUq1uR/X6gvfXsGOJdOyWhtQ==
X-Received: by 2002:a63:74e:: with SMTP id 75mr7415321pgh.200.1621824797107;
 Sun, 23 May 2021 19:53:17 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b9sm9335313pfo.107.2021.05.23.19.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 May 2021 19:53:16 -0700 (PDT)
Subject: Re: virtio_net: BQL?
To: Dave Taht <dave.taht@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <56270996-33a6-d71b-d935-452dad121df7@linux.alibaba.com>
 <CAA93jw6LUAnWZj0b5FvefpDKUyd6cajCNLoJ6OKrwbu-V_ffrA@mail.gmail.com>
 <CA+FuTSf0Af2RXEG=rCthNNEb5mwKTG37gpEBBZU16qKkvmF=qw@mail.gmail.com>
 <CAA93jw7Vr_pFMsPCrPadqaLGu0BdC-wtCmW2iyHFkHERkaiyWQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a3a9b036-14d1-2f4f-52e6-f0aa1b187003@redhat.com>
Date: Mon, 24 May 2021 10:53:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAA93jw7Vr_pFMsPCrPadqaLGu0BdC-wtCmW2iyHFkHERkaiyWQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xianting Tian <xianting.tian@linux.alibaba.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 bloat <bloat@lists.bufferbloat.net>, Jakub Kicinski <kuba@kernel.org>,
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

CuWcqCAyMDIxLzUvMTgg5LiK5Y2INTo0OCwgRGF2ZSBUYWh0IOWGmemBkzoKPiBPbiBNb24sIE1h
eSAxNywgMjAyMSBhdCAxOjIzIFBNIFdpbGxlbSBkZSBCcnVpam4KPiA8d2lsbGVtZGVicnVpam4u
a2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IE9uIE1vbiwgTWF5IDE3LCAyMDIxIGF0IDI6NDQg
UE0gRGF2ZSBUYWh0IDxkYXZlLnRhaHRAZ21haWwuY29tPiB3cm90ZToKPj4+IE5vdCByZWFsbHkg
cmVsYXRlZCB0byB0aGlzIHBhdGNoLCBidXQgaXMgdGhlcmUgc29tZSByZWFzb24gd2h5IHZpcnRp
bwo+Pj4gaGFzIG5vIHN1cHBvcnQgZm9yIEJRTD8KPj4gVGhlcmUgaGF2ZSBiZWVuIGEgZmV3IGF0
dGVtcHRzIHRvIGFkZCBpdCBvdmVyIHRoZSB5ZWFycy4KPj4KPj4gTW9zdCByZWNlbnRseSwgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE4MTIwNTIyNTMyMy4xMjU1NS0yLW1zdEByZWRo
YXQuY29tLwo+Pgo+PiBUaGF0IHRocmVhZCBoYXMgYSBsb25nIGRpc2N1c3Npb24uIEkgdGhpbmsg
dGhlIGtleSBvcGVuIGlzc3VlIHJlbWFpbnMKPj4KPj4gIlRoZSB0cmlja3kgcGFydCBpcyB0aGUg
bW9kZSBzd2l0Y2hpbmcgYmV0d2VlbiBuYXBpIGFuZCBubyBuYXBpLiIKPiBPeSwgdmV5Lgo+Cj4g
SSBkaWRuJ3QgcGF5IGFueSBhdHRlbnRpb24gdG8gdGhhdCBkaXNjdXNzaW9uLCBzYWRseSBlbm91
Z2guCj4KPiBJdCdzIGJlZW4gYWJvdXQgdGhhdCBsb25nICgyMDE4KSBzaW5jZSBJIHBhaWQgYW55
IGF0dGVudGlvbiB0bwo+IGJ1ZmZlcmJsb2F0IGluIHRoZSBjbG91ZCBhbmQgbXkgY2xvdWR5IHBy
b3ZpZGVyIChsaW5vZGUpIHN3aXRjaGVkIHRvCj4gdXNpbmcgdmlydGlvIHdoZW4gSSB3YXNuJ3Qg
bG9va2luZy4gRm9yIG92ZXIgYSB5ZWFyIG5vdywgSSdkIGJlZW4KPiBnZXR0aW5nIHJlcG9ydHMg
c2F5aW5nIHRoYXQgY29tY2FzdCdzIHBpZSByb2xsb3V0IHdhc24ndCB3b3JraW5nIGFzCj4gd2Vs
bCBhcyBleHBlY3RlZCwgdGhhdCBldmVucm91dGUncyBpbXBsZW1lbnRhdGlvbiBvZiBzY2hfY2Fr
ZSBhbmQgc3FtCj4gb24gaW5ib3VuZCB3YXNuJ3Qgd29ya2luZyByaWdodCwgbm9yIHBmX3NlbnNl
J3MgYW5kIG51bWVyb3VzIG90aGVyCj4gaXNzdWVzIGF0IEludGVybmV0IHNjYWxlLgo+Cj4gTGFz
dCB3ZWVrIEkgcmFuIGEgc3RyaW5nIG9mIGJlbmNobWFya3MgYWdhaW5zdCBzdGFybGluaydzIG5l
dyBzZXJ2aWNlcwo+IGFuZCB3YXMgcmVhbGx5IGFnaGFzdCBhdCB3aGF0IEkgZm91bmQgdGhlcmUs
IHRvby4gYnV0IHRoZSBwcm9ibGVtCj4gc2VlbWVkIGRlZXBlciB0aGFuIGluIGp1c3QgdGhlIGRp
c2h5Li4uCj4KPiBXaXRob3V0IEJRTCwgdGhlcmUncyBubyBiYWNrcHJlc3N1cmUgZm9yIGZxX2Nv
ZGVsIHRvIGRvIGl0cyB0aGluZy4KPiBOb25lLiBNeSBtZWFzdXJlbWVudCBzZXJ2ZXJzIGFyZW4n
dCBGUS1jb2RlbGluZwo+IG5vIG1hdHRlciBob3cgbXVjaCBsb2FkIEkgcHV0IG9uIHRoZW0uIFNp
bmNlIHRoYXQgcWRpc2MgaXMgdGhlIGRlZmF1bHQKPiBub3cgaW4gbW9zdCBsaW51eCBkaXN0cmli
dXRpb25zLCBJIGltYWdpbmUgdGhhdCB0aGUgYnVsayBvZiB0aGUgY2xvdWQKPiBpcyBub3cgYmVo
YXZpbmcgYXMgZXJyYXRpY2FsbHkgYXMgbGludXggd2FzIGluIDIwMTEgd2l0aCBlbm9ybW91cwo+
IHN3aW5ncyBpbiB0aHJvdWdocHV0IGFuZCBsYXRlbmN5IGZyb20gR1NPL1RTTyBoaXR0aW5nIG92
ZXJsYXJnZSByeC90eAo+IHJpbmdzLCBbMV0sIGJyZWFraW5nIHZhcmlvdXMgcmF0ZSBlc3RpbWF0
b3JzIGluIGNvZGVsLCBwaWUgYW5kIHRoZSB0Y3AKPiBzdGFjayBpdHNlbGYuCj4KPiBTZWU6Cj4K
PiBodHRwOi8vZnJlbW9udC5zdGFybGluay50YWh0Lm5ldC9+ZC92aXJ0aW9fbm9icWwvcnJ1bF8t
X2V2ZW5yb3V0ZV92M19zZXJ2ZXJfZnFfY29kZWwucG5nCj4KPiBTZWUgdGhlIHN3aW5ncyBpbiBs
YXRlbmN5IHRoZXJlPyB0aGF0J3Mgc3ltcHRvbWF0aWMgb2YgdHgvcnggcmluZ3MKPiBmaWxsaW5n
IGFuZCBlbXB0eWluZy4KPgo+IGl0IHdhc24ndCB1bnRpbCBJIHN3aXRjaGVkIG15IG1lYXN1cmVt
ZW50IHNlcnZlciB0ZW1wb3JhcmlseSBvdmVyIHRvCj4gc2NoX2ZxIHRoYXQgSSBnb3QgYSBycnVs
IHJlc3VsdCB0aGF0IHdhcyBjbG9zZSB0byB0aGUgcmVzdWx0cyB3ZSB1c2VkCj4gdG8gZ2V0IGZy
b20gdGhlIHZpcnR1YWxpemVkIGUxMDAwZSBkcml2ZXJzIHdlIHdlcmUgdXNpbmcgaW4gMjAxNC4K
Pgo+IGh0dHA6Ly9mcmVtb250LnN0YXJsaW5rLnRhaHQubmV0L35kL3ZpcnRpb19ub2JxbC9ycnVs
Xy1fZXZlbnJvdXRlX3YzX3NlcnZlcl9mcS5wbmcKPgo+IFdoaWxlIEkgaGF2ZSBsb25nIHN1cHBv
cnRlZCB0aGUgdXNlIG9mIHNjaF9mcSBmb3IgdGNwLWhlYXZ5IHdvcmtsb2FkcywKPiBpdCBzdGls
bCBiZWhhdmVzIGJldHRlciB3aXRoIGJxbCBpbiBwbGFjZSwgYW5kIGZxX2NvZGVsIGlzIGJldHRl
ciBmb3IKPiBnZW5lcmljIHdvcmtsb2Fkcy4uLiBidXQgbmVlZHMgYnFsIGJhc2VkIGJhY2twcmVz
c3VyZSB0byBraWNrIGluLgo+Cj4gWzFdIEkgcmVhbGx5IGhvcGUgSSdtIG92ZXJyZWFjdGluZyBi
dXQsIHVtLCBlciwgY291bGQgc29tZW9uZShzKSBzcGluCj4gdXAgYSBuZXcgcGF0Y2ggdGhhdCBk
b2VzIGJxbCBpbiBzb21lIHdheSBldmVuIGhhbGYgcmlnaHQgZm9yIHRoaXMKPiBkcml2ZXIgYW5k
IGhlbHAgdGVzdCBpdD8gSSBoYXZlbid0IGJ1aWx0IGEga2VybmVsIGluIGEgd2hpbGUuCgoKSSB0
aGluayBpdCdzIHRpbWUgdG8gb2Jzb2xldGUgc2tiX29ycGhhbigpIGZvciB2aXJ0aW8tbmV0IHRv
IGdldCByaWQgb2YgCmEgYnJ1bmNoIG9mIHRyaWNreSBjb2RlcyBpbiB0aGUgY3VycmVudCB2aXJ0
aW8tbmV0IGRyaXZlci4KClRoZW4gd2UgY2FuIGRvIEJRTCBvbiB0b3AuCgpJIHdpbGwgcHJlcGFy
ZSBzb21lIHBhdGNoZXMgdG8gZG8gdGhpcyAocHJvYmFibHkgd2l0aCBNaWNoYWVsJ3MgQlFMIHBh
dGNoKS4KClRoYW5rcwoKCj4KPgo+Pj4gT24gTW9uLCBNYXkgMTcsIDIwMjEgYXQgMTE6NDEgQU0g
WGlhbnRpbmcgVGlhbgo+Pj4gPHhpYW50aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20+IHdyb3Rl
Ogo+Pj4+IEJVR19PTigpIHVzZXMgdW5saWtlbHkgaW4gaWYoKSwgd2hpY2ggY2FuIGJlIG9wdGlt
aXplZCBhdCBjb21waWxlIHRpbWUuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBYaWFudGluZyBU
aWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4+IC0tLQo+Pj4+ICAgIGRy
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDUgKystLS0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+IGlu
ZGV4IGM5MjFlYmYzYWU4Mi4uMjEyZDUyMjA0ODg0IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+
IEBAIC0xNjQ2LDEwICsxNjQ2LDkgQEAgc3RhdGljIGludCB4bWl0X3NrYihzdHJ1Y3Qgc2VuZF9x
dWV1ZSAqc3EsIHN0cnVjdAo+Pj4+IHNrX2J1ZmYgKnNrYikKPj4+PiAgICAgICAgICBlbHNlCj4+
Pj4gICAgICAgICAgICAgICAgICBoZHIgPSBza2Jfdm5ldF9oZHIoc2tiKTsKPj4+Pgo+Pj4+IC0g
ICAgICAgaWYgKHZpcnRpb19uZXRfaGRyX2Zyb21fc2tiKHNrYiwgJmhkci0+aGRyLAo+Pj4+ICsg
ICAgICAgQlVHX09OKHZpcnRpb19uZXRfaGRyX2Zyb21fc2tiKHNrYiwgJmhkci0+aGRyLAo+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0aW9faXNfbGl0dGxlX2Vu
ZGlhbih2aS0+dmRldiksIGZhbHNlLAo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDApKQo+Pj4+IC0gICAgICAgICAgICAgICBCVUcoKTsKPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAwKSk7Cj4+Pj4KPj4+PiAgICAgICAgICBpZiAodmktPm1l
cmdlYWJsZV9yeF9idWZzKQo+Pj4+ICAgICAgICAgICAgICAgICAgaGRyLT5udW1fYnVmZmVycyA9
IDA7Cj4+Pj4gLS0KPj4+PiAyLjE3LjEKPj4+Pgo+Pj4KPj4+IC0tCj4+PiBMYXRlc3QgUG9kY2Fz
dDoKPj4+IGh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9mZWVkL3VwZGF0ZS91cm46bGk6YWN0aXZp
dHk6Njc5MTAxNDI4NDkzNjc4NTkyMC8KPj4+Cj4+PiBEYXZlIFTDpGh0IENUTywgVGVrTGlicmUs
IExMQwo+Cj4KPiAtLQo+IExhdGVzdCBQb2RjYXN0Ogo+IGh0dHBzOi8vd3d3LmxpbmtlZGluLmNv
bS9mZWVkL3VwZGF0ZS91cm46bGk6YWN0aXZpdHk6Njc5MTAxNDI4NDkzNjc4NTkyMC8KPgo+IERh
dmUgVMOkaHQgQ1RPLCBUZWtMaWJyZSwgTExDCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
