Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EBBC4708F
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 07:07:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D311D601FF
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 07:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D311D601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A049083521;
	Wed,  2 Jun 2021 07:07:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vWio_tR6lFpE; Wed,  2 Jun 2021 07:07:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43F7B83518;
	Wed,  2 Jun 2021 07:07:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2083EC000D;
	Wed,  2 Jun 2021 07:07:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38891C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25FB540324
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:07:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tMrY4c3HMXnx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:07:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1EB3A402EB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622617628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIn7oU6+FWaajjVOBnVnDXXj1rPq+MuBcxlSw0xkwZE=;
 b=SG8TnGdZMWOTDQnHTL1//IgN5SneSrV/eZFgWwGlrRnzntBPVzZMjAcxdW/3VtI/2Tp+tS
 b8yzsnuBGvfTKLToo0k5M3h9x5olo8+FBPKoajBRpOW52LlWXIKbapYTYupsj3zFXl+Qxm
 6LzuCiJVelUK25ndn881d/QxekUKodc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-Meja5a4gOBC6hbAiBL6VuQ-1; Wed, 02 Jun 2021 03:07:07 -0400
X-MC-Unique: Meja5a4gOBC6hbAiBL6VuQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d17-20020aa781510000b02902e921bdea05so968721pfn.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 00:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=DIn7oU6+FWaajjVOBnVnDXXj1rPq+MuBcxlSw0xkwZE=;
 b=CvYA+B/zPD1J8N6r1pZKbqsZKXTNoRrdY/WEHP4S+x2bvPmVa95I/zH9y0xI23cu8U
 9qy0uxKJH51WRRNYoci1BhATE6YuA8uJIRcQT/kd+UCuxxc+eiyEnz+1uM8Gdl/rnS3q
 7Kq9VKaoeTeeOkr0gcaRWzg4IK9aVjofxLb/TTnSNp78CM0mKTUwagdpprrYfZx3SMR5
 amM5z600E0rkEAuCAxoUwcHFNbgsk/SB0cI0kuh9LMjIGXVfa+//q6dLXpIewfsVfFgo
 er6mi6xzLn4f6TLF4HhBY4deBbJPObmEkGnF35wgOFovaIwB1mB2SExgA1XQ/TLrWey+
 Twhw==
X-Gm-Message-State: AOAM531QuEySMVApWc4YReEOmFjeupvtggGuxHZBB1NrvcDZbvNi+6Vs
 Psd2Tz39fVFPSsoKMAL/9VPb2xOlhTzMy7OyHeB1e9gmjjRTNiJeIZn+dBe5n76fTguhcifrCbm
 lpZY+WoTBUoDlG4trGFNGl4WEiIjRg1vsTLI5LLSFwQ==
X-Received: by 2002:a63:370b:: with SMTP id e11mr2997525pga.356.1622617625654; 
 Wed, 02 Jun 2021 00:07:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQPBUIaMSz6qvd9JSBnMqXSurn4bBEos0N6fpw0TLZWd+uW/3B70u5qTqpAn9peLKQgziDfg==
X-Received: by 2002:a63:370b:: with SMTP id e11mr2997512pga.356.1622617625499; 
 Wed, 02 Jun 2021 00:07:05 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p26sm3560856pfw.178.2021.06.02.00.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 00:07:05 -0700 (PDT)
Subject: Re: [PATCH V2 4/4] virtio/vdpa: clear the virtqueue state during probe
To: Eli Cohen <elic@nvidia.com>
References: <20210602021043.39201-1-jasowang@redhat.com>
 <20210602021043.39201-5-jasowang@redhat.com>
 <20210602061723.GB8662@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7ce52bd6-60b7-b733-9881-682cfba51ad8@redhat.com>
Date: Wed, 2 Jun 2021 15:07:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602061723.GB8662@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eli@mellanox.com
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

CtTaIDIwMjEvNi8yIM/CzucyOjE3LCBFbGkgQ29oZW4g0LS1wDoKPiBPbiBXZWQsIEp1biAwMiwg
MjAyMSBhdCAxMDoxMDo0M0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBGcm9tOiBFbGkg
Q29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4KPj4gQ2xlYXIgdGhlIGF2YWlsYWJsZSBpbmRleCBh
cyBwYXJ0IG9mIHRoZSBpbml0aWFsaXphdGlvbiBwcm9jZXNzIHRvCj4+IGNsZWFyIGFuZCB2YWx1
ZXMgdGhhdCBtaWdodCBiZSBsZWZ0IGZyb20gcHJldmlvdXMgdXNhZ2Ugb2YgdGhlIGRldmljZS4K
Pj4gRm9yIGV4YW1wbGUsIGlmIHRoZSBkZXZpY2Ugd2FzIHByZXZpb3VzbHkgdXNlZCBieSB2aG9z
dF92ZHBhIGFuZCBub3cKPj4gcHJvYmVkIGJ5IHZob3N0X3ZkcGEsIHlvdSB3YW50IHRvIHN0YXJ0
IHdpdGggaW5kaWNlcy4KPj4KPj4gRml4ZXM6IGMwNDNiNGE4Y2YzYiAoInZpcnRpbzogaW50cm9k
dWNlIGEgdkRQQSBiYXNlZCB0cmFuc3BvcnQiKQo+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4g
PGVsaWNAbnZpZGlhLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8IDE1
ICsrKysrKysrKysrKysrKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3ZkcGEuYwo+PiBpbmRleCBlMjhhY2Y0ODJlMGMuLmUxYTE0MTEzNTk5MiAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+PiArKysgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4+IEBAIC0xNDIsNiArMTQyLDggQEAgdmlydGlvX3Zk
cGFfc2V0dXBfdnEoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBpbmRl
eCwKPj4gICAJc3RydWN0IHZkcGFfY2FsbGJhY2sgY2I7Cj4+ICAgCXN0cnVjdCB2aXJ0cXVldWUg
KnZxOwo+PiAgIAl1NjQgZGVzY19hZGRyLCBkcml2ZXJfYWRkciwgZGV2aWNlX2FkZHI7Cj4+ICsJ
LyogQXNzdW1lIHNwbGl0IHZpcnRxdWV1ZSwgc3dpdGNoIHRvIHBhY2tlZCBpZiBuZWNlc3Nhcnkg
Ki8KPj4gKwlzdHJ1Y3QgdmRwYV92cV9zdGF0ZSBzdGF0ZSA9IHswfTsKPj4gICAJdW5zaWduZWQg
bG9uZyBmbGFnczsKPj4gICAJdTMyIGFsaWduLCBudW07Cj4+ICAgCWludCBlcnI7Cj4+IEBAIC0x
OTEsNiArMTkzLDE5IEBAIHZpcnRpb192ZHBhX3NldHVwX3ZxKHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2LCB1bnNpZ25lZCBpbnQgaW5kZXgsCj4+ICAgCQlnb3RvIGVycl92cTsKPj4gICAJfQo+
PiAgIAo+PiArCS8qIHJlc2V0IHZpcnRxdWV1ZSBzdGF0ZSBpbmRleCAqLwo+PiArCWlmICh2aXJ0
aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0ZfUklOR19QQUNLRUQpKSB7Cj4+ICsJCXN0cnVj
dCB2ZHBhX3ZxX3N0YXRlX3BhY2tlZCAqcyA9ICZzdGF0ZS5wYWNrZWQ7Cj4+ICsKPj4gKwkJcy0+
bGFzdF9hdmFpbF9jb3VudGVyID0gMTsKPj4gKwkJcy0+bGFzdF9hdmFpbF9pZHggPSAwOwo+IEl0
J3MgYWxyZWFkeSAwCj4KPj4gKwkJcy0+bGFzdF91c2VkX2NvdW50ZXIgPSAxOwo+PiArCQlzLT5s
YXN0X3VzZWRfaWR4ID0gMDsKPiBhbHJlYWR5IDAKCgpZZXMsIGJ1dCBmb3IgY29tcGxldGVuZXNz
IGFuZCBtYWtlIGNvZGUgZWFzeSB0byByZWFkLCBpdCdzIG5vIGhhcm0gdG8gCmtlZXAgdGhlbSBJ
IHRoaW5rLgoKVGhhbmtzCgoKPgo+PiArCX0KPj4gKwllcnIgPSBvcHMtPnNldF92cV9zdGF0ZSh2
ZHBhLCBpbmRleCwgJnN0YXRlKTsKPj4gKwlpZiAoZXJyKQo+PiArCQlnb3RvIGVycl92cTsKPj4g
Kwo+PiAgIAlvcHMtPnNldF92cV9yZWFkeSh2ZHBhLCBpbmRleCwgMSk7Cj4+ICAgCj4+ICAgCXZx
LT5wcml2ID0gaW5mbzsKPj4gLS0gCj4+IDIuMjUuMQo+PgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
