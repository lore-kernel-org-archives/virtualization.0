Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93635C433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043B760249
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043B760249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F9B74065C;
	Tue, 13 Apr 2021 08:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l3V0q6NTrZvX; Tue, 13 Apr 2021 08:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 708F640556;
	Tue, 13 Apr 2021 08:54:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45A0EC000C;
	Tue, 13 Apr 2021 08:54:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FCD9C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1F0240604
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gAl7E7-0nBnq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:54:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDC3A40556
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618304095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKPKEZ9FRbFkC2KSVQ4DBOrlcHV/4kIBTz0bbRwMv7o=;
 b=NEbdMAjK6+hFQ7riLYUMytPwZmSr7E70bwY6VRIzMXqHe4QwzZ8DNL0mfYXXpKJq5WOzLP
 UwvVcLTfUEP62uRzedtVu0rRNcRHtQf7DuuK2LDWY5GQZgzSQ4w+wEwbljvdbky7YxaKVX
 DSxj9j9WRVFnfgHVXReIih26UkPHTUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-Q6cfJx75NQuy_ZphtauNww-1; Tue, 13 Apr 2021 04:54:52 -0400
X-MC-Unique: Q6cfJx75NQuy_ZphtauNww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D15DE83DD38;
 Tue, 13 Apr 2021 08:54:50 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-128.pek2.redhat.com
 [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17B751A86F;
 Tue, 13 Apr 2021 08:54:44 +0000 (UTC)
Subject: Re: [PATCH RFC v2 3/4] virtio_net: move tx vq operation under tx
 queue lock
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-4-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <805053bf-960f-3c34-ce23-012d121ca937@redhat.com>
Date: Tue, 13 Apr 2021 16:54:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413054733.36363-4-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

CtTaIDIwMjEvNC8xMyDPws7nMTo0NywgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gSXQncyB1
bnNhZmUgdG8gb3BlcmF0ZSBhIHZxIGZyb20gbXVsdGlwbGUgdGhyZWFkcy4KPiBVbmZvcnR1bmF0
ZWx5IHRoaXMgaXMgZXhhY3RseSB3aGF0IHdlIGRvIHdoZW4gaW52b2tpbmcKPiBjbGVhbiB0eCBw
b2xsIGZyb20gcnggbmFwaS4KPiBBcyBhIGZpeCBtb3ZlIGV2ZXJ5dGhpbmcgdGhhdCBkZWFscyB3
aXRoIHRoZSB2cSB0byB1bmRlciB0eCBsb2NrLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggMTZkNWFiZWQ1
ODJjLi40NjBjY2RiYjg0MGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTE1MDUsNiArMTUwNSw4IEBA
IHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsX3R4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50
IGJ1ZGdldCkKPiAgIAlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IHNxLT52cS0+dmRldi0+cHJp
djsKPiAgIAl1bnNpZ25lZCBpbnQgaW5kZXggPSB2cTJ0eHEoc3EtPnZxKTsKPiAgIAlzdHJ1Y3Qg
bmV0ZGV2X3F1ZXVlICp0eHE7Cj4gKwlpbnQgb3BhcXVlOwo+ICsJYm9vbCBkb25lOwo+ICAgCj4g
ICAJaWYgKHVubGlrZWx5KGlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKHZpLCBpbmRleCkpKSB7Cj4g
ICAJCS8qIFdlIGRvbid0IG5lZWQgdG8gZW5hYmxlIGNiIGZvciBYRFAgKi8KPiBAQCAtMTUxNCwx
MCArMTUxNiwyOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChzdHJ1Y3QgbmFwaV9zdHJ1
Y3QgKm5hcGksIGludCBidWRnZXQpCj4gICAKPiAgIAl0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVl
KHZpLT5kZXYsIGluZGV4KTsKPiAgIAlfX25ldGlmX3R4X2xvY2sodHhxLCByYXdfc21wX3Byb2Nl
c3Nvcl9pZCgpKTsKPiArCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gICAJZnJlZV9v
bGRfeG1pdF9za2JzKHNxLCB0cnVlKTsKPiArCj4gKwlvcGFxdWUgPSB2aXJ0cXVldWVfZW5hYmxl
X2NiX3ByZXBhcmUoc3EtPnZxKTsKPiArCj4gKwlkb25lID0gbmFwaV9jb21wbGV0ZV9kb25lKG5h
cGksIDApOwo+ICsKPiArCWlmICghZG9uZSkKPiArCQl2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+
dnEpOwo+ICsKPiAgIAlfX25ldGlmX3R4X3VubG9jayh0eHEpOwo+ICAgCj4gLQl2aXJ0cXVldWVf
bmFwaV9jb21wbGV0ZShuYXBpLCBzcS0+dnEsIDApOwoKClNvIEkgd29uZGVyIHdoeSBub3Qgc2lt
cGx5IG1vdmUgX19uZXRpZl90eF91bmxvY2soKSBhZnRlciAKdmlydHF1ZXVlX25hcGlfY29tcGxl
dGUoKT8KClRoYW5rcwoKCj4gKwlpZiAoZG9uZSkgewo+ICsJCWlmICh1bmxpa2VseSh2aXJ0cXVl
dWVfcG9sbChzcS0+dnEsIG9wYXF1ZSkpKSB7Cj4gKwkJCWlmIChuYXBpX3NjaGVkdWxlX3ByZXAo
bmFwaSkpIHsKPiArCQkJCV9fbmV0aWZfdHhfbG9jayh0eHEsIHJhd19zbXBfcHJvY2Vzc29yX2lk
KCkpOwo+ICsJCQkJdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiArCQkJCV9fbmV0aWZf
dHhfdW5sb2NrKHR4cSk7Cj4gKwkJCQlfX25hcGlfc2NoZWR1bGUobmFwaSk7Cj4gKwkJCX0KPiAr
CQl9Cj4gKwl9Cj4gICAKPiAgIAlpZiAoc3EtPnZxLT5udW1fZnJlZSA+PSAyICsgTUFYX1NLQl9G
UkFHUykKPiAgIAkJbmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
