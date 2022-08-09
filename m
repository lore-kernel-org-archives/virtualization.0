Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF7DC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 14:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBCBE40907;
	Tue,  9 Aug 2022 14:28:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBCBE40907
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I5UaPA3t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SzQwXCjl2XwA; Tue,  9 Aug 2022 14:28:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F2F8240339;
	Tue,  9 Aug 2022 14:28:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2F8240339
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB4F4C0033;
	Tue,  9 Aug 2022 14:28:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A018DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 14:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 743AB8134F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 14:28:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 743AB8134F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I5UaPA3t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m-SmRMUx6eBr
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 14:28:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A9E481344
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A9E481344
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660055327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QoOWzRRd0gXzzd5MjvJGUJ8tTQa3lBXK43u6AGIzVrM=;
 b=I5UaPA3txoFA5ZR8QJ6yQsWFDWg8PaLDviB+fTzLqNNB6ptHWws6eS1o4AUqQIdSYONNGL
 eb+ZxrqqI1sJJv2p2P9eHdSksgdgNHceujob0JRkQjl+1E48ZoKTUjHfRD94afR3D3z7h5
 PdLwApWBnDjai4xvn2Oog0u3aazuxHU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-IknCk1rBNTiMBIW7bg8vmQ-1; Tue, 09 Aug 2022 10:28:42 -0400
X-MC-Unique: IknCk1rBNTiMBIW7bg8vmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0539F802D1C;
 Tue,  9 Aug 2022 14:28:42 +0000 (UTC)
Received: from localhost (unknown [10.39.193.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A66EEC15BA1;
 Tue,  9 Aug 2022 14:28:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] docs: driver-api: virtio: virtio on Linux
In-Reply-To: <87iln1r2hv.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
Organization: Red Hat GmbH
References: <20220804105914.3707389-1-ricardo.canuelo@collabora.com>
 <20220804105914.3707389-3-ricardo.canuelo@collabora.com>
 <87bksuetk5.fsf@redhat.com>
 <87iln1r2hv.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Notmuch/0.36 (https://notmuchmail.org)
Date: Tue, 09 Aug 2022 16:28:40 +0200
Message-ID: <87wnbhcwyv.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: mst@redhat.com, kernel@collabora.com, bagasdotme@gmail.com,
 virtualization@lists.linux-foundation.org
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

T24gVHVlLCBBdWcgMDkgMjAyMiwgUmljYXJkbyBDYcOxdWVsbyA8cmljYXJkby5jYW51ZWxvQGNv
bGxhYm9yYS5jb20+IHdyb3RlOgoKPiBIb3cgYWJvdXQgdGhpcyBhcyBhbiBpbnRyb2R1Y3Rpb24/
Cj4KPiAgICAgVmlydGlvIGlzIGFuIG9wZW4gc3RhbmRhcmQgdGhhdCBkZWZpbmVzIGEgcHJvdG9j
b2wgdG8gY29tbXVuaWNhdGUKPiAgICAgZHJpdmVycyBhbmQgZGV2aWNlcyBvZiBkaWZmZXJlbnQg
dHlwZXMsIHNlZSBDaGFwdGVyIDUgKCJEZXZpY2UKCiIuLi50aGF0IGRlZmluZXMgYSBwcm90b2Nv
bCBmb3IgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIGRyaXZlcnMgYW5kCmRldmljZXMgb2YgZGlmZmVy
ZW50IGRldmljZSB0eXBlcywgc2VlLi4uIgoKPiAgICAgVHlwZXMiKSBvZiB0aGUgdmlydGlvIHNw
ZWMgYFsxXWBfLiBPcmlnaW5hbGx5IGRldmVsb3BlZCBhcyBhCj4gICAgIHN0YW5kYXJkIGZvciBw
YXJhdmlydHVhbGl6ZWQgZGV2aWNlcyBpbXBsZW1lbnRlZCBieSBhIGh5cGVydmlzb3IsIGl0Cj4g
ICAgIGNhbiBiZSB1c2VkIHRvIGludGVyZmFjZSBhbnkgY29tcGxpYW50IGRldmljZSAocmVhbCBv
ciBlbXVsYXRlZCkKPiAgICAgd2l0aCBhIGRyaXZlci4KPgo+ICAgICBGb3IgaWxsdXN0cmF0aXZl
IHB1cnBvc2VzLCB0aGlzIGRvY3VtZW50IHdpbGwgZm9jdXMgb24gdGhlIGNvbW1vbgo+ICAgICBj
YXNlIG9mIGEgTGludXgga2VybmVsIHJ1bm5pbmcgaW4gYSB2aXJ0dWFsIG1hY2hpbmUgYW5kIHVz
aW5nCj4gICAgIHBhcmF2aXJ0dWFsaXplZCBkZXZpY2VzIHByb3ZpZGVkIGJ5IHRoZSBoeXBlcnZp
c29yLCB3aGljaCBleHBvc2VzCj4gICAgIHRoZW0gYXMgdmlydGlvIGRldmljZXMgdmlhIHN0YW5k
YXJkIG1lY2hhbmlzbXMgc3VjaCBhcyBQQ0kuCgpTb3VuZHMgZ29vZCB0byBtZS4KCiguLi4pCgo+
IE9rLCBJJ2xsIHNpbXBsaWZ5IHRoZSBpbnRybyB0byB0aGlzOgo+Cj4gICAgIFRoaXMgZG9jdW1l
bnQgc2VydmVzIGFzIGEgYmFzaWMgZ3VpZGVsaW5lIGZvciBkcml2ZXIgcHJvZ3JhbW1lcnMKPiAg
ICAgdGhhdCBuZWVkIHRvIGhhY2sgYSBuZXcgdmlydGlvIGRyaXZlciBvciB1bmRlcnN0YW5kIHRo
ZSBlc3NlbnRpYWxzCj4gICAgIG9mIHRoZSBleGlzdGluZyBvbmVzLiBTZWUgOnJlZjpgVmlydGlv
IG9uIExpbnV4IDx2aXJ0aW8+YCBmb3IgYQo+ICAgICBnZW5lcmFsIG92ZXJ2aWV3IG9mIHZpcnRp
by4KCk9rLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
