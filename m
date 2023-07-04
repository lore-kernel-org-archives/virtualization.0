Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808EDEB64D9
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 08:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F238C60E37;
	Tue,  4 Jul 2023 08:43:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F238C60E37
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmZ55qCi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HQLQRFG822LU; Tue,  4 Jul 2023 08:43:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9161C60E08;
	Tue,  4 Jul 2023 08:43:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9161C60E08
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60B8CC0071;
	Tue,  4 Jul 2023 08:43:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FEBFC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 08:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB4C181E13
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 08:43:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB4C181E13
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmZ55qCi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nnwvpl1-co3y
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 08:43:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE27B81B7B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE27B81B7B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 08:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688460194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wxHSZzQ3h16AMk8/bw5gkQqg1j0+pjTKVpjRmfziQs=;
 b=dmZ55qCi7V9yB2hHHQr2pCqxfv4esSyibCoIqDMz61G0wXJZkwV+XJd25ORaqknLORedzG
 twWkbHTac6p3DwqB2BTgMFlsxzXvGQQVO7tzZZbEUnnfyms/pxm1gT9LShJOi25ijs0p89
 bmyii7Ry3qY7cGVqiyktHnO1hQWAD6s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-b0syS39oNyakSQYOaSQ38A-1; Tue, 04 Jul 2023 04:43:13 -0400
X-MC-Unique: b0syS39oNyakSQYOaSQ38A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 222A21C05EB3;
 Tue,  4 Jul 2023 08:43:13 +0000 (UTC)
Received: from [10.39.208.32] (unknown [10.39.208.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E3C7F6419;
 Tue,  4 Jul 2023 08:43:09 +0000 (UTC)
Message-ID: <0630fc62-a414-6083-eed8-48b36acc7723@redhat.com>
Date: Tue, 4 Jul 2023 10:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
 <20230703174043-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230703174043-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 david.marchand@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiA3LzMvMjMgMjM6NDUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBNb24sIEp1
bCAwMywgMjAyMyBhdCAwOTo0Mzo0OUFNICswMjAwLCBNYXhpbWUgQ29xdWVsaW4gd3JvdGU6Cj4+
Cj4+IE9uIDcvMy8yMyAwODo0NCwgSmFzb24gV2FuZyB3cm90ZToKPj4+IE9uIFN1biwgSnVsIDIs
IDIwMjMgYXQgOTozN+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+Pj4+Cj4+Pj4gT24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgMDE6MzY6NTBQTSArMDIwMCwg
TWF4aW1lIENvcXVlbGluIHdyb3RlOgo+Pj4+PiBUaGlzIHNtYWxsIHNlcmllcyBlbmFibGVzIHZp
cnRpby1uZXQgZGV2aWNlIHR5cGUgaW4gVkRVU0UuCj4+Pj4+IFdpdGggaXQsIGJhc2ljIG9wZXJh
dGlvbiBoYXZlIGJlZW4gdGVzdGVkLCBib3RoIHdpdGgKPj4+Pj4gdmlydGlvLXZkcGEgYW5kIHZo
b3N0LXZkcGEgdXNpbmcgRFBESyBWaG9zdCBsaWJyYXJ5IHNlcmllcwo+Pj4+PiBhZGRpbmcgVkRV
U0Ugc3VwcG9ydCB1c2luZyBzcGxpdCByaW5ncyBsYXlvdXQgKG1lcmdlZCBpbgo+Pj4+PiBEUERL
IHYyMy4wNy1yYzEpLgo+Pj4+Pgo+Pj4+PiBDb250cm9sIHF1ZXVlIHN1cHBvcnQgKGFuZCBzbyBt
dWx0aXF1ZXVlKSBoYXMgYWxzbyBiZWVuCj4+Pj4+IHRlc3RlZCwgYnV0IHJlcXVpcmVzIGEgS2Vy
bmVsIHNlcmllcyBmcm9tIEphc29uIFdhbmcKPj4+Pj4gcmVsYXhpbmcgY29udHJvbCBxdWV1ZSBw
b2xsaW5nIFsxXSB0byBmdW5jdGlvbiByZWxpYWJseS4KPj4+Pj4KPj4+Pj4gWzFdOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sL0NBQ0drTUV0Z3J4TjNQUHdzRG80b09zbnNTTEpmRW1CRVow
V3ZqR1JyM3doVStRYXNVZ0BtYWlsLmdtYWlsLmNvbS9ULwo+Pj4+Cj4+Pj4gSmFzb24gcHJvbWlz
ZWQgdG8gcG9zdCBhIG5ldyB2ZXJzaW9uIG9mIHRoYXQgcGF0Y2guCj4+Pj4gUmlnaHQgSmFzb24/
Cj4+Pgo+Pj4gWWVzLgo+Pj4KPj4+PiBGb3Igbm93IGxldCdzIG1ha2Ugc3VyZSBDVlEgZmVhdHVy
ZSBmbGFnIGlzIG9mZj8KPj4+Cj4+PiBXZSBjYW4gZG8gdGhhdCBhbmQgcmVsYXggb24gdG9wIG9m
IG15IHBhdGNoLgo+Pgo+PiBJIGFncmVlPyBEbyB5b3UgcHJlZmVyIGEgZmVhdHVyZXMgbmVnb3Rp
YXRpb24sIG9yIGZhaWxpbmcgaW5pdCAobGlrZQo+PiBkb25lIGZvciBWRVJTSU9OXzEpIGlmIHRo
ZSBWRFVTRSBhcHBsaWNhdGlvbiBhZHZlcnRpc2VzIENWUT8KPj4KPj4gVGhhbmtzLAo+PiBNYXhp
bWUKPiAKPiBVbmZvcnR1bmF0ZWx5IGd1ZXN0cyBmYWlsIHByb2JlIGlmIGZlYXR1cmUgc2V0IGlz
IGluY29uc2lzdGVudC4KPiBTbyBJIGRvbid0IHRoaW5rIHBhc3NpbmcgdGhyb3VnaCBmZWF0dXJl
cyBpcyBhIGdvb2QgaWRlYSwKPiB5b3UgbmVlZCBhIGxpc3Qgb2YgbGVnYWwgYml0cy4gQW5kIHdo
ZW4gZG9pbmcgdGhpcywKPiBjbGVhciBDVlEgYW5kIGV2ZXJ5dGhpbmcgdGhhdCBkZXBlbmRzIG9u
IGl0LgoKU2luY2UgdGhpcyBpcyB0ZW1wb3JhcnksIHdoaWxlIGN2cSBpcyBtYWRlIG1vcmUgcm9i
dXN0LCBJIHRoaW5rIGl0IGlzCmJldHRlciB0byBmYWlsIFZEVVNFIGRldmljZSBjcmVhdGlvbiBp
ZiBDVlEgZmVhdHVyZSBpcyBhZHZlcnRpc2VkIGJ5IHRoZQpWRFVTRSBhcHBsaWNhdGlvbiwgaW5z
dGVhZCBvZiBlbnN1cmluZyBmZWF0dXJlcyBkZXBlbmRpbmcgb24gQ1ZRIGFyZQphbHNvIGNsZWFy
ZWQuCgpKYXNvbiBzZWVtcyB0byB0aGluayBsaWtld2lzZSwgd291bGQgdGhhdCB3b3JrIGZvciB5
b3U/CgpUaGFua3MsCk1heGltZQoKPiAKPiAKPj4+IFRoYW5rcwo+Pj4KPj4+Pgo+Pj4+PiBSRkMg
LT4gdjEgY2hhbmdlczoKPj4+Pj4gPT09PT09PT09PT09PT09PT09Cj4+Pj4+IC0gRmFpbCBkZXZp
Y2UgaW5pdCBpZiBpdCBkb2VzIG5vdCBzdXBwb3J0IFZFUlNJT05fMSAoSmFzb24pCj4+Pj4+Cj4+
Pj4+IE1heGltZSBDb3F1ZWxpbiAoMik6Cj4+Pj4+ICAgICB2ZHVzZTogdmFsaWRhdGUgYmxvY2sg
ZmVhdHVyZXMgb25seSB3aXRoIGJsb2NrIGRldmljZXMKPj4+Pj4gICAgIHZkdXNlOiBlbmFibGUg
VmlydGlvLW5ldCBkZXZpY2UgdHlwZQo+Pj4+Pgo+Pj4+PiAgICBkcml2ZXJzL3ZkcGEvdmRwYV91
c2VyL3ZkdXNlX2Rldi5jIHwgMTUgKysrKysrKysrKystLS0tCj4+Pj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pj4+Pgo+Pj4+PiAtLQo+Pj4+
PiAyLjQxLjAKPj4+Pgo+Pj4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
