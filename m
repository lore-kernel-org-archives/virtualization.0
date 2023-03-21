Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FD3C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 09:07:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF38860C20;
	Tue, 21 Mar 2023 09:07:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF38860C20
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=euCoNs54
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CFlQLw0MsaUH; Tue, 21 Mar 2023 09:07:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 74356606E7;
	Tue, 21 Mar 2023 09:07:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74356606E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C153C0035;
	Tue, 21 Mar 2023 09:07:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 499E9C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2792641731
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:07:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2792641731
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=euCoNs54
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pm91IUi64NDi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:07:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC16C4171C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC16C4171C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679389671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TxTS5ViTydaXh/skwlc4PDyBHB5ONwiCHoXqm/uMAZ8=;
 b=euCoNs54+BqIscHfSHoF8W4t8daWd0fqOBmQpE06nsjmfjIvbUQHnl9Pf3WgVSoEcMbaHg
 QFlh3ugHP8a/N97xmImXeTcawdoplUde0AG+sNXfP0OkXqirHOxuU+IfvrH6OrSfinFcPl
 pcw9sFfcRNZV+wC2cRHPFnPhmks2nEA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-uw2FI39NPO6JsfYCGKb8jw-1; Tue, 21 Mar 2023 05:07:44 -0400
X-MC-Unique: uw2FI39NPO6JsfYCGKb8jw-1
Received: by mail-wm1-f72.google.com with SMTP id
 bi27-20020a05600c3d9b00b003e9d0925341so6736169wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679389663;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TxTS5ViTydaXh/skwlc4PDyBHB5ONwiCHoXqm/uMAZ8=;
 b=Sg22S6mE7/QdzcmtibjTdFIj5V7LnCqpS+v06aFwS9nooihPGYp0HMXrj3nkj3N4x4
 29HXhHPweZWttbwS8UYcBWlGIq86eEz5Du486JsYveI4F6Mg533xOKpS310w2Qu4nlOH
 TCnxYNVQehgI77DKuN6hPWrvYQ6zwk+MFy4e92pHEqY04zZ8HrgliM+W2nEnPpqfP+HF
 Qk1q4WJpgU0RIuKZXbv7P7QCF0r8SJrhZjJK7uQjgldiG/y9hLu2dvmMmDiW6t2mKsjO
 q/vlDR5hqrAo+vusdZ1Wr3Tt1W62qAeAm7qaTaghUJomTEt3DTcESSvxNy/0WxlcC1FO
 dQaA==
X-Gm-Message-State: AO0yUKVIdP/Yd2Yelce2+MYHSL39ZcH03LH9QuG75eA12w2WJAoS34Cx
 chJsLdS6TysgAPjjD/lqwLwrm7jSeIHADHVVWazxG9xvb2skvSxF9P6Hf7MgRgkwlmugb6Yxe5/
 iycN9K8NEoaiheeOy3xgu0bxz5OhxxR2mGvhnUi8pJQ==
X-Received: by 2002:adf:e7d1:0:b0:2d2:d324:e44f with SMTP id
 e17-20020adfe7d1000000b002d2d324e44fmr1833305wrn.16.1679389663370; 
 Tue, 21 Mar 2023 02:07:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set8rdGk1Xi3XCG51r7iI8dIWqGm7FxVlS/Io6weMMs7WpN4AKGfDdGE3SAbdAZa+LqTF4JoysA==
X-Received: by 2002:adf:e7d1:0:b0:2d2:d324:e44f with SMTP id
 e17-20020adfe7d1000000b002d2d324e44fmr1833288wrn.16.1679389663088; 
 Tue, 21 Mar 2023 02:07:43 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 a18-20020a5d4d52000000b002d1e49cff35sm10811622wru.40.2023.03.21.02.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 02:07:42 -0700 (PDT)
Date: Tue, 21 Mar 2023 05:07:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Viktor Prutyanov <viktor@daynix.com>
Subject: Re: [PATCH v2] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <20230321050719-mutt-send-email-mst@kernel.org>
References: <20230320232115.1940587-1-viktor@daynix.com>
 <CACGkMEu5qa2KUHti3w59DcXNxBdh8_ogZ9oW9bo1_PHwbNiCBg@mail.gmail.com>
 <CAPv0NP5wTMG=3kT_FX4xi9kGbX0Dah4qTQfFQPutWYsWvK1i-g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPv0NP5wTMG=3kT_FX4xi9kGbX0Dah4qTQfFQPutWYsWvK1i-g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, yan@daynix.com
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

T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgMTI6MDA6NDJQTSArMDMwMCwgVmlrdG9yIFBydXR5YW5v
diB3cm90ZToKPiBPbiBUdWUsIE1hciAyMSwgMjAyMyBhdCA1OjI54oCvQU0gSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVHVlLCBNYXIgMjEsIDIwMjMg
YXQgNzoyMeKAr0FNIFZpa3RvciBQcnV0eWFub3YgPHZpa3RvckBkYXluaXguY29tPiB3cm90ZToK
PiA+ID4KPiA+ID4gQWNjb3JkaW5nIHRvIFZpcnRJTyBzcGVjIHYxLjIsIFZJUlRJT19GX05PVElG
SUNBVElPTl9EQVRBIGZlYXR1cmUKPiA+ID4gaW5kaWNhdGVzIHRoYXQgdGhlIGRyaXZlciBwYXNz
ZXMgZXh0cmEgZGF0YSBhbG9uZyB3aXRoIHRoZSBxdWV1ZQo+ID4gPiBub3RpZmljYXRpb25zLgo+
ID4gPgo+ID4gPiBJbiBhIHNwbGl0IHF1ZXVlIGNhc2UsIHRoZSBleHRyYSBkYXRhIGlzIDE2LWJp
dCBhdmFpbGFibGUgaW5kZXguIEluIGEKPiA+ID4gcGFja2VkIHF1ZXVlIGNhc2UsIHRoZSBleHRy
YSBkYXRhIGlzIDEtYml0IHdyYXAgY291bnRlciBhbmQgMTUtYml0Cj4gPiA+IGF2YWlsYWJsZSBp
bmRleC4KPiA+ID4KPiA+ID4gQWRkIHN1cHBvcnQgZm9yIHRoaXMgZmVhdHVyZSBmb3IgTU1JTyBh
bmQgUENJIHRyYW5zcG9ydHMuIENoYW5uZWwgSS9PCj4gPiA+IHRyYW5zcG9ydCB3aWxsIG5vdCBh
Y2NlcHQgdGhpcyBmZWF0dXJlLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBWaWt0b3IgUHJ1
dHlhbm92IDx2aWt0b3JAZGF5bml4LmNvbT4KPiA+ID4gLS0tCj4gPiA+Cj4gPiA+ICB2MjogcmVq
ZWN0IHRoZSBmZWF0dXJlIGluIHZpcnRpb19jY3csIHJlcGxhY2UgX19sZTMyIHdpdGggdTMyCj4g
PiA+Cj4gPiA+ICBkcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19jY3cuYyAgIHwgIDQgKy0tLQo+
ID4gPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYyAgICAgICB8IDE1ICsrKysrKysrKysr
KysrLQo+ID4gPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYyB8IDEwICsrKysr
KysrKysKPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmggfCAgNCArKysr
Cj4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgIDIgKy0KPiA+ID4g
IGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgfCAgMiArLQo+ID4gPiAgZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYyAgICAgICB8IDE3ICsrKysrKysrKysrKysrKysrCj4gPiA+
ICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19yaW5nLmggICAgICAgIHwgIDIgKysKPiA+ID4gIGluY2x1
ZGUvdWFwaS9saW51eC92aXJ0aW9fY29uZmlnLmggfCAgNiArKysrKysKPiA+ID4gIDkgZmlsZXMg
Y2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jIGIvZHJpdmVycy9zMzkw
L3ZpcnRpby92aXJ0aW9fY2N3LmMKPiA+ID4gaW5kZXggYTEwZGJlNjMyZWY5Li5kNzJhNTk0MTU1
MjcgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jCj4g
PiA+ICsrKyBiL2RyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jCj4gPiA+IEBAIC03ODks
OSArNzg5LDcgQEAgc3RhdGljIHU2NCB2aXJ0aW9fY2N3X2dldF9mZWF0dXJlcyhzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldikKPiA+ID4KPiA+ID4gIHN0YXRpYyB2b2lkIGNjd190cmFuc3BvcnRf
ZmVhdHVyZXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiA+ICB7Cj4gPiA+IC0gICAg
ICAgLyoKPiA+ID4gLSAgICAgICAgKiBDdXJyZW50bHkgbm90aGluZyB0byBkbyBoZXJlLgo+ID4g
PiAtICAgICAgICAqLwo+ID4gPiArICAgICAgIF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJU
SU9fRl9OT1RJRklDQVRJT05fREFUQSk7Cj4gPgo+ID4gSXMgdGhlcmUgYW55IHJlc3RyaWN0aW9u
IHRoYXQgcHJldmVudHMgdXMgZnJvbSBpbXBsZW1lbnRpbmcKPiA+IFZJUlRJT19GX05PVElGSUNB
VElPTl9EQVRBPyAoU3BlYyBzZWVtcyBkb2Vzbid0IGxpbWl0IHVzIGZyb20gdGhpcykKPiAKPiBN
b3N0IGxpa2VseSwgbm90aGluZy4KClNvIHBscyBjb2RlIGl0IHVwLiBJdCdzIHRoZSBzYW1lIGZv
cm1hdC4KCj4gPgo+ID4gPiAgfQo+ID4gPgo+ID4gPiAgc3RhdGljIGludCB2aXJ0aW9fY2N3X2Zp
bmFsaXplX2ZlYXR1cmVzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19tbWlvLmMKPiA+ID4gaW5kZXggM2ZmNzQ2ZTNmMjRhLi4wZTEzZGExN2ZlMGEgMTAwNjQ0Cj4g
PiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMKPiA+ID4gKysrIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX21taW8uYwo+ID4gPiBAQCAtMjg1LDYgKzI4NSwxOSBAQCBzdGF0aWMg
Ym9vbCB2bV9ub3RpZnkoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gPiA+ICAgICAgICAgcmV0dXJu
IHRydWU7Cj4gPiA+ICB9Cj4gPiA+Cj4gPiA+ICtzdGF0aWMgYm9vbCB2bV9ub3RpZnlfd2l0aF9k
YXRhKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ID4gPiArewo+ID4gPiArICAgICAgIHN0cnVjdCB2
aXJ0aW9fbW1pb19kZXZpY2UgKnZtX2RldiA9IHRvX3ZpcnRpb19tbWlvX2RldmljZSh2cS0+dmRl
dik7Cj4gPiA+ICsgICAgICAgdTMyIGRhdGEgPSB2cmluZ19maWxsX25vdGlmaWNhdGlvbl9kYXRh
KHZxKTsKPiA+Cj4gPiBDYW4gd2UgbW92ZSB0aGlzIHRvIHRoZSBpbml0aWFsaXphdGlvbj8KPiAK
PiBUaGlzIGRhdGEgaXMgbmV3IGZvciBlYWNoIG5vdGlmaWNhdGlvbiwgYmVjYXVzZSBpdCBoZWxw
cyB0byBpZGVudGlmeQo+IHRoZSBuZXh0IGF2YWlsYWJsZSBpbmRleC4KPiAKPiA+Cj4gPiBUaGFu
a3MKPiA+Cj4gCj4gVGhhbmtzLAo+IFZpa3RvciBQcnV0eWFub3YKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
