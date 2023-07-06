Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF28EB64DA
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 01:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26B2881D18;
	Thu,  6 Jul 2023 01:56:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26B2881D18
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EU5yp9p4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ZR4izCZdHEW; Thu,  6 Jul 2023 01:56:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E84481A0D;
	Thu,  6 Jul 2023 01:56:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E84481A0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6502EC0071;
	Thu,  6 Jul 2023 01:56:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A919CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8333681D11
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8333681D11
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uwockbjroYWf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:56:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A34B81A0D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A34B81A0D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688608604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EqDroqLviQEGeLkIXDsNROSinaXH/bWW7KlW3DhF9v0=;
 b=EU5yp9p4uWZ98e16gvPRIGdwgyLmWnzoHJ1CH4F4P7wOgBy4cnqQ95hmpAE93J82vJD5yI
 LlrRwkpmLmZuf7yw5WtNGyp2RhhvXgY6iNl/kwg9XCCC7LCOsTH75H72+f8riQ5e/47gmI
 YkM5UwOMawndyO9R30nVNy15fpEVyYE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-u1d--FTNMKy7J_hEHNDTSw-1; Wed, 05 Jul 2023 21:56:42 -0400
X-MC-Unique: u1d--FTNMKy7J_hEHNDTSw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b703d64832so2769901fa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 18:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688608601; x=1691200601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqDroqLviQEGeLkIXDsNROSinaXH/bWW7KlW3DhF9v0=;
 b=V9xDUSR9hwZL/7SP4+cSBuu2b2SUySvQx1GRyjdGbhWJpc+FdH+8I/jQ0Euyp/nKSz
 XWmsUNivqSRn/ze+v8f7DTDj5OUSYntLzP9nvZkk2DlCi7CLvNkoE5QWxEvwhQt9/Wwd
 HQ51+p6qMrKx1qnNJ2rlB+ph08omCdmP+PCMWOaCKgoNypgnSKVpzvXcv8ua5mnDCZ5B
 dRJo4q8JFp5+K71KQUDzg+mZvUR5ZhyuRmdvtRSGQZUB5CgW8Uo9zCGtkV2vsKQTfqrN
 ZhL4H4ZZt8FJrQ5Oy2YBF5CItzr/ooeZ8dDGMeAXz49+qexpa5Is+UL3BTFdV4EKUqlw
 K+qQ==
X-Gm-Message-State: ABy/qLa9/x15WjjcnrueR7BryLXdinZXvQr8tjba0dHEnKjbOCXJRzdy
 g8j0OnxNMEhzt09rQg0JCdkcQltogj2Vq+X8qI8//Iqs0vwDh/pIwqqzs1QumQnb9DI1Qw75YYg
 +THECGuN5+y8uJKLJXXqVH/CKCtoHxoNPUP0/kIbGNmXZtyZmypXZxMN2Lw==
X-Received: by 2002:a2e:9c82:0:b0:2b6:e9b9:4039 with SMTP id
 x2-20020a2e9c82000000b002b6e9b94039mr392889lji.35.1688608601005; 
 Wed, 05 Jul 2023 18:56:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFKS2J0e7/UUx6A/PgS2Q4XzdnwRaHcbBSWnEqCy1k8PV6J3XtVhrGjzxXzvKhr5fpzP/pbECRCNoLCbPpI01g=
X-Received: by 2002:a2e:9c82:0:b0:2b6:e9b9:4039 with SMTP id
 x2-20020a2e9c82000000b002b6e9b94039mr392881lji.35.1688608600690; Wed, 05 Jul
 2023 18:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CACGkMEvT4Y+-wfhyi324Y5hhAtn+ZF7cP9d=omdH-ZgdJ-4SOQ@mail.gmail.com>
 <20230705044151-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230705044151-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jul 2023 09:56:29 +0800
Message-ID: <CACGkMEu0MhQqNbrg9WkyGBboFU5RSqCs1W8LpksW4mO7hGxd7g@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio Perez Martin <eperezma@redhat.com>
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

T24gV2VkLCBKdWwgNSwgMjAyMyBhdCA0OjQy4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEp1bCAwNSwgMjAyMyBhdCAwMzo1NToyM1BN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCA2OjM4
4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4g
PiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDEyOjI1OjMyUE0gKzAyMDAsIEV1Z2VuaW8gUGVy
ZXogTWFydGluIHdyb3RlOgo+ID4gPiA+IE9uIE1vbiwgSnVsIDMsIDIwMjMgYXQgNDo1MuKAr1BN
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+
ID4gPiA+IE9uIE1vbiwgSnVsIDAzLCAyMDIzIGF0IDA0OjIyOjE4UE0gKzAyMDAsIEV1Z2VuaW8g
UMOpcmV6IHdyb3RlOgo+ID4gPiA+ID4gPiBXaXRoIHRoZSBjdXJyZW50IGNvZGUgaXQgaXMgYWNj
ZXB0ZWQgYXMgbG9uZyBhcyB1c2VybGFuZCBzZW5kIGl0Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiBBbHRob3VnaCB1c2VybGFuZCBzaG91bGQgbm90IHNldCBhIGZlYXR1cmUgZmxhZyB0aGF0IGhh
cyBub3QgYmVlbgo+ID4gPiA+ID4gPiBvZmZlcmVkIHRvIGl0IHdpdGggVkhPU1RfR0VUX0JBQ0tF
TkRfRkVBVFVSRVMsIHRoZSBjdXJyZW50IGNvZGUgd2lsbCBub3QKPiA+ID4gPiA+ID4gY29tcGxh
aW4gZm9yIGl0Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBTaW5jZSB0aGVyZSBpcyBubyBzcGVj
aWZpYyByZWFzb24gZm9yIGFueSBwYXJlbnQgdG8gcmVqZWN0IHRoYXQgYmFja2VuZAo+ID4gPiA+
ID4gPiBmZWF0dXJlIGJpdCB3aGVuIGl0IGhhcyBiZWVuIHByb3Bvc2VkLCBsZXQncyBjb250cm9s
IGl0IGF0IHZkcGEgZnJvbnRlbmQKPiA+ID4gPiA+ID4gbGV2ZWwuIEZ1dHVyZSBwYXRjaGVzIG1h
eSBtb3ZlIHRoaXMgY29udHJvbCB0byB0aGUgcGFyZW50IGRyaXZlci4KPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gRml4ZXM6IDk2NzgwMGQyZDUyZSAoInZkcGE6IGFjY2VwdCBWSE9TVF9CQUNLRU5E
X0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBiYWNrZW5kIGZlYXR1cmUiKQo+ID4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiBQbGVhc2UgZG8gc2VuZCB2My4gQW5kIGFnYWluLCBJIGRvbid0IHdhbnQg
dG8gc2VuZCAiYWZ0ZXIgZHJpdmVyIG9rIiBoYWNrCj4gPiA+ID4gPiB1cHN0cmVhbSBhdCBhbGws
IEkgbWVyZ2VkIGl0IGluIG5leHQganVzdCB0byBnaXZlIGl0IHNvbWUgdGVzdGluZy4KPiA+ID4g
PiA+IFdlIHdhbnQgUklOR19BQ0NFU1NfQUZURVJfS0lDSyBvciBzb21lIHN1Y2guCj4gPiA+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4gQ3VycmVudCBkZXZpY2VzIGRvIG5vdCBzdXBwb3J0IHRoYXQgc2Vt
YW50aWMuCj4gPiA+Cj4gPiA+IFdoaWNoIGRldmljZXMgc3BlY2lmaWNhbGx5IGFjY2VzcyB0aGUg
cmluZyBhZnRlciBEUklWRVJfT0sgYnV0IGJlZm9yZQo+ID4gPiBhIGtpY2s/Cj4gPgo+ID4gVmhv
c3QtbmV0IGlzIG9uZSBleGFtcGxlIGF0IGxhc3QuIEl0IHBvbGxzIGEgc29ja2V0IGFzIHdlbGws
IHNvIGl0Cj4gPiBzdGFydHMgdG8gYWNjZXNzIHRoZSByaW5nIGltbWVkaWF0ZWx5IGFmdGVyIERS
SVZFUl9PSy4KPiA+Cj4gPiBUaGFua3MKPgo+Cj4gRm9yIHN1cmUgYnV0IHRoYXQgaXMgbm90IHZk
cGEuCgpTb21laG93IHZpYSB2cF92ZHBhIHRoYXQgSSdtIHVzdWFsbHkgdGVzdGluZyB2RFBBIHBh
dGNoZXMuCgpUaGUgcHJvYmxlbSBpcyB0aGF0IGl0J3MgdmVyeSBoYXJkIHRvIGF1ZGl0IGFsbCB2
RFBBIGRldmljZXMgbm93IGlmIGl0CmlzIG5vdCBkZWZpbmVkIGluIHRoZSBzcGVjIGJlZm9yZSB0
aGV5IGFyZSBpbnZlbnRlZC4KClRoYW5rcwoKPgo+ID4gPgo+ID4gPiA+IE15IHBsYW4gd2FzIHRv
IGNvbnZlcnQKPiA+ID4gPiBpdCBpbiB2cF92ZHBhIGlmIG5lZWRlZCwgYW5kIHJldXNlIHRoZSBj
dXJyZW50IHZkcGEgb3BzLiBTb3JyeSBpZiBJCj4gPiA+ID4gd2FzIG5vdCBleHBsaWNpdCBlbm91
Z2guCj4gPiA+ID4KPiA+ID4gPiBUaGUgb25seSBzb2x1dGlvbiBJIGNhbiBzZWUgdG8gdGhhdCBp
cyB0byB0cmFwICYgZW11bGF0ZSBpbiB0aGUgdmRwYQo+ID4gPiA+IChwYXJlbnQ/KSBkcml2ZXIs
IGFzIHRhbGtlZCBpbiB2aXJ0aW8tY29tbWVudC4gQnV0IHRoYXQgY29tcGxpY2F0ZXMKPiA+ID4g
PiB0aGUgYXJjaGl0ZWN0dXJlOgo+ID4gPiA+ICogT2ZmZXIgVkhPU1RfQkFDS0VORF9GX1JJTkdf
QUNDRVNTX0FGVEVSX0tJQ0sKPiA+ID4gPiAqIFN0b3JlIHZxIGVuYWJsZSBzdGF0ZSBzZXBhcmF0
ZWx5LCBhdAo+ID4gPiA+IHZkcGEtPmNvbmZpZy0+c2V0X3ZxX3JlYWR5KHRydWUpLCBidXQgbm90
IHRyYW5zbWl0IHRoYXQgZW5hYmxlIHRvIGh3Cj4gPiA+ID4gKiBTdG9yZSB0aGUgZG9vcmJlbGwg
c3RhdGUgc2VwYXJhdGVseSwgYnV0IGRvIG5vdCBjb25maWd1cmUgaXQgdG8gdGhlCj4gPiA+ID4g
ZGV2aWNlIGRpcmVjdGx5Lgo+ID4gPiA+Cj4gPiA+ID4gQnV0IGhvdyB0byByZWNvdmVyIGlmIHRo
ZSBkZXZpY2UgY2Fubm90IGNvbmZpZ3VyZSB0aGVtIGF0IGtpY2sgdGltZSwKPiA+ID4gPiBmb3Ig
ZXhhbXBsZT8KPiA+ID4gPgo+ID4gPiA+IE1heWJlIHdlIGNhbiBqdXN0IGZhaWwgaWYgdGhlIHBh
cmVudCBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBlbmFibGluZwo+ID4gPiA+IHRoZSB2cSBhZnRl
ciBEUklWRVJfT0s/IFRoYXQgd2F5IG5vIG5ldyBmZWF0dXJlIGZsYWcgaXMgbmVlZGVkLgo+ID4g
PiA+Cj4gPiA+ID4gVGhhbmtzIQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiAtLS0KPiA+
ID4gPiA+ID4gU2VudCB3aXRoIEZpeGVzOiB0YWcgcG9pbnRpbmcgdG8gZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21zdAo+ID4gPiA+ID4gPiBjb21taXQuIFBsZWFzZSBs
ZXQgbWUga25vdyBpZiBJIHNob3VsZCBzZW5kIGEgdjMgb2YgWzFdIGluc3RlYWQuCj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwNjA5
MTIxMjQ0LW11dHQtc2VuZC1lbWFpbC1tc3RAa2VybmVsLm9yZy9ULwo+ID4gPiA+ID4gPiAtLS0K
PiA+ID4gPiA+ID4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNyArKysrKy0tCj4gPiA+ID4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2
ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4gPiBpbmRleCBlMWFiZjI5ZmVkNWIuLmE3ZTU1NDM1
MjM1MSAxMDA2NDQKPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4g
PiA+ID4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gPiA+ID4gQEAgLTY4MSwxOCAr
NjgxLDIxIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZp
bGUgKmZpbGVwLAo+ID4gPiA+ID4gPiAgewo+ID4gPiA+ID4gPiAgICAgICBzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdiA9IGZpbGVwLT5wcml2YXRlX2RhdGE7Cj4gPiA+ID4gPiA+ICAgICAgIHN0cnVjdCB2
aG9zdF9kZXYgKmQgPSAmdi0+dmRldjsKPiA+ID4gPiA+ID4gKyAgICAgY29uc3Qgc3RydWN0IHZk
cGFfY29uZmlnX29wcyAqb3BzID0gdi0+dmRwYS0+Y29uZmlnOwo+ID4gPiA+ID4gPiAgICAgICB2
b2lkIF9fdXNlciAqYXJncCA9ICh2b2lkIF9fdXNlciAqKWFyZzsKPiA+ID4gPiA+ID4gICAgICAg
dTY0IF9fdXNlciAqZmVhdHVyZXAgPSBhcmdwOwo+ID4gPiA+ID4gPiAtICAgICB1NjQgZmVhdHVy
ZXM7Cj4gPiA+ID4gPiA+ICsgICAgIHU2NCBmZWF0dXJlcywgcGFyZW50X2ZlYXR1cmVzID0gMDsK
PiA+ID4gPiA+ID4gICAgICAgbG9uZyByID0gMDsKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAg
ICAgaWYgKGNtZCA9PSBWSE9TVF9TRVRfQkFDS0VORF9GRUFUVVJFUykgewo+ID4gPiA+ID4gPiAg
ICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmZmVhdHVyZXMsIGZlYXR1cmVwLCBzaXpl
b2YoZmVhdHVyZXMpKSkKPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
RUZBVUxUOwo+ID4gPiA+ID4gPiArICAgICAgICAgICAgIGlmIChvcHMtPmdldF9iYWNrZW5kX2Zl
YXR1cmVzKQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcGFyZW50X2ZlYXR1cmVz
ID0gb3BzLT5nZXRfYmFja2VuZF9mZWF0dXJlcyh2LT52ZHBhKTsKPiA+ID4gPiA+ID4gICAgICAg
ICAgICAgICBpZiAoZmVhdHVyZXMgJiB+KFZIT1NUX1ZEUEFfQkFDS0VORF9GRUFUVVJFUyB8Cj4g
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JB
Q0tFTkRfRl9TVVNQRU5EKSB8Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUpIHwKPiA+ID4gPiA+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9B
RlRFUl9EUklWRVJfT0spKSkKPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBhcmVudF9mZWF0dXJlcykpCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVPUE5PVFNVUFA7Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgaWYgKChmZWF0dXJl
cyAmIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpKSAmJgo+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfY2FuX3N1c3BlbmQodikpCj4gPiA+ID4gPiA+IC0t
Cj4gPiA+ID4gPiA+IDIuMzkuMwo+ID4gPiA+ID4KPiA+ID4KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
