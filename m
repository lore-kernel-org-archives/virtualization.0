Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0404EC48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 02:42:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0EC61246
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 02:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0EC61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7477C4013A;
	Wed, 16 Jun 2021 02:42:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id weCyoiJoVRs9; Wed, 16 Jun 2021 02:42:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C0C7400CF;
	Wed, 16 Jun 2021 02:42:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5FD7C000D;
	Wed, 16 Jun 2021 02:42:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F09EC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 02:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3AA6E4068F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 02:42:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WFThUrPsH9KI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 02:42:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E834740304
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 02:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623811349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oqa5WhFJLs+5ajn0RrVLRKUCTBrXJ3mBHQN7hP5zDa0=;
 b=Y6RiTxYW7XmGpH1K+xE8oGlQEDauvYzmHPAgPWO6VeOgCISQwayr8zxDnJRqJmpYAWdvz+
 Uw6uaQdXcdZ4O+MSFO7ZtLAADf4peOqP+bIGcr8thSrP8HAWgleh0aar2Oa8Z3Orenq3pv
 Qs222eKaPzWMdZ0piJ8MQP4dsQrEeeU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-GL0Dl-blO1e_tWc2HmHe2g-1; Tue, 15 Jun 2021 22:42:28 -0400
X-MC-Unique: GL0Dl-blO1e_tWc2HmHe2g-1
Received: by mail-pl1-f198.google.com with SMTP id
 s23-20020a170902b197b029011aafb8fbadso222468plr.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 19:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Oqa5WhFJLs+5ajn0RrVLRKUCTBrXJ3mBHQN7hP5zDa0=;
 b=WdQ+qiYUHzJBCT7GH2iotensKZICZavLoLTWIcUJqvoqJ9WdrsZgcT7bjhV9xAhHky
 4fpCOj20wQHJHFBHIFC8ibPYsbk2xoDNndtuiZZNdxCZ+7APp+m0W+vk3mtLL4KtFWwf
 Oe8dRVxUUrdRD9+pCUr5LV7jYx0cIBmBYg7A6sH0TtRnflSkZR66bs0ypfKmyw/RON9C
 BxCT/XBJu3vBrgDRRb3uCv2ESUom/CKpnRqrfDXzqliFKNvTBfK3iywTSr6PYCUC87bq
 oGqy/pMllRwbeb7yZaLlw1O0cqkpETiL79l4dEcf/CFhq10okKyehHw8y4U9cu6fX8W/
 E+cA==
X-Gm-Message-State: AOAM531rFNff7nvxr9uVO44+WMJI3IxAPMUBmv0IzagpnY9EX7JggcMQ
 mO6FGrR3djoZJm6rgajIrXzuMzIGpocCUZDajxghXvNXwjkN+1NNsDbArCDWkjpLZb5K6JwCZyD
 vvw3LBernFF9vgHQ62Sdv0CzYrD3OPyQC7Z21+0oIIA==
X-Received: by 2002:a63:78d:: with SMTP id 135mr2724780pgh.178.1623811346884; 
 Tue, 15 Jun 2021 19:42:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxg4OnU2/MeSJw7CkcQCwmF00RCnLICax2yHLy0z44ABMAmi49jDD3Kb/dLsnhZ/+hRm7vAg==
X-Received: by 2002:a63:78d:: with SMTP id 135mr2724747pgh.178.1623811346544; 
 Tue, 15 Jun 2021 19:42:26 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id ig1sm413200pjb.27.2021.06.15.19.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jun 2021 19:42:26 -0700 (PDT)
Subject: Re: [PATCH net-next v5 06/15] virtio-net: unify the code for
 recycling the xmit ptr
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
 <20210610082209.91487-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <87b214de-cc8c-bfa1-6a10-8f3c6a409a9a@redhat.com>
Date: Wed, 16 Jun 2021 10:42:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610082209.91487-7-xuanzhuo@linux.alibaba.com>
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

CtTaIDIwMjEvNi8xMCDPws7nNDoyMiwgWHVhbiBaaHVvINC0tcA6Cj4gTm93IHRoZXJlIGFyZSB0
d28gdHlwZXMgb2YgInNrYiIgYW5kICJ4ZHAgZnJhbWUiIGR1cmluZyByZWN5Y2xpbmcgb2xkCj4g
eG1pdC4KPgo+IFRoZXJlIGFyZSB0d28gY29tcGxldGVseSBzaW1pbGFyIGFuZCBpbmRlcGVuZGVu
dCBpbXBsZW1lbnRhdGlvbnMuIFRoaXMKPiBpcyBpbmNvbnZlbmllbnQgZm9yIHRoZSBzdWJzZXF1
ZW50IGFkZGl0aW9uIG9mIG5ldyB0eXBlcy4gU28gZXh0cmFjdCBhCj4gZnVuY3Rpb24gZnJvbSB0
aGlzIHBpZWNlIG9mIGNvZGUgYW5kIGNhbGwgdGhpcyBmdW5jdGlvbiB1bmlmb3JtbHkgdG8KPiBy
ZWNvdmVyIG9sZCB4bWl0IHB0ci4KPgo+IFJlbmFtZSBmcmVlX29sZF94bWl0X3NrYnMoKSB0byBm
cmVlX29sZF94bWl0KCkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA4NiArKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMzggaW5z
ZXJ0aW9ucygrKSwgNDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggNmMxMjMzZjBh
YjNlLi5kNzkxNTQzYThkZDggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTI2NCw2ICsyNjQsMzAgQEAg
c3RhdGljIHN0cnVjdCB4ZHBfZnJhbWUgKnB0cl90b194ZHAodm9pZCAqcHRyKQo+ICAgCXJldHVy
biAoc3RydWN0IHhkcF9mcmFtZSAqKSgodW5zaWduZWQgbG9uZylwdHIgJiB+VklSVElPX1hEUF9G
TEFHKTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCBfX2ZyZWVfb2xkX3htaXQoc3RydWN0IHNl
bmRfcXVldWUgKnNxLCBib29sIGluX25hcGksCj4gKwkJCSAgICBzdHJ1Y3QgdmlydG5ldF9zcV9z
dGF0cyAqc3RhdHMpCj4gK3sKPiArCXVuc2lnbmVkIGludCBsZW47Cj4gKwl2b2lkICpwdHI7Cj4g
Kwo+ICsJd2hpbGUgKChwdHIgPSB2aXJ0cXVldWVfZ2V0X2J1ZihzcS0+dnEsICZsZW4pKSAhPSBO
VUxMKSB7Cj4gKwkJaWYgKCFpc194ZHBfZnJhbWUocHRyKSkgewo+ICsJCQlzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiID0gcHRyOwo+ICsKPiArCQkJcHJfZGVidWcoIlNlbnQgc2tiICVwXG4iLCBza2IpOwo+
ICsKPiArCQkJc3RhdHMtPmJ5dGVzICs9IHNrYi0+bGVuOwo+ICsJCQluYXBpX2NvbnN1bWVfc2ti
KHNrYiwgaW5fbmFwaSk7Cj4gKwkJfSBlbHNlIHsKPiArCQkJc3RydWN0IHhkcF9mcmFtZSAqZnJh
bWUgPSBwdHJfdG9feGRwKHB0cik7Cj4gKwo+ICsJCQlzdGF0cy0+Ynl0ZXMgKz0gZnJhbWUtPmxl
bjsKPiArCQkJeGRwX3JldHVybl9mcmFtZShmcmFtZSk7Cj4gKwkJfQo+ICsJCXN0YXRzLT5wYWNr
ZXRzKys7Cj4gKwl9Cj4gK30KPiArCj4gICAvKiBDb252ZXJ0aW5nIGJldHdlZW4gdmlydHF1ZXVl
IG5vLiBhbmQga2VybmVsIHR4L3J4IHF1ZXVlIG5vLgo+ICAgICogMDpyeDAgMTp0eDAgMjpyeDEg
Mzp0eDEgLi4uIDJOOnJ4TiAyTisxOnR4TiAyTisyOmN2cQo+ICAgICovCj4gQEAgLTU3MiwxNSAr
NTk2LDEyIEBAIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfeG1pdChzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2LAo+ICAgCQkJICAgIGludCBuLCBzdHJ1Y3QgeGRwX2ZyYW1lICoqZnJhbWVzLCB1MzIgZmxh
Z3MpCj4gICB7Cj4gICAJc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYp
Owo+ICsJc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHMgPSB7fTsKPiAgIAlzdHJ1Y3QgcmVj
ZWl2ZV9xdWV1ZSAqcnEgPSB2aS0+cnE7Cj4gICAJc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZzsK
PiAgIAlzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3E7Cj4gLQl1bnNpZ25lZCBpbnQgbGVuOwo+IC0JaW50
IHBhY2tldHMgPSAwOwo+IC0JaW50IGJ5dGVzID0gMDsKPiAgIAlpbnQgbnhtaXQgPSAwOwo+ICAg
CWludCBraWNrcyA9IDA7Cj4gLQl2b2lkICpwdHI7Cj4gICAJaW50IHJldDsKPiAgIAlpbnQgaTsK
PiAgIAo+IEBAIC01OTksMjAgKzYyMCw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfeG1pdChz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgCX0KPiAgIAo+ICAgCS8qIEZyZWUgdXAgYW55IHBl
bmRpbmcgb2xkIGJ1ZmZlcnMgYmVmb3JlIHF1ZXVlaW5nIG5ldyBvbmVzLiAqLwo+IC0Jd2hpbGUg
KChwdHIgPSB2aXJ0cXVldWVfZ2V0X2J1ZihzcS0+dnEsICZsZW4pKSAhPSBOVUxMKSB7Cj4gLQkJ
aWYgKGxpa2VseShpc194ZHBfZnJhbWUocHRyKSkpIHsKPiAtCQkJc3RydWN0IHhkcF9mcmFtZSAq
ZnJhbWUgPSBwdHJfdG9feGRwKHB0cik7Cj4gLQo+IC0JCQlieXRlcyArPSBmcmFtZS0+bGVuOwo+
IC0JCQl4ZHBfcmV0dXJuX2ZyYW1lKGZyYW1lKTsKPiAtCQl9IGVsc2Ugewo+IC0JCQlzdHJ1Y3Qg
c2tfYnVmZiAqc2tiID0gcHRyOwo+IC0KPiAtCQkJYnl0ZXMgKz0gc2tiLT5sZW47Cj4gLQkJCW5h
cGlfY29uc3VtZV9za2Ioc2tiLCBmYWxzZSk7Cj4gLQkJfQo+IC0JCXBhY2tldHMrKzsKPiAtCX0K
PiArCV9fZnJlZV9vbGRfeG1pdChzcSwgZmFsc2UsICZzdGF0cyk7Cj4gICAKPiAgIAlmb3IgKGkg
PSAwOyBpIDwgbjsgaSsrKSB7Cj4gICAJCXN0cnVjdCB4ZHBfZnJhbWUgKnhkcGYgPSBmcmFtZXNb
aV07Cj4gQEAgLTYyOSw4ICs2MzcsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3htaXQoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAl9Cj4gICBvdXQ6Cj4gICAJdTY0X3N0YXRzX3VwZGF0
ZV9iZWdpbigmc3EtPnN0YXRzLnN5bmNwKTsKPiAtCXNxLT5zdGF0cy5ieXRlcyArPSBieXRlczsK
PiAtCXNxLT5zdGF0cy5wYWNrZXRzICs9IHBhY2tldHM7Cj4gKwlzcS0+c3RhdHMuYnl0ZXMgKz0g
c3RhdHMuYnl0ZXM7Cj4gKwlzcS0+c3RhdHMucGFja2V0cyArPSBzdGF0cy5wYWNrZXRzOwo+ICAg
CXNxLT5zdGF0cy54ZHBfdHggKz0gbjsKPiAgIAlzcS0+c3RhdHMueGRwX3R4X2Ryb3BzICs9IG4g
LSBueG1pdDsKPiAgIAlzcS0+c3RhdHMua2lja3MgKz0ga2lja3M7Cj4gQEAgLTE0NTksMzkgKzE0
NjcsMjEgQEAgc3RhdGljIGludCB2aXJ0bmV0X3JlY2VpdmUoc3RydWN0IHJlY2VpdmVfcXVldWUg
KnJxLCBpbnQgYnVkZ2V0LAo+ICAgCXJldHVybiBzdGF0cy5wYWNrZXRzOwo+ICAgfQo+ICAgCj4g
LXN0YXRpYyB2b2lkIGZyZWVfb2xkX3htaXRfc2ticyhzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsIGJv
b2wgaW5fbmFwaSkKPiArc3RhdGljIHZvaWQgZnJlZV9vbGRfeG1pdChzdHJ1Y3Qgc2VuZF9xdWV1
ZSAqc3EsIGJvb2wgaW5fbmFwaSkKPiAgIHsKPiAtCXVuc2lnbmVkIGludCBsZW47Cj4gLQl1bnNp
Z25lZCBpbnQgcGFja2V0cyA9IDA7Cj4gLQl1bnNpZ25lZCBpbnQgYnl0ZXMgPSAwOwo+IC0Jdm9p
ZCAqcHRyOwo+ICsJc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHMgPSB7fTsKPiAgIAo+IC0J
d2hpbGUgKChwdHIgPSB2aXJ0cXVldWVfZ2V0X2J1ZihzcS0+dnEsICZsZW4pKSAhPSBOVUxMKSB7
Cj4gLQkJaWYgKGxpa2VseSghaXNfeGRwX2ZyYW1lKHB0cikpKSB7Cj4gLQkJCXN0cnVjdCBza19i
dWZmICpza2IgPSBwdHI7Cj4gLQo+IC0JCQlwcl9kZWJ1ZygiU2VudCBza2IgJXBcbiIsIHNrYik7
Cj4gLQo+IC0JCQlieXRlcyArPSBza2ItPmxlbjsKPiAtCQkJbmFwaV9jb25zdW1lX3NrYihza2Is
IGluX25hcGkpOwo+IC0JCX0gZWxzZSB7Cj4gLQkJCXN0cnVjdCB4ZHBfZnJhbWUgKmZyYW1lID0g
cHRyX3RvX3hkcChwdHIpOwo+IC0KPiAtCQkJYnl0ZXMgKz0gZnJhbWUtPmxlbjsKPiAtCQkJeGRw
X3JldHVybl9mcmFtZShmcmFtZSk7Cj4gLQkJfQo+IC0JCXBhY2tldHMrKzsKPiAtCX0KPiArCV9f
ZnJlZV9vbGRfeG1pdChzcSwgaW5fbmFwaSwgJnN0YXRzKTsKPiAgIAo+ICAgCS8qIEF2b2lkIG92
ZXJoZWFkIHdoZW4gbm8gcGFja2V0cyBoYXZlIGJlZW4gcHJvY2Vzc2VkCj4gICAJICogaGFwcGVu
cyB3aGVuIGNhbGxlZCBzcGVjdWxhdGl2ZWx5IGZyb20gc3RhcnRfeG1pdC4KPiAgIAkgKi8KPiAt
CWlmICghcGFja2V0cykKPiArCWlmICghc3RhdHMucGFja2V0cykKPiAgIAkJcmV0dXJuOwo+ICAg
Cj4gICAJdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbigmc3EtPnN0YXRzLnN5bmNwKTsKPiAtCXNxLT5z
dGF0cy5ieXRlcyArPSBieXRlczsKPiAtCXNxLT5zdGF0cy5wYWNrZXRzICs9IHBhY2tldHM7Cj4g
KwlzcS0+c3RhdHMuYnl0ZXMgKz0gc3RhdHMuYnl0ZXM7Cj4gKwlzcS0+c3RhdHMucGFja2V0cyAr
PSBzdGF0cy5wYWNrZXRzOwo+ICAgCXU2NF9zdGF0c191cGRhdGVfZW5kKCZzcS0+c3RhdHMuc3lu
Y3ApOwo+ICAgfQo+ICAgCj4gQEAgLTE1MTYsNyArMTUwNiw3IEBAIHN0YXRpYyB2b2lkIHZpcnRu
ZXRfcG9sbF9jbGVhbnR4KHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSkKPiAgIAkJcmV0dXJuOwo+
ICAgCj4gICAJaWYgKF9fbmV0aWZfdHhfdHJ5bG9jayh0eHEpKSB7Cj4gLQkJZnJlZV9vbGRfeG1p
dF9za2JzKHNxLCB0cnVlKTsKPiArCQlmcmVlX29sZF94bWl0KHNxLCB0cnVlKTsKPiAgIAkJX19u
ZXRpZl90eF91bmxvY2sodHhxKTsKPiAgIAl9Cj4gICAKPiBAQCAtMTYwMSw3ICsxNTkxLDcgQEAg
c3RhdGljIGludCB2aXJ0bmV0X3BvbGxfdHgoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLCBpbnQg
YnVkZ2V0KQo+ICAgCj4gICAJdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBpbmRl
eCk7Cj4gICAJX19uZXRpZl90eF9sb2NrKHR4cSwgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSk7Cj4g
LQlmcmVlX29sZF94bWl0X3NrYnMoc3EsIHRydWUpOwo+ICsJZnJlZV9vbGRfeG1pdChzcSwgdHJ1
ZSk7Cj4gICAJX19uZXRpZl90eF91bmxvY2sodHhxKTsKPiAgIAo+ICAgCXZpcnRxdWV1ZV9uYXBp
X2NvbXBsZXRlKG5hcGksIHNxLT52cSwgMCk7Cj4gQEAgLTE2NzAsNyArMTY2MCw3IEBAIHN0YXRp
YyBuZXRkZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYpCj4gICAJYm9vbCB1c2VfbmFwaSA9IHNxLT5uYXBpLndlaWdodDsKPiAgIAo+
ICAgCS8qIEZyZWUgdXAgYW55IHBlbmRpbmcgb2xkIGJ1ZmZlcnMgYmVmb3JlIHF1ZXVlaW5nIG5l
dyBvbmVzLiAqLwo+IC0JZnJlZV9vbGRfeG1pdF9za2JzKHNxLCBmYWxzZSk7Cj4gKwlmcmVlX29s
ZF94bWl0KHNxLCBmYWxzZSk7Cj4gICAKPiAgIAlpZiAodXNlX25hcGkgJiYga2ljaykKPiAgIAkJ
dmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHNxLT52cSk7Cj4gQEAgLTE3MTQsNyArMTcwNCw3
IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gICAJCWlmICghdXNlX25hcGkgJiYKPiAgIAkJICAgIHVu
bGlrZWx5KCF2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQoc3EtPnZxKSkpIHsKPiAgIAkJCS8q
IE1vcmUganVzdCBnb3QgdXNlZCwgZnJlZSB0aGVtIHRoZW4gcmVjaGVjay4gKi8KPiAtCQkJZnJl
ZV9vbGRfeG1pdF9za2JzKHNxLCBmYWxzZSk7Cj4gKwkJCWZyZWVfb2xkX3htaXQoc3EsIGZhbHNl
KTsKPiAgIAkJCWlmIChzcS0+dnEtPm51bV9mcmVlID49IDIrTUFYX1NLQl9GUkFHUykgewo+ICAg
CQkJCW5ldGlmX3N0YXJ0X3N1YnF1ZXVlKGRldiwgcW51bSk7Cj4gICAJCQkJdmlydHF1ZXVlX2Rp
c2FibGVfY2Ioc3EtPnZxKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
