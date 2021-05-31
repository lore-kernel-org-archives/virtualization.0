Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED1AC47082
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:34:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C4F60241
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C4F60241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5DD76403B4;
	Mon, 31 May 2021 06:34:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eLnfOjHGeVeZ; Mon, 31 May 2021 06:34:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id F41F9403B1;
	Mon, 31 May 2021 06:34:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84322C000E;
	Mon, 31 May 2021 06:34:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFAC9C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1602403AE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:34:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WibZtrRrFfYL
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:34:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D525940134
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622442867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsg5GGKLkxbsyGYTd9aXnL4iv/849gVD3+1fI3sYsVU=;
 b=BWj9eRGgurOHy7PjlPAcx9TAAqIeIHsxFfWUG0lygp+QCz6kVNlcffrWzLTF2PwuvxydJD
 r7r7jCqtJazBLRGsObMl9EPvmx7JPTj+tcwzTRqU0t2J80pRoydARyELWmK9AfZtn7m86U
 ZKBCcjN+dIRqKBDdK7bzRyk2dgmVAjY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-LwxmDfFeN7mmBWIrHOivlQ-1; Mon, 31 May 2021 02:34:25 -0400
X-MC-Unique: LwxmDfFeN7mmBWIrHOivlQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 z3-20020a17090a4683b029015f6c19f126so7913919pjf.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 23:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=tsg5GGKLkxbsyGYTd9aXnL4iv/849gVD3+1fI3sYsVU=;
 b=WWVEPxgpDLKVCTiyeJz75+ehOzlki4rIlRj/gC9HuEtBRF3UWwU26KudsLnQpzzKMl
 qBO0XdfTONJl0yYuD0QOt6ZdpjM4lxijamqfzf7YWVKhPtBHBSsQl0nZX5bJJGix/ESw
 4pdhALhI3qHDdAzsSeuk6xKqWeM0XJorTBs9WkCRTx0Jhy09Rsqr4M74lldvT0jBHwJN
 OSW4ebK8ZwZ5i+JEoENlD6VBw87jVZ+EXcozNz5Cc7byApReixd7xPv+w+XzxxelBTTW
 J5SN1eUm0FV5Wqmr1VcX6DY4sgL/BdzB45WeecowB7axs0Fd8JhemyimaMJtN/U3AUpV
 EV2g==
X-Gm-Message-State: AOAM5333twRIf39d565j0y6cAFOt3C7yRafpX/LuBpishP3KbEtns83L
 Cc3KfZj63b/2G4Aq1MQ82cDgWNOv4kf57y1UyzU48WR+JpLKrC0oZn/nd2JPUrJ/6Rnb6u3GNab
 xY9a9UvAG/79P7eK0Rw9LdFoU5D6W1vo9n9DUn4sGDw==
X-Received: by 2002:a17:90a:7345:: with SMTP id
 j5mr17475724pjs.64.1622442864734; 
 Sun, 30 May 2021 23:34:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFb8EfTvkxMFMlIjMbDEB4OqIHs6rtiQvEP0itBg0SNFfkGDpbAyofVggBgFw2WcbkeTEEqQ==
X-Received: by 2002:a17:90a:7345:: with SMTP id
 j5mr17475708pjs.64.1622442864485; 
 Sun, 30 May 2021 23:34:24 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c17sm10740228pgm.3.2021.05.30.23.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 23:34:24 -0700 (PDT)
Subject: Re: [PATCH] virtio: Introduce a new kick interface
 virtqueue_kick_try()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20210519114757.6143-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fdfca0e9-dd2c-13a2-39ed-b360f7bcb881@redhat.com>
Date: Mon, 31 May 2021 14:34:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210519114757.6143-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>
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

CtTaIDIwMjEvNS8xOSDPws7nNzo0NywgWHVhbiBaaHVvINC0tcA6Cj4gVW5saWtlIHZpcnRxdWV1
ZV9raWNrKCksIHZpcnRxdWV1ZV9raWNrX3RyeSgpIHJldHVybnMgdHJ1ZSBvbmx5IHdoZW4gdGhl
Cj4ga2ljayBpcyBzdWNjZXNzZnVsLiBJbiB2aXJ0aW8tbmV0LCB3ZSB3YW50IHRvIGNvdW50IHRo
ZSBudW1iZXIgb2Yga2lja3MuCj4gU28gd2UgbmVlZCBhbiBpbnRlcmZhY2UgdGhhdCBjYW4gcGVy
Y2VpdmUgd2hldGhlciB0aGUga2ljayBpcyBhY3R1YWxseQo+IGV4ZWN1dGVkLgo+Cj4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1i
eTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKCj4gLS0tCj4gICBk
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgICAgIHwgIDggKysrKy0tLS0KPiAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgfCAyMCArKysrKysrKysrKysrKysrKysrKwo+ICAgaW5jbHVkZS9s
aW51eC92aXJ0aW8uaCAgICAgICB8ICAyICsrCj4gICAzIGZpbGVzIGNoYW5nZWQsIDI2IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggOWI2YTRhODc1YzU1
Li4xNjc2OTcwMzBjYjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4g
KysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTYxNyw3ICs2MTcsNyBAQCBzdGF0
aWMgaW50IHZpcnRuZXRfeGRwX3htaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAlyZXQg
PSBueG1pdDsKPiAgIAo+ICAgCWlmIChmbGFncyAmIFhEUF9YTUlUX0ZMVVNIKSB7Cj4gLQkJaWYg
KHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUoc3EtPnZxKSAmJiB2aXJ0cXVldWVfbm90aWZ5KHNxLT52
cSkpCj4gKwkJaWYgKHZpcnRxdWV1ZV9raWNrX3RyeShzcS0+dnEpKQo+ICAgCQkJa2lja3MgPSAx
Owo+ICAgCX0KPiAgIG91dDoKPiBAQCAtMTMyNSw3ICsxMzI1LDcgQEAgc3RhdGljIGJvb2wgdHJ5
X2ZpbGxfcmVjdihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgc3RydWN0IHJlY2VpdmVfcXVldWUg
KnJxLAo+ICAgCQlpZiAoZXJyKQo+ICAgCQkJYnJlYWs7Cj4gICAJfSB3aGlsZSAocnEtPnZxLT5u
dW1fZnJlZSk7Cj4gLQlpZiAodmlydHF1ZXVlX2tpY2tfcHJlcGFyZShycS0+dnEpICYmIHZpcnRx
dWV1ZV9ub3RpZnkocnEtPnZxKSkgewo+ICsJaWYgKHZpcnRxdWV1ZV9raWNrX3RyeShycS0+dnEp
KSB7Cj4gICAJCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gICAKPiAgIAkJZmxhZ3MgPSB1NjRfc3Rh
dHNfdXBkYXRlX2JlZ2luX2lycXNhdmUoJnJxLT5zdGF0cy5zeW5jcCk7Cj4gQEAgLTE1MzMsNyAr
MTUzMyw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFw
aSwgaW50IGJ1ZGdldCkKPiAgIAo+ICAgCWlmICh4ZHBfeG1pdCAmIFZJUlRJT19YRFBfVFgpIHsK
PiAgIAkJc3EgPSB2aXJ0bmV0X3hkcF9nZXRfc3EodmkpOwo+IC0JCWlmICh2aXJ0cXVldWVfa2lj
a19wcmVwYXJlKHNxLT52cSkgJiYgdmlydHF1ZXVlX25vdGlmeShzcS0+dnEpKSB7Cj4gKwkJaWYg
KHZpcnRxdWV1ZV9raWNrX3RyeShzcS0+dnEpKSB7Cj4gICAJCQl1NjRfc3RhdHNfdXBkYXRlX2Jl
Z2luKCZzcS0+c3RhdHMuc3luY3ApOwo+ICAgCQkJc3EtPnN0YXRzLmtpY2tzKys7Cj4gICAJCQl1
NjRfc3RhdHNfdXBkYXRlX2VuZCgmc3EtPnN0YXRzLnN5bmNwKTsKPiBAQCAtMTcxMCw3ICsxNzEw
LDcgQEAgc3RhdGljIG5ldGRldl90eF90IHN0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwg
c3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiAgIAl9Cj4gICAKPiAgIAlpZiAoa2ljayB8fCBuZXRp
Zl94bWl0X3N0b3BwZWQodHhxKSkgewo+IC0JCWlmICh2aXJ0cXVldWVfa2lja19wcmVwYXJlKHNx
LT52cSkgJiYgdmlydHF1ZXVlX25vdGlmeShzcS0+dnEpKSB7Cj4gKwkJaWYgKHZpcnRxdWV1ZV9r
aWNrX3RyeShzcS0+dnEpKSB7Cj4gICAJCQl1NjRfc3RhdHNfdXBkYXRlX2JlZ2luKCZzcS0+c3Rh
dHMuc3luY3ApOwo+ICAgCQkJc3EtPnN0YXRzLmtpY2tzKys7Cj4gICAJCQl1NjRfc3RhdHNfdXBk
YXRlX2VuZCgmc3EtPnN0YXRzLnN5bmNwKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCA3MWUx
NmI1M2U5YzEuLjE0NjJiZTc1Njg3NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0xODc0
LDYgKzE4NzQsMjYgQEAgYm9vbCB2aXJ0cXVldWVfa2ljayhzdHJ1Y3QgdmlydHF1ZXVlICp2cSkK
PiAgIH0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9raWNrKTsKPiAgIAo+ICsvKioK
PiArICogdmlydHF1ZXVlX2tpY2tfdHJ5IC0gdHJ5IHVwZGF0ZSBhZnRlciBhZGRfYnVmCj4gKyAq
IEB2cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUKPiArICoKPiArICogQWZ0ZXIgb25lIG9yIG1vcmUg
dmlydHF1ZXVlX2FkZF8qIGNhbGxzLCBpbnZva2UgdGhpcyB0byBraWNrCj4gKyAqIHRoZSBvdGhl
ciBzaWRlLgo+ICsgKgo+ICsgKiBDYWxsZXIgbXVzdCBlbnN1cmUgd2UgZG9uJ3QgY2FsbCB0aGlz
IHdpdGggb3RoZXIgdmlydHF1ZXVlCj4gKyAqIG9wZXJhdGlvbnMgYXQgdGhlIHNhbWUgdGltZSAo
ZXhjZXB0IHdoZXJlIG5vdGVkKS4KPiArICoKPiArICogUmV0dXJucyB0cnVlIGlmIGtpY2sgc3Vj
Y2Vzcywgb3RoZXJ3aXNlIGZhbHNlLgo+ICsgKi8KPiArYm9vbCB2aXJ0cXVldWVfa2lja190cnko
c3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCWlmICh2aXJ0cXVldWVfa2lja19wcmVwYXJl
KHZxKSAmJiB2aXJ0cXVldWVfbm90aWZ5KHZxKSkKPiArCQlyZXR1cm4gdHJ1ZTsKPiArCXJldHVy
biBmYWxzZTsKPiArfQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfa2lja190cnkpOwo+
ICsKPiAgIC8qKgo+ICAgICogdmlydHF1ZXVlX2dldF9idWYgLSBnZXQgdGhlIG5leHQgdXNlZCBi
dWZmZXIKPiAgICAqIEBfdnE6IHRoZSBzdHJ1Y3QgdmlydHF1ZXVlIHdlJ3JlIHRhbGtpbmcgYWJv
dXQuCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xpbnV4
L3ZpcnRpby5oCj4gaW5kZXggYjE4OTRlMDMyM2ZhLi40NWNkNmEwYWYyNGQgMTAwNjQ0Cj4gLS0t
IGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgK
PiBAQCAtNTksNiArNTksOCBAQCBpbnQgdmlydHF1ZXVlX2FkZF9zZ3Moc3RydWN0IHZpcnRxdWV1
ZSAqdnEsCj4gICAKPiAgIGJvb2wgdmlydHF1ZXVlX2tpY2soc3RydWN0IHZpcnRxdWV1ZSAqdnEp
Owo+ICAgCj4gK2Jvb2wgdmlydHF1ZXVlX2tpY2tfdHJ5KHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsK
PiArCj4gICBib29sIHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUoc3RydWN0IHZpcnRxdWV1ZSAqdnEp
Owo+ICAgCj4gICBib29sIHZpcnRxdWV1ZV9ub3RpZnkoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
