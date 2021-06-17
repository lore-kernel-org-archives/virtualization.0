Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07FEC2B9F4
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 06:01:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BACF61075
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 06:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BACF61075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54C596076B;
	Thu, 17 Jun 2021 06:01:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QgB84MXLKd_B; Thu, 17 Jun 2021 06:01:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E06DF60765;
	Thu, 17 Jun 2021 06:01:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EEB7C000D;
	Thu, 17 Jun 2021 06:01:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 252FFC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F192B6076B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:00:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s9Dcwq8eiI4h
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:00:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB2DE60765
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623909657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5Nns6EKPwDlVeXRTH4tRpggC3e49X2WwCh4ckH6I4Y=;
 b=DHxsMCLuaZ9T6u5wEVYImMBF7FC8vdPTigaSUnxJQ7zU43uNLCwrpb4Y9KVeLIbivY6hzc
 4ghXpzD9cnJQ4o1YfVNNEV6PcZJIDirZ42z2DaTqXIaOKipVc/h/rpL+vJIG+efpHdcXR2
 Jft9zYhfBpsKWXti4zqvstpI0D44H5c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-JrEtuZlEObyw3QIPK1MZ9w-1; Thu, 17 Jun 2021 02:00:55 -0400
X-MC-Unique: JrEtuZlEObyw3QIPK1MZ9w-1
Received: by mail-pj1-f70.google.com with SMTP id
 15-20020a17090a0f0fb029016ad0f32fd0so2987844pjy.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 23:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=R5Nns6EKPwDlVeXRTH4tRpggC3e49X2WwCh4ckH6I4Y=;
 b=cYPTXsBd6r7r64u+1i/J02jPZhMSpOlE6l4MfjzM0TaqXJ7AZ0daavx5bHKhefAlx+
 BSg2aCyAOkYvTLEZjo22u9GoGcrPpj9jLI1Xj0y5Eo+XJZD11O9fNJW2EgO2I7buWH5F
 wSIrObmB1X/nflXfKDWzPgDUSykB3J8cXF0Jp5xg48YFoquXH6iBa5JWJOBQUE2xB5yq
 uwVRt7KtH5wJkKEid6bGJhQFBs3103DUjKjrxH1JSpAee6qCoBkuhm8V3ce3JQsYTqL0
 5MVMrvNlKEXP+m7ZQEwcqD/BMJBbIUyd5EAi1VBfxLafv/ViqYRoyznw9YENjYLbei41
 ZVlQ==
X-Gm-Message-State: AOAM530IAOqk8RoqGFVJ2A0MxrjeKmGnOPTklAtmvdJX+p3WCKBD6n3g
 xubZdP84MYfNzjfx96vqFWierEeL8OrcZwgaafFRDPhg82uBjM6kYMq1GI3PwyIRGbk+bCYXzsL
 PQ4dy1pH3roY9UN38UV/IVemttgYEBiT8u14N5j8jpw==
X-Received: by 2002:a17:902:44:b029:ee:9107:4242 with SMTP id
 62-20020a1709020044b02900ee91074242mr3076022pla.18.1623909654717; 
 Wed, 16 Jun 2021 23:00:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuQhJpZT/LZ/ASFsb1M1/+EAX4mrMb6hbKka5HX50c/zkTQLGy9dTYYEIyKzRhR0E3/G1avw==
X-Received: by 2002:a17:902:44:b029:ee:9107:4242 with SMTP id
 62-20020a1709020044b02900ee91074242mr3075997pla.18.1623909654430; 
 Wed, 16 Jun 2021 23:00:54 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x2sm3881306pfp.155.2021.06.16.23.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 23:00:53 -0700 (PDT)
Subject: Re: [PATCH net-next v5 15/15] virtio-net: xsk zero copy xmit kick by
 threshold
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1623909417.6591244-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3a7142e0-e4d7-e6c3-a7c0-02df891f42a5@redhat.com>
Date: Thu, 17 Jun 2021 14:00:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623909417.6591244-3-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust.li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

CuWcqCAyMDIxLzYvMTcg5LiL5Y2IMTo1NiwgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBUaHUsIDE3
IEp1biAyMDIxIDExOjA4OjM0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4g5ZyoIDIwMjEvNi8xMCDkuIvljYg0OjIyLCBYdWFuIFpodW8g5YaZ6YGTOgo+
Pj4gQWZ0ZXIgdGVzdGluZywgdGhlIHBlcmZvcm1hbmNlIG9mIGNhbGxpbmcga2ljayBldmVyeSB0
aW1lIGlzIG5vdCBzdGFibGUuCj4+PiBBbmQgaWYgYWxsIHRoZSBwYWNrZXRzIGFyZSBzZW50IGFu
ZCBraWNrZWQgYWdhaW4sIHRoZSBwZXJmb3JtYW5jZSBpcyBub3QKPj4+IGdvb2QuIFNvIGFkZCBh
IG1vZHVsZSBwYXJhbWV0ZXIgdG8gc3BlY2lmeSBob3cgbWFueSBwYWNrZXRzIGFyZSBzZW50IHRv
Cj4+PiBjYWxsIGEga2ljay4KPj4+Cj4+PiA4IGlzIGEgcmVsYXRpdmVseSBzdGFibGUgdmFsdWUg
d2l0aCB0aGUgYmVzdCBwZXJmb3JtYW5jZS4KPj4+Cj4+PiBIZXJlIGlzIHRoZSBwcHMgb2YgdGhl
IHRlc3Qgb2YgeHNrX2tpY2tfdGhyIHVuZGVyIGRpZmZlcmVudCB2YWx1ZXMgKGZyb20KPj4+IDEg
dG8gNjQpLgo+Pj4KPj4+IHRociAgUFBTICAgICAgICAgICAgIHRociBQUFMgICAgICAgICAgICAg
dGhyIFBQUwo+Pj4gMSAgICAyOTI0MTE2Ljc0MjQ3IHwgMjMgIDM2ODMyNjMuMDQzNDggfCA0NSAg
Mjc3NzkwNy4yMjk2Mwo+Pj4gMiAgICAzNDQxMDEwLjU3MTkxIHwgMjQgIDMwNzg4ODAuMTMwNDMg
fCA0NiAgMjc4MTM3Ni4yMTczOQo+Pj4gMyAgICAzNjM2NzI4LjcyMzc4IHwgMjUgIDI4NTkyMTku
NTc2NTYgfCA0NyAgMjc3NzI3MS45MTMwNAo+Pj4gNCAgICAzNjM3NTE4LjYxNDY4IHwgMjYgIDI4
NTE1NTcuOTU5MyAgfCA0OCAgMjgwMDMyMC41NjU3NQo+Pj4gNSAgICAzNjUxNzM4LjE2MjUxIHwg
MjcgIDI4MzQ3ODMuNTQ0MDggfCA0OSAgMjgxMzAzOS44NzU5OQo+Pj4gNiAgICAzNjUyMTc2LjY5
MjMxIHwgMjggIDI4NDcwMTIuNDE0NzIgfCA1MCAgMzQ0NTE0My4wMTgzOQo+Pj4gNyAgICAzNjY1
NDE1LjgwNjAyIHwgMjkgIDI4NjA2MzMuOTEzMDQgfCA1MSAgMzY2NjkxOC4wMTI4MQo+Pj4gOCAg
ICAzNjY1MDQ1LjE2NTU1IHwgMzAgIDI4NTc5MDMuNTc4NiAgfCA1MiAgMzA1OTkyOS4yNzA5Cj4+
Cj4+IEkgd29uZGVyIHdoYXQncyB0aGUgbnVtYmVyIGZvciB0aGUgY2FzZSBvZiBub24gemMgeHNr
Pwo+Cj4gVGhlc2UgZGF0YSBhcmUgdXNlZCB0byBjb21wYXJlIHRoZSBzaXR1YXRpb24gb2Ygc2Vu
ZGluZyBkaWZmZXJlbnQgbnVtYmVycyBvZgo+IHBhY2tldHMgdG8gdmlydGlvIGF0IG9uZSB0aW1l
LiBJIHRoaW5rIGl0IGhhcyBub3RoaW5nIHRvIGRvIHdpdGggbm9uLXplcm9jb3B5Cj4geHNrLgoK
ClllcywgYnV0IGl0IHdvdWxkIGJlIGhlbHBmdWwgdG8gc2VlIGhvdyBtdWNoIHdlIGNhbiBnYWlu
IGZyb20gemVyb2NvcHkuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLgo+Cj4+IFRoYW5rcwo+Pgo+Pgo+
Pj4gOSAgICAzNjcxMDIzLjI0MDEgIHwgMzEgIDI4MzU1ODkuOTg5NjMgfCA1MyAgMjgzMTUxNS4y
MTczOQo+Pj4gMTAgICAzNjY5NTMyLjIzMjc0IHwgMzIgIDI4NjI4MjcuODg3MDYgfCA1NCAgMzQ1
MTgwNC4wNzIwNAo+Pj4gMTEgICAzNjY2MTYwLjM3NzQ5IHwgMzMgIDI4NzE4NTUuOTY2OTYgfCA1
NSAgMzY1NDk3NS45MjM4NQo+Pj4gMTIgICAzNjc0OTUxLjQ0ODEzIHwgMzQgIDM0MzQ0NTYuNDQ4
MTYgfCA1NiAgMzY3NjE5OC4zMTg4Cj4+PiAxMyAgIDM2Njc0NDcuNTczMzEgfCAzNSAgMzY1Njkx
OC41NDE3NyB8IDU3ICAzNjg0NzQwLjg1NjE5Cj4+PiAxNCAgIDMwMTg4NDYuMDUwMyAgfCAzNiAg
MzU5NjkyMS4xNjcyMiB8IDU4ICAzMDYwOTU4Ljg1OTQKPj4+IDE1ICAgMjc5Mjc3My44NDUwNSB8
IDM3ICAzNjAzNDYwLjYzOTAzIHwgNTkgIDI4Mjg4NzQuNTcxOTEKPj4+IDE2ICAgMzQzMDU5Ni4z
NjAyICB8IDM4ICAzNTk1NDEwLjg3NjY2IHwgNjAgIDM0NTk5MjYuMTEwMjcKPj4+IDE3ICAgMzY2
MDUyNS44NTgwNiB8IDM5ICAzNjA0MjUwLjE3ODE5IHwgNjEgIDM2ODU0NDQuNDc1OTkKPj4+IDE4
ICAgMzA0NTYyNy42OTA1NCB8IDQwICAzNTk2NTQyLjI4NDI4IHwgNjIgIDMwNDk5NTkuMDgwOQo+
Pj4gMTkgICAyODQxNTQyLjk0MTc3IHwgNDEgIDM2MDA3MDUuMTYwNTQgfCA2MyAgMjgwNjI4MC4w
NDAxMwo+Pj4gMjAgICAyODMwNDc1Ljk3MzQ4IHwgNDIgIDMwMTk4MzMuNzExOTEgfCA2NCAgMzQ0
ODQ5NC4zOTEzCj4+PiAyMSAgIDI4NDU2NTUuNTU3ODkgfCA0MyAgMjc1Mjk1MS45MzI2NCB8Cj4+
PiAyMiAgIDM0NTAzODkuODQzNjUgfCA0NCAgMjc1MzEwNy4yNzE2NCB8Cj4+Pgo+Pj4gSXQgY2Fu
IGJlIGZvdW5kIHRoYXQgd2hlbiB0aGUgdmFsdWUgb2YgeHNrX2tpY2tfdGhyIGlzIHJlbGF0aXZl
bHkgc21hbGwsCj4+PiB0aGUgcGVyZm9ybWFuY2UgaXMgbm90IGdvb2QsIGFuZCB3aGVuIGl0cyB2
YWx1ZSBpcyBncmVhdGVyIHRoYW4gMTMsIHRoZQo+Pj4gcGVyZm9ybWFuY2Ugd2lsbCBiZSBtb3Jl
IGlycmVndWxhciBhbmQgdW5zdGFibGUuIEl0IGxvb2tzIHNpbWlsYXIgZnJvbSAzCj4+PiB0byAx
MywgSSBjaG9zZSA4IGFzIHRoZSBkZWZhdWx0IHZhbHVlLgo+Pj4KPj4+IFRoZSB0ZXN0IGVudmly
b25tZW50IGlzIHFlbXUgKyB2aG9zdC1uZXQuIEkgbW9kaWZpZWQgdmhvc3QtbmV0IHRvIGRyb3AK
Pj4+IHRoZSBwYWNrZXRzIHNlbnQgYnkgdm0gZGlyZWN0bHksIHNvIHRoYXQgdGhlIGNwdSBvZiB2
bSBjYW4gcnVuIGhpZ2hlci4KPj4+IEJ5IGRlZmF1bHQsIHRoZSBwcm9jZXNzZXMgaW4gdGhlIHZt
IGFuZCB0aGUgY3B1IG9mIHNvZnRpcnFkIGFyZSB0b28gbG93LAo+Pj4gYW5kIHRoZXJlIGlzIG5v
IG9idmlvdXMgZGlmZmVyZW5jZSBpbiB0aGUgdGVzdCBkYXRhLgo+Pj4KPj4+IER1cmluZyB0aGUg
dGVzdCwgdGhlIGNwdSBvZiBzb2Z0aXJxIHJlYWNoZWQgMTAwJS4gRWFjaCB4c2tfa2lja190aHIg
d2FzCj4+PiBydW4gZm9yIDMwMHMsIHRoZSBwcHMgb2YgZXZlcnkgc2Vjb25kIHdhcyByZWNvcmRl
ZCwgYW5kIHRoZSBhdmVyYWdlIG9mCj4+PiB0aGUgcHBzIHdhcyBmaW5hbGx5IHRha2VuLiBUaGUg
dmhvc3QgcHJvY2VzcyBjcHUgb24gdGhlIGhvc3QgaGFzIGFsc28KPj4+IHJlYWNoZWQgMTAwJS4K
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPgo+Pj4gUmV2aWV3ZWQtYnk6IER1c3QgTGkgPGR1c3QubGlAbGludXguYWxpYmFiYS5jb20+
Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9fbmV0LmMgfCAgMSArCj4+
PiAgICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgICAgICAgIHwgMTggKysrKysrKysrKysrKysr
Ky0tCj4+PiAgICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmggICAgICAgIHwgIDIgKysKPj4+ICAg
IDMgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Cj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMv
bmV0L3ZpcnRpby92aXJ0aW9fbmV0LmMKPj4+IGluZGV4IDk1MDMxMzNlNzFmMC4uZGZlNTA5OTM5
YjQ1IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuYwo+Pj4g
KysrIGIvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuYwo+Pj4gQEAgLTE0LDYgKzE0LDcg
QEAgc3RhdGljIGJvb2wgY3N1bSA9IHRydWUsIGdzbyA9IHRydWUsIG5hcGlfdHggPSB0cnVlOwo+
Pj4gICAgbW9kdWxlX3BhcmFtKGNzdW0sIGJvb2wsIDA0NDQpOwo+Pj4gICAgbW9kdWxlX3BhcmFt
KGdzbywgYm9vbCwgMDQ0NCk7Cj4+PiAgICBtb2R1bGVfcGFyYW0obmFwaV90eCwgYm9vbCwgMDY0
NCk7Cj4+PiArbW9kdWxlX3BhcmFtKHhza19raWNrX3RociwgaW50LCAwNjQ0KTsKPj4+Cj4+PiAg
ICAvKiBGSVhNRTogTVRVIGluIGNvbmZpZy4gKi8KPj4+ICAgICNkZWZpbmUgR09PRF9QQUNLRVRf
TEVOIChFVEhfSExFTiArIFZMQU5fSExFTiArIEVUSF9EQVRBX0xFTikKPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgYi9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMKPj4+
IGluZGV4IDM5NzNjODJkMWFkMi4uMmYzYmE2YWI0Nzk4IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy9uZXQvdmlydGlvL3hzay5jCj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMKPj4+
IEBAIC01LDYgKzUsOCBAQAo+Pj4KPj4+ICAgICNpbmNsdWRlICJ2aXJ0aW9fbmV0LmgiCj4+Pgo+
Pj4gK2ludCB4c2tfa2lja190aHIgPSA4Owo+Pj4gKwo+Pj4gICAgc3RhdGljIHN0cnVjdCB2aXJ0
aW9fbmV0X2hkcl9tcmdfcnhidWYgeHNrX2hkcjsKPj4+Cj4+PiAgICBzdGF0aWMgc3RydWN0IHZp
cnRuZXRfeHNrX2N0eCAqdmlydG5ldF94c2tfY3R4X2dldChzdHJ1Y3QgdmlydG5ldF94c2tfY3R4
X2hlYWQgKmhlYWQpCj4+PiBAQCAtNDU1LDYgKzQ1Nyw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94
c2tfeG1pdF9iYXRjaChzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsCj4+PiAgICAJc3RydWN0IHhkcF9k
ZXNjIGRlc2M7Cj4+PiAgICAJaW50IGVyciwgcGFja2V0ID0gMDsKPj4+ICAgIAlpbnQgcmV0ID0g
LUVBR0FJTjsKPj4+ICsJaW50IG5lZWRfa2ljayA9IDA7Cj4+Pgo+Pj4gICAgCXdoaWxlIChidWRn
ZXQtLSA+IDApIHsKPj4+ICAgIAkJaWYgKHNxLT52cS0+bnVtX2ZyZWUgPCAyICsgTUFYX1NLQl9G
UkFHUykgewo+Pj4gQEAgLTQ3NSwxMSArNDc4LDIyIEBAIHN0YXRpYyBpbnQgdmlydG5ldF94c2tf
eG1pdF9iYXRjaChzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsCj4+PiAgICAJCX0KPj4+Cj4+PiAgICAJ
CSsrcGFja2V0Owo+Pj4gKwkJKytuZWVkX2tpY2s7Cj4+PiArCQlpZiAobmVlZF9raWNrID4geHNr
X2tpY2tfdGhyKSB7Cj4+PiArCQkJaWYgKHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUoc3EtPnZxKSAm
Jgo+Pj4gKwkJCSAgICB2aXJ0cXVldWVfbm90aWZ5KHNxLT52cSkpCj4+PiArCQkJCSsrc3RhdHMt
PmtpY2tzOwo+Pj4gKwo+Pj4gKwkJCW5lZWRfa2ljayA9IDA7Cj4+PiArCQl9Cj4+PiAgICAJfQo+
Pj4KPj4+ICAgIAlpZiAocGFja2V0KSB7Cj4+PiAtCQlpZiAodmlydHF1ZXVlX2tpY2tfcHJlcGFy
ZShzcS0+dnEpICYmIHZpcnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkKPj4+IC0JCQkrK3N0YXRzLT5r
aWNrczsKPj4+ICsJCWlmIChuZWVkX2tpY2spIHsKPj4+ICsJCQlpZiAodmlydHF1ZXVlX2tpY2tf
cHJlcGFyZShzcS0+dnEpICYmCj4+PiArCQkJICAgIHZpcnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkK
Pj4+ICsJCQkJKytzdGF0cy0+a2lja3M7Cj4+PiArCQl9Cj4+Pgo+Pj4gICAgCQkqZG9uZSArPSBw
YWNrZXQ7Cj4+PiAgICAJCXN0YXRzLT54ZHBfdHggKz0gcGFja2V0Owo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3ZpcnRpby94c2suaCBiL2RyaXZlcnMvbmV0L3ZpcnRpby94c2suaAo+Pj4g
aW5kZXggZmUyMmNmNzhkNTA1Li40ZjBmNGY5Y2YyM2IgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L25ldC92aXJ0aW8veHNrLmgKPj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpby94c2suaAo+Pj4g
QEAgLTcsNiArNyw4IEBACj4+Pgo+Pj4gICAgI2RlZmluZSBWSVJUTkVUX1hTS19CVUZGX0NUWCAg
KCh2b2lkICopKHVuc2lnbmVkIGxvbmcpfjBMKQo+Pj4KPj4+ICtleHRlcm4gaW50IHhza19raWNr
X3RocjsKPj4+ICsKPj4+ICAgIC8qIFdoZW4geHNrIGRpc2FibGUsIHVuZGVyIG5vcm1hbCBjaXJj
dW1zdGFuY2VzLCB0aGUgbmV0d29yayBjYXJkIG11c3QgcmVjbGFpbQo+Pj4gICAgICogYWxsIHRo
ZSBtZW1vcnkgdGhhdCBoYXMgYmVlbiBzZW50IGFuZCB0aGUgbWVtb3J5IGFkZGVkIHRvIHRoZSBy
cSBxdWV1ZSBieQo+Pj4gICAgICogZGVzdHJveWluZyB0aGUgcXVldWUuCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
