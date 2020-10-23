Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F15C388F9
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 09:11:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AE024182
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 09:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jy+bvZbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AE024182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D5B3186C7B;
	Fri, 23 Oct 2020 09:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HyjYFq7ROUg6; Fri, 23 Oct 2020 09:11:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1952886842;
	Fri, 23 Oct 2020 09:11:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E73A7C088B;
	Fri, 23 Oct 2020 09:11:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CDA5C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 055D887780
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:11:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VwB7l8ifoju3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:11:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1255B8777F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603444262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ASQPdjW+0ZOFIqukoAqoxjQJ3gMAPoDQllcGzJAz/OM=;
 b=Jy+bvZbuxJU8V2i8wC79OsBwUk0P1YIN8sbPmXOkHQ9ElxWw9Fhm/kHyv3MlT5b9GL6geH
 v+3lhCtRAAgcpCvOwRzJ9nFyWReJ7AMlDVMJySqiaF16EECjWz6nJI5ntZqlBUnDdBkx9v
 c1Bx3Y/p9coL2KIVh8hxFKS6bMII45g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-gxO2VXEyPd6cDjvjgDGDSw-1; Fri, 23 Oct 2020 05:11:00 -0400
X-MC-Unique: gxO2VXEyPd6cDjvjgDGDSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75F5B1006CB5;
 Fri, 23 Oct 2020 09:10:59 +0000 (UTC)
Received: from [10.72.13.85] (ovpn-13-85.pek2.redhat.com [10.72.13.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3B0978800;
 Fri, 23 Oct 2020 09:10:53 +0000 (UTC)
Subject: Re: [PATCH] virtio_ring: use DMA when memory encryption is active
To: Sebastian Hofmann <sebastian@kaemmelot.de>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1075010014.50900.1603293266000@office.mailbox.org>
 <20201022073716-mutt-send-email-mst@kernel.org>
 <1419750420.56704.1603443654667@office.mailbox.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ea4d2c99-1c67-797d-29dc-d122e4856d24@redhat.com>
Date: Fri, 23 Oct 2020 17:10:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1419750420.56704.1603443654667@office.mailbox.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTAvMjMg5LiL5Y2INTowMCwgU2ViYXN0aWFuIEhvZm1hbm4gd3JvdGU6Cj4+IE1p
Y2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IGhhdCBhbSAyMi4xMC4yMDIwIDEzOjM5
IGdlc2NocmllYmVuOgo+Pgo+PiAgIAo+PiBPbiBXZWQsIE9jdCAyMSwgMjAyMCBhdCAwNToxNDoy
NVBNICswMjAwLCBTZWJhc3RpYW4gSG9mbWFubiB3cm90ZToKPj4+IHZpcnRpb19yaW5nIGRvZXMg
bm90IHdvcmsgd2l0aCBhY3RpdmUgbWVtb3J5IGVuY3J5cHRpb24gYmVjYXVzZSB0aGUgaG9zdCBj
YW5ub3QgcmVhZCBpdC4gRml4IHRoaXMgYnkgZW5mb3JjaW5nIHRoZSB1c2Ugb2YgRE1BIHdoaWNo
IHVzZXMgc2hhcmVkICh1bmVuY3J5cHRlZCkgbWVtb3J5IHBhZ2VzLgo+Pj4KPj4+IFNpZ25lZC1v
ZmYtYnk6IFNlYmFzdGlhbiBIb2ZtYW5uIDxzZWJhc3RpYW5Aa2FlbW1lbG90LmRlPgo+Pgo+PiBT
b3JyeSwgbm8uCj4+IGhvc3Qgd2hpY2ggY2FuIG5vdCBhY2Nlc3MgYWxsIG9mIGRyaXZlciBtZW1v
cnkgbXVzdCBzZXQgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNLgo+Pgo+PiBOb3Qgd29ydGggaXQg
dG8gd29yayBhcm91bmQgYnJva2VuIGhvc3RzLgo+Pgo+PiBYZW4gaXMgYW4gZXhjZXB0aW9uIHdl
IGNhcnJ5IGFyb3VuZCBzaW5jZSBpdCBwcmVkYXRlcyB0aGUKPj4gaW50cm9kdWN0aW9uIG9mIFZJ
UlRJT19GX0FDQ0VTU19QTEFURk9STS4KPj4KPj4KPiBUaGFua3MgZm9yIHBvaW50aW5nIG91dCBW
SVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gd2hpY2ggSSB3YXMgbm90IGF3YXJlIG9mLiBNYXliZSB0
aGF0IHBhdGNoIHdhcyBhIGJpdCBuYcOvdmUuCj4KPiBCYXNpY2FsbHkgSSdtIGxvb2tpbmcgZm9y
IGEgd2F5IHRvIHVzZSB2c29jayB3aXRoIHFlbXUgb24gQU1EIFNFVi4gV2hlbiBJIHRyeSB0byB1
c2UgSU9NTVUgZm9yIHZzb2NrIEkgZ2V0IGFuIEVPUE5PVFNVUFAgb3V0IG9mIHZob3N0X3Zzb2Nr
X3NldF9mZWF0dXJlcy4KPgo+IElzIHRoZXJlIGEgcmVhc29uIHdoeSB2aG9zdF92c29ja19zZXRf
ZmVhdHVyZXMgZG9lc24ndCB1c2Ugdmhvc3RfaW5pdF9kZXZpY2VfaW90bGIgYXMgZG9uZSBpbiB0
aGUgbmV0IGRldmljZT8KCgpJdCdzIGp1c3QgYmVjYXVzZSBpdCBoYXMgYmVlbiBpbXBsZW1lbnRl
ZC4gSW4gYWRkaXRpb24gdG8gaW1wbGVtZW50IApJT1RMQiwgdGhlIHZpcnRpby12c29jay1wY2kg
bXVzdCBhZHZlcnRpc2UgQVRTIGNhcGFiaWxpdHkgYXMgd2VsbC4KCgo+IEJlY2F1c2UgdGhhdCB3
b3VsZCBoYXZlIGJlZW4gbXkgbmV4dCBhdHRlbXB0Lgo+IEkgd291bGQgYXBwcmVjaWF0ZSBhIHNo
b3J0IGNvbW1lbnQgb24gdGhpcyBpZGVhIG9yIGEgcmVjb21tZW5kYXRpb24gZm9yIGFub3RoZXIg
c29sdXRpb24gdGhhdCBpcyBiZXR0ZXIgdGhhbiB0aGUgcGF0Y2ggYmVsb3cuCgoKQSBxdWVzdGlv
biwgaXMgdklPTU1VIGEgbXVzdCBmb3IgbWFraW5nIFNFViB3b3JrPwoKVGhhbmtzCgoKPgo+Pj4g
LS0tCj4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA1ICsrKysrCj4+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+
IGluZGV4IGJlY2M3NzY5Nzk2MC4uOGM2OGM0NzVlYzIxIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+Pj4gQEAgLTEyLDYgKzEyLDcgQEAKPj4+ICAgI2luY2x1ZGUgPGxpbnV4L2hydGltZXIu
aD4KPj4+ICAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+Cj4+PiAgICNpbmNsdWRlIDx4
ZW4veGVuLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L21lbV9lbmNyeXB0Lmg+Cj4+PiAgIAo+Pj4g
ICAjaWZkZWYgREVCVUcKPj4+ICAgLyogRm9yIGRldmVsb3BtZW50LCB3ZSB3YW50IHRvIGNyYXNo
IHdoZW5ldmVyIHRoZSByaW5nIGlzIHNjcmV3ZWQuICovCj4+PiBAQCAtMjU1LDYgKzI1NiwxMCBA
QCBzdGF0aWMgYm9vbCB2cmluZ191c2VfZG1hX2FwaShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
dikKPj4+ICAgCWlmICh4ZW5fZG9tYWluKCkpCj4+PiAgIAkJcmV0dXJuIHRydWU7Cj4+PiAgIAo+
Pj4gKwkvKiBNZW1vcnkgZW5jcnlwdGlvbiByZXF1aXJlcyBETUEgKi8KPj4+ICsJaWYgKG1lbV9l
bmNyeXB0X2FjdGl2ZSgpKQo+Pj4gKwkJcmV0dXJuIHRydWU7Cj4+PiArCj4+PiAgIAlyZXR1cm4g
ZmFsc2U7Cj4+PiAgIH0KPj4+ICAgCj4+PiAtLSAKPj4+IDIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
