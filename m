Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F535C433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 06:11:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0983651E9
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 06:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0983651E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6BC9605BE;
	Tue, 16 Mar 2021 06:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NTX-2xCX4CGC; Tue, 16 Mar 2021 06:11:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43E8A60631;
	Tue, 16 Mar 2021 06:11:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E729C000C;
	Tue, 16 Mar 2021 06:11:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39CC6C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BA3B60642
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:11:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8IOSZqUp7_Ej
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:11:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 720B0605BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615875103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGFqJnJPWEoWdqThLFH/fQr5tvLwsqAidPoANR0ZVyQ=;
 b=G84NcFFjKnt2x0P/vKtt/Q+P4kUorRWzXcNqxGsy6SJqgNgCo/IghphM+bqvMcUE3GtXbP
 0bTNJyQA/BGGGlLG0EBklTyruAege4pDdyRBxQpGx2/vDCmMfcF4e4qvD3FVMpxqD/CGAG
 Eoi5bdsnEHtWmFU+AGZXcrVyOMbedyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-zTcCLMXFMAiXbYOA1Eq_SA-1; Tue, 16 Mar 2021 02:11:37 -0400
X-MC-Unique: zTcCLMXFMAiXbYOA1Eq_SA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 084A6107465F;
 Tue, 16 Mar 2021 06:11:36 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-216.pek2.redhat.com
 [10.72.12.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6077019CB4;
 Tue, 16 Mar 2021 06:11:30 +0000 (UTC)
Subject: Re: [PATCH V4 4/7] vDPA/ifcvf: remove the version number string
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210315074501.15868-1-lingshan.zhu@intel.com>
 <20210315074501.15868-5-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7b46c912-fa81-6e91-f588-3f856177af5b@redhat.com>
Date: Tue, 16 Mar 2021 14:11:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315074501.15868-5-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMy8xNSDPws7nMzo0NCwgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
cmVtb3ZlcyB0aGUgdmVyc2lvbiBudW1iZXIgc3RyaW5nLCB1c2luZyBrZXJuZWwKPiB2ZXJzaW9u
IGlzIGVub3VnaC4KPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1
QGludGVsLmNvbT4KPiBSZXZpZXdlZC1ieTogTGVvbiBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlh
LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0t
LQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDIgLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gaW5kZXgg
ZmQ1YmVmYzVjYmNjLi5jMzRlMWVlYzZiNmMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMK
PiBAQCAtMTQsNyArMTQsNiBAQAo+ICAgI2luY2x1ZGUgPGxpbnV4L3N5c2ZzLmg+Cj4gICAjaW5j
bHVkZSAiaWZjdmZfYmFzZS5oIgo+ICAgCj4gLSNkZWZpbmUgVkVSU0lPTl9TVFJJTkcgICIwLjEi
Cj4gICAjZGVmaW5lIERSSVZFUl9BVVRIT1IgICAiSW50ZWwgQ29ycG9yYXRpb24iCj4gICAjZGVm
aW5lIElGQ1ZGX0RSSVZFUl9OQU1FICAgICAgICJpZmN2ZiIKPiAgIAo+IEBAIC01MDMsNCArNTAy
LDMgQEAgc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVyIGlmY3ZmX2RyaXZlciA9IHsKPiAgIG1vZHVs
ZV9wY2lfZHJpdmVyKGlmY3ZmX2RyaXZlcik7Cj4gICAKPiAgIE1PRFVMRV9MSUNFTlNFKCJHUEwg
djIiKTsKPiAtTU9EVUxFX1ZFUlNJT04oVkVSU0lPTl9TVFJJTkcpOwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
