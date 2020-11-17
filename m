Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEE4C388F9
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 02:30:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5522D246A3
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 02:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1bcZiRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5522D246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF364870D2;
	Tue, 17 Nov 2020 02:30:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zm3rxRQfvFuW; Tue, 17 Nov 2020 02:30:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 27973870C7;
	Tue, 17 Nov 2020 02:30:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05D7AC0800;
	Tue, 17 Nov 2020 02:30:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D8FDC07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 02:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4BF7E870C4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 02:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4eXMJpm5TqYv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 02:30:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 12F52870C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 02:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605580205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmZ1mGxlAVYrel/KK7OgqUxp4N3oZUIGmB1egO/JG/0=;
 b=W1bcZiRuFYzkNidavFq+0znMaIfQfhmnH5Y3OeCS9iLhrqI8vZzh7XbeULemi9hIdHS/dv
 is432aE2lxmPW1rZtJXkGnlrcn9wiwHGrVhfX2btWxFyBraP9O9UHAgjUrHJvGRAkmRCqL
 w1BN8RiIqEGWWx5IPWiT5oRIEA2605E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-M2lvSCNmNwiLwy4MuK1gcQ-1; Mon, 16 Nov 2020 21:30:03 -0500
X-MC-Unique: M2lvSCNmNwiLwy4MuK1gcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91968107ACF5;
 Tue, 17 Nov 2020 02:30:02 +0000 (UTC)
Received: from [10.72.13.201] (ovpn-13-201.pek2.redhat.com [10.72.13.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B214760C04;
 Tue, 17 Nov 2020 02:29:57 +0000 (UTC)
Subject: Re: [PATCH] vringh: fix vringh_iov_push_*() documentation
To: Stefano Garzarella <sgarzare@redhat.com>, mst@redhat.com
References: <20201116161653.102904-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3aa02874-1c7f-d516-b80b-c79b33c0b1fd@redhat.com>
Date: Tue, 17 Nov 2020 10:29:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116161653.102904-1-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTEvMTcg5LiK5Y2IMTI6MTYsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiB2
cmluZ2hfaW92X3B1c2hfKigpIGZ1bmN0aW9ucyBkb24ndCBoYXZlICdkc3QnIHBhcmFtZXRlciwg
YnV0IGhhdmUKPiB0aGUgJ3NyYycgcGFyYW1ldGVyLgo+Cj4gUmVwbGFjZSAnZHN0JyBkZXNjcmlw
dGlvbiB3aXRoICdzcmMnIGRlc2NyaXB0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBH
YXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZyaW5naC5jIHwg
NiArKystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92cmluZ2guYyBiL2RyaXZlcnMvdmhv
c3QvdnJpbmdoLmMKPiBpbmRleCA4YmQ4YjQwM2YwODcuLmI3NDAzYmE4ZTdmNyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92cmluZ2gu
Ywo+IEBAIC03MzAsNyArNzMwLDcgQEAgRVhQT1JUX1NZTUJPTCh2cmluZ2hfaW92X3B1bGxfdXNl
cik7Cj4gICAvKioKPiAgICAqIHZyaW5naF9pb3ZfcHVzaF91c2VyIC0gY29weSBieXRlcyBpbnRv
IHZyaW5nX2lvdi4KPiAgICAqIEB3aW92OiB0aGUgd2lvdiBhcyBwYXNzZWQgdG8gdnJpbmdoX2dl
dGRlc2NfdXNlcigpICh1cGRhdGVkIGFzIHdlIGNvbnN1bWUpCj4gLSAqIEBkc3Q6IHRoZSBwbGFj
ZSB0byBjb3B5Lgo+ICsgKiBAc3JjOiB0aGUgcGxhY2UgdG8gY29weSBmcm9tLgo+ICAgICogQGxl
bjogdGhlIG1heGltdW0gbGVuZ3RoIHRvIGNvcHkuCj4gICAgKgo+ICAgICogUmV0dXJucyB0aGUg
Ynl0ZXMgY29waWVkIDw9IGxlbiBvciBhIG5lZ2F0aXZlIGVycm5vLgo+IEBAIC05NzYsNyArOTc2
LDcgQEAgRVhQT1JUX1NZTUJPTCh2cmluZ2hfaW92X3B1bGxfa2Vybik7Cj4gICAvKioKPiAgICAq
IHZyaW5naF9pb3ZfcHVzaF9rZXJuIC0gY29weSBieXRlcyBpbnRvIHZyaW5nX2lvdi4KPiAgICAq
IEB3aW92OiB0aGUgd2lvdiBhcyBwYXNzZWQgdG8gdnJpbmdoX2dldGRlc2Nfa2VybigpICh1cGRh
dGVkIGFzIHdlIGNvbnN1bWUpCj4gLSAqIEBkc3Q6IHRoZSBwbGFjZSB0byBjb3B5Lgo+ICsgKiBA
c3JjOiB0aGUgcGxhY2UgdG8gY29weSBmcm9tLgo+ICAgICogQGxlbjogdGhlIG1heGltdW0gbGVu
Z3RoIHRvIGNvcHkuCj4gICAgKgo+ICAgICogUmV0dXJucyB0aGUgYnl0ZXMgY29waWVkIDw9IGxl
biBvciBhIG5lZ2F0aXZlIGVycm5vLgo+IEBAIC0xMzMzLDcgKzEzMzMsNyBAQCBFWFBPUlRfU1lN
Qk9MKHZyaW5naF9pb3ZfcHVsbF9pb3RsYik7Cj4gICAgKiB2cmluZ2hfaW92X3B1c2hfaW90bGIg
LSBjb3B5IGJ5dGVzIGludG8gdnJpbmdfaW92Lgo+ICAgICogQHZyaDogdGhlIHZyaW5nLgo+ICAg
ICogQHdpb3Y6IHRoZSB3aW92IGFzIHBhc3NlZCB0byB2cmluZ2hfZ2V0ZGVzY19pb3RsYigpICh1
cGRhdGVkIGFzIHdlIGNvbnN1bWUpCj4gLSAqIEBkc3Q6IHRoZSBwbGFjZSB0byBjb3B5Lgo+ICsg
KiBAc3JjOiB0aGUgcGxhY2UgdG8gY29weSBmcm9tLgo+ICAgICogQGxlbjogdGhlIG1heGltdW0g
bGVuZ3RoIHRvIGNvcHkuCj4gICAgKgo+ICAgICogUmV0dXJucyB0aGUgYnl0ZXMgY29waWVkIDw9
IGxlbiBvciBhIG5lZ2F0aXZlIGVycm5vLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
