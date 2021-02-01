Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17BFC433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 05:47:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719EC64E15
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 05:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719EC64E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 44CBE86079;
	Mon,  1 Feb 2021 05:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zxHNjXXJ6WQT; Mon,  1 Feb 2021 05:47:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A1E0386004;
	Mon,  1 Feb 2021 05:47:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A2E5C0FA7;
	Mon,  1 Feb 2021 05:47:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48AECC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3781586E88
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:47:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yYraFtYwgN9g
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:47:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 63A7B86E6E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612158444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzygt8PY+ejYaTw5CY3AQHjM5FXiYjRfhZf967nzudg=;
 b=SWFLYXp72ryDvICUj5W0M0Qpwdv29K3Fa7hVkDhQ+/y2CokQuEdx5dBCgbv8d3npeqaOLf
 y8u92MDeApRwkui/ro/5DYvLD1PAPJiIQ8LnXPMseQnSbmDtJaEfQI2ZtF2bMLQd39zxRI
 ZkI6esNzzG5/Tgs6SNqCNKNfp0O8bSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-adswYuZvO16IX_bbRm2ArQ-1; Mon, 01 Feb 2021 00:47:20 -0500
X-MC-Unique: adswYuZvO16IX_bbRm2ArQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7405E425D2;
 Mon,  1 Feb 2021 05:47:19 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67DC563BB8;
 Mon,  1 Feb 2021 05:47:10 +0000 (UTC)
Subject: Re: [PATCH RFC v2 06/10] vdpa_sim: cleanup kiovs in vdpasim_free()
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-7-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9a7051ae-8ae4-7d17-f662-fe8448606e34@redhat.com>
Date: Mon, 1 Feb 2021 13:47:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128144127.113245-7-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Ck9uIDIwMjEvMS8yOCDkuIvljYgxMDo0MSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IHZy
aW5naF9nZXRkZXNjX2lvdGxiKCkgYWxsb2NhdGVzIG1lbW9yeSB0byBzdG9yZSB0aGUga3ZlYywg
dGhhdAo+IGlzIGZyZWVkIHdpdGggdnJpbmdoX2tpb3ZfY2xlYW51cCgpLgo+Cj4gdnJpbmdoX2dl
dGRlc2NfaW90bGIoKSBpcyBhYmxlIHRvIHJldXNlIGEga3ZlYyBwcmV2aW91c2x5IGFsbG9jYXRl
ZCwKPiBzbyBpbiBvcmRlciB0byBhdm9pZCB0byBhbGxvY2F0ZSB0aGUga3ZlYyBmb3IgZWFjaCBy
ZXF1ZXN0LCB3ZSBhcmUKPiBub3QgY2FsbGluZyB2cmluZ2hfa2lvdl9jbGVhbnVwKCkgd2hlbiB3
ZSBmaW5pc2hlZCB0byBoYW5kbGUgYQo+IHJlcXVlc3QsIGJ1dCB3ZSBzaG91bGQgY2FsbCBpdCB3
aGVuIHdlIGZyZWUgdGhlIGVudGlyZSBkZXZpY2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5v
IEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92
ZHBhX3NpbS5jIHwgNyArKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IGluZGV4IDUzMjM4OTg5NzEzZC4uYTdhZWI1
ZDAxYzNlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4g
KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBAQCAtNTYyLDggKzU2Miwx
NSBAQCBzdGF0aWMgaW50IHZkcGFzaW1fZG1hX3VubWFwKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRw
YSwgdTY0IGlvdmEsIHU2NCBzaXplKQo+ICAgc3RhdGljIHZvaWQgdmRwYXNpbV9mcmVlKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRwYSkKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9
IHZkcGFfdG9fc2ltKHZkcGEpOwo+ICsJaW50IGk7Cj4gICAKPiAgIAljYW5jZWxfd29ya19zeW5j
KCZ2ZHBhc2ltLT53b3JrKTsKPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwgdmRwYXNpbS0+ZGV2X2F0
dHIubnZxczsgaSsrKSB7Cj4gKwkJdnJpbmdoX2tpb3ZfY2xlYW51cCgmdmRwYXNpbS0+dnFzW2ld
Lm91dF9pb3YpOwo+ICsJCXZyaW5naF9raW92X2NsZWFudXAoJnZkcGFzaW0tPnZxc1tpXS5pbl9p
b3YpOwo+ICsJfQo+ICsKPiAgIAlwdXRfaW92YV9kb21haW4oJnZkcGFzaW0tPmlvdmEpOwo+ICAg
CWlvdmFfY2FjaGVfcHV0KCk7Cj4gICAJa3ZmcmVlKHZkcGFzaW0tPmJ1ZmZlcik7CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
