Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3927AC433E0
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 09:32:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0492222A
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 09:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0492222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 32A1B87085;
	Tue,  5 Jan 2021 09:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bldOi-FJdfJ5; Tue,  5 Jan 2021 09:32:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4260C87058;
	Tue,  5 Jan 2021 09:32:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22F45C0891;
	Tue,  5 Jan 2021 09:32:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E24DC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 121B685C77
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:32:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id orjw-FSNPIGQ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:32:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A9BAF85C52
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609839158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KDRR0z0TUONmOgv9BLItAtpsqP3CgvwXGzYeT1dfz/4=;
 b=bf1xH8KvDnGykQu0C/o3Wa+gXdSmeQFcYlcaHsy7UKFZ3wWKsW8NVIrqmfnthskML+4Pej
 sNg6DlL6L8H9EUHFg1N580QDdsh8XSGcoNJo/j256T2L1c75hmH+DEvALfiCDZN4WZfbaK
 sauM4zdsIybNmTvMS1doiw7j+0Sv1JM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-X9SbBh3RMIqosxb8yBjmxw-1; Tue, 05 Jan 2021 04:32:34 -0500
X-MC-Unique: X9SbBh3RMIqosxb8yBjmxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD97801A9E;
 Tue,  5 Jan 2021 09:32:31 +0000 (UTC)
Received: from [10.72.13.192] (ovpn-13-192.pek2.redhat.com [10.72.13.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFA7C60873;
 Tue,  5 Jan 2021 09:32:20 +0000 (UTC)
Subject: Re: [PATCH netdev 0/5] virtio-net support xdp socket zero copy xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <cover.1609837120.git.xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a67e00af-47fb-4d92-8342-27dc93c8aab9@redhat.com>
Date: Tue, 5 Jan 2021 17:32:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1609837120.git.xuanzhuo@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 open list <linux-kernel@vger.kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, dust.li@linux.alibaba.com,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "open list:XDP SOCKETS \(AF_XDP\)" <bpf@vger.kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 tonylu@linux.alibaba.com, "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

Ck9uIDIwMjEvMS81IOS4i+WNiDU6MTEsIFh1YW4gWmh1byB3cm90ZToKPiBUaGUgZmlyc3QgcGF0
Y2ggbWFkZSBzb21lIGFkanVzdG1lbnRzIHRvIHhzay4KCgpUaGFua3MgYSBsb3QgZm9yIHRoZSB3
b3JrLiBJdCdzIHJhdGhlciBpbnRlcmVzdGluZy4KCgo+Cj4gVGhlIHNlY29uZCBwYXRjaCBpdHNl
bGYgY2FuIGJlIHVzZWQgYXMgYW4gaW5kZXBlbmRlbnQgcGF0Y2ggdG8gc29sdmUgdGhlIHByb2Js
ZW0KPiB0aGF0IFhEUCBtYXkgZmFpbCB0byBsb2FkIHdoZW4gdGhlIG51bWJlciBvZiBxdWV1ZXMg
aXMgaW5zdWZmaWNpZW50LgoKCkl0IHdvdWxkIGJlIGJldHRlciB0byBzZW5kIHRoaXMgYXMgYSBz
ZXBhcmF0ZWQgcGF0Y2guIFNldmVyYWwgcGVvcGxlIAphc2tlZCBmb3IgdGhpcyBiZWZvcmUuCgoK
Pgo+IFRoZSB0aGlyZCB0byBsYXN0IHBhdGNoIGltcGxlbWVudHMgc3VwcG9ydCBmb3IgeHNrIGlu
IHZpcnRpby1uZXQuCj4KPiBBIHByYWN0aWNhbCBwcm9ibGVtIHdpdGggdmlydGlvIGlzIHRoYXQg
dHggaW50ZXJydXB0cyBhcmUgbm90IHZlcnkgcmVsaWFibGUuCj4gVGhlcmUgd2lsbCBhbHdheXMg
YmUgc29tZSBtaXNzaW5nIG9yIGRlbGF5ZWQgdHggaW50ZXJydXB0cy4gU28gSSBzcGVjaWFsbHkg
YWRkZWQKPiBhIHBvaW50IHRpbWVyIHRvIHNvbHZlIHRoaXMgcHJvYmxlbS4gT2YgY291cnNlLCBj
b25zaWRlcmluZyBwZXJmb3JtYW5jZSBpc3N1ZXMsCj4gVGhlIHRpbWVyIG9ubHkgdHJpZ2dlcnMg
d2hlbiB0aGUgcmluZyBvZiB0aGUgbmV0d29yayBjYXJkIGlzIGZ1bGwuCgoKVGhpcyBpcyBzdWIt
b3B0aW1hbC4gV2UgbmVlZCBmaWd1cmUgb3V0IHRoZSByb290IGNhdXNlLiBXZSBkb24ndCBtZWV0
IApzdWNoIGlzc3VlIGJlZm9yZS4KClNldmVyYWwgcXVlc3Rpb25zOgoKLSBpcyB0eCBpbnRlcnJ1
cHQgZW5hYmxlZD8KLSBjYW4geW91IHN0aWxsIHNlZSB0aGUgaXNzdWUgaWYgeW91IGRpc2FibGUg
ZXZlbnQgaW5kZXg/Ci0gd2hhdCdzIGJhY2tlbmQgZGlkIHlvdSB1c2U/IHFlbXUgb3Igdmhvc3Qo
dXNlcik/CgoKPgo+IFJlZ2FyZGluZyB0aGUgaXNzdWUgb2YgdmlydGlvLW5ldCBzdXBwb3J0aW5n
IHhzaydzIHplcm8gY29weSByeCwgSSBhbSBhbHNvCj4gZGV2ZWxvcGluZyBpdCwgYnV0IEkgZm91
bmQgdGhhdCB0aGUgbW9kaWZpY2F0aW9uIG1heSBiZSByZWxhdGl2ZWx5IGxhcmdlLCBzbyBJCj4g
Y29uc2lkZXIgdGhpcyBwYXRjaCBzZXQgdG8gYmUgc2VwYXJhdGVkIGZyb20gdGhlIGNvZGUgcmVs
YXRlZCB0byB4c2sgemVybyBjb3B5Cj4gcnguCgoKVGhhdCdzIGZpbmUsIGJ1dCBhIHF1ZXN0aW9u
IGhlcmUuCgpIb3cgaXMgdGhlIG11bHRpZXVxdWUgYmVpbmcgaGFuZGxlZCBoZXJlLiBJJ20gYXNr
aW5nIHNpbmNlIHRoZXJlJ3Mgbm8gCnByb2dyYW1tYWJsZSBmaWx0ZXJzL2RpcmVjdG9ycyBzdXBw
b3J0IGluIHZpcnRpbyBzcGVjIG5vdy4KClRoYW5rcwoKCj4KPiBYdWFuIFpodW8gKDUpOgo+ICAg
IHhzazogc3VwcG9ydCBnZXQgcGFnZSBmb3IgZHJ2Cj4gICAgdmlydGlvLW5ldDogc3VwcG9ydCBY
RFBfVFggd2hlbiBub3QgbW9yZSBxdWV1ZXMKPiAgICB2aXJ0aW8tbmV0LCB4c2s6IGRpc3Rpbmd1
aXNoIFhEUF9UWCBhbmQgWFNLIFhNSVQgY3R4Cj4gICAgeHNrLCB2aXJ0aW8tbmV0OiBwcmVwYXJl
IGZvciBzdXBwb3J0IHhzawo+ICAgIHZpcnRpby1uZXQsIHhzazogdmlydGlvLW5ldCBzdXBwb3J0
IHhzayB6ZXJvIGNvcHkgdHgKPgo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jICAgIHwgNjQz
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCj4gICBpbmNsdWRl
L2xpbnV4L25ldGRldmljZS5oICAgfCAgIDEgKwo+ICAgaW5jbHVkZS9uZXQveGRwX3NvY2tfZHJ2
LmggIHwgIDEwICsKPiAgIGluY2x1ZGUvbmV0L3hza19idWZmX3Bvb2wuaCB8ICAgMSArCj4gICBu
ZXQveGRwL3hza19idWZmX3Bvb2wuYyAgICAgfCAgMTAgKy0KPiAgIDUgZmlsZXMgY2hhbmdlZCwg
NTk3IGluc2VydGlvbnMoKyksIDY4IGRlbGV0aW9ucygtKQo+Cj4gLS0KPiAxLjguMy4xCj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
