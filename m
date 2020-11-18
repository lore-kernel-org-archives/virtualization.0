Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6126C56202
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 09:40:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17370206FA
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 09:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiRVW2xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17370206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5648987201;
	Wed, 18 Nov 2020 09:40:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cnd9K61aH+f8; Wed, 18 Nov 2020 09:40:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BF2D0871CA;
	Wed, 18 Nov 2020 09:40:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FA62C0891;
	Wed, 18 Nov 2020 09:40:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2D5CC07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CBD11204F5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:40:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u0S3HkjND0zM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:40:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id AB7EB20497
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605692402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8YUHjCb6T+duwkVVqtutOFcmHYQOlclmLV2nizfmVHg=;
 b=HiRVW2xjpKa/i9erD3sDc184C+ca06hvsYxY3j6UIPh/URFmbJa/VRs0pnT5bAQON3B87g
 hisHCgUD/tkZzFSQmoSIVP1hBg4TeAwgodWhsImfdjGD+FHKzrPiUWmDTJoXbo+MGnfiYN
 yRZF5Mvtz75c5XIlIneqmQSm4BBg/EE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-eJe0u6hPPU2DjFdLdYSYRg-1; Wed, 18 Nov 2020 04:40:00 -0500
X-MC-Unique: eJe0u6hPPU2DjFdLdYSYRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2459100855E;
 Wed, 18 Nov 2020 09:39:58 +0000 (UTC)
Received: from [10.72.12.138] (ovpn-12-138.pek2.redhat.com [10.72.12.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D14E655762;
 Wed, 18 Nov 2020 09:39:52 +0000 (UTC)
Subject: Re: [PATCH net] vhost_vdpa: Return -EFUALT if copy_from_user() fails
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20201023120853.GI282278@mwanda>
 <20201023113326-mutt-send-email-mst@kernel.org>
 <4485cc8d-ac69-c725-8493-eda120e29c41@redhat.com>
 <e7242333-b364-c2d8-53f5-1f688fc4d0b5@redhat.com>
 <20201118035912-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4ac146a2-a3db-abc7-73a0-98f71119de3d@redhat.com>
Date: Wed, 18 Nov 2020 17:39:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118035912-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kuba@kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
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

Ck9uIDIwMjAvMTEvMTgg5LiL5Y2INDo1OSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFdlZCwgTm92IDE4LCAyMDIwIGF0IDAyOjA4OjE3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IE9uIDIwMjAvMTAvMjYg5LiK5Y2IMTA6NTksIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBPbiAy
MDIwLzEwLzIzIOS4i+WNiDExOjM0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4gT24g
RnJpLCBPY3QgMjMsIDIwMjAgYXQgMDM6MDg6NTNQTSArMDMwMCwgRGFuIENhcnBlbnRlciB3cm90
ZToKPj4+Pj4gVGhlIGNvcHlfdG8vZnJvbV91c2VyKCkgZnVuY3Rpb25zIHJldHVybiB0aGUgbnVt
YmVyIG9mIGJ5dGVzIHdoaWNoIHdlCj4+Pj4+IHdlcmVuJ3QgYWJsZSB0byBjb3B5IGJ1dCB0aGUg
aW9jdGwgc2hvdWxkIHJldHVybiAtRUZBVUxUIGlmIHRoZXkgZmFpbC4KPj4+Pj4KPj4+Pj4gRml4
ZXM6IGExMjdjNWJiYjZhOCAoInZob3N0LXZkcGE6IGZpeCBiYWNrZW5kIGZlYXR1cmUgaW9jdGxz
IikKPj4+Pj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFj
bGUuY29tPgo+Pj4+IEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
Pgo+Pj4+IE5lZWRlZCBmb3Igc3RhYmxlIEkgZ3Vlc3MuCj4+Pgo+Pj4gQWdyZWUuCj4+Pgo+Pj4g
QWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+Cj4+IEhpIE1pY2hh
ZWwuCj4+Cj4+IEkgZG9uJ3Qgc2VlIHRoaXMgaW4geW91ciB0cmVlLCBwbGVhc2UgY29uc2lkZXIg
dG8gbWVyZ2UuCj4+Cj4+IFRoYW5rcwo+Pgo+IEkgZG8gc2VlIGl0IHRoZXJlOgo+Cj4gY29tbWl0
IDc5MjI0NjBlMzNjODFmNDFlMGQyNDIxNDE3MjI4YjMyZTZmZGJlOTQKPiBBdXRob3I6IERhbiBD
YXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4KPiBEYXRlOiAgIEZyaSBPY3QgMjMg
MTU6MDg6NTMgMjAyMCArMDMwMAo+Cj4gICAgICB2aG9zdF92ZHBhOiBSZXR1cm4gLUVGQVVMVCBp
ZiBjb3B5X2Zyb21fdXNlcigpIGZhaWxzCj4gICAgICAKPiB0aGUgcmVhc29uIHlvdSBjYW4ndCBm
aW5kIGl0IGlzIHByb2JhYmx5IGJlY2F1c2UgSSBmaXhlZCB1cAo+IGEgdHlwbyBpbiB0aGUgc3Vi
amVjdC4KCgpJIHNlZSB0aGF0LgoKVGhhbmtzCgoKPgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
