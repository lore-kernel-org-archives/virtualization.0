Return-Path: <SRS0=edzl=JL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E11C433ED
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 04:02:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1578D61004
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 04:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1578D61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C576560711;
	Wed, 14 Apr 2021 04:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jorRE7Au7vv5; Wed, 14 Apr 2021 04:02:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27691606F1;
	Wed, 14 Apr 2021 04:02:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E259DC000B;
	Wed, 14 Apr 2021 04:02:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F24FAC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 04:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4DBC606F1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 04:02:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGeeUGKaM9ZP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 04:02:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 272B060711
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 04:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618372924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cb160dTeZzNNrUQErRypJRQxN1hzmXq4Crw0cmUCkUs=;
 b=gpK0qZiQ9M8s8y40iN/JfsZQ2VUCdlK6vbd0xPNUL+bw5yDZ2BK87PU7Fm5nu0dH1OHDCP
 DqUh6AZnRdBCOdLO//psJWvLcRQm7FDCLkTlGusBaXMQG56OEDG0CS+8dBMNKB2mvdKHGw
 lFkLDZVeUA1bpqsFo/FIkNYSExSDuj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-yOknOJ61Pvy4cwWns3ZXuA-1; Wed, 14 Apr 2021 00:01:58 -0400
X-MC-Unique: yOknOJ61Pvy4cwWns3ZXuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DFA5189C447;
 Wed, 14 Apr 2021 04:01:56 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-196.pek2.redhat.com
 [10.72.13.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9ACE5D6AC;
 Wed, 14 Apr 2021 04:01:48 +0000 (UTC)
Subject: Re: [PATCH net-next v4 08/10] virtio-net: xsk zero copy xmit setup
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210413031523.73507-1-xuanzhuo@linux.alibaba.com>
 <20210413031523.73507-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ec6d7825-ddfb-ae7e-1105-fffd6afecfcb@redhat.com>
Date: Wed, 14 Apr 2021 12:01:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413031523.73507-9-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC8xMyDJz87nMTE6MTUsIFh1YW4gWmh1byDQtLXAOgo+IHhzayBpcyBhIGhpZ2gt
cGVyZm9ybWFuY2UgcGFja2V0IHJlY2VpdmluZyBhbmQgc2VuZGluZyB0ZWNobm9sb2d5Lgo+Cj4g
VGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSBiaW5kaW5nIGFuZCB1bmJpbmRpbmcgb3BlcmF0aW9u
cyBvZiB4c2sgYW5kCj4gdGhlIHZpcnRpby1uZXQgcXVldWUgZm9yIHhzayB6ZXJvIGNvcHkgeG1p
dC4KPgo+IFRoZSB4c2sgemVybyBjb3B5IHhtaXQgZGVwZW5kcyBvbiB0eCBuYXBpLgoKCkl0J3Mg
YmV0dGVyIHRvIGRlc2NyaWJlIHdoeSB6ZXJvIGNvcHkgZGVwZW5kcyBvbiB0eCBuYXBpLgoKCj4g
ICBTbyBpZiB0eCBuYXBpIGlzIG5vdCB0cnVlLAo+IGFuIGVycm9yIHdpbGwgYmUgcmVwb3J0ZWQu
IEFuZCB0aGUgZW50aXJlIG9wZXJhdGlvbiBpcyB1bmRlciB0aGUKPiBwcm90ZWN0aW9uIG9mIHJ0
bmxfbG9jay4KPgo+IElmIHhzayBpcyBhY3RpdmUsIGl0IHdpbGwgcHJldmVudCBldGh0b29sIGZy
b20gbW9kaWZ5aW5nIHR4IG5hcGkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56
aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IFJldmlld2VkLWJ5OiBEdXN0IExpIDxkdXN0LmxpQGxp
bnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNzgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDc3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCBm
NTJhMjUwOTEzMjIuLjgyNDJhOWU5ZjE3ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMjIsNiArMjIs
NyBAQAo+ICAgI2luY2x1ZGUgPG5ldC9yb3V0ZS5oPgo+ICAgI2luY2x1ZGUgPG5ldC94ZHAuaD4K
PiAgICNpbmNsdWRlIDxuZXQvbmV0X2ZhaWxvdmVyLmg+Cj4gKyNpbmNsdWRlIDxuZXQveGRwX3Nv
Y2tfZHJ2Lmg+Cj4gICAKPiAgIHN0YXRpYyBpbnQgbmFwaV93ZWlnaHQgPSBOQVBJX1BPTExfV0VJ
R0hUOwo+ICAgbW9kdWxlX3BhcmFtKG5hcGlfd2VpZ2h0LCBpbnQsIDA0NDQpOwo+IEBAIC0xMzMs
NiArMTM0LDExIEBAIHN0cnVjdCBzZW5kX3F1ZXVlIHsKPiAgIAlzdHJ1Y3QgdmlydG5ldF9zcV9z
dGF0cyBzdGF0czsKPiAgIAo+ICAgCXN0cnVjdCBuYXBpX3N0cnVjdCBuYXBpOwo+ICsKPiArCXN0
cnVjdCB7Cj4gKwkJLyogeHNrIHBvb2wgKi8KCgpUaGlzIGNvbW1lbnQgaXMgdW5uZWNlc3Nhcnkg
c2luY2UgdGhlIGNvZGUgZXhwbGFpbnMgaXRzZWxmLgoKCj4gKwkJc3RydWN0IHhza19idWZmX3Bv
b2wgX19yY3UgKnBvb2w7Cj4gKwl9IHhzazsKPiAgIH07Cj4gICAKPiAgIC8qIEludGVybmFsIHJl
cHJlc2VudGF0aW9uIG9mIGEgcmVjZWl2ZSB2aXJ0cXVldWUgKi8KPiBAQCAtMjI0OSw4ICsyMjU1
LDE5IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9zZXRfY29hbGVzY2Uoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwKPiAgIAlpZiAobmFwaV93ZWlnaHQgXiB2aS0+c3FbMF0ubmFwaS53ZWlnaHQpIHsKPiAg
IAkJaWYgKGRldi0+ZmxhZ3MgJiBJRkZfVVApCj4gICAJCQlyZXR1cm4gLUVCVVNZOwo+IC0JCWZv
ciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspCj4gKwkJZm9yIChpID0gMDsg
aSA8IHZpLT5tYXhfcXVldWVfcGFpcnM7IGkrKykgewo+ICsJCQkvKiB4c2sgeG1pdCBkZXBlbmQg
b24gdGhlIHR4IG5hcGkuIFNvIGlmIHhzayBpcyBhY3RpdmUsCj4gKwkJCSAqIHByZXZlbnQgbW9k
aWZpY2F0aW9ucyB0byB0eCBuYXBpLgo+ICsJCQkgKi8KPiArCQkJcmN1X3JlYWRfbG9jaygpOwo+
ICsJCQlpZiAocmN1X2RlcmVmZXJlbmNlKHZpLT5zcVtpXS54c2sucG9vbCkpIHsKCgpMZXQncyB1
c2UgcnRubF9kZXJlZmVybmVjZSgpIHRoZW4gdGhlIHJjdV9yZWFkX2xvY2soKS91bmxvY2soKSBp
cyBub3QgCm5lZWRlZC4KCgo+ICsJCQkJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gKwkJCQljb250aW51
ZTsKPiArCQkJfQo+ICsJCQlyY3VfcmVhZF91bmxvY2soKTsKPiArCj4gICAJCQl2aS0+c3FbaV0u
bmFwaS53ZWlnaHQgPSBuYXBpX3dlaWdodDsKPiArCQl9Cj4gICAJfQo+ICAgCj4gICAJcmV0dXJu
IDA7Cj4gQEAgLTI1MTgsMTEgKzI1MzUsNzAgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF9zZXQo
c3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGJwZl9wcm9nICpwcm9nLAo+ICAgCXJldHVy
biBlcnI7Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2aXJ0bmV0X3hza19wb29sX2VuYWJsZShz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICsJCQkJICAgc3RydWN0IHhza19idWZmX3Bvb2wgKnBv
b2wsCj4gKwkJCQkgICB1MTYgcWlkKQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9
IG5ldGRldl9wcml2KGRldik7Cj4gKwlzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3E7Cj4gKwo+ICsJaWYg
KHFpZCA+PSB2aS0+Y3Vycl9xdWV1ZV9wYWlycykKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4g
KwlzcSA9ICZ2aS0+c3FbcWlkXTsKPiArCj4gKwkvKiB4c2sgemVyb2NvcHkgZGVwZW5kIG9uIHRo
ZSB0eCBuYXBpLgo+ICsJICoKPiArCSAqIHhzayB6ZXJvY29weSB4bWl0IGlzIGRyaXZlbiBieSB0
aGUgdHggaW50ZXJydXB0LiBXaGVuIHRoZSBkZXZpY2UgaXMKPiArCSAqIG5vdCBidXN5LCBuYXBp
IHdpbGwgYmUgY2FsbGVkIGNvbnRpbnVvdXNseSB0byBzZW5kIGRhdGEuIFdoZW4gdGhlCj4gKwkg
KiBkZXZpY2UgaXMgYnVzeSwgd2FpdCBmb3IgdGhlIG5vdGlmaWNhdGlvbiBpbnRlcnJ1cHQgYWZ0
ZXIgdGhlCj4gKwkgKiBoYXJkd2FyZSBoYXMgZmluaXNoZWQgcHJvY2Vzc2luZyB0aGUgZGF0YSwg
YW5kIGNvbnRpbnVlIHRvIHNlbmQgZGF0YQo+ICsJICogaW4gbmFwaS4KPiArCSAqLwo+ICsJaWYg
KCFzcS0+bmFwaS53ZWlnaHQpCj4gKwkJcmV0dXJuIC1FUEVSTTsKPiArCj4gKwlyY3VfcmVhZF9s
b2NrKCk7Cj4gKwkvKiBIZXJlIGlzIGFscmVhZHkgcHJvdGVjdGVkIGJ5IHJ0bmxfbG9jaywgc28g
cmN1X2Fzc2lnbl9wb2ludGVyIGlzCj4gKwkgKiBzYWZlLgo+ICsJICovCj4gKwlyY3VfYXNzaWdu
X3BvaW50ZXIoc3EtPnhzay5wb29sLCBwb29sKTsKPiArCXJjdV9yZWFkX3VubG9jaygpOwoKCkFu
eSByZWFzb24gZm9yIHRoZSByY3UgbG9jayBoZXJlPyBBbmQgZG9uJ3Qgd2UgbmVlZCB0byBzeW5j
aHJvbml6ZSByY3UgaGVyZT8KCgo+ICsKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICtzdGF0aWMg
aW50IHZpcnRuZXRfeHNrX3Bvb2xfZGlzYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCB1MTYg
cWlkKQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7
Cj4gKwlzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3E7Cj4gKwo+ICsJaWYgKHFpZCA+PSB2aS0+Y3Vycl9x
dWV1ZV9wYWlycykKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gKwlzcSA9ICZ2aS0+c3FbcWlk
XTsKPiArCj4gKwkvKiBIZXJlIGlzIGFscmVhZHkgcHJvdGVjdGVkIGJ5IHJ0bmxfbG9jaywgc28g
cmN1X2Fzc2lnbl9wb2ludGVyIGlzCj4gKwkgKiBzYWZlLgo+ICsJICovCj4gKwlyY3VfYXNzaWdu
X3BvaW50ZXIoc3EtPnhzay5wb29sLCBOVUxMKTsKPiArCj4gKwlzeW5jaHJvbml6ZV9uZXQoKTsg
LyogU3luYyB3aXRoIHRoZSBYU0sgd2FrZXVwIGFuZCB3aXRoIE5BUEkuICovCgoKTGV0J3MgbW92
ZSB0aGUgY29tbWVudCBhYm92ZSB0aGUgY29kZS4KClRoYW5rcwoKCj4gKwo+ICsJcmV0dXJuIDA7
Cj4gK30KPiArCj4gICBzdGF0aWMgaW50IHZpcnRuZXRfeGRwKHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYsIHN0cnVjdCBuZXRkZXZfYnBmICp4ZHApCj4gICB7Cj4gICAJc3dpdGNoICh4ZHAtPmNvbW1h
bmQpIHsKPiAgIAljYXNlIFhEUF9TRVRVUF9QUk9HOgo+ICAgCQlyZXR1cm4gdmlydG5ldF94ZHBf
c2V0KGRldiwgeGRwLT5wcm9nLCB4ZHAtPmV4dGFjayk7Cj4gKwljYXNlIFhEUF9TRVRVUF9YU0tf
UE9PTDoKPiArCQlpZiAoeGRwLT54c2sucG9vbCkKPiArCQkJcmV0dXJuIHZpcnRuZXRfeHNrX3Bv
b2xfZW5hYmxlKGRldiwgeGRwLT54c2sucG9vbCwKPiArCQkJCQkJICAgICAgIHhkcC0+eHNrLnF1
ZXVlX2lkKTsKPiArCQllbHNlCj4gKwkJCXJldHVybiB2aXJ0bmV0X3hza19wb29sX2Rpc2FibGUo
ZGV2LCB4ZHAtPnhzay5xdWV1ZV9pZCk7Cj4gICAJZGVmYXVsdDoKPiAgIAkJcmV0dXJuIC1FSU5W
QUw7Cj4gICAJfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
