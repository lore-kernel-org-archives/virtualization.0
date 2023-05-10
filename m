Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971E0C77B7C
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 05:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E940884691;
	Wed, 10 May 2023 05:00:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E940884691
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PEF9gLl+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JAf0SQyXQ7HJ; Wed, 10 May 2023 05:00:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2F05984188;
	Wed, 10 May 2023 05:00:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F05984188
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 069E3C0037;
	Wed, 10 May 2023 05:00:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A79EBC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 05:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A62C60FB9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 05:00:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A62C60FB9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PEF9gLl+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yg01-7k4IYMW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 05:00:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D96BE60E00
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D96BE60E00
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 05:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683694821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XeGHjCbz8dSGYd3TX1liaACMeHk61OyZyX7cZcDFTH4=;
 b=PEF9gLl+qc2ztQLWEa4LgsE1N1cQaWQjUVNMisaL2wBttw93J2y0iVVevPnNYzRwdUXWO9
 P/Vl1hqlGUiZwGJ0G0J8d+hY+7iLDfndP0ZcCWtPHJTa2J9jhde23XV3EBUKjFqWX3p1Wy
 uKylZKtRkwRnam2nUnrxW2ioXAoHvV4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-wGmh3KujPS-nmEl7P6-XtQ-1; Wed, 10 May 2023 01:00:20 -0400
X-MC-Unique: wGmh3KujPS-nmEl7P6-XtQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-51f7638a56fso6159225a12.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 22:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683694819; x=1686286819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XeGHjCbz8dSGYd3TX1liaACMeHk61OyZyX7cZcDFTH4=;
 b=QL454yQyO6UHi9vCcNHYknpMcQQgajiDFyBmFhOdhJhYOJOHW7hSr6eMnBUTSuvGpY
 ME6gJUpMuSfDhN5foWPvzacoE3LII5wHTroAd1b1V05O987kMo1Jx8e3xm1ruBnQK9iA
 qbxXJvUUJVGVJei8SbyRoATM9+wU4sKGdaWoNzEvBEwMXmMNdWu6W3Qt4XXp2eZqTfA/
 Kd+Olz1sbUXdqY//vIxKqyvSZB8TkOgwHZOLczlhvtwgLUzcWnxQ4COoBQpeYMLgdEfZ
 6clhR1rvspEKiNXtYugC6VQ4z5yyTQT/sj0DKifRpaMRcs2uZSGigt9Lp7Jr1YU16lKs
 XGjQ==
X-Gm-Message-State: AC+VfDxuGLB8LvrIXK4UToVqxmkpRBH/op7Vc9MLaHYJSSmz3UAqfIVb
 6HdZTA1/TBeBnRflveXTj4DuDr0v0LleePnLqXvg9zw3BnCF6rkSj8HkvBVJEZ8UeM2V6sLjD1b
 2Yu1g9j3JIDiWtrVft/30Ieuzt+4DjrYNN+t4H3sPtw==
X-Received: by 2002:a05:6a20:549e:b0:100:4369:164a with SMTP id
 i30-20020a056a20549e00b001004369164amr14030934pzk.46.1683694819294; 
 Tue, 09 May 2023 22:00:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ebCTud1rBz1QnWQJHfKRmNeCZ/yR49zeE232z167CAyNmOh2ig/ETAvy8858079sOcnIVIQ==
X-Received: by 2002:a05:6a20:549e:b0:100:4369:164a with SMTP id
 i30-20020a056a20549e00b001004369164amr14030897pzk.46.1683694818843; 
 Tue, 09 May 2023 22:00:18 -0700 (PDT)
Received: from [10.72.13.243] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 w12-20020aa7858c000000b0064867dc8719sm188015pfn.118.2023.05.09.22.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 May 2023 22:00:18 -0700 (PDT)
Message-ID: <a13a2d3f-e76e-b6a6-3d30-d5534e2fa917@redhat.com>
Date: Wed, 10 May 2023 13:00:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH net v3] virtio_net: Fix error unwinding of XDP
 initialization
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Feng Liu <feliu@nvidia.com>
References: <20230503003525.48590-1-feliu@nvidia.com>
 <1683340417.612963-3-xuanzhuo@linux.alibaba.com>
 <559ad341-2278-5fad-6805-c7f632e9894e@nvidia.com>
 <1683510351.569717-1-xuanzhuo@linux.alibaba.com>
 <c2c2bfed-bdf1-f517-559c-f51c9ca1807a@nvidia.com>
 <1683596602.483001-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1683596602.483001-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Simon Horman <simon.horman@corigine.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, William Tu <witu@nvidia.com>,
 netdev@vger.kernel.org, Bodong Wang <bodong@nvidia.com>, bpf@vger.kernel.org
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

CuWcqCAyMDIzLzUvOSAwOTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBNb24sIDggTWF5IDIw
MjMgMTE6MDA6MTAgLTA0MDAsIEZlbmcgTGl1IDxmZWxpdUBudmlkaWEuY29tPiB3cm90ZToKPj4K
Pj4gT24gMjAyMy0wNS0wNyBwLm0uOTo0NSwgWHVhbiBaaHVvIHdyb3RlOgo+Pj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPj4+Cj4+Pgo+
Pj4gT24gU2F0LCA2IE1heSAyMDIzIDA4OjA4OjAyIC0wNDAwLCBGZW5nIExpdSA8ZmVsaXVAbnZp
ZGlhLmNvbT4gd3JvdGU6Cj4+Pj4KPj4+PiBPbiAyMDIzLTA1LTA1IHAubS4xMDozMywgWHVhbiBa
aHVvIHdyb3RlOgo+Pj4+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5r
cyBvciBhdHRhY2htZW50cwo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBPbiBUdWUsIDIgTWF5IDIwMjMgMjA6
MzU6MjUgLTA0MDAsIEZlbmcgTGl1IDxmZWxpdUBudmlkaWEuY29tPiB3cm90ZToKPj4+Pj4+IFdo
ZW4gaW5pdGlhbGl6aW5nIFhEUCBpbiB2aXJ0bmV0X29wZW4oKSwgc29tZSBycSB4ZHAgaW5pdGlh
bGl6YXRpb24KPj4+Pj4+IG1heSBoaXQgYW4gZXJyb3IgY2F1c2luZyBuZXQgZGV2aWNlIG9wZW4g
ZmFpbGVkLiBIb3dldmVyLCBwcmV2aW91cwo+Pj4+Pj4gcnFzIGhhdmUgYWxyZWFkeSBpbml0aWFs
aXplZCBYRFAgYW5kIGVuYWJsZWQgTkFQSSwgd2hpY2ggaXMgbm90IHRoZQo+Pj4+Pj4gZXhwZWN0
ZWQgYmVoYXZpb3IuIE5lZWQgdG8gcm9sbCBiYWNrIHRoZSBwcmV2aW91cyBycSBpbml0aWFsaXph
dGlvbgo+Pj4+Pj4gdG8gYXZvaWQgbGVha3MgaW4gZXJyb3IgdW53aW5kaW5nIG9mIGluaXQgY29k
ZS4KPj4+Pj4+Cj4+Pj4+PiBBbHNvIGV4dHJhY3QgYSBoZWxwZXIgZnVuY3Rpb24gb2YgZGlzYWJs
ZSBxdWV1ZSBwYWlycywgYW5kIHVzZSBuZXdseQo+Pj4+Pj4gaW50cm9kdWNlZCBoZWxwZXIgZnVu
Y3Rpb24gaW4gZXJyb3IgdW53aW5kaW5nIGFuZCB2aXJ0bmV0X2Nsb3NlOwo+Pj4+Pj4KPj4+Pj4+
IElzc3VlOiAzMzgzMDM4Cj4+Pj4+PiBGaXhlczogNzU0YjhhMjFhOTZkICgidmlydGlvX25ldDog
c2V0dXAgeGRwX3J4cV9pbmZvIikKPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEZlbmcgTGl1IDxmZWxp
dUBudmlkaWEuY29tPgo+Pj4+Pj4gUmV2aWV3ZWQtYnk6IFdpbGxpYW0gVHUgPHdpdHVAbnZpZGlh
LmNvbT4KPj4+Pj4+IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+
Cj4+Pj4+PiBSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxzaW1vbi5ob3JtYW5AY29yaWdpbmUu
Y29tPgo+Pj4+Pj4gQWNrZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+
Cj4+Pj4+PiBDaGFuZ2UtSWQ6IEliNGM2YTk3Y2I3YjgzN2NmYTQ4NGM1OTNkZDQzYTQzNWM0N2Vh
NjhmCj4+Pj4+PiAtLS0KPj4+Pj4+ICAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAzMCAr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwg
MjAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4+Pj4+Pgo+Pj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+
Pj4+Pj4gaW5kZXggOGQ4MDM4NTM4ZmM0Li4zNzM3Y2YxMjBjYjcgMTAwNjQ0Cj4+Pj4+PiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYwo+Pj4+Pj4gQEAgLTE4NjgsNiArMTg2OCwxMyBAQCBzdGF0aWMgaW50IHZpcnRuZXRf
cG9sbChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4+Pj4+PiAgICAgICAg
ICByZXR1cm4gcmVjZWl2ZWQ7Cj4+Pj4+PiAgICAgfQo+Pj4+Pj4KPj4+Pj4+ICtzdGF0aWMgdm9p
ZCB2aXJ0bmV0X2Rpc2FibGVfcXAoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIGludCBxcF9pbmRl
eCkKPj4+Pj4+ICt7Cj4+Pj4+PiArICAgICB2aXJ0bmV0X25hcGlfdHhfZGlzYWJsZSgmdmktPnNx
W3FwX2luZGV4XS5uYXBpKTsKPj4+Pj4+ICsgICAgIG5hcGlfZGlzYWJsZSgmdmktPnJxW3FwX2lu
ZGV4XS5uYXBpKTsKPj4+Pj4+ICsgICAgIHhkcF9yeHFfaW5mb191bnJlZygmdmktPnJxW3FwX2lu
ZGV4XS54ZHBfcnhxKTsKPj4+Pj4+ICt9Cj4+Pj4+PiArCj4+Pj4+PiAgICAgc3RhdGljIGludCB2
aXJ0bmV0X29wZW4oc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPj4+Pj4+ICAgICB7Cj4+Pj4+PiAg
ICAgICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4+Pj4+
PiBAQCAtMTg4MywyMCArMTg5MCwyNiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfb3BlbihzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2KQo+Pj4+Pj4KPj4+Pj4+ICAgICAgICAgICAgICAgICAgZXJyID0geGRw
X3J4cV9pbmZvX3JlZygmdmktPnJxW2ldLnhkcF9yeHEsIGRldiwgaSwgdmktPnJxW2ldLm5hcGku
bmFwaV9pZCk7Cj4+Pj4+PiAgICAgICAgICAgICAgICAgIGlmIChlcnIgPCAwKQo+Pj4+Pj4gLSAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4+Pj4+PiArICAgICAgICAgICAgICAgICAg
ICAgZ290byBlcnJfeGRwX2luZm9fcmVnOwo+Pj4+Pj4KPj4+Pj4+ICAgICAgICAgICAgICAgICAg
ZXJyID0geGRwX3J4cV9pbmZvX3JlZ19tZW1fbW9kZWwoJnZpLT5ycVtpXS54ZHBfcnhxLAo+Pj4+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1f
VFlQRV9QQUdFX1NIQVJFRCwgTlVMTCk7Cj4+Pj4+PiAtICAgICAgICAgICAgIGlmIChlcnIgPCAw
KSB7Cj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgeGRwX3J4cV9pbmZvX3VucmVnKCZ2aS0+
cnFbaV0ueGRwX3J4cSk7Cj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsK
Pj4+Pj4+IC0gICAgICAgICAgICAgfQo+Pj4+Pj4gKyAgICAgICAgICAgICBpZiAoZXJyIDwgMCkK
Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94ZHBfcmVnX21lbV9tb2RlbDsK
Pj4+Pj4+Cj4+Pj4+PiAgICAgICAgICAgICAgICAgIHZpcnRuZXRfbmFwaV9lbmFibGUodmktPnJx
W2ldLnZxLCAmdmktPnJxW2ldLm5hcGkpOwo+Pj4+Pj4gICAgICAgICAgICAgICAgICB2aXJ0bmV0
X25hcGlfdHhfZW5hYmxlKHZpLCB2aS0+c3FbaV0udnEsICZ2aS0+c3FbaV0ubmFwaSk7Cj4+Pj4+
PiAgICAgICAgICB9Cj4+Pj4+Pgo+Pj4+Pj4gICAgICAgICAgcmV0dXJuIDA7Cj4+Pj4+PiArCj4+
Pj4+PiArZXJyX3hkcF9yZWdfbWVtX21vZGVsOgo+Pj4+Pj4gKyAgICAgeGRwX3J4cV9pbmZvX3Vu
cmVnKCZ2aS0+cnFbaV0ueGRwX3J4cSk7Cj4+Pj4+PiArZXJyX3hkcF9pbmZvX3JlZzoKPj4+Pj4+
ICsgICAgIGZvciAoaSA9IGkgLSAxOyBpID49IDA7IGktLSkKPj4+Pj4+ICsgICAgICAgICAgICAg
dmlydG5ldF9kaXNhYmxlX3FwKHZpLCBpKTsKPj4+Pj4KPj4+Pj4gSSB3b3VsZCB0byBrbm93IHNo
b3VsZCB3ZSBoYW5kbGUgZm9yIHRoZXNlOgo+Pj4+Pgo+Pj4+PiAgICAgICAgICAgIGRpc2FibGVf
ZGVsYXllZF9yZWZpbGwodmkpOwo+Pj4+PiAgICAgICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmtf
c3luYygmdmktPnJlZmlsbCk7Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+IE1heWJlIHdlIHNob3VsZCBjYWxs
IHZpcnRuZXRfY2xvc2UoKSB3aXRoICJpIiBkaXJlY3RseS4KPj4+Pj4KPj4+Pj4gVGhhbmtzLgo+
Pj4+Pgo+Pj4+Pgo+Pj4+IENhbuKAmXQgdXNlIGkgZGlyZWN0bHkgaGVyZSwgYmVjYXVzZSBpZiB4
ZHBfcnhxX2luZm9fcmVnIGZhaWxzLCBuYXBpIGhhcwo+Pj4+IG5vdCBiZWVuIGVuYWJsZWQgZm9y
IGN1cnJlbnQgcXAgeWV0LCBJIHNob3VsZCByb2xsIGJhY2sgZnJvbSB0aGUgcXVldWUKPj4+PiBw
YWlycyB3aGVyZSBuYXBpIHdhcyBlbmFibGVkIGJlZm9yZShpLS0pLCBvdGhlcndpc2UgaXQgd2ls
bCBoYW5nIGF0IG5hcGkKPj4+PiBkaXNhYmxlIGFwaQo+Pj4gVGhpcyBpcyBub3QgdGhlIHBvaW50
LCB0aGUga2V5IGlzIHdoZXRoZXIgd2Ugc2hvdWxkIGhhbmRsZSB3aXRoOgo+Pj4KPj4+ICAgICAg
ICAgICAgIGRpc2FibGVfZGVsYXllZF9yZWZpbGwodmkpOwo+Pj4gICAgICAgICAgICAgY2FuY2Vs
X2RlbGF5ZWRfd29ya19zeW5jKCZ2aS0+cmVmaWxsKTsKPj4+Cj4+PiBUaGFua3MuCj4+Pgo+Pj4K
Pj4gT0ssIGdldCB0aGUgcG9pbnQuIFRoYW5rcyBmb3IgeW91ciBjYXJlZnVsIHJldmlldy4gQW5k
IEkgY2hlY2sgdGhlIGNvZGUKPj4gYWdhaW4uCj4+Cj4+IFRoZXJlIGFyZSB0d28gcG9pbnRzIHRo
YXQgSSBuZWVkIHRvIGV4cGxhaW46Cj4+Cj4+IDEuIEFsbCByZWZpbGwgZGVsYXkgd29yayBjYWxs
cyh2aS0+cmVmaWxsLCB2aS0+cmVmaWxsX2VuYWJsZWQpIGFyZSBiYXNlZAo+PiBvbiB0aGF0IHRo
ZSB2aXJ0aW8gaW50ZXJmYWNlIGlzIHN1Y2Nlc3NmdWxseSBvcGVuZWQsIHN1Y2ggYXMKPj4gdmly
dG5ldF9yZWNlaXZlLCB2aXJ0bmV0X3J4X3Jlc2l6ZSwgX3ZpcnRuZXRfc2V0X3F1ZXVlcywgZXRj
LiBJZiB0aGVyZQo+PiBpcyBhbiBlcnJvciBpbiB0aGUgeGRwIHJlZyBoZXJlLCBpdCB3aWxsIG5v
dCB0cmlnZ2VyIHRoZXNlIHN1YnNlcXVlbnQKPj4gZnVuY3Rpb25zLiBUaGVyZSBpcyBubyBuZWVk
IHRvIGNhbGwgZGlzYWJsZV9kZWxheWVkX3JlZmlsbCgpIGFuZAo+PiBjYW5jZWxfZGVsYXllZF93
b3JrX3N5bmMoKS4KPiBNYXliZSBzb21ldGhpbmcgaXMgd3JvbmcuIEkgdGhpbmsgdGhlc2UgbGlu
ZXMgbWF5IGNhbGwgZGVsYXkgd29yay4KPgo+IHN0YXRpYyBpbnQgdmlydG5ldF9vcGVuKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYpCj4gewo+IAlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRl
dl9wcml2KGRldik7Cj4gCWludCBpLCBlcnI7Cj4KPiAJZW5hYmxlX2RlbGF5ZWRfcmVmaWxsKHZp
KTsKPgo+IAlmb3IgKGkgPSAwOyBpIDwgdmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4gCQlp
ZiAoaSA8IHZpLT5jdXJyX3F1ZXVlX3BhaXJzKQo+IAkJCS8qIE1ha2Ugc3VyZSB3ZSBoYXZlIHNv
bWUgYnVmZmVyczogaWYgb29tIHVzZSB3cS4gKi8KPiAtLT4JCQlpZiAoIXRyeV9maWxsX3JlY3Yo
dmksICZ2aS0+cnFbaV0sIEdGUF9LRVJORUwpKQo+IC0tPgkJCQlzY2hlZHVsZV9kZWxheWVkX3dv
cmsoJnZpLT5yZWZpbGwsIDApOwo+Cj4gCQllcnIgPSB4ZHBfcnhxX2luZm9fcmVnKCZ2aS0+cnFb
aV0ueGRwX3J4cSwgZGV2LCBpLCB2aS0+cnFbaV0ubmFwaS5uYXBpX2lkKTsKPiAJCWlmIChlcnIg
PCAwKQo+IAkJCXJldHVybiBlcnI7Cj4KPiAJCWVyciA9IHhkcF9yeHFfaW5mb19yZWdfbWVtX21v
ZGVsKCZ2aS0+cnFbaV0ueGRwX3J4cSwKPiAJCQkJCQkgTUVNX1RZUEVfUEFHRV9TSEFSRUQsIE5V
TEwpOwo+IAkJaWYgKGVyciA8IDApIHsKPiAJCQl4ZHBfcnhxX2luZm9fdW5yZWcoJnZpLT5ycVtp
XS54ZHBfcnhxKTsKPiAJCQlyZXR1cm4gZXJyOwo+IAkJfQo+Cj4gCQl2aXJ0bmV0X25hcGlfZW5h
YmxlKHZpLT5ycVtpXS52cSwgJnZpLT5ycVtpXS5uYXBpKTsKPiAJCXZpcnRuZXRfbmFwaV90eF9l
bmFibGUodmksIHZpLT5zcVtpXS52cSwgJnZpLT5zcVtpXS5uYXBpKTsKPiAJfQo+Cj4gCXJldHVy
biAwOwo+IH0KPgo+Cj4gQW5kIEkgdGhpbmssIGlmIHdlIHZpcnRuZXRfb3BlbigpIHJldHVybiBl
cnJvciwgdGhlbiB0aGUgc3RhdHVzIG9mIHZpcnRuZXQKPiBzaG91bGQgbGlrZSB0aGUgc3RhdHVz
IGFmdGVyIHZpcnRuZXRfY2xvc2UoKS4KPgo+IE9yIHNvbWVvbmUgaGFzIG90aGVyIG9waW5pb24u
CgoKSSBhZ3JlZSwgd2UgbmVlZCB0byBkaXNhYmxlIGFuZCBzeW5jIHdpdGggdGhlIHJlZmlsbCB3
b3JrLgoKVGhhbmtzCgoKPgo+IFRoYW5rcy4KPgo+PiBUaGUgbG9naWMgaGVyZSBpcyBkaWZmZXJl
bnQgZnJvbSB0aGF0IG9mCj4+IHZpcnRuZXRfY2xvc2UuIHZpcnRuZXRfY2xvc2UgaXMgYmFzZWQg
b24gdGhlIHN1Y2Nlc3Mgb2YgdmlydG5ldF9vcGVuIGFuZAo+PiB0aGUgdHggYW5kIHJ4IGhhcyBi
ZWVuIGNhcnJpZWQgb3V0IG5vcm1hbGx5LiBGb3IgZXJyb3IgdW53aW5kaW5nLCBvbmx5Cj4+IGRp
c2FibGUgcXAgaXMgbmVlZGVkLiBBbHNvIGVuY2FwdXNsYXRlZCBhIGhlbHBlciBmdW5jdGlvbiBv
ZiBkaXNhYmxlIHFwLAo+PiB3aGljaCBpcyB1c2VkIGluZyBlcnJvciB1bndpbmRpbmcgYW5kIHZp
cnRuZXQgY2xvc2UKPj4gMi4gVGhlIGN1cnJlbnQgZXJyb3IgcXAsIHdoaWNoIGhhcyBub3QgZW5h
YmxlZCBOQVBJLCBjYW4gb25seSBjYWxsIHhkcAo+PiB1bnJlZywgYW5kIGNhbm5vdCBjYWxsIHRo
ZSBpbnRlcmZhY2Ugb2YgZGlzYWJsZSBOQVBJLCBvdGhlcndpc2UgdGhlCj4+IGtlcm5lbCB3aWxs
IGJlIHN0dWNrLiBTbyBmb3IgaS0tIHRoZSByZWFzb24gZm9yIGNhbGxpbmcgZGlzYWJsZSBxcCBv
bgo+PiB0aGUgcHJldmlvdXMgcXVldWUKPj4KPj4gVGhhbmtzCj4+Cj4+Pj4+PiArCj4+Pj4+PiAr
ICAgICByZXR1cm4gZXJyOwo+Pj4+Pj4gICAgIH0KPj4+Pj4+Cj4+Pj4+PiAgICAgc3RhdGljIGlu
dCB2aXJ0bmV0X3BvbGxfdHgoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0KQo+
Pj4+Pj4gQEAgLTIzMDUsMTEgKzIzMTgsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfY2xvc2Uoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldikKPj4+Pj4+ICAgICAgICAgIC8qIE1ha2Ugc3VyZSByZWZpbGxf
d29yayBkb2Vzbid0IHJlLWVuYWJsZSBuYXBpISAqLwo+Pj4+Pj4gICAgICAgICAgY2FuY2VsX2Rl
bGF5ZWRfd29ya19zeW5jKCZ2aS0+cmVmaWxsKTsKPj4+Pj4+Cj4+Pj4+PiAtICAgICBmb3IgKGkg
PSAwOyBpIDwgdmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4+Pj4+PiAtICAgICAgICAgICAg
IHZpcnRuZXRfbmFwaV90eF9kaXNhYmxlKCZ2aS0+c3FbaV0ubmFwaSk7Cj4+Pj4+PiAtICAgICAg
ICAgICAgIG5hcGlfZGlzYWJsZSgmdmktPnJxW2ldLm5hcGkpOwo+Pj4+Pj4gLSAgICAgICAgICAg
ICB4ZHBfcnhxX2luZm9fdW5yZWcoJnZpLT5ycVtpXS54ZHBfcnhxKTsKPj4+Pj4+IC0gICAgIH0K
Pj4+Pj4+ICsgICAgIGZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspCj4+
Pj4+PiArICAgICAgICAgICAgIHZpcnRuZXRfZGlzYWJsZV9xcCh2aSwgaSk7Cj4+Pj4+Pgo+Pj4+
Pj4gICAgICAgICAgcmV0dXJuIDA7Cj4+Pj4+PiAgICAgfQo+Pj4+Pj4gLS0KPj4+Pj4+IDIuMzcu
MSAoQXBwbGUgR2l0LTEzNy4xKQo+Pj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
