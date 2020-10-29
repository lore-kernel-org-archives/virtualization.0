Return-Path: <SRS0=2X6m=EE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ABEC4363A
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 07:04:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2370E214DB
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 07:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkesHrXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2370E214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 84A7086439;
	Thu, 29 Oct 2020 07:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ak7Z6cwJ3Rtu; Thu, 29 Oct 2020 07:04:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 38F298641F;
	Thu, 29 Oct 2020 07:04:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6619C0859;
	Thu, 29 Oct 2020 07:04:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D03A6C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 07:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AC9E220479
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 07:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZoypItDXh1T2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 07:04:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 170AD2043C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 07:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603955044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bX6rZZ2WckVwic3cL/Iugqri2t7pKFvVduk03jGqeLQ=;
 b=EkesHrXQk98Wj0r8GEXjhgHyIc2MqW1XoKNA2SDnR09/j470UdsGuVoPGs0Fzpr4qBA41W
 ilutIKWPEF2+AaPTzf60TMQcua6wOkFu6FNVLRp2Z0z2T4No2v80UEI+JYLqTQPCWhssVu
 SoNA/tLjsFz0GtOs0mNHcBGNKAsiwH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-c7LfDfIDN--qCBrqNxdIBA-1; Thu, 29 Oct 2020 03:04:01 -0400
X-MC-Unique: c7LfDfIDN--qCBrqNxdIBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65DA6804B73;
 Thu, 29 Oct 2020 07:04:00 +0000 (UTC)
Received: from [10.72.12.209] (ovpn-12-209.pek2.redhat.com [10.72.12.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0915F1974D;
 Thu, 29 Oct 2020 07:03:43 +0000 (UTC)
Subject: Re: [PATCH] vhost: Use mutex to protect vq_irq setup
To: Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>,
 lingshan.zhu@intel.com
References: <20201028142004.GA100353@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <60e24a0e-0d72-51b3-216a-b3cf62fb1a58@redhat.com>
Date: Thu, 29 Oct 2020 15:03:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028142004.GA100353@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Ck9uIDIwMjAvMTAvMjgg5LiL5Y2IMTA6MjAsIEVsaSBDb2hlbiB3cm90ZToKPiBCb3RoIGlycV9i
eXBhc3NfcmVnaXN0ZXJfcHJvZHVjZXIoKSBhbmQgaXJxX2J5cGFzc191bnJlZ2lzdGVyX3Byb2R1
Y2VyKCkKPiByZXF1aXJlIHByb2Nlc3MgY29udGV4dCB0byBydW4uIENoYW5nZSB0aGUgY2FsbCBj
b250ZXh0IGxvY2sgZnJvbQo+IHNwaW5sb2NrIHRvIG11dGV4IHRvIHByb3RlY3QgdGhlIHNldHVw
IHByb2Nlc3MgdG8gYXZvaWQgZGVhZGxvY2tzLgo+Cj4gRml4ZXM6IDI2NWEwYWQ4NzMxZCAoInZo
b3N0OiBpbnRyb2R1Y2Ugdmhvc3RfdnJpbmdfY2FsbCIpCj4gU2lnbmVkLW9mZi1ieTogRWxpIENv
aGVuIDxlbGljQG52aWRpYS5jb20+CgoKSGkgRWxpOgoKRHVyaW5nIHJldmlldyB3ZSBzcG90IHRo
YXQgdGhlIHNwaW5sb2NrIGlzIG5vdCBuZWNlc3NhcnkuIEFuZCBpdCB3YXMgCmFscmVhZHkgcHJv
dGVjdGVkIGJ5IHZxIG11dGV4LiBTbyBpdCB3YXMgcmVtb3ZlZCBpbiB0aGlzIGNvbW1pdDoKCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xp
bnV4LmdpdC9jb21taXQvP2lkPTg2ZTE4MmZlMTJlZTU4NjkwMjI2MTQ0NTcwMzcwOTdjNzBmZTJl
ZDEKClRoYW5rcwoKCj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgfCAxMCArKysrKy0t
LS0tCj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAgNiArKystLS0KPiAgIGRyaXZlcnMvdmhv
c3Qvdmhvc3QuaCB8ICAzICsrLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCA5IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIv
ZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCBiZTc4MzU5MmZlNTguLjBhNzQ0ZjJiNmU3NiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4gQEAgLTk4LDI2ICs5OCwyNiBAQCBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3NldHVw
X3ZxX2lycShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTE2IHFpZCkKPiAgIAkJcmV0dXJuOwo+ICAg
Cj4gICAJaXJxID0gb3BzLT5nZXRfdnFfaXJxKHZkcGEsIHFpZCk7Cj4gLQlzcGluX2xvY2soJnZx
LT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4gKwltdXRleF9sb2NrKCZ2cS0+Y2FsbF9jdHguY3R4X2xv
Y2spOwo+ICAgCWlycV9ieXBhc3NfdW5yZWdpc3Rlcl9wcm9kdWNlcigmdnEtPmNhbGxfY3R4LnBy
b2R1Y2VyKTsKPiAgIAlpZiAoIXZxLT5jYWxsX2N0eC5jdHggfHwgaXJxIDwgMCkgewo+IC0JCXNw
aW5fdW5sb2NrKCZ2cS0+Y2FsbF9jdHguY3R4X2xvY2spOwo+ICsJCW11dGV4X3VubG9jaygmdnEt
PmNhbGxfY3R4LmN0eF9sb2NrKTsKPiAgIAkJcmV0dXJuOwo+ICAgCX0KPiAgIAo+ICAgCXZxLT5j
YWxsX2N0eC5wcm9kdWNlci50b2tlbiA9IHZxLT5jYWxsX2N0eC5jdHg7Cj4gICAJdnEtPmNhbGxf
Y3R4LnByb2R1Y2VyLmlycSA9IGlycTsKPiAgIAlyZXQgPSBpcnFfYnlwYXNzX3JlZ2lzdGVyX3By
b2R1Y2VyKCZ2cS0+Y2FsbF9jdHgucHJvZHVjZXIpOwo+IC0Jc3Bpbl91bmxvY2soJnZxLT5jYWxs
X2N0eC5jdHhfbG9jayk7Cj4gKwltdXRleF91bmxvY2soJnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7
Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfdW5zZXR1cF92cV9pcnEoc3Ry
dWN0IHZob3N0X3ZkcGEgKnYsIHUxNiBxaWQpCj4gICB7Cj4gICAJc3RydWN0IHZob3N0X3ZpcnRx
dWV1ZSAqdnEgPSAmdi0+dnFzW3FpZF07Cj4gICAKPiAtCXNwaW5fbG9jaygmdnEtPmNhbGxfY3R4
LmN0eF9sb2NrKTsKPiArCW11dGV4X2xvY2soJnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4gICAJ
aXJxX2J5cGFzc191bnJlZ2lzdGVyX3Byb2R1Y2VyKCZ2cS0+Y2FsbF9jdHgucHJvZHVjZXIpOwo+
IC0Jc3Bpbl91bmxvY2soJnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4gKwltdXRleF91bmxvY2so
JnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHZob3N0
X3ZkcGFfcmVzZXQoc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+IGluZGV4IDlhZDQ1ZTFkMjdm
MC4uOTM4MjM5ZTExNDU1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ICsr
KyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+IEBAIC0zMDIsNyArMzAyLDcgQEAgc3RhdGljIHZv
aWQgdmhvc3RfdnJpbmdfY2FsbF9yZXNldChzdHJ1Y3Qgdmhvc3RfdnJpbmdfY2FsbCAqY2FsbF9j
dHgpCj4gICB7Cj4gICAJY2FsbF9jdHgtPmN0eCA9IE5VTEw7Cj4gICAJbWVtc2V0KCZjYWxsX2N0
eC0+cHJvZHVjZXIsIDB4MCwgc2l6ZW9mKHN0cnVjdCBpcnFfYnlwYXNzX3Byb2R1Y2VyKSk7Cj4g
LQlzcGluX2xvY2tfaW5pdCgmY2FsbF9jdHgtPmN0eF9sb2NrKTsKPiArCW11dGV4X2luaXQoJmNh
bGxfY3R4LT5jdHhfbG9jayk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHZob3N0X3ZxX3Jl
c2V0KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiBAQCAtMTY1MCw5ICsxNjUwLDkgQEAgbG9uZyB2
aG9zdF92cmluZ19pb2N0bChzdHJ1Y3Qgdmhvc3RfZGV2ICpkLCB1bnNpZ25lZCBpbnQgaW9jdGws
IHZvaWQgX191c2VyICphcmcKPiAgIAkJCWJyZWFrOwo+ICAgCQl9Cj4gICAKPiAtCQlzcGluX2xv
Y2soJnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4gKwkJbXV0ZXhfbG9jaygmdnEtPmNhbGxfY3R4
LmN0eF9sb2NrKTsKPiAgIAkJc3dhcChjdHgsIHZxLT5jYWxsX2N0eC5jdHgpOwo+IC0JCXNwaW5f
dW5sb2NrKCZ2cS0+Y2FsbF9jdHguY3R4X2xvY2spOwo+ICsJCW11dGV4X3VubG9jaygmdnEtPmNh
bGxfY3R4LmN0eF9sb2NrKTsKPiAgIAkJYnJlYWs7Cj4gICAJY2FzZSBWSE9TVF9TRVRfVlJJTkdf
RVJSOgo+ICAgCQlpZiAoY29weV9mcm9tX3VzZXIoJmYsIGFyZ3AsIHNpemVvZiBmKSkgewo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmggYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmgK
PiBpbmRleCA5MDMyZDNjMmE5ZjQuLmU4ODU1ZWEwNDIwNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3Zob3N0L3Zob3N0LmgKPiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPiBAQCAtNjQsNyAr
NjQsOCBAQCBlbnVtIHZob3N0X3VhZGRyX3R5cGUgewo+ICAgc3RydWN0IHZob3N0X3ZyaW5nX2Nh
bGwgewo+ICAgCXN0cnVjdCBldmVudGZkX2N0eCAqY3R4Owo+ICAgCXN0cnVjdCBpcnFfYnlwYXNz
X3Byb2R1Y2VyIHByb2R1Y2VyOwo+IC0Jc3BpbmxvY2tfdCBjdHhfbG9jazsKPiArCS8qIHByb3Rl
Y3QgdnEgaXJxIHNldHVwICovCj4gKwlzdHJ1Y3QgbXV0ZXggY3R4X2xvY2s7Cj4gICB9Owo+ICAg
Cj4gICAvKiBUaGUgdmlydHF1ZXVlIHN0cnVjdHVyZSBkZXNjcmliZXMgYSBxdWV1ZSBhdHRhY2hl
ZCB0byBhIGRldmljZS4gKi8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
