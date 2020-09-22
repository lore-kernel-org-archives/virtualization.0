Return-Path: <SRS0=wpUj=C7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF604C4346E
	for <virtualization@archiver.kernel.org>; Tue, 22 Sep 2020 02:01:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A63E23A60
	for <virtualization@archiver.kernel.org>; Tue, 22 Sep 2020 02:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW76IBnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A63E23A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BCAED214FD;
	Tue, 22 Sep 2020 02:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kBnOzIvcKIHB; Tue, 22 Sep 2020 02:01:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 501FF2079A;
	Tue, 22 Sep 2020 02:01:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB71C0889;
	Tue, 22 Sep 2020 02:01:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7734CC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 02:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7069F8598A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 02:01:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U2bQ8fHu7KC3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 02:01:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5F7A58476C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 02:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600740084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tzo+iSLdl/HV45jduxk4SIxbpvPEBNGD2dSVt98peB0=;
 b=EW76IBnIrwvmpqWNvnZDAjUw3x59NLQylSS/5P9Wh1T2G4/WOEm5c4YsudrLyAQHn1pJNl
 IAAPDdiwYAnBUdvqICCrn6T9dDyOB9/IHtWJbhD/Wo2f2z5Nh3M85uDaEVVyTIsSWfHJyT
 Bd9uTP1wugi6tvkCQldHurx6mQVChZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-UvOzHbDKNpaWiXKnNTsUJw-1; Mon, 21 Sep 2020 22:01:21 -0400
X-MC-Unique: UvOzHbDKNpaWiXKnNTsUJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33292107464B;
 Tue, 22 Sep 2020 02:01:20 +0000 (UTC)
Received: from [10.72.13.139] (ovpn-13-139.pek2.redhat.com [10.72.13.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A08573670;
 Tue, 22 Sep 2020 02:01:10 +0000 (UTC)
Subject: Re: [PATCH 7/8] vhost: remove work arg from vhost_work_flush
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mst@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1600712588-9514-1-git-send-email-michael.christie@oracle.com>
 <1600712588-9514-8-git-send-email-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ce8af213-1eff-7c4e-b5e8-660267b8ff31@redhat.com>
Date: Tue, 22 Sep 2020 10:01:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600712588-9514-8-git-send-email-michael.christie@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Ck9uIDIwMjAvOS8yMiDkuIrljYgyOjIzLCBNaWtlIENocmlzdGllIHdyb3RlOgo+IHZob3N0X3dv
cmtfZmx1c2ggZG9lc24ndCBkbyBhbnl0aGluZyB3aXRoIHRoZSB3b3JrIGFyZy4gVGhpcyBwYXRj
aCBkcm9wcwo+IGl0IGFuZCB0aGVuIHJlbmFtZXMgdmhvc3Rfd29ya19mbHVzaCB0byB2aG9zdF93
b3JrX2Rldl9mbHVzaCB0byByZWZsZWN0Cj4gdGhhdCB0aGUgZnVuY3Rpb24gZmx1c2hlcyBhbGwg
dGhlIHdvcmtzIGluIHRoZSBkZXYgYW5kIG5vdCBqdXN0IGEKPiBzcGVjaWZpYyBxdWV1ZSBvciB3
b3JrIGl0ZW0uCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIENocmlzdGllIDxtaWNoYWVsLmNocmlz
dGllQG9yYWNsZS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3Qvc2NzaS5jICB8IDQgKystLQo+ICAgZHJpdmVy
cy92aG9zdC92aG9zdC5jIHwgOCArKysrLS0tLQo+ICAgZHJpdmVycy92aG9zdC92aG9zdC5oIHwg
MiArLQo+ICAgZHJpdmVycy92aG9zdC92c29jay5jIHwgMiArLQo+ICAgNCBmaWxlcyBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aG9zdC9zY3NpLmMgYi9kcml2ZXJzL3Zob3N0L3Njc2kuYwo+IGluZGV4IDg3OTFkYjguLjU4
MzMwNTkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC9zY3NpLmMKPiArKysgYi9kcml2ZXJz
L3Zob3N0L3Njc2kuYwo+IEBAIC0xNDY5LDggKzE0NjksOCBAQCBzdGF0aWMgdm9pZCB2aG9zdF9z
Y3NpX2ZsdXNoKHN0cnVjdCB2aG9zdF9zY3NpICp2cykKPiAgIAkvKiBGbHVzaCBib3RoIHRoZSB2
aG9zdCBwb2xsIGFuZCB2aG9zdCB3b3JrICovCj4gICAJZm9yIChpID0gMDsgaSA8IFZIT1NUX1ND
U0lfTUFYX1ZROyBpKyspCj4gICAJCXZob3N0X3Njc2lfZmx1c2hfdnEodnMsIGkpOwo+IC0Jdmhv
c3Rfd29ya19mbHVzaCgmdnMtPmRldiwgJnZzLT52c19jb21wbGV0aW9uX3dvcmspOwo+IC0Jdmhv
c3Rfd29ya19mbHVzaCgmdnMtPmRldiwgJnZzLT52c19ldmVudF93b3JrKTsKPiArCXZob3N0X3dv
cmtfZGV2X2ZsdXNoKCZ2cy0+ZGV2KTsKPiArCXZob3N0X3dvcmtfZGV2X2ZsdXNoKCZ2cy0+ZGV2
KTsKPiAgIAo+ICAgCS8qIFdhaXQgZm9yIGFsbCByZXFzIGlzc3VlZCBiZWZvcmUgdGhlIGZsdXNo
IHRvIGJlIGZpbmlzaGVkICovCj4gICAJZm9yIChpID0gMDsgaSA8IFZIT1NUX1NDU0lfTUFYX1ZR
OyBpKyspCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhv
c3Qvdmhvc3QuYwo+IGluZGV4IDVkZDllYjEuLmY4MzY3NGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92aG9zdC92aG9zdC5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gQEAgLTIzMSw3
ICsyMzEsNyBAQCB2b2lkIHZob3N0X3BvbGxfc3RvcChzdHJ1Y3Qgdmhvc3RfcG9sbCAqcG9sbCkK
PiAgIH0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZob3N0X3BvbGxfc3RvcCk7Cj4gICAKPiAtdm9p
ZCB2aG9zdF93b3JrX2ZsdXNoKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgc3RydWN0IHZob3N0X3dv
cmsgKndvcmspCj4gK3ZvaWQgdmhvc3Rfd29ya19kZXZfZmx1c2goc3RydWN0IHZob3N0X2RldiAq
ZGV2KQo+ICAgewo+ICAgCXN0cnVjdCB2aG9zdF9mbHVzaF9zdHJ1Y3QgZmx1c2g7Cj4gICAKPiBA
QCAtMjQzLDEzICsyNDMsMTMgQEAgdm9pZCB2aG9zdF93b3JrX2ZsdXNoKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldiwgc3RydWN0IHZob3N0X3dvcmsgKndvcmspCj4gICAJCXdhaXRfZm9yX2NvbXBsZXRp
b24oJmZsdXNoLndhaXRfZXZlbnQpOwo+ICAgCX0KPiAgIH0KPiAtRVhQT1JUX1NZTUJPTF9HUEwo
dmhvc3Rfd29ya19mbHVzaCk7Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKHZob3N0X3dvcmtfZGV2X2Zs
dXNoKTsKPiAgIAo+ICAgLyogRmx1c2ggYW55IHdvcmsgdGhhdCBoYXMgYmVlbiBzY2hlZHVsZWQu
IFdoZW4gY2FsbGluZyB0aGlzLCBkb24ndCBob2xkIGFueQo+ICAgICogbG9ja3MgdGhhdCBhcmUg
YWxzbyB1c2VkIGJ5IHRoZSBjYWxsYmFjay4gKi8KPiAgIHZvaWQgdmhvc3RfcG9sbF9mbHVzaChz
dHJ1Y3Qgdmhvc3RfcG9sbCAqcG9sbCkKPiAgIHsKPiAtCXZob3N0X3dvcmtfZmx1c2gocG9sbC0+
ZGV2LCAmcG9sbC0+d29yayk7Cj4gKwl2aG9zdF93b3JrX2Rldl9mbHVzaChwb2xsLT5kZXYpOwo+
ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodmhvc3RfcG9sbF9mbHVzaCk7Cj4gICAKPiBAQCAt
NTQyLDcgKzU0Miw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfYXR0YWNoX2Nncm91cHMoc3RydWN0IHZo
b3N0X2RldiAqZGV2KQo+ICAgCWF0dGFjaC5vd25lciA9IGN1cnJlbnQ7Cj4gICAJdmhvc3Rfd29y
a19pbml0KCZhdHRhY2gud29yaywgdmhvc3RfYXR0YWNoX2Nncm91cHNfd29yayk7Cj4gICAJdmhv
c3Rfd29ya19xdWV1ZShkZXYsICZhdHRhY2gud29yayk7Cj4gLQl2aG9zdF93b3JrX2ZsdXNoKGRl
diwgJmF0dGFjaC53b3JrKTsKPiArCXZob3N0X3dvcmtfZGV2X2ZsdXNoKGRldik7Cj4gICAJcmV0
dXJuIGF0dGFjaC5yZXQ7Cj4gICB9Cj4gICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92
aG9zdC5oIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gaW5kZXggM2QzMGIzZC4uYjkxZWZiNSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPiArKysgYi9kcml2ZXJzL3Zob3N0
L3Zob3N0LmgKPiBAQCAtNDYsNyArNDYsNyBAQCB2b2lkIHZob3N0X3BvbGxfaW5pdChzdHJ1Y3Qg
dmhvc3RfcG9sbCAqcG9sbCwgdmhvc3Rfd29ya19mbl90IGZuLAo+ICAgdm9pZCB2aG9zdF9wb2xs
X3N0b3Aoc3RydWN0IHZob3N0X3BvbGwgKnBvbGwpOwo+ICAgdm9pZCB2aG9zdF9wb2xsX2ZsdXNo
KHN0cnVjdCB2aG9zdF9wb2xsICpwb2xsKTsKPiAgIHZvaWQgdmhvc3RfcG9sbF9xdWV1ZShzdHJ1
Y3Qgdmhvc3RfcG9sbCAqcG9sbCk7Cj4gLXZvaWQgdmhvc3Rfd29ya19mbHVzaChzdHJ1Y3Qgdmhv
c3RfZGV2ICpkZXYsIHN0cnVjdCB2aG9zdF93b3JrICp3b3JrKTsKPiArdm9pZCB2aG9zdF93b3Jr
X2Rldl9mbHVzaChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpOwo+ICAgbG9uZyB2aG9zdF92cmluZ19p
b2N0bChzdHJ1Y3Qgdmhvc3RfZGV2ICpkLCB1bnNpZ25lZCBpbnQgaW9jdGwsIHZvaWQgX191c2Vy
ICphcmdwKTsKPiAgIAo+ICAgc3RydWN0IHZob3N0X2xvZyB7Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmhvc3QvdnNvY2suYyBiL2RyaXZlcnMvdmhvc3QvdnNvY2suYwo+IGluZGV4IGE0ODNjZWMu
LmY0MDIwNWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92c29jay5jCj4gKysrIGIvZHJp
dmVycy92aG9zdC92c29jay5jCj4gQEAgLTY1Miw3ICs2NTIsNyBAQCBzdGF0aWMgdm9pZCB2aG9z
dF92c29ja19mbHVzaChzdHJ1Y3Qgdmhvc3RfdnNvY2sgKnZzb2NrKQo+ICAgCWZvciAoaSA9IDA7
IGkgPCBBUlJBWV9TSVpFKHZzb2NrLT52cXMpOyBpKyspCj4gICAJCWlmICh2c29jay0+dnFzW2ld
LmhhbmRsZV9raWNrKQo+ICAgCQkJdmhvc3RfcG9sbF9mbHVzaCgmdnNvY2stPnZxc1tpXS5wb2xs
KTsKPiAtCXZob3N0X3dvcmtfZmx1c2goJnZzb2NrLT5kZXYsICZ2c29jay0+c2VuZF9wa3Rfd29y
ayk7Cj4gKwl2aG9zdF93b3JrX2Rldl9mbHVzaCgmdnNvY2stPmRldik7Cj4gICB9Cj4gICAKPiAg
IHN0YXRpYyB2b2lkIHZob3N0X3Zzb2NrX3Jlc2V0X29ycGhhbnMoc3RydWN0IHNvY2sgKnNrKQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
