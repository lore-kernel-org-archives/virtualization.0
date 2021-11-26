Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89954C433EF
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 01:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E1FB1401D1;
	Fri, 26 Nov 2021 01:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 77iJ0xvH6ks5; Fri, 26 Nov 2021 01:02:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 26798400A4;
	Fri, 26 Nov 2021 01:02:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0511C001C;
	Fri, 26 Nov 2021 01:02:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38B4BC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 01:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C8696068D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 01:02:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id peKNQ8FQ7blg
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 01:02:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E6B0560683
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 01:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637888568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDyFTKO2QF1JvvfmCS1Hx11I7QAIU5JI9G0dgtPx/uM=;
 b=bdIioipoacUVCdJCYE9QVSVj715Psz18MJCG3D2Rs1paweMXgUDtH+h4izH3LJ8z1MYFCJ
 x5BXFyi83xk+rU2piYlpiYBrIkfc7JbDRNUZFY/GP8gqoD042VecnBPuyM/+9cGCRP7vH6
 jIaaNsBHjL8HCJdw3x205If3HIfbr+U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-cB_wL--cMBGQrtiY5Qkiuw-1; Thu, 25 Nov 2021 20:02:47 -0500
X-MC-Unique: cB_wL--cMBGQrtiY5Qkiuw-1
Received: by mail-ed1-f72.google.com with SMTP id
 b15-20020aa7c6cf000000b003e7cf0f73daso6536340eds.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 17:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pDyFTKO2QF1JvvfmCS1Hx11I7QAIU5JI9G0dgtPx/uM=;
 b=xsoHHYYZzW1tsxoDIB4BijF30OaZ6p7QmRsjSN3X1vx90oOIJGfK7vZ+lNkep3Fxgw
 nfTntK90ys9K59l8VRjVP3lpfgOSY/7lk4B6/NZPphx88NmdZ1PEqMXvqRAlepHoI9Mf
 BSRSR0WHWBMGQug7JS2jC50oTpk2Sq/MhKttC7RxHu+A4/nzxtkV+qqi3oGZQ4J7n1Kj
 1MKWgZDWtl/lzZY6qEGN5H6hSHOh6uwiqlxL/bPErjo9vAVcJffW3CxO9IA3W6GiUOXc
 VXkd3cIXIxK0iyukRoa7q55jswNiKWixN7EegdUKLsQeJkDrRXpd8bkI+fSuAQMmT4Gj
 8Kpg==
X-Gm-Message-State: AOAM532FMqridFeVo3g5JNAHIOpVXmS1MTApWm6FxvhdelQScb5KorQL
 m/DJP43FLnc0HZapTO3sutANvk/PQkBBmBuVzYYOl/7tOEmFwy2HaEfsp4SZwrZ1t12l16LRI9W
 61BKuODtu66Pm6RJpkV85XjqlvuTGpS28sqdInpNDjA==
X-Received: by 2002:a17:907:3f83:: with SMTP id
 hr3mr36287486ejc.555.1637888566162; 
 Thu, 25 Nov 2021 17:02:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMPqdXsVBsibJBeonfauIqf1MFangHN3wRhjaKDXYfs/2bZGG9BdweRbPr7wODShHNrf11lQ==
X-Received: by 2002:a17:907:3f83:: with SMTP id
 hr3mr36287466ejc.555.1637888565979; 
 Thu, 25 Nov 2021 17:02:45 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:e87:2d40:4ed4:5676:5c1a])
 by smtp.gmail.com with ESMTPSA id gs15sm2097648ejc.42.2021.11.25.17.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Nov 2021 17:02:44 -0800 (PST)
Date: Thu, 25 Nov 2021 20:02:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211125195924-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211125154314-mutt-send-email-mst@kernel.org>
 <C8D84EA4-E9A8-44CC-918F-57640A05C81D@holtmann.org>
 <20211125161434-mutt-send-email-mst@kernel.org>
 <2B9668C9-427B-4D8B-A393-AAB5E50763C5@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2B9668C9-427B-4D8B-A393-AAB5E50763C5@holtmann.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>
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

T24gVGh1LCBOb3YgMjUsIDIwMjEgYXQgMTA6NTg6NTZQTSArMDEwMCwgTWFyY2VsIEhvbHRtYW5u
IHdyb3RlOgo+IEhpIE1pY2hhZWwsCj4gCj4gPj4+Pj4gRGV2aWNlIHJlbW92YWwgaXMgY2xlYXJs
eSBvdXQgb2YgdmlydGlvIHNwZWM6IGl0IGF0dGVtcHRzIHRvIHJlbW92ZQo+ID4+Pj4+IHVudXNl
ZCBidWZmZXJzIGZyb20gYSBWUSBiZWZvcmUgaW52b2tpbmcgZGV2aWNlIHJlc2V0LiBUbyBmaXgs
IG1ha2UKPiA+Pj4+PiBvcGVuL2Nsb3NlIE5PUHMgYW5kIGRvIGFsbCBjbGVhbnVwL3NldHVwIGlu
IHByb2JlL3JlbW92ZS4KPiA+Pj4+IAo+ID4+Pj4gc28gdGhlIHZpcnRidF97b3BlbixjbG9zZX0g
YXMgTk9QIGlzIG5vdCByZWFsbHkgd2hhdCBhIGRyaXZlciBpcyBzdXBwb3NlCj4gPj4+PiB0byBi
ZSBkb2luZy4gVGhlc2UgYXJlIHRyYW5zcG9ydCBlbmFibGUvZGlzYWJsZSBjYWxsYmFja3MgZnJv
bSB0aGUgQlQKPiA+Pj4+IENvcmUgdG93YXJkcyB0aGUgZHJpdmVyLiBJdCBtYXBzIHRvIGEgZGV2
aWNlIGJlaW5nIGVuYWJsZWQvZGlzYWJsZWQgYnkKPiA+Pj4+IHNvbWV0aGluZyBsaWtlIGJsdWV0
b290aGQgZm9yIGV4YW1wbGUuIFNvIGlmIGRpc2FibGVkLCBJIGV4cGVjdCB0aGF0IG5vCj4gPj4+
PiByZXNvdXJjZXMvcXVldWVzIGFyZSBpbiB1c2UuCj4gPj4+PiAKPiA+Pj4+IE1heWJlIEkgbWlz
dW5kZXJzdGFuZCB0aGUgdmlydGlvIHNwZWMgaW4gdGhhdCByZWdhcmQsIGJ1dCBJIHdvdWxkIGxp
a2UKPiA+Pj4+IHRvIGtlZXAgdGhpcyBmdW5kYW1lbnRhbCBjb25jZXB0IG9mIGEgQmx1ZXRvb3Ro
IGRyaXZlci4gSXQgZG9lcyB3b3JrCj4gPj4+PiB3aXRoIGFsbCBvdGhlciB0cmFuc3BvcnRzIGxp
a2UgVVNCLCBTRElPLCBVQVJUIGV0Yy4KPiA+Pj4+IAo+ID4+Pj4+IFRoZSBjb3N0IGhlcmUgaXMg
YSBzaW5nbGUgc2tiIHdhc3RlZCBvbiBhbiB1bnVzZWQgYnQgZGV2aWNlIC0gd2hpY2gKPiA+Pj4+
PiBzZWVtcyBtb2Rlc3QuCj4gPj4+PiAKPiA+Pj4+IFRoZXJlIHNob3VsZCBiZSBubyBidWZmZXIg
dXNlZCBpZiB0aGUgZGV2aWNlIGlzIHBvd2VyZWQgb2ZmLiBXZSBhbHNvIGRvbuKAmXQKPiA+Pj4+
IGhhdmUgYW55IFVTQiBVUkJzIGluLWZsaWdodCBpZiB0aGUgdHJhbnNwb3J0IGlzIG5vdCBhY3Rp
dmUuCj4gPj4+PiAKPiA+Pj4+PiBOQjogd2l0aCB0aGlzIGZpeCBpbiBwbGFjZSBkcml2ZXIgc3Rp
bGwgc3VmZmVycyBmcm9tIGEgcmFjZSBjb25kaXRpb24gaWYKPiA+Pj4+PiBhbiBpbnRlcnJ1cHQg
dHJpZ2dlcnMgd2hpbGUgZGV2aWNlIGlzIGJlaW5nIHJlc2V0LiBXb3JrIG9uIGEgZml4IGZvcgo+
ID4+Pj4+IHRoYXQgaXNzdWUgaXMgaW4gcHJvZ3Jlc3MuCj4gPj4+PiAKPiA+Pj4+IEluIHRoZSB2
aXJ0YnRfY2xvc2UoKSBjYWxsYmFjayB3ZSBzaG91bGQgZGVhY3RpdmF0ZSBhbGwgaW50ZXJydXB0
cy4KPiA+Pj4+IAo+ID4+PiAKPiA+Pj4gSWYgeW91IHdhbnQgdG8gZG8gdGhhdCB0aGVuIGRldmlj
ZSBoYXMgdG8gYmUgcmVzZXQgb24gY2xvc2UsCj4gPj4+IGFuZCBmdWxseSByZWluaXRpYWxpemVk
IG9uIG9wZW4uCj4gPj4+IENhbiB5b3Ugd29yayBvbiBhIHBhdGNoIGxpa2UgdGhhdD8KPiA+Pj4g
R2l2ZW4gSSBkb24ndCBoYXZlIHRoZSBkZXZpY2Ugc3VjaCBhIHJld29yayBpcyBwcm9iYWJseSBt
b3JlCj4gPj4+IHRoYW4gSSBjYW4gdW5kZXJ0YWtlLgo+ID4+IAo+ID4+IHNvIHlvdSBtZWFuIG1v
dmUgdmlydGlvX2ZpbmRfdnFzKCkgaW50byB2aXJ0YnRfb3BlbigpIGFuZCBkZWxfdnFzKCkgaW50
bwo+ID4+IHZpcnRidF9jbG9zZSgpPwo+ID4gCj4gPiBBbmQgcmVzZXQgYmVmb3JlIGRlbF92cXMu
Cj4gPiAKPiA+PiBPciBpcyB0aGVyZSBhcmUgd2F5IHRvIHNldCB1cCB0aGUgcXVldWVzIHdpdGhv
dXQgc3RhcnRpbmcgdGhlbT8KPiA+PiAKPiA+PiBIb3dldmVyIEkgYW0gZmFpbGluZyB0byB1bmRl
cnN0YW5kIHlvdXIgaW5pdGlhbCBjb25jZXJuLCB3ZSBkbyByZXNldCgpCj4gPj4gYmVmb3JlIGRl
bF92cXMoKSBpbiB2aXJ0YnRfcmVtb3ZlKCkuIFNob3VsZCB3ZSBiZSBkb2luZyBzb21ldGhpbmcg
ZGlmZmVyZW50Cj4gPj4gaW4gdmlydGJ0X2Nsb3NlKCkgb3RoZXIgdGhhbiB2aXJ0cXVldWVfZGV0
YWNoX3VudXNlZF9idWYoKS4gV2h5IHdvdWxkIEkKPiA+PiBrZWVwIGJ1ZmZlcnMgYXR0YWNoZWQg
aWYgdGhleSBhcmUgbm90IHVzZWQuCj4gPj4gCj4gPiAKPiA+IFRoZXkgYXJlIG5vdCB1c2VkIGF0
IHRoYXQgcG9pbnQgYnV0IHVudGlsIGRldmljZSBpcyByZXNldCBjYW4gdXNlIHRoZW0uCj4gPiBB
bHNvLCBpZiB5b3UgdGhlbiBwcm9jZWVkIHRvIG9wZW4gd2l0aG91dCBhIHJlc2V0LCBhbmQga2lj
aywKPiA+IGRldmljZSB3aWxsIHN0YXJ0IGJ5IHByb2Nlc3NpbmcgdGhlIG9yaWdpbmFsIGJ1ZmZl
cnMsIGNyYXNoaW5nCj4gPiBvciBjb3JydXB0aW5nIG1lbW9yeS4KPiAKPiBzbyB0aGUgb25seSB2
YWxpZCB1c2FnZSBpcyBsaWtlIHRoaXM6Cj4gCj4gCXZkZXYtPmNvbmZpZy0+cmVzZXQodmRldik7
Cj4gCj4gCXdoaWxlICgoLi4gPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYodnEpKSkgewo+
IAl9Cj4gCj4gCXZkZXYtPmNvbmZpZy0+ZGVsX3Zxcyh2ZGV2KTsKPiAKPiBJZiBJIG1ha2Ugdmly
dGJ0X3tvcGVuLGNsb3NlfSBhIE5PUCwgdGhlbiBJIGtlZXAgYWRkaW5nIGFuIGV4dHJhIFNLQiB0
byBpbmJ1ZiBvbgo+IGV2ZXJ5IHBvd2VyIGN5Y2xlIChpZnVwL2lmZG93bikuCgpTbyBtYWtlIHN1
cmUgeW91IGRvbid0IDopCgo+IEhvdyBkb2VzIG5ldGRldiBoYW5kbGUgdGhpcz8KPiAKPiBSZWdh
cmRzCj4gCj4gTWFyY2VsCgpGb3IgbmV0LCBvcGVuIGFkZHMgYnVmZmVycyB0byB2cS4gY2xvc2Ug
ZG9lcyBub3QgZnJlZSB0aGVtIHVwIC0KdGhleSBzdGF5IGluIHRoZSB2cSB1bnRpbCBkZXZpY2Ug
aXMgcmVtb3ZlZC4KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
