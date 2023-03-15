Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B41C7618E
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 07:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 084204052E;
	Wed, 15 Mar 2023 07:06:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 084204052E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WBUAbgdO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jff8pV1aW8aS; Wed, 15 Mar 2023 07:06:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 619E6404F9;
	Wed, 15 Mar 2023 07:06:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 619E6404F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B0F0C0035;
	Wed, 15 Mar 2023 07:06:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F635C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 07:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F195581496
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 07:06:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F195581496
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WBUAbgdO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxlmE5wK9AtK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 07:06:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEF378146A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AEF378146A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 07:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678863966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=21PStzEz1jRA5vdQ8HyLpGRj1pTm7pwftVwgmgKMnTM=;
 b=WBUAbgdO65VHyxhCMpTqbsivKrdneuc6K09l7wb9QSrjb//P7h6TmjxptJMsiy8upaJeuj
 sIlUJyqWF0r/KklQ+ekITCB73Nt8GVtWDG2waOfBIxM0UND+qONiB8VKbzmK9G8WxcYzZi
 E8JfnaMsTE41/bwGGNsYjxS2BRxdTgM=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-YfmtnAShMmGnFZUym5jIFg-1; Wed, 15 Mar 2023 03:06:03 -0400
X-MC-Unique: YfmtnAShMmGnFZUym5jIFg-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1778b36a88dso6965555fac.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 00:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678863963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21PStzEz1jRA5vdQ8HyLpGRj1pTm7pwftVwgmgKMnTM=;
 b=MNR0KCOeAKM2AdNX9mgsg9sDT2JwW+2XvzO08DcmMOG+nl62q/PnUaQn9yKQkHbNwB
 MNpEMop+B/PC/tgw67boS3tVCXiLNvlXho3Y81xufJVUyP4cairObg6/mS/Q5ODL5XpZ
 kEDh7ZbIlt9K372u1NGud6f8S24w/eNqNQikWRz5g5MBBMgNVVtQRL9PbnYQH+/oS8lD
 HD7VnK5CZ54sh5R6vdEN9KH8b/vedU6vT9gGsE6Az6Ln7/FrYWFv1/3rqw74ftdVdDeO
 L5B0vJg+nZ2QS11mQvoqghcoSBbXDmtqrU65anhSnVRV0SyPvWJMErTyAYKUEH8RYtF5
 mAgQ==
X-Gm-Message-State: AO0yUKX5BvWt9eaEF25rqneRwUoqIf9azrgi/DPMy4NnXUzWmaWgT+GN
 pzlUqsZpArq/Sw1YxaCA6JH/FZQ//43op6r5aOADkkB9G21QhX0UA9udr/TiGzoSjwaK25yVihP
 eYO2Xz4LSUkQ2oaxIIasdDAtfTFEZTTYa7unkPa7CQF5Zas6uN0VW7EnGHQ==
X-Received: by 2002:a05:6870:649f:b0:177:9f9c:dc5 with SMTP id
 cz31-20020a056870649f00b001779f9c0dc5mr5038271oab.9.1678863963010; 
 Wed, 15 Mar 2023 00:06:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set8pEnOJZbt4dAlXxX1QWi0bfR11fY7jA9dcWl13QD0Yn3HDJZy6smnPnQEkGmS1L1ucv9bRI4Eh905cGt0Yzt8=
X-Received: by 2002:a05:6870:649f:b0:177:9f9c:dc5 with SMTP id
 cz31-20020a056870649f00b001779f9c0dc5mr5038260oab.9.1678863962782; Wed, 15
 Mar 2023 00:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230309013046.23523-1-shannon.nelson@amd.com>
 <20230309013046.23523-8-shannon.nelson@amd.com>
In-Reply-To: <20230309013046.23523-8-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Mar 2023 15:05:51 +0800
Message-ID: <CACGkMEsuG98ASnuS2zjfro3ZkBhAr5KnhWYWqBkyT9ZzPvLXiw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 virtio 7/7] pds_vdpa: pds_vdps.rst and Kconfig
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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

T24gVGh1LCBNYXIgOSwgMjAyMyBhdCA5OjMx4oCvQU0gU2hhbm5vbiBOZWxzb24gPHNoYW5ub24u
bmVsc29uQGFtZC5jb20+IHdyb3RlOgo+Cj4gQWRkIHRoZSBkb2N1bWVudGF0aW9uIGFuZCBLY29u
ZmlnIGVudHJ5IGZvciBwZHNfdmRwYSBkcml2ZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9u
IE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4KPiAtLS0KPiAgLi4uL2V0aGVybmV0L3Bl
bnNhbmRvL3Bkc192ZHBhLnJzdCAgICAgICAgICAgIHwgODQgKysrKysrKysrKysrKysrKysrKwo+
ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArCj4g
IGRyaXZlcnMvdmRwYS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrCj4g
IDMgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L3BlbnNhbmRv
L3Bkc192ZHBhLnJzdAo+Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9k
ZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9wZW5zYW5kby9wZHNfdmRwYS5yc3QgYi9Eb2N1bWVudGF0
aW9uL25ldHdvcmtpbmcvZGV2aWNlX2RyaXZlcnMvZXRoZXJuZXQvcGVuc2FuZG8vcGRzX3ZkcGEu
cnN0Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLmQ0MWY2ZGQ2
NmUzZQo+IC0tLSAvZGV2L251bGwKPiArKysgYi9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZGV2
aWNlX2RyaXZlcnMvZXRoZXJuZXQvcGVuc2FuZG8vcGRzX3ZkcGEucnN0Cj4gQEAgLTAsMCArMSw4
NCBAQAo+ICsuLiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsKPiArLi4gbm90ZTog
Y2FuIGJlIGVkaXRlZCBhbmQgdmlld2VkIHdpdGggL3Vzci9iaW4vZm9ybWlrby12aW0KPiArCj4g
Kz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KPiArUENJIHZEUEEgZHJpdmVyIGZvciB0aGUgQU1EL1BlbnNhbmRvKFIpIERTQyBhZGFwdGVy
IGZhbWlseQo+ICs9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Cj4gKwo+ICtBTUQvUGVuc2FuZG8gdkRQQSBWRiBEZXZpY2UgRHJpdmVyCj4g
K0NvcHlyaWdodChjKSAyMDIzIEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYwo+ICsKPiArT3Zl
cnZpZXcKPiArPT09PT09PT0KPiArCj4gK1RoZSBgYHBkc192ZHBhYGAgZHJpdmVyIGlzIGFuIGF1
eGlsaWFyeSBidXMgZHJpdmVyIHRoYXQgc3VwcGxpZXMKPiArYSB2RFBBIGRldmljZSBmb3IgdXNl
IGJ5IHRoZSB2aXJ0aW8gbmV0d29yayBzdGFjay4gIEl0IGlzIHVzZWQgd2l0aAo+ICt0aGUgUGVu
c2FuZG8gVmlydHVhbCBGdW5jdGlvbiBkZXZpY2VzIHRoYXQgb2ZmZXIgdkRQQSBhbmQgdmlydGlv
IHF1ZXVlCj4gK3NlcnZpY2VzLiAgSXQgZGVwZW5kcyBvbiB0aGUgYGBwZHNfY29yZWBgIGRyaXZl
ciBhbmQgaGFyZHdhcmUgZm9yIHRoZSBQRgo+ICthbmQgVkYgUENJIGhhbmRsaW5nIGFzIHdlbGwg
YXMgZm9yIGRldmljZSBjb25maWd1cmF0aW9uIHNlcnZpY2VzLgo+ICsKPiArVXNpbmcgdGhlIGRl
dmljZQo+ICs9PT09PT09PT09PT09PT09Cj4gKwo+ICtUaGUgYGBwZHNfdmRwYWBgIGRldmljZSBp
cyBlbmFibGVkIHZpYSBtdWx0aXBsZSBjb25maWd1cmF0aW9uIHN0ZXBzIGFuZAo+ICtkZXBlbmRz
IG9uIHRoZSBgYHBkc19jb3JlYGAgZHJpdmVyIHRvIGNyZWF0ZSBhbmQgZW5hYmxlIFNSLUlPViBW
aXJ0dWFsCj4gK0Z1bmN0aW9uIGRldmljZXMuCj4gKwo+ICtTaG93biBiZWxvdyBhcmUgdGhlIHN0
ZXBzIHRvIGJpbmQgdGhlIGRyaXZlciB0byBhIFZGIGFuZCBhbHNvIHRvIHRoZQo+ICthc3NvY2lh
dGVkIGF1eGlsaWFyeSBkZXZpY2UgY3JlYXRlZCBieSB0aGUgYGBwZHNfY29yZWBgIGRyaXZlci4K
PiArCj4gKy4uIGNvZGUtYmxvY2s6OiBiYXNoCj4gKwo+ICsgICMhL2Jpbi9iYXNoCj4gKwo+ICsg
IG1vZHByb2JlIHBkc19jb3JlCj4gKyAgbW9kcHJvYmUgdmRwYQo+ICsgIG1vZHByb2JlIHBkc192
ZHBhCj4gKwo+ICsgIFBGX0JERj1gZ3JlcCAtSCAidkRQQS4qMSIgL3N5cy9rZXJuZWwvZGVidWcv
cGRzX2NvcmUvKi92aWZ0eXBlcyB8IGhlYWQgLTEgfCBhd2sgLUYgLyAne3ByaW50ICQ2fSdgCj4g
Kwo+ICsgICMgRW5hYmxlIHZEUEEgVkYgYXV4aWxpYXJ5IGRldmljZShzKSBpbiB0aGUgUEYKPiAr
ICBkZXZsaW5rIGRldiBwYXJhbSBzZXQgcGNpLyRQRl9CREYgbmFtZSBlbmFibGVfdm5ldCB2YWx1
ZSB0cnVlIGNtb2RlIHJ1bnRpbWUKPiArCgpEb2VzIHRoaXMgbWVhbiB3ZSBjYW4ndCBkbyBwZXIg
VkYgY29uZmlndXJhdGlvbiBmb3IgdkRQQSBlbmFibGVtZW50CihlLmcgVkYwIGZvciB2ZHBhIFZG
MSB0byBvdGhlciB0eXBlKT8KClRoYW5rcwoKCj4gKyAgIyBDcmVhdGUgYSBWRiBmb3IgdkRQQSB1
c2UKPiArICBlY2hvIDEgPiAvc3lzL2J1cy9wY2kvZHJpdmVycy9wZHNfY29yZS8kUEZfQkRGL3Ny
aW92X251bXZmcwo+ICsKPiArICAjIEZpbmQgdGhlIHZEUEEgc2VydmljZXMvZGV2aWNlcyBhdmFp
bGFibGUKPiArICBQRFNfVkRQQV9NR01UPWB2ZHBhIG1nbXRkZXYgc2hvdyB8IGdyZXAgdkRQQSB8
IGhlYWQgLTEgfCBjdXQgLWQ6IC1mMWAKPiArCj4gKyAgIyBDcmVhdGUgYSB2RFBBIGRldmljZSBm
b3IgdXNlIGluIHZpcnRpbyBuZXR3b3JrIGNvbmZpZ3VyYXRpb25zCj4gKyAgdmRwYSBkZXYgYWRk
IG5hbWUgdmRwYTEgbWdtdGRldiAkUERTX1ZEUEFfTUdNVCBtYWMgMDA6MTE6MjI6MzM6NDQ6NTUK
PiArCj4gKyAgIyBTZXQgdXAgYW4gZXRoZXJuZXQgaW50ZXJmYWNlIG9uIHRoZSB2ZHBhIGRldmlj
ZQo+ICsgIG1vZHByb2JlIHZpcnRpb192ZHBhCj4gKwo+ICsKPiArCj4gK0VuYWJsaW5nIHRoZSBk
cml2ZXIKPiArPT09PT09PT09PT09PT09PT09PQo+ICsKPiArVGhlIGRyaXZlciBpcyBlbmFibGVk
IHZpYSB0aGUgc3RhbmRhcmQga2VybmVsIGNvbmZpZ3VyYXRpb24gc3lzdGVtLAo+ICt1c2luZyB0
aGUgbWFrZSBjb21tYW5kOjoKPiArCj4gKyAgbWFrZSBvbGRjb25maWcvbWVudWNvbmZpZy9ldGMu
Cj4gKwo+ICtUaGUgZHJpdmVyIGlzIGxvY2F0ZWQgaW4gdGhlIG1lbnUgc3RydWN0dXJlIGF0Ogo+
ICsKPiArICAtPiBEZXZpY2UgRHJpdmVycwo+ICsgICAgLT4gTmV0d29yayBkZXZpY2Ugc3VwcG9y
dCAoTkVUREVWSUNFUyBbPXldKQo+ICsgICAgICAtPiBFdGhlcm5ldCBkcml2ZXIgc3VwcG9ydAo+
ICsgICAgICAgIC0+IFBlbnNhbmRvIGRldmljZXMKPiArICAgICAgICAgIC0+IFBlbnNhbmRvIEV0
aGVybmV0IFBEU19WRFBBIFN1cHBvcnQKPiArCj4gK1N1cHBvcnQKPiArPT09PT09PQo+ICsKPiAr
Rm9yIGdlbmVyYWwgTGludXggbmV0d29ya2luZyBzdXBwb3J0LCBwbGVhc2UgdXNlIHRoZSBuZXRk
ZXYgbWFpbGluZwo+ICtsaXN0LCB3aGljaCBpcyBtb25pdG9yZWQgYnkgUGVuc2FuZG8gcGVyc29u
bmVsOjoKPiArCj4gKyAgbmV0ZGV2QHZnZXIua2VybmVsLm9yZwo+ICsKPiArRm9yIG1vcmUgc3Bl
Y2lmaWMgc3VwcG9ydCBuZWVkcywgcGxlYXNlIHVzZSB0aGUgUGVuc2FuZG8gZHJpdmVyIHN1cHBv
cnQKPiArZW1haWw6Ogo+ICsKPiArICBkcml2ZXJzQHBlbnNhbmRvLmlvCj4gZGlmZiAtLWdpdCBh
L01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKPiBpbmRleCBjYjIxZGNkM2EwMmEuLmRhOTgxYzVi
YzgzMCAxMDA2NDQKPiAtLS0gYS9NQUlOVEFJTkVSUwo+ICsrKyBiL01BSU5UQUlORVJTCj4gQEAg
LTIyMTIwLDYgKzIyMTIwLDEwIEBAIFNORVQgRFBVIFZJUlRJTyBEQVRBIFBBVEggQUNDRUxFUkFU
T1IKPiAgUjogICAgIEFsdmFybyBLYXJzeiA8YWx2YXJvLmthcnN6QHNvbGlkLXJ1bi5jb20+Cj4g
IEY6ICAgICBkcml2ZXJzL3ZkcGEvc29saWRydW4vCj4KPiArUERTIERTQyBWSVJUSU8gREFUQSBQ
QVRIIEFDQ0VMRVJBVE9SCj4gK1I6ICAgICBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25A
YW1kLmNvbT4KPiArRjogICAgIGRyaXZlcnMvdmRwYS9wZHMvCj4gKwo+ICBWSVJUSU8gQkFMTE9P
Tgo+ICBNOiAgICAgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPgo+ICBNOiAg
ICAgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS9LY29uZmlnIGIvZHJpdmVycy92ZHBhL0tjb25maWcKPiBpbmRleCBjZDZhZDky
ZjNmMDUuLmM5MTBjYjExOWMxYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+
ICsrKyBiL2RyaXZlcnMvdmRwYS9LY29uZmlnCj4gQEAgLTExNiw0ICsxMTYsMTIgQEAgY29uZmln
IEFMSUJBQkFfRU5JX1ZEUEEKPiAgICAgICAgICAgVGhpcyBkcml2ZXIgaW5jbHVkZXMgYSBIVyBt
b25pdG9yIGRldmljZSB0aGF0Cj4gICAgICAgICAgIHJlYWRzIGhlYWx0aCB2YWx1ZXMgZnJvbSB0
aGUgRFBVLgo+Cj4gK2NvbmZpZyBQRFNfVkRQQQo+ICsgICAgICAgdHJpc3RhdGUgInZEUEEgZHJp
dmVyIGZvciBBTUQvUGVuc2FuZG8gRFNDIGRldmljZXMiCj4gKyAgICAgICBkZXBlbmRzIG9uIFBE
U19DT1JFCj4gKyAgICAgICBoZWxwCj4gKyAgICAgICAgIFZEUEEgbmV0d29yayBkcml2ZXIgZm9y
IEFNRC9QZW5zYW5kbydzIFBEUyBDb3JlIGRldmljZXMuCj4gKyAgICAgICAgIFdpdGggdGhpcyBk
cml2ZXIsIHRoZSBWaXJ0SU8gZGF0YXBsYW5lIGNhbiBiZQo+ICsgICAgICAgICBvZmZsb2FkZWQg
dG8gYW4gQU1EL1BlbnNhbmRvIERTQyBkZXZpY2UuCj4gKwo+ICBlbmRpZiAjIFZEUEEKPiAtLQo+
IDIuMTcuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
