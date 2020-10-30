Return-Path: <SRS0=7x/u=EF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F05C4363A
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 11:45:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489852076E
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 11:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEecZhC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489852076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AAB6286250;
	Fri, 30 Oct 2020 11:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ukCh5uPpBC0b; Fri, 30 Oct 2020 11:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0337785EBE;
	Fri, 30 Oct 2020 11:45:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7E3EC0859;
	Fri, 30 Oct 2020 11:45:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7E53C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 11:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D05FB860AD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 11:45:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sqb9odQ6PQaP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 11:45:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 24E0D85EBE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604058298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMzfcfElqXmYjTtD+miGi6l1YpfMLIM07gwUkJW1Ka4=;
 b=NEecZhC7KZ2JR9DGrtaHbi8GthTPa6bKjljhcAjBJrXk+zDPYS4rU5XHPt+B0h5r35II/6
 LFGIjj+AZz5rY2+RIn/0QBANSwTre7PbGZP+186BxdxgPuFi3UjDPgH2eAI0RXNwfN3cR+
 /hADoIr6WLVLzPpssK7cn0eHr+IK8aw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-3sQS_sVaMLePpUqD5ntZlw-1; Fri, 30 Oct 2020 07:44:55 -0400
X-MC-Unique: 3sQS_sVaMLePpUqD5ntZlw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B6F01017DD0;
 Fri, 30 Oct 2020 11:44:54 +0000 (UTC)
Received: from [10.72.12.248] (ovpn-12-248.pek2.redhat.com [10.72.12.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 820275CC26;
 Fri, 30 Oct 2020 11:44:45 +0000 (UTC)
Subject: Re: [PATCH] vhost/vsock: add IOTLB API support
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20201029174351.134173-1-sgarzare@redhat.com>
 <751cc074-ae68-72c8-71de-a42458058761@redhat.com>
 <20201030105422.ju2aj2bmwsckdufh@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <278f4732-e561-2b4f-03ee-b26455760b01@redhat.com>
Date: Fri, 30 Oct 2020 19:44:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030105422.ju2aj2bmwsckdufh@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

Ck9uIDIwMjAvMTAvMzAg5LiL5Y2INjo1NCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IE9u
IEZyaSwgT2N0IDMwLCAyMDIwIGF0IDA2OjAyOjE4UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Cj4+IE9uIDIwMjAvMTAvMzAg5LiK5Y2IMTo0MywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+Pj4gVGhpcyBwYXRjaCBlbmFibGVzIHRoZSBJT1RMQiBBUEkgc3VwcG9ydCBmb3Igdmhvc3Qt
dnNvY2sgZGV2aWNlcywKPj4+IGFsbG93aW5nIHRoZSB1c2Vyc3BhY2UgdG8gZW11bGF0ZSBhbiBJ
T01NVSBmb3IgdGhlIGd1ZXN0Lgo+Pj4KPj4+IFRoZXNlIGNoYW5nZXMgd2VyZSBtYWRlIGZvbGxv
d2luZyB2aG9zdC1uZXQsIGluIGRldGFpbHMgdGhpcyBwYXRjaDoKPj4+IC0gZXhwb3NlcyBWSVJU
SU9fRl9BQ0NFU1NfUExBVEZPUk0gZmVhdHVyZSBhbmQgaW5pdHMgdGhlIGlvdGxiCj4+PiDCoCBk
ZXZpY2UgaWYgdGhlIGZlYXR1cmUgaXMgYWNrZWQKPj4+IC0gaW1wbGVtZW50cyBWSE9TVF9HRVRf
QkFDS0VORF9GRUFUVVJFUyBhbmQKPj4+IMKgIFZIT1NUX1NFVF9CQUNLRU5EX0ZFQVRVUkVTIGlv
Y3Rscwo+Pj4gLSBjYWxscyB2cV9tZXRhX3ByZWZldGNoKCkgYmVmb3JlIHZxIHByb2Nlc3Npbmcg
dG8gcHJlZmV0Y2ggdnEKPj4+IMKgIG1ldGFkYXRhIGFkZHJlc3MgaW4gSU9UTEIKPj4+IC0gcHJv
dmlkZXMgLnJlYWRfaXRlciwgLndyaXRlX2l0ZXIsIGFuZCAucG9sbCBjYWxsYmFja3MgZm9yIHRo
ZQo+Pj4gwqAgY2hhcmRldjsgdGhleSBhcmUgdXNlZCBieSB0aGUgdXNlcnNwYWNlIHRvIGV4Y2hh
bmdlIElPVExCIG1lc3NhZ2VzCj4+Pgo+Pj4gVGhpcyBwYXRjaCB3YXMgdGVzdGVkIHdpdGggUUVN
VSBhbmQgYSBwYXRjaCBhcHBsaWVkIFsxXSB0byBmaXggYQo+Pj4gc2ltcGxlIGlzc3VlOgo+Pj4g
wqDCoMKgICQgcWVtdSAtTSBxMzUsYWNjZWw9a3ZtLGtlcm5lbC1pcnFjaGlwPXNwbGl0IFwKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC1kcml2ZSBmaWxlPWZlZG9yYS5xY293Mixmb3JtYXQ9cWNv
dzIsaWY9dmlydGlvIFwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC1kZXZpY2UgaW50ZWwtaW9t
bXUsaW50cmVtYXA9b24gXAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLWRldmljZSB2aG9zdC12
c29jay1wY2ksZ3Vlc3QtY2lkPTMsaW9tbXVfcGxhdGZvcm09b24KPj4KPj4KPj4gUGF0Y2ggbG9v
a3MgZ29vZCwgYnV0IGEgcXVlc3Rpb246Cj4+Cj4+IEl0IGxvb2tzIHRvIG1lIHlvdSBkb24ndCBl
bmFibGUgQVRTIHdoaWNoIG1lYW5zIHZob3N0IHdvbid0IGdldCBhbnkgCj4+IGludmFsaWRhdGlv
biByZXF1ZXN0IG9yIGRpZCBJIG1pc3MgYW55dGhpbmc/Cj4+Cj4KPiBZb3UncmUgcmlnaHQsIEkg
ZGlkbid0IHNlZSBpbnZhbGlkYXRpb24gcmVxdWVzdHMsIG9ubHkgbWlzcyBhbmQgdXBkYXRlcy4K
PiBOb3cgSSBoYXZlIHRyaWVkIHRvIGVuYWJsZSAnYXRzJyBhbmQgJ2RldmljZS1pb3RsYicgYnV0
IEkgc3RpbGwgZG9uJ3QgCj4gc2VlIGFueSBpbnZhbGlkYXRpb24uCj4KPiBIb3cgY2FuIEkgdGVz
dCBpdD8gKFNvcnJ5IGJ1dCBJIGRvbid0IGhhdmUgbXVjaCBleHBlcmllbmNlIHlldCB3aXRoIAo+
IHZJT01NVSkKCgpJIGd1ZXNzIGl0J3MgYmVjYXVzZSB0aGUgYmF0Y2hlZCB1bm1hcC4gTWF5YmUg
eW91IGNhbiB0cnkgdG8gdXNlIAoiaW50ZWxfaW9tbXU9c3RyaWN0IiBpbiBndWVzdCBrZXJuZWwg
Y29tbWFuZCBsaW5lIHRvIHNlZSBpZiBpdCB3b3Jrcy4KCkJ0dywgbWFrZSBzdXJlIHRoZSBxZW11
IGNvbnRhaW5zIHRoZSBwYXRjaCBbMV0uIE90aGVyd2lzZSBBVFMgd29uJ3QgYmUgCmVuYWJsZWQg
Zm9yIHJlY2VudCBMaW51eCBLZXJuZWwgaW4gdGhlIGd1ZXN0LgoKVGhhbmtzCgpbMV0gaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9RRU1VLzIwMjAwOTA5MDgxNzMxLjI0Njg4LTEtamFzb3dhbmdAcmVkaGF0
LmNvbS8KCj4KPiBUaGFua3MsCj4gU3RlZmFubwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
