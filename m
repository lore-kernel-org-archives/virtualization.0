Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18477C77B7A
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 05:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA957614DA;
	Thu, 20 Apr 2023 05:59:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA957614DA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bL+TiD/5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l5b7_V-tiWbw; Thu, 20 Apr 2023 05:59:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EE1FD6165C;
	Thu, 20 Apr 2023 05:59:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE1FD6165C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1E16C007E;
	Thu, 20 Apr 2023 05:59:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42C92C008C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7B6E82077
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7B6E82077
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bL+TiD/5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nO7wtLZazSIw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11BC381F72
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 11BC381F72
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681970380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndhf9eOC/JOd/pT3ZOdTc+tSLLDWf/wxwZPQj3/gbjo=;
 b=bL+TiD/5PXnWFZOoONYlnvJsZQF2XXRiFYsYXtt3dGJXJID3kkXZLRM8YZz5HIlm7q8t1h
 XPrKuuj2lt72Cru3s0KvItujVaMUArjUWUk0Btc7rFNIO6eZyVSxoeizFuPBcrX8iD0H5k
 kIB6k8B4UJb32x1BYllpTI6FXETd30A=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-ezqRZxYPMY6lc2ByTxvYXA-1; Thu, 20 Apr 2023 01:59:38 -0400
X-MC-Unique: ezqRZxYPMY6lc2ByTxvYXA-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-187ed08e43eso94256fac.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 22:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681970378; x=1684562378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndhf9eOC/JOd/pT3ZOdTc+tSLLDWf/wxwZPQj3/gbjo=;
 b=EPKH8+zaA+swee+rSV+LxS5d/tdLMfZ99xNLGHLC5vZLQFEGMwW7Q6x41Le93io38e
 TW65cNvI+rQKAyvdI31IRR8N6CxE0Tg40d7Sxh6i00HjvMTI5+9DBYHB026ypxjC0bR4
 6b5Hm0dMRbvHy0/XSFitHPP/zkpycckQmp09ih2jV3dQeDVQUFVsGNkIa3vgDgWccrJE
 ZRCvm4nrApKEQ8nMgj0CJjTjEvOub940vBALi/ZuPuqAquHbmYQLjngRwjVklpubaar0
 ybeaAgPs1PyMAcm4OaAVnK63/gEO3guthyg5yrxxb5RtyDvUHCUmGyJoX6iCjJaPFpe1
 YA3Q==
X-Gm-Message-State: AAQBX9f6JLo6+JEYJe2MTOpVXhlX2j6sRKcZ+gavK4POKjDZasXdPQXX
 jHYwYZ3Z8/Ce+9JC+0ZR+wLHEHIXQKY+Y8QfTH2eK75ep21OW55yLKjZP+fhCVJJiDlZxHPvGfW
 /G8s02E8kk7XwOQhEsoeh0Lh5FL4SSKniKJrfMf+LmjamdM18+r/OB1LzzA==
X-Received: by 2002:a4a:4f86:0:b0:546:ecb3:f44 with SMTP id
 c128-20020a4a4f86000000b00546ecb30f44mr226273oob.0.1681970378218; 
 Wed, 19 Apr 2023 22:59:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350aje03xj8D7o4+ulKEMF2OYf7kcJ5DU7pwe6+zp6C3tuhYC9OCL7PeHFCOrUww+dg4QXgRfBp8kIJ0o5Dwzt6U=
X-Received: by 2002:a4a:4f86:0:b0:546:ecb3:f44 with SMTP id
 c128-20020a4a4f86000000b00546ecb30f44mr226258oob.0.1681970378017; Wed, 19 Apr
 2023 22:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230418065327.72281-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Apr 2023 13:59:26 +0800
Message-ID: <CACGkMEuQ0pUixB1tKd8bthhndnFvdw9NEJn6xpX-JCovmu1dxg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/14] virtio_net: introduce xdp res enums
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

T24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgMjo1M+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gdmlydG5ldF94ZHBfaGFuZGxlcigpIGlzIHRvIHBy
b2Nlc3MgYWxsIHRoZSBsb2dpYyByZWxhdGVkIHRvIFhEUC4gVGhlCj4gY2FsbGVyIG9ubHkgbmVl
ZHMgdG8gY2FyZSBhYm91dCBob3cgdG8gZGVhbCB3aXRoIHRoZSBidWYuIFNvIHRoaXMgY29tbWl0
Cj4gaW50cm9kdWNlcyBuZXcgZW51bXM6Cj4KPiAxLiBWSVJUTkVUX1hEUF9SRVNfUEFTUzogbWFr
ZSBza2IgYnkgdGhlIGJ1Zgo+IDIuIFZJUlRORVRfWERQX1JFU19EUk9QOiB4ZHAgcmV0dXJuIGRy
b3AgYWN0aW9uIG9yIHNvbWUgZXJyb3IsIGNhbGxlcgo+ICAgIHNob3VsZCByZWxlYXNlIHRoZSBi
dWYKPiAzLiBWSVJUTkVUX1hEUF9SRVNfQ09OU1VNRUQ6IHhkcCBjb25zdW1lZCB0aGUgYnVmLCB0
aGUgY2FsbGVyIGRvZXNub3QgdG8KClR5cG8sIHNob3VsZCBiZSAiZG9lcyBub3QiCgo+ICAgIGRv
IGFueXRoaW5nCj4KCkkgdGhpbmsgaXQncyBiZXR0ZXIgaWYgeW91IGNvdWxkIGV4cGxhaW4gaWYg
dGhpcyBjYW4gaGVscCBhbnl0aGluZwooZS5nIHNpbXBsaWZ5IHRoZSBwYXRjaGVzIG9uIHRvcD8p
LgoKVGhhbmtzCgoKPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPgo+IC0tLQo+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA0MiArKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBp
bnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCAwZmE2NGMz
MTRlYTcuLjRkZmRjMjExZDM1NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMzAxLDYgKzMwMSwxNSBA
QCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiAgICAgICAgIGNoYXIgcGFkZGluZ1sxMl07Cj4g
IH07Cj4KPiArZW51bSB7Cj4gKyAgICAgICAvKiB4ZHAgcGFzcyAqLwo+ICsgICAgICAgVklSVE5F
VF9YRFBfUkVTX1BBU1MsCj4gKyAgICAgICAvKiBkcm9wIHBhY2tldC4gdGhlIGNhbGxlciBuZWVk
cyB0byByZWxlYXNlIHRoZSBwYWdlLiAqLwo+ICsgICAgICAgVklSVE5FVF9YRFBfUkVTX0RST1As
Cj4gKyAgICAgICAvKiBwYWNrZXQgaXMgY29uc3VtZWQgYnkgeGRwLiB0aGUgY2FsbGVyIG5lZWRz
IHRvIGRvIG5vdGhpbmcuICovCj4gKyAgICAgICBWSVJUTkVUX1hEUF9SRVNfQ09OU1VNRUQsCj4g
K307Cj4gKwo+ICBzdGF0aWMgdm9pZCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiAgc3RhdGljIHZvaWQgdmlydG5ldF9zcV9mcmVl
X3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4KPiBAQCAtODAz
LDE0ICs4MTIsMTQgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF9oYW5kbGVyKHN0cnVjdCBicGZf
cHJvZyAqeGRwX3Byb2csIHN0cnVjdCB4ZHBfYnVmZiAqeGRwLAo+Cj4gICAgICAgICBzd2l0Y2gg
KGFjdCkgewo+ICAgICAgICAgY2FzZSBYRFBfUEFTUzoKPiAtICAgICAgICAgICAgICAgcmV0dXJu
IGFjdDsKPiArICAgICAgICAgICAgICAgcmV0dXJuIFZJUlRORVRfWERQX1JFU19QQVNTOwo+Cj4g
ICAgICAgICBjYXNlIFhEUF9UWDoKPiAgICAgICAgICAgICAgICAgc3RhdHMtPnhkcF90eCsrOwo+
ICAgICAgICAgICAgICAgICB4ZHBmID0geGRwX2NvbnZlcnRfYnVmZl90b19mcmFtZSh4ZHApOwo+
ICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoIXhkcGYpKSB7Cj4gICAgICAgICAgICAgICAg
ICAgICAgICAgbmV0ZGV2X2RiZyhkZXYsICJjb252ZXJ0IGJ1ZmYgdG8gZnJhbWUgZmFpbGVkIGZv
ciB4ZHBcbiIpOwo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBYRFBfRFJPUDsKPiAr
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gVklSVE5FVF9YRFBfUkVTX0RST1A7Cj4gICAg
ICAgICAgICAgICAgIH0KPgo+ICAgICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X3hkcF94bWl0
KGRldiwgMSwgJnhkcGYsIDApOwo+IEBAIC04MTgsMTkgKzgyNywyMCBAQCBzdGF0aWMgaW50IHZp
cnRuZXRfeGRwX2hhbmRsZXIoc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZywgc3RydWN0IHhkcF9i
dWZmICp4ZHAsCj4gICAgICAgICAgICAgICAgICAgICAgICAgeGRwX3JldHVybl9mcmFtZV9yeF9u
YXBpKHhkcGYpOwo+ICAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKHVubGlrZWx5KGVyciA8IDAp
KSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgdHJhY2VfeGRwX2V4Y2VwdGlvbihkZXYsIHhk
cF9wcm9nLCBhY3QpOwo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBYRFBfRFJPUDsK
PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gVklSVE5FVF9YRFBfUkVTX0RST1A7Cj4g
ICAgICAgICAgICAgICAgIH0KPiArCj4gICAgICAgICAgICAgICAgICp4ZHBfeG1pdCB8PSBWSVJU
SU9fWERQX1RYOwo+IC0gICAgICAgICAgICAgICByZXR1cm4gYWN0Owo+ICsgICAgICAgICAgICAg
ICByZXR1cm4gVklSVE5FVF9YRFBfUkVTX0NPTlNVTUVEOwo+Cj4gICAgICAgICBjYXNlIFhEUF9S
RURJUkVDVDoKPiAgICAgICAgICAgICAgICAgc3RhdHMtPnhkcF9yZWRpcmVjdHMrKzsKPiAgICAg
ICAgICAgICAgICAgZXJyID0geGRwX2RvX3JlZGlyZWN0KGRldiwgeGRwLCB4ZHBfcHJvZyk7Cj4g
ICAgICAgICAgICAgICAgIGlmIChlcnIpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IFhEUF9EUk9QOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBWSVJUTkVUX1hEUF9S
RVNfRFJPUDsKPgo+ICAgICAgICAgICAgICAgICAqeGRwX3htaXQgfD0gVklSVElPX1hEUF9SRURJ
UjsKPiAtICAgICAgICAgICAgICAgcmV0dXJuIGFjdDsKPiArICAgICAgICAgICAgICAgcmV0dXJu
IFZJUlRORVRfWERQX1JFU19DT05TVU1FRDsKPgo+ICAgICAgICAgZGVmYXVsdDoKPiAgICAgICAg
ICAgICAgICAgYnBmX3dhcm5faW52YWxpZF94ZHBfYWN0aW9uKGRldiwgeGRwX3Byb2csIGFjdCk7
Cj4gQEAgLTgzOSw3ICs4NDksNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX2hhbmRsZXIoc3Ry
dWN0IGJwZl9wcm9nICp4ZHBfcHJvZywgc3RydWN0IHhkcF9idWZmICp4ZHAsCj4gICAgICAgICAg
ICAgICAgIHRyYWNlX3hkcF9leGNlcHRpb24oZGV2LCB4ZHBfcHJvZywgYWN0KTsKPiAgICAgICAg
ICAgICAgICAgZmFsbHRocm91Z2g7Cj4gICAgICAgICBjYXNlIFhEUF9EUk9QOgo+IC0gICAgICAg
ICAgICAgICByZXR1cm4gWERQX0RST1A7Cj4gKyAgICAgICAgICAgICAgIHJldHVybiBWSVJUTkVU
X1hEUF9SRVNfRFJPUDsKPiAgICAgICAgIH0KPiAgfQo+Cj4gQEAgLTk4NywxNyArOTk3LDE4IEBA
IHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9zbWFsbChzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2LAo+ICAgICAgICAgICAgICAgICBhY3QgPSB2aXJ0bmV0X3hkcF9oYW5kbGVyKHhkcF9wcm9n
LCAmeGRwLCBkZXYsIHhkcF94bWl0LCBzdGF0cyk7Cj4KPiAgICAgICAgICAgICAgICAgc3dpdGNo
IChhY3QpIHsKPiAtICAgICAgICAgICAgICAgY2FzZSBYRFBfUEFTUzoKPiArICAgICAgICAgICAg
ICAgY2FzZSBWSVJUTkVUX1hEUF9SRVNfUEFTUzoKPiAgICAgICAgICAgICAgICAgICAgICAgICAv
KiBSZWNhbGN1bGF0ZSBsZW5ndGggaW4gY2FzZSBicGYgcHJvZ3JhbSBjaGFuZ2VkIGl0ICovCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgZGVsdGEgPSBvcmlnX2RhdGEgLSB4ZHAuZGF0YTsKPiAg
ICAgICAgICAgICAgICAgICAgICAgICBsZW4gPSB4ZHAuZGF0YV9lbmQgLSB4ZHAuZGF0YTsKPiAg
ICAgICAgICAgICAgICAgICAgICAgICBtZXRhc2l6ZSA9IHhkcC5kYXRhIC0geGRwLmRhdGFfbWV0
YTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAtICAgICAgICAgICAgICAgY2Fz
ZSBYRFBfVFg6Cj4gLSAgICAgICAgICAgICAgIGNhc2UgWERQX1JFRElSRUNUOgo+ICsKPiArICAg
ICAgICAgICAgICAgY2FzZSBWSVJUTkVUX1hEUF9SRVNfQ09OU1VNRUQ6Cj4gICAgICAgICAgICAg
ICAgICAgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAg
Z290byB4ZHBfeG1pdDsKPiAtICAgICAgICAgICAgICAgZGVmYXVsdDoKPiArCj4gKyAgICAgICAg
ICAgICAgIGNhc2UgVklSVE5FVF9YRFBfUkVTX0RST1A6Cj4gICAgICAgICAgICAgICAgICAgICAg
ICAgZ290byBlcnJfeGRwOwo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICB9Cj4gQEAgLTEz
MjQsMTggKzEzMzUsMTkgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJs
ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAgICAgICAgICAgICBhY3QgPSB2aXJ0bmV0
X3hkcF9oYW5kbGVyKHhkcF9wcm9nLCAmeGRwLCBkZXYsIHhkcF94bWl0LCBzdGF0cyk7Cj4KPiAg
ICAgICAgICAgICAgICAgc3dpdGNoIChhY3QpIHsKPiAtICAgICAgICAgICAgICAgY2FzZSBYRFBf
UEFTUzoKPiArICAgICAgICAgICAgICAgY2FzZSBWSVJUTkVUX1hEUF9SRVNfUEFTUzoKPiAgICAg
ICAgICAgICAgICAgICAgICAgICBoZWFkX3NrYiA9IGJ1aWxkX3NrYl9mcm9tX3hkcF9idWZmKGRl
diwgdmksICZ4ZHAsIHhkcF9mcmFnc190cnVlc3opOwo+ICAgICAgICAgICAgICAgICAgICAgICAg
IGlmICh1bmxpa2VseSghaGVhZF9za2IpKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZ290byBlcnJfeGRwX2ZyYWdzOwo+Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcmN1X3Jl
YWRfdW5sb2NrKCk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGhlYWRfc2tiOwo+
IC0gICAgICAgICAgICAgICBjYXNlIFhEUF9UWDoKPiAtICAgICAgICAgICAgICAgY2FzZSBYRFBf
UkVESVJFQ1Q6Cj4gKwo+ICsgICAgICAgICAgICAgICBjYXNlIFZJUlRORVRfWERQX1JFU19DT05T
VU1FRDoKPiAgICAgICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiAgICAg
ICAgICAgICAgICAgICAgICAgICBnb3RvIHhkcF94bWl0Owo+IC0gICAgICAgICAgICAgICBkZWZh
dWx0Ogo+ICsKPiArICAgICAgICAgICAgICAgY2FzZSBWSVJUTkVUX1hEUF9SRVNfRFJPUDoKPiAg
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgICAgICAgICAgfQo+ICBlcnJf
eGRwX2ZyYWdzOgo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
