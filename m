Return-Path: <SRS0=RIAz=EB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4C7C4363A
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 02:45:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34962087C
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 02:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRoW/AGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34962087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3FEB9203DD;
	Mon, 26 Oct 2020 02:45:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zEFwYPNazZn6; Mon, 26 Oct 2020 02:45:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7F9A6276D4;
	Mon, 26 Oct 2020 02:45:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60921C0859;
	Mon, 26 Oct 2020 02:45:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6AE9C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 02:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8E52A871C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 02:45:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O8rXFlXCYf6l
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 02:45:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 31437871AF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 02:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603680336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kiy/scF/hlp1wouCLACe5uKilF+W+fUexE2l1/eWOxo=;
 b=CRoW/AGhUTEBAsbDLQ784NWo1DHS7YoWf6bIZz+c0bfsWI0ZA5xIPV4zAHYiwz3nu6Apo6
 lNdh7DNOXvnFGqVb2Y4nBQhkmJHeNmEAoJe0B3gB1BVsLEdBS4VHJxuLb+5/oAjvy8nTA1
 MEpKnvdsniyHvqy3DrYT4iGAPJAmMzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-xmmeefaqPMqyLvjBjDhZ-Q-1; Sun, 25 Oct 2020 22:45:34 -0400
X-MC-Unique: xmmeefaqPMqyLvjBjDhZ-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45391835B8E;
 Mon, 26 Oct 2020 02:45:33 +0000 (UTC)
Received: from [10.72.13.201] (ovpn-13-201.pek2.redhat.com [10.72.13.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A04A60C05;
 Mon, 26 Oct 2020 02:45:28 +0000 (UTC)
Subject: Re: [PATCH] vdpa: handle irq bypass register failure case
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20201023104046.404794-1-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bf3d5114-c55f-80e6-41b0-b7f5ae8ad9e9@redhat.com>
Date: Mon, 26 Oct 2020 10:45:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023104046.404794-1-lingshan.zhu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTAvMjMg5LiL5Y2INjo0MCwgWmh1IExpbmdzaGFuIHdyb3RlOgo+IExLUCBjb25z
aWRlcmVkIHZhcmlhYmxlICdyZXQnIGluIHZob3N0X3ZkcGFfc2V0dXBfdnFfaXJxKCkgYXMKPiBh
IHVudXNlZCB2YXJpYWJsZSwgc28gc3VnZ2VzdCB3ZSByZW1vdmUgaXQuIEFjdHVhbGx5IGl0IHN0
b3Jlcwo+IHJldHVybiB2YWx1ZSBvZiBpcnFfYnlwYXNzX3JlZ2lzdGVyX3Byb2R1Y2VyKCksIGJ1
dCB3ZSBkaWQgbm90Cj4gY2hlY2sgaXQsIHdlIHNob3VsZCBoYW5kbGUgdGhlIGZhaWx1cmUgY2Fz
ZS4KPgo+IFRoaXMgY29tbWl0IHdpbGwgcHJpbnQgYSBtZXNzYWdlIGlmIGlycSBieXBhc3MgcmVn
aXN0ZXIgcHJvZHVjZXIKPiBmYWlsLCBpbiB0aGlzIGNhc2UsIHZxcyBzdGlsbCByZW1haW4gZnVu
Y3Rpb25hbC4KPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGlu
dGVsLmNvbT4KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDMgKysrCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMg
Yi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IGluZGV4IDYyYTliYjBlZmM1NS4uZDZiMmMzYmQxYjAx
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9z
dC92ZHBhLmMKPiBAQCAtMTA3LDYgKzEwNyw5IEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfc2V0
dXBfdnFfaXJxKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MTYgcWlkKQo+ICAgCXZxLT5jYWxsX2N0
eC5wcm9kdWNlci50b2tlbiA9IHZxLT5jYWxsX2N0eC5jdHg7Cj4gICAJdnEtPmNhbGxfY3R4LnBy
b2R1Y2VyLmlycSA9IGlycTsKPiAgIAlyZXQgPSBpcnFfYnlwYXNzX3JlZ2lzdGVyX3Byb2R1Y2Vy
KCZ2cS0+Y2FsbF9jdHgucHJvZHVjZXIpOwo+ICsJaWYgKHVubGlrZWx5KHJldCkpCj4gKwkJZGV2
X2luZm8oJnYtPmRldiwgInZxICV1LCBpcnEgYnlwYXNzIHByb2R1Y2VyICh0b2tlbiAlcCkgcmVn
aXN0cmF0aW9uIGZhaWxzLCByZXQgPSAgJWRcbiIsCj4gKwkJCSBxaWQsIHZxLT5jYWxsX2N0eC5w
cm9kdWNlci50b2tlbiwgcmV0KTsKPiAgIAlzcGluX3VubG9jaygmdnEtPmNhbGxfY3R4LmN0eF9s
b2NrKTsKPiAgIH0KPiAgIAoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
