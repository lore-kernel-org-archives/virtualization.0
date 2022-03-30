Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0F7C433FE
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 03:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6937F41B97;
	Wed, 30 Mar 2022 03:48:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iGdDTmy0kQce; Wed, 30 Mar 2022 03:48:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9EC6D41B8E;
	Wed, 30 Mar 2022 03:48:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EEEFC002C;
	Wed, 30 Mar 2022 03:48:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FC3CC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 03:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EF9741B8E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 03:48:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F2wtxo8oVXSL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 03:48:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81BA840358
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 03:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648612124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FZL18oa0/kDEGHce7+84EJ8QLiWPMRn2+Um5bP62fMA=;
 b=QDMuf1G2Xk6UShOqU5bskg37/FbFJRKmdWndPR1eg3WxelvJh+qeldn/fECUj6SJHCaylP
 CBgdhVUpwPf47iuZdegQy1TU8hpJshaOfDWL36HdpqrYSQKx7YKHICRqW1zzrnIyCAde7E
 4dRhdpDODwKbB+GzquT2sOBRNtW/Oho=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-9U2xD5NrOteDfN9d-14nQw-1; Tue, 29 Mar 2022 23:48:43 -0400
X-MC-Unique: 9U2xD5NrOteDfN9d-14nQw-1
Received: by mail-pf1-f200.google.com with SMTP id
 k69-20020a628448000000b004fd8affa86aso1774758pfd.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 20:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=FZL18oa0/kDEGHce7+84EJ8QLiWPMRn2+Um5bP62fMA=;
 b=lJC3UYYWUR0ZVbpAK7OeHnM0cTd9l2y90pGaLQXDwHIXhtFNUQvJ7dGAbSFvR9GUYn
 yFvKSRiOQ5MheaSqe8Ft6QNsqEG1y+qsch+raq9U3AZeqFtbP1nNnNmqsFg7JgZPe3O/
 ZnLWHkWzXvt2aSe5f+9pYpsAQ7qwv2eejjcOCZ31LZthoJ3M9f9YYF5ggXrVaAbaBu59
 dfrYZ2Eazv680oWcaWp2SnGMS/8DLRV8LhcmYu1i57pjhFl1pHdI3KWVyNCMDgF5k5Pd
 p5XVJy7MVpXMASERUsQqjICiUfP/T9Q/Z7/Lyuzw6wikzSSSHwHluKjCb6x5sW9DIcfk
 DwHg==
X-Gm-Message-State: AOAM531iV5ZyWqfQ0cQLh1prpjgXcwg8k4xbgWLydtPfiMeNLJWa0RsD
 WIs5sfAxzQKy/DSbtvDTBe5dZlAnFYfN7EJhhk4SydwbDP64Ns0E2VUf0t91WVQTjimZyP+xtbS
 tyx4awFNwb41U3Px35Jt0LNg8uyKFmbJwcFw3jh0YZg==
X-Received: by 2002:a17:90b:2502:b0:1c6:d783:6e76 with SMTP id
 ns2-20020a17090b250200b001c6d7836e76mr2724244pjb.158.1648612120791; 
 Tue, 29 Mar 2022 20:48:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywLwCkROOTxLNNcnQAH2iBqtUPnhu9ydUUtIUlxUBIyEerEA+D2xFTESDGdOgP068zU2sG3g==
X-Received: by 2002:a17:90b:2502:b0:1c6:d783:6e76 with SMTP id
 ns2-20020a17090b250200b001c6d7836e76mr2724217pjb.158.1648612120410; 
 Tue, 29 Mar 2022 20:48:40 -0700 (PDT)
Received: from [10.72.14.7] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 fy9-20020a17090b020900b001c690bc05c4sm4366409pjb.0.2022.03.29.20.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Mar 2022 20:48:39 -0700 (PDT)
Message-ID: <53a42ba3-8111-dd14-40d4-1c1ae077268a@redhat.com>
Date: Wed, 30 Mar 2022 11:48:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v8 10/16] virtio_ring: split: implement
 virtqueue_resize_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-11-xuanzhuo@linux.alibaba.com>
 <a75ecf24-6d00-b790-4da8-602205381b1d@redhat.com>
 <1648111444.337551-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1648111444.337551-4-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzMvMjQg5LiL5Y2INDo0NCwgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBUdWUsIDIy
IE1hciAyMDIyIDE0OjMwOjI5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4g5ZyoIDIwMjIvMy8xNCDkuIvljYg1OjM0LCBYdWFuIFpodW8g5YaZ6YGTOgo+
Pj4gdmlydGlvIHJpbmcgc3BsaXQgc3VwcG9ydHMgcmVzaXplLgo+Pj4KPj4+IE9ubHkgYWZ0ZXIg
dGhlIG5ldyB2cmluZyBpcyBzdWNjZXNzZnVsbHkgYWxsb2NhdGVkIGJhc2VkIG9uIHRoZSBuZXcg
bnVtLAo+Pj4gd2Ugd2lsbCByZWxlYXNlIHRoZSBvbGQgdnJpbmcuIEluIGFueSBjYXNlLCBhbiBl
cnJvciBpcyByZXR1cm5lZCwKPj4+IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3RpbGwgcG9p
bnRzIHRvIHRoZSBvbGQgdnJpbmcuIEluIHRoZSBjYXNlIG9mCj4+PiBhbiBlcnJvciwgd2Ugd2ls
bCByZS1pbml0aWFsaXplIHRoZSBzdGF0ZSBvZiB0aGUgdnJpbmcgdG8gZW5zdXJlIHRoYXQKPj4+
IHRoZSB2cmluZyBjYW4gYmUgdXNlZC4KPj4+Cj4+PiBJbiBhZGRpdGlvbiwgdnJpbmdfYWxpZ24s
IG1heV9yZWR1Y2VfbnVtIGFyZSBuZWNlc3NhcnkgZm9yIHJlYWxsb2NhdGluZwo+Pj4gdnJpbmcs
IHNvIHRoZXkgYXJlIHJldGFpbmVkIGZvciBjcmVhdGluZyB2cS4KPj4+Cj4+PiBTaWduZWQtb2Zm
LWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4gLS0tCj4+PiAg
ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNjIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKQo+
Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+Pj4gaW5kZXggODFiYmZkNjU0MTFlLi5hMTU4Njk1MTQx
NDYgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+PiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+PiBAQCAtMTM5LDYgKzEzOSwxMiBAQCBz
dHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsKPj4+ICAgIAkJCS8qIERNQSBhZGRyZXNzIGFuZCBzaXpl
IGluZm9ybWF0aW9uICovCj4+PiAgICAJCQlkbWFfYWRkcl90IHF1ZXVlX2RtYV9hZGRyOwo+Pj4g
ICAgCQkJc2l6ZV90IHF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4+PiArCj4+PiArCQkJLyogVGhlIHBh
cmFtZXRlcnMgZm9yIGNyZWF0aW5nIHZyaW5ncyBhcmUgcmVzZXJ2ZWQgZm9yCj4+PiArCQkJICog
Y3JlYXRpbmcgbmV3IHZyaW5ncyB3aGVuIGVuYWJsaW5nIHJlc2V0IHF1ZXVlLgo+Pj4gKwkJCSAq
Lwo+Pj4gKwkJCXUzMiB2cmluZ19hbGlnbjsKPj4+ICsJCQlib29sIG1heV9yZWR1Y2VfbnVtOwo+
Pj4gICAgCQl9IHNwbGl0Owo+Pj4KPj4+ICAgIAkJLyogQXZhaWxhYmxlIGZvciBwYWNrZWQgcmlu
ZyAqLwo+Pj4gQEAgLTE5OCw2ICsyMDQsMTYgQEAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSB7Cj4+
PiAgICAjZW5kaWYKPj4+ICAgIH07Cj4+Pgo+Pj4gK3N0YXRpYyB2b2lkIF9fdnJpbmdfZnJlZShz
dHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+Pj4gK3N0YXRpYyB2b2lkIF9fdnJpbmdfdmlydHF1ZXVl
X2luaXRfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4+PiArCQkJCQkgc3RydWN0
IHZpcnRpb19kZXZpY2UgKnZkZXYpOwo+Pj4gK3N0YXRpYyB2b2lkIF9fdnJpbmdfdmlydHF1ZXVl
X2F0dGFjaF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPj4+ICsJCQkJCSAgIHN0
cnVjdCB2cmluZyB2cmluZywKPj4+ICsJCQkJCSAgIHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3Nw
bGl0ICpkZXNjX3N0YXRlLAo+Pj4gKwkJCQkJICAgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKmRl
c2NfZXh0cmEpOwo+Pj4gK3N0YXRpYyBpbnQgX192cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxp
dCh1MzIgbnVtLAo+Pj4gKwkJCQkJICAgc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQgKipk
ZXNjX3N0YXRlLAo+Pj4gKwkJCQkJICAgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKipkZXNjX2V4
dHJhKTsKPj4+Cj4+PiAgICAvKgo+Pj4gICAgICogSGVscGVycy4KPj4+IEBAIC05OTEsNiArMTAw
Nyw4IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3Nw
bGl0KAo+Pj4gICAgCQlyZXR1cm4gTlVMTDsKPj4+ICAgIAl9Cj4+Pgo+Pj4gKwl0b192dnEodnEp
LT5zcGxpdC52cmluZ19hbGlnbiA9IHZyaW5nX2FsaWduOwo+Pj4gKwl0b192dnEodnEpLT5zcGxp
dC5tYXlfcmVkdWNlX251bSA9IG1heV9yZWR1Y2VfbnVtOwo+Pj4gICAgCXRvX3Z2cSh2cSktPnNw
bGl0LnF1ZXVlX2RtYV9hZGRyID0gZG1hX2FkZHI7Cj4+PiAgICAJdG9fdnZxKHZxKS0+c3BsaXQu
cXVldWVfc2l6ZV9pbl9ieXRlcyA9IHF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4+PiAgICAJdG9fdnZx
KHZxKS0+d2Vfb3duX3JpbmcgPSB0cnVlOwo+Pj4gQEAgLTk5OCw2ICsxMDE2LDUwIEBAIHN0YXRp
YyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+Pj4gICAg
CXJldHVybiB2cTsKPj4+ICAgIH0KPj4+Cj4+PiArc3RhdGljIGludCB2aXJ0cXVldWVfcmVzaXpl
X3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwgdTMyIG51bSkKPj4+ICt7Cj4+PiArCXN0cnVj
dCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4+PiArCXN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2ID0gX3ZxLT52ZGV2Owo+Pj4gKwlzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9z
cGxpdCAqc3RhdGU7Cj4+PiArCXN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICpleHRyYTsKPj4+ICsJ
c2l6ZV90IHF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4+PiArCWRtYV9hZGRyX3QgZG1hX2FkZHI7Cj4+
PiArCXN0cnVjdCB2cmluZyB2cmluZzsKPj4+ICsJaW50IGVyciA9IC1FTk9NRU07Cj4+PiArCXZv
aWQgKnF1ZXVlOwo+Pj4gKwo+Pj4gKwlCVUdfT04oIXZxLT53ZV9vd25fcmluZyk7Cj4+Cj4+IEkg
ZG9uJ3Qgc2VlIGFueSBjaGVja3MgaW4gdmlydHF1ZXVlX3Jlc2l6ZSgpLiBTbyBJIHRoaW5rIGl0
J3MgYmV0dGVyIHRvCj4+IGVpdGhlcgo+Pgo+PiAxKSByZXR1cm4gLUVJTlZBTCBoZXJlCj4+Cj4+
IG9yCj4+Cj4+IDIpIGFkZCBhIGNoZWNrIGluIHZpcnRxdWV1ZV9yZXNpemUgYW5kIGZhaWwgdGhl
cmUKPj4KPj4KPj4+ICsKPj4+ICsJcXVldWUgPSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCh2ZGV2
LCAmZG1hX2FkZHIsICZudW0sCj4+PiArCQkJCQl2cS0+c3BsaXQudnJpbmdfYWxpZ24sCj4+PiAr
CQkJCQl2cS0+d2Vha19iYXJyaWVycywKPj4+ICsJCQkJCXZxLT5zcGxpdC5tYXlfcmVkdWNlX251
bSk7Cj4+PiArCWlmICghcXVldWUpCj4+PiArCQlnb3RvIGluaXQ7Cj4+PiArCj4+PiArCXF1ZXVl
X3NpemVfaW5fYnl0ZXMgPSB2cmluZ19zaXplKG51bSwgdnEtPnNwbGl0LnZyaW5nX2FsaWduKTsK
Pj4+ICsKPj4+ICsJZXJyID0gX192cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdChudW0sICZz
dGF0ZSwgJmV4dHJhKTsKPj4+ICsJaWYgKGVycikgewo+Pj4gKwkJdnJpbmdfZnJlZV9xdWV1ZSh2
ZGV2LCBxdWV1ZV9zaXplX2luX2J5dGVzLCBxdWV1ZSwgZG1hX2FkZHIpOwo+Pj4gKwkJZ290byBp
bml0Owo+Pj4gKwl9Cj4+PiArCj4+PiArCV9fdnJpbmdfZnJlZSgmdnEtPnZxKTsKPj4+ICsKPj4+
ICsJdnJpbmdfaW5pdCgmdnJpbmcsIG51bSwgcXVldWUsIHZxLT5zcGxpdC52cmluZ19hbGlnbik7
Cj4+PiArCV9fdnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9zcGxpdCh2cSwgdnJpbmcsIHN0YXRlLCBl
eHRyYSk7Cj4+Cj4+IEkgd29uZGVyIGlmIHdlIG5lZWQgYSBzeW1tZXRyaWMgdmlydHF1ZXVlX3Jl
c2l6ZV9kZXRhY2goKSBpbnRlcm5hbCBoZWxwZXIuCj4gSSB0aGluayBfX3ZyaW5nX2ZyZWUoKSBp
cyBzb21ld2hhdCBzaW1pbGFyIHRvIHdoYXQgeW91IHNhaWQgYWJvdXQKPiB2aXJ0cXVldWVfcmVz
aXplX2RldGFjaCgpIC4KCgpTbyBmcm9tIHdoYXQgSSdtIHVuZGVyc3RhbmRpbmcgdGhlIGNvZGUs
IHRoZSBrZXkgcG9pbnQgZm9yIGF0dGFjaGluZyBpczoKCiDCoMKgwqDCoMKgwqDCoCB2cS0+c3Bs
aXQudnJpbmcgPSB2cmluZzsKCkJ1dCB0aGlzIGlzIG5vdCB3aGF0IF9fdnJpbmdfZnJlZSgpIGRp
ZCwgaXQganVzdCBmcmVlIHRoZSByZXNvdXJjZXMuCgoKPgo+Pgo+Pj4gKwl2cS0+c3BsaXQucXVl
dWVfZG1hX2FkZHIgPSBkbWFfYWRkcjsKPj4+ICsJdnEtPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0
ZXMgPSBxdWV1ZV9zaXplX2luX2J5dGVzOwo+Pj4gKwo+Pj4gKwllcnIgPSAwOwo+Pj4gKwo+Pj4g
K2luaXQ6Cj4+PiArCV9fdnJpbmdfdmlydHF1ZXVlX2luaXRfc3BsaXQodnEsIHZkZXYpOwo+Pj4g
Kwl2cS0+d2Vfb3duX3JpbmcgPSB0cnVlOwo+Pgo+PiBUaGVuIHdlIGNhbiBsZWF2ZSB0aGlzIHVu
Y2hhbmdlZC4KPiBJIHRoaW5rIHlvdSBtZWFuICJ2cS0+d2Vfb3duX3JpbmcgPSB0cnVlIjsKPgo+
IFRoZSByZWFzb24gZm9yIG1vZGlmeWluZyB3ZV9vd25fcmluZyBhbG9uZSBpcyB0aGF0IGluIHRo
ZSBnZW5lcmFsIHByb2Nlc3Mgb2YKPiBjcmVhdGluZyBhIHJpbmcsIF9fdnJpbmdfdmlydHF1ZXVl
X2luaXRfc3BsaXQgaXMgY2FsbGVkIGluCj4gX192cmluZ19uZXdfdmlydHF1ZXVlLiBBdCB0aGlz
IHRpbWUsIHdlX293bl9yaW5nIGlzIGZhbHNlLgo+IHZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3Bs
aXQgd2lsbCBjaGFuZ2UgaXQgdG8gdHJ1ZS4gU28gYWZ0ZXIgY2FsbGluZwo+IF9fdnJpbmdfdmly
dHF1ZXVlX2luaXRfc3BsaXQgYWxvbmUsIHdlX293bl9yaW5nIGlzIGZhbHNlLgo+Cj4gSSB0aGlu
ayBpdCdzIHBvc3NpYmxlIHRvIHdyYXAgX192cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdCgpIGFn
YWluCj4KPiBzdGF0aWMgdm9pZCB2cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdChzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlICp2cSwKPiAJCQkJCSBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiB7
Cj4gCV9fdnJpbmdfdmlydHF1ZXVlX2luaXRfc3BsaXQodnEsIHZkZXYpOwo+IAl2cS0+d2Vfb3du
X3JpbmcgPSB0cnVlOwo+IH0KPgo+IElzIHRoaXMgd2hhdCB5b3Ugd2FudD8KCgpOb3BlLCBJIG1l
YW50IHRoZXJlIGFyZSBzb21lIHRyYW5zcG9ydHMgdGhhdCBhbGxvY2F0ZSB0aGUgdnJpbmcgYnkg
CnRoZW1zZWx2ZXMsIHdlIGNhbid0IHJlc2l6ZSB0aG9zZSB2cmluZy4KClNlZSB0aGUgY2FsbGVy
cyBvZiB2cmluZ19uZXdfdmlydHF1ZXVlKCkKClRoYW5rcwoKCj4KPiBUaGFua3MuCj4KPgo+PiBU
aGFua3MKPj4KPj4KPj4+ICsJcmV0dXJuIGVycjsKPj4+ICt9Cj4+PiArCj4+Pgo+Pj4gICAgLyoK
Pj4+ICAgICAqIFBhY2tlZCByaW5nIHNwZWNpZmljIGZ1bmN0aW9ucyAtICpfcGFja2VkKCkuCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
