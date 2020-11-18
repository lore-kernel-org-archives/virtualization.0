Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F7DC5519F
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 05:18:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CD824654
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 05:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YooA35dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CD824654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 77D19871AF;
	Wed, 18 Nov 2020 05:18:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lDfFNH6Fm5d3; Wed, 18 Nov 2020 05:18:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9B000871B9;
	Wed, 18 Nov 2020 05:18:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 860BBC0800;
	Wed, 18 Nov 2020 05:18:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADDF7C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 05:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 975A285640
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 05:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hsZpTd5vqGuw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 05:18:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D965E855F6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 05:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605676688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H80xTT/If52xYm2Cf+wqujtNbekMdRf0VklelR0JXkw=;
 b=YooA35dmkhZF5iQxWiV1B57BWDoELuK3jSge7nPeRnGTk5YWQ1d85JpWFM7AWEH2mIzRXz
 uNJHttGsDjSvZKwuhNEt5C5ua9eVIBWu5Z3rCWMkbZ1sW/7qv6l9tP4lLP+oa88m/CaoWM
 HXnOssXv6WSVL/S82Sax08ea76pIlkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-8VjkYBvUMCmWoVECWtCZPw-1; Wed, 18 Nov 2020 00:18:03 -0500
X-MC-Unique: 8VjkYBvUMCmWoVECWtCZPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C87DE804755;
 Wed, 18 Nov 2020 05:18:01 +0000 (UTC)
Received: from [10.72.13.172] (ovpn-13-172.pek2.redhat.com [10.72.13.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B5F860C04;
 Wed, 18 Nov 2020 05:17:51 +0000 (UTC)
Subject: Re: [PATCH 00/10] vhost/qemu: thread per IO SCSI vq
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <20201117164043.GS131917@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bba47572-bec9-794f-5a70-d7f016267022@redhat.com>
Date: Wed, 18 Nov 2020 13:17:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117164043.GS131917@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: fam@euphon.net, linux-scsi@vger.kernel.org, mst@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, pbonzini@redhat.com
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

Ck9uIDIwMjAvMTEvMTgg5LiK5Y2IMTI6NDAsIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToKPiBPbiBU
aHUsIE5vdiAxMiwgMjAyMCBhdCAwNToxODo1OVBNIC0wNjAwLCBNaWtlIENocmlzdGllIHdyb3Rl
Ogo+PiBUaGUgZm9sbG93aW5nIGtlcm5lbCBwYXRjaGVzIHdlcmUgbWFkZSBvdmVyIE1pY2hhZWwn
cyB2aG9zdCBicmFuY2g6Cj4+Cj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L21zdC92aG9zdC5naXQvbG9nLz9oPXZob3N0Cj4+Cj4+IGFuZCB0aGUgdmhv
c3Qtc2NzaSBidWcgZml4IHBhdGNoc2V0Ogo+Pgo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1zY3NpLzIwMjAxMTEyMTcwMDA4LkdCMTU1NTY1M0BzdGVmYW5oYS14MS5sb2NhbGRvbWFp
bi9ULyN0Cj4+Cj4+IEFuZCB0aGUgcWVtdSBwYXRjaCB3YXMgbWFkZSBvdmVyIHRoZSBxZW11IG1h
c3RlciBicmFuY2guCj4+Cj4+IHZob3N0LXNjc2kgY3VycmVudGx5IHN1cHBvcnRzIG11bHRpcGxl
IHF1ZXVlcyB3aXRoIHRoZSBudW1fcXVldWVzCj4+IHNldHRpbmcsIGJ1dCB3ZSBlbmQgdXAgd2l0
aCBhIHNldHVwIHdoZXJlIHRoZSBndWVzdCdzIHNjc2kvYmxvY2sKPj4gbGF5ZXIgY2FuIGRvIGEg
cXVldWUgcGVyIHZDUFUgYW5kIHRoZSBsYXllcnMgYmVsb3cgdmhvc3QgY2FuIGRvCj4+IGEgcXVl
dWUgcGVyIENQVS4gdmhvc3Qtc2NzaSB3aWxsIHRoZW4gZG8gYSBudW1fcXVldWUgdmlydHF1ZXVl
cywKPj4gYnV0IGFsbCBJTyBnZXRzIHNldCBvbiBhbmQgY29tcGxldGVkIG9uIGEgc2luZ2xlIHZo
b3N0LXNjc2kgdGhyZWFkLgo+PiBBZnRlciAyIC0gNCB2cXMgdGhpcyBiZWNvbWVzIGEgYm90dGxl
bmVjay4KPj4KPj4gVGhpcyBwYXRjaHNldCBhbGxvd3MgdXMgdG8gY3JlYXRlIGEgd29ya2VyIHRo
cmVhZCBwZXIgSU8gdnEsIHNvIHdlCj4+IGNhbiBiZXR0ZXIgdXRpbGl6ZSBtdWx0aXBsZSBDUFVz
IHdpdGggdGhlIG11bHRpcGxlIHF1ZXVlcy4gSXQKPj4gaW1wbG1lbnRzIEphc29uJ3Mgc3VnZ2Vz
dGlvbiB0byBjcmVhdGUgdGhlIGluaXRpYWwgd29ya2VyIGxpa2UKPj4gbm9ybWFsLCB0aGVuIGNy
ZWF0ZSB0aGUgZXh0cmEgd29ya2VycyBmb3IgSU8gdnFzIHdpdGggdGhlCj4+IFZIT1NUX1NFVF9W
UklOR19FTkFCTEUgaW9jdGwgY29tbWFuZCBhZGRlZCBpbiB0aGlzIHBhdGNoc2V0Lgo+IEhvdyBk
b2VzIHVzZXJzcGFjZSBmaW5kIG91dCB0aGUgdGlkcyBhbmQgc2V0IHRoZWlyIENQVSBhZmZpbml0
eT8KPgo+IFdoYXQgaXMgdGhlIG1lYW5pbmcgb2YgdGhlIG5ldyBWSE9TVF9TRVRfVlJJTkdfRU5B
QkxFIGlvY3RsPyBJdCBkb2Vzbid0Cj4gcmVhbGx5ICJlbmFibGUiIG9yICJkaXNhYmxlIiB0aGUg
dnEsIHJlcXVlc3RzIGFyZSBwcm9jZXNzZWQgcmVnYXJkbGVzcy4KCgpBY3R1YWxseSBJIHRoaW5r
IGl0IHNob3VsZCBkbyB0aGUgcmVhbCAiZW5hYmxlL2Rpc2FibGUiIHRoYXQgdHJpZXMgdG8gCmZv
bGxvdyB0aGUgdmlydGlvIHNwZWMuCgooRS5nIGJvdGggUENJIGFuZCBNTUlPIGhhdmUgc29tZXRo
aW5nIHNpbWlsYXIpLgoKCj4KPiBUaGUgcHVycG9zZSBvZiB0aGUgaW9jdGwgaXNuJ3QgY2xlYXIg
dG8gbWUgYmVjYXVzZSB0aGUga2VybmVsIGNvdWxkCj4gYXV0b21hdGljYWxseSBjcmVhdGUgMSB0
aHJlYWQgcGVyIHZxIHdpdGhvdXQgYSBuZXcgaW9jdGwuCgoKSXQncyBub3QgbmVjZXNzYXJpbHkg
dG8gY3JlYXRlIG9yIGRlc3Ryb3kga3RocmVhZCBhY2NvcmRpbmcgdG8gClZSSU5HX0VOQUJMRSBi
dXQgY291bGQgYmUgYSBoaW50LgoKCj4gICBPbiB0aGUgb3RoZXIKPiBoYW5kLCBpZiB1c2Vyc3Bh
Y2UgaXMgc3VwcG9zZWQgdG8gY29udHJvbCB3b3JrZXIgdGhyZWFkcyB0aGVuIGEKPiBkaWZmZXJl
bnQgaW50ZXJmYWNlIHdvdWxkIGJlIG1vcmUgcG93ZXJmdWw6Cj4KPiAgICBzdHJ1Y3Qgdmhvc3Rf
dnFfd29ya2VyX2luZm8gewo+ICAgICAgICAvKgo+ICAgICAgICAgKiBUaGUgcGlkIG9mIGFuIGV4
aXN0aW5nIHZob3N0IHdvcmtlciB0aGF0IHRoaXMgdnEgd2lsbCBiZQo+ICAgICAgICAgKiBhc3Np
Z25lZCB0by4gV2hlbiBwaWQgaXMgMCB0aGUgdmlydHF1ZXVlIGlzIGFzc2lnbmVkIHRvIHRoZQo+
ICAgICAgICAgKiBkZWZhdWx0IHZob3N0IHdvcmtlci4gV2hlbiBwaWQgaXMgLTEgYSBuZXcgd29y
a2VyIHRocmVhZCBpcwo+ICAgICAgICAgKiBjcmVhdGVkIGZvciB0aGlzIHZpcnRxdWV1ZS4gV2hl
biBwaWQgaXMgLTIgdGhlIHZpcnRxdWV1ZSdzCj4gICAgICAgICAqIHdvcmtlciB0aHJlYWQgaXMg
dW5jaGFuZ2VkLgo+ICAgICAgICAgKgo+ICAgICAgICAgKiBJZiBhIHZob3N0IHdvcmtlciBubyBs
b25nZXIgaGFzIGFueSB2aXJ0cXVldWVzIGFzc2lnbmVkIHRvIGl0Cj4gICAgICAgICAqIHRoZW4g
aXQgd2lsbCB0ZXJtaW5hdGUuCj4gICAgICAgICAqCj4gICAgICAgICAqIFRoZSBwaWQgb2YgdGhl
IHZob3N0IHdvcmtlciBpcyBzdG9yZWQgdG8gdGhpcyBmaWVsZCB3aGVuIHRoZQo+ICAgICAgICAg
KiBpb2N0bCBjb21wbGV0ZXMgc3VjY2Vzc2Z1bGx5LiBVc2UgcGlkIC0yIHRvIHF1ZXJ5IHRoZSBj
dXJyZW50Cj4gICAgICAgICAqIHZob3N0IHdvcmtlciBwaWQuCj4gICAgICAgICAqLwo+ICAgICAg
ICBfX2tlcm5lbF9waWRfdCBwaWQ7ICAvKiBpbi9vdXQgKi8KPgo+ICAgICAgICAvKiBUaGUgdmly
dHF1ZXVlIGluZGV4Ki8KPiAgICAgICAgdW5zaWduZWQgaW50IHZxX2lkeDsgLyogaW4gKi8KPiAg
ICB9Owo+Cj4gICAgaW9jdGwodmhvc3RfZmQsIFZIT1NUX1NFVF9WUV9XT1JLRVIsICZpbmZvKTsK
CgpUaGlzIHNlZW1zIHRvIGxlYXZlIHRoZSBxdWVzdGlvbiB0byB1c2Vyc3BhY2Ugd2hpY2ggSSdt
IG5vdCBzdXJlIGl0J3MgCmdvb2Qgc2luY2UgaXQgdHJpZXMgdG8gaW50cm9kdWNlIGFub3RoZXIg
c2NoZWR1bGluZyBsYXllci4KClBlciB2cSB3b3JrZXIgc2VlbXMgYmUgZ29vZCBlbm91Z2ggdG8g
c3RhcnQgd2l0aC4KClRoYW5rcwoKCj4KPiBTdGVmYW4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
