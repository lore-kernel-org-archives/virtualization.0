Return-Path: <SRS0=4MNw=EI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4F7C00A89
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 05:57:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D14207BB
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 05:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hwlw6fiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D14207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 83B53204CC;
	Mon,  2 Nov 2020 05:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fdq+RyJ7NcaY; Mon,  2 Nov 2020 05:57:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8841A20119;
	Mon,  2 Nov 2020 05:57:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EBABC0889;
	Mon,  2 Nov 2020 05:57:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEA94C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 05:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AAD3A85C19
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 05:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qN5dzTjoS5gA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 05:57:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E33EE85C28
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 05:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604296638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Chvvc87ZiQGdVbH/KclajGTi8q9ae76wxWdLpfbOgtM=;
 b=Hwlw6fiHQXlXtUmpN2OC5UKCvjXlLxvoWv7ORegDNVxXuefvazAl9dIPMgLcX4bWW199Wy
 cVPXXQH/7autvefvHXzFhm1ZEDkVPhTIgWwoQzXtXoX8cgm9OdpdinOHKgIiDkK8drH7hZ
 3NWA1k4jABNYCDSGJw9JiY92xn3cyBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374--oFwCbQCN82weSN9FUtC5w-1; Mon, 02 Nov 2020 00:57:14 -0500
X-MC-Unique: -oFwCbQCN82weSN9FUtC5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E0C81074651;
 Mon,  2 Nov 2020 05:57:13 +0000 (UTC)
Received: from [10.72.13.42] (ovpn-13-42.pek2.redhat.com [10.72.13.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 317F560C15;
 Mon,  2 Nov 2020 05:57:03 +0000 (UTC)
Subject: Re: [PATCH 04/17] vhost: prep vhost_dev_init users to handle failures
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mst@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-5-git-send-email-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0f4a5f72-01e7-46d1-f214-c61cbb812859@redhat.com>
Date: Mon, 2 Nov 2020 13:57:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603326903-27052-5-git-send-email-michael.christie@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Ck9uIDIwMjAvMTAvMjIg5LiK5Y2IODozNCwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPiBUaGlzIGlz
IGp1c3QgYSBwcmVwIHBhdGNoIHRvIGdldCB2aG9zdF9kZXZfaW5pdCBjYWxsZXJzIHJlYWR5IHRv
IGhhbmRsZQo+IHRoZSBuZXh0IHBhdGNoIHdoZXJlIHRoZSBmdW5jdGlvbiBjYW4gZmFpbC4gSW4g
dGhpcyBwYXRjaCB2aG9zdF9kZXZfaW5pdAo+IGp1c3QgcmV0dXJucyAwLCBidXQgSSB0aGluayBp
dCdzIGVhc2llciB0byBjaGVjayBmb3IgZ290by9lcnJvciBoYW5kbGluZwo+IGVycm9ycyBzZXBh
cmF0ZWQgZnJvbSB0aGUgbmV4dCBwYXRjaC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pa2UgQ2hyaXN0
aWU8bWljaGFlbC5jaHJpc3RpZUBvcmFjbGUuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC9u
ZXQuYyAgIHwgMTEgKysrKysrKy0tLS0KPiAgIGRyaXZlcnMvdmhvc3Qvc2NzaS5jICB8ICA3ICsr
KysrLS0KPiAgIGRyaXZlcnMvdmhvc3QvdGVzdC5jICB8ICA5ICsrKysrKystLQo+ICAgZHJpdmVy
cy92aG9zdC92ZHBhLmMgIHwgIDcgKysrKystLQo+ICAgZHJpdmVycy92aG9zdC92aG9zdC5jIHwg
MTQgKysrKysrKystLS0tLS0KPiAgIGRyaXZlcnMvdmhvc3Qvdmhvc3QuaCB8IDEwICsrKysrLS0t
LS0KPiAgIGRyaXZlcnMvdmhvc3QvdnNvY2suYyB8ICA5ICsrKysrKy0tLQo+ICAgNyBmaWxlcyBj
aGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKCgpBY2tlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
