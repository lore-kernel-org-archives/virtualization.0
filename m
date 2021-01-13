Return-Path: <SRS0=6FxZ=GQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CFCC433DB
	for <virtualization@archiver.kernel.org>; Wed, 13 Jan 2021 03:38:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C05E23117
	for <virtualization@archiver.kernel.org>; Wed, 13 Jan 2021 03:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C05E23117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2D12386222;
	Wed, 13 Jan 2021 03:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WDU-4LGx3ej9; Wed, 13 Jan 2021 03:38:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8FE9D86207;
	Wed, 13 Jan 2021 03:38:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 718FDC088B;
	Wed, 13 Jan 2021 03:38:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21F86C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 03:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0379286F8A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 03:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WL-1NLsbZzei
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 03:38:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8F27F86F89
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 03:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610509125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSaLRoG57KvO7g+HhBEQBIyCeK5sYiN7HkTE57zkReU=;
 b=WGu/K8aYD7DCrnGN7gDIRGROSZBEJEaOxP47+7gCAvYNsVF2AgL8ilT+1C3VFNcs535MgC
 YjUZ1aNVoaGNdzzu6EV//KVzUfSxh8FJivhu8opmIsaap8UlF2OCgu8riAOKJJIDCdS+hi
 2vNNsj7xw9TAIchRNythflXdJYQF0Po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-LlhP_UCCPhyJ2DE4Q9BBuA-1; Tue, 12 Jan 2021 22:38:43 -0500
X-MC-Unique: LlhP_UCCPhyJ2DE4Q9BBuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D45A805EE3;
 Wed, 13 Jan 2021 03:38:42 +0000 (UTC)
Received: from [10.72.12.205] (ovpn-12-205.pek2.redhat.com [10.72.12.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F370B60BFA;
 Wed, 13 Jan 2021 03:38:36 +0000 (UTC)
Subject: Re: [PATCH v3] vhost_vdpa: fix the problem in
 vhost_vdpa_set_config_call
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, lingshan.zhu@intel.com
References: <20210112053629.9853-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1403c336-4493-255f-54e3-c55dd2015c40@redhat.com>
Date: Wed, 13 Jan 2021 11:38:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112053629.9853-1-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: stable@vger.kernel.org
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

Ck9uIDIwMjEvMS8xMiDkuIvljYgxOjM2LCBDaW5keSBMdSB3cm90ZToKPiBJbiB2aG9zdF92ZHBh
X3NldF9jb25maWdfY2FsbCwgdGhlIGNiLnByaXZhdGUgc2hvdWxkIGJlIHZob3N0X3ZkcGEuCj4g
dGhpcyBjYi5wcml2YXRlIHdpbGwgZmluYWxseSB1c2UgaW4gdmhvc3RfdmRwYV9jb25maWdfY2Ig
YXMKPiB2aG9zdF92ZHBhLiBGaXggdGhpcyBpc3N1ZS4KPgo+IEZpeGVzOiA3NzZmMzk1MDA0ZDgy
ICgidmhvc3RfdmRwYTogU3VwcG9ydCBjb25maWcgaW50ZXJydXB0IGluIHZkcGEiKQo+IEFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IENp
bmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+Cj4gLS0tCgoKSGkgQ2luZHk6CgpJIHRoaW5rIGF0IGxl
YXN0IHlvdSBmb3JnZXQgdG8gY2Mgc3RhYmxlLgoKVGhhbmtzCgoKPiAgIGRyaXZlcnMvdmhvc3Qv
dmRwYS5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+IGluZGV4IGVmNjg4YzhjMGUwZS4uM2ZiYjljMWY0OWRhIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBA
QCAtMzE5LDcgKzMxOSw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X2NvbmZpZ19jYWxs
KHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgX191c2VyICphcmdwKQo+ICAgCXN0cnVjdCBldmVu
dGZkX2N0eCAqY3R4Owo+ICAgCj4gICAJY2IuY2FsbGJhY2sgPSB2aG9zdF92ZHBhX2NvbmZpZ19j
YjsKPiAtCWNiLnByaXZhdGUgPSB2LT52ZHBhOwo+ICsJY2IucHJpdmF0ZSA9IHY7Cj4gICAJaWYg
KGNvcHlfZnJvbV91c2VyKCZmZCwgYXJncCwgc2l6ZW9mKGZkKSkpCj4gICAJCXJldHVybiAgLUVG
QVVMVDsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
