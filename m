Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DBFC433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:49:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5975464D9C
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5975464D9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0894883DA4;
	Tue,  2 Mar 2021 06:49:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zoqn0fIPY34O; Tue,  2 Mar 2021 06:49:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A21AF83D9D;
	Tue,  2 Mar 2021 06:49:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88C64C000B;
	Tue,  2 Mar 2021 06:49:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8417C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A51314EC8E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SsUCqZen0pzv
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:49:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5960D4EC21
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614667768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWsCopsWZPSi41ULNKjBHGlcw6/zU4zCo27Dtmkuins=;
 b=gFzzFvJGdJNYUbQzIEU1xHQPfx+4nWnZKiPR7U5a7kxQGf1+gQRaRGnKOl3WHnrGQf9A3r
 f9CXW6iVhkR8T9ArsyRQcO9ewFdxWv6BUuMhConYz83d9jjqqgYeYiC6jdqZoBnY9Ep1Iy
 QIPacw6NJ/C0dzew5z81E6OW/HyW/Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-uM0QVBUqN-K3HXizDZDIIw-1; Tue, 02 Mar 2021 01:49:24 -0500
X-MC-Unique: uM0QVBUqN-K3HXizDZDIIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52E481005501;
 Tue,  2 Mar 2021 06:49:22 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-133.pek2.redhat.com
 [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD1645D71F;
 Tue,  2 Mar 2021 06:49:10 +0000 (UTC)
Subject: Re: [RFC v4 03/11] vhost-iotlb: Add an opaque pointer for vhost IOTLB
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <41c12b5a-d46c-2b80-d553-82efc3f94147@redhat.com>
Date: Tue, 2 Mar 2021 14:49:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210223115048.435-4-xieyongji@bytedance.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Ck9uIDIwMjEvMi8yMyA3OjUwIOS4i+WNiCwgWGllIFlvbmdqaSB3cm90ZToKPiBBZGQgYW4gb3Bh
cXVlIHBvaW50ZXIgZm9yIHZob3N0IElPVExCLiBBbmQgaW50cm9kdWNlCj4gdmhvc3RfaW90bGJf
YWRkX3JhbmdlX2N0eCgpIHRvIGFjY2VwdCBpdC4KPgo+IFN1Z2dlc3RlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5
b25namlAYnl0ZWRhbmNlLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC9pb3RsYi5jICAgICAgIHwgMjAgKysr
KysrKysrKysrKysrKy0tLS0KPiAgIGluY2x1ZGUvbGludXgvdmhvc3RfaW90bGIuaCB8ICAzICsr
Kwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvaW90bGIuYyBiL2RyaXZlcnMvdmhvc3QvaW90
bGIuYwo+IGluZGV4IDBmZDNmODdlOTEzYy4uNWM5OWUxMTEyY2JiIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmhvc3QvaW90bGIuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvaW90bGIuYwo+IEBAIC0z
NiwxOSArMzYsMjEgQEAgdm9pZCB2aG9zdF9pb3RsYl9tYXBfZnJlZShzdHJ1Y3Qgdmhvc3RfaW90
bGIgKmlvdGxiLAo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodmhvc3RfaW90bGJfbWFwX2ZyZWUpOwo+
ICAgCj4gICAvKioKPiAtICogdmhvc3RfaW90bGJfYWRkX3JhbmdlIC0gYWRkIGEgbmV3IHJhbmdl
IHRvIHZob3N0IElPVExCCj4gKyAqIHZob3N0X2lvdGxiX2FkZF9yYW5nZV9jdHggLSBhZGQgYSBu
ZXcgcmFuZ2UgdG8gdmhvc3QgSU9UTEIKPiAgICAqIEBpb3RsYjogdGhlIElPVExCCj4gICAgKiBA
c3RhcnQ6IHN0YXJ0IG9mIHRoZSBJT1ZBIHJhbmdlCj4gICAgKiBAbGFzdDogbGFzdCBvZiBJT1ZB
IHJhbmdlCj4gICAgKiBAYWRkcjogdGhlIGFkZHJlc3MgdGhhdCBpcyBtYXBwZWQgdG8gQHN0YXJ0
Cj4gICAgKiBAcGVybTogYWNjZXNzIHBlcm1pc3Npb24gb2YgdGhpcyByYW5nZQo+ICsgKiBAb3Bh
cXVlOiB0aGUgb3BhcXVlIHBvaW50ZXIgZm9yIHRoZSBuZXcgbWFwcGluZwo+ICAgICoKPiAgICAq
IFJldHVybnMgYW4gZXJyb3IgbGFzdCBpcyBzbWFsbGVyIHRoYW4gc3RhcnQgb3IgbWVtb3J5IGFs
bG9jYXRpb24KPiAgICAqIGZhaWxzCj4gICAgKi8KPiAtaW50IHZob3N0X2lvdGxiX2FkZF9yYW5n
ZShzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+IC0JCQkgIHU2NCBzdGFydCwgdTY0IGxhc3Qs
Cj4gLQkJCSAgdTY0IGFkZHIsIHVuc2lnbmVkIGludCBwZXJtKQo+ICtpbnQgdmhvc3RfaW90bGJf
YWRkX3JhbmdlX2N0eChzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+ICsJCQkgICAgICB1NjQg
c3RhcnQsIHU2NCBsYXN0LAo+ICsJCQkgICAgICB1NjQgYWRkciwgdW5zaWduZWQgaW50IHBlcm0s
Cj4gKwkJCSAgICAgIHZvaWQgKm9wYXF1ZSkKPiAgIHsKPiAgIAlzdHJ1Y3Qgdmhvc3RfaW90bGJf
bWFwICptYXA7Cj4gICAKPiBAQCAtNzEsNiArNzMsNyBAQCBpbnQgdmhvc3RfaW90bGJfYWRkX3Jh
bmdlKHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4gICAJbWFwLT5sYXN0ID0gbGFzdDsKPiAg
IAltYXAtPmFkZHIgPSBhZGRyOwo+ICAgCW1hcC0+cGVybSA9IHBlcm07Cj4gKwltYXAtPm9wYXF1
ZSA9IG9wYXF1ZTsKPiAgIAo+ICAgCWlvdGxiLT5ubWFwcysrOwo+ICAgCXZob3N0X2lvdGxiX2l0
cmVlX2luc2VydChtYXAsICZpb3RsYi0+cm9vdCk7Cj4gQEAgLTgwLDYgKzgzLDE1IEBAIGludCB2
aG9zdF9pb3RsYl9hZGRfcmFuZ2Uoc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKPiAgIAo+ICAg
CXJldHVybiAwOwo+ICAgfQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh2aG9zdF9pb3RsYl9hZGRfcmFu
Z2VfY3R4KTsKPiArCj4gK2ludCB2aG9zdF9pb3RsYl9hZGRfcmFuZ2Uoc3RydWN0IHZob3N0X2lv
dGxiICppb3RsYiwKPiArCQkJICB1NjQgc3RhcnQsIHU2NCBsYXN0LAo+ICsJCQkgIHU2NCBhZGRy
LCB1bnNpZ25lZCBpbnQgcGVybSkKPiArewo+ICsJcmV0dXJuIHZob3N0X2lvdGxiX2FkZF9yYW5n
ZV9jdHgoaW90bGIsIHN0YXJ0LCBsYXN0LAo+ICsJCQkJCSBhZGRyLCBwZXJtLCBOVUxMKTsKPiAr
fQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodmhvc3RfaW90bGJfYWRkX3JhbmdlKTsKPiAgIAo+ICAg
LyoqCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmhvc3RfaW90bGIuaCBiL2luY2x1ZGUv
bGludXgvdmhvc3RfaW90bGIuaAo+IGluZGV4IDZiMDliNzg2YTc2Mi4uMmQwZTJmNTJmOTM4IDEw
MDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmhvc3RfaW90bGIuaAo+ICsrKyBiL2luY2x1ZGUv
bGludXgvdmhvc3RfaW90bGIuaAo+IEBAIC0xNyw2ICsxNyw3IEBAIHN0cnVjdCB2aG9zdF9pb3Rs
Yl9tYXAgewo+ICAgCXUzMiBwZXJtOwo+ICAgCXUzMiBmbGFnc19wYWRkaW5nOwo+ICAgCXU2NCBf
X3N1YnRyZWVfbGFzdDsKPiArCXZvaWQgKm9wYXF1ZTsKPiAgIH07Cj4gICAKPiAgICNkZWZpbmUg
VkhPU1RfSU9UTEJfRkxBR19SRVRJUkUgMHgxCj4gQEAgLTI5LDYgKzMwLDggQEAgc3RydWN0IHZo
b3N0X2lvdGxiIHsKPiAgIAl1bnNpZ25lZCBpbnQgZmxhZ3M7Cj4gICB9Owo+ICAgCj4gK2ludCB2
aG9zdF9pb3RsYl9hZGRfcmFuZ2VfY3R4KHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsIHU2NCBz
dGFydCwgdTY0IGxhc3QsCj4gKwkJCSAgICAgIHU2NCBhZGRyLCB1bnNpZ25lZCBpbnQgcGVybSwg
dm9pZCAqb3BhcXVlKTsKPiAgIGludCB2aG9zdF9pb3RsYl9hZGRfcmFuZ2Uoc3RydWN0IHZob3N0
X2lvdGxiICppb3RsYiwgdTY0IHN0YXJ0LCB1NjQgbGFzdCwKPiAgIAkJCSAgdTY0IGFkZHIsIHVu
c2lnbmVkIGludCBwZXJtKTsKPiAgIHZvaWQgdmhvc3RfaW90bGJfZGVsX3JhbmdlKHN0cnVjdCB2
aG9zdF9pb3RsYiAqaW90bGIsIHU2NCBzdGFydCwgdTY0IGxhc3QpOwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
