Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227AEC433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Jul 2022 09:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A05266113B;
	Tue, 12 Jul 2022 09:20:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A05266113B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rm8hpNLv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kjNhx99cb2Qr; Tue, 12 Jul 2022 09:20:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0D1F96110C;
	Tue, 12 Jul 2022 09:20:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D1F96110C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2A4FC0035;
	Tue, 12 Jul 2022 09:20:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 352B2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 09:20:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D66742286
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 09:20:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D66742286
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rm8hpNLv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tNaauidqWzCO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 09:20:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DA9C42266
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0DA9C42266
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 09:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657617639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYz6sQFrLTtNwewKdjTQqPfTJGeybAAsk7vYVyjO6GM=;
 b=Rm8hpNLvSmExrp4j/s2dxSbuGzBKO813eGorUD//v1OUnruj8Ot/MDJNt0OZMLTxgj3AVF
 4AqkmffEwiFG+0WoFFJuRb6AGvEks2bhyqyDgXg7VbcYQqdNGxEc97ThyDu1+V44d6Yk6K
 ewUo0B7rdcy9q08Jo4NO8jxJlDBV0XY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-gttbMDIUNpOY1gL7Um3CYw-1; Tue, 12 Jul 2022 05:20:37 -0400
X-MC-Unique: gttbMDIUNpOY1gL7Um3CYw-1
Received: by mail-wm1-f70.google.com with SMTP id
 h65-20020a1c2144000000b003a2cf5b5aabso5345074wmh.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 02:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=LYz6sQFrLTtNwewKdjTQqPfTJGeybAAsk7vYVyjO6GM=;
 b=dQpSGXcBmcCGTY9eTq7SCUKLllm7CzoUBGN/1bKahIVv79bPLPYnKD1/ulSZsLXAd5
 WJ4AOmfHcNTtBTbinXXikkR85WVylejQlS5xLPIW3iAYIBbNVg236qJTm9fekGTTBqHZ
 r3YabnFswTUlDD0pglVKcxWHGrY7Iz+w68WTWAUSoCGrEXJpxwdEA2uuDxqPzp4vGFA0
 aAIOCkellLKizJs8SDAzFD2XgkevXE26J5wpzwoL3boUQZKFpi02DtSHnaKaw9R8NKh5
 S0G7DblzcBAi/fMz4WVnrFEiwLLoa5BDQ861uxDdEvJWgGwXjvW5f6LVE7+LBGWs2aWs
 qS2Q==
X-Gm-Message-State: AJIora905j4qP9TL61+grPaKNGbZaTjr6T+7hZEr3Ro9ihYSFns3pL1Y
 ghWVnho6HwDNyhqfH5QDvy94Nm5pJciNIlb7GbP6n+st7eTQRfhgqq/MWh8G5QH61w+z9gDTfdw
 XPFGOoiSHCqIoJtZ2N7z6C6jib1eaIuYEgL0p4AgoYA==
X-Received: by 2002:a05:600c:3b1d:b0:3a2:60a1:fe6a with SMTP id
 m29-20020a05600c3b1d00b003a260a1fe6amr2641725wms.3.1657617636569; 
 Tue, 12 Jul 2022 02:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9RDSlegIwgOcJ6F20tlQ2lBcbr65X6+YRs7b+2BnymUAXBnm75D8yNy2Zv/ziWoZOQkGE5Q==
X-Received: by 2002:a05:600c:3b1d:b0:3a2:60a1:fe6a with SMTP id
 m29-20020a05600c3b1d00b003a260a1fe6amr2641714wms.3.1657617636417; 
 Tue, 12 Jul 2022 02:20:36 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 j40-20020a05600c48a800b003a2e278510csm8027518wmp.15.2022.07.12.02.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jul 2022 02:20:35 -0700 (PDT)
Date: Tue, 12 Jul 2022 11:20:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 0/6] virtio_test: add support for vhost-vdpa
Message-ID: <20220712092033.637dwixetnaujg6y@sgarzare-redhat>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <a94ec2f5-8728-d62a-072e-407fbe59eb61@redhat.com>
 <20220712084544.lgtggj44ihlkfsb3@sgarzare-redhat>
 <CACGkMEtHg_EVYcS=Qxsmwq3t+96E8LNqa5Ck1Gi4hJs2AJ0F+Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtHg_EVYcS=Qxsmwq3t+96E8LNqa5Ck1Gi4hJs2AJ0F+Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBKdWwgMTIsIDIwMjIgYXQgMDQ6NDc6MTBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPk9uIFR1ZSwgSnVsIDEyLCAyMDIyIGF0IDQ6NDYgUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxz
Z2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPj4KPj4gT24gVHVlLCBKdWwgMTIsIDIwMjIgYXQg
MDQ6MzQ6MTFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gPgo+PiA+5ZyoIDIwMjIvNy81
IDAxOjE2LCBTdGVmYW5vIEdhcnphcmVsbGEg5YaZ6YGTOgo+PiA+PlRoZSBmaXJzdCAzIHBhdGNo
ZXMgZml4IHZhcmlvdXMgcHJvYmxlbXMgSSBoYXZlIGVuY291bnRlcmVkIHdpdGgKPj4gPj52aXJ0
aW9fdGVzdCAodGhleSBtYXkgZ28gd2l0aG91dCB0aGlzIHNlcmllcywgYnV0IEkgaW5jbHVkZWQg
dG8gYWxsb3cgeW91Cj4+ID4+dG8gdGVzdCB0aGUgc2VyaWVzKS4KPj4gPj4KPj4gPj5QYXRjaCA0
IGlzIGluIHByZXBhcmF0aW9uIG9mIHBhdGNoIDUsIG1vdmluZyB0aGUgZmVhdHVyZSBuZWdvdGlh
dGlvbiB3aGVuCj4+ID4+d2UgaW5pdGlhbGl6ZSB0aGUgZGV2aWNlLgo+PiA+Pgo+PiA+PlBhdGNo
IDUgYWRkIHRoZSBzdXBwb3J0IG9mIHZob3N0LXZkcGEgaW4gdmlydGlvX3Rlc3QKPj4gPj4KPj4g
Pj5QYXRjaCA2IGFkZCB2ZHBhX3Rlc3Qua28gYmFzZWQgb24gdmRwYV9zaW1fdGVzdC5jLCBzbyB3
ZSBjYW4gcmV1c2UgbW9zdCBvZgo+PiA+PnRoZSBjb2RlIGNvbWluZyBmcm9tIHRoZSB2ZHBhX3Np
bSBmcmFtZXdvcmsuCj4+ID4+Cj4+ID4+SSB0ZXN0ZWQgaW4gdGhpcyB3YXk6Cj4+ID4+Cj4+ID4+
ICAgJCBtb2Rwcm9iZSB2ZHBhX3NpbQo+PiA+PiAgICQgbW9kcHJvYmUgdmhvc3QtdmRwYQo+PiA+
Pgo+PiA+PiAgICMgbG9hZCB0aGUgdmRwYXNpbV90ZXN0IGRldmljZQo+PiA+PiAgICQgaW5zbW9k
IHZkcGFfdGVzdC5rbwo+PiA+Pgo+PiA+PiAgICMgY3JlYXRlIGEgbmV3IHZkcGFzaW1fdGVzdCBk
ZXZpY2UKPj4gPj4gICAkIHZkcGEgZGV2IGFkZCBtZ210ZGV2IHZkcGFzaW1fdGVzdCBuYW1lIGRl
djAKPj4gPgo+PiA+Cj4+ID5JIHdvbmRlciB3aGF0J3MgdGhlIGJlbmVmaXQgb2YgdXNpbmcgYSBk
ZWRpY2F0ZWQgdGVzdCBkZXZpY2Ugb3RoZXIKPj4gPnRoYW4gbmV0d29ya2luZz8gKGFscmVhZHkg
YSBsb29wYmFjayBkZXZpY2UgYW55aG93KS4KPj4gPgo+Pgo+PiBUaGUgbWFpbiBhZHZhbnRhZ2Ug
SSB3YXMgdGhpbmtpbmcgaXMgdGhhdCB3ZSBjYW4gZXh0ZW5kIGl0IGF0IHdpbGwgdG8KPj4gdHJ5
IHRvIGNvdmVyIGFzIG11Y2ggYXMgcG9zc2libGUgYWxsIHRoZSBwYXRocyB0aGF0IG1heWJlIHdp
dGggbmV0IHdlCj4+IGNhbid0IChpbmRpcmVjdCwgcmVzZXQsIGV0Yy4pLgo+Pgo+PiBQbHVzIGl0
IHNob3VsZCBiZSBlYXNpZXIgdG8gdGVzdCB2aG9zdC12ZHBhIHRoaXMgd2F5IHdpdGhvdXQgdXNp
bmcgUUVNVS4KPj4KPj4gRG8geW91IHRoaW5rIHRoaXMgaXMgcmVkdW5kYW50Pwo+Cj5JdCdzIHBy
b2JhYmx5IGZpbmUgYW5kIGl0IG1pZ2h0IGJlIGJldHRlciB0byBkZXNjcmliZSB0aGUgcmVhc29u
IGluCj50aGUgY2hhbmdlbG9nLgoKT2theSwgSSdsbCBkbyBpbiB0aGUgbmV4dCB2ZXJzaW9uIQoK
VGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
