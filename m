Return-Path: <SRS0=5BC2=MD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B0DC07E96
	for <virtualization@archiver.kernel.org>; Sun, 11 Jul 2021 16:08:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A32561166
	for <virtualization@archiver.kernel.org>; Sun, 11 Jul 2021 16:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A32561166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00F5840119;
	Sun, 11 Jul 2021 16:08:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mP_XUQtse6_U; Sun, 11 Jul 2021 16:08:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 71E39400F1;
	Sun, 11 Jul 2021 16:08:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F61DC0010;
	Sun, 11 Jul 2021 16:08:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0BE0C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 16:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA76560768
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 16:08:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bxtes7yai4G5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 16:08:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9430B6059C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626019700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XELSw37O8TDJHMK3is14sKF8BhQBplTncIZKxDsEcK0=;
 b=J9SDN4Gaio6b23X3tBfaRJDFaek96Lgsyfbwx5HlborYNVfdK9UIJ/YRL1ZYnVZjj/o6w1
 294EwgUPdGxwapTGJwugt/xLel132R+DMATJxbet/lUZR8/8GkMi3DFD0yOyh00jJTZDDa
 FEuuxeQUo2F0tBdkEg0wVM0jIOy89D4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-NQefH1z4N4GSvQSwH-5V7w-1; Sun, 11 Jul 2021 12:08:16 -0400
X-MC-Unique: NQefH1z4N4GSvQSwH-5V7w-1
Received: by mail-ed1-f70.google.com with SMTP id
 p13-20020a05640210cdb029039560ff6f46so8441439edu.17
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 09:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=XELSw37O8TDJHMK3is14sKF8BhQBplTncIZKxDsEcK0=;
 b=VQAYxZhkrNP3o53ihjb3zhHWASRc6A3Mu7Gdvh8p5Gz8+iW6UgoKT9kNDm5sOJFI2e
 UIctP1YKSWYv3h3sko+ndSKYsmDCuHxnx7FHIYcKe/+Y0RNz+Bf+ZuliI0oaw+uksKu3
 qOXurdt5ltFtPQeWZH2Fatku/ghCfh4btwotB2EVXpC/0Uzjn4wsfbjSt0Ah28tLY06+
 wcVv/8qFykq0/sHSYliduHr4JHW5du2RUmK/5GqhbzcQ0Sr8Lhv5wlO+f/nQxQMriUem
 KyHmcSACEBS8GeAz2y0JKIDdpGf76RL+XlHm7zuFdHctPSG9QVq46dRPdkjyP9hMa3vs
 ALzQ==
X-Gm-Message-State: AOAM533q2mAn0t5jDnvLBI8FIUYp5uaIyQ3whXER2Zd71DQq/k/jyHma
 2mmuOJh+yQawfIbpH/xl/vC/T01VyihJ9rsEy5qtBRuvX5bmyDsF1B9ayaOuGcZbhG+mhHds/oe
 Bv1EuCLyFr1SDQ0lq+s4ojISLTaFDnQYyzGpEW/vWrw==
X-Received: by 2002:a17:906:5fc1:: with SMTP id
 k1mr27785409ejv.360.1626019695552; 
 Sun, 11 Jul 2021 09:08:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoOutlQAd3/f1sy1nxXxkoEnxMXnTXG9X2/DyP8QFWC6t3h/0LFkJ/lZQlZunhgEyGPQEKoA==
X-Received: by 2002:a17:906:5fc1:: with SMTP id
 k1mr27785387ejv.360.1626019695342; 
 Sun, 11 Jul 2021 09:08:15 -0700 (PDT)
Received: from redhat.com ([2.55.136.76])
 by smtp.gmail.com with ESMTPSA id y7sm5292459edc.86.2021.07.11.09.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jul 2021 09:08:14 -0700 (PDT)
Date: Sun, 11 Jul 2021 12:08:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
Message-ID: <20210711120627-mutt-send-email-mst@kernel.org>
References: <20210423080942.2997-1-jasowang@redhat.com>
 <0e9d70b7-6c8a-4ff5-1fa9-3c4f04885bb8@redhat.com>
 <20210506041057-mutt-send-email-mst@kernel.org>
 <20210506123829.GA403858@infradead.org>
 <20210514063516-mutt-send-email-mst@kernel.org>
 <8bf22db2-97d4-9f88-8b6b-d685fd63ac8b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8bf22db2-97d4-9f88-8b6b-d685fd63ac8b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, xieyongji@bytedance.com,
 stefanha@redhat.com
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

T24gRnJpLCBKdW4gMDQsIDIwMjEgYXQgMDE6Mzg6MDFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS81LzE0IOS4i+WNiDc6MTMsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnp
gZM6Cj4gPiBPbiBUaHUsIE1heSAwNiwgMjAyMSBhdCAwMTozODoyOVBNICswMTAwLCBDaHJpc3Rv
cGggSGVsbHdpZyB3cm90ZToKPiA+ID4gT24gVGh1LCBNYXkgMDYsIDIwMjEgYXQgMDQ6MTI6MTdB
TSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+IExldCdzIHRyeSBmb3Ig
anVzdCBhIGJpdCwgd29uJ3QgbWFrZSB0aGlzIHdpbmRvdyBhbnl3YXk6Cj4gPiA+ID4gCj4gPiA+
ID4gSSBoYXZlIGFuIG9sZCBpZGVhLiBBZGQgYSB3YXkgdG8gZmluZCBvdXQgdGhhdCB1bm1hcCBp
cyBhIG5vcAo+ID4gPiA+IChvciBtb3JlIGV4YWN0bHkgZG9lcyBub3QgdXNlIHRoZSBhZGRyZXNz
L2xlbmd0aCkuCj4gPiA+ID4gVGhlbiBpbiB0aGF0IGNhc2UgZXZlbiB3aXRoIERNQSBBUEkgd2Ug
ZG8gbm90IG5lZWQKPiA+ID4gPiB0aGUgZXh0cmEgZGF0YS4gSG1tPwo+ID4gPiBTbyB3ZSBhY3R1
YWxseSBkbyBoYXZlIGEgY2hlY2sgZm9yIHRoYXQgZnJvbSB0aGUgZWFybHkgZGF5cyBvZiB0aGUg
RE1BCj4gPiA+IEFQSSwgYnV0IGl0IG9ubHkgd29ya3MgYXQgY29tcGlsZSB0aW1lOiBDT05GSUdf
TkVFRF9ETUFfTUFQX1NUQVRFLgo+ID4gPiAKPiA+ID4gQnV0IGdpdmVuIGhvdyByYXJlIGNvbmZp
Z3Mgd2l0aG91dCBhbiBpb21tdSBvciBzd2lvdGxiIGFyZSB0aGVzZSBkYXlzCj4gPiA+IGl0IGhh
cyBzdG9wcGVkIHRvIGJlIHZlcnkgdXNlZnVsLiAgVW5mb3J0dW5hdGVseSBhIHJ1bnRpbWUtdmVy
c2lvbiBpcwo+ID4gPiBub3QgZW50aXJlbHkgdHJpdmlhbCwgYnV0IG1heWJlIGlmIHdlIGFsbG93
IGZvciBmYWxzZSBwb3NpdGl2ZXMgd2UKPiA+ID4gY291bGQgZG8gc29tZXRoaW5nIGxpa2UgdGhp
cwo+ID4gPiAKPiA+ID4gYm9vbCBkbWFfZGlyZWN0X25lZWRfc3RhdGUoc3RydWN0IGRldmljZSAq
ZGV2KQo+ID4gPiB7Cj4gPiA+IAkvKiBzb21lIGFyZWFzIGNvdWxkIG5vdCBiZSBjb3ZlcmVkIGJ5
IGFueSBtYXAgYXQgYWxsICovCj4gPiA+IAlpZiAoZGV2LT5kbWFfcmFuZ2VfbWFwKQo+ID4gPiAJ
CXJldHVybiBmYWxzZTsKPiA+ID4gCWlmIChmb3JjZV9kbWFfdW5lbmNyeXB0ZWQoZGV2KSkKPiA+
ID4gCQlyZXR1cm4gZmFsc2U7Cj4gPiA+IAlpZiAoZG1hX2RpcmVjdF9uZWVkX3N5bmMoZGV2KSkK
PiA+ID4gCQlyZXR1cm4gZmFsc2U7Cj4gPiA+IAlyZXR1cm4gKmRldi0+ZG1hX21hc2sgPT0gRE1B
X0JJVF9NQVNLKDY0KTsKPiA+ID4gfQo+ID4gPiAKPiA+ID4gYm9vbCBkbWFfbmVlZF9zdGF0ZShz
dHJ1Y3QgZGV2aWNlICpkZXYpCj4gPiA+IHsKPiA+ID4gCWNvbnN0IHN0cnVjdCBkbWFfbWFwX29w
cyAqb3BzID0gZ2V0X2RtYV9vcHMoZGV2KTsKPiA+ID4gCj4gPiA+IAlpZiAoZG1hX21hcF9kaXJl
Y3QoZGV2LCBvcHMpKQo+ID4gPiAJCXJldHVybiBkbWFfZGlyZWN0X25lZWRfc3RhdGUoZGV2KTsK
PiA+ID4gCXJldHVybiBvcHMtPnVubWFwX3BhZ2UgfHwKPiA+ID4gCQlvcHMtPnN5bmNfc2luZ2xl
X2Zvcl9jcHUgfHwgb3BzLT5zeW5jX3NpbmdsZV9mb3JfZGV2aWNlOwo+ID4gPiB9Cj4gPiBZZWEg
dGhhdCBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYS4gV2Ugd2lsbCBuZWVkIHRvIGRvY3VtZW50IHRo
YXQuCj4gPiAKPiA+IAo+ID4gU29tZXRoaW5nIGxpa2U6Cj4gPiAKPiA+IC8qCj4gPiAgICogZG1h
X25lZWRfc3RhdGUgLSByZXBvcnQgd2hldGhlciB1bm1hcCBjYWxscyB1c2UgdGhlIGFkZHJlc3Mg
YW5kIGxlbmd0aAo+ID4gICAqIEBkZXY6IGRldmljZSB0byBndWVyeQo+ID4gICAqCj4gPiAgICog
VGhpcyBpcyBhIHJ1bnRpbWUgdmVyc2lvbiBvZiBDT05GSUdfTkVFRF9ETUFfTUFQX1NUQVRFLgo+
ID4gICAqCj4gPiAgICogUmV0dXJuIHRoZSB2YWx1ZSBpbmRpY2F0aW5nIHdoZXRoZXIgZG1hX3Vu
bWFwXyogYW5kIGRtYV9zeW5jXyogY2FsbHMgZm9yIHRoZSBkZXZpY2UKPiA+ICAgKiB1c2UgdGhl
IERNQSBzdGF0ZSBwYXJhbWV0ZXJzIHBhc3NlZCB0byB0aGVtLgo+ID4gICAqIFRoZSBETUEgc3Rh
dGUgcGFyYW1ldGVycyBhcmU6IHNjYXR0ZXIvZ2F0aGVyIGxpc3QvdGFibGUsIGFkZHJlc3MgYW5k
Cj4gPiAgICogbGVuZ3RoLgo+ID4gICAqCj4gPiAgICogSWYgZG1hX25lZWRfc3RhdGUgcmV0dXJu
cyBmYWxzZSB0aGVuIERNQSBzdGF0ZSBwYXJhbWV0ZXJzIGFyZQo+ID4gICAqIGlnbm9yZWQgYnkg
YWxsIGRtYV91bm1hcF8qIGFuZCBkbWFfc3luY18qIGNhbGxzLCBzbyBpdCBpcyBzYWZlIHRvIHBh
c3MgMCBmb3IKPiA+ICAgKiBhZGRyZXNzIGFuZCBsZW5ndGgsIGFuZCBETUFfVU5NQVBfU0dfVEFC
TEVfSU5WQUxJRCBhbmQKPiA+ICAgKiBETUFfVU5NQVBfU0dfTElTVF9JTlZBTElEIGZvciBzL2cg
dGFibGUgYW5kIGxlbmd0aCByZXNwZWN0aXZlbHkuCj4gPiAgICogSWYgZG1hX25lZWRfc3RhdGUg
cmV0dXJucyB0cnVlIHRoZW4gRE1BIHN0YXRlIG1pZ2h0Cj4gPiAgICogYmUgdXNlZCBhbmQgc28g
dGhlIGFjdHVhbCB2YWx1ZXMgYXJlIHJlcXVpcmVkLgo+ID4gICAqLwo+ID4gCj4gPiBBbmQgd2Ug
d2lsbCBuZWVkIERNQV9VTk1BUF9TR19UQUJMRV9JTlZBTElEIGFuZAo+ID4gRE1BX1VOTUFQX1NH
X0xJU1RfSU5WQUxJRCBhcyBwb2ludGVycyB0byBhbiBlbXB0eSBnbG9iYWwgdGFibGUgYW5kIGxp
c3QKPiA+IGZvciBjYWxscyBzdWNoIGFzIGRtYV91bm1hcF9zZ3RhYmxlIHRoYXQgZGVyZWZlcmVu
Y2UgcG9pbnRlcnMgYmVmb3JlIGNoZWNraW5nCj4gPiB0aGV5IGFyZSB1c2VkLgo+ID4gCj4gPiAK
PiA+IERvZXMgdGhpcyBsb29rIGdvb2Q/Cj4gPiAKPiA+IFRoZSB0YWJsZS9sZW5ndGggdmFyaWFu
dHMgYXJlIGZvciBjb25zaXN0ZW5jeSwgdmlydGlvIHNwZWNpZmljYWxseSBkb2VzCj4gPiBub3Qg
dXNlIHMvZyBhdCB0aGUgbW9tZW50LCBidXQgaXQgc2VlbXMgbmljZXIgdGhhbiBsZWF2aW5nCj4g
PiB1c2VycyB3b25kZXIgd2hhdCB0byBkbyBhYm91dCB0aGVzZS4KPiA+IAo+ID4gVGhvdWdodHM/
IEphc29uIHdhbnQgdG8gdHJ5IGltcGxlbWVudGluZz8KPiAKPiAKPiBJIGNhbiBhZGQgaXQgaW4g
bXkgdG9kbyBsaXN0IG90aGVyIGlmIG90aGVyIHBlb3BsZSBhcmUgaW50ZXJlc3RlZCBpbiB0aGlz
LAo+IHBsZWFzZSBsZXQgdXMga25vdy4KPiAKPiBCdXQgdGhpcyBpcyBqdXN0IGFib3V0IHNhdmlu
ZyB0aGUgZWZmb3J0cyBvZiB1bm1hcCBhbmQgaXQgZG9lc24ndCBlbGltaW5hdGUKPiB0aGUgbmVj
ZXNzYXJ5IG9mIHVzaW5nIHByaXZhdGUgbWVtb3J5IChhZGRyLCBsZW5ndGgpIGZvciB0aGUgbWV0
YWRhdGEgZm9yCj4gdmFsaWRhdGluZyB0aGUgZGV2aWNlIGlucHV0cy4KCgpCZXNpZGVzIHVubWFw
LCB3aHkgZG8gd2UgbmVlZCB0byB2YWxpZGF0ZSBhZGRyZXNzPyBsZW5ndGggY2FuIGJlCnR5cGlj
YWxseSB2YWxpZGF0ZWQgYnkgc3BlY2lmaWMgZHJpdmVycyAtIG5vdCBhbGwgb2YgdGhlbSBldmVu
IHVzZSBpdCAuLgoKPiBBbmQganVzdCB0byBjbGFyaWZ5LCB0aGUgc2xpZ2h0IHJlZ3Jlc3Npb24g
d2Ugc2VlIGlzIHRlc3Rpbmcgd2l0aG91dAo+IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSB3aGlj
aCBtZWFucyBETUEgQVBJIGlzIG5vdCB1c2VkLgoKSSBndWVzcyB0aGlzIGlzIGR1ZSB0byBleHRy
YSBjYWNoZSBwcmVzc3VyZT8gTWF5YmUgY3JlYXRlIHlldCBhbm90aGVyCmFycmF5IGp1c3QgZm9y
IERNQSBzdGF0ZSAuLi4KCj4gU28gSSB3aWxsIGdvIHRvIHBvc3QgYSBmb3JtYWwgdmVyc2lvbiBv
ZiB0aGlzIHNlcmllcyBhbmQgd2UgY2FuIHN0YXJ0IGZyb20KPiB0aGVyZS4KPiAKPiBUaGFua3MK
PiAKPiAKPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
