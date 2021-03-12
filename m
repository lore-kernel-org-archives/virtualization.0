Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82794C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 06:33:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A3464E10
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 06:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A3464E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43C6C6F992;
	Fri, 12 Mar 2021 06:33:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wlz0rO8OyEOO; Fri, 12 Mar 2021 06:33:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7FA96F98C;
	Fri, 12 Mar 2021 06:33:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1D9FC000A;
	Fri, 12 Mar 2021 06:33:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A08A7C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 06:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E83D6F999
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 06:33:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 627sDKrQAmdD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 06:33:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B0D9600B8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 06:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615530830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxYXgMslZPHyhqjjAUjb+4OhgFRtuNfwG4K2get5jzc=;
 b=H5Wqj50AZqlyKexovXP0tqYP94Ejq2Xlfr0PIVZNW+nBc1QX44aZByV1Wh4j/R8LGKmUdk
 Nf8AUXLpuaDgK+TwDGpwcAELeiJj0uodpkqz9Es+JXYdz3fNfVdSt/eUsrm1S9qYmu8rxL
 9reNJtMvGULX4T5UMJThKHpI6ZRakpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-74yRoMHdPampxkMFKNsVrQ-1; Fri, 12 Mar 2021 01:33:46 -0500
X-MC-Unique: 74yRoMHdPampxkMFKNsVrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B0F6801817;
 Fri, 12 Mar 2021 06:33:45 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-168.pek2.redhat.com
 [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0CD15D6D7;
 Fri, 12 Mar 2021 06:33:39 +0000 (UTC)
Subject: Re: [PATCH 1/2] vhost-vdpa: fix use-after-free of v->config_ctx
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210311135257.109460-1-sgarzare@redhat.com>
 <20210311135257.109460-2-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cfe550cf-301a-92c4-7270-6a50ea3ed19c@redhat.com>
Date: Fri, 12 Mar 2021 14:33:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210311135257.109460-2-sgarzare@redhat.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: netdev@vger.kernel.org, Zhu Lingshan <lingshan.zhu@intel.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Ck9uIDIwMjEvMy8xMSA5OjUyIOS4i+WNiCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IFdo
ZW4gdGhlICd2LT5jb25maWdfY3R4JyBldmVudGZkX2N0eCByZWZlcmVuY2UgaXMgcmVsZWFzZWQg
d2UgZGlkbid0Cj4gc2V0IGl0IHRvIE5VTEwuIFNvIGlmIHRoZSBzYW1lIGNoYXJhY3RlciBkZXZp
Y2UgKGUuZy4gL2Rldi92aG9zdC12ZHBhLTApCj4gaXMgcmUtb3BlbmVkLCB0aGUgJ3YtPmNvbmZp
Z19jdHgnIGlzIGludmFsaWQgYW5kIGNhbGxpbmcgYWdhaW4KPiB2aG9zdF92ZHBhX2NvbmZpZ19w
dXQoKSBjYXVzZXMgdXNlLWFmdGVyLWZyZWUgaXNzdWVzIGxpa2UgdGhlCj4gZm9sbG93aW5nIHJl
ZmNvdW50X3QgdW5kZXJmbG93Ogo+Cj4gICAgICByZWZjb3VudF90OiB1bmRlcmZsb3c7IHVzZS1h
ZnRlci1mcmVlLgo+ICAgICAgV0FSTklORzogQ1BVOiAyIFBJRDogODcyIGF0IGxpYi9yZWZjb3Vu
dC5jOjI4IHJlZmNvdW50X3dhcm5fc2F0dXJhdGUrMHhhZS8weGYwCj4gICAgICBSSVA6IDAwMTA6
cmVmY291bnRfd2Fybl9zYXR1cmF0ZSsweGFlLzB4ZjAKPiAgICAgIENhbGwgVHJhY2U6Cj4gICAg
ICAgZXZlbnRmZF9jdHhfcHV0KzB4NWIvMHg3MAo+ICAgICAgIHZob3N0X3ZkcGFfcmVsZWFzZSsw
eGNkLzB4MTUwIFt2aG9zdF92ZHBhXQo+ICAgICAgIF9fZnB1dCsweDhlLzB4MjQwCj4gICAgICAg
X19fX2ZwdXQrMHhlLzB4MTAKPiAgICAgICB0YXNrX3dvcmtfcnVuKzB4NjYvMHhhMAo+ICAgICAg
IGV4aXRfdG9fdXNlcl9tb2RlX3ByZXBhcmUrMHgxMTgvMHgxMjAKPiAgICAgICBzeXNjYWxsX2V4
aXRfdG9fdXNlcl9tb2RlKzB4MjEvMHg1MAo+ICAgICAgID8gX194NjRfc3lzX2Nsb3NlKzB4MTIv
MHg0MAo+ICAgICAgIGRvX3N5c2NhbGxfNjQrMHg0NS8weDUwCj4gICAgICAgZW50cnlfU1lTQ0FM
TF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhZQo+Cj4gRml4ZXM6IDc3NmYzOTUwMDRkOCAoInZo
b3N0X3ZkcGE6IFN1cHBvcnQgY29uZmlnIGludGVycnVwdCBpbiB2ZHBhIikKPiBDYzogbGluZ3No
YW4uemh1QGludGVsLmNvbQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4gU2lnbmVkLW9m
Zi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgoKCkFja2VkLWJ5
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3Zo
b3N0L3ZkcGEuYyB8IDQgKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJp
dmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCBlZjY4OGM4YzBlMGUuLjAwNzk2ZTRlY2ZkZiAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRw
YS5jCj4gQEAgLTMwOCw4ICszMDgsMTAgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfdnJp
bmdfbnVtKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MTYgX191c2VyICphcmdwKQo+ICAgCj4gICBz
dGF0aWMgdm9pZCB2aG9zdF92ZHBhX2NvbmZpZ19wdXQoc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4g
ICB7Cj4gLQlpZiAodi0+Y29uZmlnX2N0eCkKPiArCWlmICh2LT5jb25maWdfY3R4KSB7Cj4gICAJ
CWV2ZW50ZmRfY3R4X3B1dCh2LT5jb25maWdfY3R4KTsKPiArCQl2LT5jb25maWdfY3R4ID0gTlVM
TDsKPiArCX0KPiAgIH0KPiAgIAo+ICAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRfY29uZmln
X2NhbGwoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBfX3VzZXIgKmFyZ3ApCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
