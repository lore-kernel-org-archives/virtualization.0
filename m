Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB544C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:01:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7C464DE8
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7C464DE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EC1BD85C97;
	Wed, 10 Feb 2021 04:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BYAuARWMYjfH; Wed, 10 Feb 2021 04:01:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DC85885413;
	Wed, 10 Feb 2021 04:01:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C188FC0891;
	Wed, 10 Feb 2021 04:01:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94CCFC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 89C4D870F4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dpz5PYfQcDUy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:00:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6B32B87198
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612929658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LiSar9TAMcy2xRKolsSKppUgJqRDQOLGsEBTg7PEtAM=;
 b=eijp87V0hluKrsNhg95oElBSld3LQxMDXnHfd3ydNTbNzen0veZvbOZ5D+U5PzF4U94E4c
 Fvc57V+QVB2Y2hGsflpKUMOzL4zFOlFrRt2qpTRRQYfmSv5hWxIdtYPU166MsD8g1ezVVQ
 Gegx1lWE3JF4sDhSznWD3iAxCuzqsM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-pat8V0wMPIeyoW0ZjqVYMg-1; Tue, 09 Feb 2021 23:00:56 -0500
X-MC-Unique: pat8V0wMPIeyoW0ZjqVYMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C762189DF4F;
 Wed, 10 Feb 2021 04:00:54 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 830E219C78;
 Wed, 10 Feb 2021 04:00:48 +0000 (UTC)
Subject: Re: [PATCH 3/3] mlx5_vdpa: defer clear_virtqueues to until DRIVER_OK
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, elic@nvidia.com
References: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
 <1612614564-4220-3-git-send-email-si-wei.liu@oracle.com>
 <2e2bc8d7-5d64-c28c-9aa0-1df32c7dcef3@redhat.com>
 <00d3ec60-3635-a5f1-15fc-21e6ce53202b@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ca25b0fd-5871-2543-d802-b10ed2a1d3a4@redhat.com>
Date: Wed, 10 Feb 2021 12:00:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00d3ec60-3635-a5f1-15fc-21e6ce53202b@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi8xMCDkuIrljYg4OjI2LCBTaS1XZWkgTGl1IHdyb3RlOgo+Cj4KPiBPbiAyLzgv
MjAyMSA3OjM3IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiBPbiAyMDIxLzIvNiDkuIvljYg4
OjI5LCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4gV2hpbGUgdmlydHEgaXMgc3RvcHBlZCzCoCBnZXRf
dnFfc3RhdGUoKSBpcyBzdXBwb3NlZCB0bwo+Pj4gYmXCoCBjYWxsZWQgdG/CoCBnZXTCoCBzeW5j
J2VkwqAgd2l0aMKgIHRoZSBsYXRlc3QgaW50ZXJuYWwKPj4+IGF2YWlsX2luZGV4IGZyb20gZGV2
aWNlLiBUaGUgc2F2ZWQgYXZhaWxfaW5kZXggaXMgdXNlZAo+Pj4gdG8gcmVzdGF0ZcKgIHRoZSB2
aXJ0ccKgIG9uY2UgZGV2aWNlIGlzIHN0YXJ0ZWQuwqAgQ29tbWl0Cj4+PiBiMzVjY2ViZTNlZjcg
aW50cm9kdWNlZCB0aGUgY2xlYXJfdmlydHF1ZXVlcygpIHJvdXRpbmUKPj4+IHRvwqAgcmVzZXTC
oCB0aGUgc2F2ZWTCoCBhdmFpbF9pbmRleCzCoCBob3dldmVyLCB0aGUgaW5kZXgKPj4+IGdldHMg
Y2xlYXJlZCBhIGJpdCBlYXJsaWVyIGJlZm9yZSBnZXRfdnFfc3RhdGUoKSB0cmllcwo+Pj4gdG8g
cmVhZCBpdC4gVGhpcyB3b3VsZCBjYXVzZSBjb25zaXN0ZW5jeSBwcm9ibGVtcyB3aGVuCj4+PiB2
aXJ0cSBpcyByZXN0YXJ0ZWQsIGUuZy4gdGhyb3VnaCBhIHNlcmllcyBvZiBsaW5rIGRvd24KPj4+
IGFuZCBsaW5rIHVwIGV2ZW50cy4gV2XCoCBjb3VsZMKgIGRlZmVywqAgdGhlwqAgY2xlYXJpbmcg
b2YKPj4+IGF2YWlsX2luZGV4wqAgdG/CoCB1bnRpbMKgIHRoZcKgIGRldmljZcKgIGlzIHRvIGJl
IHN0YXJ0ZWQsCj4+PiBpLmUuIHVudGlswqAgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PS8KgIGlz
IHNldCBhZ2FpbiBpbgo+Pj4gc2V0X3N0YXR1cygpLgo+Pj4KPj4+IEZpeGVzOiBiMzVjY2ViZTNl
ZjcgKCJ2ZHBhL21seDU6IFJlc3RvcmUgdGhlIGhhcmR3YXJlIHVzZWQgaW5kZXggCj4+PiBhZnRl
ciBjaGFuZ2UgbWFwIikKPj4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jIHwgMiArLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYyAKPj4+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+PiBpbmRleCBh
YTZmOGNkLi40NDRhYjU4IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jCj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+
IEBAIC0xNzg1LDcgKzE3ODUsNiBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X3N0YXR1cyhz
dHJ1Y3QgCj4+PiB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKQo+Pj4gwqDCoMKgwqDCoCBp
ZiAoIXN0YXR1cykgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIG1seDVfdmRwYV9pbmZvKG12ZGV2
LCAicGVyZm9ybWluZyBkZXZpY2UgcmVzZXRcbiIpOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHRl
YXJkb3duX2RyaXZlcihuZGV2KTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBjbGVhcl92aXJ0cXVldWVz
KG5kZXYpOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIG1seDVfdmRwYV9kZXN0cm95X21yKCZuZGV2
LT5tdmRldik7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbmRldi0+bXZkZXYuc3RhdHVzID0gMDsK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCArK212ZGV2LT5nZW5lcmF0aW9uOwo+Pj4gQEAgLTE3OTQs
NiArMTc5Myw3IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCAKPj4+
IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpCj4+PiDCoCDCoMKgwqDCoMKgIGlmICgoc3Rh
dHVzIF4gbmRldi0+bXZkZXYuc3RhdHVzKSAmIAo+Pj4gVklSVElPX0NPTkZJR19TX0RSSVZFUl9P
Sykgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChzdGF0dXMgJiBWSVJUSU9fQ09ORklHX1Nf
RFJJVkVSX09LKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbGVhcl92aXJ0cXVldWVz
KG5kZXYpOwo+Pgo+Pgo+PiBSZXRoaW5rIGFib3V0IHRoaXMuIEFzIG1lbnRpb25lZCBpbiBhbm90
aGVyIHRocmVhZCwgdGhpcyBpbiBmYWN0IAo+PiBicmVha3Mgc2V0X3ZxX3N0YXRlKCkuwqAgKFNl
ZSB2aG9zdF92aXJ0cXVldWVfc3RhcnQoKSAtPiAKPj4gdmhvc3RfdmRwYV9zZXRfdnJpbmdfYmFz
ZSgpIGluIHFlbXUgY29kZXMpLgo+IEkgYXNzdW1lIHRoYXQgdGhlIGNsZWFyaW5nIGZvciB2aG9z
dC12ZHBhIHdvdWxkIGJlIGRvbmUgdmlhIChxZW11IGNvZGUpLAo+Cj4gdmhvc3RfZGV2X3N0YXJ0
KCktPnZob3N0X3ZkcGFfZGV2X3N0YXJ0KCktPnZob3N0X3ZkcGFfY2FsbChzdGF0dXMgfCAKPiBW
SVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKQo+Cj4gd2hpY2ggaXMgX2FmdGVyXyB2aG9zdF92aXJ0
cXVldWVfc3RhcnQoKSBnZXRzIGNhbGxlZCB0byByZXN0b3JlIHRoZSAKPiBhdmFpbF9pZHggdG8g
aC93IGluIHZob3N0X2Rldl9zdGFydCgpLiBXaGF0IGFtIEkgbWlzc2luZyBoZXJlPwo+Cj4gLVNp
d2VpCgoKSSB0aGluayBub3QuIEkgdGhvdWdodCBjbGVhcl92aXJ0cXVldWVzKCkgd2lsbCBjbGVh
ciBoYXJkd2FyZSBpbmRleCBidXQgCmxvb2tzIG5vdC4gKEkgZ3Vlc3Mgd2UgbmVlZCBhIGJldHRl
ciBuYW1lIG90aGVyIHRoYW4gY2xlYXJfdmlydHF1ZXVlcygpLCAKZS5nIGZyb20gdGhlIG5hbWUg
aXQgbG9va3MgbGlrZSB0aGUgaXQgd2lsbCBjbGVhciB0aGUgaGFyZHdhcmUgc3RhdGVzKQoKVGhh
bmtzCgoKPgo+Cj4+Cj4+IFRoZSBpc3N1ZSBpcyB0aGF0IHRoZSBhdmFpbCBpZHggaXMgZm9yZ290
LCB3ZSBuZWVkIGtlZXAgaXQuCj4+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZXJyID0gc2V0dXBfZHJpdmVyKG5kZXYpOwo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKGVycikgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtbHg1X3ZkcGFfd2FybihtdmRldiwgImZhaWxlZCB0byBzZXR1cCBkcml2ZXJcbiIpOwo+
Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
