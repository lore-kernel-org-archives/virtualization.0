Return-Path: <SRS0=0lGn=FS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82193C4361B
	for <virtualization@archiver.kernel.org>; Mon, 14 Dec 2020 04:07:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD64E238E4
	for <virtualization@archiver.kernel.org>; Mon, 14 Dec 2020 04:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD64E238E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0989D85DFD;
	Mon, 14 Dec 2020 04:07:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QSoeWeTBup6E; Mon, 14 Dec 2020 04:07:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5DC2385D8D;
	Mon, 14 Dec 2020 04:07:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26B19C088E;
	Mon, 14 Dec 2020 04:07:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55F0CC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 04:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4A8B387315
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 04:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I2RHQDITgyDJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 04:07:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 757C586FB1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 04:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607918822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzyNprWQhpXB2BvhFP0QM0DQai4ecWHKhpNZSzP1Ytw=;
 b=Z+jXH0h3IGcn/MnuqlBJAf1NbXOtr297y8sa78zJWrQFhGnAimhN4SFiHZRR3l8Qw5Ylum
 in/k5Zl34p/UjDc0Hr/S6M/qHUgL1im3huhrJINymFAQr1BBcPrsOqno8f9eiNUVDhV/bC
 +IqfhuFsoXDtwjGtib4fs1sJ/EqqsHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-KDGZE9q7M4SWJoaOppEwiQ-1; Sun, 13 Dec 2020 23:06:57 -0500
X-MC-Unique: KDGZE9q7M4SWJoaOppEwiQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C63510054FF;
 Mon, 14 Dec 2020 04:06:56 +0000 (UTC)
Received: from [10.72.13.213] (ovpn-13-213.pek2.redhat.com [10.72.13.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6564370472;
 Mon, 14 Dec 2020 04:06:49 +0000 (UTC)
Subject: Re: [PATCH net v2] tun: fix ubuf refcount incorrectly on error path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <1606982459-41752-1-git-send-email-wangyunjian@huawei.com>
 <1607517703-18472-1-git-send-email-wangyunjian@huawei.com>
 <CA+FuTSfQoDr0jd76xBXSvchhyihQaL2UQXeCR6frJ7hyXxbmVA@mail.gmail.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB6E3B3@dggemm513-mbx.china.huawei.com>
 <CA+FuTSdVJa4JQzzybZ17WDcfokA2RZ043kh5++Zgy5aNNebj0A@mail.gmail.com>
 <CAF=yD-LF+j1vpzKDtBVUi22ZkTCEnMAXgfLfoQTBO+95D6RGRA@mail.gmail.com>
 <75c625df-3ac8-79ba-d1c5-3b6d1f9b108b@redhat.com>
 <CAF=yD-+Hcg8cNo2qMfpGOWRORJskZR3cPPEE61neg7xFWkVh8w@mail.gmail.com>
 <CAF=yD-JHO3SaxaHAZJ8nZ1jy8Zp4hMt1EhP3abutA5zczgTv5g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3cfbcd25-f9ae-ea9b-fc10-80a44a614276@redhat.com>
Date: Mon, 14 Dec 2020 12:06:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-JHO3SaxaHAZJ8nZ1jy8Zp4hMt1EhP3abutA5zczgTv5g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Willem de Bruijn <willemb@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 wangyunjian <wangyunjian@huawei.com>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

Ck9uIDIwMjAvMTIvMTQg5LiK5Y2IMTE6NTYsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gT24g
U3VuLCBEZWMgMTMsIDIwMjAgYXQgMTA6NTQgUE0gV2lsbGVtIGRlIEJydWlqbgo+IDx3aWxsZW1k
ZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPiB3cm90ZToKPj4gT24gU3VuLCBEZWMgMTMsIDIwMjAg
YXQgMTA6MzAgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pgo+
Pj4gT24gMjAyMC8xMi8xNCDkuIrljYg5OjMyLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+Pj4+
IE9uIFNhdCwgRGVjIDEyLCAyMDIwIGF0IDc6MTggUE0gV2lsbGVtIGRlIEJydWlqbgo+Pj4+IDx3
aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPiB3cm90ZToKPj4+Pj4+Pj4gYWZ0ZXJ3YXJk
cywgdGhlIGVycm9yIGhhbmRsaW5nIGluIHZob3N0IGhhbmRsZV90eCgpIHdpbGwgdHJ5IHRvCj4+
Pj4+Pj4+IGRlY3JlYXNlIHRoZSBzYW1lIHJlZmNvdW50IGFnYWluLiBUaGlzIGlzIHdyb25nIGFu
ZCBmaXggdGhpcyBieSBkZWxheQo+Pj4+Pj4+PiBjb3B5aW5nIHVidWZfaW5mbyB1bnRpbCB3ZSdy
ZSBzdXJlIHRoZXJlJ3Mgbm8gZXJyb3JzLgo+Pj4+Pj4+IEkgdGhpbmsgdGhlIHJpZ2h0IGFwcHJv
YWNoIGlzIHRvIGFkZHJlc3MgdGhpcyBpbiB0aGUgZXJyb3IgcGF0aHMsIHJhdGhlciB0aGFuCj4+
Pj4+Pj4gY29tcGxpY2F0ZSB0aGUgbm9ybWFsIGRhdGFwYXRoLgo+Pj4+Pj4+Cj4+Pj4+Pj4gSXMg
aXQgc3VmZmljaWVudCB0byBzdXBwcmVzcyB0aGUgY2FsbCB0byB2aG9zdF9uZXRfdWJ1Zl9wdXQg
aW4gdGhlIGhhbmRsZV90eAo+Pj4+Pj4+IHNlbmRtc2cgZXJyb3IgcGF0aCwgZ2l2ZW4gdGhhdCB2
aG9zdF96ZXJvY29weV9jYWxsYmFjayB3aWxsIGJlIGNhbGxlZCBvbgo+Pj4+Pj4+IGtmcmVlX3Nr
Yj8KPj4+Pj4+IFdlIGNhbiBub3QgY2FsbCBrZnJlZV9za2IoKSB1bnRpbCB0aGUgc2tiIHdhcyBj
cmVhdGVkLgo+Pj4+Pj4KPj4+Pj4+PiBPciBhbHRlcm5hdGl2ZWx5IGNsZWFyIHRoZSBkZXN0cnVj
dG9yIGluIGRyb3A6Cj4+Pj4+PiBUaGUgdWFyZy0+Y2FsbGJhY2soKSBpcyBjYWxsZWQgaW1tZWRp
YXRlbHkgYWZ0ZXIgd2UgZGVjaWRlIGRvIGRhdGFjb3B5Cj4+Pj4+PiBldmVuIGlmIGNhbGxlciB3
YW50IHRvIGRvIHplcm9jb3B5LiBJZiBhbm90aGVyIGVycm9yIG9jY3VycyBsYXRlciwgdGhlIHZo
b3N0Cj4+Pj4+PiBoYW5kbGVfdHgoKSB3aWxsIHRyeSB0byBkZWNyZWFzZSBpdCBhZ2Fpbi4KPj4+
Pj4gT2ggcmlnaHQsIEkgbWlzc2VkIHRoZSBlbHNlIGJyYW5jaCBpbiB0aGlzIHBhdGg6Cj4+Pj4+
Cj4+Pj4+ICAgICAgICAgICAvKiBjb3B5IHNrYl91YnVmX2luZm8gZm9yIGNhbGxiYWNrIHdoZW4g
c2tiIGhhcyBubyBlcnJvciAqLwo+Pj4+PiAgICAgICAgICAgaWYgKHplcm9jb3B5KSB7Cj4+Pj4+
ICAgICAgICAgICAgICAgICAgIHNrYl9zaGluZm8oc2tiKS0+ZGVzdHJ1Y3Rvcl9hcmcgPSBtc2df
Y29udHJvbDsKPj4+Pj4gICAgICAgICAgICAgICAgICAgc2tiX3NoaW5mbyhza2IpLT50eF9mbGFn
cyB8PSBTS0JUWF9ERVZfWkVST0NPUFk7Cj4+Pj4+ICAgICAgICAgICAgICAgICAgIHNrYl9zaGlu
Zm8oc2tiKS0+dHhfZmxhZ3MgfD0gU0tCVFhfU0hBUkVEX0ZSQUc7Cj4+Pj4+ICAgICAgICAgICB9
IGVsc2UgaWYgKG1zZ19jb250cm9sKSB7Cj4+Pj4+ICAgICAgICAgICAgICAgICAgIHN0cnVjdCB1
YnVmX2luZm8gKnVhcmcgPSBtc2dfY29udHJvbDsKPj4+Pj4gICAgICAgICAgICAgICAgICAgdWFy
Zy0+Y2FsbGJhY2sodWFyZywgZmFsc2UpOwo+Pj4+PiAgICAgICAgICAgfQo+Pj4+Pgo+Pj4+PiBT
byBpZiBoYW5kbGVfdHhfemVyb2NvcHkgY2FsbHMgdHVuX3NlbmRtc2cgd2l0aCB1YnVmX2luZm8g
KGFuZCB0aHVzIGEKPj4+Pj4gcmVmZXJlbmNlIHRvIHJlbGVhc2UpLCB0aGVyZSBhcmUgdGhlc2Ug
Zml2ZSBvcHRpb25zOgo+Pj4+Pgo+Pj4+PiAxLiB0dW5fc2VuZG1zZyBzdWNjZWVkcywgdWJ1Zl9p
bmZvIGlzIGFzc29jaWF0ZWQgd2l0aCBza2IuCj4+Pj4+ICAgICAgICByZWZlcmVuY2UgcmVsZWFz
ZWQgZnJvbSBrZnJlZV9za2IgY2FsbGluZyB2aG9zdF96ZXJvY29weV9jYWxsYmFjayBsYXRlcgo+
Pj4+Pgo+Pj4+PiAyLiB0dW5fc2VuZG1zZyBzdWNjZWVkcywgdWJ1Zl9pbmZvIGlzIHJlbGVhc2Vk
IGltbWVkaWF0ZWx5LCBhcyBza2IgaXMKPj4+Pj4gbm90IHplcm9jb3B5Lgo+Pj4+Pgo+Pj4+PiAz
LiB0dW5fc2VuZG1zZyBmYWlscyBiZWZvcmUgY3JlYXRpbmcgc2tiLCBoYW5kbGVfdHhfemVyb2Nv
cHkgY29ycmVjdGx5Cj4+Pj4+IGNsZWFucyB1cCBvbiByZWNlaXZpbmcgZXJyb3IgZnJvbSB0dW5f
c2VuZG1zZy4KPj4+Pj4KPj4+Pj4gNC4gdHVuX3NlbmRtc2cgZmFpbHMgYWZ0ZXIgY3JlYXRpbmcg
c2tiLCBidXQgd2l0aCBjb3B5aW5nOiBkZWNyZW1lbnRlZAo+Pj4+PiBhdCBicmFuY2ggc2hvd24g
YWJvdmUgKyBhZ2FpbiBpbiBoYW5kbGVfdHhfemVyb2NvcHkKPj4+Pj4KPj4+Pj4gNS4gdHVuX3Nl
bmRtc2cgZmFpbHMgYWZ0ZXIgY3JlYXRpbmcgc2tiLCB3aXRoIHplcm9jb3B5OiBkZWNyZW1lbnRl
ZCBhdAo+Pj4+PiBrZnJlZV9za2IgaW4gZHJvcDogKyBhZ2FpbiBpbiBoYW5kbGVfdHhfemVyb2Nv
cHkKPj4+Pj4KPj4+Pj4gU2luY2UgaGFuZGxlX3R4X3plcm9jb3B5IGhhcyBubyBpZGVhIHdoZXRo
ZXIgb24gZXJyb3IgMywgNCBvciA1Cj4+Pj4+IG9jY3VycmVkLAo+Pj4+IEFjdHVhbGx5LCBpdCBk
b2VzLiBJZiBzZW5kbXNnIHJldHVybnMgYW4gZXJyb3IsIGl0IGNhbiB0ZXN0IHdoZXRoZXIKPj4+
PiB2cS0+aGVhZHNbbnZxLT51cGVuZF9pZHhdLmxlbiAhPSBWSE9TVF9ETUFfSU5fUFJPR1JFU1Mu
Cj4+Pgo+Pj4gSnVzdCB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIHRoaXMuIEFueSByZWFzb24g
Zm9yIGl0IGNhbid0IGJlCj4+PiBWSE9TVF9ETUFfSU5fUFJPR1JFU1MgaGVyZT8KPj4gSXQgY2Fu
IGJlLCBhbmQgaXQgd2lsbCBiZSBpZiB0dW5fc2VuZG1zZyByZXR1cm5zIEVJTlZBTCBiZWZvcmUK
Pj4gYXNzaWduaW5nIHRoZSBza2IgZGVzdHJ1Y3Rvci4KPiBJIG1lYW50IHJldHVybnMgYW4gZXJy
b3IsIG5vdCBuZWNlc3NhcmlseSBvbmx5IEVJTlZBTC4KPgo+PiBPbmx5IGlmIHR1bl9zZW5kbXNn
IHJlbGVhc2VkIHRoZSB6ZXJvY29weSBzdGF0ZSB0aHJvdWdoCj4+IGtmcmVlX3NrYi0+dmhvc3Rf
emVyb2NvcHlfY2FsbGJhY2sgd2lsbCBpdCBoYXZlIGJlZW4gdXBkYXRlZCB0bwo+PiBWSE9TVF9E
TUFfRE9ORV9MRU4uIEFuZCBvbmx5IHRoZW4gbXVzdCB0aGUgY2FsbGVyIG5vdCB0cnkgdG8gcmVs
ZWFzZQo+PiB0aGUgc3RhdGUgYWdhaW4uCj4gCQoKCkkgc2VlLiBTbyBJIHRlbmQgdG8gZml4IHRo
aXMgaW4gdmhvc3QgaW5zdGVhZCBvZiB0dW4gdG8gYmUgY29uc2lzdGVudCAKd2l0aCB0aGUgY3Vy
cmVudCBlcnJvciBoYW5kbGluZyBpbiBoYW5kbGVfdHhfemVyb2NvcHkoKS4KClRoYW5rcwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
