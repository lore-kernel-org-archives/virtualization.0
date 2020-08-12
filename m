Return-Path: <SRS0=QAK1=BW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60660C433DF
	for <virtualization@archiver.kernel.org>; Wed, 12 Aug 2020 02:02:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155FE206DA
	for <virtualization@archiver.kernel.org>; Wed, 12 Aug 2020 02:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9UocYj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155FE206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D036088343;
	Wed, 12 Aug 2020 02:02:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P0xqESPvnUNY; Wed, 12 Aug 2020 02:02:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7A76A8830F;
	Wed, 12 Aug 2020 02:02:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37E72C013C;
	Wed, 12 Aug 2020 02:02:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A9C2C004D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 02:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1C42488341
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 02:02:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZmD8pY3GuYAr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 02:02:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 201358830F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 02:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597197760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoZ/EBZIxsgZT3jW1Je1ueNMDaBxzDlPbn95xarnJ6M=;
 b=I9UocYj1MQRM+pi23K0PWpoYyoiarzHYOEbp2/MFbkDGl0ig0dzPqpX53j85jSbZ78kIF8
 4wIgHltOS8ieXJvX3B4UN/OcTLZmc5EPykQed0aaKikQAiRVB+XAKkCBNmE26Q+A7PUt8G
 sk2td0E3xt0JdMLWziU4J2y799y/L/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-odOuMVZWOCqDs1ztjQP2JA-1; Tue, 11 Aug 2020 22:02:38 -0400
X-MC-Unique: odOuMVZWOCqDs1ztjQP2JA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6AC5E921;
 Wed, 12 Aug 2020 02:02:36 +0000 (UTC)
Received: from [10.72.12.118] (ovpn-12-118.pek2.redhat.com [10.72.12.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 983C61A7CF;
 Wed, 12 Aug 2020 02:02:27 +0000 (UTC)
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
 <20200806082727-mutt-send-email-mst@kernel.org>
 <20200806124354.GA172661@mtl-vdi-166.wap.labs.mlnx>
 <20200810080410-mutt-send-email-mst@kernel.org>
 <2d1e6278-e57e-c340-399e-40ff102c74a3@redhat.com>
 <20200811042733-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9effa14f-e305-2fa0-5aa6-83b146b969e0@redhat.com>
Date: Wed, 12 Aug 2020 10:02:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811042733-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 Eli Cohen <eli@mellanox.com>, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvOC8xMSDkuIvljYg0OjI5LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
VHVlLCBBdWcgMTEsIDIwMjAgYXQgMTA6NTM6MDlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gT24gMjAyMC84LzEwIOS4i+WNiDg6MDUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+
IE9uIFRodSwgQXVnIDA2LCAyMDIwIGF0IDAzOjQzOjU0UE0gKzAzMDAsIEVsaSBDb2hlbiB3cm90
ZToKPj4+PiBPbiBUaHUsIEF1ZyAwNiwgMjAyMCBhdCAwODoyOToyMkFNIC0wNDAwLCBNaWNoYWVs
IFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+IE9uIFRodSwgQXVnIDA2LCAyMDIwIGF0IDAzOjAzOjU1
UE0gKzAzMDAsIEVsaSBDb2hlbiB3cm90ZToKPj4+Pj4+IE9uIFdlZCwgQXVnIDA1LCAyMDIwIGF0
IDA4OjUxOjU2QU0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+Pj4+PiBPbiBX
ZWQsIEp1biAxNywgMjAyMCBhdCAxMToyOTo0NEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
Pj4+Pj4+PiBUaGlzIHBhdGNoIGludHJvZHVjZSBhIGNvbmZpZyBvcCB0byBnZXQgdmFsaWQgaW92
YSByYW5nZSBmcm9tIHRoZSB2RFBBCj4+Pj4+Pj4+IGRldmljZS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4g
U2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZzxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4+Pj4+PiAt
LS0KPj4+Pj4+Pj4gICAgaW5jbHVkZS9saW51eC92ZHBhLmggfCAxNCArKysrKysrKysrKysrKwo+
Pj4+Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQo+Pj4+Pj4+Pgo+Pj4+
Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3Zk
cGEuaAo+Pj4+Pj4+PiBpbmRleCAyMzlkYjc5NDM1N2MuLmI3NjMzZWQyNTAwYyAxMDA2NDQKPj4+
Pj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+Pj4+Pj4gKysrIGIvaW5jbHVkZS9s
aW51eC92ZHBhLmgKPj4+Pj4+Pj4gQEAgLTQxLDYgKzQxLDE2IEBAIHN0cnVjdCB2ZHBhX2Rldmlj
ZSB7Cj4+Pj4+Pj4+ICAgIAl1bnNpZ25lZCBpbnQgaW5kZXg7Cj4+Pj4+Pj4+ICAgIH07Cj4+Pj4+
Pj4+ICsvKioKPj4+Pj4+Pj4gKyAqIHZEUEEgSU9WQSByYW5nZSAtIHRoZSBJT1ZBIHJhbmdlIHN1
cHBvcnQgYnkgdGhlIGRldmljZQo+Pj4+Pj4+PiArICogQHN0YXJ0OiBzdGFydCBvZiB0aGUgSU9W
QSByYW5nZQo+Pj4+Pj4+PiArICogQGVuZDogZW5kIG9mIHRoZSBJT1ZBIHJhbmdlCj4+Pj4+Pj4+
ICsgKi8KPj4+Pj4+Pj4gK3N0cnVjdCB2ZHBhX2lvdmFfcmFuZ2Ugewo+Pj4+Pj4+PiArCXU2NCBz
dGFydDsKPj4+Pj4+Pj4gKwl1NjQgZW5kOwo+Pj4+Pj4+PiArfTsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+
IFRoaXMgaXMgYW1iaWd1b3VzLiBJcyBlbmQgaW4gdGhlIHJhbmdlIG9yIGp1c3QgYmVoaW5kIGl0
Pwo+Pj4+Pj4+IEhvdyBhYm91dCBmaXJzdC9sYXN0Pwo+Pj4+Pj4gSXQgaXMgY3VzdG9tYXJ5IGlu
IHRoZSBrZXJuZWwgdG8gdXNlIHN0YXJ0LWVuZCB3aGVyZSBlbmQgY29ycmVzcG9uZHMgdG8KPj4+
Pj4+IHRoZSBieXRlIGZvbGxvd2luZyB0aGUgbGFzdCBpbiB0aGUgcmFuZ2UuIFNlZSBzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QKPj4+Pj4+IHZtX3N0YXJ0IGFuZCB2bV9lbmQgZmllbGRzCj4+Pj4+IEV4
YWN0bHkgbXkgcG9pbnQ6Cj4+Pj4+Cj4+Pj4+IGluY2x1ZGUvbGludXgvbW1fdHlwZXMuaDogICAg
ICAgdW5zaWduZWQgbG9uZyB2bV9lbmQ7ICAgICAgICAgICAvKiBUaGUgZmlyc3QgYnl0ZSBhZnRl
ciBvdXIgZW5kIGFkZHJlc3MKPj4+Pj4KPj4+Pj4gaW4gdGhpcyBjYXNlIEphc29uIHdhbnRzIGl0
IHRvIGJlIHRoZSBsYXN0IGJ5dGUsIG5vdCBvbmUgYmVoaW5kLgo+Pj4+Pgo+Pj4+Pgo+Pj4+IE1h
eWJlIHN0YXJ0LCBzaXplPyBOb3QgYW1iaWd1b3VzLCBhbmQgeW91IGRvbid0IG5lZWQgdG8gZG8g
YW5ub3lpbmcKPj4+PiBjYWxjdWxhdGlvbnMgbGlrZSBzaXplID0gbGFzdCAtIHN0YXJ0ICsgMQo+
Pj4gU2l6ZSBoYXMgYSBidW5jaCBvZiBpc3N1ZXM6IGNhbiBvdmVybGFwLCBjYW4gbm90IGNvdmVy
IHRoZSBlbnRpcmUgNjQgYml0Cj4+PiByYW5nZS4gVGhlIHJlcXVpc2l0ZSBjaGVja3MgYXJlIGFy
Z3VhYmx5IGVhc2llciB0byBnZXQgd3JvbmcgdGhhbgo+Pj4gZ2V0dGluZyB0aGUgc2l6ZSBpZiB5
b3UgbmVlZCBpdC4KPj4gWWVzLCBzbyBkbyB5b3Ugc3RpbGwgcHJlZmVyIGZpcnN0L2xhc3Qgb3Ig
anVzdCBiZWdpbi9lbmQgd2hpY2ggaXMgY29uc2lzdGVudAo+PiB3aXRoIGlvbW11X2RvbWFpbl9n
ZW9tZXRyeT8KPj4KPj4gVGhhbmtzCj4gSSBwcmVmZXIgZmlyc3QvbGFzdCBJIHRoaW5rLCB0aGVz
ZSBhcmUgdW5hbWJpZ3VvdXMuCj4gRS5nLgo+Cj4gICAgICAgICAgZG1hX2FkZHJfdCBhcGVydHVy
ZV9zdGFydDsgLyogRmlyc3QgYWRkcmVzcyB0aGF0IGNhbiBiZSBtYXBwZWQgICAgKi8KPiAgICAg
ICAgICBkbWFfYWRkcl90IGFwZXJ0dXJlX2VuZDsgICAvKiBMYXN0IGFkZHJlc3MgdGhhdCBjYW4g
YmUgbWFwcGVkICAgICAqLwo+Cj4gaW5zdGVhZCBvZiBhZGRyZXNzaW5nIGFtYmlndWl0eSB3aXRo
IGEgY29tbWVudCwgbGV0J3MganVzdCBuYW1lIHRoZSBmaWVsZCB3ZWxsLgoKCk9rLCB3aWxsIGRv
LgoKVGhhbmtzCgoKCj4KPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
