Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4E2EB64D9
	for <virtualization@archiver.kernel.org>; Fri,  7 Jul 2023 07:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A68EA82132;
	Fri,  7 Jul 2023 07:45:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A68EA82132
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YxCiS12V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RuJMAFQ-48bX; Fri,  7 Jul 2023 07:45:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 13D79820D3;
	Fri,  7 Jul 2023 07:45:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13D79820D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2403C0072;
	Fri,  7 Jul 2023 07:45:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87BD8C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6817C61183
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:45:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6817C61183
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YxCiS12V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sRPkV0cKgAKl
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:45:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BA9260A7D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BA9260A7D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688715900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvFopdVMX2fOx14kZcV5OzI3C0A2yd85C4HgqlgQUC4=;
 b=YxCiS12VAr1LXfpA/2wC3KoKg1NfO2AZdHu6hBwv3I3SIwleLK5DTBAX9AbkQpMhg7iazd
 zrC3ZBB1FyM68yYYVJPo13Q1S2rcLZf8GGiWPSPI71ffj5WULJHATtzDGN2dcX0FYBlOi8
 k9jV8y3kZsD6F9nuPvTMJun377Z/6lI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Zc_y3cGnOx6YsNNgKJXuig-1; Fri, 07 Jul 2023 03:44:58 -0400
X-MC-Unique: Zc_y3cGnOx6YsNNgKJXuig-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b70bfcd15aso5455051fa.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Jul 2023 00:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688715897; x=1691307897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvFopdVMX2fOx14kZcV5OzI3C0A2yd85C4HgqlgQUC4=;
 b=SJI5DHortioLdnHkqk1Z5nKE8n7Q03zUQR5zB/BMHbYFP0D1WFm8ieM6QM6MDdasn4
 DCnezx3TzZfb11SSUoUlXObaJbDBWOOleXWtOjrr85IaNS4JYPYNuEi78kjYSryyhFDe
 CvTH4a/nw8bTqzSfxOx/uo/FTEegq1RM87gOxHt+Y4oFgeCUSEqpxVvGNz7v77mx7Dcd
 x59dKg66KKYQJSKq52cUzWSYzV90/t+q0Zi5tetdJXrkmC18X/r2EAUWs26RCuUoRVRF
 KzlM2mIAuWNgYFqZPG7NdOTUoGggXtWox9bqN/RYfF+HOnMqOmhIQe2ikcuJi+RH/TJF
 /e/w==
X-Gm-Message-State: ABy/qLY+HkKPTxnmjkgs6Kb2ZooWnWRL5cCaQx/+SO27dKNBimeX1xmZ
 XafNdhWZhmqLulWQHA9IhBp8yh0i/7ZZ50phffwsPqk2qGOY1jhPsYx3VK7FlZgWQeArMwBJrj6
 r6kKbomuF2wHRtD7j/nbRspT7aebh4yQdkEG6DALMAruNxdqLWisozfZM8w==
X-Received: by 2002:a2e:83d5:0:b0:2b6:9f1e:12c1 with SMTP id
 s21-20020a2e83d5000000b002b69f1e12c1mr4035890ljh.3.1688715897296; 
 Fri, 07 Jul 2023 00:44:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHU/nRDUHuYhFgse/jwYSAFRpY3tbiByilN09qGXhk1ws184RfXzxkxYMNviVf6GL/qykSZdeC91pKlPYfdWtk=
X-Received: by 2002:a2e:83d5:0:b0:2b6:9f1e:12c1 with SMTP id
 s21-20020a2e83d5000000b002b69f1e12c1mr4035877ljh.3.1688715896991; Fri, 07 Jul
 2023 00:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-3-shannon.nelson@amd.com>
In-Reply-To: <20230630003609.28527-3-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jul 2023 15:44:46 +0800
Message-ID: <CACGkMEvszXdPy9esfXLNsgjE8OQMX8UQ9HNQ2JVT87xwuOH+LQ@mail.gmail.com>
Subject: Re: [PATCH virtio 2/4] pds_vdpa: always allow offering
 VIRTIO_NET_F_MAC
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, drivers@pensando.io,
 virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
 mst@redhat.com
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

T24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgODozNuKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IE91ciBkcml2ZXIgc2V0cyBhIG1hYyBpZiB0aGUg
SFcgaXMgMDA6Li46MDAgc28gd2UgbmVlZCB0byBiZSBzdXJlIHRvCj4gYWR2ZXJ0aXNlIFZJUlRJ
T19ORVRfRl9NQUMgZXZlbiBpZiB0aGUgSFcgZG9lc24ndC4gIFdlIGFsc28gbmVlZCB0byBiZQo+
IHN1cmUgdGhhdCB2aXJ0aW9fbmV0IHNlZXMgdGhlIFZJUlRJT19ORVRfRl9NQUMgYW5kIGRvZXNu
J3QgcmV3cml0ZSB0aGUKPiBtYWMgYWRkcmVzcyB0aGF0IGEgdXNlciBtYXkgaGF2ZSBzZXQgd2l0
aCB0aGUgdmRwYSB1dGlsaXR5Lgo+Cj4gQWZ0ZXIgcmVhZGluZyB0aGUgaHdfZmVhdHVyZSBiaXRz
LCBhZGQgdGhlIFZJUlRJT19ORVRfRl9NQUMgdG8gdGhlIGRyaXZlcidzCj4gc3VwcG9ydGVkX2Zl
YXR1cmVzIGFuZCB1c2UgdGhhdCBmb3IgcmVwb3J0aW5nIHdoYXQgaXMgYXZhaWxhYmxlLiAgSWYg
dGhlCj4gSFcgaXMgbm90IGFkdmVydGlzaW5nIGl0LCBiZSBzdXJlIHRvIHN0cmlwIHRoZSBWSVJU
SU9fTkVUX0ZfTUFDIGJlZm9yZQo+IGZpbmlzaGluZyB0aGUgZmVhdHVyZSBuZWdvdGlhdGlvbi4g
IElmIHRoZSB1c2VyIHNwZWNpZmllcyBhIGRldmljZV9mZWF0dXJlcwo+IGJpdHBhdHRlcm4gaW4g
dGhlIHZkcGEgdXRpbGl0eSB3aXRob3V0IHRoZSBWSVJUSU9fTkVUX0ZfTUFDIHNldCwgdGhlbgo+
IGRvbid0IHNldCB0aGUgbWFjLgo+Cj4gRml4ZXM6IDE1MWNjODM0ZjNkZCAoInBkc192ZHBhOiBh
ZGQgc3VwcG9ydCBmb3IgdmRwYSBhbmQgdmRwYW1nbXQgaW50ZXJmYWNlcyIpCj4gU2lnbmVkLW9m
Zi1ieTogU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+Cj4gUmV2aWV3ZWQt
Ynk6IEJyZXR0IENyZWVsZXkgPGJyZXR0LmNyZWVsZXlAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy92ZHBhL3Bkcy92ZHBhX2Rldi5jIHwgMjUgKysrKysrKysrKysrKysrKysrKy0tLS0tLQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMgYi9kcml2ZXJzL3ZkcGEvcGRzL3Zk
cGFfZGV2LmMKPiBpbmRleCBlMmU5OWJiMGJlMmIuLjVlNzYxZDYyNWVmMyAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvcGRzL3Zk
cGFfZGV2LmMKPiBAQCAtMzE2LDYgKzMxNiw3IEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfc2V0X2Ry
aXZlcl9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1NjQgZmVhdHVyCj4g
IHsKPiAgICAgICAgIHN0cnVjdCBwZHNfdmRwYV9kZXZpY2UgKnBkc3YgPSB2ZHBhX3RvX3Bkc3Yo
dmRwYV9kZXYpOwo+ICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkc3YtPnZkcGFfZGV2
LmRldjsKPiArICAgICAgIHU2NCByZXF1ZXN0ZWRfZmVhdHVyZXM7Cj4gICAgICAgICB1NjQgZHJp
dmVyX2ZlYXR1cmVzOwo+ICAgICAgICAgdTY0IG5lZ29fZmVhdHVyZXM7Cj4gICAgICAgICB1NjQg
bWlzc2luZzsKPiBAQCAtMzI1LDE4ICszMjYsMjQgQEAgc3RhdGljIGludCBwZHNfdmRwYV9zZXRf
ZHJpdmVyX2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHU2NCBmZWF0dXIK
PiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+ICAgICAgICAgfQo+Cj4gKyAg
ICAgICAvKiBzYXZlIG9yaWdpbmFsIHJlcXVlc3QgZm9yIGRlYnVnZnMgKi8KPiAgICAgICAgIHBk
c3YtPnJlcV9mZWF0dXJlcyA9IGZlYXR1cmVzOwo+ICsgICAgICAgcmVxdWVzdGVkX2ZlYXR1cmVz
ID0gZmVhdHVyZXM7Cj4gKwo+ICsgICAgICAgLyogaWYgd2UncmUgZmFraW5nIHRoZSBGX01BQywg
c3RyaXAgaXQgZnJvbSBmZWF0dXJlcyB0byBiZSBuZWdvdGlhdGVkICovCj4gKyAgICAgICBkcml2
ZXJfZmVhdHVyZXMgPSBwZHNfdmRwYV9nZXRfZHJpdmVyX2ZlYXR1cmVzKHZkcGFfZGV2KTsKPiAr
ICAgICAgIGlmICghKGRyaXZlcl9mZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX01BQykp
KQo+ICsgICAgICAgICAgICAgICByZXF1ZXN0ZWRfZmVhdHVyZXMgJj0gfkJJVF9VTEwoVklSVElP
X05FVF9GX01BQyk7CgpJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIGhlcmUsIGFzc3VtaW5nIHdl
IGFyZSBkb2luZyBmZWF0dXJlCm5lZ290aWF0aW9uIGhlcmUuIEluIHRoaXMgY2FzZSBkcml2ZXJf
ZmVhdHVyZXMgd2UgcmVhZCBzaG91bGQgYmUgemVybz8KT3IgZGlkIHlvdSBhY3R1YWxseSBtZWFu
IGRldmljZV9mZWF0dXJlcyBoZXJlPwoKVGhhbmtzCgo+Cj4gICAgICAgICAvKiBDaGVjayBmb3Ig
dmFsaWQgZmVhdHVyZSBiaXRzICovCj4gLSAgICAgICBuZWdvX2ZlYXR1cmVzID0gZmVhdHVyZXMg
JiBsZTY0X3RvX2NwdShwZHN2LT52ZHBhX2F1eC0+aWRlbnQuaHdfZmVhdHVyZXMpOwo+IC0gICAg
ICAgbWlzc2luZyA9IHBkc3YtPnJlcV9mZWF0dXJlcyAmIH5uZWdvX2ZlYXR1cmVzOwo+ICsgICAg
ICAgbmVnb19mZWF0dXJlcyA9IHJlcXVlc3RlZF9mZWF0dXJlcyAmIGxlNjRfdG9fY3B1KHBkc3Yt
PnZkcGFfYXV4LT5pZGVudC5od19mZWF0dXJlcyk7Cj4gKyAgICAgICBtaXNzaW5nID0gcmVxdWVz
dGVkX2ZlYXR1cmVzICYgfm5lZ29fZmVhdHVyZXM7Cj4gICAgICAgICBpZiAobWlzc2luZykgewo+
ICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkNhbid0IHN1cHBvcnQgYWxsIHJlcXVlc3Rl
ZCBmZWF0dXJlcyBpbiAlI2xseCwgbWlzc2luZyAlI2xseCBmZWF0dXJlc1xuIiwKPiAgICAgICAg
ICAgICAgICAgICAgICAgICBwZHN2LT5yZXFfZmVhdHVyZXMsIG1pc3NpbmcpOwo+ICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIGRyaXZl
cl9mZWF0dXJlcyA9IHBkc192ZHBhX2dldF9kcml2ZXJfZmVhdHVyZXModmRwYV9kZXYpOwo+ICAg
ICAgICAgZGV2X2RiZyhkZXYsICIlczogJSNsbHggPT4gJSNsbHhcbiIsCj4gICAgICAgICAgICAg
ICAgIF9fZnVuY19fLCBkcml2ZXJfZmVhdHVyZXMsIG5lZ29fZmVhdHVyZXMpOwo+Cj4gQEAgLTU2
NCw3ICs1NzEsNyBAQCBzdGF0aWMgaW50IHBkc192ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdt
dF9kZXYgKm1kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4KPiAgICAgICAgIGlmIChhZGRfY29uZmln
LT5tYXNrICYgQklUX1VMTChWRFBBX0FUVFJfREVWX0ZFQVRVUkVTKSkgewo+ICAgICAgICAgICAg
ICAgICB1NjQgdW5zdXBwX2ZlYXR1cmVzID0KPiAtICAgICAgICAgICAgICAgICAgICAgICBhZGRf
Y29uZmlnLT5kZXZpY2VfZmVhdHVyZXMgJiB+bWdtdC0+c3VwcG9ydGVkX2ZlYXR1cmVzOwo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGFkZF9jb25maWctPmRldmljZV9mZWF0dXJlcyAmIH5wZHN2
LT5zdXBwb3J0ZWRfZmVhdHVyZXM7Cj4KPiAgICAgICAgICAgICAgICAgaWYgKHVuc3VwcF9mZWF0
dXJlcykgewo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiVW5zdXBwb3J0
ZWQgZmVhdHVyZXM6ICUjbGx4XG4iLCB1bnN1cHBfZmVhdHVyZXMpOwo+IEBAIC02MTUsNyArNjIy
LDggQEAgc3RhdGljIGludCBwZHNfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICpt
ZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ICAgICAgICAgfQo+Cj4gICAgICAgICAvKiBTZXQgYSBt
YWMsIGVpdGhlciBmcm9tIHRoZSB1c2VyIGNvbmZpZyBpZiBwcm92aWRlZAo+IC0gICAgICAgICog
b3Igc2V0IGEgcmFuZG9tIG1hYyBpZiBkZWZhdWx0IGlzIDAwOi4uOjAwCj4gKyAgICAgICAgKiBv
ciB1c2UgdGhlIGRldmljZSdzIG1hYyBpZiBub3QgMDA6Li46MDAKPiArICAgICAgICAqIG9yIHNl
dCBhIHJhbmRvbSBtYWMKPiAgICAgICAgICAqLwo+ICAgICAgICAgaWYgKGFkZF9jb25maWctPm1h
c2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSKSkgewo+ICAgICAgICAg
ICAgICAgICBldGhlcl9hZGRyX2NvcHkocGRzdi0+bWFjLCBhZGRfY29uZmlnLT5uZXQubWFjKTsK
PiBAQCAtNjI0LDcgKzYzMiw4IEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfZGV2X2FkZChzdHJ1Y3Qg
dmRwYV9tZ210X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPgo+ICAgICAgICAgICAgICAg
ICB2YyA9IHBkc3YtPnZkcGFfYXV4LT52ZF9tZGV2LmRldmljZTsKPiAgICAgICAgICAgICAgICAg
bWVtY3B5X2Zyb21pbyhwZHN2LT5tYWMsIHZjLT5tYWMsIHNpemVvZihwZHN2LT5tYWMpKTsKPiAt
ICAgICAgICAgICAgICAgaWYgKGlzX3plcm9fZXRoZXJfYWRkcihwZHN2LT5tYWMpKSB7Cj4gKyAg
ICAgICAgICAgICAgIGlmIChpc196ZXJvX2V0aGVyX2FkZHIocGRzdi0+bWFjKSAmJgo+ICsgICAg
ICAgICAgICAgICAgICAgKHBkc3YtPnN1cHBvcnRlZF9mZWF0dXJlcyAmIEJJVF9VTEwoVklSVElP
X05FVF9GX01BQykpKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgZXRoX3JhbmRvbV9hZGRy
KHBkc3YtPm1hYyk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2luZm8oZGV2LCAic2V0
dGluZyByYW5kb20gbWFjICVwTVxuIiwgcGRzdi0+bWFjKTsKPiAgICAgICAgICAgICAgICAgfQo+
IEBAIC03NTIsNiArNzYxLDEwIEBAIGludCBwZHNfdmRwYV9nZXRfbWdtdF9pbmZvKHN0cnVjdCBw
ZHNfdmRwYV9hdXggKnZkcGFfYXV4KQo+ICAgICAgICAgbWdtdC0+aWRfdGFibGUgPSBwZHNfdmRw
YV9pZF90YWJsZTsKPiAgICAgICAgIG1nbXQtPmRldmljZSA9IGRldjsKPiAgICAgICAgIG1nbXQt
PnN1cHBvcnRlZF9mZWF0dXJlcyA9IGxlNjRfdG9fY3B1KHZkcGFfYXV4LT5pZGVudC5od19mZWF0
dXJlcyk7Cj4gKwo+ICsgICAgICAgLyogYWR2ZXJ0aXNlIEZfTUFDIGV2ZW4gaWYgdGhlIGRldmlj
ZSBkb2Vzbid0ICovCj4gKyAgICAgICBtZ210LT5zdXBwb3J0ZWRfZmVhdHVyZXMgfD0gQklUX1VM
TChWSVJUSU9fTkVUX0ZfTUFDKTsKPiArCj4gICAgICAgICBtZ210LT5jb25maWdfYXR0cl9tYXNr
ID0gQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUik7Cj4gICAgICAgICBtZ210
LT5jb25maWdfYXR0cl9tYXNrIHw9IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9W
UVApOwo+ICAgICAgICAgbWdtdC0+Y29uZmlnX2F0dHJfbWFzayB8PSBCSVRfVUxMKFZEUEFfQVRU
Ul9ERVZfRkVBVFVSRVMpOwo+IC0tCj4gMi4xNy4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
