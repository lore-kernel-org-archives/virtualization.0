Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBCBC433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 03:16:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C658464F4C
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 03:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C658464F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A90886256;
	Thu,  4 Feb 2021 03:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xskK6dIOJOFl; Thu,  4 Feb 2021 03:16:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0ADD18600D;
	Thu,  4 Feb 2021 03:16:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB564C0174;
	Thu,  4 Feb 2021 03:16:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A181C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C76FC273A9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:16:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AInDFmGpFQZK
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:16:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id AAC9A27384
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612408605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgYGpxnisbo64RPm48ypK05uakOPf3IDveD9EGryR64=;
 b=IO7pMN50fxrhDr/VCIJJcK58znKnBW/8Fr2yHqfPwaAS3Tn8c4+/z4VkjpIcAlrTAA1Z/S
 RBTM+vBjYYDRbLPQ77evFUhw5LZBQwOImBy7hrVlhNJYoQJt+S4GOQOCWfhvL2LR5gZsI+
 z9WLPBhcuKeslqAzMR0Z9bnLf7xghgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-AJpO5PrJPdW6cwd5Sh_3-g-1; Wed, 03 Feb 2021 22:16:41 -0500
X-MC-Unique: AJpO5PrJPdW6cwd5Sh_3-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97124801962;
 Thu,  4 Feb 2021 03:16:40 +0000 (UTC)
Received: from [10.72.14.1] (ovpn-14-1.pek2.redhat.com [10.72.14.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F0E310016F9;
 Thu,  4 Feb 2021 03:16:32 +0000 (UTC)
Subject: Re: [PATCH iproute2-next v3 0/5] Add vdpa device management tool
To: Parav Pandit <parav@nvidia.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 dsahern@gmail.com, stephen@networkplumber.org, mst@redhat.com,
 Adrian Moreno Zapata <amorenoz@redhat.com>
References: <20210122112654.9593-3-parav@nvidia.com>
 <20210202103518.3858-1-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <99106d07-1730-6ed8-c847-0400be0dcd57@redhat.com>
Date: Thu, 4 Feb 2021 11:16:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202103518.3858-1-parav@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Ck9uIDIwMjEvMi8yIOS4i+WNiDY6MzUsIFBhcmF2IFBhbmRpdCB3cm90ZToKPiBMaW51eCB2ZHBh
IGludGVyZmFjZSBhbGxvd3MgdmRwYSBkZXZpY2UgbWFuYWdlbWVudCBmdW5jdGlvbmFsaXR5Lgo+
IFRoaXMgaW5jbHVkZXMgYWRkaW5nLCByZW1vdmluZywgcXVlcnlpbmcgdmRwYSBkZXZpY2VzLgo+
Cj4gdmRwYSBpbnRlcmZhY2UgYWxzbyBpbmNsdWRlcyBzaG93aW5nIHN1cHBvcnRlZCBtYW5hZ2Vt
ZW50IGRldmljZXMKPiB3aGljaCBzdXBwb3J0IHN1Y2ggb3BlcmF0aW9ucy4KPgo+IFRoaXMgcGF0
Y2hzZXQgaW5jbHVkZXMga2VybmVsIHVhcGkgaGVhZGVycyBhbmQgYSB2ZHBhIHRvb2wuCj4KPiBl
eGFtcGxlczoKPgo+ICQgdmRwYSBtZ210ZGV2IHNob3cKPiB2ZHBhc2ltOgo+ICAgIHN1cHBvcnRl
ZF9jbGFzc2VzIG5ldAo+Cj4gJCB2ZHBhIG1nbXRkZXYgc2hvdyAtanAKPiB7Cj4gICAgICAic2hv
dyI6IHsKPiAgICAgICAgICAidmRwYXNpbSI6IHsKPiAgICAgICAgICAgICAgInN1cHBvcnRlZF9j
bGFzc2VzIjogWyAibmV0IiBdCj4gICAgICAgICAgfQo+ICAgICAgfQo+IH0KPgo+IENyZWF0ZSBh
IHZkcGEgZGV2aWNlIG9mIHR5cGUgbmV0d29ya2luZyBuYW1lZCBhcyAiZm9vMiIgZnJvbQo+IHRo
ZSBtYW5hZ2VtZW50IGRldmljZSB2ZHBhc2ltX25ldDoKPgo+ICQgdmRwYSBkZXYgYWRkIG1nbXRk
ZXYgdmRwYXNpbV9uZXQgbmFtZSBmb28yCj4KPiBTaG93IHRoZSBuZXdseSBjcmVhdGVkIHZkcGEg
ZGV2aWNlIGJ5IGl0cyBuYW1lOgo+ICQgdmRwYSBkZXYgc2hvdyBmb28yCj4gZm9vMjogdHlwZSBu
ZXR3b3JrIG1nbXRkZXYgdmRwYXNpbV9uZXQgdmVuZG9yX2lkIDAgbWF4X3ZxcyAyIG1heF92cV9z
aXplIDI1Ngo+Cj4gJCB2ZHBhIGRldiBzaG93IGZvbzIgLWpwCj4gewo+ICAgICAgImRldiI6IHsK
PiAgICAgICAgICAiZm9vMiI6IHsKPiAgICAgICAgICAgICAgInR5cGUiOiAibmV0d29yayIsCj4g
ICAgICAgICAgICAgICJtZ210ZGV2IjogInZkcGFzaW1fbmV0IiwKPiAgICAgICAgICAgICAgInZl
bmRvcl9pZCI6IDAsCj4gICAgICAgICAgICAgICJtYXhfdnFzIjogMiwKPiAgICAgICAgICAgICAg
Im1heF92cV9zaXplIjogMjU2Cj4gICAgICAgICAgfQo+ICAgICAgfQo+IH0KPgo+IERlbGV0ZSB0
aGUgdmRwYSBkZXZpY2UgYWZ0ZXIgaXRzIHVzZToKPiAkIHZkcGEgZGV2IGRlbCBmb28yCj4KPiBQ
YXRjaCBzdW1tYXJ5Ogo+IFBhdGNoLTEgYWRkcyBrZXJuZWwgaGVhZGVycyBmb3IgdmRwYSBzdWJz
eXN0ZW0KPiBQYXRjaC0yIGFkZHMgbGlicmFyeSByb3V0aW5lcyBmb3IgaW5kZW50IGhhbmRsaW5n
Cj4gUGF0Y2gtMyBhZGRzIGxpYnJhcnkgcm91dGluZXMgZm9yIGdlbmVyaWMgc29ja2V0IGNvbW11
bmljYXRpb24KPiBQQXRjaC00IGFkZHMgbGlicmFyeSByb3V0aW5lIGZvciBudW1iZXIgdG8gc3Ry
aW5nIG1hcHBpbmcKPiBQYXRjaC01IGFkZHMgdmRwYSB0b29sCj4KPiBLZXJuZWwgaGVhZGVycyBh
cmUgZnJvbSB0aGUgdmhvc3Qga2VybmVsIHRyZWUgWzFdIGZyb20gYnJhbmNoIGxpbnV4LW5leHQu
Cj4KPiBbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
bXN0L3Zob3N0LmdpdAo+Cj4gLS0tCgoKQWRkaW5nIEFkcmlhbiB0byBzZWUgaWYgdGhpcyBsb29r
cyBnb29kIGZvciBrOHMgaW50ZWdyYXRpb24uCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
