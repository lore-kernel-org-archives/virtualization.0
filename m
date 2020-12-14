Return-Path: <SRS0=0lGn=FS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B180CC4361B
	for <virtualization@archiver.kernel.org>; Mon, 14 Dec 2020 03:30:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E9321534
	for <virtualization@archiver.kernel.org>; Mon, 14 Dec 2020 03:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E9321534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 493C2859D9;
	Mon, 14 Dec 2020 03:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bw6M5B81LE1y; Mon, 14 Dec 2020 03:30:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9D32485D2B;
	Mon, 14 Dec 2020 03:30:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84185C0893;
	Mon, 14 Dec 2020 03:30:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4849EC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0C80E8713A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2v+cEimja-pD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:30:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 67BC68700F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607916647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJ/f1p/jWo6LX+lLq8as51T0CjWuBGu+ntgy1aiNUVU=;
 b=Zbq1o4F7tl6zozTrfMm//8elcfJ24OSN5grie+LAGF6/vjDA/un0dPr6JniJX7lKgEYE+1
 zERh73enjqsCTxWH6PJCSMQVVVWKZ0GvqW1JWiNcqsWIFpj9D2nrSbG0eVnUChMWReGh/4
 mzrxDydIwe5S2298pK/hNquHrP3SEMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-r5g-zVk8NN656j8-kn3CsQ-1; Sun, 13 Dec 2020 22:30:43 -0500
X-MC-Unique: r5g-zVk8NN656j8-kn3CsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5A33107ACF7;
 Mon, 14 Dec 2020 03:30:41 +0000 (UTC)
Received: from [10.72.13.213] (ovpn-13-213.pek2.redhat.com [10.72.13.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFDC9277BE;
 Mon, 14 Dec 2020 03:30:34 +0000 (UTC)
Subject: Re: [PATCH net v2] tun: fix ubuf refcount incorrectly on error path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 wangyunjian <wangyunjian@huawei.com>
References: <1606982459-41752-1-git-send-email-wangyunjian@huawei.com>
 <1607517703-18472-1-git-send-email-wangyunjian@huawei.com>
 <CA+FuTSfQoDr0jd76xBXSvchhyihQaL2UQXeCR6frJ7hyXxbmVA@mail.gmail.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB6E3B3@dggemm513-mbx.china.huawei.com>
 <CA+FuTSdVJa4JQzzybZ17WDcfokA2RZ043kh5++Zgy5aNNebj0A@mail.gmail.com>
 <CAF=yD-LF+j1vpzKDtBVUi22ZkTCEnMAXgfLfoQTBO+95D6RGRA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <75c625df-3ac8-79ba-d1c5-3b6d1f9b108b@redhat.com>
Date: Mon, 14 Dec 2020 11:30:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-LF+j1vpzKDtBVUi22ZkTCEnMAXgfLfoQTBO+95D6RGRA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Willem de Bruijn <willemb@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
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

Ck9uIDIwMjAvMTIvMTQg5LiK5Y2IOTozMiwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiBPbiBT
YXQsIERlYyAxMiwgMjAyMCBhdCA3OjE4IFBNIFdpbGxlbSBkZSBCcnVpam4KPiA8d2lsbGVtZGVi
cnVpam4ua2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pj4+IGFmdGVyd2FyZHMsIHRoZSBlcnJv
ciBoYW5kbGluZyBpbiB2aG9zdCBoYW5kbGVfdHgoKSB3aWxsIHRyeSB0bwo+Pj4+PiBkZWNyZWFz
ZSB0aGUgc2FtZSByZWZjb3VudCBhZ2Fpbi4gVGhpcyBpcyB3cm9uZyBhbmQgZml4IHRoaXMgYnkg
ZGVsYXkKPj4+Pj4gY29weWluZyB1YnVmX2luZm8gdW50aWwgd2UncmUgc3VyZSB0aGVyZSdzIG5v
IGVycm9ycy4KPj4+PiBJIHRoaW5rIHRoZSByaWdodCBhcHByb2FjaCBpcyB0byBhZGRyZXNzIHRo
aXMgaW4gdGhlIGVycm9yIHBhdGhzLCByYXRoZXIgdGhhbgo+Pj4+IGNvbXBsaWNhdGUgdGhlIG5v
cm1hbCBkYXRhcGF0aC4KPj4+Pgo+Pj4+IElzIGl0IHN1ZmZpY2llbnQgdG8gc3VwcHJlc3MgdGhl
IGNhbGwgdG8gdmhvc3RfbmV0X3VidWZfcHV0IGluIHRoZSBoYW5kbGVfdHgKPj4+PiBzZW5kbXNn
IGVycm9yIHBhdGgsIGdpdmVuIHRoYXQgdmhvc3RfemVyb2NvcHlfY2FsbGJhY2sgd2lsbCBiZSBj
YWxsZWQgb24KPj4+PiBrZnJlZV9za2I/Cj4+PiBXZSBjYW4gbm90IGNhbGwga2ZyZWVfc2tiKCkg
dW50aWwgdGhlIHNrYiB3YXMgY3JlYXRlZC4KPj4+Cj4+Pj4gT3IgYWx0ZXJuYXRpdmVseSBjbGVh
ciB0aGUgZGVzdHJ1Y3RvciBpbiBkcm9wOgo+Pj4gVGhlIHVhcmctPmNhbGxiYWNrKCkgaXMgY2Fs
bGVkIGltbWVkaWF0ZWx5IGFmdGVyIHdlIGRlY2lkZSBkbyBkYXRhY29weQo+Pj4gZXZlbiBpZiBj
YWxsZXIgd2FudCB0byBkbyB6ZXJvY29weS4gSWYgYW5vdGhlciBlcnJvciBvY2N1cnMgbGF0ZXIs
IHRoZSB2aG9zdAo+Pj4gaGFuZGxlX3R4KCkgd2lsbCB0cnkgdG8gZGVjcmVhc2UgaXQgYWdhaW4u
Cj4+IE9oIHJpZ2h0LCBJIG1pc3NlZCB0aGUgZWxzZSBicmFuY2ggaW4gdGhpcyBwYXRoOgo+Pgo+
PiAgICAgICAgICAvKiBjb3B5IHNrYl91YnVmX2luZm8gZm9yIGNhbGxiYWNrIHdoZW4gc2tiIGhh
cyBubyBlcnJvciAqLwo+PiAgICAgICAgICBpZiAoemVyb2NvcHkpIHsKPj4gICAgICAgICAgICAg
ICAgICBza2Jfc2hpbmZvKHNrYiktPmRlc3RydWN0b3JfYXJnID0gbXNnX2NvbnRyb2w7Cj4+ICAg
ICAgICAgICAgICAgICAgc2tiX3NoaW5mbyhza2IpLT50eF9mbGFncyB8PSBTS0JUWF9ERVZfWkVS
T0NPUFk7Cj4+ICAgICAgICAgICAgICAgICAgc2tiX3NoaW5mbyhza2IpLT50eF9mbGFncyB8PSBT
S0JUWF9TSEFSRURfRlJBRzsKPj4gICAgICAgICAgfSBlbHNlIGlmIChtc2dfY29udHJvbCkgewo+
PiAgICAgICAgICAgICAgICAgIHN0cnVjdCB1YnVmX2luZm8gKnVhcmcgPSBtc2dfY29udHJvbDsK
Pj4gICAgICAgICAgICAgICAgICB1YXJnLT5jYWxsYmFjayh1YXJnLCBmYWxzZSk7Cj4+ICAgICAg
ICAgIH0KPj4KPj4gU28gaWYgaGFuZGxlX3R4X3plcm9jb3B5IGNhbGxzIHR1bl9zZW5kbXNnIHdp
dGggdWJ1Zl9pbmZvIChhbmQgdGh1cyBhCj4+IHJlZmVyZW5jZSB0byByZWxlYXNlKSwgdGhlcmUg
YXJlIHRoZXNlIGZpdmUgb3B0aW9uczoKPj4KPj4gMS4gdHVuX3NlbmRtc2cgc3VjY2VlZHMsIHVi
dWZfaW5mbyBpcyBhc3NvY2lhdGVkIHdpdGggc2tiLgo+PiAgICAgICByZWZlcmVuY2UgcmVsZWFz
ZWQgZnJvbSBrZnJlZV9za2IgY2FsbGluZyB2aG9zdF96ZXJvY29weV9jYWxsYmFjayBsYXRlcgo+
Pgo+PiAyLiB0dW5fc2VuZG1zZyBzdWNjZWVkcywgdWJ1Zl9pbmZvIGlzIHJlbGVhc2VkIGltbWVk
aWF0ZWx5LCBhcyBza2IgaXMKPj4gbm90IHplcm9jb3B5Lgo+Pgo+PiAzLiB0dW5fc2VuZG1zZyBm
YWlscyBiZWZvcmUgY3JlYXRpbmcgc2tiLCBoYW5kbGVfdHhfemVyb2NvcHkgY29ycmVjdGx5Cj4+
IGNsZWFucyB1cCBvbiByZWNlaXZpbmcgZXJyb3IgZnJvbSB0dW5fc2VuZG1zZy4KPj4KPj4gNC4g
dHVuX3NlbmRtc2cgZmFpbHMgYWZ0ZXIgY3JlYXRpbmcgc2tiLCBidXQgd2l0aCBjb3B5aW5nOiBk
ZWNyZW1lbnRlZAo+PiBhdCBicmFuY2ggc2hvd24gYWJvdmUgKyBhZ2FpbiBpbiBoYW5kbGVfdHhf
emVyb2NvcHkKPj4KPj4gNS4gdHVuX3NlbmRtc2cgZmFpbHMgYWZ0ZXIgY3JlYXRpbmcgc2tiLCB3
aXRoIHplcm9jb3B5OiBkZWNyZW1lbnRlZCBhdAo+PiBrZnJlZV9za2IgaW4gZHJvcDogKyBhZ2Fp
biBpbiBoYW5kbGVfdHhfemVyb2NvcHkKPj4KPj4gU2luY2UgaGFuZGxlX3R4X3plcm9jb3B5IGhh
cyBubyBpZGVhIHdoZXRoZXIgb24gZXJyb3IgMywgNCBvciA1Cj4+IG9jY3VycmVkLAo+IEFjdHVh
bGx5LCBpdCBkb2VzLiBJZiBzZW5kbXNnIHJldHVybnMgYW4gZXJyb3IsIGl0IGNhbiB0ZXN0IHdo
ZXRoZXIKPiB2cS0+aGVhZHNbbnZxLT51cGVuZF9pZHhdLmxlbiAhPSBWSE9TVF9ETUFfSU5fUFJP
R1JFU1MuCgoKSnVzdCB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIHRoaXMuIEFueSByZWFzb24g
Zm9yIGl0IGNhbid0IGJlIApWSE9TVF9ETUFfSU5fUFJPR1JFU1MgaGVyZT8KClRoYW5rcwoKCj4K
Pj4gZWl0aGVyIGFsbCBkZWNyZW1lbnQtb24tZXJyb3IgY2FzZXMgbXVzdCBiZSBoYW5kbGVkIGJ5
Cj4+IGhhbmRsZV90eF96ZXJvY29weSBvciBub25lLgo+Pgo+PiBZb3VyIHBhdGNoIGNob29zZXMg
dGhlIGxhdHRlci4gTWFrZXMgc2Vuc2UuCj4+Cj4+IEJ1dCBjYW4gdGhpcyBzdGlsbCBnbyB3cm9u
ZyBpZiB0aGUgeGRwIHBhdGggaXMgdGFrZW4sIGJ1dCBubyBwcm9ncmFtCj4+IGV4aXN0cyBvciB0
aGUgcHJvZ3JhbSByZXR1cm5zIFhEUF9QQVNTLiBBbmQgdGhlbiB0aGUgcGFja2V0IGhpdHMgYW4K
Pj4gZXJyb3IgcGF0aCwgc3VjaCBhcyAhIElGRl9VUD8KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
