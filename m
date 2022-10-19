Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF87AC4332F
	for <virtualization@archiver.kernel.org>; Wed, 19 Oct 2022 05:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B7F44198A;
	Wed, 19 Oct 2022 05:14:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B7F44198A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OAQdNWnt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X14yS0Q84L1i; Wed, 19 Oct 2022 05:14:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 23BC4410D5;
	Wed, 19 Oct 2022 05:14:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23BC4410D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E34CDC0032;
	Wed, 19 Oct 2022 05:14:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADCA6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73DB54025F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:14:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73DB54025F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OAQdNWnt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JKp2ouTBTl8z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:14:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7EF0F40111
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7EF0F40111
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666156467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=elWLeuJKIZ4oJu/GVv8j/7xLvrjS+NMtbQ72eCBOoSw=;
 b=OAQdNWntr4p2soM4FgyyFDLQyWknN1WVvvFzlKSlvvW1DlK+AjciXmPQKUHOczAORAjcb1
 1T8j2n4jCCZw9wYdx4XL4c23FP6aIHDUEbxpaA5oLKER3IXklObvmqv6haQIreuzYMjIOD
 rFIymAf5dZk9WI+5W9qjrzJFwqDZGaw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-171-QbfPgJOyO-Kcy8YbN_4Cow-1; Wed, 19 Oct 2022 01:14:26 -0400
X-MC-Unique: QbfPgJOyO-Kcy8YbN_4Cow-1
Received: by mail-pl1-f200.google.com with SMTP id
 f18-20020a170902ce9200b0017f9ac4cfb5so11183780plg.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 22:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=elWLeuJKIZ4oJu/GVv8j/7xLvrjS+NMtbQ72eCBOoSw=;
 b=dbC8/JwciVcoc1TcUewgALB5q3s4z+y4TArr+zeqRLeUFdiIN69NJmp+Npdo0Kj0jo
 wrCZRgIbw0lIf2sJG+b6kT9qwT2Iv/yEJGBhIpFy2ptY79D8z8N3JbyX19BZWUFp6Wl2
 rjrv/0i5ZI+m5JRhZGT1J9OJWF4P4h8YTVQW7Bk1NHiMvKYqHHdNgoTWhYYSAPdr6QV6
 cyAXQR1SFfjSk1uHCsmwBMeBoqxAfP5LTb2Hw3g3HPHYmM+ICybwpi4vK8SFmYmY5lSW
 npNWBkKkUb88bJTCQnCJlyYqTffz74adACjY1tYSmn2fyGf2Vyw0rGS3kUDvnVngqnaF
 FCMw==
X-Gm-Message-State: ACrzQf0AMw6jHdsCwp5keuqTx999+lVFRMfEDt3gQc9UBYCRO5UUbhiy
 0GnLhNTrtxCkalFNPzMpsnSXHl1LdAs09wxIxHKn7iyyWn5DhNzSfa4BTTKQhRYlwtMWzta+KyL
 Yvr99D2dPjV12hzH/dPTzoPjz6cGzSCzIaU5MagSPmg==
X-Received: by 2002:a17:903:32cd:b0:185:5421:a5d6 with SMTP id
 i13-20020a17090332cd00b001855421a5d6mr6563119plr.99.1666156464794; 
 Tue, 18 Oct 2022 22:14:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Hvcr/I9EH7SdGoInjE6Qebm/YSK0Gmhj8yliMC/8ZMVpkTInJy4XKE5CCKWujd1Hid7apSg==
X-Received: by 2002:a17:902:ce91:b0:183:610c:1df3 with SMTP id
 f17-20020a170902ce9100b00183610c1df3mr6401359plg.51.1666156453588; 
 Tue, 18 Oct 2022 22:14:13 -0700 (PDT)
Received: from [10.72.12.164] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a170902d0d300b0018658badef3sm45961pln.232.2022.10.18.22.14.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Oct 2022 22:14:12 -0700 (PDT)
Message-ID: <33449319-b984-a60b-50e2-a0080a62f1c1@redhat.com>
Date: Wed, 19 Oct 2022 13:14:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 3/4] vdpa/mlx5: Add debugfs subtree
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20221018111232.4021-1-elic@nvidia.com>
 <20221018111232.4021-4-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221018111232.4021-4-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma@redhat.com, lulu@redhat.com
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

CuWcqCAyMDIyLzEwLzE4IDE5OjEyLCBFbGkgQ29oZW4g5YaZ6YGTOgo+IEFkZCBkZWJ1Z2ZzIHN1
YnRyZWUgYW5kIGV4cG9zZSBmbG93IHRhYmxlIElEIGFuZCBUSVIgbnVtYmVyLiBUaGlzCj4gaW5m
b3JtYXRpb24gY2FuIGJlIHVzZWQgYnkgZXh0ZXJuYWwgdG9vbHMgdG8gZG8gZXh0ZW5kZWQKPiB0
cm91Ymxlc2hvb3RpbmcuCj4KPiBUaGUgaW5mb3JtYXRpb24gY2FuIGJlIHJldHJpZXZlZCBsaWtl
IHNvOgo+ICQgY2F0IC9zeXMva2VybmVsL2RlYnVnL21seDUvbWx4NV9jb3JlLnNmLjEvdmRwYS0w
L3J4L3RhYmxlX2lkCj4gJCBjYXQgL3N5cy9rZXJuZWwvZGVidWcvbWx4NS9tbHg1X2NvcmUuc2Yu
MS92ZHBhLTAvcngvdGlybgoKCkkgd29uZGVyIGlmIHdlIG5lZWQgYSBjb25maWcgb3B0aW9uIGZv
ciB0aGlzLgoKQW5kIGlmIGl0J3MgYmV0dGVyIHRvIHVzZSB2ZW5kb3Igc3RhdHMuCgpUaGFua3MK
Cgo+Cj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gLS0tCj4g
ICBkcml2ZXJzL3ZkcGEvbWx4NS9NYWtlZmlsZSAgICAgICAgfCAgMiArLQo+ICAgZHJpdmVycy92
ZHBhL21seDUvbmV0L2RlYnVnLmMgICAgIHwgNjYgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMTEgKysrKysrCj4g
ICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmggfCAgOSArKysrKwo+ICAgNCBmaWxl
cyBjaGFuZ2VkLCA4NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy92ZHBhL21seDUvbmV0L2RlYnVnLmMKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvbWx4NS9NYWtlZmlsZSBiL2RyaXZlcnMvdmRwYS9tbHg1L01ha2VmaWxlCj4g
aW5kZXggZjcxNzk3OGM4M2JmLi5lNzkxMzk0YzMzZTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
ZHBhL21seDUvTWFrZWZpbGUKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9NYWtlZmlsZQo+IEBA
IC0xLDQgKzEsNCBAQAo+ICAgc3ViZGlyLWNjZmxhZ3MteSArPSAtSSQoc3JjdHJlZSkvZHJpdmVy
cy92ZHBhL21seDUvY29yZQo+ICAgCj4gICBvYmotJChDT05GSUdfTUxYNV9WRFBBX05FVCkgKz0g
bWx4NV92ZHBhLm8KPiAtbWx4NV92ZHBhLSQoQ09ORklHX01MWDVfVkRQQV9ORVQpICs9IG5ldC9t
bHg1X3ZuZXQubyBjb3JlL3Jlc291cmNlcy5vIGNvcmUvbXIubwo+ICttbHg1X3ZkcGEtJChDT05G
SUdfTUxYNV9WRFBBX05FVCkgKz0gbmV0L21seDVfdm5ldC5vIGNvcmUvcmVzb3VyY2VzLm8gY29y
ZS9tci5vIG5ldC9kZWJ1Zy5vCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9k
ZWJ1Zy5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L2RlYnVnLmMKPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NAo+IGluZGV4IDAwMDAwMDAwMDAwMC4uOTVlNDgwMWRmMjExCj4gLS0tIC9kZXYvbnVsbAo+
ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9kZWJ1Zy5jCj4gQEAgLTAsMCArMSw2NiBAQAo+
ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBMaW51eC1PcGVuSUIKPiAr
LyogQ29weXJpZ2h0IChjKSAyMDIyLCBOVklESUEgQ09SUE9SQVRJT04gJiBBRkZJTElBVEVTLiBB
bGwgcmlnaHRzIHJlc2VydmVkLiAqLwo+ICsKPiArI2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4K
PiArI2luY2x1ZGUgPGxpbnV4L21seDUvZnMuaD4KPiArI2luY2x1ZGUgIm1seDVfdm5ldC5oIgo+
ICsKPiArc3RhdGljIGludCB0aXJuX3Nob3coc3RydWN0IHNlcV9maWxlICpmaWxlLCB2b2lkICpw
cml2KQo+ICt7Cj4gKwlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IGZpbGUtPnByaXZhdGU7
Cj4gKwo+ICsJc2VxX3ByaW50ZihmaWxlLCAiMHgleFxuIiwgbmRldi0+cmVzLnRpcm4pOwo+ICsJ
cmV0dXJuIDA7Cj4gK30KPiArCj4gK0RFRklORV9TSE9XX0FUVFJJQlVURSh0aXJuKTsKPiArCj4g
K3ZvaWQgbWx4NV92ZHBhX3JlbW92ZV90aXJuKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+
ICt7Cj4gKwlpZiAobmRldi0+ZGVidWdmcykKPiArCQlkZWJ1Z2ZzX3JlbW92ZShuZGV2LT5yZXMu
dGlybl9kZW50KTsKPiArfQo+ICsKPiArdm9pZCBtbHg1X3ZkcGFfYWRkX3Rpcm4oc3RydWN0IG1s
eDVfdmRwYV9uZXQgKm5kZXYpCj4gK3sKPiArCW5kZXYtPnJlcy50aXJuX2RlbnQgPSBkZWJ1Z2Zz
X2NyZWF0ZV9maWxlKCJ0aXJuIiwgMDQ0NCwgbmRldi0+cnhfZGVudCwKPiArCQkJCQkJICBuZGV2
LCAmdGlybl9mb3BzKTsKPiArfQo+ICsKPiArc3RhdGljIGludCByeF9mbG93X3RhYmxlX3Nob3co
c3RydWN0IHNlcV9maWxlICpmaWxlLCB2b2lkICpwcml2KQo+ICt7Cj4gKwlzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAqbmRldiA9IGZpbGUtPnByaXZhdGU7Cj4gKwo+ICsJc2VxX3ByaW50ZihmaWxlLCAi
MHgleFxuIiwgbWx4NV9mbG93X3RhYmxlX2lkKG5kZXYtPnJ4ZnQpKTsKPiArCXJldHVybiAwOwo+
ICt9Cj4gKwo+ICtERUZJTkVfU0hPV19BVFRSSUJVVEUocnhfZmxvd190YWJsZSk7Cj4gKwo+ICt2
b2lkIG1seDVfdmRwYV9yZW1vdmVfcnhfZmxvd190YWJsZShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAq
bmRldikKPiArewo+ICsJaWYgKG5kZXYtPmRlYnVnZnMpCj4gKwkJZGVidWdmc19yZW1vdmUobmRl
di0+cnhfdGFibGVfZGVudCk7Cj4gK30KPiArCj4gK3ZvaWQgbWx4NV92ZHBhX2FkZF9yeF9mbG93
X3RhYmxlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ICt7Cj4gKwluZGV2LT5yeF90YWJs
ZV9kZW50ID0gZGVidWdmc19jcmVhdGVfZmlsZSgidGFibGVfaWQiLCAwNDQ0LCBuZGV2LT5yeF9k
ZW50LAo+ICsJCQkJCQkgIG5kZXYsICZyeF9mbG93X3RhYmxlX2ZvcHMpOwo+ICt9Cj4gKwo+ICt2
b2lkIG1seDVfdmRwYV9hZGRfZGVidWdmcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAr
ewo+ICsJc3RydWN0IG1seDVfY29yZV9kZXYgKm1kZXY7Cj4gKwo+ICsJbWRldiA9IG5kZXYtPm12
ZGV2Lm1kZXY7Cj4gKwluZGV2LT5kZWJ1Z2ZzID0gZGVidWdmc19jcmVhdGVfZGlyKGRldl9uYW1l
KCZuZGV2LT5tdmRldi52ZGV2LmRldiksCj4gKwkJCQkJICAgbWx4NV9kZWJ1Z2ZzX2dldF9kZXZf
cm9vdChtZGV2KSk7Cj4gKwlpZiAoIUlTX0VSUihuZGV2LT5kZWJ1Z2ZzKSkKPiArCQluZGV2LT5y
eF9kZW50ID0gZGVidWdmc19jcmVhdGVfZGlyKCJyeCIsIG5kZXYtPmRlYnVnZnMpOwo+ICt9Cj4g
Kwo+ICt2b2lkIG1seDVfdmRwYV9yZW1vdmVfZGVidWdmcyhzdHJ1Y3QgZGVudHJ5ICpkYmcpCj4g
K3sKPiArCWRlYnVnZnNfcmVtb3ZlX3JlY3Vyc2l2ZShkYmcpOwo+ICt9Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYwo+IGluZGV4IDY0ZmRiOTQwMzgwZi4uZWU1MGRhMzNlMjViIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC0xMzg4LDExICsxMzg4LDE2IEBAIHN0YXRp
YyBpbnQgY3JlYXRlX3RpcihzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAgIAo+ICAgCWVy
ciA9IG1seDVfdmRwYV9jcmVhdGVfdGlyKCZuZGV2LT5tdmRldiwgaW4sICZuZGV2LT5yZXMudGly
bik7Cj4gICAJa2ZyZWUoaW4pOwo+ICsJaWYgKGVycikKPiArCQlyZXR1cm4gZXJyOwo+ICsKPiAr
CW1seDVfdmRwYV9hZGRfdGlybihuZGV2KTsKPiAgIAlyZXR1cm4gZXJyOwo+ICAgfQo+ICAgCj4g
ICBzdGF0aWMgdm9pZCBkZXN0cm95X3RpcihzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAg
IHsKPiArCW1seDVfdmRwYV9yZW1vdmVfdGlybihuZGV2KTsKPiAgIAltbHg1X3ZkcGFfZGVzdHJv
eV90aXIoJm5kZXYtPm12ZGV2LCBuZGV2LT5yZXMudGlybik7Cj4gICB9Cj4gICAKPiBAQCAtMTU3
Niw2ICsxNTgxLDcgQEAgc3RhdGljIGludCBzZXR1cF9zdGVlcmluZyhzdHJ1Y3QgbWx4NV92ZHBh
X25ldCAqbmRldikKPiAgIAkJbWx4NV92ZHBhX3dhcm4oJm5kZXYtPm12ZGV2LCAiZmFpbGVkIHRv
IGNyZWF0ZSBmbG93IHRhYmxlXG4iKTsKPiAgIAkJcmV0dXJuIFBUUl9FUlIobmRldi0+cnhmdCk7
Cj4gICAJfQo+ICsJbWx4NV92ZHBhX2FkZF9yeF9mbG93X3RhYmxlKG5kZXYpOwo+ICAgCj4gICAJ
ZXJyID0gbWFjX3ZsYW5fYWRkKG5kZXYsIG5kZXYtPmNvbmZpZy5tYWMsIDAsIGZhbHNlKTsKPiAg
IAlpZiAoZXJyKQo+IEBAIC0xNTg0LDYgKzE1OTAsNyBAQCBzdGF0aWMgaW50IHNldHVwX3N0ZWVy
aW5nKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ICAgCXJldHVybiAwOwo+ICAgCj4gICBl
cnJfYWRkOgo+ICsJbWx4NV92ZHBhX3JlbW92ZV9yeF9mbG93X3RhYmxlKG5kZXYpOwo+ICAgCW1s
eDVfZGVzdHJveV9mbG93X3RhYmxlKG5kZXYtPnJ4ZnQpOwo+ICAgCXJldHVybiBlcnI7Cj4gICB9
Cj4gQEAgLTE1OTEsNiArMTU5OCw3IEBAIHN0YXRpYyBpbnQgc2V0dXBfc3RlZXJpbmcoc3RydWN0
IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gICBzdGF0aWMgdm9pZCB0ZWFyZG93bl9zdGVlcmluZyhz
dHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAgIHsKPiAgIAljbGVhcl9tYWNfdmxhbl90YWJs
ZShuZGV2KTsKPiArCW1seDVfdmRwYV9yZW1vdmVfcnhfZmxvd190YWJsZShuZGV2KTsKPiAgIAlt
bHg1X2Rlc3Ryb3lfZmxvd190YWJsZShuZGV2LT5yeGZ0KTsKPiAgIH0KPiAgIAo+IEBAIC0zMTY3
LDYgKzMxNzUsNyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21n
bXRfZGV2ICp2X21kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4gICAJaWYgKGVycikKPiAgIAkJZ290
byBlcnJfcmVnOwo+ICAgCj4gKwltbHg1X3ZkcGFfYWRkX2RlYnVnZnMobmRldik7Cj4gICAJbWd0
ZGV2LT5uZGV2ID0gbmRldjsKPiAgIAlyZXR1cm4gMDsKPiAgIAo+IEBAIC0zMTkzLDYgKzMyMDIs
OCBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfZGV2X2RlbChzdHJ1Y3QgdmRwYV9tZ210X2RldiAq
dl9tZGV2LCBzdHJ1Y3QgdmRwYV9kZXZpY2UgKgo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpu
ZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+ICAgCXN0cnVjdCB3b3JrcXVldWVfc3Ry
dWN0ICp3cTsKPiAgIAo+ICsJbWx4NV92ZHBhX3JlbW92ZV9kZWJ1Z2ZzKG5kZXYtPmRlYnVnZnMp
Owo+ICsJbmRldi0+ZGVidWdmcyA9IE5VTEw7Cj4gICAJaWYgKG5kZXYtPm5iX3JlZ2lzdGVyZWQp
IHsKPiAgIAkJbWx4NV9ub3RpZmllcl91bnJlZ2lzdGVyKG12ZGV2LT5tZGV2LCAmbmRldi0+bmIp
Owo+ICAgCQluZGV2LT5uYl9yZWdpc3RlcmVkID0gZmFsc2U7Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuaCBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuaAo+IGluZGV4IDY2OTFjODc5YTZjYS4uZjJjZWYzOTI1ZTViIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuaAo+IEBAIC0xNiw2ICsxNiw3IEBAIHN0cnVjdCBtbHg1X3ZkcGFf
bmV0X3Jlc291cmNlcyB7Cj4gICAJdTMyIHRpcm47Cj4gICAJdTMyIHJxdG47Cj4gICAJYm9vbCB2
YWxpZDsKPiArCXN0cnVjdCBkZW50cnkgKnRpcm5fZGVudDsKPiAgIH07Cj4gICAKPiAgICNkZWZp
bmUgTUxYNVZfTUFDVkxBTl9TSVpFIDI1Ngo+IEBAIC00Myw2ICs0NCw3IEBAIHN0cnVjdCBtbHg1
X3ZkcGFfbmV0IHsKPiAgIAlzdHJ1Y3QgdmRwYV9jYWxsYmFjayBjb25maWdfY2I7Cj4gICAJc3Ry
dWN0IG1seDVfdmRwYV93cV9lbnQgY3ZxX2VudDsKPiAgIAlzdHJ1Y3QgaGxpc3RfaGVhZCBtYWN2
bGFuX2hhc2hbTUxYNVZfTUFDVkxBTl9TSVpFXTsKPiArCXN0cnVjdCBkZW50cnkgKmRlYnVnZnM7
Cj4gICB9Owo+ICAgCj4gICBzdHJ1Y3QgbWFjdmxhbl9ub2RlIHsKPiBAQCAtNTIsNCArNTQsMTEg
QEAgc3RydWN0IG1hY3ZsYW5fbm9kZSB7Cj4gICAJdTY0IG1hY3ZsYW47Cj4gICB9Owo+ICAgCj4g
K3ZvaWQgbWx4NV92ZHBhX2FkZF9kZWJ1Z2ZzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KTsK
PiArdm9pZCBtbHg1X3ZkcGFfcmVtb3ZlX2RlYnVnZnMoc3RydWN0IGRlbnRyeSAqZGJnKTsKPiAr
dm9pZCBtbHg1X3ZkcGFfYWRkX3J4X2Zsb3dfdGFibGUoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5k
ZXYpOwo+ICt2b2lkIG1seDVfdmRwYV9yZW1vdmVfcnhfZmxvd190YWJsZShzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAqbmRldik7Cj4gK3ZvaWQgbWx4NV92ZHBhX2FkZF90aXJuKHN0cnVjdCBtbHg1X3Zk
cGFfbmV0ICpuZGV2KTsKPiArdm9pZCBtbHg1X3ZkcGFfcmVtb3ZlX3Rpcm4oc3RydWN0IG1seDVf
dmRwYV9uZXQgKm5kZXYpOwo+ICsKPiAgICNlbmRpZiAvKiBfX01MWDVfVk5FVF9IX18gKi8KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
