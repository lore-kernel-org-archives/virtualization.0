Return-Path: <SRS0=fSyG=FF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2C5C64E7B
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 06:25:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9442087D
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 06:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GurzyJYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9442087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11CC786A2B;
	Tue,  1 Dec 2020 06:25:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y7OA2N1Nistl; Tue,  1 Dec 2020 06:25:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0A44486A11;
	Tue,  1 Dec 2020 06:25:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC994C163C;
	Tue,  1 Dec 2020 06:25:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84986C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 06:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 669672E0EA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 06:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wAjKPsTsMEsM
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 06:25:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id DD8682E0F5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 06:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606803916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCHesexpjRFhWOcxGP78gptqdhCw6l2GCYqi5IE/c2M=;
 b=GurzyJYdaIbP7qEk7glfI4rJLLN636K9yE1TUOj48OgltwWmXfYJrU2RXVfhhSt4dEptds
 DUgRFiydI/ZoxJ9vMp7X/4qKB92uV9VkUA0NViLXfsC5AZg8ktI4N0NOLpH+LdHV+mxga+
 Y1ZcVWaAMgnVP2YhAQM7uIGPMihOzhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-h6Hs-gSMOVqrcs__jDRWng-1; Tue, 01 Dec 2020 01:25:12 -0500
X-MC-Unique: h6Hs-gSMOVqrcs__jDRWng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7820F180E49D;
 Tue,  1 Dec 2020 06:25:11 +0000 (UTC)
Received: from [10.72.13.167] (ovpn-13-167.pek2.redhat.com [10.72.13.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F69860853;
 Tue,  1 Dec 2020 06:25:06 +0000 (UTC)
Subject: Re: [External] Re: [PATCH 0/7] Introduce vdpa management tool
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <5b2235f6-513b-dbc9-3670-e4c9589b4d1f@redhat.com>
 <CACycT3sYScObb9nN3g7L3cesjE7sCZWxZ5_5R1usGU9ePZEeqA@mail.gmail.com>
 <182708df-1082-0678-49b2-15d0199f20df@redhat.com>
 <CACycT3votu2eyacKg+w12xZ_ujEOgTY0f8A7qcpbM-fwTpjqAw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7f80eeed-f5d3-8c6f-1b8c-87b7a449975c@redhat.com>
Date: Tue, 1 Dec 2020 14:25:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3votu2eyacKg+w12xZ_ujEOgTY0f8A7qcpbM-fwTpjqAw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: netdev@vger.kernel.org, elic@nvidia.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
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

Ck9uIDIwMjAvMTEvMzAg5LiL5Y2IMzowNywgWW9uZ2ppIFhpZSB3cm90ZToKPj4+IFRoYW5rcyBm
b3IgYWRkaW5nIG1lLCBKYXNvbiEKPj4+Cj4+PiBOb3cgSSdtIHdvcmtpbmcgb24gYSB2MiBwYXRj
aHNldCBmb3IgVkRVU0UgKHZEUEEgRGV2aWNlIGluIFVzZXJzcGFjZSkKPj4+IFsxXS4gVGhpcyB0
b29sIGlzIHZlcnkgdXNlZnVsIGZvciB0aGUgdmR1c2UgZGV2aWNlLiBTbyBJJ20gY29uc2lkZXJp
bmcKPj4+IGludGVncmF0aW5nIHRoaXMgaW50byBteSB2MiBwYXRjaHNldC4gQnV0IHRoZXJlIGlz
IG9uZSBwcm9ibGVt77yaCj4+Pgo+Pj4gSW4gdGhpcyB0b29sLCB2ZHBhIGRldmljZSBjb25maWcg
YWN0aW9uIGFuZCBlbmFibGUgYWN0aW9uIGFyZSBjb21iaW5lZAo+Pj4gaW50byBvbmUgbmV0bGlu
ayBtc2c6IFZEUEFfQ01EX0RFVl9ORVcuIEJ1dCBpbiB2ZHVzZSBjYXNlLCBpdCBuZWVkcyB0bwo+
Pj4gYmUgc3BsaXR0ZWQgYmVjYXVzZSBhIGNoYXJkZXYgc2hvdWxkIGJlIGNyZWF0ZWQgYW5kIG9w
ZW5lZCBieSBhCj4+PiB1c2Vyc3BhY2UgcHJvY2VzcyBiZWZvcmUgd2UgZW5hYmxlIHRoZSB2ZHBh
IGRldmljZSAoY2FsbAo+Pj4gdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKSkuCj4+Pgo+Pj4gU28gSSdk
IGxpa2UgdG8ga25vdyB3aGV0aGVyIGl0J3MgcG9zc2libGUgKG9yIGhhdmUgc29tZSBwbGFucykg
dG8gYWRkCj4+PiB0d28gbmV3IG5ldGxpbmsgbXNncyBzb21ldGhpbmcgbGlrZTogVkRQQV9DTURf
REVWX0VOQUJMRSBhbmQKPj4+IFZEUEFfQ01EX0RFVl9ESVNBQkxFIHRvIG1ha2UgdGhlIGNvbmZp
ZyBwYXRoIG1vcmUgZmxleGlibGUuCj4+Pgo+PiBBY3R1YWxseSwgd2UndmUgZGlzY3Vzc2VkIHN1
Y2ggaW50ZXJtZWRpYXRlIHN0ZXAgaW4gc29tZSBlYXJseQo+PiBkaXNjdXNzaW9uLiBJdCBsb29r
cyB0byBtZSBWRFVTRSBjb3VsZCBiZSBvbmUgb2YgdGhlIHVzZXJzIG9mIHRoaXMuCj4+Cj4+IE9y
IEkgd29uZGVyIHdoZXRoZXIgd2UgY2FuIHN3aXRjaCB0byB1c2UgYW5vbnltb3VzIGlub2RlKGZk
KSBmb3IgVkRVU0UKPj4gdGhlbiBmZXRjaGluZyBpdCB2aWEgYW4gVkRVU0VfR0VUX0RFVklDRV9G
RCBpb2N0bD8KPj4KPiBZZXMsIHdlIGNhbi4gQWN0dWFsbHkgdGhlIGN1cnJlbnQgaW1wbGVtZW50
YXRpb24gaW4gVkRVU0UgaXMgbGlrZQo+IHRoaXMuICBCdXQgc2VlbXMgbGlrZSB0aGlzIGlzIHN0
aWxsIGEgaW50ZXJtZWRpYXRlIHN0ZXAuIFRoZSBmZCBzaG91bGQKPiBiZSBiaW5kZWQgdG8gYSBu
YW1lIG9yIHNvbWV0aGluZyBlbHNlIHdoaWNoIG5lZWQgdG8gYmUgY29uZmlndXJlZAo+IGJlZm9y
ZS4KCgpUaGUgbmFtZSBjb3VsZCBiZSBzcGVjaWZpZWQgdmlhIHRoZSBuZXRsaW5rLiBJdCBsb29r
cyB0byBtZSB0aGUgcmVhbCAKaXNzdWUgaXMgdGhhdCB1bnRpbCB0aGUgZGV2aWNlIGlzIGNvbm5l
Y3RlZCB3aXRoIGEgdXNlcnNwYWNlLCBpdCBjYW4ndCAKYmUgdXNlZC4gU28gd2UgYWxzbyBuZWVk
IHRvIGZhaWwgdGhlIGVuYWJsaW5nIGlmIGl0IGRvZXNuJ3Qgb3BlbmVkLgoKVGhhbmtzCgoKPgo+
IFRoYW5rcywKPiBZb25namkKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
