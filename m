Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DB3C433DB
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:58:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23232151B
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23232151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7DE31855C6;
	Mon,  4 Jan 2021 06:58:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ly9pssDJ0b-E; Mon,  4 Jan 2021 06:58:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1062F85F4D;
	Mon,  4 Jan 2021 06:58:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBAD1C0893;
	Mon,  4 Jan 2021 06:58:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 001CDC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DBDFA85045
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zGw5YDYTSdzf
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:58:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3475484FB6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609743526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxdh5q0caEjSDWuCekQlHDQQh0mRUuamrqPDtKU99A0=;
 b=i0ChQGIpgf32JEWmJJdbeysDR/tQCobt5CykK4T91Kwp8mO/pQgGK/5ENp0FXyVjDG8uhU
 81Tdv/Higwbn1zM3jk4Gds0rGE1rYI14wTfKmWDwrXOCMOzcjp29r0vNJs8vqAFIxu9AnW
 JFh0ZNOkOSR8pVt1zNAMiE5FGn1V6X8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-SPEMtkpcMqCKWeZ2OvOlOQ-1; Mon, 04 Jan 2021 01:58:42 -0500
X-MC-Unique: SPEMtkpcMqCKWeZ2OvOlOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E940107ACE4;
 Mon,  4 Jan 2021 06:58:41 +0000 (UTC)
Received: from [10.72.13.91] (ovpn-13-91.pek2.redhat.com [10.72.13.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2618B60BE5;
 Mon,  4 Jan 2021 06:58:36 +0000 (UTC)
Subject: Re: [PATCH V2 00/19] vDPA driver for virtio-pci device
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
 <3a3fa2f5-d5d8-e8dd-71d1-cb81a3276658@redhat.com>
 <20210103073629-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5347a78d-fce4-f1dc-b4ed-9740e39ad56f@redhat.com>
Date: Mon, 4 Jan 2021 14:58:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210103073629-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: shahafs@mellanox.com, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMS8zIOS4i+WNiDg6MzcsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBU
aHUsIERlYyAzMSwgMjAyMCBhdCAxMTo1MjoxNEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBPbiAyMDIwLzEyLzQg5LiL5Y2IMTI6MDMsIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBIaSBhbGw6
Cj4+Pgo+Pj4gVGhpcyBzZXJpZXMgdHJpZXMgdG8gaW1wbGVtZW50IGEgdkRQQSBkcml2ZXIgZm9y
IHZpcnRpby1wY2kgZGV2aWNlCj4+PiB3aGljaCB3aWxsIGJyaWRnZSBiZXR3ZWVuIHZEUEEgYnVz
IGFuZCB2aXJ0aW8tcGNpIGRldmljZS4KPj4+Cj4+PiBUaGlzIGNvdWxkIGJlIHVzZWQgZm9yIGZ1
dHVyZSBmZWF0dXJlIHByb3RvdHlwaW5nIGFuZCB0ZXN0aW5nLgo+Pj4KPj4+IFBsZWFzZSByZXZp
ZXcKPj4+Cj4+PiBDaGFuZ2VzIGZyb20gVjI6Cj4+Pgo+Pj4gLSBkb24ndCB0cnkgdG8gdXNlIGRl
dnJlcyBmb3IgdmlydGlvLXBjaSBjb3JlCj4+PiAtIHR3ZWFrIHRoZSBjb21taXQgbG9nCj4+PiAt
IHNwbGl0IHRoZSBwYXRjaGVzIGZ1cnRoZXJseSB0byBlYXNlIHRoZSByZXZpZXdpbmcKPj4+Cj4+
PiBDaGFuZ2VzIGZyb20gVjE6Cj4+Pgo+Pj4gLSBTcGxpdCBjb21tb24gY29kZXMgZnJvbSB2aXJp
dG8tcGNpIGFuZCBzaGFyZSBpdCB3aXRoIHZEUEEgZHJpdmVyCj4+PiAtIFVzZSBkeW5hbWljIGlk
IGluIG9yZGVyIHRvIGJlIGxlc3MgY29uZnVzaW5nIHdpdGggdmlydGlvLXBjaSBkcml2ZXIKPj4+
IC0gTm8gZmVhdHVyZSB3aGl0ZWxpc3QsIHN1cHBvcnRpbmcgYW55IGZlYXR1cmVzIChtcSwgY29u
ZmlnIGV0YykKPj4+Cj4+PiBUaGFua3MKPj4KPj4gTWljaGFlbCwgYW55IGNvbW1lbnQgZm9yIHRo
aXMgc2VyaWVzPwo+Pgo+PiBJdCdzIG5lZWRlZCBmb3IgdGVzdGluZyBkb29yYmVsbCBtYXBwaW5n
IGFuZCBjb25maWcgaW50ZXJydXB0IHN1cHBvcnQuCj4+Cj4+IFRoYW5rcwo+IEkgc2F3IHlvdSBn
b3Qgc29tZSBjb21tZW50cyBiYWNrIGluIGRlY2VtYmVyIHNvIHdhcyBleHBlY3RpbmcgYW5vdGhl
cgo+IHZlcnNpb24uIElmIHlvdSdkIHJhdGhlciBJIHJldmlld2VkIHRoaXMgb25lLCBsZXQgbWUg
a25vdy4KCgpSaWdodC4gU28gSSd2ZSBwb3N0ZWQgYSBuZXcgdmVyc2lvbiB0aGF0IHRyaWVzIHRv
IGFkZHJlc3MgdGhlIHByZXZpb3VzIApjb21tZW50cy4KClBsZWFzZSByZXZpZXcgdGhhdCB2ZXJz
aW9uLgoKVGhhbmtzCgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
