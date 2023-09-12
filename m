Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1206CCA0ED5
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 04:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2981403FD;
	Tue, 12 Sep 2023 04:25:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A2981403FD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P9Gb1Vdf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z2_lJ6I3YF8r; Tue, 12 Sep 2023 04:25:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37CA540003;
	Tue, 12 Sep 2023 04:25:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37CA540003
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10B5FC0039;
	Tue, 12 Sep 2023 04:25:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BC7DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 04:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15762610CD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 04:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15762610CD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P9Gb1Vdf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rc5eu9jOgnj3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 04:25:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22CBF610C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 04:25:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22CBF610C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694492748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xt/6TK4ZAZf7utaAiAFXRfEuvmL8TglfbIta8iQ8Fk=;
 b=P9Gb1VdfFZnwPBeeoDJU7YwP/t2RSJ8p+Sttlby+RR+JAq5o6ccOz00vZmOZdV65Lv/dG8
 ZgzvKjloBiRzBKq3GJNJbfPKqEE/GpzLFkF+/1XFmqteS3gz6zprXY5NFIPGzbrc2bHxfT
 JvoMhx4hbNI+7M5/IxMGdqHJqrip/Xk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-ersdnVlcO7-K4ojXYki_fQ-1; Tue, 12 Sep 2023 00:25:46 -0400
X-MC-Unique: ersdnVlcO7-K4ojXYki_fQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5008240846fso3294571e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 21:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694492744; x=1695097544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xt/6TK4ZAZf7utaAiAFXRfEuvmL8TglfbIta8iQ8Fk=;
 b=cSCeLJiwELr3gtGvp0cybWfUXrNhcsa5RBDR3xcVkodpuVd8Hc01v6aiAkgmT9gmD/
 D0S29PbeTTnrTaflwUFLZkytSDFkMLrmt+4/wiymyFmrM+a5CD5U4vKr+oOo0mgfv5cp
 3zFhM3Pp7o25eTHIQwNWDWu99+L5ZzfO7HTwyBHAaI5GXyieKbxD2cojQ3Y4Qq0o36sn
 0ah+MrgxfhCdL5B7YBfGeCRGquMPF5KNBtv/NJg3C/mGaFFnmR5v6hpuhsYvlLv4m1jo
 ocK9AB/Qdm2k601//5yS/Gsq8vor9EYgJ1bUsSe15UPvKdov7b6/9R2IXlfUiOi31dUv
 085w==
X-Gm-Message-State: AOJu0Yw79hJEuPK2eTboUyxuoiZl3Bxffhm8UHiPolEwkS4xWP35fs9K
 v6OmHn6HI//wemMTyw/VVMQLwrcKLu2qI4Hi/9Gxb7ChoU9JLm4X2LQ00U/7djse2ZhOvAJ4Iz5
 C5tLLv7CJJB2b5V3PVoThnuq8LtJ1GwePlz3JlEX2iY4s4Vc56m5uENEqdQ==
X-Received: by 2002:a05:6512:159e:b0:500:af82:7ddc with SMTP id
 bp30-20020a056512159e00b00500af827ddcmr507290lfb.28.1694492744655; 
 Mon, 11 Sep 2023 21:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH1eVTDE96O2FrJhL5LE1f7qnozt2/+EhcZbm3g8P2gzUa/kRBqy8SuAS2j9tt5abySU9/ojase4fOi1ABmNk=
X-Received: by 2002:a05:6512:159e:b0:500:af82:7ddc with SMTP id
 bp30-20020a056512159e00b00500af827ddcmr507283lfb.28.1694492744328; Mon, 11
 Sep 2023 21:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <1694248959-13369-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEumYw5NKGfakjm=QGxTX0JH71owt240=y0WGxQzGipXGA@mail.gmail.com>
 <a9516f2b76d66f5292358b4509a854ebd57fb090.camel@nvidia.com>
In-Reply-To: <a9516f2b76d66f5292358b4509a854ebd57fb090.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Sep 2023 12:25:33 +0800
Message-ID: <CACGkMEsCuzzBLiREiCRAnGXRY6K2UN58skNW3KPHh7UE5p6Jpw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/3] vdpa: dedicated descriptor table group
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
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

T24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgMzowNuKAr1BNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IEhpIEphc29uLAo+Cj4gT24gTW9uLCAyMDIzLTA5LTEx
IGF0IDE0OjQzICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gU2F0LCBTZXAgOSwgMjAy
MyBhdCA0OjQ14oCvUE0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90ZToK
PiA+ID4KPiA+ID4gRm9sbG93aW5nIHBhdGNoc2V0IGludHJvZHVjZXMgZGVkaWNhdGVkIGdyb3Vw
IGZvciBkZXNjcmlwdG9yIHRhYmxlIHRvCj4gPiA+IHJlZHVjZSBsaXZlIG1pZ3JhdGlvbiBkb3du
dGltZSB3aGVuIHBhc3N0aHJvdWdoIFZRIGlzIGJlaW5nIHN3aXRjaGVkCj4gPiA+IHRvIHNoYWRv
dyBWUS4gVGhpcyBSRkMgdjIgaXMgc2VudCB0byBpbmNvcnBvcmF0ZSB0aGUgZWFybHkgZmVlZGJh
Y2sKPiA+ID4gZnJvbSByZXZpZXdlcnMgb24gdGhlIHVBUEkgYW5kIGRyaXZlciBBUEkgcGFydCBv
ZiBjaGFuZ2VzLCB0aGUKPiA+ID4gYXNzb2NpYXRlZCBkcml2ZXIgcGF0Y2ggc2V0IGNvbnN1bWlu
ZyB0aHMgQVBJIHdpbGwgY29tZSBhcm91bmQKPiA+ID4gc29vbiBhbG9uZyB3aXRoIGZvcm1hbCBz
dWJtaXNzaW9uIG9mIHRoaXMgc2VyaWVzLgo+ID4gPgo+ID4gPiBTb21lIGluaXRpYWwgcGVyZm9y
bWFuY2UgZGF0YSB3aWxsIGJlIGdhdGhlcmVkIHVzaW5nIHRoZSByZWFsCj4gPiA+IGhhcmR3YXJl
IGRldmljZSB3aXRoIG1seDVfdmRwYS4gVGhlIHRhcmdldCBnb2FsIG9mIHRoaXMgc2VyaWVzIGlz
IHRvCj4gPiA+IHJlZHVjZSB0aGUgU1ZRIHN3aXRjaGluZyBvdmVyaGVhZCB0byBsZXNzIHRoYW4g
MzAwbXMgb24gYSB+MTAwR0IKPiA+ID4gZ3Vlc3Qgd2l0aCAyIG5vbi1tcSB2aG9zdC12ZHBhIGRl
dmljZXMuIFRoZSByZWR1Y3Rpb24gaW4gdGhlIGRvd250aW1lCj4gPiA+IGlzIHRoYW5rcyB0byBh
dm9pZGluZyB0aGUgZnVsbCByZW1hcCBpbiB0aGUgc3dpdGNoaW5nLgo+ID4gPgo+ID4gPiBUaGUg
cGxhbiBvZiB0aGUgaW50ZW5kZWQgZHJpdmVyIGltcGxlbWVudGF0aW9uIGlzIHRvIHVzZSBhIGRl
ZGljYXRlZAo+ID4gPiBncm91cCAoc3BlY2lmaWNhbGx5LCAyIGluIGJlbG93IHRhYmxlKSB0byBo
b3N0IHRoZSBkZXNjcmlwdG9yIHRhYmxlcwo+ID4gPiBmb3IgZGF0YSB2cXMsIGRpZmZlcmVudCBm
cm9tIHdoZXJlIGJ1ZmZlciBhZGRyZXNzZXMgYXJlIGNvbnRhaW5lZCAoaW4KPiA+ID4gZ3JvdXAg
MCBhcyBiZWxvdykuIGN2cSBkb2VzIG5vdCBoYXZlIHRvIGFsbG9jYXRlIGRlZGljYXRlZCBncm91
cCBmb3IKPiA+ID4gZGVzY3JpcHRvciB0YWJsZSwgc28gaXRzIGJ1ZmZlcnMgYW5kIGRlc2NyaXB0
b3IgdGFibGUgd291bGQgYWx3YXlzCj4gPiA+IGJlbG9uZyB0byB0aGUgc2FtZSBncm91cCAoMSBp
biB0YWJsZSBiZWxvdykuCj4gPiA+Cj4gPiA+Cj4gPiA+ICAgICAgICAgICAgICAgfCAgZGF0YSB2
cSB8IGN0cmwgdnEKPiA+ID4gPT09PT09PT09PT09PT0rPT09PT09PT09PSs9PT09PT09PT09PQo+
ID4gPiB2cV9ncm91cCAgICAgIHwgICAgMCAgICAgfCAgICAxCj4gPiA+IHZxX2Rlc2NfZ3JvdXAg
fCAgICAyICAgICB8ICAgIDEKPiA+ID4KPiA+ID4KPiA+ID4gLS0tCj4gPiA+Cj4gPiA+IFNpLVdl
aSBMaXUgKDMpOgo+ID4gPiAgIHZkcGE6IGludHJvZHVjZSBkZWRpY2F0ZWQgZGVzY3JpcHRvciBn
cm91cCBmb3IgdmlydHF1ZXVlCj4gPiA+ICAgdmhvc3QtdmRwYTogaW50cm9kdWNlIGRlc2NyaXB0
b3IgZ3JvdXAgYmFja2VuZCBmZWF0dXJlCj4gPiA+ICAgdmhvc3QtdmRwYTogdUFQSSB0byBnZXQg
ZGVkaWNhdGVkIGRlc2NyaXB0b3IgZ3JvdXAgaWQKPiA+Cj4gPiBMb29rcyBnb29kIHRvIG1lIGJ1
dCBJJ2QgZXhwZWN0IGV4YW1wbGUgaW1wbGVtZW50YXRpb25zIGluIHRoZSBwYXJlbnQuCj4gPgo+
IFdlIChTaS1XZWkgYW5kIEkpIHdpbGwgc2VuZCBhIG5vbi1SRkMgc2VyaWVzIHdpdGggdGhlIG1s
eDVfdmRwYSBpbXBsZW1lbnRhdGlvbgo+IGFzIHNvb24gYXMgdGhlIHN1Ym1pc3Npb24gd2luZG93
IG9wZW5zLgo+Cj4gQ2FuIHdlIGFkZCB5b3VyIEFja2VkLWJ5IGZvciB0aGVzZSBjb3JlIHBhdGNo
ZXM/CgpZZXMuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gRHJhZ29zCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
