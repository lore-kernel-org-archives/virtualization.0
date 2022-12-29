Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D623C4332F
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 08:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C056440577;
	Thu, 29 Dec 2022 08:10:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C056440577
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FwPlf/18
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yd1veOoFSivz; Thu, 29 Dec 2022 08:10:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 439AD40573;
	Thu, 29 Dec 2022 08:10:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 439AD40573
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EC22C0033;
	Thu, 29 Dec 2022 08:10:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43918C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 08:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C11B60C29
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 08:10:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C11B60C29
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FwPlf/18
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jBgYAol6ExHe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 08:10:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4328960593
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4328960593
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 08:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672301445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gI6AlEc7KfZ1avo1jwJKrSQequUz5Q+UUl+tM82CWOM=;
 b=FwPlf/18Teflo3B/QtesMHoS2Ze/16AaBxtDwT8iWyTBKx/Y05rhIw2KU6UqjkAxKKeC39
 pvd0UyIDmFSJgN3ZT3EL2qJJgtNQecH6v2S+PJ4galWiSRq+/7r8sNszvQpWvf1Qo2iZy9
 7AsZHVQpGJCv5wyzPrUp8AYtYa6HGL4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-EjJvdBEcMXSgoR-Po1EgFQ-1; Thu, 29 Dec 2022 03:10:43 -0500
X-MC-Unique: EjJvdBEcMXSgoR-Po1EgFQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg25-20020a05600c3c9900b003cf3ed7e27bso9397516wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 00:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gI6AlEc7KfZ1avo1jwJKrSQequUz5Q+UUl+tM82CWOM=;
 b=d4bPz738RichmWEMjtTI6aYjW3w5BF+i17LZoxu5hnrpd4A8J67Pnct//+y//G6PMn
 md7mAlip9GBpRsT3wNZLkfCsLBetph9Fd2FXP2acGD/h6Pv3JRKXVDylBwsEpTlUZE18
 237B63JxwZvmvEHrPvzCVVW8UkguBc4uU0FyDmPnbdR840o5IijzTmKaJYJYth32vAPc
 r1KKN6zrpTBL4l0QpvCr+nAM/0go+n/vD9h4jpp82lCPSSbJbZImNr75F6HduuiL0Gbh
 NuwljCz1m1kBWd3kHNoPwiqOvxjXL564q8L3SbarWtZJed4vxwy3ZPMiUPuiTYUN9+oG
 6vjA==
X-Gm-Message-State: AFqh2kpiHRwg1jj07p2RVp/84IFZpfLwMcsXj+89NzWMrkNdKgUVhy+S
 EF+R3v1CgIAC2IZZ0Jsme/G90Yixwt51QoUtXb/W9nVuGIzoJKj6f+decf7BE8UX5t8EKsDex3l
 vw+GWuI4YLUyKl/pQWOaRAhaz9abzNiBv1k/fz9sPog==
X-Received: by 2002:adf:ce0a:0:b0:246:e6df:86e7 with SMTP id
 p10-20020adfce0a000000b00246e6df86e7mr17498199wrn.5.1672301442773; 
 Thu, 29 Dec 2022 00:10:42 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtCwrO0CDFtRs3sThb9MNmLR5zMGV1PR7/QCvy+zp7ENhYRIgm6RfCU8IAhgG7fUSbme3pHsQ==
X-Received: by 2002:adf:ce0a:0:b0:246:e6df:86e7 with SMTP id
 p10-20020adfce0a000000b00246e6df86e7mr17498181wrn.5.1672301442504; 
 Thu, 29 Dec 2022 00:10:42 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 a6-20020adff7c6000000b002421db5f279sm17347928wrq.78.2022.12.29.00.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Dec 2022 00:10:41 -0800 (PST)
Date: Thu, 29 Dec 2022 03:10:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20221229030633-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
 <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
 <20221229020553-mutt-send-email-mst@kernel.org>
 <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gVGh1LCBEZWMgMjksIDIwMjIgYXQgMDQ6MDQ6MTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIERlYyAyOSwgMjAyMiBhdCAzOjA3IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdlZCwgRGVjIDI4LCAyMDIyIGF0IDA3
OjUzOjA4UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFdlZCwgRGVjIDI4LCAy
MDIyIGF0IDI6MzQgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+ID4KPiA+ID4gPgo+ID4gPiA+IOWcqCAyMDIyLzEyLzI3IDE3OjM4LCBNaWNoYWVsIFMuIFRz
aXJraW4g5YaZ6YGTOgo+ID4gPiA+ID4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMDU6MTI6NThQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+PiDlnKggMjAyMi8xMi8yNyAxNToz
MywgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gPiA+Pj4gT24gVHVlLCBEZWMgMjcs
IDIwMjIgYXQgMTI6MzA6MzVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+Pj4+
PiBCdXQgZGV2aWNlIGlzIHN0aWxsIGdvaW5nIGFuZCB3aWxsIGxhdGVyIHVzZSB0aGUgYnVmZmVy
cy4KPiA+ID4gPiA+Pj4+Pgo+ID4gPiA+ID4+Pj4+IFNhbWUgZm9yIHRpbWVvdXQgcmVhbGx5Lgo+
ID4gPiA+ID4+Pj4gQXZvaWRpbmcgaW5maW5pdGUgd2FpdC9wb2xsIGlzIG9uZSBvZiB0aGUgZ29h
bHMsIGFub3RoZXIgaXMgdG8gc2xlZXAuCj4gPiA+ID4gPj4+PiBJZiB3ZSB0aGluayB0aGUgdGlt
ZW91dCBpcyBoYXJkLCB3ZSBjYW4gc3RhcnQgZnJvbSB0aGUgd2FpdC4KPiA+ID4gPiA+Pj4+Cj4g
PiA+ID4gPj4+PiBUaGFua3MKPiA+ID4gPiA+Pj4gSWYgdGhlIGdvYWwgaXMgdG8gYXZvaWQgZGlz
cnVwdGluZyB0cmFmZmljIHdoaWxlIENWUSBpcyBpbiB1c2UsCj4gPiA+ID4gPj4+IHRoYXQgc291
bmRzIG1vcmUgcmVhc29uYWJsZS4gRS5nLiBzb21lb25lIGlzIHR1cm5pbmcgb24gcHJvbWlzYywK
PiA+ID4gPiA+Pj4gYSBzcGlrZSBpbiBDUFUgdXNhZ2UgbWlnaHQgYmUgdW53ZWxjb21lLgo+ID4g
PiA+ID4+Cj4gPiA+ID4gPj4gWWVzLCB0aGlzIHdvdWxkIGJlIG1vcmUgb2J2aW91cyBpcyBVUCBp
cyB1c2VkLgo+ID4gPiA+ID4+Cj4gPiA+ID4gPj4KPiA+ID4gPiA+Pj4gdGhpbmdzIHdlIHNob3Vs
ZCBiZSBjYXJlZnVsIHRvIGFkZHJlc3MgdGhlbjoKPiA+ID4gPiA+Pj4gMS0gZGVidWdnaW5nLiBD
dXJyZW50bHkgaXQncyBlYXN5IHRvIHNlZSBhIHdhcm5pbmcgaWYgQ1BVIGlzIHN0dWNrCj4gPiA+
ID4gPj4+ICAgICAgaW4gYSBsb29wIGZvciBhIHdoaWxlLCBhbmQgd2UgYWxzbyBnZXQgYSBiYWNr
dHJhY2UuCj4gPiA+ID4gPj4+ICAgICAgRS5nLiB3aXRoIHRoaXMgLSBob3cgZG8gd2Uga25vdyB3
aG8gaGFzIHRoZSBSVE5MPwo+ID4gPiA+ID4+PiAgICAgIFdlIG5lZWQgdG8gaW50ZWdyYXRlIHdp
dGgga2VybmVsL3dhdGNoZG9nLmMgZm9yIGdvb2QgcmVzdWx0cwo+ID4gPiA+ID4+PiAgICAgIGFu
ZCB0byBtYWtlIHN1cmUgcG9saWN5IGlzIGNvbnNpc3RlbnQuCj4gPiA+ID4gPj4KPiA+ID4gPiA+
PiBUaGF0J3MgZmluZSwgd2lsbCBjb25zaWRlciB0aGlzLgo+ID4gPgo+ID4gPiBTbyBhZnRlciBz
b21lIGludmVzdGlnYXRpb24sIGl0IHNlZW1zIHRoZSB3YXRjaGRvZy5jIGRvZXNuJ3QgaGVscC4g
VGhlCj4gPiA+IG9ubHkgZXhwb3J0IGhlbHBlciBpcyB0b3VjaF9zb2Z0bG9ja3VwX3dhdGNoZG9n
KCkgd2hpY2ggdHJpZXMgdG8gYXZvaWQKPiA+ID4gdHJpZ2dlcmluZyB0aGUgbG9ja3VwcyB3YXJu
aW5nIGZvciB0aGUga25vd24gc2xvdyBwYXRoLgo+ID4KPiA+IEkgbmV2ZXIgc2FpZCB5b3UgY2Fu
IGp1c3QgdXNlIGV4aXN0aW5nIGV4cG9ydGluZyBBUElzLiBZb3UnbGwgaGF2ZSB0bwo+ID4gd3Jp
dGUgbmV3IG9uZXMgOikKPiAKPiBPaywgSSB0aG91Z2h0IHlvdSB3YW50ZWQgdG8gdHJpZ2dlciBz
aW1pbGFyIHdhcm5pbmdzIGFzIGEgd2F0Y2hkb2cuCj4gCj4gQnR3LCBJIHdvbmRlciB3aGF0IGtp
bmQgb2YgbG9naWMgeW91IHdhbnQgaGVyZS4gSWYgd2Ugc3dpdGNoIHRvIHVzaW5nCj4gc2xlZXAs
IHRoZXJlIHdvbid0IGJlIHNvZnQgbG9ja3VwIGFueW1vcmUuIEEgc2ltcGxlIHdhaXQgKyB0aW1l
b3V0ICsKPiB3YXJuaW5nIHNlZW1zIHN1ZmZpY2llbnQ/Cj4gCj4gVGhhbmtzCgpJJ2QgbGlrZSB0
byBhdm9pZCBuZWVkIHRvIHRlYWNoIHVzZXJzIG5ldyBBUElzLiBTbyB3YXRjaGRvZyBzZXR1cCB0
byBhcHBseQp0byB0aGlzIGRyaXZlci4gVGhlIHdhcm5pbmcgY2FuIGJlIGRpZmZlcmVudC4KCgo+
ID4KPiA+ID4gQW5kIGJlZm9yZSB0aGUgcGF0Y2gsIHdlIGVuZCB1cCB3aXRoIGEgcmVhbCBpbmZp
bml0ZSBsb29wIHdoaWNoIGNvdWxkCj4gPiA+IGJlIGNhdWdodCBieSBSQ1Ugc3RhbGwgZGV0ZWN0
b3Igd2hpY2ggaXMgbm90IHRoZSBjYXNlIG9mIHRoZSBzbGVlcC4KPiA+ID4gV2hhdCB3ZSBjYW4g
ZG8gaXMgcHJvYmFibHkgZG8gYSBwZXJpb2RpYyBuZXRkZXZfZXJyKCkuCj4gPiA+Cj4gPiA+IFRo
YW5rcwo+ID4KPiA+IE9ubHkgd2l0aCBhIGJhZCBkZXZpY2UuCj4gPgo+ID4gPiA+ID4+Cj4gPiA+
ID4gPj4KPiA+ID4gPiA+Pj4gMi0gb3ZlcmhlYWQuIEluIGEgdmVyeSBjb21tb24gc2NlbmFyaW8g
d2hlbiBkZXZpY2UgaXMgaW4gaHlwZXJ2aXNvciwKPiA+ID4gPiA+Pj4gICAgICBwcm9ncmFtbWlu
ZyB0aW1lcnMgZXRjIGhhcyBhIHZlcnkgaGlnaCBvdmVyaGVhZCwgYXQgYm9vdHVwCj4gPiA+ID4g
Pj4+ICAgICAgbG90cyBvZiBDVlEgY29tbWFuZHMgYXJlIHJ1biBhbmQgc2xvd2luZyBib290IGRv
d24gaXMgbm90IG5pY2UuCj4gPiA+ID4gPj4+ICAgICAgbGV0J3MgcG9sbCBmb3IgYSBiaXQgYmVm
b3JlIHdhaXRpbmc/Cj4gPiA+ID4gPj4KPiA+ID4gPiA+PiBUaGVuIHdlIGdvIGJhY2sgdG8gdGhl
IHF1ZXN0aW9uIG9mIGNob29zaW5nIGEgZ29vZCB0aW1lb3V0IGZvciBwb2xsLiBBbmQKPiA+ID4g
PiA+PiBwb2xsIHNlZW1zIHByb2JsZW1hdGljIGluIHRoZSBjYXNlIG9mIFVQLCBzY2hlZHVsZXIg
bWlnaHQgbm90IGhhdmUgdGhlCj4gPiA+ID4gPj4gY2hhbmNlIHRvIHJ1bi4KPiA+ID4gPiA+IFBv
bGwganVzdCBhIGJpdCA6KSBTZXJpb3VzbHkgSSBkb24ndCBrbm93LCBidXQgYXQgbGVhc3QgY2hl
Y2sgb25jZQo+ID4gPiA+ID4gYWZ0ZXIga2ljay4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gSSB0
aGluayBpdCBpcyB3aGF0IHRoZSBjdXJyZW50IGNvZGUgZGlkIHdoZXJlIHRoZSBjb25kaXRpb24g
d2lsbCBiZQo+ID4gPiA+IGNoZWNrIGJlZm9yZSB0cnlpbmcgdG8gc2xlZXAgaW4gdGhlIHdhaXRf
ZXZlbnQoKS4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4+PiAzLSBzdXByaXNl
IHJlbW92YWwuIG5lZWQgdG8gd2FrZSB1cCB0aHJlYWQgaW4gc29tZSB3YXkuIHdoYXQgYWJvdXQK
PiA+ID4gPiA+Pj4gICAgICBvdGhlciBjYXNlcyBvZiBkZXZpY2UgYnJlYWthZ2UgLSBpcyB0aGVy
ZSBhIGNoYW5jZSB0aGlzCj4gPiA+ID4gPj4+ICAgICAgaW50cm9kdWNlcyBuZXcgYnVncyBhcm91
bmQgdGhhdD8gYXQgbGVhc3QgZW51bWVyYXRlIHRoZW0gcGxlYXNlLgo+ID4gPiA+ID4+Cj4gPiA+
ID4gPj4gVGhlIGN1cnJlbnQgY29kZSBkaWQ6Cj4gPiA+ID4gPj4KPiA+ID4gPiA+PiAxKSBjaGVj
ayBmb3IgdnEtPmJyb2tlbgo+ID4gPiA+ID4+IDIpIHdha2V1cCBkdXJpbmcgQkFEX1JJTkcoKQo+
ID4gPiA+ID4+Cj4gPiA+ID4gPj4gU28gd2Ugd29uJ3QgZW5kIHVwIHdpdGggYSBuZXZlciB3b2tl
IHVwIHByb2Nlc3Mgd2hpY2ggc2hvdWxkIGJlIGZpbmUuCj4gPiA+ID4gPj4KPiA+ID4gPiA+PiBU
aGFua3MKPiA+ID4gPiA+Cj4gPiA+ID4gPiBCVFcgQkFEX1JJTkcgb24gcmVtb3ZhbCB3aWxsIHRy
aWdnZXIgZGV2X2Vyci4gTm90IHN1cmUgdGhhdCBpcyBhIGdvb2QKPiA+ID4gPiA+IGlkZWEgLSBj
YW4gY2F1c2UgY3Jhc2hlcyBpZiBrZXJuZWwgcGFuaWNzIG9uIGVycm9yLgo+ID4gPiA+Cj4gPiA+
ID4KPiA+ID4gPiBZZXMsIGl0J3MgYmV0dGVyIHRvIHVzZSBfX3ZpcnRxdWV1ZV9icmVhaygpIGlu
c3RlYWQuCj4gPiA+ID4KPiA+ID4gPiBCdXQgY29uc2lkZXIgd2Ugd2lsbCBzdGFydCBmcm9tIGEg
d2FpdCBmaXJzdCwgSSB3aWxsIGxpbWl0IHRoZSBjaGFuZ2VzCj4gPiA+ID4gaW4gdmlydGlvLW5l
dCB3aXRob3V0IGJvdGhlcmluZyB2aXJ0aW8gY29yZS4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPj4+Cj4gPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
