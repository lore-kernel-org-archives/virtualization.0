Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714AEC46467
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 09:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E67EF81357;
	Tue, 27 Dec 2022 09:38:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E67EF81357
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGXHCX7/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wZTrmgqtR1Ys; Tue, 27 Dec 2022 09:38:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F4B181340;
	Tue, 27 Dec 2022 09:38:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F4B181340
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55EF2C0035;
	Tue, 27 Dec 2022 09:38:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64224C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AAA781342
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:38:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AAA781342
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XsQx7zXJR07m
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:38:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6473481340
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6473481340
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672133912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3BLtHqoydlVUf+z9Cs67tPhoqV/CQzv2c7yUWqYhoE=;
 b=FGXHCX7/J1P9lPs3V0pXOwU6ADXhRDfzVKrgxBwG4hveR07PHhDR2n8DN7kxtUr1ke64HC
 qZOI+aIAz5ABo0I3n2MANhvg81l3LHXSeBZLjNHTRGjIoIjedJK7v4pSQAlyKsAQrbT4/n
 vEXJVRbQ7SroHB8Gefiv7lKINgVVUW8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-441-J3gzfKQ3PS65zgb2AndKcA-1; Tue, 27 Dec 2022 04:38:30 -0500
X-MC-Unique: J3gzfKQ3PS65zgb2AndKcA-1
Received: by mail-ed1-f72.google.com with SMTP id
 g14-20020a056402090e00b0046790cd9082so9059666edz.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 01:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J3BLtHqoydlVUf+z9Cs67tPhoqV/CQzv2c7yUWqYhoE=;
 b=dxgR8jM53AW6irRM4jdAgoqnn0A8yrqviisWlSFSAqKjWgpNMccg+TG0Q8l84c1J72
 rlb56d81myOMCcPXnvWm0Pu71mJXCvB47oASGAIXxjXBI+BvyalfhNZd5VHby26yO1qA
 gIn/QbITmMUton0f+MbQJgjyspkCvPtStrwtbw0epVVmYWKSDO8VUbUWoOt+IA+wyUCT
 peuDHT+dx6ryw0hiufetoocVcjJvla8TKkZxoFrdH6bClHJChKOHtQOXBKBg/b6mEiqd
 B5oPZGZ/033P7BhQQnizVc9xC70QtSMvdxFc42GiEZFzX8CDOSbv2scgQ9z0MtE2PTvq
 y0Cg==
X-Gm-Message-State: AFqh2kppLQcJWMWM/ydXQVAo0iINplITp616UTNbAgpW4AtX+cs77Yyw
 GdQLioi5SrK0dN5HIW1aEVDCUsppInazLbTuGpsenuXMNjs5aeYSgeAFmK/jNi8exm4gSZPS9uW
 SZ1Z1NjUryVwpIstgpUBchuaqs0EIw5guNMJYnw9Gsw==
X-Received: by 2002:a17:907:7f04:b0:7c1:36:9002 with SMTP id
 qf4-20020a1709077f0400b007c100369002mr21415463ejc.67.1672133909663; 
 Tue, 27 Dec 2022 01:38:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu1izE+/u+Tuwf8tjP2vCdjI4kLYsk008OtSrOIXpnLKNcCpaysWJW9Xx5P3ns02pTzhv/LQg==
X-Received: by 2002:a17:907:7f04:b0:7c1:36:9002 with SMTP id
 qf4-20020a1709077f0400b007c100369002mr21415444ejc.67.1672133909480; 
 Tue, 27 Dec 2022 01:38:29 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 9-20020a170906218900b007c4fbb79535sm5873901eju.82.2022.12.27.01.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Dec 2022 01:38:28 -0800 (PST)
Date: Tue, 27 Dec 2022 04:38:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20221227043148-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
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

T24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMDU6MTI6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMi8xMi8yNyAxNTozMywgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoK
PiA+IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDEyOjMwOjM1UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+ID4gQnV0IGRldmljZSBpcyBzdGlsbCBnb2luZyBhbmQgd2lsbCBsYXRlciB1
c2UgdGhlIGJ1ZmZlcnMuCj4gPiA+ID4gCj4gPiA+ID4gU2FtZSBmb3IgdGltZW91dCByZWFsbHku
Cj4gPiA+IEF2b2lkaW5nIGluZmluaXRlIHdhaXQvcG9sbCBpcyBvbmUgb2YgdGhlIGdvYWxzLCBh
bm90aGVyIGlzIHRvIHNsZWVwLgo+ID4gPiBJZiB3ZSB0aGluayB0aGUgdGltZW91dCBpcyBoYXJk
LCB3ZSBjYW4gc3RhcnQgZnJvbSB0aGUgd2FpdC4KPiA+ID4gCj4gPiA+IFRoYW5rcwo+ID4gSWYg
dGhlIGdvYWwgaXMgdG8gYXZvaWQgZGlzcnVwdGluZyB0cmFmZmljIHdoaWxlIENWUSBpcyBpbiB1
c2UsCj4gPiB0aGF0IHNvdW5kcyBtb3JlIHJlYXNvbmFibGUuIEUuZy4gc29tZW9uZSBpcyB0dXJu
aW5nIG9uIHByb21pc2MsCj4gPiBhIHNwaWtlIGluIENQVSB1c2FnZSBtaWdodCBiZSB1bndlbGNv
bWUuCj4gCj4gCj4gWWVzLCB0aGlzIHdvdWxkIGJlIG1vcmUgb2J2aW91cyBpcyBVUCBpcyB1c2Vk
Lgo+IAo+IAo+ID4gCj4gPiB0aGluZ3Mgd2Ugc2hvdWxkIGJlIGNhcmVmdWwgdG8gYWRkcmVzcyB0
aGVuOgo+ID4gMS0gZGVidWdnaW5nLiBDdXJyZW50bHkgaXQncyBlYXN5IHRvIHNlZSBhIHdhcm5p
bmcgaWYgQ1BVIGlzIHN0dWNrCj4gPiAgICAgaW4gYSBsb29wIGZvciBhIHdoaWxlLCBhbmQgd2Ug
YWxzbyBnZXQgYSBiYWNrdHJhY2UuCj4gPiAgICAgRS5nLiB3aXRoIHRoaXMgLSBob3cgZG8gd2Ug
a25vdyB3aG8gaGFzIHRoZSBSVE5MPwo+ID4gICAgIFdlIG5lZWQgdG8gaW50ZWdyYXRlIHdpdGgg
a2VybmVsL3dhdGNoZG9nLmMgZm9yIGdvb2QgcmVzdWx0cwo+ID4gICAgIGFuZCB0byBtYWtlIHN1
cmUgcG9saWN5IGlzIGNvbnNpc3RlbnQuCj4gCj4gCj4gVGhhdCdzIGZpbmUsIHdpbGwgY29uc2lk
ZXIgdGhpcy4KPiAKPiAKPiA+IDItIG92ZXJoZWFkLiBJbiBhIHZlcnkgY29tbW9uIHNjZW5hcmlv
IHdoZW4gZGV2aWNlIGlzIGluIGh5cGVydmlzb3IsCj4gPiAgICAgcHJvZ3JhbW1pbmcgdGltZXJz
IGV0YyBoYXMgYSB2ZXJ5IGhpZ2ggb3ZlcmhlYWQsIGF0IGJvb3R1cAo+ID4gICAgIGxvdHMgb2Yg
Q1ZRIGNvbW1hbmRzIGFyZSBydW4gYW5kIHNsb3dpbmcgYm9vdCBkb3duIGlzIG5vdCBuaWNlLgo+
ID4gICAgIGxldCdzIHBvbGwgZm9yIGEgYml0IGJlZm9yZSB3YWl0aW5nPwo+IAo+IAo+IFRoZW4g
d2UgZ28gYmFjayB0byB0aGUgcXVlc3Rpb24gb2YgY2hvb3NpbmcgYSBnb29kIHRpbWVvdXQgZm9y
IHBvbGwuIEFuZAo+IHBvbGwgc2VlbXMgcHJvYmxlbWF0aWMgaW4gdGhlIGNhc2Ugb2YgVVAsIHNj
aGVkdWxlciBtaWdodCBub3QgaGF2ZSB0aGUKPiBjaGFuY2UgdG8gcnVuLgoKUG9sbCBqdXN0IGEg
Yml0IDopIFNlcmlvdXNseSBJIGRvbid0IGtub3csIGJ1dCBhdCBsZWFzdCBjaGVjayBvbmNlCmFm
dGVyIGtpY2suCgo+IAo+ID4gMy0gc3VwcmlzZSByZW1vdmFsLiBuZWVkIHRvIHdha2UgdXAgdGhy
ZWFkIGluIHNvbWUgd2F5LiB3aGF0IGFib3V0Cj4gPiAgICAgb3RoZXIgY2FzZXMgb2YgZGV2aWNl
IGJyZWFrYWdlIC0gaXMgdGhlcmUgYSBjaGFuY2UgdGhpcwo+ID4gICAgIGludHJvZHVjZXMgbmV3
IGJ1Z3MgYXJvdW5kIHRoYXQ/IGF0IGxlYXN0IGVudW1lcmF0ZSB0aGVtIHBsZWFzZS4KPiAKPiAK
PiBUaGUgY3VycmVudCBjb2RlIGRpZDoKPiAKPiAxKSBjaGVjayBmb3IgdnEtPmJyb2tlbgo+IDIp
IHdha2V1cCBkdXJpbmcgQkFEX1JJTkcoKQo+IAo+IFNvIHdlIHdvbid0IGVuZCB1cCB3aXRoIGEg
bmV2ZXIgd29rZSB1cCBwcm9jZXNzIHdoaWNoIHNob3VsZCBiZSBmaW5lLgo+IAo+IFRoYW5rcwoK
CkJUVyBCQURfUklORyBvbiByZW1vdmFsIHdpbGwgdHJpZ2dlciBkZXZfZXJyLiBOb3Qgc3VyZSB0
aGF0IGlzIGEgZ29vZAppZGVhIC0gY2FuIGNhdXNlIGNyYXNoZXMgaWYga2VybmVsIHBhbmljcyBv
biBlcnJvci4KCj4gCj4gPiAKPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
