Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23AFC43457
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 07:45:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA3A2087D
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 07:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bq4YDkbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA3A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 645C3873D6;
	Mon, 12 Oct 2020 07:45:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EsMSZnLy5Zvc; Mon, 12 Oct 2020 07:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C31AA873F7;
	Mon, 12 Oct 2020 07:45:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A60A1C07FF;
	Mon, 12 Oct 2020 07:45:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55D6FC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 07:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 40F5586775
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 07:45:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M+HMzhd-lDqM
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 07:45:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 027C986757
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 07:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602488732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdZ3onrXxBOiI/yO33udyhWQa6oD4WfuDiVTG0nr5Kw=;
 b=bq4YDkbHm3y1Qp09+GqshjACwXHMZyNPSxwItiaRw+PGs8RZwooPUYyrmW7PNOLETeuMH7
 rjAt4qJAte257139s1c0Of8djUp4TP+4OKgk7zDOzygNtP4uhku5l27dowL9HEtSMswnHW
 9FyV4gAnFRb8eg4JoEe5XG3+SgaOe4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-sMCUXiNeM6evZkrVbhjnyw-1; Mon, 12 Oct 2020 03:45:28 -0400
X-MC-Unique: sMCUXiNeM6evZkrVbhjnyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD17F108E1C2;
 Mon, 12 Oct 2020 07:45:26 +0000 (UTC)
Received: from [10.72.13.74] (ovpn-13-74.pek2.redhat.com [10.72.13.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8453F10023A7;
 Mon, 12 Oct 2020 07:45:12 +0000 (UTC)
Subject: Re: [RFC PATCH 10/24] vdpa: introduce config operations for
 associating ASID to a virtqueue group
To: Eli Cohen <elic@nvidia.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
 <20200924032125.18619-11-jasowang@redhat.com>
 <20201001132927.GC32363@mtl-vdi-166.wap.labs.mlnx>
 <70af3ff0-74ed-e519-56f5-d61e6a48767f@redhat.com>
 <20201012065931.GA42327@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b1ac150b-0845-874f-75d0-7440133a1d41@redhat.com>
Date: Mon, 12 Oct 2020 15:45:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012065931.GA42327@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, maxime.coquelin@redhat.com,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvMTAvMTIg5LiL5Y2IMjo1OSwgRWxpIENvaGVuIHdyb3RlOgo+IE9uIEZyaSwgT2N0
IDA5LCAyMDIwIGF0IDExOjU2OjQ1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+IE9uIDIw
MjAvMTAvMSDkuIvljYg5OjI5LCBFbGkgQ29oZW4gd3JvdGU6Cj4+PiBPbiBUaHUsIFNlcCAyNCwg
MjAyMCBhdCAxMToyMToxMUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IFRoaXMgcGF0
Y2ggaW50cm9kdWNlcyBhIG5ldyBidXMgb3BlcmF0aW9uIHRvIGFsbG93IHRoZSB2RFBBIGJ1cyBk
cml2ZXIKPj4+PiB0byBhc3NvY2lhdGUgYW4gQVNJRCB0byBhIHZpcnRxdWV1ZSBncm91cC4KPj4+
Pgo+Pj4gU28gaW4gY2FzZSBvZiB2aXJ0aW9fbmV0LCBJIHdvdWxkIGV4cGVjdCB0aGF0IGFsbCB0
aGUgZGF0YSB2aXJ0cXVldWVzCj4+PiB3aWxsIGJlIGFzc29jaWF0ZWQgd2l0aCB0aGUgc2FtZSBh
ZGRyZXNzIHNwYWNlIGlkZW50aWZpZXIuCj4+Cj4+IFJpZ2h0Lgo+Pgo+PiBJIHdpbGwgYWRkIHRo
ZSBjb2RlcyB0byBkbyB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24uIEl0IHNob3VsZCBiZSBtb3Jl
Cj4+IGV4cGxpY2l0IHRoYW4gaGF2ZSB0aGlzIGFzc3VtcHRpb24gYnkgZGVmYXVsdC4KPj4KPj4K
Pj4+IE1vcmVvdmVyLAo+Pj4gdGhpcyBhc3NpZ25tZW50IHNob3VsZCBiZSBwcm92aWRlZCBiZWZv
cmUgdGhlIHNldF9tYXAgY2FsbCB0aGF0IHByb3ZpZGVzCj4+PiB0aGUgaW90bGIgZm9yIHRoZSBh
ZGRyZXNzIHNwYWNlLCBjb3JyZWN0Pwo+Pgo+PiBJIHRoaW5rIGl0J3MgYmV0dGVyIG5vdCBoYXZl
IHRoaXMgbGltaXRhdGlvbiwgbm90ZSB0aGF0IHNldF9tYXAoKSBub3cgdGFrZXMKPj4gYSBhc2lk
IGFyZ3VtZW50Lgo+Pgo+PiBTbyBmb3IgaGFyZHdhcmUgaWYgdGhlIGFzc29jaWF0ZWQgYXMgaXMg
Y2hhbmdlZCwgdGhlIGRyaXZlciBuZWVkcyB0byBwcm9ncmFtCj4+IHRoZSBoYXJkd2FyZSB0byBz
d2l0Y2ggdG8gdGhlIG5ldyBtYXBwaW5nLgo+Pgo+PiBEb2VzIHRoaXMgd29yayBmb3IgbWx4NT8K
Pj4KPiBTbyBpbiB0aGVvcnkgd2UgY2FuIGhhdmUgc2V2ZXJhbCBhc2lkJ3MgKGZvciBkaWZmZXJl
bnQgdmlydHF1ZXVlcyksIGVhY2gKPiBvbmUgc2hvdWxkIGJlIGZvbGxvd2VkIGJ5IGEgc3BlY2lm
aWMgc2V0X21hcCBjYWxsLiBJZiB0aGlzIGlzIHNvLCBob3cgZG8KPiBJIGtub3cgaWYgSSBtZXQg
YWxsIHRoZSBjb25kaXRpb25zIHJ1biBteSBkcml2ZXI/IE1heWJlIHdlIG5lZWQgYW5vdGhlcgo+
IGNhbGxiYWNrIHRvIGxldCB0aGUgZHJpdmVyIGtub3cgaXQgc2hvdWxkIG5vdCBleHBlY3QgbW9y
ZSBzZXRfbWFwcygpLgoKClRoaXMgc2hvdWxkIHdvcmsgc2ltaWxhcmx5IGFzIGluIHRoZSBwYXN0
LiBUd28gcGFydHMgb2YgdGhlIHdvcmsgaXMgCmV4cGVjdGVkIHRvIGJlIGRvbmUgYnkgdGhlIGRy
aXZlcjoKCjEpIHN0b3JlIHRoZSBtYXBwaW5nIHNvbWV3aGVyZSAoZS5nIGhhcmR3YXJlKSBkdXJp
bmcgc2V0X21hcCgpCjIpIGFzc29jaWF0aW5nIG1hcHBpbmcgd2l0aCBhIHNwZWNpZmljIHZpcnRx
dWV1ZQoKVGhlIG9ubHkgZGlmZmVyZW5jZSBpcyB0aGF0IG1vcmUgdGhhbiBvbmUgbWFwcGluZyBp
cyB1c2VkIG5vdy4KCkZvciB0aGUgaXNzdWUgb2YgbW9yZSBzZXRfbWFwcygpLCBkcml2ZXIgc2hv
dWxkIGJlIGFsd2F5cyByZWFkeSBmb3IgdGhlIApuZXcgc2V0X21hcHMoKSBjYWxsIGluc3RlYWQg
b2Ygbm90IGV4cGVjdGluZyBuZXcgc2V0X21hcHMoKSBzaW5jZSBndWVzdCAKbWVtb3J5IHRvcG9s
b2d5IGNvdWxkIGJlIGNoYW5nZWQgZHVlIHRvIHNldmVyYWwgcmVhc29ucy4KClFlbXUgb3Igdmhv
c3QtdkRQQSB3aWxsIHRyeSB0aGVpciBiZXN0IHRvIGF2b2lkIHRoZSBmcmVxdWVuY3kgb2YgCnNl
dF9tYXBzKCkgZm9yIGJldHRlciBwZXJmb3JtYW5jZSAoZS5nIHRocm91Z2ggYmF0Y2hlZCBJT1RM
QiB1cGRhdGluZykuIApFLmcgdGhlcmUgc2hvdWxkIGJlIGF0IG1vc3Qgb25lIHNldF9tYXAoKSBk
dXJpbmcgb25lIHRpbWUgb2YgZ3Vlc3QgYm9vdGluZy4KClRoYW5rcwoKCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
