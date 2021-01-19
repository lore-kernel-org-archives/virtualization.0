Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34670C433DB
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 11:09:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE6C2168B
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 11:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE6C2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3FE981FEED;
	Tue, 19 Jan 2021 11:09:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7eHn1JQTTATN; Tue, 19 Jan 2021 11:09:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9C4452040E;
	Tue, 19 Jan 2021 11:09:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 816FBC088B;
	Tue, 19 Jan 2021 11:09:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7F4AC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C77A0861A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:09:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fSNUYYCJqHG5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:09:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D6C6E86092
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611054562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2fMZZDQuJKWa78kHqWy72u0NbSs/ePOoOI7YgyeE0M=;
 b=HIFE3zTVFrXFBuYGDlTVQxAfvS1JIQD89HXqM213EGUa0vZYLkIj7qDsjPxnXiSCEJqrQl
 99AME3I7GYnfaULQ33E0wjNiRGz5DmffkkwN4Qm/x0/xboTcBuQEfgUMIIuC0QbgN9xRfj
 Ij83qoCBNvR2+pmYa4rhxnEn1+obY3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-xrMHlhRrMF6ofmY135qcAA-1; Tue, 19 Jan 2021 06:09:21 -0500
X-MC-Unique: xrMHlhRrMF6ofmY135qcAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCBF1806662;
 Tue, 19 Jan 2021 11:09:19 +0000 (UTC)
Received: from [10.72.13.139] (ovpn-13-139.pek2.redhat.com [10.72.13.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9475372167;
 Tue, 19 Jan 2021 11:09:13 +0000 (UTC)
Subject: Re: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210105103203.82508-1-parav@nvidia.com>
 <20210105103203.82508-7-parav@nvidia.com>
 <20210105064707-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322E5E7CA71CB2EE0577706DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105071101-mutt-send-email-mst@kernel.org>
 <BY5PR12MB432235169D805760EC0CF7CEDCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105082243-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322EC8D0AD648063C607E17DCAF0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <66dc44ac-52da-eaba-3f5e-69254e42d75b@redhat.com>
 <BY5PR12MB43225D83EA46004E3AF50D3ADCA80@BY5PR12MB4322.namprd12.prod.outlook.com>
 <01213588-d4af-820a-bcf8-c28b8a80c346@redhat.com>
 <BY5PR12MB4322309C33E4871C11535F3CDCA70@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8bc2cf97-3ee4-797a-0ffb-1528b7ce350f@redhat.com>
Date: Tue, 19 Jan 2021 19:09:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4322309C33E4871C11535F3CDCA70@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, Sean Mooney <smooney@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

Ck9uIDIwMjEvMS8xNSDkuIvljYgyOjI3LCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+PiBXaXRoIHRo
YXQgbWFjLCBtdHUgYXMgb3B0aW9uYWwgaW5wdXQgZmllbGRzIHByb3ZpZGUgdGhlIG5lY2Vzc2Fy
eSBmbGV4aWJpbGl0eQo+PiBmb3IgZGlmZmVyZW50IHN0YWNrcyB0byB0YWtlIGFwcHJvcHJpYXRl
IHNoYXBlIGFzIHRoZXkgZGVzaXJlLgo+Pgo+Pgo+PiBUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0
aW9uLiBJIHRoaW5rIHdlJ2QgYmV0dGVyIGRvY3VtZW50IHRoZSBhYm92ZSBpbiB0aGUKPj4gcGF0
Y2ggdGhhdCBpbnRyb2R1Y2VzIHRoZSBtYWMgc2V0dGluZyBmcm9tIG1hbmFnZW1lbnQgQVBJLgo+
IFllcy4gV2lsbCBkby4KPiBUaGFua3MuCgoKQWRkaW5nIFNlYW4uCgpSZWdhcmRpbmcgdG8gbWFj
IGFkZHJlc3Mgc2V0dGluZy4gRG8gd2UgcGxhbiB0byBhbGxvdyB0byBtb2RpZnkgbWFjIAphZGRy
ZXNzIGFmdGVyIHRoZSBjcmVhdGlvbj8gSXQgbG9va3MgbGlrZSBPcGVuc3RhY2sgd2FudHMgdGhp
cy4KClNlYW4gbWF5IHNoYXJlIG1vcmUgaW5mb3JtYXRpb24gb24gdGhpcy4KClRoYW5rcwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
