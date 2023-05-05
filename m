Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC2FC77B73
	for <virtualization@archiver.kernel.org>; Fri,  5 May 2023 03:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BDAE840D4;
	Fri,  5 May 2023 03:46:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BDAE840D4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gIlY4kEY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vUl8zExrb2PZ; Fri,  5 May 2023 03:46:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6563E840B8;
	Fri,  5 May 2023 03:46:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6563E840B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 470F0C0037;
	Fri,  5 May 2023 03:46:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4200EC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 03:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08F8F60BD7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 03:46:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08F8F60BD7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gIlY4kEY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gEQoKxtBkx9X
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 03:46:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC9BA60B8F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC9BA60B8F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 03:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683258380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXSt/ToeG7abONjanxyM5GaulTCPV5FswADO1Tk+VdA=;
 b=gIlY4kEYDrYHQ+9wrfUXE10w/qVkjJ6GvNViSClyIdI8PFiQNlKzjkdDcOXPyUsPAJUTq2
 7HG319jLViI9v48gqYtZbt5P7WQ8DTpqSB0IRw63C/EfPkcd/N7s1iohCXx2EIZrecSIOs
 TwmbO2IpCdtprPUOBaWy93Az/eESJUY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-HJE3O3ZMNxCAM-wYKu0VBg-1; Thu, 04 May 2023 23:46:18 -0400
X-MC-Unique: HJE3O3ZMNxCAM-wYKu0VBg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-517c06c1a1bso540305a12.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 May 2023 20:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683258377; x=1685850377;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XXSt/ToeG7abONjanxyM5GaulTCPV5FswADO1Tk+VdA=;
 b=ObRFBlW5K8vjKfBiLMJLyv+9gLzbBkmtxRdsDBh9CBhjXpSbwhDnu/Sv14qmdiN++R
 Utn7p/fh8S2ddVBTDpJky5S0Vf1gxbOJCOjG6IoQoMyjLsJV8IF8AH2jT1GHE8gHV9nP
 LpDV+kqvmLzNgExHOV0t34GGtAeNTEGM3qOKgxB2/Gq8Dg739vwxYfvoKlOj29Oe0lUu
 6aVChMeSemu/32ue6/AZdWJvlz2E94tWMv7Ndu5EXFKOxxhhZpn7C7tECBVeujL15lNX
 JXespb9c+mtoFbJH2UK5lg0UGdA1ZogwiGMJzVG1hb/sDiOs7nw0IkWKSqP0zfeoph/K
 Xudg==
X-Gm-Message-State: AC+VfDzf3KhyjjUcLqYyWgyaJ2ogR/YwmrRYziC4bYl35m9T/y5gxFjO
 HVciTFWFGtBYoGbiHNvd3kOTG+RMREfUeeuUJNkGXn6NgG3CvpGglRwbeU65lCI1F/BaJdms/0a
 a5noV9z7LfoiJav38i8k5pQCqMB7zWRKmCg1yJK5Prw==
X-Received: by 2002:a05:6a20:9187:b0:dd:e6f5:a798 with SMTP id
 v7-20020a056a20918700b000dde6f5a798mr191110pzd.6.1683258377658; 
 Thu, 04 May 2023 20:46:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uzNVYqwoZ12N32XRVcLzHKoDUnytveRa6DJklrnk9647kWN+h+tLL4mZawoF7IdFY90EKZQ==
X-Received: by 2002:a05:6a20:9187:b0:dd:e6f5:a798 with SMTP id
 v7-20020a056a20918700b000dde6f5a798mr191087pzd.6.1683258377273; 
 Thu, 04 May 2023 20:46:17 -0700 (PDT)
Received: from [10.72.12.124] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 205-20020a6304d6000000b00502e7115cbdsm510929pge.51.2023.05.04.20.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 May 2023 20:46:16 -0700 (PDT)
Message-ID: <3f602115-4889-ead0-eb5a-a0db76b6e312@redhat.com>
Date: Fri, 5 May 2023 11:46:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
From: Jason Wang <jasowang@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
In-Reply-To: <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzQvMTcgMTE6NDAsIEphc29uIFdhbmcg5YaZ6YGTOgo+IE9uIEZyaSwgQXByIDE0
LCAyMDIzIGF0IDM6MjHigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3
cm90ZToKPj4gT24gRnJpLCBBcHIgMTQsIDIwMjMgYXQgMDE6MDQ6MTVQTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPj4+IEZvcmdldCB0byBjYyBuZXRkZXYsIGFkZGluZy4KPj4+Cj4+PiBPbiBG
cmksIEFwciAxNCwgMjAyMyBhdCAxMjoyNeKAr0FNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+IHdyb3RlOgo+Pj4+IE9uIFRodSwgQXByIDEzLCAyMDIzIGF0IDAyOjQwOjI2UE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+IFRoaXMgcGF0Y2ggY29udmVydCByeCBtb2Rl
IHNldHRpbmcgdG8gYmUgZG9uZSBpbiBhIHdvcmtxdWV1ZSwgdGhpcyBpcwo+Pj4+PiBhIG11c3Qg
Zm9yIGFsbG93IHRvIHNsZWVwIHdoZW4gd2FpdGluZyBmb3IgdGhlIGN2cSBjb21tYW5kIHRvCj4+
Pj4+IHJlc3BvbnNlIHNpbmNlIGN1cnJlbnQgY29kZSBpcyBleGVjdXRlZCB1bmRlciBhZGRyIHNw
aW4gbG9jay4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KPj4+PiBJIGRvbid0IGxpa2UgdGhpcyBmcmFua2x5LiBUaGlzIG1lYW5zIHRo
YXQgc2V0dGluZyBSWCBtb2RlIHdoaWNoIHdvdWxkCj4+Pj4gcHJldmlvdXNseSBiZSByZWxpYWJs
ZSwgbm93IGJlY29tZXMgdW5yZWxpYWJsZS4KPj4+IEl0IGlzICJ1bnJlbGlhYmxlIiBieSBkZXNp
Z246Cj4+Pgo+Pj4gICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICgqbmRvX3NldF9yeF9t
b2RlKShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KTsKPj4+Cj4+Pj4gLSBmaXJzdCBvZiBhbGwgY29u
ZmlndXJhdGlvbiBpcyBubyBsb25nZXIgaW1tZWRpYXRlCj4+PiBJcyBpbW1lZGlhdGUgYSBoYXJk
IHJlcXVpcmVtZW50PyBJIGNhbiBzZWUgYSB3b3JrcXVldWUgaXMgdXNlZCBhdCBsZWFzdDoKPj4+
Cj4+PiBtbHg1ZSwgaXBvaWIsIGVmeCwgLi4uCj4+Pgo+Pj4+ICAgIGFuZCB0aGVyZSBpcyBubyB3
YXkgZm9yIGRyaXZlciB0byBmaW5kIG91dCB3aGVuCj4+Pj4gICAgaXQgYWN0dWFsbHkgdG9vayBl
ZmZlY3QKPj4+IEJ1dCB3ZSBrbm93IHJ4IG1vZGUgaXMgYmVzdCBlZmZvcnQgZS5nIGl0IGRvZXNu
J3Qgc3VwcG9ydCB2aG9zdCBhbmQgd2UKPj4+IHN1cnZpdmUgZnJvbSB0aGlzIGZvciB5ZWFycy4K
Pj4+Cj4+Pj4gLSBzZWNvbmQsIGlmIGRldmljZSBmYWlscyBjb21tYW5kLCB0aGlzIGlzIGFsc28g
bm90Cj4+Pj4gICAgcHJvcGFnYXRlZCB0byBkcml2ZXIsIGFnYWluIG5vIHdheSBmb3IgZHJpdmVy
IHRvIGZpbmQgb3V0Cj4+Pj4KPj4+PiBWRFVTRSBuZWVkcyB0byBiZSBmaXhlZCB0byBkbyB0cmlj
a3MgdG8gZml4IHRoaXMKPj4+PiB3aXRob3V0IGJyZWFraW5nIG5vcm1hbCBkcml2ZXJzLgo+Pj4g
SXQncyBub3Qgc3BlY2lmaWMgdG8gVkRVU0UuIEZvciBleGFtcGxlLCB3aGVuIHVzaW5nIHZpcnRp
by1uZXQgaW4gdGhlCj4+PiBVUCBlbnZpcm9ubWVudCB3aXRoIGFueSBzb2Z0d2FyZSBjdnEgKGxp
a2UgbWx4NSB2aWEgdkRQQSBvciBjbWEKPj4+IHRyYW5zcG9ydCkuCj4+Pgo+Pj4gVGhhbmtzCj4+
IEhtbS4gQ2FuIHdlIGRpZmZlcmVudGlhdGUgYmV0d2VlbiB0aGVzZSB1c2UtY2FzZXM/Cj4gSXQg
ZG9lc24ndCBsb29rIGVhc3kgc2luY2Ugd2UgYXJlIGRyaXZlcnMgZm9yIHZpcnRpbyBidXMuIFVu
ZGVybGF5ZXIKPiBkZXRhaWxzIHdlcmUgaGlkZGVuIGZyb20gdmlydGlvLW5ldC4KPgo+IE9yIGRv
IHlvdSBoYXZlIGFueSBpZGVhcyBvbiB0aGlzPwoKCk1pY2hhZWwsIGFueSB0aG91Z2h0IG9uIHRo
aXM/CgpUaGFua3MKCgo+Cj4gVGhhbmtzCj4KPj4+Pgo+Pj4+PiAtLS0KPj4+Pj4gQ2hhbmdlcyBz
aW5jZSBWMToKPj4+Pj4gLSB1c2UgUlROTCB0byBzeW5jaHJvbml6ZSByeCBtb2RlIHdvcmtlcgo+
Pj4+PiAtLS0KPj4+Pj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA1NSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUy
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4g
aW5kZXggZTI1NjBiNmY3OTgwLi4yZTU2YmJmODY4OTQgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
Pj4+Pj4gQEAgLTI2NSw2ICsyNjUsMTIgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4+Pj4+ICAg
ICAgICAvKiBXb3JrIHN0cnVjdCBmb3IgY29uZmlnIHNwYWNlIHVwZGF0ZXMgKi8KPj4+Pj4gICAg
ICAgIHN0cnVjdCB3b3JrX3N0cnVjdCBjb25maWdfd29yazsKPj4+Pj4KPj4+Pj4gKyAgICAgLyog
V29yayBzdHJ1Y3QgZm9yIGNvbmZpZyByeCBtb2RlICovCj4+Pj4+ICsgICAgIHN0cnVjdCB3b3Jr
X3N0cnVjdCByeF9tb2RlX3dvcms7Cj4+Pj4+ICsKPj4+Pj4gKyAgICAgLyogSXMgcnggbW9kZSB3
b3JrIGVuYWJsZWQ/ICovCj4+Pj4+ICsgICAgIGJvb2wgcnhfbW9kZV93b3JrX2VuYWJsZWQ7Cj4+
Pj4+ICsKPj4+Pj4gICAgICAgIC8qIERvZXMgdGhlIGFmZmluaXR5IGhpbnQgaXMgc2V0IGZvciB2
aXJ0cXVldWVzPyAqLwo+Pj4+PiAgICAgICAgYm9vbCBhZmZpbml0eV9oaW50X3NldDsKPj4+Pj4K
Pj4+Pj4gQEAgLTM4OCw2ICszOTQsMjAgQEAgc3RhdGljIHZvaWQgZGlzYWJsZV9kZWxheWVkX3Jl
ZmlsbChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPj4+Pj4gICAgICAgIHNwaW5fdW5sb2NrX2Jo
KCZ2aS0+cmVmaWxsX2xvY2spOwo+Pj4+PiAgIH0KPj4+Pj4KPj4+Pj4gK3N0YXRpYyB2b2lkIGVu
YWJsZV9yeF9tb2RlX3dvcmsoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4+Pj4+ICt7Cj4+Pj4+
ICsgICAgIHJ0bmxfbG9jaygpOwo+Pj4+PiArICAgICB2aS0+cnhfbW9kZV93b3JrX2VuYWJsZWQg
PSB0cnVlOwo+Pj4+PiArICAgICBydG5sX3VubG9jaygpOwo+Pj4+PiArfQo+Pj4+PiArCj4+Pj4+
ICtzdGF0aWMgdm9pZCBkaXNhYmxlX3J4X21vZGVfd29yayhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2
aSkKPj4+Pj4gK3sKPj4+Pj4gKyAgICAgcnRubF9sb2NrKCk7Cj4+Pj4+ICsgICAgIHZpLT5yeF9t
b2RlX3dvcmtfZW5hYmxlZCA9IGZhbHNlOwo+Pj4+PiArICAgICBydG5sX3VubG9jaygpOwo+Pj4+
PiArfQo+Pj4+PiArCj4+Pj4+ICAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX25hcGlfc2NoZWR1bGUo
c3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+Pj4+PiAgIHsKPj4+Pj4gQEAgLTIzMTAs
OSArMjMzMCwxMSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfY2xvc2Uoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldikKPj4+Pj4gICAgICAgIHJldHVybiAwOwo+Pj4+PiAgIH0KPj4+Pj4KPj4+Pj4gLXN0YXRp
YyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPj4+Pj4g
K3N0YXRpYyB2b2lkIHZpcnRuZXRfcnhfbW9kZV93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29y
aykKPj4+Pj4gICB7Cj4+Pj4+IC0gICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0ZGV2
X3ByaXYoZGV2KTsKPj4+Pj4gKyAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPQo+Pj4+PiAr
ICAgICAgICAgICAgIGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgdmlydG5ldF9pbmZvLCByeF9t
b2RlX3dvcmspOwo+Pj4+PiArICAgICBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0gdmktPmRldjsK
Pj4+Pj4gICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCBzZ1syXTsKPj4+Pj4gICAgICAgIHN0cnVj
dCB2aXJ0aW9fbmV0X2N0cmxfbWFjICptYWNfZGF0YTsKPj4+Pj4gICAgICAgIHN0cnVjdCBuZXRk
ZXZfaHdfYWRkciAqaGE7Cj4+Pj4+IEBAIC0yMzI1LDYgKzIzNDcsOCBAQCBzdGF0aWMgdm9pZCB2
aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4+Pj4+ICAgICAgICBp
ZiAoIXZpcnRpb19oYXNfZmVhdHVyZSh2aS0+dmRldiwgVklSVElPX05FVF9GX0NUUkxfUlgpKQo+
Pj4+PiAgICAgICAgICAgICAgICByZXR1cm47Cj4+Pj4+Cj4+Pj4+ICsgICAgIHJ0bmxfbG9jaygp
Owo+Pj4+PiArCj4+Pj4+ICAgICAgICB2aS0+Y3RybC0+cHJvbWlzYyA9ICgoZGV2LT5mbGFncyAm
IElGRl9QUk9NSVNDKSAhPSAwKTsKPj4+Pj4gICAgICAgIHZpLT5jdHJsLT5hbGxtdWx0aSA9ICgo
ZGV2LT5mbGFncyAmIElGRl9BTExNVUxUSSkgIT0gMCk7Cj4+Pj4+Cj4+Pj4+IEBAIC0yMzQyLDE0
ICsyMzY2LDE5IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9k
ZXZpY2UgKmRldikKPj4+Pj4gICAgICAgICAgICAgICAgZGV2X3dhcm4oJmRldi0+ZGV2LCAiRmFp
bGVkIHRvICVzYWJsZSBhbGxtdWx0aSBtb2RlLlxuIiwKPj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgdmktPmN0cmwtPmFsbG11bHRpID8gImVuIiA6ICJkaXMiKTsKPj4+Pj4KPj4+Pj4gKyAg
ICAgbmV0aWZfYWRkcl9sb2NrX2JoKGRldik7Cj4+Pj4+ICsKPj4+Pj4gICAgICAgIHVjX2NvdW50
ID0gbmV0ZGV2X3VjX2NvdW50KGRldik7Cj4+Pj4+ICAgICAgICBtY19jb3VudCA9IG5ldGRldl9t
Y19jb3VudChkZXYpOwo+Pj4+PiAgICAgICAgLyogTUFDIGZpbHRlciAtIHVzZSBvbmUgYnVmZmVy
IGZvciBib3RoIGxpc3RzICovCj4+Pj4+ICAgICAgICBidWYgPSBremFsbG9jKCgodWNfY291bnQg
KyBtY19jb3VudCkgKiBFVEhfQUxFTikgKwo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAoMiAq
IHNpemVvZihtYWNfZGF0YS0+ZW50cmllcykpLCBHRlBfQVRPTUlDKTsKPj4+Pj4gICAgICAgIG1h
Y19kYXRhID0gYnVmOwo+Pj4+PiAtICAgICBpZiAoIWJ1ZikKPj4+Pj4gKyAgICAgaWYgKCFidWYp
IHsKPj4+Pj4gKyAgICAgICAgICAgICBuZXRpZl9hZGRyX3VubG9ja19iaChkZXYpOwo+Pj4+PiAr
ICAgICAgICAgICAgIHJ0bmxfdW5sb2NrKCk7Cj4+Pj4+ICAgICAgICAgICAgICAgIHJldHVybjsK
Pj4+Pj4gKyAgICAgfQo+Pj4+Pgo+Pj4+PiAgICAgICAgc2dfaW5pdF90YWJsZShzZywgMik7Cj4+
Pj4+Cj4+Pj4+IEBAIC0yMzcwLDYgKzIzOTksOCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9y
eF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4+Pj4+ICAgICAgICBuZXRkZXZfZm9yX2Vh
Y2hfbWNfYWRkcihoYSwgZGV2KQo+Pj4+PiAgICAgICAgICAgICAgICBtZW1jcHkoJm1hY19kYXRh
LT5tYWNzW2krK11bMF0sIGhhLT5hZGRyLCBFVEhfQUxFTik7Cj4+Pj4+Cj4+Pj4+ICsgICAgIG5l
dGlmX2FkZHJfdW5sb2NrX2JoKGRldik7Cj4+Pj4+ICsKPj4+Pj4gICAgICAgIHNnX3NldF9idWYo
JnNnWzFdLCBtYWNfZGF0YSwKPj4+Pj4gICAgICAgICAgICAgICAgICAgc2l6ZW9mKG1hY19kYXRh
LT5lbnRyaWVzKSArIChtY19jb3VudCAqIEVUSF9BTEVOKSk7Cj4+Pj4+Cj4+Pj4+IEBAIC0yMzc3
LDkgKzI0MDgsMTkgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2KQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJU
SU9fTkVUX0NUUkxfTUFDX1RBQkxFX1NFVCwgc2cpKQo+Pj4+PiAgICAgICAgICAgICAgICBkZXZf
d2FybigmZGV2LT5kZXYsICJGYWlsZWQgdG8gc2V0IE1BQyBmaWx0ZXIgdGFibGUuXG4iKTsKPj4+
Pj4KPj4+Pj4gKyAgICAgcnRubF91bmxvY2soKTsKPj4+Pj4gKwo+Pj4+PiAgICAgICAga2ZyZWUo
YnVmKTsKPj4+Pj4gICB9Cj4+Pj4+Cj4+Pj4+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9t
b2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4+Pj4+ICt7Cj4+Pj4+ICsgICAgIHN0cnVjdCB2
aXJ0bmV0X2luZm8gKnZpID0gbmV0ZGV2X3ByaXYoZGV2KTsKPj4+Pj4gKwo+Pj4+PiArICAgICBp
ZiAodmktPnJ4X21vZGVfd29ya19lbmFibGVkKQo+Pj4+PiArICAgICAgICAgICAgIHNjaGVkdWxl
X3dvcmsoJnZpLT5yeF9tb2RlX3dvcmspOwo+Pj4+PiArfQo+Pj4+PiArCj4+Pj4+ICAgc3RhdGlj
IGludCB2aXJ0bmV0X3ZsYW5fcnhfYWRkX3ZpZChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+Pj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19iZTE2IHByb3RvLCB1MTYgdmlk
KQo+Pj4+PiAgIHsKPj4+Pj4gQEAgLTMxNTAsNiArMzE5MSw4IEBAIHN0YXRpYyB2b2lkIHZpcnRu
ZXRfZnJlZXplX2Rvd24oc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+Pj4+Cj4+Pj4+ICAg
ICAgICAvKiBNYWtlIHN1cmUgbm8gd29yayBoYW5kbGVyIGlzIGFjY2Vzc2luZyB0aGUgZGV2aWNl
ICovCj4+Pj4+ICAgICAgICBmbHVzaF93b3JrKCZ2aS0+Y29uZmlnX3dvcmspOwo+Pj4+PiArICAg
ICBkaXNhYmxlX3J4X21vZGVfd29yayh2aSk7Cj4+Pj4+ICsgICAgIGZsdXNoX3dvcmsoJnZpLT5y
eF9tb2RlX3dvcmspOwo+Pj4+Pgo+Pj4+PiAgICAgICAgbmV0aWZfdHhfbG9ja19iaCh2aS0+ZGV2
KTsKPj4+Pj4gICAgICAgIG5ldGlmX2RldmljZV9kZXRhY2godmktPmRldik7Cj4+Pj4gU28gbm93
IGNvbmZpZ3VyYXRpb24gaXMgbm90IHByb3BhZ2F0ZWQgdG8gZGV2aWNlLgo+Pj4+IFdvbid0IGRl
dmljZSBsYXRlciB3YWtlIHVwIGluIHdyb25nIHN0YXRlPwo+Pj4+Cj4+Pj4KPj4+Pj4gQEAgLTMx
NzIsNiArMzIxNSw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9yZXN0b3JlX3VwKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2KQo+Pj4+PiAgICAgICAgdmlydGlvX2RldmljZV9yZWFkeSh2ZGV2KTsK
Pj4+Pj4KPj4+Pj4gICAgICAgIGVuYWJsZV9kZWxheWVkX3JlZmlsbCh2aSk7Cj4+Pj4+ICsgICAg
IGVuYWJsZV9yeF9tb2RlX3dvcmsodmkpOwo+Pj4+Pgo+Pj4+PiAgICAgICAgaWYgKG5ldGlmX3J1
bm5pbmcodmktPmRldikpIHsKPj4+Pj4gICAgICAgICAgICAgICAgZXJyID0gdmlydG5ldF9vcGVu
KHZpLT5kZXYpOwo+Pj4+PiBAQCAtMzk2OSw2ICs0MDEzLDcgQEAgc3RhdGljIGludCB2aXJ0bmV0
X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+Pj4+PiAgICAgICAgdmRldi0+cHJp
diA9IHZpOwo+Pj4+Pgo+Pj4+PiAgICAgICAgSU5JVF9XT1JLKCZ2aS0+Y29uZmlnX3dvcmssIHZp
cnRuZXRfY29uZmlnX2NoYW5nZWRfd29yayk7Cj4+Pj4+ICsgICAgIElOSVRfV09SSygmdmktPnJ4
X21vZGVfd29yaywgdmlydG5ldF9yeF9tb2RlX3dvcmspOwo+Pj4+PiAgICAgICAgc3Bpbl9sb2Nr
X2luaXQoJnZpLT5yZWZpbGxfbG9jayk7Cj4+Pj4+Cj4+Pj4+ICAgICAgICBpZiAodmlydGlvX2hh
c19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9NUkdfUlhCVUYpKSB7Cj4+Pj4+IEBAIC00MDc3
LDYgKzQxMjIsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYpCj4+Pj4+ICAgICAgICBpZiAodmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFz
aF9yZXBvcnQpCj4+Pj4+ICAgICAgICAgICAgICAgIHZpcnRuZXRfaW5pdF9kZWZhdWx0X3Jzcyh2
aSk7Cj4+Pj4+Cj4+Pj4+ICsgICAgIGVuYWJsZV9yeF9tb2RlX3dvcmsodmkpOwo+Pj4+PiArCj4+
Pj4+ICAgICAgICAvKiBzZXJpYWxpemUgbmV0ZGV2IHJlZ2lzdGVyICsgdmlydGlvX2RldmljZV9y
ZWFkeSgpIHdpdGggbmRvX29wZW4oKSAqLwo+Pj4+PiAgICAgICAgcnRubF9sb2NrKCk7Cj4+Pj4+
Cj4+Pj4+IEBAIC00MTc0LDYgKzQyMjEsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3JlbW92ZShz
dHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4+Pj4KPj4+Pj4gICAgICAgIC8qIE1ha2Ugc3Vy
ZSBubyB3b3JrIGhhbmRsZXIgaXMgYWNjZXNzaW5nIHRoZSBkZXZpY2UuICovCj4+Pj4+ICAgICAg
ICBmbHVzaF93b3JrKCZ2aS0+Y29uZmlnX3dvcmspOwo+Pj4+PiArICAgICBkaXNhYmxlX3J4X21v
ZGVfd29yayh2aSk7Cj4+Pj4+ICsgICAgIGZsdXNoX3dvcmsoJnZpLT5yeF9tb2RlX3dvcmspOwo+
Pj4+Pgo+Pj4+PiAgICAgICAgdW5yZWdpc3Rlcl9uZXRkZXYodmktPmRldik7Cj4+Pj4+Cj4+Pj4+
IC0tCj4+Pj4+IDIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
