Return-Path: <SRS0=Cd1r=BK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F69C433E0
	for <virtualization@archiver.kernel.org>; Fri, 31 Jul 2020 03:18:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA1E207F5
	for <virtualization@archiver.kernel.org>; Fri, 31 Jul 2020 03:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bx5OKTEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA1E207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AE60888713;
	Fri, 31 Jul 2020 03:18:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gj3iNG6io58y; Fri, 31 Jul 2020 03:18:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 83F3588689;
	Fri, 31 Jul 2020 03:18:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7680AC004F;
	Fri, 31 Jul 2020 03:18:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F748C004D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 03:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5AFCD869DD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 03:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZfMOlj7epT9w
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 03:18:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AC249869D9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 03:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596165534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oeb1VKsxkfGqpmZlCJj7NjGP59zOgyrbLbbbEHSWF0Q=;
 b=bx5OKTEJ6vZtpE3vKEKJNv2yoWOgop1CdN9RVLp1vF7BK2slVOT0YZyaTKVR6C6cXEX3Ye
 kox4noBHCyaXhcY8MdqSYjen+sl8xlsS50oIXKfL8FQQDmfzXoKlyqwD3JulebIN75obaZ
 ZeoyZpoakHQC82IGY9GCvfdGoH9H3kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-Ho6C2Ek9N0mJD3NRhSS_PQ-1; Thu, 30 Jul 2020 23:18:52 -0400
X-MC-Unique: Ho6C2Ek9N0mJD3NRhSS_PQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4611118839C1;
 Fri, 31 Jul 2020 03:18:51 +0000 (UTC)
Received: from [10.72.13.197] (ovpn-13-197.pek2.redhat.com [10.72.13.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E61355F7D8;
 Fri, 31 Jul 2020 03:18:41 +0000 (UTC)
Subject: Re: [PATCH V4 0/6] IRQ offloading for vDPA
To: Zhu Lingshan <lingshan.zhu@intel.com>, alex.williamson@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com,
 wanpengli@tencent.com
References: <20200728042405.17579-1-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d3a12faa-44b5-1c1b-2047-7b39863d82a7@redhat.com>
Date: Fri, 31 Jul 2020 11:18:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728042405.17579-1-lingshan.zhu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: shahafs@mellanox.com, parav@mellanox.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eli@mellanox.com
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

Ck9uIDIwMjAvNy8yOCDkuIvljYgxMjoyMywgWmh1IExpbmdzaGFuIHdyb3RlOgo+IFRoaXMgc2Vy
aWVzIGludGVuZHMgdG8gaW1wbGVtZW50IElSUSBvZmZsb2FkaW5nIGZvcgo+IHZob3N0X3ZkcGEu
Cj4KPiBCeSB0aGUgZmVhdCBvZiBpcnEgZm9yd2FyZGluZyBmYWNpbGl0aWVzIGxpa2UgcG9zdGVk
Cj4gaW50ZXJydXB0IG9uIFg4NiwgaXJxIGJ5cGFzcyBjYW4gIGhlbHAgZGVsaXZlcgo+IGludGVy
cnVwdHMgdG8gdkNQVSBkaXJlY3RseS4KPgo+IHZEUEEgZGV2aWNlcyBoYXZlIGRlZGljYXRlZCBo
YXJkd2FyZSBiYWNrZW5kcyBsaWtlIFZGSU8KPiBwYXNzLXRocm91Z2hlZCBkZXZpY2VzLiBTbyBp
dCB3b3VsZCBiZSBwb3NzaWJsZSB0byBzZXR1cAo+IGlycSBvZmZsb2FkaW5nKGlycSBieXBhc3Mp
IGZvciB2RFBBIGRldmljZXMgYW5kIGdhaW4KPiBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudHMuCj4K
PiBJbiBteSB0ZXN0aW5nLCB3aXRoIHRoaXMgZmVhdHVyZSwgd2UgY2FuIHNhdmUgMC4xbXMKPiBp
biBhIHBpbmcgYmV0d2VlbiB0d28gVkZzIG9uIGF2ZXJhZ2UuCj4gY2hhbmdlcyBmcm9tIFYzOgo+
ICgxKXJlbW92ZWQgdkRQQSBpcnEgYWxsb2NhdGUvZnJlZSBoZWxwZXJzIGluIHZEUEEgY29yZS4K
PiAoMilhZGQgYSBuZXcgZnVuY3Rpb24gZ2V0X3ZxX2lycSgpIGluIHN0cnVjdCB2ZHBhX2NvbmZp
Z19vcHMsCj4gdXBwZXIgbGF5ZXIgZHJpdmVyIGNhbiB1c2UgdGhpcyBmdW5jdGlvbiB0bzogQS4g
cXVlcnkgdGhlCj4gaXJxIG51bWJuZXIgb2YgYSB2cS4gQi4gZGV0ZWN0IHdoZXRoZXIgYSB2cSBp
cyBlbmFibGVkLgo+ICgzKWltcGxlbWVudCBnZXRfdnFfaXJxKCkgaW4gaWZjdmYgZHJpdmVyLgo+
ICg0KWluIHZob3N0X3ZkcGEsIHNldF9zdGF0dXMoKSB3aWxsIHNldHVwIGlycSBvZmZsb2FkaW5n
IHdoZW4KPiBzZXR0aW5nIERSSVZFUl9PSywgYW5kIHVuc2V0dXAgd2hlbiByZWNlaXZlICFEUklW
RVJfT0suCj4gKDUpbWlub3IgaW1wcm92ZW1lbnRzLgoKCk9rLCBJIHRoaW5rIHlvdSBjYW4gZ28g
YWhlYWQgdG8gcG9zdCBhIFY1LiBJdCdzIG5vdCBiYWQgdG8gc3RhcnQgd2l0aCAKZ2V0X3ZxX2ly
cSgpIGFuZCB3ZSBjYW4gZG8gYW55IGNoYW5nZXMgYWZ0ZXJ3YXJkcyBpZiBpdCBjYW4gd29yayBm
b3IgCnNvbWUgY2FzZXMuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
