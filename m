Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6FFC433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 03:39:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C3864E09
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 03:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C3864E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5AE1487075;
	Mon, 22 Feb 2021 03:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H+HNgFNsCSqZ; Mon, 22 Feb 2021 03:39:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8A43E8703A;
	Mon, 22 Feb 2021 03:39:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 749AAC000B;
	Mon, 22 Feb 2021 03:39:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D49A1C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C6331843FD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZdIpcvAlzynB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:39:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AF1B0843F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613965155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3e0EU0Vhv5kCwoJTIMI/Uu5QjWnIGqt95U3pli1A3P4=;
 b=X8ci+PFc7FaewzudalBHmGDxpUDdLtBt4wPDd4xryaPZmDBvjP2iI58Z8LEngeC8wwuq/i
 KOZIjcESoTZPYz/x7+DSuuGECJ635reIvsgq3/DTu/On5ekjL9xAfHOusQFyhyLb7qQ0J1
 GsOf/GYZ3fqmzmiEbMc2cvz7ke1NfJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-VQdukF9iOeGY9_iNTSqGbw-1; Sun, 21 Feb 2021 22:39:13 -0500
X-MC-Unique: VQdukF9iOeGY9_iNTSqGbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C40E01005501;
 Mon, 22 Feb 2021 03:39:11 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-112.pek2.redhat.com
 [10.72.13.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C85F262954;
 Mon, 22 Feb 2021 03:39:05 +0000 (UTC)
Subject: Re: [PATCH] net: check if protocol extracted by
 virtio_net_hdr_set_proto is correct
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <5e910d11a14da17c41317417fc41d3a9d472c6e7.1613659844.git.bnemeth@redhat.com>
 <CA+FuTSe7srSBnAmFNFBFkDrLmPL5XtxhbXEs1mBytUBuuym2fg@mail.gmail.com>
 <2cc06597-8005-7be8-4094-b20f525afde8@redhat.com>
 <CA+FuTSf2GCi+RzpkFeBgtSOyhjsBFfApjekzupHLfyeYDn-JYQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8168e98e-d608-750a-9b49-b1e60a23714c@redhat.com>
Date: Mon, 22 Feb 2021 11:39:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CA+FuTSf2GCi+RzpkFeBgtSOyhjsBFfApjekzupHLfyeYDn-JYQ@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Balazs Nemeth <bnemeth@redhat.com>,
 David Miller <davem@davemloft.net>
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

Ck9uIDIwMjEvMi8xOSAxMDo1NSDkuIvljYgsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gT24g
RnJpLCBGZWIgMTksIDIwMjEgYXQgMzo1MyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPj4KPj4gT24gMjAyMS8yLzE4IDExOjUwIOS4i+WNiCwgV2lsbGVtIGRlIEJy
dWlqbiB3cm90ZToKPj4+IE9uIFRodSwgRmViIDE4LCAyMDIxIGF0IDEwOjAxIEFNIEJhbGF6cyBO
ZW1ldGggPGJuZW1ldGhAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4gRm9yIGdzbyBwYWNrZXRzLCB2
aXJ0aW9fbmV0X2hkcl9zZXRfcHJvdG8gc2V0cyB0aGUgcHJvdG9jb2wgKGlmIGl0IGlzbid0Cj4+
Pj4gc2V0KSBiYXNlZCBvbiB0aGUgdHlwZSBpbiB0aGUgdmlydGlvIG5ldCBoZHIsIGJ1dCB0aGUg
c2tiIGNvdWxkIGNvbnRhaW4KPj4+PiBhbnl0aGluZyBzaW5jZSBpdCBjb3VsZCBjb21lIGZyb20g
cGFja2V0X3NuZCB0aHJvdWdoIGEgcmF3IHNvY2tldC4gSWYKPj4+PiB0aGVyZSBpcyBhIG1pc21h
dGNoIGJldHdlZW4gd2hhdCB2aXJ0aW9fbmV0X2hkcl9zZXRfcHJvdG8gc2V0cyBhbmQKPj4+PiB0
aGUgYWN0dWFsIHByb3RvY29sLCB0aGVuIHRoZSBza2IgY291bGQgYmUgaGFuZGxlZCBpbmNvcnJl
Y3RseSBsYXRlcgo+Pj4+IG9uIGJ5IGdzby4KPj4+Pgo+Pj4+IFRoZSBuZXR3b3JrIGhlYWRlciBv
ZiBnc28gcGFja2V0cyBzdGFydHMgYXQgMTQgYnl0ZXMsIGJ1dCBhIHNwZWNpYWxseQo+Pj4+IGNy
YWZ0ZWQgcGFja2V0IGNvdWxkIGZvb2wgdGhlIGNhbGwgdG8gc2tiX2Zsb3dfZGlzc2VjdF9mbG93
X2tleXNfYmFzaWMKPj4+PiBhcyB0aGUgbmV0d29yayBoZWFkZXIgb2Zmc2V0IGluIHRoZSBza2Ig
Y291bGQgYmUgaW5jb3JyZWN0Lgo+Pj4+IENvbnNlcXVlbnRseSwgRUlOVkFMIGlzIG5vdCByZXR1
cm5lZC4KPj4+Pgo+Pj4+IFRoZXJlIGFyZSBldmVuIHBhY2tldHMgdGhhdCBjYW4gY2F1c2UgYW4g
aW5maW5pdGUgbG9vcC4gRm9yIGV4YW1wbGUsIGEKPj4+PiBwYWNrZXQgd2l0aCBldGhlcm5ldCB0
eXBlIEVUSF9QX01QTFNfVUMgKHdoaWNoIGlzIHVubm90aWNlZCBieQo+Pj4+IHZpcnRpb19uZXRf
aGRyX3RvX3NrYikgdGhhdCBpcyBzZW50IHRvIGEgZ2VuZXZlIGludGVyZmFjZSB3aWxsIGJlCj4+
Pj4gaGFuZGxlZCBieSBnZW5ldmVfYnVpbGRfc2tiLiBJbiB0dXJuLCBpdCBjYWxscwo+Pj4+IHVk
cF90dW5uZWxfaGFuZGxlX29mZmxvYWRzIHdoaWNoIHRoZW4gY2FsbHMgc2tiX3Jlc2V0X2lubmVy
X2hlYWRlcnMuCj4+Pj4gQWZ0ZXIgdGhhdCwgdGhlIHBhY2tldCBnZXRzIHBhc3NlZCB0byBtcGxz
X2dzb19zZWdtZW50LiBUaGF0IGZ1bmN0aW9uCj4+Pj4gY2FsY3VsYXRlcyB0aGUgbXBscyBoZWFk
ZXIgbGVuZ3RoIGJ5IHRha2luZyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuCj4+Pj4gbmV0d29ya19o
ZWFkZXIgYW5kIGlubmVyX25ldHdvcmtfaGVhZGVyLiBTaW5jZSB0aGUgdHdvIGFyZSBlcXVhbAo+
Pj4+IChkdWUgdG8gdGhlIGVhcmxpZXIgY2FsbCB0byBza2JfcmVzZXRfaW5uZXJfaGVhZGVycyks
IGl0IHdpbGwgY2FsY3VsYXRlCj4+Pj4gYSBoZWFkZXIgb2YgbGVuZ3RoIDAsIGFuZCBpdCB3aWxs
IG5vdCBwdWxsIGFueSBoZWFkZXJzLiBUaGVuLCBpdCB3aWxsCj4+Pj4gY2FsbCBza2JfbWFjX2dz
b19zZWdtZW50IHdoaWNoIHdpbGwgYWdhaW4gY2FsbCBtcGxzX2dzb19zZWdtZW50LCBldGMuLi4K
Pj4+PiBUaGlzIGxlYWRzIHRvIHRoZSBpbmZpbml0ZSBsb29wLgo+Pgo+PiBJIHJlbWVtYmVyIGtl
cm5lbCB3aWxsIHZhbGlkYXRlIGRvZGd5IGdzbyBwYWNrZXRzIGluIGdzbyBvcHMuIEkgd29uZGVy
Cj4+IHdoeSBub3QgZG8gdGhlIGNoZWNrIHRoZXJlPyBUaGUgcmVhc29uIGlzIHRoYXQgdmlydGlv
L1RVTiBpcyBub3QgdGhlCj4+IG9ubHkgc291cmNlIGZvciB0aG9zZSBwYWNrZXRzLgo+IEl0IGlz
PyBBbGwgb3RoZXIgR1NPIHBhY2tldHMgYXJlIGdlbmVyYXRlZCBieSB0aGUgc3RhY2sgaXRzZWxm
LCBlaXRoZXIKPiBsb2NhbGx5IG9yIHRocm91Z2ggR1JPLgoKClNvbWV0aGluZyBsaWtlIHdoYXQg
aGFzIGJlZW4gZG9uZSBpbiB0Y3BfdHNvX3NlZ21lbnQoKT8KCiDCoMKgwqAgaWYgKHNrYl9nc29f
b2soc2tiLCBmZWF0dXJlcyB8IE5FVElGX0ZfR1NPX1JPQlVTVCkpIHsKIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvKiBQYWNrZXQgaXMgZnJvbSBhbiB1bnRydXN0ZWQgc291cmNlLCBy
ZXNldCBnc29fc2Vncy4gKi8KCiDCoMKgwqAgwqDCoMKgIHNrYl9zaGluZm8oc2tiKS0+Z3NvX3Nl
Z3MgPSBESVZfUk9VTkRfVVAoc2tiLT5sZW4sIG1zcyk7CgogwqDCoMKgIMKgwqDCoCBzZWdzID0g
TlVMTDsKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKIMKgwqDCoMKg
wqDCoMKgIH0KCk15IHVuZGVyc3RhbmRpbmcgb2YgdGhlIGhlYWRlciBjaGVjayBsb2dpYyBpcyB0
aGF0IGl0IHRyaWVzIHRvIGRlYWx5IHRoZSAKY2hlY2sgYXMgbXVjaCBhcyBwb3NzaWJsZSwgc28g
Zm9yIGRldmljZSB0aGF0IGhhcyBHUk9fUk9CVVNULCB0aGVyZSdzIApldmVuIG5vIG5lZWQgdG8g
ZG8gdGhhdC4KCgo+Cj4gQnV0IGluZGVlZCBzb21lIGNoZWNrcyBhcmUgYmV0dGVyIHBlcmZvcm1l
ZCBpbiB0aGUgR1NPIGxheWVyLiBTdWNoIGFzCj4gbGlrZWx5IHRoZSAwLWJ5dGUgbXBscyBoZWFk
ZXIgbGVuZ3RoLgo+Cj4gSWYgd2UgY2Fubm90IHRydXN0IHZpcnRpb19uZXRfaGRyLmdzb190eXBl
IHBhc3NlZCBmcm9tIHVzZXJzcGFjZSwgdGhlbgo+IHdlIGNhbiBhbHNvIG5vdCB0cnVzdCB0aGUg
ZXRoLmhfcHJvdG8gY29taW5nIGZyb20gdGhlIHNhbWUgc291cmNlLgoKCkkgYWdyZWUuCgoKPiBC
dXQKPiBpdCBtYWtlcyBzZW5zZSB0byByZXF1aXJlIHRoZW0gdG8gYmUgY29uc2lzdGVudC4gVGhl
cmUgaXMgYQo+IGRldl9wYXJzZV9oZWFkZXJfcHJvdG9jb2wgdGhhdCBtYXkgcmV0dXJuIHRoZSBs
aW5rIGxheWVyIHR5cGUgaW4gYQo+IG1vcmUgZ2VuZXJpYyBmYXNoaW9uIHRoYW4gY2FzdGluZyB0
byBza2JfZXRoX2hkci4KPgo+IFF1ZXN0aW9uIHJlbWFpbnMgd2hhdCB0byBkbyBmb3IgdGhlIGxp
bmsgbGF5ZXIgdHlwZXMgdGhhdCBkbyBub3QgaW1wbGVtZW50Cj4gaGVhZGVyX29wcy0+cGFyc2Vf
cHJvdG9jb2wsIGFuZCBzbyB3ZSBjYW5ub3QgdmFsaWRhdGUgdGhlIHBhY2tldCdzCj4gbmV0d29y
ayBwcm90b2NvbC4gRHJvcCB3aWxsIGNhdXNlIGZhbHNlIHBvc2l0aXZlcywgYWNjZXB0cyB3aWxs
IGxlYXZlIGEKPiBwb3RlbnRpYWwgcGF0aCwganVzdCBjbG9zZXMgaXQgZm9yIEV0aGVybmV0Lgo+
Cj4gVGhpcyBtaWdodCBjYWxsIGZvciBtdWx0aXBsZSBmaXhlcywgYm90aCBvbiBmaXJzdCBpbmdl
c3QgYW5kIGluc2lkZSB0aGUgc3RhY2s/CgoKSXQncyBhIGJhbGFuY2UgYmV0d2VlbiBwZXJmb3Jt
YW5jZSBhbmQgc2VjdXJpdHkuIElkZWFsbHksIGl0IGxvb2tzIHRvIG1lIAp0aGUgR1NPIGNvZGVz
IHNob3VsZCBub3QgYXNzdW1lIHRoZSBoZWFkZXIgb2YgZG9kZ3kgcGFja2V0IGlzIGNvcnJlY3Qg
CndoaWNoIG1lYW5zIGl0IG11c3QgdmFsaWRhdGUgdGhlbSBiZWZvcmUgdXNpbmcgdGhlbS4gSSdt
IG5vdCBzdXJlIGlmIGl0IApuZWVkcyBhIGxvdCBvZiBjaGFuZ2VzIG9yIG5vdC4KCkZvciBzZWN1
cml0eSByZWFzb24sIGl0J3MgYmV0dGVyIHRvIGRvIGEgc3RyaWN0IGNoZWNrIGR1cmluZyBmaXJz
dCAKaW5nZXN0LiBCdXQgaXQgYmFzY2lhbGx5IHN1cHByZXNzIHRoZSBtZWFuaW5nIG9mIE5FVElG
X0ZfR1NPX1JPQlVTVCAKc29tZWhvdy4gQW5kIGl0IG5lZWRzIHNvbWUgYmVuY2htYXJrIHRvIHNl
ZSBpZiBpdCBjYW4gY2F1c2Ugb2J2aW91cyAKcGVyZm9ybWFuY2UgcmVncmVzc2lvbi4KClRoYW5r
cwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
