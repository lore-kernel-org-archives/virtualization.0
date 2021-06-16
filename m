Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD82C48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 07:34:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74F260FEA
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 07:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74F260FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8646C403B1;
	Wed, 16 Jun 2021 07:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mi2TXrr7DIyC; Wed, 16 Jun 2021 07:34:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F13E5402F4;
	Wed, 16 Jun 2021 07:34:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAC7DC000D;
	Wed, 16 Jun 2021 07:34:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AA30C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 07:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55851606AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 07:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QSfa7aVZImKW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 07:34:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77C7660624
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623828862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNd5rq7O+X7v4DbfCG2yqBupZLQdBei7SCAcvGOKyO8=;
 b=hS/gdS/KhDBLLPutQRtO6dPrTtAshzTQLS3aZIWuAc2+bEmvp4wAqk7cwWGo+6Er6RC+hi
 i8b7Z6Rv/q8Lln1ZjTjxXiI6pZZO/JXUSm1aaCPLjqieOb9XA9hVLWCGQ+RzqTb+qgnFJw
 23HR5LDOdUlUvjqafWAtsOu4IKs06pw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-rN74tYfTOlKfGXl9L-ek_g-1; Wed, 16 Jun 2021 03:34:18 -0400
X-MC-Unique: rN74tYfTOlKfGXl9L-ek_g-1
Received: by mail-pj1-f72.google.com with SMTP id
 b9-20020a17090aa589b029016e99e81994so3545456pjq.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 00:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=VNd5rq7O+X7v4DbfCG2yqBupZLQdBei7SCAcvGOKyO8=;
 b=jqAFQQAfTMicXNa8WdsucGSJM8ozeHK+vHVd8oQcFo/NReOprF1jYvMNr3u8lq07EP
 lTSstZvkJKcT7tKMMvGdPAs/XvbMToaSd157hv4weo7TxkhkM7jxMxqOn6IwvCCghM67
 hlLmJfYNA4vm8phsZAIhxkkc4rBQlotj2pv5ShgyEXgRjKcNZPrTds1KXKmy32HK1hA7
 ALy3OnbZP8XB3s6PAcRuC/uWq8bA9ulVP2gFD4S28B7HDE4e5lNNqlX+iFDz+IH4wapu
 HHESK63wvKNxgT3Pa+yvaPzRA7RMW1UKkFQ5k4akxXogtFV9vkFC2isr33mPhQfUY0yt
 9Y8g==
X-Gm-Message-State: AOAM531jdo+tnkSM/DJVWyNyYsMB8ct/RGsTUcThjuyRH4YFwdsdKlKS
 wUzkv+KD92PFI9sDQqgxYan5M8cCFsSYev2upQZpIaZG7n1g+F7zehZHf9I3KJDrqoJJZc/lT/N
 BMgLv4TO4YDAdV6ava5mNWIVj58hNwq9rQvoMV0X1tw==
X-Received: by 2002:a63:31c2:: with SMTP id x185mr3680275pgx.97.1623828857767; 
 Wed, 16 Jun 2021 00:34:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpWj9mu7EPVo9Xizh8HgAiHa9lTv3v0OYAjKCalyAeUEevOz3ooK6fJp6k/Gioc3mz2dTXug==
X-Received: by 2002:a63:31c2:: with SMTP id x185mr3680240pgx.97.1623828857481; 
 Wed, 16 Jun 2021 00:34:17 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g6sm1277967pfq.110.2021.06.16.00.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 00:34:16 -0700 (PDT)
Subject: Re: [PATCH net-next v5 10/15] virtio-net: independent directory
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
 <20210610082209.91487-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e43d40ab-7a5a-c6f7-979b-95a379bba170@redhat.com>
Date: Wed, 16 Jun 2021 15:34:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610082209.91487-11-xuanzhuo@linux.alibaba.com>
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
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8xMCDPws7nNDoyMiwgWHVhbiBaaHVvINC0tcA6Cj4gQ3JlYXRlIGEgc2VwYXJh
dGUgZGlyZWN0b3J5IGZvciB2aXJ0aW8tbmV0LiBBRl9YRFAgc3VwcG9ydCB3aWxsIGJlIGFkZGVk
Cj4gbGF0ZXIsIGFuZCBhIHNlcGFyYXRlIHhzay5jIGZpbGUgd2lsbCBiZSBhZGRlZC4KPgo+IFNp
Z25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNr
ZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIE1BSU5U
QUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICAgZHJpdmVycy9uZXQv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICA4ICstLS0tLS0tCj4gICBkcml2ZXJzL25ldC9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpby9L
Y29uZmlnICAgICAgICAgICAgfCAxMSArKysrKysrKysrKwo+ICAgZHJpdmVycy9uZXQvdmlydGlv
L01ha2VmaWxlICAgICAgICAgICB8ICA2ICsrKysrKwo+ICAgZHJpdmVycy9uZXQveyA9PiB2aXJ0
aW99L3ZpcnRpb19uZXQuYyB8ICAwCj4gICA2IGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmly
dGlvL0tjb25maWcKPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vTWFr
ZWZpbGUKPiAgIHJlbmFtZSBkcml2ZXJzL25ldC97ID0+IHZpcnRpb30vdmlydGlvX25ldC5jICgx
MDAlKQo+Cj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKPiBpbmRleCBl
NjljMTk5MWVjM2IuLjIwNDEyNjdmMTlmMSAxMDA2NDQKPiAtLS0gYS9NQUlOVEFJTkVSUwo+ICsr
KyBiL01BSU5UQUlORVJTCj4gQEAgLTE5MzQ0LDcgKzE5MzQ0LDcgQEAgUzoJTWFpbnRhaW5lZAo+
ICAgRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZpcnRpby8KPiAgIEY6CWRy
aXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4gICBGOglkcml2ZXJzL2NyeXB0by92aXJ0aW8vCj4g
LUY6CWRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICtGOglkcml2ZXJzL25ldC92aXJ0aW8vCj4g
ICBGOglkcml2ZXJzL3ZkcGEvCj4gICBGOglkcml2ZXJzL3ZpcnRpby8KPiAgIEY6CWluY2x1ZGUv
bGludXgvdmRwYS5oCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L0tjb25maWcgYi9kcml2ZXJz
L25ldC9LY29uZmlnCj4gaW5kZXggNGRhNjhiYTg0NDhmLi4yMjk3ZmU0MTgzYWUgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9uZXQvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvbmV0L0tjb25maWcKPiBA
QCAtMzkyLDEzICszOTIsNyBAQCBjb25maWcgVkVUSAo+ICAgCSAgV2hlbiBvbmUgZW5kIHJlY2Vp
dmVzIHRoZSBwYWNrZXQgaXQgYXBwZWFycyBvbiBpdHMgcGFpciBhbmQgdmljZQo+ICAgCSAgdmVy
c2EuCj4gICAKPiAtY29uZmlnIFZJUlRJT19ORVQKPiAtCXRyaXN0YXRlICJWaXJ0aW8gbmV0d29y
ayBkcml2ZXIiCj4gLQlkZXBlbmRzIG9uIFZJUlRJTwo+IC0Jc2VsZWN0IE5FVF9GQUlMT1ZFUgo+
IC0JaGVscAo+IC0JICBUaGlzIGlzIHRoZSB2aXJ0dWFsIG5ldHdvcmsgZHJpdmVyIGZvciB2aXJ0
aW8uICBJdCBjYW4gYmUgdXNlZCB3aXRoCj4gLQkgIFFFTVUgYmFzZWQgVk1NcyAobGlrZSBLVk0g
b3IgWGVuKS4gIFNheSBZIG9yIE0uCj4gK3NvdXJjZSAiZHJpdmVycy9uZXQvdmlydGlvL0tjb25m
aWciCj4gICAKPiAgIGNvbmZpZyBOTE1PTgo+ICAgCXRyaXN0YXRlICJWaXJ0dWFsIG5ldGxpbmsg
bW9uaXRvcmluZyBkZXZpY2UiCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L01ha2VmaWxlIGIv
ZHJpdmVycy9uZXQvTWFrZWZpbGUKPiBpbmRleCA3ZmZkMmQwM2VmYWYuLmM0Yzc0MTllMDM5OCAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC9NYWtlZmlsZQo+ICsrKyBiL2RyaXZlcnMvbmV0L01h
a2VmaWxlCj4gQEAgLTI4LDcgKzI4LDcgQEAgb2JqLSQoQ09ORklHX05FVF9URUFNKSArPSB0ZWFt
Lwo+ICAgb2JqLSQoQ09ORklHX1RVTikgKz0gdHVuLm8KPiAgIG9iai0kKENPTkZJR19UQVApICs9
IHRhcC5vCj4gICBvYmotJChDT05GSUdfVkVUSCkgKz0gdmV0aC5vCj4gLW9iai0kKENPTkZJR19W
SVJUSU9fTkVUKSArPSB2aXJ0aW9fbmV0Lm8KPiArb2JqLSQoQ09ORklHX1ZJUlRJT19ORVQpICs9
IHZpcnRpby8KPiAgIG9iai0kKENPTkZJR19WWExBTikgKz0gdnhsYW4ubwo+ICAgb2JqLSQoQ09O
RklHX0dFTkVWRSkgKz0gZ2VuZXZlLm8KPiAgIG9iai0kKENPTkZJR19CQVJFVURQKSArPSBiYXJl
dWRwLm8KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvL0tjb25maWcgYi9kcml2ZXJz
L25ldC92aXJ0aW8vS2NvbmZpZwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAw
MDAwMDAwLi45YmMyYTJmYzZjM2UKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvZHJpdmVycy9uZXQv
dmlydGlvL0tjb25maWcKPiBAQCAtMCwwICsxLDExIEBACj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb25seQo+ICsjCj4gKyMgdmlydGlvLW5ldCBkZXZpY2UgY29uZmlndXJh
dGlvbgo+ICsjCj4gK2NvbmZpZyBWSVJUSU9fTkVUCj4gKwl0cmlzdGF0ZSAiVmlydGlvIG5ldHdv
cmsgZHJpdmVyIgo+ICsJZGVwZW5kcyBvbiBWSVJUSU8KPiArCXNlbGVjdCBORVRfRkFJTE9WRVIK
PiArCWhlbHAKPiArCSAgVGhpcyBpcyB0aGUgdmlydHVhbCBuZXR3b3JrIGRyaXZlciBmb3Igdmly
dGlvLiAgSXQgY2FuIGJlIHVzZWQgd2l0aAo+ICsJICBRRU1VIGJhc2VkIFZNTXMgKGxpa2UgS1ZN
IG9yIFhlbikuICBTYXkgWSBvciBNLgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8v
TWFrZWZpbGUgYi9kcml2ZXJzL25ldC92aXJ0aW8vTWFrZWZpbGUKPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NAo+IGluZGV4IDAwMDAwMDAwMDAwMC4uY2NjODBmNDBmMzNhCj4gLS0tIC9kZXYvbnVsbAo+
ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpby9NYWtlZmlsZQo+IEBAIC0wLDAgKzEsNiBAQAo+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCj4gKyMKPiArIyBNYWtlZmlsZSBmb3Ig
dGhlIHZpcnRpbyBuZXR3b3JrIGRldmljZSBkcml2ZXJzLgo+ICsjCj4gKwo+ICtvYmotJChDT05G
SUdfVklSVElPX05FVCkgKz0gdmlydGlvX25ldC5vCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9fbmV0LmMKPiBzaW1pbGFy
aXR5IGluZGV4IDEwMCUKPiByZW5hbWUgZnJvbSBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBy
ZW5hbWUgdG8gZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuYwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
