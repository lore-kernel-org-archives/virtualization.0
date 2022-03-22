Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D256CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 06:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 736AE84378;
	Tue, 22 Mar 2022 06:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZPZ30bv6N8h3; Tue, 22 Mar 2022 06:41:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C6EA284388;
	Tue, 22 Mar 2022 06:41:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96A27C001A;
	Tue, 22 Mar 2022 06:41:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F68DC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:41:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 767A5611C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:41:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 564ak6tGXbma
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:41:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0297760E39
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647931263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2RhvcmubXKeiA2kcomFz9DaJ/to1HpCIF/qDQN8nHEg=;
 b=TgDhFBsIoMb+HPIsn2tT2gUp5iB+esG52jJXPzJT2jKVV2AibwvvwhpCB29Xv+8UFhB8jy
 xUgwaaBfsi3C4HLzCFtQ6rDdr/FCmcosCh1YzqBIIxW+ioX5EpjRWqAU81PDjlHKTLnS25
 7DDcMzVzRydDMPKVOIbAa6KLCcpO3b8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-xHdnexY8PQOses6-vVUUVw-1; Tue, 22 Mar 2022 02:41:00 -0400
X-MC-Unique: xHdnexY8PQOses6-vVUUVw-1
Received: by mail-pg1-f198.google.com with SMTP id
 b18-20020a63d812000000b0037e1aa59c0bso8353247pgh.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 23:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2RhvcmubXKeiA2kcomFz9DaJ/to1HpCIF/qDQN8nHEg=;
 b=SD9usar6H9YnYNaam/2IfZ5KgghRYzeOqOYQOsC/tRyZE5DyvEs9GUFLWgJltgB6d/
 OSyhAveyYifxi2i1+rY/ol0piCuFin1Qt/KpNbFVbZ7o++itBCe8KpOEqi93P/VfE+pm
 JpCQBCh94nrPgfE5NejvnmNO3hItq4NiK55lB4UwpFoNu/ML2sWbocyOcLzS/NtMuX3/
 qGN1lU4MVJO/k0X89ry+V0lxvSbfIE3aWmO5h7vqPbEFN9yGVlxXVsPY2T4MxtU5bjj1
 yRjp2iJxtfBLzCF+Z6xhU8OVs68eoUvDEZkiZdyLs2FYS0xYcZgY/SnLJ17uCgR3FFY7
 NzGA==
X-Gm-Message-State: AOAM530otSqkjKfbybnKSAdIDFxiAz6rXGOmh+dK3w4l2gQW+ynCwN0d
 xoAl47sLlPiH2wSBijt1BOPZT660U4H0WfM+AYH4lbHLne2h1cf/4ydm6i81mxs0hv+Cb2BtwHu
 /GF1nt4Q70cRpXZzrTnKY3JbjA5F9SqGVinSc58QlKw==
X-Received: by 2002:a63:4b64:0:b0:382:800d:1529 with SMTP id
 k36-20020a634b64000000b00382800d1529mr7008788pgl.317.1647931259679; 
 Mon, 21 Mar 2022 23:40:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9yPqZjK8z5HvVdTom3A5et/U2rpskbkA51gWbPmSlWHUs5iEt+cdtyH95aW7hFNIGkM1iMw==
X-Received: by 2002:a63:4b64:0:b0:382:800d:1529 with SMTP id
 k36-20020a634b64000000b00382800d1529mr7008779pgl.317.1647931259422; 
 Mon, 21 Mar 2022 23:40:59 -0700 (PDT)
Received: from [10.72.13.61] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 j11-20020a056a00234b00b004f7463022absm21779433pfj.208.2022.03.21.23.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Mar 2022 23:40:58 -0700 (PDT)
Message-ID: <70194138-072d-ecec-7571-af893f22e52c@redhat.com>
Date: Tue, 22 Mar 2022 14:40:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v8 00/16] virtio pci support VIRTIO_F_RING_RESET (refactor
 vring)
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzMvMTQg5LiL5Y2INTozNCwgWHVhbiBaaHVvIOWGmemBkzoKPiBUaGUgdmlydGlv
IHNwZWMgYWxyZWFkeSBzdXBwb3J0cyB0aGUgdmlydGlvIHF1ZXVlIHJlc2V0IGZ1bmN0aW9uLiBU
aGlzIHBhdGNoIHNldAo+IGlzIHRvIGFkZCB0aGlzIGZ1bmN0aW9uIHRvIHRoZSBrZXJuZWwuIFRo
ZSByZWxldmFudCB2aXJ0aW8gc3BlYyBpbmZvcm1hdGlvbiBpcwo+IGhlcmU6Cj4KPiAgICAgIGh0
dHBzOi8vZ2l0aHViLmNvbS9vYXNpcy10Y3MvdmlydGlvLXNwZWMvaXNzdWVzLzEyNAo+Cj4gQWxz
byByZWdhcmRpbmcgTU1JTyBzdXBwb3J0IGZvciBxdWV1ZSByZXNldCwgSSBwbGFuIHRvIHN1cHBv
cnQgaXQgYWZ0ZXIgdGhpcwo+IHBhdGNoIGlzIHBhc3NlZC4KPgo+IFRoaXMgcGF0Y2ggc2V0IGlt
cGxlbWVudHMgdGhlIHJlZmFjdG9yaW5nIG9mIHZyaW5nLiBGaW5hbGx5LCB0aGUKPiB2aXJ0dXF1
ZV9yZXNpemUoKSBpbnRlcmZhY2UgaXMgcHJvdmlkZWQgYmFzZWQgb24gdGhlIHJlc2V0IGZ1bmN0
aW9uIG9mIHRoZQo+IHRyYW5zcG9ydCBsYXllci4KPgo+IFRlc3QgZW52aXJvbm1lbnQ6Cj4gICAg
ICBIb3N0OiA0LjE5LjkxCj4gICAgICBRZW11OiBRRU1VIGVtdWxhdG9yIHZlcnNpb24gNi4yLjUw
ICh3aXRoIHZxIHJlc2V0IHN1cHBvcnQpCgoKSXQgd291bGQgYmUgYmV0dGVyIGlmIHlvdSBjYW4g
cG9zdCBRZW11IGNvZGUgZm9yIHJldmlldyBhcyB3ZWxsLgoKCj4gICAgICBUZXN0IENtZDogIGV0
aHRvb2wgLUcgZXRoMSByeCAkMSB0eCAkMjsgZXRodG9vbCAtZyBldGgxCj4KPiAgICAgIFRoZSBk
ZWZhdWx0IGlzIHNwbGl0IG1vZGUsIG1vZGlmeSBRZW11IHZpcnRpby1uZXQgdG8gYWRkIFBBQ0tF
RCBmZWF0dXJlIHRvIHRlc3QKPiAgICAgIHBhY2tlZCBtb2RlLgo+Cj4gUGxlYXNlIHJldmlldy4g
VGhhbmtzLgoKCkxvb2tzIGdvb2Qgb3ZlcmFsbCwgc2VlIGNvbW1lbnRzIGluIGluZGl2aWR1YWwg
cGF0Y2guCgpJIHRoaW5rIHRoZSBjb2RlIGlzIHN0cnVjdHVyZWQgaW4gYSB3YXkgdGhhdCBpcyBu
b3QgZnJpZW5kbHkgdG8gdGhlIApyZXZpZXdlcnMuIEZvciBuZXh0IHZlcnNpb24sIHdlIGNhbiBi
cmluZyBiYWNrIHRoZSBldGh0b29sIC1HIGZvciAKdmlydGlvLW5ldC4KClRoYW5rcwoKCj4KPiB2
ODoKPiAgICAxLiBQcm92aWRlIGEgdmlydHF1ZXVlX3Jlc2V0KCkgaW50ZXJmYWNlIGRpcmVjdGx5
Cj4gICAgMi4gU3BsaXQgdGhlIHR3byBwYXRjaCBzZXRzLCB0aGlzIGlzIHRoZSBmaXJzdCBwYXJ0
Cj4gICAgMy4gQWRkIGluZGVwZW5kZW50IGFsbG9jYXRpb24gaGVscGVyIGZvciBhbGxvY2F0aW5n
IHN0YXRlLCBleHRyYQo+Cj4gdjc6Cj4gICAgMS4gZml4ICM2IHN1YmplY3QgdHlwbwo+ICAgIDIu
IGZpeCAjNiByaW5nX3NpemVfaW5fYnl0ZXMgaXMgdW5pbml0aWFsaXplZAo+ICAgIDMuIGNoZWNr
IGJ5OiBtYWtlIFc9MTIKPgo+IHY2Ogo+ICAgIDEuIHZpcnRpb19wY2k6IHVzZSBzeW5jaHJvbml6
ZV9pcnEoaXJxKSB0byBzeW5jIHRoZSBpcnEgY2FsbGJhY2tzCj4gICAgMi4gSW50cm9kdWNlIHZp
cnRxdWV1ZV9yZXNldF92cmluZygpIHRvIGltcGxlbWVudCB0aGUgcmVzZXQgb2YgdnJpbmcgZHVy
aW5nCj4gICAgICAgdGhlIHJlc2V0IHByb2Nlc3MuIE1heSB1c2UgdGhlIG9sZCB2cmluZyBpZiBu
dW0gb2YgdGhlIHZxIG5vdCBjaGFuZ2UuCj4gICAgMy4gZmluZF92cXMoKSBzdXBwb3J0IHNpemVz
IHRvIHNwZWNpYWwgdGhlIG1heCBzaXplIG9mIGVhY2ggdnEKPgo+IHY1Ogo+ICAgIDEuIGFkZCB2
aXJ0aW8tbmV0IHN1cHBvcnQgc2V0X3JpbmdwYXJhbQo+Cj4gdjQ6Cj4gICAgMS4ganVzdCB0aGUg
Y29kZSBvZiB2aXJ0aW8sIHdpdGhvdXQgdmlydGlvLW5ldAo+ICAgIDIuIFBlcmZvcm1pbmcgcmVz
ZXQgb24gYSBxdWV1ZSBpcyBkaXZpZGVkIGludG8gdGhlc2Ugc3RlcHM6Cj4gICAgICAxLiByZXNl
dF92cTogcmVzZXQgb25lIHZxCj4gICAgICAyLiByZWN5Y2xlIHRoZSBidWZmZXIgZnJvbSB2cSBi
eSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoKQo+ICAgICAgMy4gcmVsZWFzZSB0aGUgcmlu
ZyBvZiB0aGUgdnEgYnkgdnJpbmdfcmVsZWFzZV92aXJ0cXVldWUoKQo+ICAgICAgNC4gZW5hYmxl
X3Jlc2V0X3ZxOiByZS1lbmFibGUgdGhlIHJlc2V0IHF1ZXVlCj4gICAgMy4gU2ltcGxpZnkgdGhl
IHBhcmFtZXRlcnMgb2YgZW5hYmxlX3Jlc2V0X3ZxKCkKPiAgICA0LiBhZGQgY29udGFpbmVyIHN0
cnVjdHVyZXMgZm9yIHZpcnRpb19wY2lfY29tbW9uX2NmZwo+Cj4gdjM6Cj4gICAgMS4ga2VlcCB2
cSwgaXJxIHVucmVsZWFzZWQKPgo+IFh1YW4gWmh1byAoMTYpOgo+ICAgIHZpcnRpbzogYWRkIGhl
bHBlciB2aXJ0cXVldWVfZ2V0X3ZyaW5nX21heF9zaXplKCkKPiAgICB2aXJ0aW86IHN0cnVjdCB2
aXJ0aW9fY29uZmlnX29wcyBhZGQgY2FsbGJhY2tzIGZvciBxdWV1ZV9yZXNldAo+ICAgIHZpcnRp
b19yaW5nOiB1cGRhdGUgdGhlIGRvY3VtZW50IG9mIHRoZSB2aXJ0cXVldWVfZGV0YWNoX3VudXNl
ZF9idWYKPiAgICAgIGZvciBxdWV1ZSByZXNldAo+ICAgIHZpcnRpb19yaW5nOiByZW1vdmUgdGhl
IGFyZyB2cSBvZiB2cmluZ19hbGxvY19kZXNjX2V4dHJhKCkKPiAgICB2aXJ0aW9fcmluZzogZXh0
cmFjdCB0aGUgbG9naWMgb2YgZnJlZWluZyB2cmluZwo+ICAgIHZpcnRpb19yaW5nOiBzcGxpdDog
ZXh0cmFjdCB0aGUgbG9naWMgb2YgYWxsb2MgcXVldWUKPiAgICB2aXJ0aW9fcmluZzogc3BsaXQ6
IGV4dHJhY3QgdGhlIGxvZ2ljIG9mIGFsbG9jIHN0YXRlIGFuZCBleHRyYQo+ICAgIHZpcnRpb19y
aW5nOiBzcGxpdDogZXh0cmFjdCB0aGUgbG9naWMgb2YgYXR0YWNoIHZyaW5nCj4gICAgdmlydGlv
X3Jpbmc6IHNwbGl0OiBleHRyYWN0IHRoZSBsb2dpYyBvZiB2cSBpbml0Cj4gICAgdmlydGlvX3Jp
bmc6IHNwbGl0OiBpbXBsZW1lbnQgdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdCgpCj4gICAgdmlydGlv
X3Jpbmc6IHBhY2tlZDogZXh0cmFjdCB0aGUgbG9naWMgb2YgYWxsb2MgcXVldWUKPiAgICB2aXJ0
aW9fcmluZzogcGFja2VkOiBleHRyYWN0IHRoZSBsb2dpYyBvZiBhbGxvYyBzdGF0ZSBhbmQgZXh0
cmEKPiAgICB2aXJ0aW9fcmluZzogcGFja2VkOiBleHRyYWN0IHRoZSBsb2dpYyBvZiBhdHRhY2gg
dnJpbmcKPiAgICB2aXJ0aW9fcmluZzogcGFja2VkOiBleHRyYWN0IHRoZSBsb2dpYyBvZiB2cSBp
bml0Cj4gICAgdmlydGlvX3Jpbmc6IHBhY2tlZDogaW1wbGVtZW50IHZpcnRxdWV1ZV9yZXNpemVf
cGFja2VkKCkKPiAgICB2aXJ0aW9fcmluZzogaW50cm9kdWNlIHZpcnRxdWV1ZV9yZXNpemUoKQo+
Cj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jICAgICAgIHwgICAyICsKPiAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgfCAgIDIgKwo+ICAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9tb2Rlcm4uYyB8ICAgMiArCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jICAgICAgIHwgNjA0ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tCj4gICBpbmNsdWRl
L2xpbnV4L3ZpcnRpby5oICAgICAgICAgICAgIHwgICA1ICsKPiAgIGluY2x1ZGUvbGludXgvdmly
dGlvX2NvbmZpZy5oICAgICAgfCAgMTIgKwo+ICAgNiBmaWxlcyBjaGFuZ2VkLCA0OTQgaW5zZXJ0
aW9ucygrKSwgMTMzIGRlbGV0aW9ucygtKQo+Cj4gLS0KPiAyLjMxLjAKPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
