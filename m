Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915D4C433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 06:39:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103B164E6F
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 06:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103B164E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CB347847F9;
	Thu, 18 Feb 2021 06:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IkIA0KVjDJZa; Thu, 18 Feb 2021 06:39:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 64915847DE;
	Thu, 18 Feb 2021 06:39:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 493A2C000F;
	Thu, 18 Feb 2021 06:39:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A56EC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 965A7847F9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Wu1DU49ApgL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:39:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 16429847DE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613630365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/r6ZrTAwzUnNQ6cScq8XvsWgkFZQZGxH65h7veBqKs=;
 b=Z+eG3/CvEH73NtO7CqMSneBI0+B0JU+REYPWB+szI+dpYwzZedfu0hprMR7sSaHmKQ0St/
 0NWtIWpJwmHFqP4xloyru09TJtZk33etoxUOxGl+DJlg7IiK0jn1kso/4sZQh6nwGy6C8P
 t6mrK2h+oDgE/gF4zeRYqFalkY2XJTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-iyA5BtJkP3K3KF_hZhQTIw-1; Thu, 18 Feb 2021 01:39:23 -0500
X-MC-Unique: iyA5BtJkP3K3KF_hZhQTIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 252F180402E;
 Thu, 18 Feb 2021 06:39:22 +0000 (UTC)
Received: from [10.72.13.28] (ovpn-13-28.pek2.redhat.com [10.72.13.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34F6D177F8;
 Thu, 18 Feb 2021 06:39:16 +0000 (UTC)
Subject: Re: [PATCH for 5.10] vdpa_sim: fix param validation in
 vdpasim_get_config()
To: Stefano Garzarella <sgarzare@redhat.com>, stable@vger.kernel.org
References: <20210211162519.215418-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d5f8c1b7-9506-6a84-dbba-53bf21897e5f@redhat.com>
Date: Thu, 18 Feb 2021 14:39:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211162519.215418-1-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8xMiDkuIrljYgxMjoyNSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IENv
bW1pdCA2NWI3MDk1ODZlMjIyZmE2ZmZkNDE2NmFjN2ZkYjVkNWRhZDExM2VlIHVwc3RyZWFtLgo+
Cj4gQmVmb3JlIHRoaXMgcGF0Y2gsIGlmICdvZmZzZXQgKyBsZW4nIHdhcyBlcXVhbCB0bwo+IHNp
emVvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpLCB0aGUgZW50aXJlIGJ1ZmZlciB3YXNuJ3Qg
ZmlsbGVkLAo+IHJldHVybmluZyBpbmNvcnJlY3QgdmFsdWVzIHRvIHRoZSBjYWxsZXIuCj4KPiBT
aW5jZSAndmRwYXNpbS0+Y29uZmlnJyB0eXBlIGlzICdzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcn
LCB3ZSBjYW4KPiBzYWZlbHkgY29weSBpdHMgY29udGVudCB1bmRlciB0aGlzIGNvbmRpdGlvbi4K
Pgo+IENvbW1pdCA2NWI3MDk1ODZlMjIgKCJ2ZHBhX3NpbTogYWRkIGdldF9jb25maWcgY2FsbGJh
Y2sgaW4KPiB2ZHBhc2ltX2Rldl9hdHRyIikgdW5pbnRlbnRpb25hbGx5IHNvbHZlZCBpdCB1cHN0
cmVhbSB3aGlsZQo+IHJlZmFjdG9yaW5nIHZkcGFfc2ltLmMgdG8gc3VwcG9ydCBtdWx0aXBsZSBk
ZXZpY2VzLiBCdXQgd2UgZG9uJ3Qgd2FudAo+IHRvIGJhY2twb3J0IGl0IHRvIHN0YWJsZSBicmFu
Y2hlcyBhcyBpdCBjb250YWlucyBtYW55IGNoYW5nZXMuCj4KPiBGaXhlczogMmM1M2QwZjY0YzA2
ICgidmRwYXNpbTogdkRQQSBkZXZpY2Ugc2ltdWxhdG9yIikKPiBDYzogPHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmc+ICMgNS4xMC54Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxz
Z2FyemFyZUByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFf
c2ltLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBi
L2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gaW5kZXggNmE5MGZkYjljYmZjLi44
Y2ExNzhkN2IwMmYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IEBAIC01NzIsNyAr
NTcyLDcgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRwYSwgdW5zaWduZWQgaW50IG9mZnNldCwKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYXNpbSAq
dmRwYXNpbSA9IHZkcGFfdG9fc2ltKHZkcGEpOwo+ICAgCj4gLQlpZiAob2Zmc2V0ICsgbGVuIDwg
c2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZykpCj4gKwlpZiAob2Zmc2V0ICsgbGVuIDw9
IHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpKQo+ICAgCQltZW1jcHkoYnVmLCAodTgg
KikmdmRwYXNpbS0+Y29uZmlnICsgb2Zmc2V0LCBsZW4pOwo+ICAgfQo+ICAgCgoKQWNrZWQtYnk6
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
