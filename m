Return-Path: <SRS0=UCi2=GD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0992C433E0
	for <virtualization@archiver.kernel.org>; Thu, 31 Dec 2020 03:52:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F44720799
	for <virtualization@archiver.kernel.org>; Thu, 31 Dec 2020 03:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F44720799
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 33B6C8738D;
	Thu, 31 Dec 2020 03:52:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3jLyxJUVykZj; Thu, 31 Dec 2020 03:52:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E5F48738A;
	Thu, 31 Dec 2020 03:52:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30869C0174;
	Thu, 31 Dec 2020 03:52:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3072DC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 03:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 24C8986E42
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 03:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eOltWcPuLP5e
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 03:52:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C7C7A86D7C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 03:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609386746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WK2g2N52OBXmMOcR7zvVT2FcLYBhxstRgX3djP/XcFw=;
 b=Y1D7NVtuVJEw31gUtnWeURlKuV0nAG1GQyiDInqb9E8m1VOe0KhIyIooi7znjzEPGKeitP
 Dod7OJje6lq1R3qHoAb6jU/DAPlotXyq7gMx6xBmYjBMKU6ciyS0ZOsLUCerOBTWoOAX2n
 QNc7iLT8rAKaLIyrUQE8YaVNg0FvWJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-nsGEDtkxNvWxEfPkdFPNsA-1; Wed, 30 Dec 2020 22:52:21 -0500
X-MC-Unique: nsGEDtkxNvWxEfPkdFPNsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FED08015C4;
 Thu, 31 Dec 2020 03:52:20 +0000 (UTC)
Received: from [10.72.12.236] (ovpn-12-236.pek2.redhat.com [10.72.12.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0B4D27C3C;
 Thu, 31 Dec 2020 03:52:15 +0000 (UTC)
Subject: Re: [PATCH V2 00/19] vDPA driver for virtio-pci device
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20201204040353.21679-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3a3fa2f5-d5d8-e8dd-71d1-cb81a3276658@redhat.com>
Date: Thu, 31 Dec 2020 11:52:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com
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

Ck9uIDIwMjAvMTIvNCDkuIvljYgxMjowMywgSmFzb24gV2FuZyB3cm90ZToKPiBIaSBhbGw6Cj4K
PiBUaGlzIHNlcmllcyB0cmllcyB0byBpbXBsZW1lbnQgYSB2RFBBIGRyaXZlciBmb3IgdmlydGlv
LXBjaSBkZXZpY2UKPiB3aGljaCB3aWxsIGJyaWRnZSBiZXR3ZWVuIHZEUEEgYnVzIGFuZCB2aXJ0
aW8tcGNpIGRldmljZS4KPgo+IFRoaXMgY291bGQgYmUgdXNlZCBmb3IgZnV0dXJlIGZlYXR1cmUg
cHJvdG90eXBpbmcgYW5kIHRlc3RpbmcuCj4KPiBQbGVhc2UgcmV2aWV3Cj4KPiBDaGFuZ2VzIGZy
b20gVjI6Cj4KPiAtIGRvbid0IHRyeSB0byB1c2UgZGV2cmVzIGZvciB2aXJ0aW8tcGNpIGNvcmUK
PiAtIHR3ZWFrIHRoZSBjb21taXQgbG9nCj4gLSBzcGxpdCB0aGUgcGF0Y2hlcyBmdXJ0aGVybHkg
dG8gZWFzZSB0aGUgcmV2aWV3aW5nCj4KPiBDaGFuZ2VzIGZyb20gVjE6Cj4KPiAtIFNwbGl0IGNv
bW1vbiBjb2RlcyBmcm9tIHZpcml0by1wY2kgYW5kIHNoYXJlIGl0IHdpdGggdkRQQSBkcml2ZXIK
PiAtIFVzZSBkeW5hbWljIGlkIGluIG9yZGVyIHRvIGJlIGxlc3MgY29uZnVzaW5nIHdpdGggdmly
dGlvLXBjaSBkcml2ZXIKPiAtIE5vIGZlYXR1cmUgd2hpdGVsaXN0LCBzdXBwb3J0aW5nIGFueSBm
ZWF0dXJlcyAobXEsIGNvbmZpZyBldGMpCj4KPiBUaGFua3MKCgpNaWNoYWVsLCBhbnkgY29tbWVu
dCBmb3IgdGhpcyBzZXJpZXM/CgpJdCdzIG5lZWRlZCBmb3IgdGVzdGluZyBkb29yYmVsbCBtYXBw
aW5nIGFuZCBjb25maWcgaW50ZXJydXB0IHN1cHBvcnQuCgpUaGFua3MKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
