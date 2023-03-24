Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A248C6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 06:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72D4A41E14;
	Fri, 24 Mar 2023 06:00:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72D4A41E14
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dxY33bOm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ta0C_dJJBAr2; Fri, 24 Mar 2023 06:00:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 16DFF41DE9;
	Fri, 24 Mar 2023 05:59:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16DFF41DE9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAB23C0071;
	Fri, 24 Mar 2023 05:59:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33D00C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 05:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3F9241DF4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 05:59:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3F9241DF4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qgGj_B0i25lR
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 05:59:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC3F741DE9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC3F741DE9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 05:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679637593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vt1J17FUEsFz1bQOp6BzRT5G+PK9gWtwL+MNcCXC+I8=;
 b=dxY33bOmrHraYtQKXsHOjTkcj8VqS0r/lbIW8/t8zUGR89xxpRjdpNKP5+8hmiA3GdvIgQ
 kz+NV8HOH9sVlKd+oWovgXbKFwHBPhWLuxjbJQdG05W5ZlhocqTlhpGeUCPSVPb7Mb1OMj
 QMUmTKSiclghZPetmY9TjuR5mFIJWYs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ceRa5ywqNliYXocLUw1aFQ-1; Fri, 24 Mar 2023 01:59:52 -0400
X-MC-Unique: ceRa5ywqNliYXocLUw1aFQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 c11-20020a509f8b000000b00501e2facf47so1561658edf.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 22:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679637591;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vt1J17FUEsFz1bQOp6BzRT5G+PK9gWtwL+MNcCXC+I8=;
 b=nqHwHSmmZ7DqkACAMdPSHbBmZ+lmt2ffqohbv4xELQjJnxAOJ7fM7n3cBNxZtghTjb
 VG+dZOhvrPbwk3d9vxPmAwnyNjdogfjiiJ5kJKWL5HjLJF+S+sXMvv1BufsBthTWcu/s
 hvAGplqCqh4eW9/7aWk3WeZw00Ak40nR6LHjRxSW4DmEJqg+twcqAofybdyuSgrm2dtT
 M4OE5V2GumFKyKEXDK4N7lbeOmGi3R7o6Zk/sO3UMsZIcaWpVfCuYqOTdzs2SDSmDWlW
 9+VDq5zAAfWc9a8l3wlPL/K+mMhQn3Wj6qlNmq61r5MEV6XX0ueeECSn8uV9sQy2kJAJ
 dTmQ==
X-Gm-Message-State: AAQBX9cyZwe0mNK1RZhL8aNjuqBXYcPEoGNwkQJVkM8XyYb+ojV7hNo+
 Aea9Q5OJznYkciJviZuFXpUDbIu3wCAwEzLXBqtsJrHxd+nuS0o9ajqW+gaYLvvRJaB8rjCgOho
 qUcXnz7kdlLLbovi5E8c1+lZ6CtU6KAf95WDHA+P9eA==
X-Received: by 2002:aa7:c547:0:b0:4f9:ed17:3bec with SMTP id
 s7-20020aa7c547000000b004f9ed173becmr1975074edr.20.1679637591414; 
 Thu, 23 Mar 2023 22:59:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y9MxlyAuE5jXcAqgE+Rz2mYEFwxEIstOcZTAZDAO6WUG2qcJgTq7hr9YRQ/bj1u1Np+JzcFw==
X-Received: by 2002:aa7:c547:0:b0:4f9:ed17:3bec with SMTP id
 s7-20020aa7c547000000b004f9ed173becmr1975053edr.20.1679637591106; 
 Thu, 23 Mar 2023 22:59:51 -0700 (PDT)
Received: from redhat.com ([2.52.12.190]) by smtp.gmail.com with ESMTPSA id
 r12-20020a50c00c000000b00501d2f10d19sm5720060edb.20.2023.03.23.22.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 22:59:50 -0700 (PDT)
Date: Fri, 24 Mar 2023 01:59:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [External] Re: [PATCH] virtio_ring: Suppress tx interrupt when
 napi_tx disable
Message-ID: <20230324013805-mutt-send-email-mst@kernel.org>
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
 <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
 <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMTE6NDE6MTJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIE1hciAyMywgMjAyMyBhdCA0OjAx4oCvUE0g6buE5p2wIDxodWFuZ2ppZS5h
bGJlcnRAYnl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4gPgo+ID4gSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4g5LqOMjAyM+W5tDPmnIgyMuaXpeWRqOS4iSAxMDozN+WGmemBk++8mgo+ID4g
Pgo+ID4gPiBPbiBUdWUsIE1hciAyMSwgMjAyMyBhdCA1OjAw4oCvUE0gQWxiZXJ0IEh1YW5nCj4g
PiA+IDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4g
PiBGcm9tOiAiaHVhbmdqaWUuYWxiZXJ0IiA8aHVhbmdqaWUuYWxiZXJ0QGJ5dGVkYW5jZS5jb20+
Cj4gPiA+ID4KPiA+ID4gPiBmaXggY29tbWl0IDhkNjIyZDIxZDI0OCAoInZpcnRpbzogZml4IHVw
IHZpcnRpb19kaXNhYmxlX2NiIikKPiA+ID4gPgo+ID4gPiA+IGlmIHdlIGRpc2FibGUgdGhlIG5h
cGlfdHguIHdoZW4gd2UgdHJpZ2VyIGEgdHggaW50ZXJydXB0LCB0aGUKPiA+ID4KPiA+ID4gdHlw
byBzaG91bGQgYmUgInRyaWdnZXIiCj4gPiA+Cj4gPgo+ID4gT0ssIHRoYW5rcyBmb3IgdGhpcy4g
SSB3aWxsIGNvcnJlY3QgaXQgaW4gdGhlIG5leHQgdmVyc2lvbgo+ID4KPiA+ID4gPiB2cS0+ZXZl
bnRfdHJpZ2dlcmVkIHdpbGwgYmUgc2V0IHRvIHRydWUuIEl0IHdpbGwgbm8gbG9uZ2VyIGJlCj4g
PiA+ID4gc2V0IHRvIGZhbHNlLiBVbmxlc3Mgd2UgZXhwbGljaXRseSBjYWxsIHZpcnRxdWV1ZV9l
bmFibGVfY2JfZGVsYXllZAo+ID4gPiA+IG9yIHZpcnRxdWV1ZV9lbmFibGVfY2JfcHJlcGFyZQo+
ID4gPiA+Cj4gPiA+ID4gaWYgd2UgZGlzYWJsZSB0aGUgbmFwaV90eCwgSXQgd2lsbCBvbmx5IGJl
IGNhbGxlZCB3aGVuIHRoZSB0eCByaW5nCj4gPiA+ID4gYnVmZmVyIGlzIHJlbGF0aXZlbHkgc21h
bGw6Cj4gPiA+ID4gdmlydGlvX25ldC0+c3RhcnRfeG1pdDoKPiA+ID4gPiAgICAgICAgIGlmIChz
cS0+dnEtPm51bV9mcmVlIDwgMitNQVhfU0tCX0ZSQUdTKSB7Cj4gPiA+ID4gICAgICAgICAgICAg
ICAgIG5ldGlmX3N0b3Bfc3VicXVldWUoZGV2LCBxbnVtKTsKPiA+ID4gPiAgICAgICAgICAgICAg
ICAgaWYgKCF1c2VfbmFwaSAmJgo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgdW5saWtlbHko
IXZpcnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChzcS0+dnEpKSkgewo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIC8qIE1vcmUganVzdCBnb3QgdXNlZCwgZnJlZSB0aGVtIHRoZW4gcmVj
aGVjay4gKi8KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBmcmVlX29sZF94bWl0X3Nr
YnMoc3EsIGZhbHNlKTsKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoc3EtPnZx
LT5udW1fZnJlZSA+PSAyK01BWF9TS0JfRlJBR1MpIHsKPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG5ldGlmX3N0YXJ0X3N1YnF1ZXVlKGRldiwgcW51bSk7Cj4gPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+
dnEpOwo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiA+ID4KPiA+ID4gVGhlIGNv
ZGUgZXhhbXBsZSBoZXJlIGlzIG91dCBvZiBkYXRlLCBtYWtlIHN1cmUgeW91ciB0cmVlIGhhcyB0
aGlzOgo+ID4KPiA+IGFsc28sIEkgd2lsbCBjb3JyZWN0IGl0IGluIHRoZSBuZXh0IHZlcnNpb27v
vIx0aGlzIGlzIGZyb20ga2VybmVsIDUuMTUuCj4gPgo+ID4gPgo+ID4gPiBjb21taXQgZDcxZWJl
ODExNGI0YmY2MjI4MDRiODEwZjVlMjc0MDY5MDYwYTE3NAo+ID4gPiBBdXRob3I6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+IERhdGU6ICAgVHVlIEphbiAxNyAxMTo0Nzow
NyAyMDIzICswODAwCj4gPiA+Cj4gPiA+ICAgICB2aXJ0aW8tbmV0OiBjb3JyZWN0bHkgZW5hYmxl
IGNhbGxiYWNrIGR1cmluZyBzdGFydF94bWl0Cj4gPiA+Cj4gPiA+ID4gICAgICAgICAgICAgICAg
IH0KPiA+ID4gPiAgICAgICAgIH0KPiA+ID4gPiBCZWNhdXNlIGV2ZW50X3RyaWdnZXJlZCBpcyB0
cnVlLlRoZXJlZm9yZSwgVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQgb3IKPiA+ID4gPiBWUklO
R19QQUNLRURfRVZFTlRfRkxBR19ESVNBQkxFIHdpbGwgbm90IGJlIHNldC5TbyB3ZSB1cGRhdGUK
PiA+ID4gPiB2cmluZ191c2VkX2V2ZW50KCZ2cS0+c3BsaXQudnJpbmcpIG9yIHZxLT5wYWNrZWQu
dnJpbmcuZHJpdmVyLT5vZmZfd3JhcAo+ID4gPiA+IGV2ZXJ5IHRpbWUgd2UgY2FsbCB2aXJ0cXVl
dWVfZ2V0X2J1Zl9jdHguVGhpcyB3aWxsIGJyaW5nIG1vcmUgaW50ZXJydXB0aW9ucy4KPiA+ID4K
PiA+ID4gQ2FuIHlvdSBwbGVhc2UgcG9zdCBob3cgdG8gdGVzdCB3aXRoIHRoZSBwZXJmb3JtYW5j
ZSBudW1iZXJzPwo+ID4gPgo+ID4KPiA+IGlwZXJmMyB0Y3Agc3RyZWFtOgo+ID4gdm0xIC0tLS0t
LS0tLS0tLS0tLS0tPiB2bTIKPiA+IHZtMiBqdXN0IHJlY2VpdmUgdGNwIGRhdGEgc3RyZWFtIGZy
b20gdm0xLCBhbmQgc2VuZCB0aGUgYWNrIHRvIHZtMSwKPiA+IHRoZXJlIGFyZSBzbwo+ID4gbWFu
eSB0eCBpbnRlcnJ1cHRpb25zICBpbiB2bTIuCj4gPgo+ID4gYnV0IHdpdGhvdXQgZXZlbnRfdHJp
Z2dlcmVkIHRoZXJlIGFyZSBqdXN0IGEgZmV3IHR4IGludGVycnVwdGlvbnMuCj4gPgo+ID4gPiA+
Cj4gPiA+ID4gaWYgZXZlbnRfdHJpZ2dlcmVkIGlzIHNldCB0byB0cnVlLCBkbyBub3QgdXBkYXRl
IHZyaW5nX3VzZWRfZXZlbnQoJnZxLT5zcGxpdC52cmluZykKPiA+ID4gPiBvciB2cS0+cGFja2Vk
LnZyaW5nLmRyaXZlci0+b2ZmX3dyYXAKPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IGh1
YW5namllLmFsYmVydCA8aHVhbmdqaWUuYWxiZXJ0QGJ5dGVkYW5jZS5jb20+Cj4gPiA+ID4gLS0t
Cj4gPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA2ICsrKystLQo+ID4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPiA+
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gaW5kZXggMzA3ZTEzOWNiMTFkLi5mNDg2
Y2NjYWRiZWIgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiBAQCAt
Nzk1LDcgKzc5NSw4IEBAIHN0YXRpYyB2b2lkICp2aXJ0cXVldWVfZ2V0X2J1Zl9jdHhfc3BsaXQo
c3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ID4gPiA+ICAgICAgICAgLyogSWYgd2UgZXhwZWN0IGFu
IGludGVycnVwdCBmb3IgdGhlIG5leHQgZW50cnksIHRlbGwgaG9zdAo+ID4gPiA+ICAgICAgICAg
ICogYnkgd3JpdGluZyBldmVudCBpbmRleCBhbmQgZmx1c2ggb3V0IHRoZSB3cml0ZSBiZWZvcmUK
PiA+ID4gPiAgICAgICAgICAqIHRoZSByZWFkIGluIHRoZSBuZXh0IGdldF9idWYgY2FsbC4gKi8K
PiA+ID4gPiAtICAgICAgIGlmICghKHZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cgJiBWUklO
R19BVkFJTF9GX05PX0lOVEVSUlVQVCkpCj4gPiA+ID4gKyAgICAgICBpZiAoISh2cS0+c3BsaXQu
YXZhaWxfZmxhZ3Nfc2hhZG93ICYgVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQpCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgJiYgKHZxLT5ldmVudF90cmlnZ2VyZWQgPT0gZmFsc2Up
KQo+ID4gPgo+ID4gPiBJJ20gbm90IHN1cmUgdGhpcyBjYW4gd29yaywgd2hlbiBldmVudF90cmln
Z2VyZWQgaXMgdHJ1ZSBpdCBtZWFucwo+ID4gPiB3ZSd2ZSBnb3QgYW4gaW50ZXJydXB0LCBpbiB0
aGlzIGNhc2UgaWYgd2Ugd2FudCBhbm90aGVyIGludGVycnVwdCBmb3IKPiA+ID4gdGhlIG5leHQg
ZW50cnksIHdlIHNob3VsZCB1cGRhdGUgdXNlZF9ldmVudCBvdGhlcndpc2Ugd2Ugd2lsbCBsb3Nl
Cj4gPiA+IHRoYXQgaW50ZXJydXB0Pwo+ID4gPgo+ID4gPiBUaGFua3MKPiA+Cj4gPiBOb3JtYWxs
eSwgaWYgd2UgcmVjZWl2ZSBhbiBpbnRlcnJ1cHQsIHdlIHNob3VsZCBkaXNhYmxlIHRoZSBpbnRl
cnJ1cHQKPiA+IGluIHRoZSBpbnRlcnJ1cHQgY2FsbGJhY2sgaGFuZGxlci4KPiAKPiBTbyB0aGUg
cHJvYmxlbSBpczoKPiAKPiAxKSBldmVudF90cmlnZ2VyZWQgd2FzIHNldCB0byB0cnVlIGluIHZy
aW5nX2ludGVycnVwdCgpCj4KPiAyKSBhZnRlciB0aGlzIG5vdGhpbmcgd2lsbCBoYXBwZW4gZm9y
IHZpcnRxdWV1ZV9kaXNhYmxlX2NiKCkgc28KPiBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVCBp
cyBub3Qgc2V0IGluIGF2YWlsX2ZsYWdzX3NoYWRvdwo+IDMpIHZpcnRxdWV1ZV9nZXRfYnVmX2N0
eF9zcGxpdCgpIHdpbGwgc3RpbGwgdGhpbmsgdGhlIGNiIGlzIGVuYWJsZWQKPiB0aGVuIGl0IHRy
aWVzIHRvIHB1Ymxpc2ggbmV3IGV2ZW50CgpPaC4gR29vZCBwb2ludCEgSSB0aGluayB3aGVuIEkg
d3JvdGUgdXAKOGQ2MjJkMjFkMjQ4ICgidmlydGlvOiBmaXggdXAgdmlydGlvX2Rpc2FibGVfY2Ii
KQpJIG1pc3NlZCB0aGlzIGNvcm5lciBjYXNlLgoKCgo+IFRoaXMgbWFrZXMgbWUgdGhpbmsgYWJv
dXQgd2hldGhlciBvciBub3Qgd2UgcmVhbGx5IG5lZWQKPiBldmVudF90cmlnZ2VyZWQuIFRoZSBh
c3N1bXB0aW9uIGluIHRoZSB2aXJ0cXVldWVfZGlzYWJsZV9jYigpIHNlZW1zCj4gd3Jvbmc6Cj4g
Cj4gLyogSWYgZGV2aWNlIHRyaWdnZXJlZCBhbiBldmVudCBhbHJlYWR5IGl0IHdvbid0IHRyaWdn
ZXIgb25lIGFnYWluOgo+ICAqIG5vIG5lZWQgdG8gZGlzYWJsZS4KPiAgKi8KPiBpZiAodnEtPmV2
ZW50X3RyaWdnZXJlZCkKPiAgICAgICAgICAgICAgICAgcmV0dXJuOwo+IAo+IFRoaXMgaXMgd3Jv
bmcgaWYgdGhlcmUncyBubyBldmVudCBpbmRleCBzdXBwb3J0LgoKCkkgZG9uJ3QgZ2V0IGl0LiAg
aG93IGRvZXMgdGhpcyBnZXQgdHJpZ2dlcmVkPwoKWW91IGFyZSB0YWxraW5nIGFib3V0IGRldmlj
ZSB3aXRob3V0IGV2ZW50IGluZGV4PwpIZXJlJ3MgY29kZSBmcm9tIHZyaW5nX2ludGVycnVwdCgp
OgoKICAgICAgICAvKiBKdXN0IGEgaGludCBmb3IgcGVyZm9ybWFuY2U6IHNvIGl0J3Mgb2sgdGhh
dCB0aGlzIGNhbiBiZSByYWN5ISAqLwogICAgICAgIGlmICh2cS0+ZXZlbnQpCiAgICAgICAgICAg
ICAgICB2cS0+ZXZlbnRfdHJpZ2dlcmVkID0gdHJ1ZTsKCgoKCj4gQW5kIHRoZQo+IGV2ZW50X3Ry
aWdnZXJlZCBpcyBzb21laG93IGR1cGxpY2F0ZWQgd2l0aCB0aGUKPiBWUklOR19BVkFJTF9GX05P
X0lOVEVSUlVQVCBpbiB0aGUgY2FzZSBvZiBldmVudCBpbmRleC4gVGhlIGNvcnJlY3QgZml4Cj4g
bWlnaHQgYmU6Cj4gCj4gMSkgcmVtb3ZlIGV2ZW50X3RyaWdnZXJlZAo+IDIpIHNldCBWUklOR19B
VkFJTF9GX05PX0lOVEVSUlVQVCBpbiBhdmFpbF9mbGFnc19zaGFkb3cgaW4KPiB2cmluZ19pbnRl
cnJydXB0IGlmIGV2ZW50IGluZGV4IGlzIHN1cHBvcnRlZAo+IAo+ID8KPiAKPiBUaGFua3MKCkkg
YW0gbm90IHN1cmUgYWxsIHRoaXMgaXMgcmlnaHQgYW5kIEknZCByYXRoZXIgd2UgZm9jdXNlZApw
ZXJmb3JtYW5jZS9jb3JyZWN0bmVzcyBhbmQgY2xlYW51cHMgc2VwYXJhdGVseS4KCgoKCj4gCj4g
PiBCdXQgYmVjYXVzZSBvZiB0aGUgaW50cm9kdWN0aW9uIG9mIGV2ZW50X3RyaWdnZXJlZCwgaGVy
ZSwKPiA+IHZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9zcGxpdCAgY2Fubm90IGJlIHJlY29nbml6ZWQK
PiA+IHRoYXQgdGhlIGludGVycnVwdCBoYXMgYmVlbiB0dXJuZWQgb2ZmLgo+ID4KPiA+IGlmIHdl
IHdhbnQgIGFub3RoZXIgaW50ZXJydXB0IGZvciB0aGUgbmV4dCBlbnRyeSwgV2Ugc2hvdWxkIHBy
b2JhYmx5Cj4gPiBjYWxsIHZpcnRxdWV1ZV9lbmFibGVfY2LvvJ8KPiA+Cj4gPiBUaGFua3MKPiA+
Cj4gPiA+Cj4gPiA+ID4gICAgICAgICAgICAgICAgIHZpcnRpb19zdG9yZV9tYih2cS0+d2Vha19i
YXJyaWVycywKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2cmluZ191
c2VkX2V2ZW50KCZ2cS0+c3BsaXQudnJpbmcpLAo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY3B1X3RvX3ZpcnRpbzE2KF92cS0+dmRldiwgdnEtPmxhc3RfdXNlZF9pZHgp
KTsKPiA+ID4gPiBAQCAtMTUyOSw3ICsxNTMwLDggQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9n
ZXRfYnVmX2N0eF9wYWNrZWQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ID4gPiA+ICAgICAgICAg
ICogYnkgd3JpdGluZyBldmVudCBpbmRleCBhbmQgZmx1c2ggb3V0IHRoZSB3cml0ZSBiZWZvcmUK
PiA+ID4gPiAgICAgICAgICAqIHRoZSByZWFkIGluIHRoZSBuZXh0IGdldF9idWYgY2FsbC4KPiA+
ID4gPiAgICAgICAgICAqLwo+ID4gPiA+IC0gICAgICAgaWYgKHZxLT5wYWNrZWQuZXZlbnRfZmxh
Z3Nfc2hhZG93ID09IFZSSU5HX1BBQ0tFRF9FVkVOVF9GTEFHX0RFU0MpCj4gPiA+ID4gKyAgICAg
ICBpZiAodnEtPnBhY2tlZC5ldmVudF9mbGFnc19zaGFkb3cgPT0gVlJJTkdfUEFDS0VEX0VWRU5U
X0ZMQUdfREVTQwo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICYmICh2cS0+ZXZlbnRf
dHJpZ2dlcmVkID09IGZhbHNlKSkKPiA+ID4gPiAgICAgICAgICAgICAgICAgdmlydGlvX3N0b3Jl
X21iKHZxLT53ZWFrX2JhcnJpZXJzLAo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJnZxLT5wYWNrZWQudnJpbmcuZHJpdmVyLT5vZmZfd3JhcCwKPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNwdV90b19sZTE2KHZxLT5sYXN0X3VzZWRfaWR4KSk7
Cj4gPiA+ID4gLS0KPiA+ID4gPiAyLjMxLjEKPiA+ID4gPgo+ID4gPgo+ID4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
