Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F88DC433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 03:12:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00291206C2
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 03:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00291206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7FEC285A80;
	Tue, 12 Jan 2021 03:12:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LBXd_Q91KJLz; Tue, 12 Jan 2021 03:12:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E984B859D9;
	Tue, 12 Jan 2021 03:12:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCAAEC0893;
	Tue, 12 Jan 2021 03:12:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BC79C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 03:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8D557859EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 03:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t9xqWJYQvhZB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 03:12:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 49E74859D9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 03:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610421132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EuO0KkAWEORR9LXclbclk1TcGomO+Sw1YafkcEF0DvM=;
 b=cABIErmoyVdr7w9kLzgXinQ5aTap9MogbvMR3m+qvCWTkU3ggTYDsKV9TMdZs2mw56uKqp
 Ei/piqXvQP0K9HxfrydueXshuq3O+kFy4GOTPhrGTaIuKd7wtvzu8k0a3IAxV1p+GyB8d8
 Y3lKJw4+bmNw1kKBfPqye22Fe0cdaHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-3kppubIDNlibVpEQZ58Tow-1; Mon, 11 Jan 2021 22:12:10 -0500
X-MC-Unique: 3kppubIDNlibVpEQZ58Tow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AF13801FC4;
 Tue, 12 Jan 2021 03:12:08 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96FEE60BE2;
 Tue, 12 Jan 2021 03:11:54 +0000 (UTC)
Subject: Re: [PATCH 21/21] vdpasim: control virtqueue support
To: Eli Cohen <elic@nvidia.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216064818.48239-22-jasowang@redhat.com>
 <20210111122601.GA172492@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <da50981b-6bbc-ee61-b5b1-a57a09da8e93@redhat.com>
Date: Tue, 12 Jan 2021 11:11:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111122601.GA172492@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 stefanha@redhat.com, eli@mellanox.com, lingshan.zhu@intel.com,
 rob.miller@broadcom.com
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

Ck9uIDIwMjEvMS8xMSDkuIvljYg4OjI2LCBFbGkgQ29oZW4gd3JvdGU6Cj4gT24gV2VkLCBEZWMg
MTYsIDIwMjAgYXQgMDI6NDg6MThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gVGhpcyBw
YXRjaCBpbnRyb2R1Y2VzIHRoZSBjb250cm9sIHZpcnRxdWV1ZSBzdXBwb3J0IGZvciB2RFBBCj4+
IHNpbXVsYXRvci4gVGhpcyBpcyBhIHJlcXVpcmVtZW50IGZvciBzdXBwb3J0aW5nIGFkdmFuY2Vk
IGZlYXR1cmVzIGxpa2UKPj4gbXVsdGlxdWV1ZS4KPj4KPj4gQSByZXF1aXJlbWVudCBmb3IgY29u
dHJvbCB2aXJ0cXVldWUgaXMgdG8gaXNvbGF0ZSBpdHMgbWVtb3J5IGFjY2Vzcwo+PiBmcm9tIHRo
ZSByeC90eCB2aXJ0cXVldWVzLiBUaGlzIGlzIGJlY2F1c2Ugd2hlbiB1c2luZyB2RFBBIGRldmlj
ZQo+PiBmb3IgVk0sIHRoZSBjb250cm9sIHZpcnF1ZXVlIGlzIG5vdCBkaXJlY3RseSBhc3NpZ25l
ZCB0byBWTS4gVXNlcnNwYWNlCj4+IChRZW11KSB3aWxsIHByZXNlbnQgYSBzaGFkb3cgY29udHJv
bCB2aXJ0cXVldWUgdG8gY29udHJvbCBmb3IKPj4gcmVjb3JkaW5nIHRoZSBkZXZpY2Ugc3RhdGVz
Lgo+Pgo+PiBUaGUgaXNvbGF0aW9uIGlzIGRvbmUgdmlhIHRoZSB2aXJ0cXVldWUgZ3JvdXBzIGFu
ZCBBU0lEIHN1cHBvcnQgaW4KPj4gdkRQQSB0aHJvdWdoIHZob3N0LXZkcGEuIFRoZSBzaW11bGF0
b3IgaXMgZXh0ZW5kZWQgdG8gaGF2ZToKPj4KPj4gMSkgdGhyZWUgdmlydHF1ZXVlczogUlhWUSwg
VFhWUSBhbmQgQ1ZRIChjb250cm9sIHZpcnRxdWV1ZSkKPj4gMikgdHdvIHZpcnRxdWV1ZSBncm91
cHM6IGdyb3VwIDAgY29udGFpbnMgUlhWUSBhbmQgVFhWUTsgZ3JvdXAgMQo+PiAgICAgY29udGFp
bnMgQ1ZRCj4+IDMpIHR3byBhZGRyZXNzIHNwYWNlcyBhbmQgdGhlIHNpbXVsYXRvciBzaW1wbHkg
aW1wbGVtZW50cyB0aGUgYWRkcmVzcwo+PiAgICAgc3BhY2VzIGJ5IG1hcHBpbmcgaXQgMToxIHRv
IElPVExCLgo+Pgo+PiBGb3IgdGhlIFZNIHVzZSBjYXNlcywgdXNlcnNwYWNlKFFlbXUpIG1heSBz
ZXQgQVMgMCB0byBncm91cCAwIGFuZCBBUyAxCj4+IHRvIGdyb3VwIDEuIFNvIHdlIGhhdmU6Cj4+
Cj4+IDEpIFRoZSBJT1RMQiBmb3IgdmlydHF1ZXVlIGdyb3VwIDAgY29udGFpbnMgdGhlIG1hcHBp
bmdzIG9mIGd1ZXN0LCBzbwo+PiAgICAgUlggYW5kIFRYIGNhbiBiZSBhc3NpZ25lZCB0byBndWVz
dCBkaXJlY3RseS4KPj4gMikgVGhlIElPVExCIGZvciB2aXJ0cXVldWUgZ3JvdXAgMSBjb250YWlu
cyB0aGUgbWFwcGluZ3Mgb2YgQ1ZRIHdoaWNoCj4+ICAgICBpcyB0aGUgYnVmZmVycyB0aGF0IGFs
bG9jYXRlZCBhbmQgbWFuYWdlZCBieSBWTU0gb25seS4gU28gQ1ZRIG9mCj4+ICAgICB2aG9zdC12
ZHBhIGlzIHZpc2libGUgdG8gVk1NIG9ubHkuIEFuZCBHdWVzdCBjYW4gbm90IGFjY2VzcyB0aGUg
Q1ZRCj4+ICAgICBvZiB2aG9zdC12ZHBhLgo+Pgo+PiBGb3IgdGhlIG90aGVyIHVzZSBjYXNlcywg
c2luY2UgQVMgMCBpcyBhc3NvY2lhdGVkIHRvIGFsbCB2aXJ0cXVldWUKPj4gZ3JvdXBzIGJ5IGRl
ZmF1bHQuIEFsbCB2aXJ0cXVldWVzIHNoYXJlIHRoZSBzYW1lIG1hcHBpbmcgYnkgZGVmYXVsdC4K
Pj4KPj4gVG8gZGVtb25zdHJhdGUgdGhlIGZ1bmN0aW9uLCBWSVJJVE9fTkVUX0ZfQ1RSTF9NQUNB
RERSIGlzCj4+IGltcGxlbWVudGVkIGluIHRoZSBzaW11bGF0b3IgZm9yIHRoZSBkcml2ZXIgdG8g
c2V0IG1hYyBhZGRyZXNzLgo+Pgo+IEhpIEphc29uLAo+Cj4gaXMgdGhlcmUgYW55IHZlcnNpb24g
b2YgcWVtdS9saWJ2aXJ0IGF2YWlsYWJsZSB0aGF0IEkgY2FuIHNlZSB0aGUKPiBjb250cm9sIHZp
cnRxdWV1ZSB3b3JraW5nIGluIGFjdGlvbj8KCgpOb3QgeWV0LCB0aGUgcWVtdSBwYXJ0IGRlcGVu
ZHMgb24gdGhlIHNoYWRvdyB2aXJ0cXVldWUgd29yayBvZiBFdWdlbmlvLiAKQnV0IGl0IHdpbGwg
d29yayBhczoKCjEpIHFlbXUgd2lsbCB1c2UgYSBzZXBhcmF0ZWQgYWRkcmVzcyBzcGFjZSBmb3Ig
dGhlIGNvbnRyb2wgdmlydHF1ZXVlIAooc2hhZG93KSBleHBvc2VkIHRocm91Z2ggdmhvc3QtdkRQ
QQoyKSB0aGUgY29tbWFuZHMgc2VudCB0aHJvdWdoIGNvbnRyb2wgdmlydHF1ZXVlIGJ5IGd1ZXN0
IGRyaXZlciB3aWxsIAppbnRlcmNlcHQgYnkgcWVtdQozKSBRZW11IHdpbGwgc2VuZCB0aG9zZSBj
b21tYW5kcyB0byB0aGUgc2hhZG93IGNvbnRyb2wgdmlydHF1ZXVlCgpFdWdlbmlvLCBhbnkgRVRB
IGZvciB0aGUgbmV3IHZlcnNpb24gb2Ygc2hhZG93IHZpcnRxdWV1ZSBzdXBwb3J0IGluIFFlbXU/
CgpUaGFua3MKCgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
