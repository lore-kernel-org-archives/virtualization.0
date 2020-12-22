Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585AFC433DB
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 04:41:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70CF22B2D
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 04:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70CF22B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 85DEE2002F;
	Tue, 22 Dec 2020 04:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gopvGmQUrhd3; Tue, 22 Dec 2020 04:41:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 84C972002B;
	Tue, 22 Dec 2020 04:41:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63019C1787;
	Tue, 22 Dec 2020 04:41:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD8D5C0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 04:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C623784489
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 04:41:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPD2VpeC4ANx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 04:41:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E3BD584480
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 04:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608612087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxNvOkwVVescVONh1zwIXV5OChiSOuHHhJQGCHD0sCo=;
 b=Q39tAqJDjO/0S2RKmW1A7kEDPrhqyLNmOwTtNcHVoImMG131hdePWCKKzZ9srfpGRGvioT
 MWGOjJFzV/fwB0r0OmBYCRIpFo9xkEDmv/HOaKmiHUWyTp0t8IRPK7dk1++AIkJUacFYMU
 S4vCgAwWcCALHzz2i2hRDYw8Sl+iets=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-aub14m2SNuyyi1o3ejeAqw-1; Mon, 21 Dec 2020 23:41:23 -0500
X-MC-Unique: aub14m2SNuyyi1o3ejeAqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27791801817;
 Tue, 22 Dec 2020 04:41:22 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 445595D6D1;
 Tue, 22 Dec 2020 04:41:16 +0000 (UTC)
Subject: Re: [PATCH net v2 2/2] vhost_net: fix high cpu load when sendmsg fails
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 wangyunjian <wangyunjian@huawei.com>
References: <cover.1608065644.git.wangyunjian@huawei.com>
 <6b4c5fff8705dc4b5b6a25a45c50f36349350c73.1608065644.git.wangyunjian@huawei.com>
 <CAF=yD-K6EM3zfZtEh=305P4Z6ehO6TzfQC4cxp5+gHYrxEtXSg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <acebdc23-7627-e170-cdfb-b7656c05e5c5@redhat.com>
Date: Tue, 22 Dec 2020 12:41:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-K6EM3zfZtEh=305P4Z6ehO6TzfQC4cxp5+gHYrxEtXSg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 virtualization@lists.linux-foundation.org,
 chenchanghu <chenchanghu@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>, xudingke <xudingke@huawei.com>
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

Ck9uIDIwMjAvMTIvMjIg5LiK5Y2INzowNywgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiBPbiBX
ZWQsIERlYyAxNiwgMjAyMCBhdCAzOjIwIEFNIHdhbmd5dW5qaWFuPHdhbmd5dW5qaWFuQGh1YXdl
aS5jb20+ICB3cm90ZToKPj4gRnJvbTogWXVuamlhbiBXYW5nPHdhbmd5dW5qaWFuQGh1YXdlaS5j
b20+Cj4+Cj4+IEN1cnJlbnRseSB3ZSBicmVhayB0aGUgbG9vcCBhbmQgd2FrZSB1cCB0aGUgdmhv
c3Rfd29ya2VyIHdoZW4KPj4gc2VuZG1zZyBmYWlscy4gV2hlbiB0aGUgd29ya2VyIHdha2VzIHVw
IGFnYWluLCB3ZSdsbCBtZWV0IHRoZQo+PiBzYW1lIGVycm9yLgo+IFRoZSBwYXRjaCBpcyBiYXNl
ZCBvbiB0aGUgYXNzdW1wdGlvbiB0aGF0IHN1Y2ggZXJyb3IgY2FzZXMgYWx3YXlzCj4gcmV0dXJu
IEVBR0FJTi4gQ2FuIGl0IG5vdCBhbHNvIGJlIEVOT01FTSwgc3VjaCBhcyBmcm9tIHR1bl9idWls
ZF9za2I/Cj4KPj4gVGhpcyB3aWxsIGNhdXNlIGhpZ2ggQ1BVIGxvYWQuIFRvIGZpeCB0aGlzIGlz
c3VlLAo+PiB3ZSBjYW4gc2tpcCB0aGlzIGRlc2NyaXB0aW9uIGJ5IGlnbm9yaW5nIHRoZSBlcnJv
ci4gV2hlbiB3ZQo+PiBleGNlZWRzIHNuZGJ1ZiwgdGhlIHJldHVybiB2YWx1ZSBvZiBzZW5kbXNn
IGlzIC1FQUdBSU4uIEluCj4+IHRoZSBjYXNlIHdlIGRvbid0IHNraXAgdGhlIGRlc2NyaXB0aW9u
IGFuZCBkb24ndCBkcm9wIHBhY2tldC4KPiB0aGUgLT4gdGhhdAo+Cj4gaGVyZSBhbmQgYWJvdmU6
IGRlc2NyaXB0aW9uIC0+IGRlc2NyaXB0b3IKPgo+IFBlcmhhcHMgc2xpZ2h0bHkgcmV2aXNlIHRv
IG1vcmUgZXhwbGljaXRseSBzdGF0ZSB0aGF0Cj4KPiAxLiBpbiB0aGUgY2FzZSBvZiBwZXJzaXN0
ZW50IGZhaWx1cmUgKGkuZS4sIGJhZCBwYWNrZXQpLCB0aGUgZHJpdmVyCj4gZHJvcHMgdGhlIHBh
Y2tldAo+IDIuIGluIHRoZSBjYXNlIG9mIHRyYW5zaWVudCBmYWlsdXJlIChlLmcsLiBtZW1vcnkg
cHJlc3N1cmUpIHRoZSBkcml2ZXIKPiBzY2hlZHVsZXMgdGhlIHdvcmtlciB0byB0cnkgYWdhaW4g
bGF0ZXIKCgpJZiB3ZSB3YW50IHRvIGdvIHdpdGggdGhpcyB3YXksIHdlIG5lZWQgYSBiZXR0ZXIg
dGltZSB0byB3YWtldXAgdGhlIAp3b3JrZXIuIE90aGVyd2lzZSBpdCBqdXN0IHByb2R1Y2VzIG1v
cmUgc3RyZXNzIG9uIHRoZSBjcHUgdGhhdCBpcyB3aGF0IAp0aGlzIHBhdGNoIHRyaWVzIHRvIGF2
b2lkLgoKVGhhbmtzCgoKPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
