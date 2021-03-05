Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2D7C433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 03:05:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50C164FEE
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 03:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50C164FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53E3B6FB55;
	Fri,  5 Mar 2021 03:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lbg6aPJPLgHS; Fri,  5 Mar 2021 03:05:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02A056F52F;
	Fri,  5 Mar 2021 03:05:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAC17C000A;
	Fri,  5 Mar 2021 03:05:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A143C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46C456FB4D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:05:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qI1bikLXIuDB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:05:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D5B36F52F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614913502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NyeZ19kifPGrNPSu9tsx+U9SHlXSaVFqXfzKSyjA9QU=;
 b=YxScW7OW5tMBG6f7L5d2S4CpSakIw154kHKhBMMDJNl/Jcvcf/ZCMlUz3CARg0Cc9lBQhU
 Iiq9z6ChScuevoFqKBRcyM3Y6kvKKUwHkXWGFj8LqVEROlDcRfbF87bvG2N8p4jgKBgM1U
 Mc993Uk2151l3TV/oU49l1UlERY9670=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-3LT2sfD5N0eNx-b62H3FiQ-1; Thu, 04 Mar 2021 22:05:00 -0500
X-MC-Unique: 3LT2sfD5N0eNx-b62H3FiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C35F1084C83;
 Fri,  5 Mar 2021 03:04:57 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-196.pek2.redhat.com
 [10.72.13.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9ECCC60C0F;
 Fri,  5 Mar 2021 03:04:44 +0000 (UTC)
Subject: Re: [RFC v4 10/11] vduse: Introduce a workqueue for irq injection
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-11-xieyongji@bytedance.com>
 <d63e4cfd-4992-8493-32b0-18e0478f6e1a@redhat.com>
 <CACycT3tqM=ALOG1r0Ve6UTGmwJ7Wg7fQpLZypjZsJF1mJ+adMA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2d3418d9-856c-37ee-7614-af5b721becd7@redhat.com>
Date: Fri, 5 Mar 2021 11:04:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tqM=ALOG1r0Ve6UTGmwJ7Wg7fQpLZypjZsJF1mJ+adMA@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-aio@kvack.org, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Bob Liu <bob.liu@oracle.com>,
 bcrl@kvack.org, viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org
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

Ck9uIDIwMjEvMy80IDQ6NTgg5LiL5Y2ILCBZb25namkgWGllIHdyb3RlOgo+IE9uIFRodSwgTWFy
IDQsIDIwMjEgYXQgMjo1OSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPj4KPj4gT24gMjAyMS8yLzIzIDc6NTAg5LiL5Y2ILCBYaWUgWW9uZ2ppIHdyb3RlOgo+Pj4g
VGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgd29ya3F1ZXVlIHRvIHN1cHBvcnQgaW5qZWN0aW5nCj4+
PiB2aXJ0cXVldWUncyBpbnRlcnJ1cHQgYXN5bmNocm9ub3VzbHkuIFRoaXMgaXMgbWFpbmx5Cj4+
PiBmb3IgcGVyZm9ybWFuY2UgY29uc2lkZXJhdGlvbnMgd2hpY2ggbWFrZXMgc3VyZSB0aGUgcHVz
aCgpCj4+PiBhbmQgcG9wKCkgZm9yIHVzZWQgdnJpbmcgY2FuIGJlIGFzeW5jaHJvbm91cy4KPj4K
Pj4gRG8geW91IGhhdmUgcHJlZiBudW1iZXJzIGZvciB0aGlzIHBhdGNoPwo+Pgo+IE5vLCBJIGNh
biBkbyBzb21lIHRlc3RzIGZvciBpdCBpZiBuZWVkZWQuCj4KPiBBbm90aGVyIHByb2JsZW0gaXMg
dGhlIFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYIGZlYXR1cmUgd2lsbCBiZSB1c2VsZXNzCj4gaWYg
d2UgY2FsbCBpcnEgY2FsbGJhY2sgaW4gaW9jdGwgY29udGV4dC4gU29tZXRoaW5nIGxpa2U6Cj4K
PiB2aXJ0cXVldWVfcHVzaCgpOwo+IHZpcnRpb19ub3RpZnkoKTsKPiAgICAgIGlvY3RsKCkKPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICAgICAg
ICAgaXJxX2NiKCkKPiAgICAgICAgICAgICAgdmlydHF1ZXVlX2dldF9idWYoKQo+Cj4gVGhlIHVz
ZWQgdnJpbmcgaXMgYWx3YXlzIGVtcHR5IGVhY2ggdGltZSB3ZSBjYWxsIHZpcnRxdWV1ZV9wdXNo
KCkgaW4KPiB1c2Vyc3BhY2UuIE5vdCBzdXJlIGlmIGl0IGlzIHdoYXQgd2UgZXhwZWN0ZWQuCgoK
SSdtIG5vdCBzdXJlIEkgZ2V0IHRoZSBpc3N1ZS4KClRIZSB1c2VkIHJpbmcgc2hvdWxkIGJlIGZp
bGxlZCBieSB2aXJ0cXVldWVfcHVzaCgpIHdoaWNoIGlzIGRvbmUgYnkgCnVzZXJzcGFjZSBiZWZv
cmU/CgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
