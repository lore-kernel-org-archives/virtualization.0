Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1BBC433F5
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 12:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BAB2F4040D;
	Mon, 17 Jan 2022 12:38:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cvcoq5JD25Mw; Mon, 17 Jan 2022 12:38:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 305EF4019B;
	Mon, 17 Jan 2022 12:38:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 026FDC0031;
	Mon, 17 Jan 2022 12:38:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69F69C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 12:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 664094021B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 12:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BCsnNbrTmnDV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 12:38:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B751D4020B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 12:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642423132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqTVwBDvJkQkrgOjBOFOxTMhFtDY5gU77SJrn6Io5D8=;
 b=cGJtdDSeRoAya3wIzapLiDPUL49J32lLlfy8YkYf+Gw0rWPsMSUbEbaydLqBaloM+6O98A
 CBNGYdbX3p/Leb1jJMU/OpsLPEDAZVCvVkW2bQxRYH3hF+5b7PxgruubNif4x4+vEVKw2K
 OAl08QHpPnF9rGEb27uJJJRmJUYWpEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-QJzUXAueNpm3biCdYaoZbw-1; Mon, 17 Jan 2022 07:38:49 -0500
X-MC-Unique: QJzUXAueNpm3biCdYaoZbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5010E1083F6B;
 Mon, 17 Jan 2022 12:38:48 +0000 (UTC)
Received: from localhost (unknown [10.39.194.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0A3974EB5;
 Mon, 17 Jan 2022 12:38:43 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: acknowledge all features before access
In-Reply-To: <20220117032429-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220114200744.150325-1-mst@redhat.com>
 <d6c4e521-1538-bbbf-30e6-f658a095b3ae@redhat.com>
 <20220117032429-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Mon, 17 Jan 2022 13:38:42 +0100
Message-ID: <87mtjuv8od.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBKYW4gMTcgMjAyMiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29t
PiB3cm90ZToKCj4gT24gTW9uLCBKYW4gMTcsIDIwMjIgYXQgMDI6MzE6NDlQTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPj4gCj4+IOWcqCAyMDIyLzEvMTUg5LiK5Y2INDowOSwgTWljaGFlbCBT
LiBUc2lya2luIOWGmemBkzoKPj4gPiBAQCAtNDk1LDYgKzQ5NCwxMCBAQCBpbnQgdmlydGlvX2Rl
dmljZV9yZXN0b3JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpCj4+ID4gICAJLyogV2UgaGF2
ZSBhIGRyaXZlciEgKi8KPj4gPiAgIAl2aXJ0aW9fYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05G
SUdfU19EUklWRVIpOwo+PiA+ICsJcmV0ID0gZGV2LT5jb25maWctPmZpbmFsaXplX2ZlYXR1cmVz
KGRldik7Cj4+ID4gKwlpZiAocmV0KQo+PiA+ICsJCWdvdG8gZXJyOwo+PiAKPj4gCj4+IElzIHRo
aXMgcGFydCBvZiBjb2RlIHJlbGF0ZWQ/Cj4+IAo+PiBUaGFua3MKPj4gCj4KPiBZZXMuIHZpcnRp
b19maW5hbGl6ZV9mZWF0dXJlcyBubyBsb25nZXIgY2FsbHMgZGV2LT5jb25maWctPmZpbmFsaXpl
X2ZlYXR1cmVzLgo+Cj4gSSB0aGluayB0aGUgZGV2LT5jb25maWctPmZpbmFsaXplX2ZlYXR1cmVz
IGNhbGxiYWNrIGlzIGFjdHVhbGx5Cj4gYSBtaXNub21lciBub3csIGl0IGp1c3Qgc2VuZHMgdGhl
IGZlYXR1cmVzIHRvIGRldmljZSwKPiBmaW5hbGl6ZSBpcyBGRUFUVVJFU19PSy4gUmVuYW1pbmcg
dGhhdCBpcyBhIGJpZ2dlcgo+IHBhdGNoIHRob3VnaCwgYW5kIEknZCBsaWtlIHRoaXMgb25lIHRv
IGJlIGNoZXJyeS1waWNrYWJsZQo+IHRvIHN0YWJsZS4KCkRvIHdlIHdhbnQgdG8gYWRkIGEgY29t
bWVudCBiZWZvcmUgdGhlIGNhbGxzIHRvIC0+ZmluYWxpemVfZmVhdHVyZXMoKQooLyogd3JpdGUg
ZmVhdHVyZXMgdG8gZGV2aWNlICovKSBhbmQgYWRhcHQgdGhlIGNvbW1lbnQgaW4gdmlydGlvX3Jp
bmcuaD8KU2hvdWxkIHN0aWxsIGJlIHN0YWJsZS1mcmllbmRseSwgYW5kIGdpdmluZyB0aGUgY2Fs
bGJhY2sgYSBiZXR0ZXIgbmFtZQpjYW4gYmUgYSBmb2xsb3ctdXAgcGF0Y2guCgo+Cj4+ID4gKwo+
PiA+ICAgCXJldCA9IHZpcnRpb19maW5hbGl6ZV9mZWF0dXJlcyhkZXYpOwo+PiA+ICAgCWlmIChy
ZXQpCj4+ID4gICAJCWdvdG8gZXJyOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
