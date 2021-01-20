Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF77FC433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:47:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388D8223E8
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388D8223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ADB0A85D95;
	Wed, 20 Jan 2021 03:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W9sPkjixcbkT; Wed, 20 Jan 2021 03:47:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 14B0C85D94;
	Wed, 20 Jan 2021 03:47:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2058C088B;
	Wed, 20 Jan 2021 03:47:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 762E6C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 62FB786763
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:47:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w-LWPDbFIVvS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:47:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AC9798677D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611114424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61kBWcJtmQFIvGjS1IKO0RhJ1LrkMQqyt5uWZQ6fQwI=;
 b=P4NHjfcSD8KOO5BQ95x1Yc1YI2hgOvjWQzpXnZ2f1SCvTFlgRW6xHkJa0GXsFetw2pshxB
 pjAZ3JdLhTqSf5zgeSV3YysFZZFPlZUI6MLWs9jxkYyMHK6KfDuGjp6ebfi9Pt/IsAiVmE
 dtWDKK6f2Uzh508m1VLwRXSF25sKZ2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-pTfqDSdGP9CR1YEzofLBAw-1; Tue, 19 Jan 2021 22:47:02 -0500
X-MC-Unique: pTfqDSdGP9CR1YEzofLBAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD934800D53;
 Wed, 20 Jan 2021 03:47:00 +0000 (UTC)
Received: from [10.72.13.124] (ovpn-13-124.pek2.redhat.com [10.72.13.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DB3E9CA0;
 Wed, 20 Jan 2021 03:46:39 +0000 (UTC)
Subject: Re: [RFC v3 03/11] vdpa: Remove the restriction that only supports
 virtio-net devices
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
Date: Wed, 20 Jan 2021 11:46:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119045920.447-4-xieyongji@bytedance.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMS8xOSDkuIvljYgxMjo1OSwgWGllIFlvbmdqaSB3cm90ZToKPiBXaXRoIFZEVVNF
LCB3ZSBzaG91bGQgYmUgYWJsZSB0byBzdXBwb3J0IGFsbCBraW5kcyBvZiB2aXJ0aW8gZGV2aWNl
cy4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29t
Pgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCAyOSArKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+IGluZGV4IDI5ZWQ0MTczZjA0ZS4uNDQ4YmU3ODc1YjZkIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBA
QCAtMjIsNiArMjIsNyBAQAo+ICAgI2luY2x1ZGUgPGxpbnV4L25vc3BlYy5oPgo+ICAgI2luY2x1
ZGUgPGxpbnV4L3Zob3N0Lmg+Cj4gICAjaW5jbHVkZSA8bGludXgvdmlydGlvX25ldC5oPgo+ICsj
aW5jbHVkZSA8bGludXgvdmlydGlvX2Jsay5oPgo+ICAgCj4gICAjaW5jbHVkZSAidmhvc3QuaCIK
PiAgIAo+IEBAIC0xODUsMjYgKzE4Niw2IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0
YXR1cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+ICAgCXJldHVy
biAwOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUo
c3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gLQkJCQkgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9jb25m
aWcgKmMpCj4gLXsKPiAtCWxvbmcgc2l6ZSA9IDA7Cj4gLQo+IC0Jc3dpdGNoICh2LT52aXJ0aW9f
aWQpIHsKPiAtCWNhc2UgVklSVElPX0lEX05FVDoKPiAtCQlzaXplID0gc2l6ZW9mKHN0cnVjdCB2
aXJ0aW9fbmV0X2NvbmZpZyk7Cj4gLQkJYnJlYWs7Cj4gLQl9Cj4gLQo+IC0JaWYgKGMtPmxlbiA9
PSAwKQo+IC0JCXJldHVybiAtRUlOVkFMOwo+IC0KPiAtCWlmIChjLT5sZW4gPiBzaXplIC0gYy0+
b2ZmKQo+IC0JCXJldHVybiAtRTJCSUc7Cj4gLQo+IC0JcmV0dXJuIDA7Cj4gLX0KCgpJIHRoaW5r
IHdlIHNob3VsZCB1c2UgYSBzZXBhcmF0ZSBwYXRjaCBmb3IgdGhpcy4KClRoYW5rcwoKCj4gLQo+
ICAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2aG9zdF92ZHBhICp2
LAo+ICAgCQkJCSAgc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnIF9fdXNlciAqYykKPiAgIHsKPiBA
QCAtMjE1LDcgKzE5Niw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1
Y3Qgdmhvc3RfdmRwYSAqdiwKPiAgIAo+ICAgCWlmIChjb3B5X2Zyb21fdXNlcigmY29uZmlnLCBj
LCBzaXplKSkKPiAgIAkJcmV0dXJuIC1FRkFVTFQ7Cj4gLQlpZiAodmhvc3RfdmRwYV9jb25maWdf
dmFsaWRhdGUodiwgJmNvbmZpZykpCj4gKwlpZiAoY29uZmlnLmxlbiA9PSAwKQo+ICAgCQlyZXR1
cm4gLUVJTlZBTDsKPiAgIAlidWYgPSBrdnphbGxvYyhjb25maWcubGVuLCBHRlBfS0VSTkVMKTsK
PiAgIAlpZiAoIWJ1ZikKPiBAQCAtMjQzLDcgKzIyNCw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3Zk
cGFfc2V0X2NvbmZpZyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAgIAo+ICAgCWlmIChjb3B5X2Zy
b21fdXNlcigmY29uZmlnLCBjLCBzaXplKSkKPiAgIAkJcmV0dXJuIC1FRkFVTFQ7Cj4gLQlpZiAo
dmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUodiwgJmNvbmZpZykpCj4gKwlpZiAoY29uZmlnLmxl
biA9PSAwKQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAlidWYgPSBrdnphbGxvYyhjb25maWcu
bGVuLCBHRlBfS0VSTkVMKTsKPiAgIAlpZiAoIWJ1ZikKPiBAQCAtMTAyNSwxMCArMTAwNiw2IEBA
IHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9iZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4g
ICAJaW50IG1pbm9yOwo+ICAgCWludCByOwo+ICAgCj4gLQkvKiBDdXJyZW50bHksIHdlIG9ubHkg
YWNjZXB0IHRoZSBuZXR3b3JrIGRldmljZXMuICovCj4gLQlpZiAob3BzLT5nZXRfZGV2aWNlX2lk
KHZkcGEpICE9IFZJUlRJT19JRF9ORVQpCj4gLQkJcmV0dXJuIC1FTk9UU1VQUDsKPiAtCj4gICAJ
diA9IGt6YWxsb2Moc2l6ZW9mKCp2KSwgR0ZQX0tFUk5FTCB8IF9fR0ZQX1JFVFJZX01BWUZBSUwp
Owo+ICAgCWlmICghdikKPiAgIAkJcmV0dXJuIC1FTk9NRU07CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
