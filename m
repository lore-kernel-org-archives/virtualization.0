Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF0C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 13:54:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADFD64ED5
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 13:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADFD64ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 56D9186B74;
	Tue,  9 Feb 2021 13:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TDtbESMFai0h; Tue,  9 Feb 2021 13:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 38A42869AC;
	Tue,  9 Feb 2021 13:54:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 234B1C0891;
	Tue,  9 Feb 2021 13:54:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 731D5C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 13:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5F4A286B2D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 13:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Py2IX+qMTa+n
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 13:54:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 476EA86A08
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 13:54:18 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id f14so31567307ejc.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Feb 2021 05:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LHXxRnsLKoOvgd0yvx6F4xuhgUe7ABigB+ckGTWSYwg=;
 b=Ft2JbOoNS11xYnG4jPafmaaqHhG1EEGHT7MA8DfFZxSLfyvH3n0DGPDVzkntupT43E
 +bjzWtJmfui/DGFuFDIoqmHBcQZeiCglr4ynd28Z3pqgJleOYcpaKvfC0RoiW+szcGKa
 CLmMJhbwaCXUD/O4NzezKg9O0NXgTBy3oFVNKuI6IL+6a/O1Ho5LGoOG858DdW7kMgOi
 40jW6XqilwMS4/eBnplOvOIVqEd0WwXB8wOCQppbKmxfNwBZVPLeU1hutD8TRyLvnWgT
 5SXPw9Se3AUZ9+xUxyr03aesF9vnfSWiq0jpjO5EKWJ19yWAwOvMb20BpcQ/cBFN7wfR
 LtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LHXxRnsLKoOvgd0yvx6F4xuhgUe7ABigB+ckGTWSYwg=;
 b=TCUr3Cq1stMhFKIwekZiGQb82qGbkuzcBT5yz+qKMIadIANqgSse+Ie+AOUEyFOJgl
 EfQXGo9WK2h1A/bnlw1zcWQXKIseWvKrC9cfgHM/qdi1PxCI2gXGVd6bVsvkBWiTOogu
 +PZLUBFQfaGdDAdbvv29ZnEqcKaN/QeWzElKxGBqPctiRlaR3PCgFW+0HXwEu8/P1n0I
 s3qvozwNPFcm8lrEjKAWdLOEWTPggoCZOUagaNAlyqxa4HTPsFgTQaUBGyFkyVJDWjdm
 eSeVK6RMCXv21G1zLn4ZZeO4NzO6fR1MpDpEHd39LkCHSjUXwz8WcOgNS+P65xJcjO6b
 tYkQ==
X-Gm-Message-State: AOAM532Y+kTBgOcKAaJSKYjFeXovZQs2y/oTIeEx5fd+/Uzsx2X/P7AW
 j/mybt4I6X3OHJ7mDLovbcaac+AnLqlrTIh8Z9g=
X-Google-Smtp-Source: ABdhPJwxdUAn9WHjqsT4NJBsFmkI4fLufcraU6RK4VvOJrza9m3CIZ7ManUXZ4AXC4z/SfN0G3UI3LDwT9GWibA5Vdk=
X-Received: by 2002:a17:906:4dc5:: with SMTP id
 f5mr22171118ejw.11.1612878856672; 
 Tue, 09 Feb 2021 05:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20210208185558.995292-1-willemdebruijn.kernel@gmail.com>
 <20210208185558.995292-3-willemdebruijn.kernel@gmail.com>
 <c089cb3e-96cb-b42a-5ce1-d54d298987c4@redhat.com>
In-Reply-To: <c089cb3e-96cb-b42a-5ce1-d54d298987c4@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 9 Feb 2021 08:53:40 -0500
Message-ID: <CAF=yD-Jkm-Cfs2tHKhC17KfPp+=18y=9_XSuY-LNgkC-2_NfLA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/4] virtio-net: support receive timestamp
To: Jason Wang <jasowang@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Willem de Bruijn <willemb@google.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBGZWIgOCwgMjAyMSBhdCAxMToxMyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4gT24gMjAyMS8yLzkg5LiK5Y2IMjo1NSwgV2lsbGVtIGRlIEJy
dWlqbiB3cm90ZToKPiA+IEZyb206IFdpbGxlbSBkZSBCcnVpam4gPHdpbGxlbWJAZ29vZ2xlLmNv
bT4KPiA+Cj4gPiBBZGQgb3B0aW9uYWwgUFRQIGhhcmR3YXJlIHJ4IHRpbWVzdGFtcCBvZmZsb2Fk
IGZvciB2aXJ0aW8tbmV0Lgo+ID4KPiA+IEFjY3VyYXRlIFJUVCBtZWFzdXJlbWVudCByZXF1aXJl
cyB0aW1lc3RhbXBzIGNsb3NlIHRvIHRoZSB3aXJlLgo+ID4gSW50cm9kdWNlIHZpcnRpbyBmZWF0
dXJlIFZJUlRJT19ORVRfRl9SWF9UU1RBTVAuIElmIG5lZ290aWF0ZWQsIHRoZQo+ID4gdmlydGlv
LW5ldCBoZWFkZXIgaXMgZXhwYW5kZWQgd2l0aCByb29tIGZvciBhIHRpbWVzdGFtcC4KPiA+Cj4g
PiBBIGRldmljZSBtYXkgcGFzcyByZWNlaXZlIHRpbWVzdGFtcHMgZm9yIGFsbCBvciBzb21lIHBh
Y2tldHMuIEZsYWcKPiA+IFZJUlRJT19ORVRfSERSX0ZfVFNUQU1QIHNpZ25hbHMgd2hldGhlciBh
IHRpbWVzdGFtcCBpcyByZWNvcmRlZC4KPiA+Cj4gPiBBIGRyaXZlciB0aGF0IHN1cHBvcnRzIGhh
cmR3YXJlIHRpbWVzdGFtcGluZyBtdXN0IGFsc28gc3VwcG9ydAo+ID4gaW9jdGwgU0lPQ1NIV1RT
VEFNUC4gSW1wbGVtZW50IHRoYXQsIGFzIHdlbGwgYXMgaW5mb3JtYXRpb24gZ2V0dGVycwo+ID4g
aW9jdGwgU0lPQ0dIV1RTVEFNUCBhbmQgZXRodG9vbCBnZXRfdHNfaW5mbyAoYGV0aHRvb2wgLVQg
JERFVmApLgo+ID4KPiA+IFRoZSB0aW1lc3RhbXAgc3RyYWRkbGVzICh2aXJ0dWFsKSBoYXJkd2Fy
ZSBkb21haW5zLiBMaWtlIFBUUCwgdXNlCj4gPiBpbnRlcm5hdGlvbmFsIGF0b21pYyB0aW1lIChD
TE9DS19UQUkpIGFzIGdsb2JhbCBjbG9jayBiYXNlLiBUaGUgZHJpdmVyCj4gPiBtdXN0IHN5bmMg
d2l0aCB0aGUgZGV2aWNlLCBlLmcuLCB0aHJvdWdoIGt2bS1jbG9jay4KPiA+Cj4gPiBUZXN0ZWQ6
Cj4gPiAgICBndWVzdDogLi90aW1lc3RhbXBpbmcgZXRoMCBcCj4gPiAgICAgICAgICAgIFNPRl9U
SU1FU1RBTVBJTkdfUkFXX0hBUkRXQVJFIFwKPiA+ICAgICAgICAgICAgU09GX1RJTUVTVEFNUElO
R19SWF9IQVJEV0FSRQo+ID4gICAgaG9zdDogbmMgLTQgLXUgMTkyLjE2OC4xLjEgMzE5Cj4gPgo+
ID4gQ2hhbmdlcyBSRkMgLT4gUkZDdjIKPiA+ICAgIC0gcmVuYW1lIHZpcnRpb19uZXRfaGRyX3Yx
MiB0byB2aXJ0aW9fbmV0X2hkcl9oYXNoX3RzCj4gPiAgICAtIGFkZCBldGh0b29sIC5nZXRfdHNf
aW5mbyB0byBxdWVyeSBjYXBhYmlsaXRpZXMKPiA+ICAgIC0gYWRkIGlvY3RsIFNJT0NbR1NdSFdU
U1RBTVAgdG8gY29uZmlndXJlIGZlYXR1cmUKPiA+ICAgIC0gYWRkIHZpLT5lbmFibGVfcnhfdHN0
YW1wIHRvIHN0b3JlIGNvbmZpZ3VyYXRpb24KPiA+ICAgIC0gY29udmVydCB2aXJ0aW9YWF90b19j
cHUgdG8gbGVYWF90b19jcHUKPiA+ICAgIC0gY29udmVydCByZXNlcnZlZCB0byBfX3UzMgo+ID4K
PiA+IFNpZ25lZC1vZmYtYnk6IFdpbGxlbSBkZSBCcnVpam4gPHdpbGxlbWJAZ29vZ2xlLmNvbT4K
Cj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbmV0X2RldmljZV9vcHMgdmlydG5ldF9uZXRkZXYg
PSB7Cj4gPiAgICAgICAubmRvX29wZW4gICAgICAgICAgICA9IHZpcnRuZXRfb3BlbiwKPiA+ICAg
ICAgIC5uZG9fc3RvcCAgICAgICAgICAgID0gdmlydG5ldF9jbG9zZSwKPiA+IEBAIC0yNTczLDYg
KzI2NzYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vfb3BzIHZpcnRuZXRfbmV0
ZGV2ID0gewo+ID4gICAgICAgLm5kb19mZWF0dXJlc19jaGVjayAgICAgPSBwYXNzdGhydV9mZWF0
dXJlc19jaGVjaywKPiA+ICAgICAgIC5uZG9fZ2V0X3BoeXNfcG9ydF9uYW1lID0gdmlydG5ldF9n
ZXRfcGh5c19wb3J0X25hbWUsCj4gPiAgICAgICAubmRvX3NldF9mZWF0dXJlcyAgICAgICA9IHZp
cnRuZXRfc2V0X2ZlYXR1cmVzLAo+ID4gKyAgICAgLm5kb19kb19pb2N0bCAgICAgICAgICAgPSB2
aXJ0bmV0X2lvY3RsLAo+ID4gICB9Owo+ID4KPiA+ICAgc3RhdGljIHZvaWQgdmlydG5ldF9jb25m
aWdfY2hhbmdlZF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiA+IEBAIC0zMDY5LDYg
KzMxNzMsMTEgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2KQo+ID4gICAgICAgICAgICAgICB2aS0+aGRyX2xlbiA9IHNpemVvZihzdHJ1Y3Qgdmly
dGlvX25ldF9oZHJfdjFfaGFzaCk7Cj4gPiAgICAgICB9Cj4gPgo+ID4gKyAgICAgaWYgKHZpcnRp
b19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfUlhfVFNUQU1QKSkgewo+ID4gKyAgICAg
ICAgICAgICB2aS0+aGFzX3J4X3RzdGFtcCA9IHRydWU7Cj4gPiArICAgICAgICAgICAgIHZpLT5o
ZHJfbGVuID0gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9oYXNoX3RzKTsKPgo+Cj4gRG9l
cyB0aGlzIG1lYW4gZXZlbiBpZiB0aGUgZGV2aWNlIGRvZXNuJ3QgcGFzcyB0aW1lc3RhbXAsIHRo
ZSBoZWFkZXIKPiBzdGlsbCBjb250YWlucyB0aGUgdGltZXN0YW1wIGZpZWxkcy4KClllcy4gQXMg
aW1wbGVtZW50ZWQsIHRoZSBzaXplIG9mIHRoZSBoZWFkZXIgaXMgY29uc3RhbnQgYWNyb3NzCnBh
Y2tldHMuIElmIGJvdGggc2lkZXMgbmVnb3RpYXRlIHRoZSBmZWF0dXJlLCB0aGVuIGFsbCBoZWFk
ZXJzIHJlc2VydmUKc3BhY2UsIHdoZXRoZXIgb3Igbm90IHRoZSBzcGVjaWZpYyBwYWNrZXQgaGFz
IGEgdGltZXN0YW1wLgoKU28gZmFyIGhlYWRlcnMgYXJlIGZpeGVkIHNpemUuIEkgc3VwcG9zZSB3
ZSBjb3VsZCBpbnZlc3RpZ2F0ZSB2YXJpYWJsZQpzaXplIGhlYWRlcnMuIFRoaXMgZ29lcyBiYWNr
IHRvIG91ciBkaXNjdXNzaW9uIGluIHRoZSBwcmV2aW91cwpwYXRjaHNldCwgdGhhdCB3ZSBjYW4g
YWx3YXlzIGFkZCBhIHBhY2tlZC1oZWFkZXIgZmVhdHVyZSBsYXRlciwgaWYgdGhlCm51bWJlciBv
ZiBvcHRpb25hbCBmZWF0dXJlcyByZWFjaGVzIGEgc2l6ZSB0aGF0IG1ha2VzIHRoZSBjb21wbGV4
aXR5CndvcnRod2hpbGUuCgo+ID4gKyAgICAgfQo+ID4gKwo+ID4gICAgICAgaWYgKHZpcnRpb19o
YXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fRl9BTllfTEFZT1VUKSB8fAo+ID4gICAgICAgICAgIHZp
cnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fRl9WRVJTSU9OXzEpKQo+ID4gICAgICAgICAg
ICAgICB2aS0+YW55X2hlYWRlcl9zZyA9IHRydWU7Cj4gPiBAQCAtMzI2MCw3ICszMzY5LDcgQEAg
c3RhdGljIHN0cnVjdCB2aXJ0aW9fZGV2aWNlX2lkIGlkX3RhYmxlW10gPSB7Cj4gPiAgICAgICBW
SVJUSU9fTkVUX0ZfQ1RSTF9NQUNfQUREUiwgXAo+ID4gICAgICAgVklSVElPX05FVF9GX01UVSwg
VklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZGTE9BRFMsIFwKPiA+ICAgICAgIFZJUlRJT19ORVRf
Rl9TUEVFRF9EVVBMRVgsIFZJUlRJT19ORVRfRl9TVEFOREJZLCBcCj4gPiAtICAgICBWSVJUSU9f
TkVUX0ZfVFhfSEFTSAo+ID4gKyAgICAgVklSVElPX05FVF9GX1RYX0hBU0gsIFZJUlRJT19ORVRf
Rl9SWF9UU1RBTVAKPiA+Cj4gPiAgIHN0YXRpYyB1bnNpZ25lZCBpbnQgZmVhdHVyZXNbXSA9IHsK
PiA+ICAgICAgIFZJUlRORVRfRkVBVFVSRVMsCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBp
L2xpbnV4L3ZpcnRpb19uZXQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbmV0LmgKPiA+
IGluZGV4IDI3M2Q0M2MzNWY1OS4uYTVjODQ0MTBjZjkyIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVk
ZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaAo+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19uZXQuaAo+ID4gQEAgLTU3LDYgKzU3LDcgQEAKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICogU3RlZXJpbmcgKi8KPiA+ICAgI2RlZmluZSBWSVJUSU9fTkVU
X0ZfQ1RSTF9NQUNfQUREUiAyMyAgICAgICAvKiBTZXQgTUFDIGFkZHJlc3MgKi8KPiA+Cj4gPiAr
I2RlZmluZSBWSVJUSU9fTkVUX0ZfUlhfVFNUQU1QICAgICAgICAgNTUgICAgLyogRGV2aWNlIHNl
bmRzIFRBSSByZWNlaXZlIHRpbWUgKi8KPiA+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0ZfVFhfSEFT
SCAgICAgICAgICA1NiAgICAvKiBEcml2ZXIgc2VuZHMgaGFzaCByZXBvcnQgKi8KPiA+ICAgI2Rl
ZmluZSBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQgIDU3ICAgICAgICAvKiBTdXBwb3J0cyBoYXNo
IHJlcG9ydCAqLwo+ID4gICAjZGVmaW5lIFZJUlRJT19ORVRfRl9SU1MgICAgICA2MCAgICAvKiBT
dXBwb3J0cyBSU1MgUlggc3RlZXJpbmcgKi8KPiA+IEBAIC0xMjYsNiArMTI3LDcgQEAgc3RydWN0
IHZpcnRpb19uZXRfaGRyX3YxIHsKPiA+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0hEUl9GX05FRURT
X0NTVU0gMSAgICAgICAvKiBVc2UgY3N1bV9zdGFydCwgY3N1bV9vZmZzZXQgKi8KPiA+ICAgI2Rl
ZmluZSBWSVJUSU9fTkVUX0hEUl9GX0RBVEFfVkFMSUQgMiAgICAgICAvKiBDc3VtIGlzIHZhbGlk
ICovCj4gPiAgICNkZWZpbmUgVklSVElPX05FVF9IRFJfRl9SU0NfSU5GTyAgIDQgICAgICAgLyog
cnNjIGluZm8gaW4gY3N1bV8gZmllbGRzICovCj4gPiArI2RlZmluZSBWSVJUSU9fTkVUX0hEUl9G
X1RTVEFNUCAgICAgICAgICAgICAgOCAgICAgICAvKiB0aW1lc3RhbXAgaXMgcmVjb3JkZWQgKi8K
PiA+ICAgICAgIF9fdTggZmxhZ3M7Cj4gPiAgICNkZWZpbmUgVklSVElPX05FVF9IRFJfR1NPX05P
TkUgICAgICAgICAgICAgMCAgICAgICAvKiBOb3QgYSBHU08gZnJhbWUgKi8KPiA+ICAgI2RlZmlu
ZSBWSVJUSU9fTkVUX0hEUl9HU09fVENQVjQgICAgMSAgICAgICAvKiBHU08gZnJhbWUsIElQdjQg
VENQIChUU08pICovCj4gPiBAQCAtMTgxLDYgKzE4MywxNyBAQCBzdHJ1Y3QgdmlydGlvX25ldF9o
ZHJfdjFfaGFzaCB7Cj4gPiAgICAgICB9Owo+ID4gICB9Owo+ID4KPiA+ICtzdHJ1Y3QgdmlydGlv
X25ldF9oZHJfaGFzaF90cyB7Cj4gPiArICAgICBzdHJ1Y3QgdmlydGlvX25ldF9oZHJfdjEgaGRy
Owo+ID4gKyAgICAgc3RydWN0IHsKPiA+ICsgICAgICAgICAgICAgX19sZTMyIHZhbHVlOwo+ID4g
KyAgICAgICAgICAgICBfX2xlMTYgcmVwb3J0Owo+ID4gKyAgICAgICAgICAgICBfX2xlMTYgZmxv
d19zdGF0ZTsKPiA+ICsgICAgIH0gaGFzaDsKPgo+Cj4gQW55IHJlYXNvbiBmb3Igbm90IGVtYmVk
ZGluZyBzdHJ1Y3R1cmUgdmlydGlvX25ldF9oZHJfdjFfaGFzaD8KCkp1c3QgdGhhdCBpdCBiZWNv
bWVzIGFuIG9uaW9uIG9mIHN0cnVjdCBpbnNpZGUgc3RydWN0cy4gSSBjYW4gY2hhbmdlCmlmIHlv
dSBwcmVmZXIuCgo+IFRoYW5rcwoKQXMgYWx3YXlzLCB0aGFua3MgZm9yIHJldmlld2luZywgSmFz
b24uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
