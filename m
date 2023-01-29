Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B900AC05027
	for <virtualization@archiver.kernel.org>; Sun, 29 Jan 2023 07:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E74841731;
	Sun, 29 Jan 2023 07:30:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E74841731
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MV66PArB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J3jMsg1qOF6N; Sun, 29 Jan 2023 07:30:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0491B41679;
	Sun, 29 Jan 2023 07:30:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0491B41679
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8562C0033;
	Sun, 29 Jan 2023 07:30:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 024F1C002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 07:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC58F60EF2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 07:30:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC58F60EF2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MV66PArB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UZE-GnlSb8ln
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 07:30:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5889C60E67
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5889C60E67
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 07:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674977412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ov+1IIBAWUO4cVMGk1jfLqe88PNWYaRlwb1nxeeSoz8=;
 b=MV66PArBGajreXgRz1MKlGH4MqzoOogvGVw+W3QvLJaXcKcAqhm14YHNlzlsHL6dVUgJ3z
 qgxGndB7oYO54AEoDcjttsBSzJJR4ivyR6C+GhWqK9nSwI57petwlVPCPbDuBnVUwVG3JY
 UXqttpx3HnXlQOblvNuV+kCVuOAj7xM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56-REti49ztPdWOv9-d34i_ww-1; Sun, 29 Jan 2023 02:30:08 -0500
X-MC-Unique: REti49ztPdWOv9-d34i_ww-1
Received: by mail-wm1-f71.google.com with SMTP id
 o5-20020a05600c4fc500b003db0b3230efso7365705wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Jan 2023 23:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ov+1IIBAWUO4cVMGk1jfLqe88PNWYaRlwb1nxeeSoz8=;
 b=UnXI1VGJOy8rEiVwCrDfgjBOK+4CvGzOTqS5n9z/0LAP27fjDAto1i8YPIOIfjmj/S
 Xe1WnTVQ2YBYY5mvfnEIW2ujqYDW7qdX8OB+oB2eBETZ7ORbARUi/+iO36yjMqtibf6M
 6TMT4s2WkB3DEiY8B8QTTiO9wtZL7o+LmGHmh9rXUrrPY+tJffdmHYm2/QOlj8uhpfcp
 b9wg3wzYdcYpf3xh/tur0XB+ZsxpVroK3xtyPst9iScn8URhrK8vUI6doPZFso4AMYc9
 yyHMa7gkxFbV8jGUC1FDi8csiIajwuDY50m2+bgNEIlarUSI34rGLlWX2dQJADGPwc4m
 S/oA==
X-Gm-Message-State: AO0yUKWJ7ndfpYatvXzXkIZL3OPg82QpgXUk5ayKb7tpcnlgqemhXO5p
 aFfAl12C0ik7ZbRKb2T+othSy8sSOiPMn/xzHdLQzAxgGrs3Fw13cZCvLqWTh4eR6R05FBjfEun
 fAA/avUa413jkod2i1UATifAw6hBKxzeCXRu1/YPbDw==
X-Received: by 2002:a5d:6088:0:b0:2bf:e533:3158 with SMTP id
 w8-20020a5d6088000000b002bfe5333158mr1886325wrt.20.1674977407430; 
 Sat, 28 Jan 2023 23:30:07 -0800 (PST)
X-Google-Smtp-Source: AK7set9LsUvsi2F0Rhe6agjXYMxH1Bd/kDEDU1j0Zr9SlfykK9KgWHLBzwN6kTKcmrPBAf0LiiWnSA==
X-Received: by 2002:a5d:6088:0:b0:2bf:e533:3158 with SMTP id
 w8-20020a5d6088000000b002bfe5333158mr1886305wrt.20.1674977407110; 
 Sat, 28 Jan 2023 23:30:07 -0800 (PST)
Received: from redhat.com ([2.52.20.248]) by smtp.gmail.com with ESMTPSA id
 z2-20020a5d6542000000b00267bcb1bbe5sm8398974wrv.56.2023.01.28.23.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jan 2023 23:30:06 -0800 (PST)
Date: Sun, 29 Jan 2023 02:30:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20230129022809-mutt-send-email-mst@kernel.org>
References: <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
 <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
 <20221229020553-mutt-send-email-mst@kernel.org>
 <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
 <20221229030633-mutt-send-email-mst@kernel.org>
 <CACGkMEukqZX=6yz1yCj+psHp5c+ZGVVuEYTUssfRCTQZgVWS6g@mail.gmail.com>
 <20230127053112-mutt-send-email-mst@kernel.org>
 <CACGkMEsZs=6TaeSUnu_9Rf+38uisi6ViHyM50=2+ut3Wze2S1g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsZs=6TaeSUnu_9Rf+38uisi6ViHyM50=2+ut3Wze2S1g@mail.gmail.com>
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

T24gU3VuLCBKYW4gMjksIDIwMjMgYXQgMDE6NDg6NDlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIEphbiAyNywgMjAyMyBhdCA2OjM1IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIEZyaSwgRGVjIDMwLCAyMDIyIGF0IDEx
OjQzOjA4QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFRodSwgRGVjIDI5LCAy
MDIyIGF0IDQ6MTAgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBPbiBUaHUsIERlYyAyOSwgMjAyMiBhdCAwNDowNDoxM1BNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gT24gVGh1LCBEZWMgMjksIDIwMjIgYXQgMzow
NyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gT24gV2VkLCBEZWMgMjgsIDIwMjIgYXQgMDc6NTM6MDhQTSArMDgwMCwg
SmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBXZWQsIERlYyAyOCwgMjAyMiBhdCAy
OjM0IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiDlnKggMjAyMi8xMi8yNyAxNzoz
OCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCBE
ZWMgMjcsIDIwMjIgYXQgMDU6MTI6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4g
PiA+ID4gPiA+ID4+IOWcqCAyMDIyLzEyLzI3IDE1OjMzLCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ
6YGTOgo+ID4gPiA+ID4gPiA+ID4gPj4+IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDEyOjMwOjM1
UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+PiBCdXQgZGV2
aWNlIGlzIHN0aWxsIGdvaW5nIGFuZCB3aWxsIGxhdGVyIHVzZSB0aGUgYnVmZmVycy4KPiA+ID4g
PiA+ID4gPiA+ID4+Pj4+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+PiBTYW1lIGZvciB0aW1lb3V0IHJl
YWxseS4KPiA+ID4gPiA+ID4gPiA+ID4+Pj4gQXZvaWRpbmcgaW5maW5pdGUgd2FpdC9wb2xsIGlz
IG9uZSBvZiB0aGUgZ29hbHMsIGFub3RoZXIgaXMgdG8gc2xlZXAuCj4gPiA+ID4gPiA+ID4gPiA+
Pj4+IElmIHdlIHRoaW5rIHRoZSB0aW1lb3V0IGlzIGhhcmQsIHdlIGNhbiBzdGFydCBmcm9tIHRo
ZSB3YWl0Lgo+ID4gPiA+ID4gPiA+ID4gPj4+Pgo+ID4gPiA+ID4gPiA+ID4gPj4+PiBUaGFua3MK
PiA+ID4gPiA+ID4gPiA+ID4+PiBJZiB0aGUgZ29hbCBpcyB0byBhdm9pZCBkaXNydXB0aW5nIHRy
YWZmaWMgd2hpbGUgQ1ZRIGlzIGluIHVzZSwKPiA+ID4gPiA+ID4gPiA+ID4+PiB0aGF0IHNvdW5k
cyBtb3JlIHJlYXNvbmFibGUuIEUuZy4gc29tZW9uZSBpcyB0dXJuaW5nIG9uIHByb21pc2MsCj4g
PiA+ID4gPiA+ID4gPiA+Pj4gYSBzcGlrZSBpbiBDUFUgdXNhZ2UgbWlnaHQgYmUgdW53ZWxjb21l
Lgo+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4+IFllcywgdGhpcyB3b3VsZCBi
ZSBtb3JlIG9idmlvdXMgaXMgVVAgaXMgdXNlZC4KPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4g
PiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPj4+IHRoaW5ncyB3ZSBzaG91bGQgYmUgY2FyZWZ1
bCB0byBhZGRyZXNzIHRoZW46Cj4gPiA+ID4gPiA+ID4gPiA+Pj4gMS0gZGVidWdnaW5nLiBDdXJy
ZW50bHkgaXQncyBlYXN5IHRvIHNlZSBhIHdhcm5pbmcgaWYgQ1BVIGlzIHN0dWNrCj4gPiA+ID4g
PiA+ID4gPiA+Pj4gICAgICBpbiBhIGxvb3AgZm9yIGEgd2hpbGUsIGFuZCB3ZSBhbHNvIGdldCBh
IGJhY2t0cmFjZS4KPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIEUuZy4gd2l0aCB0aGlzIC0gaG93
IGRvIHdlIGtub3cgd2hvIGhhcyB0aGUgUlROTD8KPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIFdl
IG5lZWQgdG8gaW50ZWdyYXRlIHdpdGgga2VybmVsL3dhdGNoZG9nLmMgZm9yIGdvb2QgcmVzdWx0
cwo+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgYW5kIHRvIG1ha2Ugc3VyZSBwb2xpY3kgaXMgY29u
c2lzdGVudC4KPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+PiBUaGF0J3MgZmlu
ZSwgd2lsbCBjb25zaWRlciB0aGlzLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gU28gYWZ0
ZXIgc29tZSBpbnZlc3RpZ2F0aW9uLCBpdCBzZWVtcyB0aGUgd2F0Y2hkb2cuYyBkb2Vzbid0IGhl
bHAuIFRoZQo+ID4gPiA+ID4gPiA+IG9ubHkgZXhwb3J0IGhlbHBlciBpcyB0b3VjaF9zb2Z0bG9j
a3VwX3dhdGNoZG9nKCkgd2hpY2ggdHJpZXMgdG8gYXZvaWQKPiA+ID4gPiA+ID4gPiB0cmlnZ2Vy
aW5nIHRoZSBsb2NrdXBzIHdhcm5pbmcgZm9yIHRoZSBrbm93biBzbG93IHBhdGguCj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IEkgbmV2ZXIgc2FpZCB5b3UgY2FuIGp1c3QgdXNlIGV4aXN0aW5nIGV4
cG9ydGluZyBBUElzLiBZb3UnbGwgaGF2ZSB0bwo+ID4gPiA+ID4gPiB3cml0ZSBuZXcgb25lcyA6
KQo+ID4gPiA+ID4KPiA+ID4gPiA+IE9rLCBJIHRob3VnaHQgeW91IHdhbnRlZCB0byB0cmlnZ2Vy
IHNpbWlsYXIgd2FybmluZ3MgYXMgYSB3YXRjaGRvZy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBCdHcs
IEkgd29uZGVyIHdoYXQga2luZCBvZiBsb2dpYyB5b3Ugd2FudCBoZXJlLiBJZiB3ZSBzd2l0Y2gg
dG8gdXNpbmcKPiA+ID4gPiA+IHNsZWVwLCB0aGVyZSB3b24ndCBiZSBzb2Z0IGxvY2t1cCBhbnlt
b3JlLiBBIHNpbXBsZSB3YWl0ICsgdGltZW91dCArCj4gPiA+ID4gPiB3YXJuaW5nIHNlZW1zIHN1
ZmZpY2llbnQ/Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPiBJJ2Qg
bGlrZSB0byBhdm9pZCBuZWVkIHRvIHRlYWNoIHVzZXJzIG5ldyBBUElzLiBTbyB3YXRjaGRvZyBz
ZXR1cCB0byBhcHBseQo+ID4gPiA+IHRvIHRoaXMgZHJpdmVyLiBUaGUgd2FybmluZyBjYW4gYmUg
ZGlmZmVyZW50Lgo+ID4gPgo+ID4gPiBSaWdodCwgc28gaXQgbG9va3MgdG8gbWUgdGhlIG9ubHkg
cG9zc2libGUgc2V0dXAgaXMgdGhlCj4gPiA+IHdhdGNoZG9nX3RocmVzLiBJIHBsYW4gdG8gdHJp
Z2dlciB0aGUgd2FybmluZyBldmVyeSB3YXRjaGRvZ190aHJlcyAqIDIKPiA+ID4gc2Vjb25kIChh
cyBzb2Z0bG9ja3VwIGRpZCkuCj4gPiA+Cj4gPiA+IEFuZCBJIHRoaW5rIGl0IHdvdWxkIHN0aWxs
IG1ha2Ugc2Vuc2UgdG8gZmFpbCwgd2UgY2FuIHN0YXJ0IHdpdGggYQo+ID4gPiB2ZXJ5IGxvbmcg
dGltZW91dCBsaWtlIDEgbWludXRlcyBhbmQgYnJlYWsgdGhlIGRldmljZS4gRG9lcyB0aGlzIG1h
a2UKPiA+ID4gc2Vuc2U/Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4KPiA+IEknZCBzYXkgd2UgbmVl
ZCB0byBtYWtlIHRoaXMgbWFuYWdlYWJsZSB0aGVuLgo+IAo+IERpZCB5b3UgbWVhbiBzb21ldGhp
bmcgbGlrZSBzeXNmcyBvciBtb2R1bGUgcGFyYW1ldGVycz8KCk5vIEknZCBzYXkgcGFzcyBpdCB3
aXRoIGFuIGlvY3RsLgoKPiA+IENhbid0IHdlIGRvIGl0IG5vcm1hbGx5Cj4gPiBlLmcuIHJlYWN0
IHRvIGFuIGludGVycnVwdCB0byByZXR1cm4gdG8gdXNlcnNwYWNlPwo+IAo+IEkgZGlkbid0IGdl
dCB0aGUgbWVhbmluZyBvZiB0aGlzLiBTb3JyeS4KPiAKPiBUaGFua3MKClN0YW5kYXJkIHdheSB0
byBoYW5kbGUgdGhpbmdzIHRoYXQgY2FuIHRpbWVvdXQgYW5kIHdoZXJlIHVzZXJzcGFjZQpkaWQg
bm90IHN1cHBseSB0aGUgdGltZSBpcyB0byBibG9jayB1bnRpbCBhbiBpbnRlcnJ1cHQKdGhlbiBy
ZXR1cm4gRUlOVFIuIFVzZXJzcGFjZSBjb250cm9scyB0aGUgdGltZW91dCBieQp1c2luZyBlLmcu
IGFsYXJtKDIpLgoKCj4gPgo+ID4KPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+IEFuZCBiZWZvcmUgdGhlIHBhdGNoLCB3ZSBlbmQgdXAgd2l0aCBhIHJlYWwgaW5m
aW5pdGUgbG9vcCB3aGljaCBjb3VsZAo+ID4gPiA+ID4gPiA+IGJlIGNhdWdodCBieSBSQ1Ugc3Rh
bGwgZGV0ZWN0b3Igd2hpY2ggaXMgbm90IHRoZSBjYXNlIG9mIHRoZSBzbGVlcC4KPiA+ID4gPiA+
ID4gPiBXaGF0IHdlIGNhbiBkbyBpcyBwcm9iYWJseSBkbyBhIHBlcmlvZGljIG5ldGRldl9lcnIo
KS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiBPbmx5IHdpdGggYSBiYWQgZGV2aWNlLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
Pj4KPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4gMi0gb3ZlcmhlYWQuIElu
IGEgdmVyeSBjb21tb24gc2NlbmFyaW8gd2hlbiBkZXZpY2UgaXMgaW4gaHlwZXJ2aXNvciwKPiA+
ID4gPiA+ID4gPiA+ID4+PiAgICAgIHByb2dyYW1taW5nIHRpbWVycyBldGMgaGFzIGEgdmVyeSBo
aWdoIG92ZXJoZWFkLCBhdCBib290dXAKPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIGxvdHMgb2Yg
Q1ZRIGNvbW1hbmRzIGFyZSBydW4gYW5kIHNsb3dpbmcgYm9vdCBkb3duIGlzIG5vdCBuaWNlLgo+
ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgbGV0J3MgcG9sbCBmb3IgYSBiaXQgYmVmb3JlIHdhaXRp
bmc/Cj4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPj4gVGhlbiB3ZSBnbyBiYWNr
IHRvIHRoZSBxdWVzdGlvbiBvZiBjaG9vc2luZyBhIGdvb2QgdGltZW91dCBmb3IgcG9sbC4gQW5k
Cj4gPiA+ID4gPiA+ID4gPiA+PiBwb2xsIHNlZW1zIHByb2JsZW1hdGljIGluIHRoZSBjYXNlIG9m
IFVQLCBzY2hlZHVsZXIgbWlnaHQgbm90IGhhdmUgdGhlCj4gPiA+ID4gPiA+ID4gPiA+PiBjaGFu
Y2UgdG8gcnVuLgo+ID4gPiA+ID4gPiA+ID4gPiBQb2xsIGp1c3QgYSBiaXQgOikgU2VyaW91c2x5
IEkgZG9uJ3Qga25vdywgYnV0IGF0IGxlYXN0IGNoZWNrIG9uY2UKPiA+ID4gPiA+ID4gPiA+ID4g
YWZ0ZXIga2ljay4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gSSB0aGluayBpdCBpcyB3aGF0IHRoZSBjdXJyZW50IGNvZGUgZGlkIHdoZXJlIHRoZSBjb25k
aXRpb24gd2lsbCBiZQo+ID4gPiA+ID4gPiA+ID4gY2hlY2sgYmVmb3JlIHRyeWluZyB0byBzbGVl
cCBpbiB0aGUgd2FpdF9ldmVudCgpLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4gMy0gc3VwcmlzZSByZW1vdmFsLiBu
ZWVkIHRvIHdha2UgdXAgdGhyZWFkIGluIHNvbWUgd2F5LiB3aGF0IGFib3V0Cj4gPiA+ID4gPiA+
ID4gPiA+Pj4gICAgICBvdGhlciBjYXNlcyBvZiBkZXZpY2UgYnJlYWthZ2UgLSBpcyB0aGVyZSBh
IGNoYW5jZSB0aGlzCj4gPiA+ID4gPiA+ID4gPiA+Pj4gICAgICBpbnRyb2R1Y2VzIG5ldyBidWdz
IGFyb3VuZCB0aGF0PyBhdCBsZWFzdCBlbnVtZXJhdGUgdGhlbSBwbGVhc2UuCj4gPiA+ID4gPiA+
ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPj4gVGhlIGN1cnJlbnQgY29kZSBkaWQ6Cj4gPiA+ID4g
PiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPj4gMSkgY2hlY2sgZm9yIHZxLT5icm9rZW4KPiA+
ID4gPiA+ID4gPiA+ID4+IDIpIHdha2V1cCBkdXJpbmcgQkFEX1JJTkcoKQo+ID4gPiA+ID4gPiA+
ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4+IFNvIHdlIHdvbid0IGVuZCB1cCB3aXRoIGEgbmV2ZXIg
d29rZSB1cCBwcm9jZXNzIHdoaWNoIHNob3VsZCBiZSBmaW5lLgo+ID4gPiA+ID4gPiA+ID4gPj4K
PiA+ID4gPiA+ID4gPiA+ID4+IFRoYW5rcwo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiBCVFcgQkFEX1JJTkcgb24gcmVtb3ZhbCB3aWxsIHRyaWdnZXIgZGV2X2Vyci4gTm90IHN1
cmUgdGhhdCBpcyBhIGdvb2QKPiA+ID4gPiA+ID4gPiA+ID4gaWRlYSAtIGNhbiBjYXVzZSBjcmFz
aGVzIGlmIGtlcm5lbCBwYW5pY3Mgb24gZXJyb3IuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+IFllcywgaXQncyBiZXR0ZXIgdG8gdXNlIF9fdmlydHF1ZXVl
X2JyZWFrKCkgaW5zdGVhZC4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBCdXQgY29u
c2lkZXIgd2Ugd2lsbCBzdGFydCBmcm9tIGEgd2FpdCBmaXJzdCwgSSB3aWxsIGxpbWl0IHRoZSBj
aGFuZ2VzCj4gPiA+ID4gPiA+ID4gPiBpbiB2aXJ0aW8tbmV0IHdpdGhvdXQgYm90aGVyaW5nIHZp
cnRpbyBjb3JlLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+Pj4KPiA+ID4gPiA+ID4KPiA+ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
