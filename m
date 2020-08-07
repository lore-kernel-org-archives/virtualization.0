Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5191FC433E0
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:04:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3132B221E2
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVmkxO5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3132B221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E0F238867B;
	Fri,  7 Aug 2020 03:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IxsTnB2+SIkO; Fri,  7 Aug 2020 03:04:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 56C748863D;
	Fri,  7 Aug 2020 03:04:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38BAEC0051;
	Fri,  7 Aug 2020 03:04:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADFE4C004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:04:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 96D3D88662
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u3PkbsNCslDO
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:04:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ACDAF8863D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596769486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdOpBjCOVkquS5JtoOdSjXeW1osIHL7KNsSvy/tC5XQ=;
 b=OVmkxO5tYQye9xvQs1JjLKVg2PGjIBymQqDpPz3qJoIoneGa5fKFzDxgh3GmOtsnyrT0R3
 A4lITw/5xeeFgyr2eKhQohG3Xtvku8B651wN4UY+W8Q2cDAg5oQ1rjdEJIyH39IaDp0M1H
 TBVU7Hvs8DlO2CpdQW4adldABODCujM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-olBv4X8GPxauTGFiSuf8pw-1; Thu, 06 Aug 2020 23:04:42 -0400
X-MC-Unique: olBv4X8GPxauTGFiSuf8pw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D8B0106B242;
 Fri,  7 Aug 2020 03:04:40 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5C597B927;
 Fri,  7 Aug 2020 03:04:32 +0000 (UTC)
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
To: Eli Cohen <eli@mellanox.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200806121002.GA171574@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e9730008-0f3f-c986-0055-e83578961896@redhat.com>
Date: Fri, 7 Aug 2020 11:04:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806121002.GA171574@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Shahaf Shuler <shahafs@mellanox.com>, "lulu@redhat.com" <lulu@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "mhabets@solarflare.com" <mhabets@solarflare.com>,
 "vmireyno@marvell.com" <vmireyno@marvell.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "gdawar@xilinx.com" <gdawar@xilinx.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "hanand@xilinx.com" <hanand@xilinx.com>,
 "zhangweining@ruijie.com.cn" <zhangweining@ruijie.com.cn>,
 "saugatm@xilinx.com" <saugatm@xilinx.com>,
 "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
 "rob.miller@broadcom.com" <rob.miller@broadcom.com>
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

Ck9uIDIwMjAvOC82IOS4i+WNiDg6MTAsIEVsaSBDb2hlbiB3cm90ZToKPiBPbiBXZWQsIEp1biAx
NywgMjAyMCBhdCAwNjoyOTo0NEFNICswMzAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBUaGlzIHBh
dGNoIGludHJvZHVjZSBhIGNvbmZpZyBvcCB0byBnZXQgdmFsaWQgaW92YSByYW5nZSBmcm9tIHRo
ZSB2RFBBCj4+IGRldmljZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZzxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgo+PiAtLS0KPj4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDE0ICsrKysr
KysrKysrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKPj4KPj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4g
aW5kZXggMjM5ZGI3OTQzNTdjLi5iNzYzM2VkMjUwMGMgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUv
bGludXgvdmRwYS5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+IEBAIC00MSw2ICs0
MSwxNiBAQCBzdHJ1Y3QgdmRwYV9kZXZpY2Ugewo+PiAgIAl1bnNpZ25lZCBpbnQgaW5kZXg7Cj4+
ICAgfTsKPj4gICAKPj4gKy8qKgo+PiArICogdkRQQSBJT1ZBIHJhbmdlIC0gdGhlIElPVkEgcmFu
Z2Ugc3VwcG9ydCBieSB0aGUgZGV2aWNlCj4+ICsgKiBAc3RhcnQ6IHN0YXJ0IG9mIHRoZSBJT1ZB
IHJhbmdlCj4+ICsgKiBAZW5kOiBlbmQgb2YgdGhlIElPVkEgcmFuZ2UKPj4gKyAqLwo+PiArc3Ry
dWN0IHZkcGFfaW92YV9yYW5nZSB7Cj4+ICsJdTY0IHN0YXJ0Owo+PiArCXU2NCBlbmQ7Cj4+ICt9
Owo+PiArCj4gV2hhdCBkbyB5b3UgZG8gd2l0aCB0aGlzIGluZm9ybWF0aW9uPyBTdXBwb3NlIHNv
bWUgZGV2aWNlIHRlbGxzIHlvdSBpdAo+IHN1cHBvcnRzIHNvbWUgbGltaXRlZCByYW5nZSwgc2F5
LCBmcm9tIDB4NDAwMDAwMDAgdG8gMHg4MDAwMDAwMC4gV2hhdAo+IGRvZXMgcWVtdSBkbyB3aXRo
IHRoaXMgaW5mb3JtYXRpb24/CgoKRm9yIHFlbXUsIHdoZW4gcWVtdSB3aWxsIGZhaWwgdGhlIHZE
UEEgZGV2aWNlIGNyZWF0aW9uIHdoZW46CgoxKSB2SU9NTVUgaXMgbm90IGVuYWJsZWQgYW5kIEdQ
QSBpcyBvdXQgb2YgdGhpcyByYW5nZQoyKSB2SU9NTVUgaXMgZW5hYmxlZCBidXQgaXQgY2FuJ3Qg
cmVwb3J0IHN1Y2ggcmFuZ2UgdG8gZ3Vlc3QKCkZvciBvdGhlciB1c2Vyc3BhY2UgYXBwbGljYXRp
b24sIGl0IHdpbGwga25vdyBpdCBjYW4gb25seSB1c2UgdGhpcyByYW5nZSAKYXMgaXRzIElPVkEu
CgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
