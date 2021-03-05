Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A6C433E6
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 03:42:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DCC364DCE
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 03:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCC364DCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC11C432CD;
	Fri,  5 Mar 2021 03:42:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vKqxNb_vW_WF; Fri,  5 Mar 2021 03:42:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7DD44432D4;
	Fri,  5 Mar 2021 03:42:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54859C000B;
	Fri,  5 Mar 2021 03:42:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE85CC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86F446FB47
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:42:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hOsIxqYJ4_kD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:42:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC0D1606D0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614915770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S09KIs3h5s2DqZN4ohZ2FeX/5vfiTMGLwJJiGKhjztY=;
 b=b4qY9NN2pFkAvXi36M9Ih9O04IXIQ51Jx5J/6L7vwaCE0WM8F7BWIV9/LBWyL6yQziqZmO
 AYUsam47xSCSKMXwY6LOy+ohh3KkKBN1dAz6j77CwWo9b0i0mgzQ10BC0Pu6tPDQsK4NZj
 NH4RRAQ3DL/xqP96OiwXSgrR6ZeATzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-f8M8SgrOOhOnTxEFlfiUxQ-1; Thu, 04 Mar 2021 22:42:46 -0500
X-MC-Unique: f8M8SgrOOhOnTxEFlfiUxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4584A80006E;
 Fri,  5 Mar 2021 03:42:44 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-196.pek2.redhat.com
 [10.72.13.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE9AA5D755;
 Fri,  5 Mar 2021 03:42:32 +0000 (UTC)
Subject: Re: [RFC v4 10/11] vduse: Introduce a workqueue for irq injection
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-11-xieyongji@bytedance.com>
 <d63e4cfd-4992-8493-32b0-18e0478f6e1a@redhat.com>
 <CACycT3tqM=ALOG1r0Ve6UTGmwJ7Wg7fQpLZypjZsJF1mJ+adMA@mail.gmail.com>
 <2d3418d9-856c-37ee-7614-af5b721becd7@redhat.com>
 <CACycT3u0+LTbtFMS75grKGZ2mnXzHnKug+HGWbf+nqVybqwkZQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b3faa4a6-a65b-faf7-985a-b2771533c8bb@redhat.com>
Date: Fri, 5 Mar 2021 11:42:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3u0+LTbtFMS75grKGZ2mnXzHnKug+HGWbf+nqVybqwkZQ@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Ck9uIDIwMjEvMy81IDExOjMwIOS4iuWNiCwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBGcmksIE1h
ciA1LCAyMDIxIGF0IDExOjA1IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAyMDIxLzMvNCA0OjU4IOS4i+WNiCwgWW9uZ2ppIFhpZSB3cm90ZToKPj4+
IE9uIFRodSwgTWFyIDQsIDIwMjEgYXQgMjo1OSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4+PiBPbiAyMDIxLzIvMjMgNzo1MCDkuIvljYgsIFhpZSBZb25namkg
d3JvdGU6Cj4+Pj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIHdvcmtxdWV1ZSB0byBzdXBwb3J0
IGluamVjdGluZwo+Pj4+PiB2aXJ0cXVldWUncyBpbnRlcnJ1cHQgYXN5bmNocm9ub3VzbHkuIFRo
aXMgaXMgbWFpbmx5Cj4+Pj4+IGZvciBwZXJmb3JtYW5jZSBjb25zaWRlcmF0aW9ucyB3aGljaCBt
YWtlcyBzdXJlIHRoZSBwdXNoKCkKPj4+Pj4gYW5kIHBvcCgpIGZvciB1c2VkIHZyaW5nIGNhbiBi
ZSBhc3luY2hyb25vdXMuCj4+Pj4gRG8geW91IGhhdmUgcHJlZiBudW1iZXJzIGZvciB0aGlzIHBh
dGNoPwo+Pj4+Cj4+PiBObywgSSBjYW4gZG8gc29tZSB0ZXN0cyBmb3IgaXQgaWYgbmVlZGVkLgo+
Pj4KPj4+IEFub3RoZXIgcHJvYmxlbSBpcyB0aGUgVklSVElPX1JJTkdfRl9FVkVOVF9JRFggZmVh
dHVyZSB3aWxsIGJlIHVzZWxlc3MKPj4+IGlmIHdlIGNhbGwgaXJxIGNhbGxiYWNrIGluIGlvY3Rs
IGNvbnRleHQuIFNvbWV0aGluZyBsaWtlOgo+Pj4KPj4+IHZpcnRxdWV1ZV9wdXNoKCk7Cj4+PiB2
aXJ0aW9fbm90aWZ5KCk7Cj4+PiAgICAgICBpb2N0bCgpCj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+PiAgICAgICAgICAgaXJxX2NiKCkKPj4+
ICAgICAgICAgICAgICAgdmlydHF1ZXVlX2dldF9idWYoKQo+Pj4KPj4+IFRoZSB1c2VkIHZyaW5n
IGlzIGFsd2F5cyBlbXB0eSBlYWNoIHRpbWUgd2UgY2FsbCB2aXJ0cXVldWVfcHVzaCgpIGluCj4+
PiB1c2Vyc3BhY2UuIE5vdCBzdXJlIGlmIGl0IGlzIHdoYXQgd2UgZXhwZWN0ZWQuCj4+Cj4+IEkn
bSBub3Qgc3VyZSBJIGdldCB0aGUgaXNzdWUuCj4+Cj4+IFRIZSB1c2VkIHJpbmcgc2hvdWxkIGJl
IGZpbGxlZCBieSB2aXJ0cXVldWVfcHVzaCgpIHdoaWNoIGlzIGRvbmUgYnkKPj4gdXNlcnNwYWNl
IGJlZm9yZT8KPj4KPiBBZnRlciB1c2Vyc3BhY2UgY2FsbCB2aXJ0cXVldWVfcHVzaCgpLCBpdCBh
bHdheXMgY2FsbCB2aXJ0aW9fbm90aWZ5KCkKPiBpbW1lZGlhdGVseS4gSW4gdHJhZGl0aW9uYWwg
Vk0gKHZob3N0LXZkcGEpIGNhc2VzLCB2aXJ0aW9fbm90aWZ5KCkKPiB3aWxsIGluamVjdCBhbiBp
cnEgdG8gVk0gYW5kIHJldHVybiwgdGhlbiB2Y3B1IHRocmVhZCB3aWxsIGNhbGwKPiBpbnRlcnJ1
cHQgaGFuZGxlci4gQnV0IGluIGNvbnRhaW5lciAodmlydGlvLXZkcGEpIGNhc2VzLAo+IHZpcnRp
b19ub3RpZnkoKSB3aWxsIGNhbGwgaW50ZXJydXB0IGhhbmRsZXIgZGlyZWN0bHkuIFNvIGl0IGxv
b2tzIGxpa2UKPiB3ZSBoYXZlIHRvIG9wdGltaXplIHRoZSB2aXJ0aW8tdmRwYSBjYXNlcy4gQnV0
IG9uZSBwcm9ibGVtIGlzIHdlIGRvbid0Cj4ga25vdyB3aGV0aGVyIHdlIGFyZSBpbiB0aGUgVk0g
dXNlciBjYXNlIG9yIGNvbnRhaW5lciB1c2VyIGNhc2UuCgoKWWVzLCBidXQgSSBzdGlsbCBkb24n
dCBnZXQgd2h5IHVzZWQgcmluZyBpcyBlbXB0eSBhZnRlciB0aGUgaW9jdGwoKT8gClVzZWQgcmlu
ZyBkb2VzIG5vdCB1c2UgYm91bmNlIHBhZ2Ugc28gaXQgc2hvdWxkIGJlIHZpc2libGUgdG8gdGhl
IGtlcm5lbCAKZHJpdmVyLiBXaGF0IGRpZCBJIG1pc3MgOikgPwoKVGhhbmtzCgoKCj4KPiBUaGFu
a3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
