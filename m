Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4E7C7EE30
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 09:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE81260C05;
	Thu,  2 Mar 2023 09:45:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE81260C05
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fwonGpL4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MWHKKOgnqf7b; Thu,  2 Mar 2023 09:45:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EAA3860759;
	Thu,  2 Mar 2023 09:45:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAA3860759
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF085C0035;
	Thu,  2 Mar 2023 09:45:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14C2CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CED9860759
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:45:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CED9860759
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZUuo5iouOAei
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:45:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0D4560C05
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0D4560C05
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677750305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rbcPl/Xo1gbrdEEEeeBIbRO9JdxpAp6+JEpsGQF+O8=;
 b=fwonGpL4SmBouGV91r4Z5jmQiDIH4Hsd1tyG22r158Sp1Xk1UdiILbhfhk5DGDqOSC0aRG
 qKcmaX2XLP6oVDp9xRffLmZkEjzn4YCMhq6q3Fqy8IvIBbaN+n++k10YlOMv12oG+6u/3U
 YkTycaQYufuyWIMj2AAAC1OFmGo7zH8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-tRk2lhCiNgCGyKt6S69Q_g-1; Thu, 02 Mar 2023 04:45:04 -0500
X-MC-Unique: tRk2lhCiNgCGyKt6S69Q_g-1
Received: by mail-wr1-f70.google.com with SMTP id
 j2-20020adfa782000000b002ca9ab26627so2848758wrc.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 01:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3rbcPl/Xo1gbrdEEEeeBIbRO9JdxpAp6+JEpsGQF+O8=;
 b=VuzyS9XKS89D1LIXWrb9Q6Lz66Y2iU6sKTlKX0tTPxhpFRsQTBRZrKtIwXHCrBOBZa
 vQ+iuha41YGrinqLLSlQKuqC1w4AuG/B+lugg6MxuWwQfHXnhLYSuLBLi8/YOKpw3uYa
 tFkepovUU93rRLW/AUXsVGMa3Kf9pn0+34KZmApzZKtoA3jTwRjsXa2Vwxd3PLpcoCVR
 DYQ3tJDB055uHS5zUXhyzI9H7zubMMK2mVY/0qlFyJVRy86NwVPE7hsJbEhuBnUFsH62
 MkfRKzSh1NX9n5/5IE75pVH2T6lqpaRP1bBfUSGNvotZJVDWsVCJkx+/546QMD9hVjnr
 UWWg==
X-Gm-Message-State: AO0yUKXY6RYNAhWbabiPVN13QPOUm+PCPJq9P2DRsbGaebiuVnjLTveO
 v172nicac+796b2c9hMR0+zc2oQeP06pFrjdnH2wbLOlBnGRtF2lNSFLRHqCgrZeLTMdHS8whet
 6/b+PsvqMY9OWLtokUhop42RILXW7t1J6cENd7GUcDg==
X-Received: by 2002:a05:600c:3d99:b0:3dc:5ae4:c13d with SMTP id
 bi25-20020a05600c3d9900b003dc5ae4c13dmr7473024wmb.4.1677750303104; 
 Thu, 02 Mar 2023 01:45:03 -0800 (PST)
X-Google-Smtp-Source: AK7set9SGMecLsQHbDU+Ep5cCFFYOkidvt2LbJLkJ2KQmGNnd8Vc3XSsNc9dy5AVwYOCPDjAt0XbIA==
X-Received: by 2002:a05:600c:3d99:b0:3dc:5ae4:c13d with SMTP id
 bi25-20020a05600c3d9900b003dc5ae4c13dmr7473013wmb.4.1677750302818; 
 Thu, 02 Mar 2023 01:45:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a1c7c10000000b003e70a7c1b73sm2296348wmc.16.2023.03.02.01.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 01:45:02 -0800 (PST)
Message-ID: <82084397a98d55e17657b32a09c2909912498b41.camel@redhat.com>
Subject: Re: [PATCH v3] virtio-net: Fix probe of virtio-net on kvmtool
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 02 Mar 2023 10:45:00 +0100
In-Reply-To: <CACGkMEsG10CWigz+S6JgSVK8XfbpT=L=30hZ8LDvohtaanAiZQ@mail.gmail.com>
References: <20230223-virtio-net-kvmtool-v3-1-e038660624de@rivosinc.com>
 <20230301093054-mutt-send-email-mst@kernel.org>
 <CACGkMEsG10CWigz+S6JgSVK8XfbpT=L=30hZ8LDvohtaanAiZQ@mail.gmail.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rbradford@rivosinc.com, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVGh1LCAyMDIzLTAzLTAyIGF0IDE2OjEwICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9u
IFdlZCwgTWFyIDEsIDIwMjMgYXQgMTA6NDTigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPiA+IAo+ID4gT24gV2VkLCBNYXIgMDEsIDIwMjMgYXQgMDE6NTk6
NTJQTSArMDAwMCwgUm9iIEJyYWRmb3JkIHZpYSBCNCBSZWxheSB3cm90ZToKPiA+ID4gRnJvbTog
Um9iIEJyYWRmb3JkIDxyYnJhZGZvcmRAcml2b3NpbmMuY29tPgo+ID4gPiAKPiA+ID4gU2luY2Ug
dGhlIGZvbGxvd2luZyBjb21taXQgdmlydGlvLW5ldCBvbiBrdm10b29sIGhhcyBwcmludGVkIGEg
d2FybmluZwo+ID4gPiBkdXJpbmcgdGhlIHByb2JlOgo+ID4gPiAKPiA+ID4gY29tbWl0IGRiY2Yy
NGQxNTM4ODQ0MzlkYWQzMDQ4NGEwZTNmMDIzNTA2OTJlNGMKPiA+ID4gQXV0aG9yOiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiBEYXRlOiAgIFR1ZSBBdWcgMTcgMTY6MDY6
NTkgMjAyMSArMDgwMAo+ID4gPiAKPiA+ID4gICAgIHZpcnRpby1uZXQ6IHVzZSBORVRJRl9GX0dS
T19IVyBpbnN0ZWFkIG9mIE5FVElGX0ZfTFJPCj4gPiA+IAo+ID4gPiBbICAgIDEuODY1OTkyXSBu
ZXQgZXRoMDogRmFpbCB0byBzZXQgZ3Vlc3Qgb2ZmbG9hZC4KPiA+ID4gWyAgICAxLjg3MjQ5MV0g
dmlydGlvX25ldCB2aXJ0aW8yIGV0aDA6IHNldF9mZWF0dXJlcygpIGZhaWxlZCAoLTIyKTsgd2Fu
dGVkIDB4MDAwMDAwMDAwMDEzNDgyOSwgbGVmdCAweDAwODAwMDAwMDAxMzQ4MjkKPiA+ID4gCj4g
PiA+IFRoaXMgaXMgYmVjYXVzZSBkdXJpbmcgdGhlIHByb2JpbmcgdGhlIHVuZGVybHlpbmcgbmV0
ZGV2IGRldmljZSBoYXMKPiA+ID4gaWRlbnRpZmllZCB0aGF0IHRoZSBuZXRkZXYgZmVhdHVyZXMg
b24gdGhlIGRldmljZSBoYXMgY2hhbmdlZCBhbmQKPiA+ID4gYXR0ZW1wdHMgdG8gdXBkYXRlIHRo
ZSB2aXJ0aW8tbmV0IG9mZmxvYWRzIHRocm91Z2ggdGhlIHZpcnRpby1uZXQKPiA+ID4gY29udHJv
bCBxdWV1ZS4ga3ZtdG9vbCBob3dldmVyIGRvZXMgbm90IGhhdmUgYSBjb250cm9sIHF1ZXVlIHRo
YXQgc3VwcG9ydHMKPiA+ID4gb2ZmbG9hZCBjaGFuZ2luZyAoVklSVElPX05FVF9GX0NUUkxfR1VF
U1RfT0ZGTE9BRFMgaXMgbm90IGFkdmVydGlzZWQpCj4gPiA+IAo+ID4gPiBUaGUgbmV0ZGV2IGZl
YXR1cmVzIGhhdmUgY2hhbmdlZCBkdWUgdG8gdmFsaWRhdGlvbiBjaGVja3MgaW4KPiA+ID4gbmV0
ZGV2X2ZpeF9mZWF0dXJlcygpOgo+ID4gPiAKPiA+ID4gaWYgKCEoZmVhdHVyZXMgJiBORVRJRl9G
X1JYQ1NVTSkpIHsKPiA+ID4gICAgICAgLyogTkVUSUZfRl9HUk9fSFcgaW1wbGllcyBkb2luZyBS
WENTVU0gc2luY2UgZXZlcnkgcGFja2V0Cj4gPiA+ICAgICAgICAqIHN1Y2Nlc3NmdWxseSBtZXJn
ZWQgYnkgaGFyZHdhcmUgbXVzdCBhbHNvIGhhdmUgdGhlCj4gPiA+ICAgICAgICAqIGNoZWNrc3Vt
IHZlcmlmaWVkIGJ5IGhhcmR3YXJlLiAgSWYgdGhlIHVzZXIgZG9lcyBub3QKPiA+ID4gICAgICAg
ICogd2FudCB0byBlbmFibGUgUlhDU1VNLCBsb2dpY2FsbHksIHdlIHNob3VsZCBkaXNhYmxlIEdS
T19IVy4KPiA+ID4gICAgICAgICovCj4gPiA+ICAgICAgIGlmIChmZWF0dXJlcyAmIE5FVElGX0Zf
R1JPX0hXKSB7Cj4gPiA+ICAgICAgICAgICAgICAgbmV0ZGV2X2RiZyhkZXYsICJEcm9wcGluZyBO
RVRJRl9GX0dST19IVyBzaW5jZSBubyBSWENTVU0gZmVhdHVyZS5cbiIpOwo+ID4gPiAgICAgICAg
ICAgICAgIGZlYXR1cmVzICY9IH5ORVRJRl9GX0dST19IVzsKPiA+ID4gICAgICAgfQo+ID4gPiB9
Cj4gPiA+IAo+ID4gPiBTaW5jZSBrdm10b29sIGRvZXMgbm90IGFkdmVydGlzZSB0aGUgVklSVElP
X05FVF9GX0dVRVNUX0NTVU0gZmVhdHVyZSB0aGUKPiA+ID4gTkVUSUZfRl9SWENTVU0gYml0IGlz
IG5vdCBwcmVzZW50IGFuZCBzbyB0aGUgTkVUSUZfRl9HUk9fSFcgYml0IGlzCj4gPiA+IGNsZWFy
ZWQuIFRoaXMgcmVzdWx0cyBpbiB0aGUgbmV0ZGV2IGZlYXR1cmVzIGNoYW5naW5nLCB3aGljaCB0
cmlnZ2Vycwo+ID4gPiB0aGUgYXR0ZW1wdCB0byByZXByb2dyYW0gdGhlIHZpcnRpby1uZXQgb2Zm
bG9hZHMgd2hpY2ggdGhlbiBmYWlscy4KPiA+ID4gCj4gPiA+IFRoaXMgY29tbWl0IHByZXZlbnRz
IHRoYXQgc2V0IG9mIG5ldGRldiBmZWF0dXJlcyBmcm9tIGNoYW5naW5nIGJ5Cj4gPiA+IHByZWVt
cHRpdmVseSBhcHBseWluZyB0aGUgc2FtZSB2YWxpZGF0aW9uIGFuZCBvbmx5IHNldHRpbmcKPiA+
ID4gTkVUSUZfRl9HUk9fSFcgaWYgTkVUSUZfRl9SWENTVU0gaXMgc2V0IGJlY2F1c2UgdGhlIGRl
dmljZSBzdXBwb3J0cyBib3RoCj4gPiA+IFZJUlRJT19ORVRfRl9HVUVTVF9DU1VNIGFuZCBWSVJU
SU9fTkVUX0ZfR1VFU1RfVFNPezQsNn0KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJvYiBC
cmFkZm9yZCA8cmJyYWRmb3JkQHJpdm9zaW5jLmNvbT4KPiA+ID4gLS0tCj4gPiA+IENoYW5nZXMg
aW4gdjM6Cj4gPiA+IC0gSWRlbnRpZmllZCByb290LWNhdXNlIG9mIGZlYXR1cmUgYml0IGNoYW5n
aW5nIGFuZCB1cGRhdGVkIGNvbmRpdGlvbnMKPiA+ID4gICBjaGVjawo+ID4gPiAtIExpbmsgdG8g
djI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzAyMjMtdmlydGlvLW5ldC1rdm10b29s
LXYyLTEtOGVjOTM1MTFlNjdmQHJpdm9zaW5jLmNvbQo+ID4gPiAKPiA+ID4gQ2hhbmdlcyBpbiB2
MjoKPiA+ID4gLSBVc2UgcGFyZW50aGVzZXMgdG8gZ3JvdXAgbG9naWNhbCBPUiBvZiBmZWF0dXJl
cwo+ID4gPiAtIExpbmsgdG8gdjE6Cj4gPiA+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8y
MDIzMDIyMy12aXJ0aW8tbmV0LWt2bXRvb2wtdjEtMS1mYzIzZDI5YjlkN2FAcml2b3NpbmMuY29t
Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTAgKysrKysrLS0t
LQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
PiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gaW5kZXggNjFlMzNlNGRkMGNkLi4yZTc3MDUxNDJj
YTUgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiArKysg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gQEAgLTM3NzgsMTEgKzM3NzgsMTMgQEAg
c3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgZGV2LT5mZWF0dXJlcyB8PSBkZXYtPmh3X2ZlYXR1cmVz
ICYgTkVUSUZfRl9BTExfVFNPOwo+ID4gPiAgICAgICAgICAgICAgIC8qICghY3N1bSAmJiBnc28p
IGNhc2Ugd2lsbCBiZSBmaXhlZCBieSByZWdpc3Rlcl9uZXRkZXYoKSAqLwo+ID4gPiAgICAgICB9
Cj4gPiA+IC0gICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dV
RVNUX0NTVU0pKQo+ID4gPiArICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJ
T19ORVRfRl9HVUVTVF9DU1VNKSkgewo+ID4gPiAgICAgICAgICAgICAgIGRldi0+ZmVhdHVyZXMg
fD0gTkVUSUZfRl9SWENTVU07Cj4gPiA+IC0gICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRl
diwgVklSVElPX05FVF9GX0dVRVNUX1RTTzQpIHx8Cj4gPiA+IC0gICAgICAgICB2aXJ0aW9faGFz
X2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpKQo+ID4gPiAtICAgICAgICAg
ICAgIGRldi0+ZmVhdHVyZXMgfD0gTkVUSUZfRl9HUk9fSFc7Cj4gPiA+ICsgICAgICAgICAgICAg
LyogVGhpcyBkZXBlbmRlbmN5IGlzIGVuZm9yY2VkIGJ5IG5ldGRldl9maXhfZmVhdHVyZXMgKi8K
PiA+ID4gKyAgICAgICAgICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19O
RVRfRl9HVUVTVF9UU080KSB8fAo+ID4gPiArICAgICAgICAgICAgICAgICB2aXJ0aW9faGFzX2Zl
YXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpKQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX0dST19IVzsKPiA+ID4gKyAgICAgfQo+
ID4gPiAgICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9DVFJM
X0dVRVNUX09GRkxPQURTKSkKPiA+ID4gICAgICAgICAgICAgICBkZXYtPmh3X2ZlYXR1cmVzIHw9
IE5FVElGX0ZfR1JPX0hXOwo+IAo+IFNob3VsZCB3ZSBtb3ZlIHRoaXMgYWxzbyB1bmRlciB0aGUg
Y2hlY2sgb2YgUlhDU1VNLCBvdGhlcndpc2Ugd2UgbWF5Cj4gZW5kIHVwIHRoZSBmb2xsb3dpbmcg
Y2FzZToKPiAKPiB3aGVuIENTVU0gaXMgbm90IG5lZ290aWF0ZWQgYnV0IEdVRVNUX09GRkxPQURT
LCBjYW4gc3RpbGwgdHJ5IHRvCj4gZW5hYmxlLW9yLWRpc2FibGUgZ3Vlc3Qgb2ZmbG9hZHM/IE9y
IGRvIHdlIG5lZWQgdG8gZmFpbCB0aGUgcHJvYmUgaW4KPiB0aGUgY2FzZSB2aWEgdmlydG5ldF92
YWxpZGF0ZV9mZWF0dXJlcygpPwo+IAo+ID4gPiAKPiA+IAo+ID4gSSBzZWUuIEl0IGlzIGFubm95
aW5nIHRoYXQgd2UgYXJlIGR1cGxpY2F0aW5nIHRoZSBsb2dpYyBmcm9tCj4gPiBuZXRkZXZfZml4
X2ZlYXR1cmVzIGhlcmUgdGhvdWdoIDooCj4gPiBNYXliZSB3ZSBzaG91bGQgY2FsbCBuZXRkZXZf
dXBkYXRlX2ZlYXR1cmVzLCBpbiB0aGUgY2FsbGJhY2sgY2hlY2sKPiA+IHRoZSBmbGFncyBhbmQg
ZGVjaWRlIHdoYXQgdG8gc2V0IGFuZCB3aGF0IHRvIGNsZWFyPwo+ID4gT3IgZXhwb3J0IG5ldGRl
dl9maXhfZmVhdHVyZXMgdG8gbW9kdWxlcz8KPiAKPiBUaGVyZSdzIGEgbmRvX2ZpeF9mZWF0dXJl
cygpIHRoYXQgbWlnaHQgYmUgdXNlZCBoZXJlLgoKSSBhZ3JlZSB3aXRoIEphc29uOiBJIHRoaW5r
IGEgdmlydGlvX25ldCBzcGVjaWZpYyBuZG9fZml4X2ZlYXR1cmVzKCkKc2hvdWxkIGJlIHRoZSBy
aWdodCBwbGFjZSB0byBpbXBsZW1lbnQgdGhlIGFib3ZlIGxvZ2ljLgoKQ2hlZXJzLAoKUGFvbG8K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
