Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF0EC433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 03:22:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFEA61939
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 03:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFEA61939
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3F1760639;
	Mon, 22 Mar 2021 03:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BdB790dBEfTF; Mon, 22 Mar 2021 03:22:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 917FA605BE;
	Mon, 22 Mar 2021 03:22:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59752C000A;
	Mon, 22 Mar 2021 03:22:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABF1AC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9210D4029B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uqm0SJP65CKx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:22:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E334E40299
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616383354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CxCPTphkLxAAe7WrRHdqu9Vis3F0z32vdPzkrtEuSY=;
 b=GufCd1dNYOpqWzTuuAu+4dB+N1OaMWECKmPEss8gbicA7XrI+CZc/1FjqAvbFgB7Sw4ZZy
 R7f4SvkY/V3DyLXyoCDDti6uNyfl41DBy5rKRAXyFz9ur5qeuXbgHcgrl1FKhcMzhUAVEf
 712+K/mbmtpy8iqkBl8qlAVK0HUIkEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-iZsFkDiAOR6s_9WODNEMaw-1; Sun, 21 Mar 2021 23:22:32 -0400
X-MC-Unique: iZsFkDiAOR6s_9WODNEMaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 646D8180FCA8;
 Mon, 22 Mar 2021 03:22:30 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-188.pek2.redhat.com
 [10.72.13.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 046675F9C9;
 Mon, 22 Mar 2021 03:22:16 +0000 (UTC)
Subject: Re: [PATCH 1/3] virtio_ring: always warn when descriptor chain
 exceeds queue size
To: Connor Kuehl <ckuehl@redhat.com>, virtio-fs@redhat.com
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-2-ckuehl@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fa4988fa-a671-0abf-f922-6b362faf10d5@redhat.com>
Date: Mon, 22 Mar 2021 11:22:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318135223.1342795-2-ckuehl@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: miklos@szeredi.hu, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
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

CtTaIDIwMjEvMy8xOCDPws7nOTo1MiwgQ29ubm9yIEt1ZWhsINC0tcA6Cj4gIEZyb20gc2VjdGlv
biAyLjYuNS4zLjEgKERyaXZlciBSZXF1aXJlbWVudHM6IEluZGlyZWN0IERlc2NyaXB0b3JzKQo+
IG9mIHRoZSB2aXJ0aW8gc3BlYzoKPgo+ICAgICJBIGRyaXZlciBNVVNUIE5PVCBjcmVhdGUgYSBk
ZXNjcmlwdG9yIGNoYWluIGxvbmdlciB0aGFuIHRoZSBRdWV1ZQo+ICAgIFNpemUgb2YgdGhlIGRl
dmljZS4iCj4KPiBUaGlzIHRleHQgc3VnZ2VzdHMgdGhhdCB0aGUgd2FybmluZyBzaG91bGQgdHJp
Z2dlciBldmVuIGlmCj4gaW5kaXJlY3QgZGVzY3JpcHRvcnMgYXJlIGluIHVzZS4KCgpTbyBJIHRo
aW5rIGF0IGxlYXN0IHRoZSBjb21taXQgbG9nIG5lZWRzIHNvbWUgdHdlYWsuCgpGb3Igc3BsaXQg
dmlydHF1ZXVlLiBXZSBoYWQ6CgoyLjYuNS4yIERyaXZlciBSZXF1aXJlbWVudHM6IFRoZSBWaXJ0
cXVldWUgRGVzY3JpcHRvciBUYWJsZQoKRHJpdmVycyBNVVNUIE5PVCBhZGQgYSBkZXNjcmlwdG9y
IGNoYWluIGxvbmdlciB0aGFuIDJeMzIgYnl0ZXMgaW4gdG90YWw7IAp0aGlzIGltcGxpZXMgdGhh
dCBsb29wcyBpbiB0aGUgZGVzY3JpcHRvciBjaGFpbiBhcmUgZm9yYmlkZGVuIQoKMi42LjUuMy4x
IERyaXZlciBSZXF1aXJlbWVudHM6IEluZGlyZWN0IERlc2NyaXB0b3JzCgpBIGRyaXZlciBNVVNU
IE5PVCBjcmVhdGUgYSBkZXNjcmlwdG9yIGNoYWluIGxvbmdlciB0aGFuIHRoZSBRdWV1ZSBTaXpl
IApvZiB0aGUgZGV2aWNlLgoKSWYgSSB1bmRlcnN0YW5kIHRoZSBzcGVjIGNvcnJlY3RseSwgdGhl
IGNoZWNrIGlzIG9ubHkgbmVlZGVkIGZvciBhIApzaW5nbGUgaW5kaXJlY3QgZGVzY3JpcHRvciB0
YWJsZT8KCkZvciBwYWNrZWQgdmlydHF1ZXVlLiBXZSBoYWQ6CgoyLjcuMTcgRHJpdmVyIFJlcXVp
cmVtZW50czogU2NhdHRlci1HYXRoZXIgU3VwcG9ydAoKQSBkcml2ZXIgTVVTVCBOT1QgY3JlYXRl
IGEgZGVzY3JpcHRvciBsaXN0IGxvbmdlciB0aGFuIGFsbG93ZWQgYnkgdGhlIApkZXZpY2UuCgpB
IGRyaXZlciBNVVNUIE5PVCBjcmVhdGUgYSBkZXNjcmlwdG9yIGxpc3QgbG9uZ2VyIHRoYW4gdGhl
IFF1ZXVlIFNpemUuCgoyLjcuMTkgRHJpdmVyIFJlcXVpcmVtZW50czogSW5kaXJlY3QgRGVzY3Jp
cHRvcnMKCkEgZHJpdmVyIE1VU1QgTk9UIGNyZWF0ZSBhIGRlc2NyaXB0b3IgY2hhaW4gbG9uZ2Vy
IHRoYW4gYWxsb3dlZCBieSB0aGUgCmRldmljZS4KClNvIGl0IGxvb2tzIHRvIG1lIHRoZSBwYWNr
ZWQgcGFydCBpcyBmaW5lLgoKTm90ZSB0aGF0IGlmIEkgdW5kZXJzdGFuZCB0aGUgc3BlYyBjb3Jy
ZWN0bHkgMi43LjE3IGltcGxpZXMgMi43LjE5LgoKVGhhbmtzCgoKPgo+IFJlcG9ydGVkLWJ5OiBT
dGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQ29u
bm9yIEt1ZWhsIDxja3VlaGxAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMgfCA3ICsrKystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCA3MWUxNmI1M2U5
YzEuLjFiYzI5MGY5YmExMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC00NDQsMTEgKzQ0
NCwxMiBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0
cXVldWUgKl92cSwKPiAgIAo+ICAgCWhlYWQgPSB2cS0+ZnJlZV9oZWFkOwo+ICAgCj4gKwlXQVJO
X09OX09OQ0UodG90YWxfc2cgPiB2cS0+c3BsaXQudnJpbmcubnVtKTsKPiArCj4gICAJaWYgKHZp
cnRxdWV1ZV91c2VfaW5kaXJlY3QoX3ZxLCB0b3RhbF9zZykpCj4gICAJCWRlc2MgPSBhbGxvY19p
bmRpcmVjdF9zcGxpdChfdnEsIHRvdGFsX3NnLCBnZnApOwo+ICAgCWVsc2Ugewo+ICAgCQlkZXNj
ID0gTlVMTDsKPiAtCQlXQVJOX09OX09OQ0UodG90YWxfc2cgPiB2cS0+c3BsaXQudnJpbmcubnVt
ICYmICF2cS0+aW5kaXJlY3QpOwo+ICAgCX0KPiAgIAo+ICAgCWlmIChkZXNjKSB7Cj4gQEAgLTEx
MTgsNiArMTExOSw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfcGFja2VkKHN0
cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgIAo+ICAgCUJVR19PTih0b3RhbF9zZyA9PSAwKTsKPiAg
IAo+ICsJV0FSTl9PTl9PTkNFKHRvdGFsX3NnID4gdnEtPnBhY2tlZC52cmluZy5udW0pOwo+ICsK
PiAgIAlpZiAodmlydHF1ZXVlX3VzZV9pbmRpcmVjdChfdnEsIHRvdGFsX3NnKSkKPiAgIAkJcmV0
dXJuIHZpcnRxdWV1ZV9hZGRfaW5kaXJlY3RfcGFja2VkKHZxLCBzZ3MsIHRvdGFsX3NnLAo+ICAg
CQkJCW91dF9zZ3MsIGluX3NncywgZGF0YSwgZ2ZwKTsKPiBAQCAtMTEyNSw4ICsxMTI4LDYgQEAg
c3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9wYWNrZWQoc3RydWN0IHZpcnRxdWV1ZSAq
X3ZxLAo+ICAgCWhlYWQgPSB2cS0+cGFja2VkLm5leHRfYXZhaWxfaWR4Owo+ICAgCWF2YWlsX3Vz
ZWRfZmxhZ3MgPSB2cS0+cGFja2VkLmF2YWlsX3VzZWRfZmxhZ3M7Cj4gICAKPiAtCVdBUk5fT05f
T05DRSh0b3RhbF9zZyA+IHZxLT5wYWNrZWQudnJpbmcubnVtICYmICF2cS0+aW5kaXJlY3QpOwo+
IC0KPiAgIAlkZXNjID0gdnEtPnBhY2tlZC52cmluZy5kZXNjOwo+ICAgCWkgPSBoZWFkOwo+ICAg
CWRlc2NzX3VzZWQgPSB0b3RhbF9zZzsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
