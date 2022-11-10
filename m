Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65309C433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 09:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C40FA401FB;
	Thu, 10 Nov 2022 09:14:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C40FA401FB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iGVSU1+h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gppt31gYWdu4; Thu, 10 Nov 2022 09:14:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2379F400AF;
	Thu, 10 Nov 2022 09:14:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2379F400AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6A5CC0032;
	Thu, 10 Nov 2022 09:14:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFD35C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 944DD400BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:14:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 944DD400BF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DpZ9PxZQwb7c
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:13:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B99BD400AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B99BD400AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668071638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Eo+993tzPE//U6vfrnyaKgpwg49AGZ5ezTqTVPuNTw=;
 b=iGVSU1+hzw/Vfs2X+1d/TCuEoVq0nnvaSyr0CfRO1NVASmd+XS59RWIAVJPIjq/qW4o331
 FVsd3ppXowWamSI2X+V/sSNOYKTWA4k7iyfYpIjukx9CSQn5FEWevyQTSQ5SEk/JheUsNT
 ZcxN40e4/e7tA5h9VrPV74YtDO4spMY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-Eqbz3kQJPvSQ_XGyUYA5vA-1; Thu, 10 Nov 2022 04:13:56 -0500
X-MC-Unique: Eqbz3kQJPvSQ_XGyUYA5vA-1
Received: by mail-oi1-f197.google.com with SMTP id
 19-20020aca1113000000b0035a95a1f697so435619oir.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 01:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Eo+993tzPE//U6vfrnyaKgpwg49AGZ5ezTqTVPuNTw=;
 b=XCFAumeH+hIBmCtExj6LRzYKiWxu0RL/8pPoEpGEvBkebk3pWA9mWDeI+JeUgBQi5O
 PxzTx7HOerIQGMlmboVyx51+lDD2fKJ4G06r3yffglpuqo2CSKKeujT0an6zF6N/od6l
 a41OomgKsoJ3k4bbOiraYY9cctTE0Wbd/Y9vfp15PrGQ3L/9VeFVIKVG3NiRMNE+yerW
 IpAffM2iK6feysFKheMaCi1Gsa4Wzi2JgVd+sxitr9Nvj3F1pH0KC0aH+7tb+qhYtnNm
 BdXtW+I5Rew58rxGi334xoepCXh3kiX6XiYe2CPHJ4+Jpiz6tJV3lJwpJoIcSgVPf1uJ
 YCZA==
X-Gm-Message-State: ACrzQf07IZGTrHvWMf92jEQPSTC2/th+1/6XmBsKMQGLM/Zy9yXw6qWL
 ho6swB+R0UFpRi706QhFf+BSIkaTJbX4uZvqaQBc+WYK0TyjwxqnXU1wmg2H5QWCaT80SDfV9rz
 Z0rZta+9f49VLQiuk2e+2P7sE3tMVpCjk5xtHd7qdxxLZZfJfFU0XaUkOIQ==
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr17332936oib.35.1668071636101; 
 Thu, 10 Nov 2022 01:13:56 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5g8DkSxI973B+iDAGilOnCuX4Ay70bh6mLHXgA5dZRuIYpLjeNOnYvc77Ze9zce4mijbGDhSRedk2PxKgKvYA=
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr17332927oib.35.1668071635886; Thu, 10
 Nov 2022 01:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20221107093345.121648-1-lingshan.zhu@intel.com>
 <CACGkMEs9af1E1pLd2t8E71YBPF=rHkhfN8qO9_3=x6HVaCMAxg@mail.gmail.com>
 <0b15591f-9e49-6383-65eb-6673423f81ec@intel.com>
 <CACGkMEujqOFHv7QATWgYo=SdAKef5jQXi2-YksjgT-hxEgKNDQ@mail.gmail.com>
 <80cdd80a-16fa-ac75-0a89-5729b846efed@intel.com>
 <CACGkMEu-5TbA3Ky2qgn-ivfhgfJ2b12mDJgq8iNgHce8qu3ApA@mail.gmail.com>
 <03657084-98ab-93bc-614a-e6cc7297d93e@intel.com>
 <d59c311f-ba9f-4c00-28f8-c50e099adb9f@redhat.com>
 <3286ad00-e432-da69-a041-6a3032494470@intel.com>
In-Reply-To: <3286ad00-e432-da69-a041-6a3032494470@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Nov 2022 17:13:44 +0800
Message-ID: <CACGkMEuca97Cv+XuKxmHHHgAQYsayZvJRtpONCCqcEE8qMu5Kw@mail.gmail.com>
Subject: Re: [PATCH 0/4] ifcvf/vDPA implement features provisioning
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: piotr.uminski@intel.com, hang.yuan@intel.com,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com
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

T24gVGh1LCBOb3YgMTAsIDIwMjIgYXQgNDo1OSBQTSBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56
aHVAaW50ZWwuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiAxMS8xMC8yMDIyIDI6MjkgUE0sIEphc29u
IFdhbmcgd3JvdGU6Cj4gPgo+ID4g5ZyoIDIwMjIvMTEvMTAgMTQ6MjAsIFpodSwgTGluZ3NoYW4g
5YaZ6YGTOgo+ID4+Cj4gPj4KPiA+PiBPbiAxMS8xMC8yMDIyIDExOjQ5IEFNLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4+PiBPbiBXZWQsIE5vdiA5LCAyMDIyIGF0IDU6MDYgUE0gWmh1LCBMaW5nc2hh
bgo+ID4+PiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4gd3JvdGU6Cj4gPj4+Pgo+ID4+Pj4KPiA+
Pj4+IE9uIDExLzkvMjAyMiA0OjU5IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+Pj4+IE9uIFdl
ZCwgTm92IDksIDIwMjIgYXQgNDoxNCBQTSBaaHUsIExpbmdzaGFuCj4gPj4+Pj4gPGxpbmdzaGFu
LnpodUBpbnRlbC5jb20+IHdyb3RlOgo+ID4+Pj4+Pgo+ID4+Pj4+PiBPbiAxMS85LzIwMjIgMjo1
MSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiA+Pj4+Pj4+IE9uIE1vbiwgTm92IDcsIDIwMjIgYXQg
NTo0MiBQTSBaaHUgTGluZ3NoYW4KPiA+Pj4+Pj4+IDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPiB3
cm90ZToKPiA+Pj4+Pj4+PiBUaGlzIHNlcmllcyBpbXBsZW1lbnRzIGZlYXR1cmVzIHByb3Zpc2lv
bmluZyBmb3IgaWZjdmYuCj4gPj4+Pj4+Pj4gQnkgYXBwbHlpbmcgdGhpcyBzZXJpZXMsIHdlIGFs
bG93IHVzZXJzcGFjZSB0byBjcmVhdGUKPiA+Pj4+Pj4+PiBhIHZEUEEgZGV2aWNlIHdpdGggc2Vs
ZWN0ZWQgKG1hbmFnZW1lbnQgZGV2aWNlIHN1cHBvcnRlZCkKPiA+Pj4+Pj4+PiBmZWF0dXJlIGJp
dHMgYW5kIG1hc2sgb3V0IG90aGVycy4KPiA+Pj4+Pj4+IEkgZG9uJ3Qgc2VlIGEgZGlyZWN0IHJl
bGF0aW9uc2hpcCBiZXR3ZWVuIHRoZSBmaXJzdCAzIGFuZCB0aGUgbGFzdC4KPiA+Pj4+Pj4+IE1h
eWJlIHlvdSBjYW4gc3RhdGUgdGhlIHJlYXNvbiB3aHkgdGhlIHJlc3RydWN0dXJlIGlzIGEgbXVz
dCBmb3IKPiA+Pj4+Pj4+IHRoZQo+ID4+Pj4+Pj4gZmVhdHVyZSBwcm92aXNpb25pbmcuIE90aGVy
d2lzZSwgd2UnZCBiZXR0ZXIgc3BsaXQgdGhlIHNlcmllcy4KPiA+Pj4+Pj4gV2hlbiBpbnRyb2R1
Y2luZyBmZWF0dXJlcyBwcm92aXNpb25pbmcgYWJpbGl0eSB0byBpZmN2ZiwgdGhlcmUgaXMKPiA+
Pj4+Pj4gYSBuZWVkCj4gPj4+Pj4+IHRvIHJlLWNyZWF0ZSB2RFBBIGRldmljZXMKPiA+Pj4+Pj4g
b24gYSBWRiB3aXRoIGRpZmZlcmVudCBmZWF0dXJlIGJpdHMuCj4gPj4+Pj4gVGhpcyBzZWVtcyBh
IHJlcXVpcmVtZW50IGV2ZW4gd2l0aG91dCBmZWF0dXJlIHByb3Zpc2lvbmluZz8gRGV2aWNlCj4g
Pj4+Pj4gY291bGQgYmUgZGVsZXRlZCBmcm9tIHRoZSBtYW5hZ2VtZW50IGRldmljZSBhbnlob3cu
Cj4gPj4+PiBZZXMsIHdlIG5lZWQgdGhpcyB0byBkZWxldGUgYW5kIHJlLWNyZWF0ZSBhIHZEUEEg
ZGV2aWNlLgo+ID4+PiBJIHdvbmRlciBpZiB3ZSBuZWVkIHNvbWV0aGluZyB0aGF0IHdvcmtzIGZv
ciAtc3RhYmxlLgo+ID4+IEkgY2FuIGFkZCBhIGZpeCB0YWcsIHNvIHRoZXNlIHRocmVlIHBhdGNo
ZXMgY291bGQgYXBwbHkgdG8gc3RhYmxlCj4gPgo+ID4KPiA+IEl0J3MgdG9vIGh1Z2UgZm9yIC1z
dGFibGUuCj4gPgo+ID4KPiA+Pj4KPiA+Pj4gQUZBSUssIHdlIGNhbiBtb3ZlIHRoZSB2ZHBhX2Fs
bG9jX2RldmljZSgpIGZyb20gcHJvYmUoKSB0byBkZXZfYWRkKCkKPiA+Pj4gYW5kIGl0IHNlZW1z
IHRvIHdvcms/Cj4gPj4gWWVzIGFuZCB0aGlzIGlzIGRvbmUgaW4gdGhpcyBzZXJpZXMgYW5kIHRo
YXQncyB3aHkgd2UgbmVlZCB0aGVzZQo+ID4+IHJlZmFjdG9yaW5nIGNvZGUuCj4gPgo+ID4KPiA+
IEkgbWVhbnQgdGhlcmUncyBwcm9iYWJseSBubyBuZWVkIHRvIGNoYW5nZSB0aGUgYXNzb2NpYXRp
b24gb2YgZXhpc3RpbmcKPiA+IHN0cnVjdHVyZSBidXQganVzdCBkbyB0aGUgYWxsb2NhdGlvbiBp
biBkZXZfYWRkKCksIHRoZW4gd2Ugd2lsbCBoYXZlIGEKPiA+IHBhdGNoIHdpdGggbXVjaCBtb3Jl
IHNtYWxsIGNoYW5nZXNldCB0aGF0IGZpdCBmb3IgLXN0YWJsZS4KPiBQYXRjaCAxKGlmY3ZmX2Jh
c2Ugb25seSB3b3JrIG9uIGlmY3ZmX2h3KSBhbmQgcGF0Y2ggMihpcnEgZnVuY3Rpb25zIG9ubHkK
PiB3b3JrIG9uIGlmY3ZmX2h3KSBhcmUgbm90IG5lZWRlZCBmb3Igc3RhYmxlLgo+IEkgaGF2ZSBh
bHJlYWR5IGRvbmUgdGhpcyBhbGxvY2F0aW9uIG9mIGlmY3ZmX2FkYXB0ZXIgd2hpY2ggaXMgdGhl
Cj4gY29udGFpbmVyIG9mIHN0cnVjdCB2ZHBhX2RldmljZSBpbiBkZXZfYWRkKCkgaW4gUGF0Y2gg
MywgdGhpcyBzaG91bGQgYmUKPiBtZXJnZWQgdG8gc3RhYmxlLgo+IFBhdGNoIDMgaXMgaHVnZSBi
dXQgbmVjZXNzYXJ5LCBub3Qgb25seSBhbGxvY2F0ZSBpZmN2Zl9hZGFwdGVyIGluCj4gZGV2X2Fk
ZCgpLCBpdCBhbHNvIHJlZmFjdG9ycyB0aGUgc3RydWN0dXJlcyBvZiBpZmN2Zl9tZ210X2RldiBh
bmQKPiBpZmN2Zl9hZGFwdGVyLAo+IGJlY2F1c2Ugd2UgbmVlZCB0byBpbml0aWFsaXplIHRoZSBW
RidzIGh3IHN0cnVjdHVyZSBpZmN2Zl9odyh3aGljaCB3YXMgYQo+IG1lbWJlciBvZiBpZmN2Zl9h
ZGFwdGVyIGJ1dCBub3cgc2hvdWxkIGJlIGEgbWVtYmVyIG9mIGlmY3ZmX21nbXRfZGV2KSBpbgo+
IHByb2JlLgo+Cj4gSXMgaXQgc3RpbGwgaHVnZT8KClRoZW4gcGxlYXNlIHJlb3JkZXIgdGhlIHBh
dGNoZXMsIHN0YWJsZS1rZXJuZWwtcnVsZXMucnN0IHNhaWQ6CgogLSBJdCBjYW5ub3QgYmUgYmln
Z2VyIHRoYW4gMTAwIGxpbmVzLCB3aXRoIGNvbnRleHQuCgpMZXQncyBzZWUuCgpUaGFua3MKCj4K
PiBUaGFua3MKPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+ID4+Cj4gPj4gQnkgdGhlIHdheSwgZG8g
eW91IGhhdmUgYW55IGNvbW1lbnRzIHRvIHRoZSBwYXRjaGVzPwo+ID4+Cj4gPj4gVGhhbmtzLAo+
ID4+IFpodSBMaW5nc2hhbgo+ID4+Pgo+ID4+PiBUaGFua3MKPiA+Pj4KPiA+Pj4+IFdlIGNyZWF0
ZSB2RFBBIGRldmljZSBmcm9tIGEgVkYsIHNvIHdpdGhvdXQgZmVhdHVyZXMgcHJvdmlzaW9uaW5n
Cj4gPj4+PiByZXF1aXJlbWVudHMsCj4gPj4+PiB3ZSBkb24ndCBuZWVkIHRvIHJlLWNyZWF0ZSB0
aGUgdkRQQSBkZXZpY2UuIEJ1dCB3aXRoIGZlYXR1cmVzCj4gPj4+PiBwcm92aXNpb25pbmcsCj4g
Pj4+PiBpdCBpcyBhIG11c3Qgbm93Lgo+ID4+Pj4KPiA+Pj4+IFRoYW5rcwo+ID4+Pj4KPiA+Pj4+
Cj4gPj4+Pj4gVGhha25zCj4gPj4+Pj4KPiA+Pj4+Pj4gV2hlbiByZW1vdmUgYSB2RFBBIGRldmlj
ZSwgdGhlIGNvbnRhaW5lciBvZiBzdHJ1Y3QgdmRwYV9kZXZpY2UKPiA+Pj4+Pj4gKGhlcmUgaXMK
PiA+Pj4+Pj4gaWZjdmZfYWRhcHRlcikgaXMgZnJlZS1lZCBpbgo+ID4+Pj4+PiBkZXZfZGVsKCkg
aW50ZXJmYWNlLCBzbyB3ZSBuZWVkIHRvIGFsbG9jYXRlIGlmY3ZmX2FkYXB0ZXIgaW4KPiA+Pj4+
Pj4gZGV2X2FkZCgpCj4gPj4+Pj4+IHRoYW4gaW4gcHJvYmUoKS4gVGhhdCdzCj4gPj4+Pj4+IHdo
eSBJIGhhdmUgcmUtZmFjdG9yZWQgdGhlIGFkYXB0ZXIvbWdtdF9kZXYgY29kZS4KPiA+Pj4+Pj4K
PiA+Pj4+Pj4gRm9yIHJlLWZhY3RvcmluZyB0aGUgaXJxIHJlbGF0ZWQgY29kZSBhbmQgaWZjdmZf
YmFzZSwgbGV0IHRoZW0KPiA+Pj4+Pj4gd29yayBvbgo+ID4+Pj4+PiBzdHJ1Y3QgaWZjdmZfaHcs
IHRoZQo+ID4+Pj4+PiByZWFzb24gaXMgdGhhdCB0aGUgYWRhcHRlciBpcyBhbGxvY2F0ZWQgaW4g
ZGV2X2FkZCgpLCBpZiB3ZSB3YW50Cj4gPj4+Pj4+IHRoZXNlcwo+ID4+Pj4+PiBmdW5jdGlvbnMg
dG8gd29yawo+ID4+Pj4+PiBiZWZvcmUgZGV2X2FkZCgpLCBsaWtlIGluIHByb2JlLCB3ZSBuZWVk
IHRoZW0gd29yayBvbiBpZmN2Zl9odwo+ID4+Pj4+PiB0aGFuIHRoZQo+ID4+Pj4+PiBhZGFwdGVy
Lgo+ID4+Pj4+Pgo+ID4+Pj4+PiBUaGFua3MKPiA+Pj4+Pj4gWmh1IExpbmdzaGFuCj4gPj4+Pj4+
PiBUaGFua3MKPiA+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gUGxlYXNlIGhlbHAgcmV2aWV3Cj4gPj4+Pj4+
Pj4KPiA+Pj4+Pj4+PiBUaGFua3MKPiA+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+IFpodSBMaW5nc2hhbiAo
NCk6Cj4gPj4+Pj4+Pj4gICAgICB2RFBBL2lmY3ZmOiBpZmN2ZiBiYXNlIGxheWVyIGludGVyZmFj
ZXMgd29yayBvbiBzdHJ1Y3QKPiA+Pj4+Pj4+PiBpZmN2Zl9odwo+ID4+Pj4+Pj4+ICAgICAgdkRQ
QS9pZmN2ZjogSVJRIGludGVyZmFjZXMgd29yayBvbiBpZmN2Zl9odwo+ID4+Pj4+Pj4+ICAgICAg
dkRQQS9pZmN2ZjogYWxsb2NhdGUgaWZjdmZfYWRhcHRlciBpbiBkZXZfYWRkKCkKPiA+Pj4+Pj4+
PiAgICAgIHZEUEEvaWZjdmY6IGltcGxlbWVudCBmZWF0dXJlcyBwcm92aXNpb25pbmcKPiA+Pj4+
Pj4+Pgo+ID4+Pj4+Pj4+ICAgICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jIHwgIDMy
ICsrLS0tLS0KPiA+Pj4+Pj4+PiAgICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8
ICAxMCArLQo+ID4+Pj4+Pj4+ICAgICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwg
MTU2Cj4gPj4+Pj4+Pj4gKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KPiA+Pj4+Pj4+
PiAgICAgMyBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspLCAxMDkgZGVsZXRpb25zKC0p
Cj4gPj4+Pj4+Pj4KPiA+Pj4+Pj4+PiAtLQo+ID4+Pj4+Pj4+IDIuMzEuMQo+ID4+Pj4+Pj4+Cj4g
Pj4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
