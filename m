Return-Path: <SRS0=bMq5=D5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC11C388F7
	for <virtualization@archiver.kernel.org>; Thu, 22 Oct 2020 05:47:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA84020FC3
	for <virtualization@archiver.kernel.org>; Thu, 22 Oct 2020 05:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X24RHM3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA84020FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2FB7A86B25;
	Thu, 22 Oct 2020 05:47:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DBew_ny0TkPo; Thu, 22 Oct 2020 05:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2366286A22;
	Thu, 22 Oct 2020 05:47:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 102BCC08A1;
	Thu, 22 Oct 2020 05:47:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74767C0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 05:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6810287467
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 05:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QvoQPUWfIYyO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 05:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C451087223
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 05:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603345661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4B//qnaxTvyagU4Ta4XmHD0G1WDTvcCQn1ISIno4ag=;
 b=X24RHM3yjD55bQgewiBGa2mzAm25UMg1eQlzCUAKOI/WfKXnd60Gmt5Jb1ioMFuyJJlnEJ
 5bm+yIktqYgIaFORKkwoDU7rWLL7dIPLAXy8pBLpY6eexIZrsuo65sVtx+CC6qbhEy+FAa
 23rcrjEVQlCt96ueFVnRqYKQ+ATHPlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-24ki4_b3MOywOgsTgU-wwA-1; Thu, 22 Oct 2020 01:47:37 -0400
X-MC-Unique: 24ki4_b3MOywOgsTgU-wwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A3F98797F6;
 Thu, 22 Oct 2020 05:47:34 +0000 (UTC)
Received: from [10.72.13.119] (ovpn-13-119.pek2.redhat.com [10.72.13.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA8CD5C1C7;
 Thu, 22 Oct 2020 05:47:25 +0000 (UTC)
Subject: Re: [PATCH 0/4] vDPA: API for reporting IOVA range
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20201021104508-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <09525e8b-2c7a-de5d-128a-79b5b0725224@redhat.com>
Date: Thu, 22 Oct 2020 13:47:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021104508-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvMTAvMjEg5LiL5Y2IMTA6NDUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBP
biBXZWQsIEp1biAxNywgMjAyMCBhdCAxMToyOTo0M0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiBIaSBBbGw6Cj4+Cj4+IFRoaXMgc2VyaWVzIGludHJvZHVjZXMgQVBJIGZvciByZXBvcmlu
ZyBJT1ZBIHJhbmdlLiBUaGlzIGlzIGEgbXVzdCBmb3IKPj4gdXNlcnNwYWNlIHRvIHdvcmsgY29y
cmVjbHR5Ogo+Pgo+PiAtIGZvciB0aGUgcHJvY2VzcyB0aGF0IHVzZXMgdmhvc3QtdkRQQSBkaXJl
Y3RseSB0byBwcm9wZXJseSBhbGxvY2F0ZQo+PiAgICBJT1ZBCj4+IC0gZm9yIFZNKHFlbXUpLCB3
aGVuIHZJT01NVSBpcyBub3QgZW5hYmxlZCwgZmFpbCBlYXJseSBpZiBHUEEgaXMgb3V0Cj4+ICAg
IG9mIHJhbmdlCj4+IC0gZm9yIFZNKHFlbXUpLCB3aGVuIHZJT01NVSBpcyBlbmFibGVkLCBkZXRl
cm1pbmUgYSB2YWxpZCBndWVzdAo+PiAgICBhZGRyZXNzIHdpZHRoCj4+Cj4+IFBsZWFzZSByZXZp
ZXcuCj4+Cj4+IFRoYW5rcwo+IE9LIHNvIHdoYXQgaXMgdGhlIHBsYW4gaGVyZT8gQ2hhbmdlIGJl
Z2luLWVuZC0+Zmlyc3QtbGFzdCBhbmQgcmVwb3N0PwoKCkkndmUgcG9zdGVkIFYyIHdpdGggdGhp
cyBjaGFuZ2UsIGJ1dCBpdCBnZXQgc29tZSB3YXJuaW5nIGZvciBidWlsZGJvdC4KCldpbGwgcG9z
dCBhIFYzLgoKVGhhbmtzCgoKPgo+PiBKYXNvbiBXYW5nICg0KToKPj4gICAgdmRwYTogaW50cm9k
dWNlIGNvbmZpZyBvcCB0byBnZXQgdmFsaWQgaW92YSByYW5nZQo+PiAgICB2ZHBhX3NpbTogaW1w
bGVtZW50IGdldF9pb3ZhX3JhbmdlIGJ1cyBvcGVyYXRpb24KPj4gICAgdmRwYTogZ2V0X2lvdmFf
cmFuZ2UoKSBpcyBtYW5kYXRvcnkgZm9yIGRldmljZSBzcGVjaWZpYyBETUEKPj4gICAgICB0cmFu
c2xhdGlvbgo+PiAgICB2aG9zdDogdmRwYTogcmVwb3J0IGlvdmEgcmFuZ2UKPj4KPj4gICBkcml2
ZXJzL3ZkcGEvdmRwYS5jICAgICAgICAgICAgICB8ICA0ICsrKysKPj4gICBkcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW0uYyB8IDExICsrKysrKysrKysrCj4+ICAgZHJpdmVycy92aG9zdC92
ZHBhLmMgICAgICAgICAgICAgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gICBp
bmNsdWRlL2xpbnV4L3ZkcGEuaCAgICAgICAgICAgICB8IDE0ICsrKysrKysrKysrKysrCj4+ICAg
aW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmggICAgICAgfCAgNCArKysrCj4+ICAgaW5jbHVkZS91
YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggfCAgNSArKysrKwo+PiAgIDYgZmlsZXMgY2hhbmdlZCwg
NjUgaW5zZXJ0aW9ucygrKQo+Pgo+PiAtLSAKPj4gMi4yMC4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
