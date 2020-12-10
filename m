Return-Path: <SRS0=lZ9m=FO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636CBC4361B
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 04:03:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1C023BA7
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 04:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1C023BA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 964F387492;
	Thu, 10 Dec 2020 04:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hlN_4PzFj5HO; Thu, 10 Dec 2020 04:03:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 04BEC87405;
	Thu, 10 Dec 2020 04:03:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2DE0C0893;
	Thu, 10 Dec 2020 04:03:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA6DC013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 04:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 128F320366
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 04:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kGTTKxF-zDqT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 04:03:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 148EF20341
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 04:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607572997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ep/ZiwecWipeqk42V6c9PjyxWhVrZXaXr/UgV2fCnYY=;
 b=VFQEZ2RRCpOegGpg1ItwFQJ8CQKdgBzgUdvAZpRDGGytoLRjz2P8J1ctzor15s4A1W8PbB
 Mnp68DLHsG3TlUNjJ8XHUoaRrphBSH/Bvt6KeqYS+R7Y20YLXUjto27MNxbmgu1lf7tj3D
 jaCPkuSVc+bWiFIzI/nIjzNzyQZ0brg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-3ir88J8zN1aW0_fCiv20MQ-1; Wed, 09 Dec 2020 23:03:15 -0500
X-MC-Unique: 3ir88J8zN1aW0_fCiv20MQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18F32107ACF6;
 Thu, 10 Dec 2020 04:03:14 +0000 (UTC)
Received: from [10.72.13.187] (ovpn-13-187.pek2.redhat.com [10.72.13.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C52E75D6A1;
 Thu, 10 Dec 2020 04:03:04 +0000 (UTC)
Subject: Re: [PATCH v3 05/19] vdpa_sim: remove the limit of IOTLB entries
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-6-sgarzare@redhat.com>
 <d7b00b70-9785-db1f-1e42-7b9172b7ad90@redhat.com>
 <20201209105829.6l6ie7xqp2eycds6@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0333484d-7fa1-fc88-7e22-14492e994b72@redhat.com>
Date: Thu, 10 Dec 2020 12:03:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209105829.6l6ie7xqp2eycds6@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Shahaf Shuler <shahafs@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>,
 Oren Duer <oren@nvidia.com>
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

Ck9uIDIwMjAvMTIvOSDkuIvljYg2OjU4LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24g
TW9uLCBEZWMgMDcsIDIwMjAgYXQgMTI6MDA6MDdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4KPj4gT24gMjAyMC8xMi80IOS4iuWNiDE6MDQsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToK
Pj4+IFRoZSBzaW11bGF0ZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBtdWx0aXBsZSBxdWV1ZXMsIHNv
IHRoaXMgbGltaXQKPj4+IHNob3VsZCBiZSBkZWZpbmVkIGFjY29yZGluZyB0byB0aGUgbnVtYmVy
IG9mIHF1ZXVlcyBzdXBwb3J0ZWQgYnkKPj4+IHRoZSBkZXZpY2UuCj4+Pgo+Pj4gU2luY2Ugd2Ug
YXJlIGluIGEgc2ltdWxhdG9yLCBsZXQncyBzaW1wbHkgcmVtb3ZlIHRoYXQgbGltaXQuCj4+Pgo+
Pj4gU3VnZ2VzdGVkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4gQWNr
ZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5
OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4+Cj4+Cj4+IFJldGhp
bmsgYWJvdXQgdGhpcywgc2luY2Ugc2ltdWxhdG9yIGNhbiBiZSB1c2VkIGJ5IFZNLCBzbyB0aGUg
Cj4+IGFsbG9jYXRpb24gaXMgYWN0dWFsbHkgZ3Vlc3QgdHJpZ2dlci1hYmxlIHdoZW4gdklPTU1V
IGlzIGVuYWJsZWQuCj4+Cj4+IFRoaXMgbWVhbnMgd2UgbmVlZCBhIGxpbWl0IHNvbWVob3csIChl
LmcgSSByZW1lbWJlciBzd2lvdGxiIGlzIGFib3V0IAo+PiA2NE1CIGJ5IGRlZmF1bHQpLiBPciBo
YXZpbmcgYSBtb2R1bGUgcGFyYW1ldGVyIGZvciB0aGlzLgo+Pgo+PiBCdHcsIGhhdmUgeW91IG1l
dCBhbnkgaXNzdWUgd2hlbiB1c2luZyAyMDQ4LCBJIGd1ZXNzIGl0IGNhbiBoYXBwZW4gCj4+IHdo
ZW4gd2UgcnVuIHNldmVyYWwgcHJvY2Vzc2VzIGluIHBhcmFsbGVsPwo+Pgo+Cj4gTm8sIEkgZGlk
bid0IHRyeSB3aXRoIHRoZSBsaW1pdC4KPiBUaGlzIGNhbWUgZnJvbSB0aGUgcmV2aWV3cyB0byBN
YXgncyBwYXRjaGVzLgo+Cj4gQW55d2F5IEkgY2FuIGFkZCBhIG1vZHVsZSBwYXJhbWV0ZXIgdG8g
Y29udHJvbCB0aGF0IGxpbWl0LCBkbyB5b3UgCj4gdGhpbmsgaXMgYmV0dGVyIHRvIHNldCBhIGxp
bWl0IHBlciBxdWV1ZSAodGhlIHBhcmFtZXRlciBwZXIgbnVtYmVyIG9mIAo+IHF1ZXVlcyksIG9y
IGp1c3QgYSB2YWx1ZSBmb3IgdGhlIGVudGlyZSBkZXZpY2U/CgoKUGVyLWRldmljZSBzaG91bGQg
YmUgb2suCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
