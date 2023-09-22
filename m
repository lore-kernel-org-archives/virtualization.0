Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7B9E7D0C2
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 03:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB7C383D27;
	Fri, 22 Sep 2023 03:03:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB7C383D27
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVUmCgwm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t6AoMHcc6bwR; Fri, 22 Sep 2023 03:03:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 472B983D18;
	Fri, 22 Sep 2023 03:03:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 472B983D18
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E39AC0071;
	Fri, 22 Sep 2023 03:03:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D7CBC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20D0C421CA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:03:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20D0C421CA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVUmCgwm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OgJ5DXKXxU5V
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:03:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D0B4421C5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:02:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D0B4421C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695351778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C4/7HVPf6uamIbhGmRjVc4ZotzNyCXQbQd4oze32eow=;
 b=cVUmCgwmvA5uVl+XxXQjogKNWUzXUftJSMqhFg87fdp4t5BznNIQXFT0Rv++7xk08VtpLD
 B8zyUvrT0vUC0QwU+N4Qn6AeAUSB2NJdiwaz339w6TtXhLS03VmAhMlQHEk2GrX3tRgIRs
 Y5bS8/tw6iusGJierELAN3D5iK9dAtc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-xUpV80e-NDezQ3dAOeZ-fQ-1; Thu, 21 Sep 2023 23:02:57 -0400
X-MC-Unique: xUpV80e-NDezQ3dAOeZ-fQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-504319087d9so1357916e87.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695351776; x=1695956576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4/7HVPf6uamIbhGmRjVc4ZotzNyCXQbQd4oze32eow=;
 b=eGiHzO0SOCQHx+hO6qoHUgwJaX06gELae888wFyMceo9p6EZbWrKMf8JSfhv3forF+
 tL2wpNPjSoJe4ojx4gGR9Bh3nF0BZiA/fR1vYb2Y7xyPfAJ3UiqZktEsV0m/api3LyfN
 Zm9PNlDJ3WR0G/rX4MWeNF/aRE+oeyaDTLGmCEjnUrT2+UrCjV5C6sp9Ckt+pJOG4v2I
 /yk0xrqUWRjj7Cett6nIAU5T990hPOH90rpGVyiluhrATySI/lV3VD8G9Ry4w0DbCn4U
 GpZT2P0K1rT8Eo1AeNDWu01y0SvwD9Xzp27IUbR3N5pGeSfAxPlBkV/wgJHcET/qf8ZL
 29YQ==
X-Gm-Message-State: AOJu0YxkSuRZe12pTeeSPmGYAvpaCLIhpc+06ITd+eHrbhhR9xGP5rgY
 oo5ew5coIcxDXsQJLxxLB5JaxBKX/dAoyYv9djQkK6EgNGedo3batpJ4KNvNS9om+HZLGDX/J6n
 yH/21BJTwr1DAKDSNg3kKV3P78tYmPK4x+QnzqpvDV11e3yAtd3Nl5w56CQ==
X-Received: by 2002:a05:6512:3e17:b0:501:bf37:1fc0 with SMTP id
 i23-20020a0565123e1700b00501bf371fc0mr7518462lfv.33.1695351775885; 
 Thu, 21 Sep 2023 20:02:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK0VNN1CQqjxfBqcyZruxzFlh3gm1m468Kkmtaqhcvh89ukdHWFMbXLOQnTSo1SwuQSl9L8ShMnn3mbZgUoL8=
X-Received: by 2002:a05:6512:3e17:b0:501:bf37:1fc0 with SMTP id
 i23-20020a0565123e1700b00501bf371fc0mr7518442lfv.33.1695351775543; Thu, 21
 Sep 2023 20:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921150448-mutt-send-email-mst@kernel.org>
 <20230921194946.GX13733@nvidia.com>
 <20230921163421-mutt-send-email-mst@kernel.org>
 <20230921225526.GE13733@nvidia.com>
In-Reply-To: <20230921225526.GE13733@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 11:02:44 +0800
Message-ID: <CACGkMEtNZ1FdUb_xG5862nve565Oh-=o8ZUjfR_Gr7JPCbJ_Kw@mail.gmail.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
To: Jason Gunthorpe <jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 maorg@nvidia.com, virtualization@lists.linux-foundation.org, jiri@nvidia.com,
 leonro@nvidia.com
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgNjo1NeKAr0FNIEphc29uIEd1bnRob3JwZSA8amdnQG52
aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMDQ6NDU6NDVQTSAt
MDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gT24gVGh1LCBTZXAgMjEsIDIwMjMg
YXQgMDQ6NDk6NDZQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+ID4gPiBPbiBUaHUs
IFNlcCAyMSwgMjAyMyBhdCAwMzoxMzoxMFBNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4gPiA+ID4gT24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMDM6Mzk6MjZQTSAtMDMwMCwgSmFz
b24gR3VudGhvcnBlIHdyb3RlOgo+ID4gPiA+ID4gT24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMTI6
NTM6MDRQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+IHZk
cGEgaXMgbm90IHZmaW8sIEkgZG9uJ3Qga25vdyBob3cgeW91IGNhbiBzdWdnZXN0IHZkcGEgaXMg
YQo+ID4gPiA+ID4gPiA+IHJlcGxhY2VtZW50IGZvciBhIHZmaW8gZHJpdmVyLiBUaGV5IGFyZSBj
b21wbGV0ZWx5IGRpZmZlcmVudAo+ID4gPiA+ID4gPiA+IHRoaW5ncy4KPiA+ID4gPiA+ID4gPiBF
YWNoIHNpZGUgaGFzIGl0cyBvd24gc3RyZW5ndGhzLCBhbmQgdmZpbyBlc3BlY2lhbGx5IGlzIGFj
Y2VsZXJhdGluZwo+ID4gPiA+ID4gPiA+IGluIGl0cyBjYXBhYmlsaXR5IGluIHdheSB0aGF0IHZw
ZGEgaXMgbm90LiBlZyBpZiBhbiBpb21tdWZkIGNvbnZlcnNpb24KPiA+ID4gPiA+ID4gPiBoYWQg
YmVlbiBkb25lIGJ5IG5vdyBmb3IgdmRwYSBJIG1pZ2h0IGJlIG1vcmUgc3ltcGF0aGV0aWMuCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFllYSwgSSBhZ3JlZSBpb21tdWZkIGlzIGEgYmlnIHByb2Js
ZW0gd2l0aCB2ZHBhIHJpZ2h0IG5vdy4gQ2luZHkgd2FzCj4gPiA+ID4gPiA+IHNpY2sgYW5kIEkg
ZGlkbid0IGtub3cgYW5kIGtlcHQgYXNzdW1pbmcgc2hlJ3Mgd29ya2luZyBvbiB0aGlzLiBJIGRv
bid0Cj4gPiA+ID4gPiA+IHRoaW5rIGl0J3MgYSBodWdlIGFtb3VudCBvZiB3b3JrIHRob3VnaC4g
IEknbGwgdGFrZSBhIGxvb2suCj4gPiA+ID4gPiA+IElzIHRoZXJlIGFueXRoaW5nIGVsc2UgdGhv
dWdoPyBEbyB0ZWxsLgo+ID4gPiA+ID4KPiA+ID4gPiA+IENvbmZpZGVudGlhbCBjb21wdXRlIHdp
bGwgbmV2ZXIgd29yayB3aXRoIFZEUEEncyBhcHByb2FjaC4KPiA+ID4gPgo+ID4gPiA+IEkgZG9u
J3Qgc2VlIGhvdyB3aGF0IHRoaXMgcGF0Y2hzZXQgaXMgZG9pbmcgaXMgZGlmZmVyZW50Cj4gPiA+
ID4gd3J0IHRvIENvbmZpZGVudGlhbCBjb21wdXRlIC0geW91IHRyYXAgSU8gYWNjZXNzZXMgYW5k
IGVtdWxhdGUuCj4gPiA+ID4gQ2FyZSB0byBlbGFib3JhdGU/Cj4gPiA+Cj4gPiA+IFRoaXMgcGF0
Y2ggc2VyaWVzIGlzbid0IGFib3V0IGNvbmZpZGVudGlhbCBjb21wdXRlLCB5b3UgYXNrZWQgYWJv
dXQKPiA+ID4gdGhlIGZ1dHVyZS4gVkZJTyB3aWxsIHN1cHBvcnQgY29uZmlkZW50aWFsIGNvbXB1
dGUgaW4gdGhlIGZ1dHVyZSwgVkRQQQo+ID4gPiB3aWxsIG5vdC4KCldoYXQgYmxvY2tzIHZEUEEg
ZnJvbSBzdXBwb3J0aW5nIHRoYXQ/Cgo+ID4KPiA+IE5vbnNlbnNlIGl0IGFscmVhZHkgd29ya3Mu
Cj4KPiBUaGF0IGlzbid0IHdoYXQgSSdtIHRhbGtpbmcgYWJvdXQuIFdpdGggYSByZWFsIFBDSSBm
dW5jdGlvbiBhbmQgVERJU1AKPiB3ZSBjYW4gYWN0dWFsbHkgRE1BIGRpcmVjdGx5IGZyb20gdGhl
IGd1ZXN0J3MgbWVtb3J5IHdpdGhvdXQgbmVlZGluZwo+IHRoZSB1Z2x5IGJvdW5jZSBidWZmZXIg
aGFjay4gVGhlbiB5b3UgY2FuIGdldCBkZWNlbnQgcGVyZm9ybWFuY2UuCgpUaGlzIHNlcmllcyBy
ZXF1aXJlcyB0aGUgdHJhcHBpbmcgaW4gdGhlIGxlZ2FjeSBJL08gQkFSIGluIFZGSU8uIFdoeQpj
YW4gVERJU1Agd29yayB3aGVuIHRyYXBwaW5nIGluIFZGSU8gYnV0IG5vdCB2RFBBPyBJZiBuZWl0
aGVyLCBob3cgY2FuClRESVNQIGFmZmVjdCBoZXJlPwoKPgo+ID4gQnV0IEkgZGlkIG5vdCBhc2sg
YWJvdXQgdGhlIGZ1dHVyZSBzaW5jZSBJIGRvIG5vdCBiZWxpZXZlIGl0Cj4gPiBjYW4gYmUgY29u
ZmlkZW50bHkgcHJlZGljdGVkLiBJIGFza2VkIHdoYXQgaXMgbWlzc2luZyBpbiBWRFBBCj4gPiBu
b3cgZm9yIHlvdSB0byBhZGQgdGhpcyBmZWF0dXJlIHRoZXJlIGFuZCBub3QgaW4gVkZJTy4KPgo+
IEkgZG9uJ3Qgc2VlIHRoYXQgVkRQQSBuZWVkcyB0aGlzLCBWRFBBIHNob3VsZCBwcm9jZXNzIHRo
ZSBJTyBCQVIgb24KPiBpdHMgb3duIHdpdGggaXRzIG93biBsb2dpYywganVzdCBsaWtlIGV2ZXJ5
dGhpbmcgZWxzZSBpdCBkb2VzLgo+Cj4gVGhpcyBpcyBzcGVjaWZpY2FsbHkgYWJvdXQgYXZvaWRp
bmcgbWVkaWF0aW9uIGJ5IHJlbGF5aW5nIGRpcmVjdGx5IHRoZQo+IElPIEJBUiBvcGVyYXRpb25z
IHRvIHRoZSBkZXZpY2UgaXRzZWxmLgoKU28gd2UgaGFkOgoKMSkgYSBuZXcgdmlydGlvIHNwZWNp
ZmljIGRyaXZlciBmb3IgVkZJTwoyKSB0aGUgZXhpc3RpbmcgdnBfdmRwYSBkcml2ZXIKCkhvdyBt
dWNoIGRpZmZlcmVuY2VzIGJldHdlZW4gdGhlbSBpbiB0aGUgY29udGV4dCBvZiB0aGUgbWVkaWF0
aW9uIG9yCnJlbGF5aW5nPyBPciBpcyBpdCBoYXJkIHRvIGludHJvZHVjZSBhZG1pbiBjb21tYW5k
cyBpbiB0aGUgdkRQQSBidXM/Cgo+IFRoYXQgaXMgdGhlIGVudGlyZSBpcm9ueSwgdGhpcyB3aG9s
ZSBzY2hlbWUgd2FzIGRlc2lnbmVkIGFuZAo+IHN0YW5kYXJkaXplZCAqc3BlY2lmaWNhbGx5KiB0
byBhdm9pZCBjb21wbGV4IG1lZGlhdGlvbiBhbmQgaGVyZSB5b3UKPiBhcmUgc2F5aW5nIHdlIHNo
b3VsZCBqdXN0IHVzZSBtZWRpYXRpb24uCgpObywgdXNpbmcgInNpbXBsZSBWRklPIHBhc3N0aHJv
dWdoIiBpcyBqdXN0IGZpbmUuCgpUaGFua3MKCj4KPiBKYXNvbgo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
