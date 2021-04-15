Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31325C43470
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:17:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E206102A
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E206102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F6ED60663;
	Thu, 15 Apr 2021 07:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9YPhUMaS6cUE; Thu, 15 Apr 2021 07:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 264F0606FF;
	Thu, 15 Apr 2021 07:17:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2C6FC000B;
	Thu, 15 Apr 2021 07:17:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 782DCC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65E6240FAB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qg60xGZqiaHQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:17:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 910AC40F6A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618471056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0WnUGWj6mmdpbk5EPEs1Mzx7dyk9BlduW5BXBGRUq4=;
 b=QlpIHk9ZUmYMuaREvcDz2UgSIdQqFWuha1XkJADFLMeWvcvnN4ZJrjLl8UfnQfElS3x7NL
 LIua4IggSfq7WGjni1OcFL+ZtyZTTntdVzScFiigKBsF/7u9HJbnyEaG2mga/u2UM0kJQ3
 cATIvtzF2V9TNn47vGTQefXZ+T6d5GY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Dle6J09lNr2HRO6FMp9cYg-1; Thu, 15 Apr 2021 03:17:32 -0400
X-MC-Unique: Dle6J09lNr2HRO6FMp9cYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21BB01854E25;
 Thu, 15 Apr 2021 07:17:31 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-61.pek2.redhat.com
 [10.72.12.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9021F61D31;
 Thu, 15 Apr 2021 07:17:22 +0000 (UTC)
Subject: Re: [PATCH 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block for
 vDPA
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-3-lingshan.zhu@intel.com>
 <54839b05-78d2-8edf-317c-372f0ecda024@redhat.com>
 <1a1f9f50-dc92-ced3-759d-e600abca3138@linux.intel.com>
 <c90a923f-7c8d-9a32-ce14-2370f85f1ba4@redhat.com>
 <10700088-3358-739b-5770-612ab761598c@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d6b27f59-ff17-1d63-0065-fd03ee36cd2d@redhat.com>
Date: Thu, 15 Apr 2021 15:17:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <10700088-3358-739b-5770-612ab761598c@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

CuWcqCAyMDIxLzQvMTUg5LiL5Y2IMjo0MSwgWmh1IExpbmdzaGFuIOWGmemBkzoKPj4+Pgo+Pj4+
IEkgdGhpbmsgd2UndmUgZGlzY3Vzc2VkIHRoaXMgc29tZXRpbWUgaW4gdGhlIHBhc3QgYnV0IHdo
YXQncyB0aGUgCj4+Pj4gcmVhc29uIGZvciBzdWNoIHdoaXRlbGlzdCBjb25zaWRlciB0aGVyZSdz
IGFscmVhZHkgYSBnZXRfZmVhdHVyZXMoKSAKPj4+PiBpbXBsZW1lbnRpb24/Cj4+Pj4KPj4+PiBF
LmcgQW55IHJlYXNvbiB0byBibG9jayBWSVJUSU9fQkxLX0ZfV1JJVEVfWkVST1Mgb3IgCj4+Pj4g
VklSVElPX0ZfUklOR19QQUNLRUQ/Cj4+Pj4KPj4+PiBUaGFua3MKPj4+IFRoZSByZWFzb24gaXMg
c29tZSBmZWF0dXJlIGJpdHMgYXJlIHN1cHBvcnRlZCBpbiB0aGUgZGV2aWNlIGJ1dCBub3QgCj4+
PiBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlciwgZS5nLCBmb3IgdmlydGlvLW5ldCwgbXEgJiBjcSBp
bXBsZW1lbnRhdGlvbiAKPj4+IGlzIG5vdCByZWFkeSBpbiB0aGUgZHJpdmVyLgo+Pgo+Pgo+PiBJ
IHVuZGVyc3RhbmQgdGhlIGNhc2Ugb2YgdmlydGlvLW5ldCBidXQgSSB3b25kZXIgd2h5IHdlIG5l
ZWQgdGhpcyBmb3IgCj4+IGJsb2NrIHdoZXJlIHdlIGRvbid0IHZxIGN2cS4KPj4KPj4gVGhhbmtz
Cj4gVGhpcyBpcyBzdGlsbCBhIHN1YnNldCBvZiB0aGUgZmVhdHVyZSBiaXRzIHJlYWQgZnJvbSBo
YXJkd2FyZSwgSSBsZWF2ZSAKPiBpdCBoZXJlIHRvIGNvZGUgY29uc2lzdGVudGx5LCBhbmQgaW5k
aWNhdGUgd2hhdCB3ZSBzdXBwb3J0IGNsZWFybHkuCj4gQXJlIHlvdSBzdWdnZXN0aW5nIHJlbW92
ZSB0aGlzIGZlYXR1cmUgYml0cyBsaXN0IGFuZCBqdXN0IHVzZSB3aGF0IHdlIAo+IHJlYWQgZnJv
bSBoYXJkd2FyZT8KPgo+IFRoYW5zayAKCgpZZXMsIHBsZWFzZSBkbyB0aGF0LgoKVGhlIHdoaWx0
ZWxpc3QgZG9lc24ndCBoZWxwIGluIHRoaXMgY2FzZSBJIHRoaW5rLgoKVGhhbmtzCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
