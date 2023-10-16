Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FC0CDB474
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 05:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D81F3813AF;
	Mon, 16 Oct 2023 05:30:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D81F3813AF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eyeJWDiN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2CliOOqoReQw; Mon, 16 Oct 2023 05:30:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 39CDD81387;
	Mon, 16 Oct 2023 05:30:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39CDD81387
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EAC3C0039;
	Mon, 16 Oct 2023 05:30:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3206CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 05:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F395B40944
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 05:30:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F395B40944
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eyeJWDiN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uGSXzN1s3zLr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 05:30:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1ACB4092D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 05:30:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1ACB4092D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697434223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1C2WXsdOvEFkNHl/IhfFcAYtP0vCH8zsN+6evhNM07I=;
 b=eyeJWDiNpHyVgE2hR6UdUpAYrvqeeTIcV4zj80qUrjHRh6pxepKqWybVibFwUlwgckjzWO
 uVzp74/eLBtDcv9Bs90Jin8N2LwBVE9+PYFNM32tu54XV0uzcIjpW/xWbWIhfYgIHTMlHU
 QhURXRFs3/4sW7ZO5uFnQefoLImgn5U=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-q9wrc3O-NY2HBnBWGm3e5w-1; Mon, 16 Oct 2023 01:30:20 -0400
X-MC-Unique: q9wrc3O-NY2HBnBWGm3e5w-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c503af866dso28547161fa.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Oct 2023 22:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697434218; x=1698039018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1C2WXsdOvEFkNHl/IhfFcAYtP0vCH8zsN+6evhNM07I=;
 b=LqrdzY8cjv7Bm9fI4urMsJt3u2KizGOQxyy1sdJ7onorLB7wzry0/9WY4wU4TXSlZW
 PlKE1aOJAW762zjBG78yulSXr/cnv+Z8NM6nFUeWKnpkz+VCMjCRQ8vMBSK8Ci0GVwZH
 IrjkQZsNQbEATDRr2iTBkOo4YbVxPXPXeYZsajinbxthuAlWP3IOPwodi3ux9Ox1GFST
 zx+SY+kMH3XymVFllUkVz5yvrj4ZXTStHC0lx1XwxxGevXYlnQcWQb/KuxIXhrQzxwwp
 E2quKMzgA3/WrKn8EjOD9YF3macbBBPN8vcHn0McXN1djst+B8/5ay9BVKEQ8GkDuaw1
 ni6g==
X-Gm-Message-State: AOJu0Yy+mk12TS+DQvGB6rlLqAeiK96OoH6aBx4dXYXZmNLr0AeOTlc0
 BV/SMNeSKiiVsP5MHH/C6ka0ZlEY7H7wdi6YOUmEkNRpmpfF0Be8gYbUrGHLmxXAnjOuhid88JY
 ydlGXOuVjtU2ua4BvUFot7Aoz3SEivR2s6MkDpmpN33cC3zrkTpI4FE9OhA==
X-Received: by 2002:a2e:850f:0:b0:2c5:2103:604b with SMTP id
 j15-20020a2e850f000000b002c52103604bmr1773607lji.2.1697434218623; 
 Sun, 15 Oct 2023 22:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRBikMoE5QFf7VlNg+iTYDUs31qOow+BkmsjVhIQbfuhtzvOIE+ECRPPPCCN0d/sXlFyh85ZZGVE/CxzHrr/E=
X-Received: by 2002:a2e:850f:0:b0:2c5:2103:604b with SMTP id
 j15-20020a2e850f000000b002c52103604bmr1773588lji.2.1697434218254; Sun, 15 Oct
 2023 22:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEt2vohDVG=BOpvn=7QgPiADgB93KoZ6xWwrO4T=Wgj6Pw@mail.gmail.com>
 <3dbc36b7-28c2-4b62-97dc-a8280f10dc36@oracle.com>
In-Reply-To: <3dbc36b7-28c2-4b62-97dc-a8280f10dc36@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Oct 2023 13:30:07 +0800
Message-ID: <CACGkMEvC3BsApy1XR0mVAOmy4sdon=Mk02=pkgm4BPs_98NP3g@mail.gmail.com>
Subject: Re: [PATCH 1/4] vdpa: introduce .reset_map operation callback
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

T24gRnJpLCBPY3QgMTMsIDIwMjMgYXQgMzozNuKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gMTAvMTIvMjAyMyA3OjQ5IFBNLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gT24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgNTowNeKAr1BNIFNpLVdlaSBM
aXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4gPj4gRGV2aWNlIHNwZWNpZmljIElP
TU1VIHBhcmVudCBkcml2ZXIgd2hvIHdpc2hlcyB0byBzZWUgbWFwcGluZyB0byBiZQo+ID4+IGRl
Y291cGxlZCBmcm9tIHZpcnRpbyBvciB2ZHBhIGRldmljZSBsaWZlIGN5Y2xlIChkZXZpY2UgcmVz
ZXQpIGNhbiB1c2UKPiA+PiBpdCB0byByZXN0b3JlIG1lbW9yeSBtYXBwaW5nIGluIHRoZSBkZXZp
Y2UgSU9NTVUgdG8gdGhlIGluaXRpYWwgb3IKPiA+PiBkZWZhdWx0IHN0YXRlLiBUaGUgcmVzZXQg
b2YgbWFwcGluZyBpcyBkb25lIHBlciBhZGRyZXNzIHNwYWNlIGJhc2lzLgo+ID4+Cj4gPj4gVGhl
IHJlYXNvbiB3aHkgYSBzZXBhcmF0ZSAucmVzZXRfbWFwIG9wIGlzIGludHJvZHVjZWQgaXMgYmVj
YXVzZSB0aGlzCj4gPj4gYWxsb3dzIGEgc2ltcGxlIG9uLWNoaXAgSU9NTVUgbW9kZWwgd2l0aG91
dCBleHBvc2luZyB0b28gbXVjaCBkZXZpY2UKPiA+PiBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzIHRv
IHRoZSB1cHBlciB2ZHBhIGxheWVyLiBUaGUgLmRtYV9tYXAvdW5tYXAgb3IKPiA+PiAuc2V0X21h
cCBkcml2ZXIgQVBJIGlzIG1lYW50IHRvIGJlIHVzZWQgdG8gbWFuaXB1bGF0ZSB0aGUgSU9UTEIg
bWFwcGluZ3MsCj4gPj4gYW5kIGhhcyBiZWVuIGFic3RyYWN0ZWQgaW4gYSB3YXkgc2ltaWxhciB0
byBob3cgYSByZWFsIElPTU1VIGRldmljZSBtYXBzCj4gPj4gb3IgdW5tYXBzIHBhZ2VzIGZvciBj
ZXJ0YWluIG1lbW9yeSByYW5nZXMuIEhvd2V2ZXIsIGFwYXJ0IGZyb20gdGhpcyB0aGVyZQo+ID4+
IGFsc28gZXhpc3RzIG90aGVyIG1hcHBpbmcgbmVlZHMsIGluIHdoaWNoIGNhc2UgMToxIHBhc3N0
aHJvdWdoIG1hcHBpbmcKPiA+PiBoYXMgdG8gYmUgdXNlZCBieSBvdGhlciB1c2VycyAocmVhZCB2
aXJ0aW8tdmRwYSkuIFRvIGVhc2UgcGFyZW50L3ZlbmRvcgo+ID4+IGRyaXZlciBpbXBsZW1lbnRh
dGlvbiBhbmQgdG8gYXZvaWQgYWJ1c2luZyBETUEgb3BzIGluIGFuIHVuZXhwYWN0ZWQgd2F5LAo+
ID4+IHRoZXNlIG9uLWNoaXAgSU9NTVUgZGV2aWNlcyBjYW4gc3RhcnQgd2l0aCAxOjEgcGFzc3Ro
cm91Z2ggbWFwcGluZyBtb2RlCj4gPj4gaW5pdGlhbGx5IGF0IHRoZSBoZSB0aW1lIG9mIGNyZWF0
aW9uLiBUaGVuIHRoZSAucmVzZXRfbWFwIG9wIGNhbiBiZSB1c2VkCj4gPj4gdG8gc3dpdGNoIGlv
dGxiIGJhY2sgdG8gdGhpcyBpbml0aWFsIHN0YXRlIHdpdGhvdXQgaGF2aW5nIHRvIGV4cG9zZSBh
Cj4gPj4gY29tcGxleCB0d28tZGltZW5zaW9uYWwgSU9NTVUgZGV2aWNlIG1vZGVsLgo+ID4+Cj4g
Pj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+ID4+
IC0tLQo+ID4+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggfCAxMCArKysrKysrKysrCj4gPj4gICAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiA+PiBpbmRleCBkMzc2
MzA5Li4yNmFlNmFlIDEwMDY0NAo+ID4+IC0tLSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gPj4g
KysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiA+PiBAQCAtMzI3LDYgKzMyNywxNSBAQCBzdHJ1
Y3QgdmRwYV9tYXBfZmlsZSB7Cj4gPj4gICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QGlvdmE6IGlvdmEgdG8gYmUgdW5tYXBwZWQKPiA+PiAgICAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBAc2l6ZTogc2l6ZSBvZiB0aGUgYXJlYQo+ID4+ICAgICogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFJldHVybnMgaW50ZWdlcjogc3VjY2VzcyAoMCkgb3IgZXJyb3IgKDwgMCkK
PiA+PiArICogQHJlc2V0X21hcDogICAgICAgICAgICAgICAgIFJlc2V0IGRldmljZSBtZW1vcnkg
bWFwcGluZyB0byB0aGUgZGVmYXVsdAo+ID4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RhdGUgKG9wdGlvbmFsKQo+ID4gSSB0aGluayB3ZSBuZWVkIHRvIG1lbnRpb24gdGhhdCB0
aGlzIGlzIGEgbXVzdCBmb3IgcGFyZW50cyB0aGF0IHVzZSBzZXRfbWFwKCk/Cj4gSXQncyBub3Qg
YSBtdXN0IElNTywgc29tZSAuc2V0X21hcCgpIHVzZXIgZm9yIGUuZy4gVkRVU0Ugb3IgdmRwYS1z
aW0tYmxrCj4gY2FuIGRlbGliZXJhdGVseSBjaG9vc2UgdG8gaW1wbGVtZW50IC5yZXNldF9tYXAo
KSBkZXBlbmRpbmcgb24gaXRzIG93bgo+IG5lZWQuIFRob3NlIHVzZXJfdmEgc29mdHdhcmUgZGV2
aWNlcyBtb3N0bHkgZG9uJ3QgY2FyZSBhYm91dCBtYXBwaW5nCj4gY29zdCBkdXJpbmcgcmVzZXQs
IGFzIHRoZXkgZG9uJ3QgaGF2ZSB0byBwaW4ga2VybmVsIG1lbW9yeSBpbiBnZW5lcmFsLgo+IEl0
J3MganVzdCB3aGV0aGVyIG9yIG5vdCB0aGV5IGNhcmUgYWJvdXQgbWFwcGluZyBiZWluZyBkZWNv
dXBsZWQgZnJvbQo+IGRldmljZSByZXNldCBhdCBhbGwuCgpPaywgbGV0J3MgZG9jdW1lbnQgdGhp
cyBpbiB0aGUgY2hhbmdlbG9nIGF0IGxlYXN0LgoKVGhhbmtzCgo+Cj4gQW5kIHRoZSBleGFjdCBp
bXBsZW1lbnRhdGlvbiByZXF1aXJlbWVudCBvZiB0aGlzIGludGVyZmFjZSBoYXMgYmVlbgo+IGRv
Y3VtZW50ZWQgcmlnaHQgYmVsb3cuCj4KPiAtU2l3ZWkKPiA+Cj4gPiBPdGhlciB0aGFuIHRoaXM6
Cj4gPgo+ID4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPgo+
ID4gVGhhbmtzCj4gPgo+ID4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTmVlZGVk
IGZvciBkZXZpY2VzIHRoYXQgYXJlIHVzaW5nIGRldmljZQo+ID4+ICsgKiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3BlY2lmaWMgRE1BIHRyYW5zbGF0aW9uIGFuZCBwcmVmZXIgbWFwcGlu
Zwo+ID4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdG8gYmUgZGVjb3VwbGVkIGZy
b20gdGhlIHZpcnRpbyBsaWZlIGN5Y2xlLAo+ID4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaS5lLiBkZXZpY2UgLnJlc2V0IG9wIGRvZXMgbm90IHJlc2V0IG1hcHBpbmcKPiA+PiAr
ICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+ID4+ICsg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQGFzaWQ6IGFkZHJlc3Mgc3BhY2UgaWRlbnRp
Zmllcgo+ID4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUmV0dXJucyBpbnRlZ2Vy
OiBzdWNjZXNzICgwKSBvciBlcnJvciAoPCAwKQo+ID4+ICAgICogQGdldF92cV9kbWFfZGV2OiAg
ICAgICAgICAgIEdldCB0aGUgZG1hIGRldmljZSBmb3IgYSBzcGVjaWZpYwo+ID4+ICAgICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRxdWV1ZSAob3B0aW9uYWwpCj4gPj4gICAgKiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4gPj4gQEAgLTQw
NSw2ICs0MTQsNyBAQCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHsKPiA+PiAgICAgICAgICAgICAg
ICAgICAgICAgICB1NjQgaW92YSwgdTY0IHNpemUsIHU2NCBwYSwgdTMyIHBlcm0sIHZvaWQgKm9w
YXF1ZSk7Cj4gPj4gICAgICAgICAgaW50ICgqZG1hX3VubWFwKShzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYsIHVuc2lnbmVkIGludCBhc2lkLAo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
dTY0IGlvdmEsIHU2NCBzaXplKTsKPiA+PiArICAgICAgIGludCAoKnJlc2V0X21hcCkoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCk7Cj4gPj4gICAgICAgICAgaW50
ICgqc2V0X2dyb3VwX2FzaWQpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50
IGdyb3VwLAo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQg
YXNpZCk7Cj4gPj4gICAgICAgICAgc3RydWN0IGRldmljZSAqKCpnZXRfdnFfZG1hX2Rldikoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KTsKPiA+PiAtLQo+ID4+IDEuOC4zLjEKPiA+
Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
