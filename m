Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151ABEB64D9
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 10:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 660C4402CC;
	Tue,  4 Jul 2023 10:38:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 660C4402CC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WK6+siXT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JGCI5qc_Zf6E; Tue,  4 Jul 2023 10:38:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 96A6640884;
	Tue,  4 Jul 2023 10:38:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96A6640884
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7069BC0071;
	Tue,  4 Jul 2023 10:38:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13CDAC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 10:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6800814B1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 10:38:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6800814B1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WK6+siXT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EXDxBzQrWif7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 10:38:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9ADCB81493
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9ADCB81493
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688467124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRorza6OJCiLsVesM2IH/LA8g4F1XVqMOWMx+3P1rz4=;
 b=WK6+siXTpMKYmAWxQnR86ytA49jxDOu82BBjafOwSP9jIlBDgFrpKEVv7FKPqiak5p9Fak
 fqDrmJPyBk3lm0WEf4frmkab6e6x8+UKDHtu4El8yM9f+vKku2f7eXqOmIPppSrZ15FuQu
 lG3xdFWvZvNkhPLOKaGazIarsmNA9l0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-w4pK0f04Oca6gpj7HFHs2g-1; Tue, 04 Jul 2023 06:38:41 -0400
X-MC-Unique: w4pK0f04Oca6gpj7HFHs2g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fb1a5788f0so4800931e87.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jul 2023 03:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688467119; x=1691059119;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QRorza6OJCiLsVesM2IH/LA8g4F1XVqMOWMx+3P1rz4=;
 b=dFRu/LF1cUtTzXyhRJoBwYkBfU3D/9OHGf+LwlVFc9Xtta12/k16XDbRG2rXTOK37o
 O7lOSGVMCvNbspKn4LFJytjyUNtllBXvDOJ80fX/UYqxr0DXXNHiJMYYp7HdDVpld1bS
 M9KnXTdbUd3xl8mZzDUfC6d7LfEnrqyuH+lJZLycQM+nTNoF3M3X9Rx9BLkt5u+xCcdX
 ARXIOVwxyNNLFWSuUTlV1hIO+VOVxWlm8ZGb3L4hK8Ja2lOeyFS92qlOcSestgy/ynHI
 FLL2D+MI5cFuSByApBvOwmrsVhXjozKiH0PosQN2wPRPAIA/LIrDvig0L/jjuo2pbDOH
 Pmng==
X-Gm-Message-State: ABy/qLZA0tU+AiBvB10DfKBrTUHE6MxtoufQUn4brCWTB9arEmgRLg8O
 gDfFLdtfCjtqA+ygBXBN3hoP/Omc/cwdTicGpVpRfxspoveDULvNIMM64TFT9iLKFMaCJCjcFf1
 XDQoieu0L4NI7OLkvIrNS8TZsHJzUOoRyNYX+TcqmnQ==
X-Received: by 2002:a05:6512:39d3:b0:4f7:405f:72e7 with SMTP id
 k19-20020a05651239d300b004f7405f72e7mr10638815lfu.50.1688467119712; 
 Tue, 04 Jul 2023 03:38:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGDGMjGihqxX02HuxnbdBtGBjZZQqY3m1CG+EemG0uaYcjxxZV8C9XGiMcmo2QCieoBmTukg==
X-Received: by 2002:a05:6512:39d3:b0:4f7:405f:72e7 with SMTP id
 k19-20020a05651239d300b004f7405f72e7mr10638796lfu.50.1688467119354; 
 Tue, 04 Jul 2023 03:38:39 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 z7-20020a05600c220700b003fa999cefc0sm23940722wml.36.2023.07.04.03.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 03:38:38 -0700 (PDT)
Date: Tue, 4 Jul 2023 06:38:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230704063646-mutt-send-email-mst@kernel.org>
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

T24gVHVlLCBKdWwgMDQsIDIwMjMgYXQgMTI6MjU6MzJQTSArMDIwMCwgRXVnZW5pbyBQZXJleiBN
YXJ0aW4gd3JvdGU6Cj4gT24gTW9uLCBKdWwgMywgMjAyMyBhdCA0OjUy4oCvUE0gTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uLCBKdWwgMDMs
IDIwMjMgYXQgMDQ6MjI6MThQTSArMDIwMCwgRXVnZW5pbyBQw6lyZXogd3JvdGU6Cj4gPiA+IFdp
dGggdGhlIGN1cnJlbnQgY29kZSBpdCBpcyBhY2NlcHRlZCBhcyBsb25nIGFzIHVzZXJsYW5kIHNl
bmQgaXQuCj4gPiA+Cj4gPiA+IEFsdGhvdWdoIHVzZXJsYW5kIHNob3VsZCBub3Qgc2V0IGEgZmVh
dHVyZSBmbGFnIHRoYXQgaGFzIG5vdCBiZWVuCj4gPiA+IG9mZmVyZWQgdG8gaXQgd2l0aCBWSE9T
VF9HRVRfQkFDS0VORF9GRUFUVVJFUywgdGhlIGN1cnJlbnQgY29kZSB3aWxsIG5vdAo+ID4gPiBj
b21wbGFpbiBmb3IgaXQuCj4gPiA+Cj4gPiA+IFNpbmNlIHRoZXJlIGlzIG5vIHNwZWNpZmljIHJl
YXNvbiBmb3IgYW55IHBhcmVudCB0byByZWplY3QgdGhhdCBiYWNrZW5kCj4gPiA+IGZlYXR1cmUg
Yml0IHdoZW4gaXQgaGFzIGJlZW4gcHJvcG9zZWQsIGxldCdzIGNvbnRyb2wgaXQgYXQgdmRwYSBm
cm9udGVuZAo+ID4gPiBsZXZlbC4gRnV0dXJlIHBhdGNoZXMgbWF5IG1vdmUgdGhpcyBjb250cm9s
IHRvIHRoZSBwYXJlbnQgZHJpdmVyLgo+ID4gPgo+ID4gPiBGaXhlczogOTY3ODAwZDJkNTJlICgi
dmRwYTogYWNjZXB0IFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LIGJhY2tl
bmQgZmVhdHVyZSIpCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXpt
YUByZWRoYXQuY29tPgo+ID4KPiA+IFBsZWFzZSBkbyBzZW5kIHYzLiBBbmQgYWdhaW4sIEkgZG9u
J3Qgd2FudCB0byBzZW5kICJhZnRlciBkcml2ZXIgb2siIGhhY2sKPiA+IHVwc3RyZWFtIGF0IGFs
bCwgSSBtZXJnZWQgaXQgaW4gbmV4dCBqdXN0IHRvIGdpdmUgaXQgc29tZSB0ZXN0aW5nLgo+ID4g
V2Ugd2FudCBSSU5HX0FDQ0VTU19BRlRFUl9LSUNLIG9yIHNvbWUgc3VjaC4KPiA+Cj4gCj4gQ3Vy
cmVudCBkZXZpY2VzIGRvIG5vdCBzdXBwb3J0IHRoYXQgc2VtYW50aWMuCgpXaGljaCBkZXZpY2Vz
IHNwZWNpZmljYWxseSBhY2Nlc3MgdGhlIHJpbmcgYWZ0ZXIgRFJJVkVSX09LIGJ1dCBiZWZvcmUK
YSBraWNrPwoKPiBNeSBwbGFuIHdhcyB0byBjb252ZXJ0Cj4gaXQgaW4gdnBfdmRwYSBpZiBuZWVk
ZWQsIGFuZCByZXVzZSB0aGUgY3VycmVudCB2ZHBhIG9wcy4gU29ycnkgaWYgSQo+IHdhcyBub3Qg
ZXhwbGljaXQgZW5vdWdoLgo+IAo+IFRoZSBvbmx5IHNvbHV0aW9uIEkgY2FuIHNlZSB0byB0aGF0
IGlzIHRvIHRyYXAgJiBlbXVsYXRlIGluIHRoZSB2ZHBhCj4gKHBhcmVudD8pIGRyaXZlciwgYXMg
dGFsa2VkIGluIHZpcnRpby1jb21tZW50LiBCdXQgdGhhdCBjb21wbGljYXRlcwo+IHRoZSBhcmNo
aXRlY3R1cmU6Cj4gKiBPZmZlciBWSE9TVF9CQUNLRU5EX0ZfUklOR19BQ0NFU1NfQUZURVJfS0lD
Swo+ICogU3RvcmUgdnEgZW5hYmxlIHN0YXRlIHNlcGFyYXRlbHksIGF0Cj4gdmRwYS0+Y29uZmln
LT5zZXRfdnFfcmVhZHkodHJ1ZSksIGJ1dCBub3QgdHJhbnNtaXQgdGhhdCBlbmFibGUgdG8gaHcK
PiAqIFN0b3JlIHRoZSBkb29yYmVsbCBzdGF0ZSBzZXBhcmF0ZWx5LCBidXQgZG8gbm90IGNvbmZp
Z3VyZSBpdCB0byB0aGUKPiBkZXZpY2UgZGlyZWN0bHkuCj4gCj4gQnV0IGhvdyB0byByZWNvdmVy
IGlmIHRoZSBkZXZpY2UgY2Fubm90IGNvbmZpZ3VyZSB0aGVtIGF0IGtpY2sgdGltZSwKPiBmb3Ig
ZXhhbXBsZT8KPiAKPiBNYXliZSB3ZSBjYW4ganVzdCBmYWlsIGlmIHRoZSBwYXJlbnQgZHJpdmVy
IGRvZXMgbm90IHN1cHBvcnQgZW5hYmxpbmcKPiB0aGUgdnEgYWZ0ZXIgRFJJVkVSX09LPyBUaGF0
IHdheSBubyBuZXcgZmVhdHVyZSBmbGFnIGlzIG5lZWRlZC4KPiAKPiBUaGFua3MhCj4gCj4gPgo+
ID4gPiAtLS0KPiA+ID4gU2VudCB3aXRoIEZpeGVzOiB0YWcgcG9pbnRpbmcgdG8gZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21zdAo+ID4gPiBjb21taXQuIFBsZWFzZSBs
ZXQgbWUga25vdyBpZiBJIHNob3VsZCBzZW5kIGEgdjMgb2YgWzFdIGluc3RlYWQuCj4gPiA+Cj4g
PiA+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwNjA5MTIxMjQ0LW11dHQt
c2VuZC1lbWFpbC1tc3RAa2VybmVsLm9yZy9ULwo+ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMvdmhv
c3QvdmRwYS5jIHwgNyArKysrKy0tCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9z
dC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiBpbmRleCBlMWFiZjI5ZmVkNWIu
LmE3ZTU1NDM1MjM1MSAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+
ID4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gQEAgLTY4MSwxOCArNjgxLDIxIEBA
IHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVw
LAo+ID4gPiAgewo+ID4gPiAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9IGZpbGVwLT5wcml2
YXRlX2RhdGE7Cj4gPiA+ICAgICAgIHN0cnVjdCB2aG9zdF9kZXYgKmQgPSAmdi0+dmRldjsKPiA+
ID4gKyAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdi0+dmRwYS0+Y29u
ZmlnOwo+ID4gPiAgICAgICB2b2lkIF9fdXNlciAqYXJncCA9ICh2b2lkIF9fdXNlciAqKWFyZzsK
PiA+ID4gICAgICAgdTY0IF9fdXNlciAqZmVhdHVyZXAgPSBhcmdwOwo+ID4gPiAtICAgICB1NjQg
ZmVhdHVyZXM7Cj4gPiA+ICsgICAgIHU2NCBmZWF0dXJlcywgcGFyZW50X2ZlYXR1cmVzID0gMDsK
PiA+ID4gICAgICAgbG9uZyByID0gMDsKPiA+ID4KPiA+ID4gICAgICAgaWYgKGNtZCA9PSBWSE9T
VF9TRVRfQkFDS0VORF9GRUFUVVJFUykgewo+ID4gPiAgICAgICAgICAgICAgIGlmIChjb3B5X2Zy
b21fdXNlcigmZmVhdHVyZXMsIGZlYXR1cmVwLCBzaXplb2YoZmVhdHVyZXMpKSkKPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOwo+ID4gPiArICAgICAgICAgICAgIGlm
IChvcHMtPmdldF9iYWNrZW5kX2ZlYXR1cmVzKQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
cGFyZW50X2ZlYXR1cmVzID0gb3BzLT5nZXRfYmFja2VuZF9mZWF0dXJlcyh2LT52ZHBhKTsKPiA+
ID4gICAgICAgICAgICAgICBpZiAoZmVhdHVyZXMgJiB+KFZIT1NUX1ZEUEFfQkFDS0VORF9GRUFU
VVJFUyB8Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NU
X0JBQ0tFTkRfRl9TVVNQRU5EKSB8Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUpIHwKPiA+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklW
RVJfT0spKSkKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9mZWF0
dXJlcykpCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4g
PiA+ICAgICAgICAgICAgICAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9G
X1NVU1BFTkQpKSAmJgo+ID4gPiAgICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfY2FuX3N1
c3BlbmQodikpCj4gPiA+IC0tCj4gPiA+IDIuMzkuMwo+ID4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
