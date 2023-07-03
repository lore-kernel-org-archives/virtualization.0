Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ABAEB64DC
	for <virtualization@archiver.kernel.org>; Mon,  3 Jul 2023 07:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06367408F4;
	Mon,  3 Jul 2023 07:45:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06367408F4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iq1MiASN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mk_vK2MQLbiE; Mon,  3 Jul 2023 07:45:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 18A52408DE;
	Mon,  3 Jul 2023 07:45:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18A52408DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9E2AC0071;
	Mon,  3 Jul 2023 07:45:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5439FC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 07:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F38F60760
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 07:45:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F38F60760
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iq1MiASN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xYRaveVLTehw
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 07:45:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A1FC60B29
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A1FC60B29
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 07:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688370306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55bNqB8+Yuqx/ySjnDbigrCQp0fQIOTPHTvF9O0igIQ=;
 b=iq1MiASNguVECZ7jc2lOJ09mAzZS5TeIP3jhFAJnsr6mBDFDrdAf5lAAQR38HUhrZjfv1W
 GIJoUotpvh9ydJC1oc7F9g67S6+Ma5vXRnhT30IQBACEdcXQmLCmMzP1y+pKEqU95bukKL
 acPSumtWR7nsGHf71CGsPl/fWBvcXR4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-qMIljs3wP_G7RsKYRlSxTg-1; Mon, 03 Jul 2023 03:45:05 -0400
X-MC-Unique: qMIljs3wP_G7RsKYRlSxTg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b626e49e46so39612181fa.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Jul 2023 00:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688370304; x=1690962304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55bNqB8+Yuqx/ySjnDbigrCQp0fQIOTPHTvF9O0igIQ=;
 b=bkB1YOe+3RddicO8ad1jTbfSvdvrVqRJxca/ISME69xc5NC9J00UKZ4iYpCYVH5t/q
 0RDKcj2z+gooUTOgGNlDbz1BVv0mNfIg+x6P7W/pFJ332o0vE24iHgxamA5QvdWabra5
 OEcCKwcYbzYpCKw5mKGIThK0AMH3bAW95qB5o8FEKplLDhjLvrf2Wg4ppjXIRBQ/Muht
 rLTOcoDIFCdQ0jzWfEYghDz7nQDlYr0s03dSpzOUGga9R6+SL0OJyEBAR3Arew6F0dzC
 zrAzuNaBsrvzEjFfRVk9oJrPBs3WyYYI4XGD5nbPy7kBswWWG36/D3G9Iw3qjb5vPZ8P
 /o4Q==
X-Gm-Message-State: ABy/qLZqIbfGD6/HIkp6Cma8cRdKTG3lK/FcDUcv0SfkhpCUqrad7k+M
 QsDm9W8clfl/PwBZr0FXjMI0Tx4wAHK4fo4htukp0UgBVihV/ZBqt7/Q8oTYA5rPEyUqdU0TcF5
 nZ2ipoIdtY5bbz5yHJpp2/XvZ4j1El21QN+wna51l+hiF8ofx4JOjjEKqHQ==
X-Received: by 2002:a2e:9059:0:b0:2b6:9909:79cb with SMTP id
 n25-20020a2e9059000000b002b6990979cbmr6941110ljg.42.1688370304439; 
 Mon, 03 Jul 2023 00:45:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEIF9G1Mas3bWI9l/SxIhrXke3ejPrphx9HBEOMX/W+63WdpsfNStOiAI6vn69dm4MUmGuyOhoxIof/LMmBT6M=
X-Received: by 2002:a2e:9059:0:b0:2b6:9909:79cb with SMTP id
 n25-20020a2e9059000000b002b6990979cbmr6941093ljg.42.1688370304167; Mon, 03
 Jul 2023 00:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
In-Reply-To: <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Jul 2023 15:44:53 +0800
Message-ID: <CACGkMEt-Ao-0FmrG9y8+t31N9mJNyybY5SS+me_7pGyC_xJTsw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, eperezma@redhat.com, david.marchand@redhat.com
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

T24gTW9uLCBKdWwgMywgMjAyMyBhdCAzOjQz4oCvUE0gTWF4aW1lIENvcXVlbGluCjxtYXhpbWUu
Y29xdWVsaW5AcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPgo+IE9uIDcvMy8yMyAwODo0NCwgSmFzb24g
V2FuZyB3cm90ZToKPiA+IE9uIFN1biwgSnVsIDIsIDIwMjMgYXQgOTozN+KAr1BNIE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gT24gVHVlLCBKdW4g
MjcsIDIwMjMgYXQgMDE6MzY6NTBQTSArMDIwMCwgTWF4aW1lIENvcXVlbGluIHdyb3RlOgo+ID4+
PiBUaGlzIHNtYWxsIHNlcmllcyBlbmFibGVzIHZpcnRpby1uZXQgZGV2aWNlIHR5cGUgaW4gVkRV
U0UuCj4gPj4+IFdpdGggaXQsIGJhc2ljIG9wZXJhdGlvbiBoYXZlIGJlZW4gdGVzdGVkLCBib3Ro
IHdpdGgKPiA+Pj4gdmlydGlvLXZkcGEgYW5kIHZob3N0LXZkcGEgdXNpbmcgRFBESyBWaG9zdCBs
aWJyYXJ5IHNlcmllcwo+ID4+PiBhZGRpbmcgVkRVU0Ugc3VwcG9ydCB1c2luZyBzcGxpdCByaW5n
cyBsYXlvdXQgKG1lcmdlZCBpbgo+ID4+PiBEUERLIHYyMy4wNy1yYzEpLgo+ID4+Pgo+ID4+PiBD
b250cm9sIHF1ZXVlIHN1cHBvcnQgKGFuZCBzbyBtdWx0aXF1ZXVlKSBoYXMgYWxzbyBiZWVuCj4g
Pj4+IHRlc3RlZCwgYnV0IHJlcXVpcmVzIGEgS2VybmVsIHNlcmllcyBmcm9tIEphc29uIFdhbmcK
PiA+Pj4gcmVsYXhpbmcgY29udHJvbCBxdWV1ZSBwb2xsaW5nIFsxXSB0byBmdW5jdGlvbiByZWxp
YWJseS4KPiA+Pj4KPiA+Pj4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBQ0dr
TUV0Z3J4TjNQUHdzRG80b09zbnNTTEpmRW1CRVowV3ZqR1JyM3doVStRYXNVZ0BtYWlsLmdtYWls
LmNvbS9ULwo+ID4+Cj4gPj4gSmFzb24gcHJvbWlzZWQgdG8gcG9zdCBhIG5ldyB2ZXJzaW9uIG9m
IHRoYXQgcGF0Y2guCj4gPj4gUmlnaHQgSmFzb24/Cj4gPgo+ID4gWWVzLgo+ID4KPiA+PiBGb3Ig
bm93IGxldCdzIG1ha2Ugc3VyZSBDVlEgZmVhdHVyZSBmbGFnIGlzIG9mZj8KPiA+Cj4gPiBXZSBj
YW4gZG8gdGhhdCBhbmQgcmVsYXggb24gdG9wIG9mIG15IHBhdGNoLgo+Cj4gSSBhZ3JlZT8gRG8g
eW91IHByZWZlciBhIGZlYXR1cmVzIG5lZ290aWF0aW9uLCBvciBmYWlsaW5nIGluaXQgKGxpa2UK
PiBkb25lIGZvciBWRVJTSU9OXzEpIGlmIHRoZSBWRFVTRSBhcHBsaWNhdGlvbiBhZHZlcnRpc2Vz
IENWUT8KCkFzc3VtaW5nIHdlIHdpbGwgcmVsYXggaXQgc29vbiwgSSB0aGluayB3ZSBjYW4gY2hv
b3NlIHRoZSBlYXNpZXIgd2F5LgpJIGd1ZXNzIGl0J3MganVzdCBmYWlsaW5nLgoKVGhhbmtzCgo+
Cj4gVGhhbmtzLAo+IE1heGltZQo+Cj4gPiBUaGFua3MKPiA+Cj4gPj4KPiA+Pj4gUkZDIC0+IHYx
IGNoYW5nZXM6Cj4gPj4+ID09PT09PT09PT09PT09PT09PQo+ID4+PiAtIEZhaWwgZGV2aWNlIGlu
aXQgaWYgaXQgZG9lcyBub3Qgc3VwcG9ydCBWRVJTSU9OXzEgKEphc29uKQo+ID4+Pgo+ID4+PiBN
YXhpbWUgQ29xdWVsaW4gKDIpOgo+ID4+PiAgICB2ZHVzZTogdmFsaWRhdGUgYmxvY2sgZmVhdHVy
ZXMgb25seSB3aXRoIGJsb2NrIGRldmljZXMKPiA+Pj4gICAgdmR1c2U6IGVuYWJsZSBWaXJ0aW8t
bmV0IGRldmljZSB0eXBlCj4gPj4+Cj4gPj4+ICAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVz
ZV9kZXYuYyB8IDE1ICsrKysrKysrKysrLS0tLQo+ID4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+ID4+Pgo+ID4+PiAtLQo+ID4+PiAyLjQxLjAK
PiA+Pgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
