Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F85C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 09:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E58F6403A7;
	Tue, 27 Dec 2022 09:17:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E58F6403A7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ew05d883
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AuiDBxdITjGz; Tue, 27 Dec 2022 09:17:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EF3C940272;
	Tue, 27 Dec 2022 09:17:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF3C940272
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCAF5C0035;
	Tue, 27 Dec 2022 09:17:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 624D4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 354A5812D0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 354A5812D0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ew05d883
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id guAJSDu_EL7A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:17:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 252B1812A8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 252B1812A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672132649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/bktaJTYphckb8lHBVzp0LupQSLPFA4q1rNEqzTk5Pg=;
 b=ew05d883WO+YhK+lA8JRgLHyb7fQqkt+iGRJWCl5AMMy1OC9L0uwY/wTAS42911GANc5gI
 b18QCYQj7LDU6O/6P9fNeMkBx6jzm3Ggs1Wx4Qyhoal7SbW5pqBhCvda3o5k895FDG4fd9
 HMzlm0QyXYWgViGs6SGxW/tQMm6eNg0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-96-vKOjVeCVNJmtaX5fUO-Xsw-1; Tue, 27 Dec 2022 04:17:27 -0500
X-MC-Unique: vKOjVeCVNJmtaX5fUO-Xsw-1
Received: by mail-pj1-f72.google.com with SMTP id
 om16-20020a17090b3a9000b002216006cbffso10733348pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 01:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/bktaJTYphckb8lHBVzp0LupQSLPFA4q1rNEqzTk5Pg=;
 b=LF+zA1ESqrXAUn7UIl3JIYtKGTg8WlOLnE3n6hYTbqLaQGnhM4SZ4Dwwef3Fmrbl7w
 f39c5kaaLl8R8Rk+AcymnpYufzirWDs/oLlFtQHKeYTITFC9cu+j2qowQ6/YNbEBlEkO
 OoqeuWG6ywJ9PJqwNmmaM07yvHUxgib0zot3GYNtv3bXZ9yMQ0jP5MnRkku6Ue+IxLmm
 kfmBMOV/JcaW7HBjtcoFgqpdBtUrixUbQFhkbNSdYzpVUoNzYNoizzMXSlBosR8DB1FJ
 52jLkNubvilhDd2IgWDMYWmmfBD+ZWtl+yQ+uwqlorYRzAoaK2FVtBEdJvv9AWd58vGK
 kmfQ==
X-Gm-Message-State: AFqh2ko935ZFKVmgBJdbVw2m3WgpIUkd1QB2TKFoaG8Pw97NxoyVl/33
 xGHHzz0Oe3ARJedFk6XIDPlI/lqX1Enpp99oVhUGnxazaXLx/dR5Djvr7ujB89k7SbIdlJrQ9QM
 bWvT6dL83Rb+FuRl0dwPUY3eZJDHxYo9vZaUweHfk/A==
X-Received: by 2002:a17:902:bf45:b0:189:fa12:c98a with SMTP id
 u5-20020a170902bf4500b00189fa12c98amr19633299pls.66.1672132646700; 
 Tue, 27 Dec 2022 01:17:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs9EjmLJOCvG9yHpAmbhIHrWsBZcO0zpncQsDqCZILYEeGXTIH6gY7wrxLHaEgelRlHT8YkLg==
X-Received: by 2002:a17:902:bf45:b0:189:fa12:c98a with SMTP id
 u5-20020a170902bf4500b00189fa12c98amr19633282pls.66.1672132646435; 
 Tue, 27 Dec 2022 01:17:26 -0800 (PST)
Received: from [10.72.13.143] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170903120600b00188a908cbddsm8485162plh.302.2022.12.27.01.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Dec 2022 01:17:26 -0800 (PST)
Message-ID: <1ddb2a26-cbc3-d561-6a0d-24adf206db17@redhat.com>
Date: Tue, 27 Dec 2022 17:17:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
 <20221227014641-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221227014641-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, kuba@kernel.org, maxime.coquelin@redhat.com,
 pabeni@redhat.com, davem@davemloft.net
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

CuWcqCAyMDIyLzEyLzI3IDE0OjU4LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IE9uIFR1
ZSwgRGVjIDI3LCAyMDIyIGF0IDEyOjMzOjUzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDEwOjI1IEFNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Pj4gT24gTW9uLCAyNiBEZWMgMjAyMiAxNTo0OTowOCAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4gV2UgdXNl
ZCB0byBidXN5IHdhaXRpbmcgb24gdGhlIGN2cSBjb21tYW5kIHRoaXMgdGVuZHMgdG8gYmUKPj4+
PiBwcm9ibGVtYXRpYyBzaW5jZToKPj4+Pgo+Pj4+IDEpIENQVSBjb3VsZCB3YWl0IGZvciBldmVy
IG9uIGEgYnVnZ3kvbWFsaWNvdXMgZGV2aWNlCj4+Pj4gMikgVGhlcmUncyBubyB3YWl0IHRvIHRl
cm1pbmF0ZSB0aGUgcHJvY2VzcyB0aGF0IHRyaWdnZXJzIHRoZSBjdnEKPj4+PiAgICAgY29tbWFu
ZAo+Pj4+Cj4+Pj4gU28gdGhpcyBwYXRjaCBzd2l0Y2ggdG8gdXNlIHZpcnRxdWV1ZV93YWl0X2Zv
cl91c2VkKCkgdG8gc2xlZXAgd2l0aCBhCj4+Pj4gdGltZW91dCAoMXMpIGluc3RlYWQgb2YgYnVz
eSBwb2xsaW5nIGZvciB0aGUgY3ZxIGNvbW1hbmQgZm9yZXZlci4gVGhpcwo+Pj4gSSBkb24ndCB0
aGluayB0aGF0IGEgZml4ZWQgMVMgaXMgYSBnb29kIGNob2ljZS4KPj4gV2VsbCwgaXQgY291bGQg
YmUgdHdlYWtlZCB0byBiZSBhIGxpdHRsZSBiaXQgbG9uZ2VyLgo+Pgo+PiBPbmUgd2F5LCBhcyBk
aXNjdXNzZWQsIGlzIHRvIGxldCB0aGUgZGV2aWNlIGFkdmVydGlzZSBhIHRpbWVvdXQgdGhlbgo+
PiB0aGUgZHJpdmVyIGNhbiB2YWxpZGF0ZSBpZiBpdCdzIHZhbGlkIGFuZCB1c2UgdGhhdCB0aW1l
b3V0LiBCdXQgaXQKPj4gbmVlZHMgZXh0ZW5zaW9uIHRvIHRoZSBzcGVjLgo+IENvbnRyb2xsaW5n
IHRpbWVvdXQgZnJvbSBkZXZpY2UgaXMgYSBnb29kIGlkZWEsIGUuZy4gaGFyZHdhcmUgZGV2aWNl
cwo+IHdvdWxkIGJlbmVmaXQgZnJvbSBhIHNob3J0ZXIgdGltZW91dCwgaHlwZXJ2aXNvciBkZXZp
Y2VzIGZyb20gYSBsb25nZXIKPiB0aW1lb3V0IG9yIG5vIHRpbWVvdXQuCgoKWWVzLgoKCj4KPj4+
IFNvbWUgb2YgdGhlIERQVXMgYXJlIHZlcnkKPj4+IGxhenkgZm9yIGN2cSBoYW5kbGUuCj4+IFN1
Y2ggZGVzaWduIG5lZWRzIHRvIGJlIHJldmlzaXRlZCwgY3ZxIChjb250cm9sIHBhdGgpIHNob3Vs
ZCBoYXZlIGEKPj4gYmV0dGVyIHByaW9yaXR5IG9yIFFPUyB0aGFuIGRhdGFwYXRoLgo+IFNwZWMg
c2F5cyBub3RoaW5nIGFib3V0IHRoaXMsIHNvIGRyaXZlciBjYW4ndCBhc3N1bWUgdGhpcyBlaXRo
ZXIuCgoKV2VsbCwgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGl0J3MgbW9yZSB0aGFuIHdoYXQg
c3BlYyBjYW4gZGVmaW5lIG9yIAppdCdzIGEga2luZCBvZiBiZXN0IHByYWN0aWNlLgoKVGhlIGN1
cnJlbnQgY29kZSBpcyBvbmUgZXhhbXBsZSwgdGhhdCBpcywgZHJpdmVyIG1heSBjaG9vc2UgdG8g
YnVzeSBwb2xsIAp3aGljaCBjYXVzZSBzcGlrZS4KCgo+Cj4+PiBJbiBwYXJ0aWN1bGFyLCB3ZSB3
aWxsIGFsc28gZGlyZWN0bHkgYnJlYWsgdGhlIGRldmljZS4KPj4gSXQncyBraW5kIG9mIGhhcmRl
bmluZyBmb3IgbWFsaWNpb3VzIGRldmljZXMuCj4gQVRNIG5vIGFtb3VudCBvZiBoYXJkZW5pbmcg
Y2FuIHByZXZlbnQgYSBtYWxpY2lvdXMgaHlwZXJ2aXNvciBmcm9tCj4gYmxvY2tpbmcgdGhlIGd1
ZXN0LiBSZWNvdmVyaW5nIHdoZW4gYSBoYXJkd2FyZSBkZXZpY2UgaXMgYnJva2VuIHdvdWxkIGJl
Cj4gbmljZSBidXQgSSB0aGluayBpZiB3ZSBkbyBib3RoZXIgdGhlbiB3ZSBzaG91bGQgdHJ5IGhh
cmRlciB0byByZWNvdmVyLAo+IHN1Y2ggYXMgYnkgZHJpdmluZyBkZXZpY2UgcmVzZXQuCgoKUHJv
YmFibHksIGJ1dCBhcyBkaXNjdXNzZWQgaW4gYW5vdGhlciB0aHJlYWQsIGl0IG5lZWRzIGNvLW9w
ZXJhdGlvbiBpbiAKdGhlIHVwcGVyIGxheWVyIChuZXR3b3JraW5nIGNvcmUpLgoKCj4KPgo+IEFs
c28sIGRvZXMgeW91ciBwYXRjaCBicmVhayBzdXJwcmlzZSByZW1vdmFsPyBUaGVyZSdzIG5vIGNh
bGxiYWNrCj4gaW4gdGhpcyBjYXNlIEFUTS4KCgpJIHRoaW5rIG5vdCAoc2VlIHJlcGx5IGluIGFu
b3RoZXIgdGhyZWFkKS4KClRoYW5rcwoKCj4KPj4+IEkgdGhpbmsgaXQgaXMgbmVjZXNzYXJ5IHRv
IGFkZCBhIFZpcnRpby1OZXQgcGFyYW1ldGVyIHRvIGFsbG93IHVzZXJzIHRvIGRlZmluZQo+Pj4g
dGhpcyB0aW1lb3V0IGJ5IHRoZW1zZWx2ZXMuIEFsdGhvdWdoIEkgZG9uJ3QgdGhpbmsgdGhpcyBp
cyBhIGdvb2Qgd2F5Lgo+PiBWZXJ5IGhhcmQgYW5kIHVuZnJpZW5kbHkgdG8gdGhlIGVuZCB1c2Vy
cy4KPj4KPj4gVGhhbmtzCj4+Cj4+PiBUaGFua3MuCj4+Pgo+Pj4KPj4+PiBnaXZlcyB0aGUgc2No
ZWR1bGVyIGEgYnJlYXRoIGFuZCBjYW4gbGV0IHRoZSBwcm9jZXNzIGNhbiByZXNwb25kIHRvCj4+
Pj4gYXNpZ25hbC4gSWYgdGhlIGRldmljZSBkb2Vzbid0IHJlc3BvbmQgaW4gdGhlIHRpbWVvdXQs
IGJyZWFrIHRoZQo+Pj4+IGRldmljZS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+Pj4gLS0tCj4+Pj4gQ2hhbmdlcyBzaW5jZSBWMToK
Pj4+PiAtIGJyZWFrIHRoZSBkZXZpY2Ugd2hlbiB0aW1lb3V0Cj4+Pj4gLSBnZXQgYnVmZmVyIG1h
bnVhbGx5IHNpbmNlIHRoZSB2aXJ0aW8gY29yZSBjaGVjayBtb3JlX3VzZWQoKSBpbnN0ZWFkCj4+
Pj4gLS0tCj4+Pj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyNCArKysrKysrKysrKysr
KysrLS0tLS0tLS0KPj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+IGluZGV4IGVmZDlkZDU1ODI4Yi4uNmEy
ZWE2NGNmY2I1IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+
ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+IEBAIC00MDUsNiArNDA1LDcgQEAg
c3RhdGljIHZvaWQgZGlzYWJsZV9yeF9tb2RlX3dvcmsoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkp
Cj4+Pj4gICAgICAgIHZpLT5yeF9tb2RlX3dvcmtfZW5hYmxlZCA9IGZhbHNlOwo+Pj4+ICAgICAg
ICBzcGluX3VubG9ja19iaCgmdmktPnJ4X21vZGVfbG9jayk7Cj4+Pj4KPj4+PiArICAgICB2aXJ0
cXVldWVfd2FrZV91cCh2aS0+Y3ZxKTsKPj4+PiAgICAgICAgZmx1c2hfd29yaygmdmktPnJ4X21v
ZGVfd29yayk7Cj4+Pj4gICB9Cj4+Pj4KPj4+PiBAQCAtMTQ5Nyw2ICsxNDk4LDExIEBAIHN0YXRp
YyBib29sIHRyeV9maWxsX3JlY3Yoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCByZWNl
aXZlX3F1ZXVlICpycSwKPj4+PiAgICAgICAgcmV0dXJuICFvb207Cj4+Pj4gICB9Cj4+Pj4KPj4+
PiArc3RhdGljIHZvaWQgdmlydG5ldF9jdnFfZG9uZShzdHJ1Y3QgdmlydHF1ZXVlICpjdnEpCj4+
Pj4gK3sKPj4+PiArICAgICB2aXJ0cXVldWVfd2FrZV91cChjdnEpOwo+Pj4+ICt9Cj4+Pj4gKwo+
Pj4+ICAgc3RhdGljIHZvaWQgc2tiX3JlY3ZfZG9uZShzdHJ1Y3QgdmlydHF1ZXVlICpydnEpCj4+
Pj4gICB7Cj4+Pj4gICAgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gcnZxLT52ZGV2LT5w
cml2Owo+Pj4+IEBAIC0xOTg0LDYgKzE5OTAsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfdHhfcmVz
aXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+Pj4+ICAgICAgICByZXR1cm4gZXJyOwo+Pj4+
ICAgfQo+Pj4+Cj4+Pj4gK3N0YXRpYyBpbnQgdmlydG5ldF9jbG9zZShzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2KTsKPj4+PiArCj4+Pj4gICAvKgo+Pj4+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0aGUg
Y29udHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4+Pj4gICAgKiBz
dXBwb3J0ZWQgYnkgdGhlIGh5cGVydmlzb3IsIGFzIGluZGljYXRlZCBieSBmZWF0dXJlIGJpdHMs
IHNob3VsZAo+Pj4+IEBAIC0yMDI2LDE0ICsyMDM0LDE0IEBAIHN0YXRpYyBib29sIHZpcnRuZXRf
c2VuZF9jb21tYW5kKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCB1OCBjbGFzcywgdTggY21kLAo+
Pj4+ICAgICAgICBpZiAodW5saWtlbHkoIXZpcnRxdWV1ZV9raWNrKHZpLT5jdnEpKSkKPj4+PiAg
ICAgICAgICAgICAgICByZXR1cm4gdmktPmN0cmwtPnN0YXR1cyA9PSBWSVJUSU9fTkVUX09LOwo+
Pj4+Cj4+Pj4gLSAgICAgLyogU3BpbiBmb3IgYSByZXNwb25zZSwgdGhlIGtpY2sgY2F1c2VzIGFu
IGlvcG9ydCB3cml0ZSwgdHJhcHBpbmcKPj4+PiAtICAgICAgKiBpbnRvIHRoZSBoeXBlcnZpc29y
LCBzbyB0aGUgcmVxdWVzdCBzaG91bGQgYmUgaGFuZGxlZCBpbW1lZGlhdGVseS4KPj4+PiAtICAg
ICAgKi8KPj4+PiAtICAgICB3aGlsZSAoIXZpcnRxdWV1ZV9nZXRfYnVmKHZpLT5jdnEsICZ0bXAp
ICYmCj4+Pj4gLSAgICAgICAgICAgICF2aXJ0cXVldWVfaXNfYnJva2VuKHZpLT5jdnEpKQo+Pj4+
IC0gICAgICAgICAgICAgY3B1X3JlbGF4KCk7Cj4+Pj4gKyAgICAgaWYgKHZpcnRxdWV1ZV93YWl0
X2Zvcl91c2VkKHZpLT5jdnEpKSB7Cj4+Pj4gKyAgICAgICAgICAgICB2aXJ0cXVldWVfZ2V0X2J1
Zih2aS0+Y3ZxLCAmdG1wKTsKPj4+PiArICAgICAgICAgICAgIHJldHVybiB2aS0+Y3RybC0+c3Rh
dHVzID09IFZJUlRJT19ORVRfT0s7Cj4+Pj4gKyAgICAgfQo+Pj4+Cj4+Pj4gLSAgICAgcmV0dXJu
IHZpLT5jdHJsLT5zdGF0dXMgPT0gVklSVElPX05FVF9PSzsKPj4+PiArICAgICBuZXRkZXZfZXJy
KHZpLT5kZXYsICJDVlEgY29tbWFuZCB0aW1lb3V0LCBicmVhayB0aGUgdmlydGlvIGRldmljZS4i
KTsKPj4+PiArICAgICB2aXJ0aW9fYnJlYWtfZGV2aWNlKHZpLT52ZGV2KTsKPj4+PiArICAgICBy
ZXR1cm4gVklSVElPX05FVF9FUlI7Cj4+Pj4gICB9Cj4+Pj4KPj4+PiAgIHN0YXRpYyBpbnQgdmly
dG5ldF9zZXRfbWFjX2FkZHJlc3Moc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgdm9pZCAqcCkKPj4+
PiBAQCAtMzUyNiw3ICszNTM0LDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X2ZpbmRfdnFzKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpKQo+Pj4+Cj4+Pj4gICAgICAgIC8qIFBhcmFtZXRlcnMgZm9yIGNv
bnRyb2wgdmlydHF1ZXVlLCBpZiBhbnkgKi8KPj4+PiAgICAgICAgaWYgKHZpLT5oYXNfY3ZxKSB7
Cj4+Pj4gLSAgICAgICAgICAgICBjYWxsYmFja3NbdG90YWxfdnFzIC0gMV0gPSBOVUxMOwo+Pj4+
ICsgICAgICAgICAgICAgY2FsbGJhY2tzW3RvdGFsX3ZxcyAtIDFdID0gdmlydG5ldF9jdnFfZG9u
ZTsKPj4+PiAgICAgICAgICAgICAgICBuYW1lc1t0b3RhbF92cXMgLSAxXSA9ICJjb250cm9sIjsK
Pj4+PiAgICAgICAgfQo+Pj4+Cj4+Pj4gLS0KPj4+PiAyLjI1LjEKPj4+Pgo+Pj4+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4gVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0Cj4+Pj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKPj4+PiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
