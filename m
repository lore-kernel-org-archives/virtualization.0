Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB111C63777
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:20:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191D5206C1
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IN01u9rY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191D5206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C342D863AC;
	Mon, 30 Nov 2020 03:20:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 50Au9poESFSs; Mon, 30 Nov 2020 03:20:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3ACD0860C8;
	Mon, 30 Nov 2020 03:20:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A54DC163C;
	Mon, 30 Nov 2020 03:20:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F14ACC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DF9D486D7B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VtI0UxjDuOn8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:20:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A72F186D79
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606706441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02n+GAz8jVQazuCSdq+blVnMw+ge3tAwB9SJiGGhAsg=;
 b=IN01u9rYJ6GMn/Nkvd/LDY4PM6tFFZS1h2dh9oP5ZwEH+NdkKPTiQ9w64pzy9a2bt/ehpP
 dozVYu0XcsBYdnqniXEq0mgewCsOJlg6nrwfhUXnp6/gV8L9xbg+HrciorGQoaob0wrIZS
 kZXD/3Gwh5p1PxYBkuuX/zom5aG7Un0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-BgspEzxuNNmNQB5qCdeCfg-1; Sun, 29 Nov 2020 22:20:39 -0500
X-MC-Unique: BgspEzxuNNmNQB5qCdeCfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F7791E7EF;
 Mon, 30 Nov 2020 03:20:38 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42CCF189B6;
 Mon, 30 Nov 2020 03:20:26 +0000 (UTC)
Subject: Re: [PATCH v2 10/17] vdpa_sim: store parsed MAC address in a buffer
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-11-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <56441d58-df03-1e4c-4178-a10c7ba9a3e3@redhat.com>
Date: Mon, 30 Nov 2020 11:20:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-11-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBB
cyBwcmVwYXJhdGlvbiBmb3IgdGhlIG5leHQgcGF0Y2hlcywgd2Ugc3RvcmUgdGhlIE1BQyBhZGRy
ZXNzLAo+IHBhcnNlZCBkdXJpbmcgdGhlIHZkcGFzaW1fY3JlYXRlKCksIGluIGEgYnVmZmVyIHRo
YXQgd2lsbCBiZSB1c2VkCj4gdG8gZmlsbCAnY29uZmlnJyB0b2dldGhlciB3aXRoIG90aGVyIGNv
bmZpZ3VyYXRpb25zLgo+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
LmMgfCAxMCArKysrKysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9k
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IGluZGV4IGI4NGQ5YWNkMTMwYy4uOWYy
Y2EzYTc3MDI1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5j
Cj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBAQCAtMjksNiArMjks
OCBAQCBzdGF0aWMgY2hhciAqbWFjYWRkcjsKPiAgIG1vZHVsZV9wYXJhbShtYWNhZGRyLCBjaGFy
cCwgMCk7Cj4gICBNT0RVTEVfUEFSTV9ERVNDKG1hY2FkZHIsICJFdGhlcm5ldCBNQUMgYWRkcmVz
cyIpOwo+ICAgCj4gK3U4IG1hY2FkZHJfYnVmW0VUSF9BTEVOXTsKPiArCj4gICBzdHJ1Y3QgdmRw
YXNpbV92aXJ0cXVldWUgewo+ICAgCXN0cnVjdCB2cmluZ2ggdnJpbmc7Cj4gICAJc3RydWN0IHZy
aW5naF9raW92IGlvdjsKPiBAQCAtMzg2LDEzICszODgsMTMgQEAgc3RhdGljIHN0cnVjdCB2ZHBh
c2ltICp2ZHBhc2ltX2NyZWF0ZShzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciAqZGV2X2F0dHIpCj4g
ICAJCWdvdG8gZXJyX2lvbW11Owo+ICAgCj4gICAJaWYgKG1hY2FkZHIpIHsKPiAtCQltYWNfcHRv
bihtYWNhZGRyLCB2ZHBhc2ltLT5jb25maWcubWFjKTsKPiAtCQlpZiAoIWlzX3ZhbGlkX2V0aGVy
X2FkZHIodmRwYXNpbS0+Y29uZmlnLm1hYykpIHsKPiArCQltYWNfcHRvbihtYWNhZGRyLCBtYWNh
ZGRyX2J1Zik7Cj4gKwkJaWYgKCFpc192YWxpZF9ldGhlcl9hZGRyKG1hY2FkZHJfYnVmKSkgewo+
ICAgCQkJcmV0ID0gLUVBRERSTk9UQVZBSUw7Cj4gICAJCQlnb3RvIGVycl9pb21tdTsKPiAgIAkJ
fQo+ICAgCX0gZWxzZSB7Cj4gLQkJZXRoX3JhbmRvbV9hZGRyKHZkcGFzaW0tPmNvbmZpZy5tYWMp
Owo+ICsJCWV0aF9yYW5kb21fYWRkcihtYWNhZGRyX2J1Zik7Cj4gICAJfQo+ICAgCj4gICAJZm9y
IChpID0gMDsgaSA8IGRldl9hdHRyLT5udnFzOyBpKyspCj4gQEAgLTUyOCw2ICs1MzAsOCBAQCBz
dGF0aWMgaW50IHZkcGFzaW1fc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwg
dTY0IGZlYXR1cmVzKQo+ICAgCj4gICAJY29uZmlnLT5tdHUgPSBjcHVfdG9fdmRwYXNpbTE2KHZk
cGFzaW0sIDE1MDApOwo+ICAgCWNvbmZpZy0+c3RhdHVzID0gY3B1X3RvX3ZkcGFzaW0xNih2ZHBh
c2ltLCBWSVJUSU9fTkVUX1NfTElOS19VUCk7Cj4gKwltZW1jcHkoY29uZmlnLT5tYWMsIG1hY2Fk
ZHJfYnVmLCBFVEhfQUxFTik7Cj4gKwo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
