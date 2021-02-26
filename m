Return-Path: <SRS0=m8lA=H4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B30C433DB
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 08:33:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52B264EE3
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 08:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52B264EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EAA384151;
	Fri, 26 Feb 2021 08:33:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iPb5UDx0EJ6c; Fri, 26 Feb 2021 08:33:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED171840E3;
	Fri, 26 Feb 2021 08:33:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BACE7C000A;
	Fri, 26 Feb 2021 08:33:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C43AC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74952431CD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OTj9vMfSQt7g
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:33:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 749D1431CA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614328409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=011w3KKnCyPcKscYU2ygb7MrGcytv7jVh+90/CrRMwQ=;
 b=RyT5EYFY35D4GWdkiiRDdQE4WytFLmSHFKv4Fiuhv8P3DQCLMN6GwHae1YDh0vxRvRstbO
 BaXYPJ2kU4gd60e6vyMctRtgJ5EHfn18lIlJ4jRh6M1gWbxezlxZV7ZZETuirpkPv4dnZj
 APLnQU/hlc3VFdxFaio7rJL8f1scK4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-EgyozB7IM765hz0TcUfnMQ-1; Fri, 26 Feb 2021 03:33:24 -0500
X-MC-Unique: EgyozB7IM765hz0TcUfnMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ACFF18B62A3;
 Fri, 26 Feb 2021 08:33:21 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-20.pek2.redhat.com
 [10.72.12.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B723910016FF;
 Fri, 26 Feb 2021 08:33:16 +0000 (UTC)
Subject: Re: [PATCH linux-next 1/9] vdpa_sim: Consider read only supported
 features instead of current
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-2-parav@nvidia.com>
 <20210224020336-mutt-send-email-mst@kernel.org>
 <BY5PR12MB43223107467FBA270BE072F2DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <92e4eeaa-b54e-803d-bb5b-74071257353f@redhat.com>
Date: Fri, 26 Feb 2021 16:33:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB43223107467FBA270BE072F2DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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

Ck9uIDIwMjEvMi8yNiAzOjM2IOS4i+WNiCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+IEhpIE1pY2hh
ZWwsIEphc29uLAo+Cj4+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+
Cj4+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjQsIDIwMjEgMTI6NDAgUE0KPj4KPj4gT24g
V2VkLCBGZWIgMjQsIDIwMjEgYXQgMDg6MTg6MzZBTSArMDIwMCwgUGFyYXYgUGFuZGl0IHdyb3Rl
Ogo+Pj4gVG8gaG9ub3IgVklSVElPX0ZfVkVSU0lPTl8xIGZlYXR1cmUgYml0LCBkdXJpbmcgZW5k
aWFubmVzcyBkZXRlY3Rpb24sCj4+PiBjb25zaWRlciB0aGUgcmVhZCBvbmx5IHN1cHBvcnRlZCBm
ZWF0dXJlcyBiaXQgaW5zdGVhZCBvZiBjdXJyZW50Cj4+PiBmZWF0dXJlcyBiaXQgd2hpY2ggY2Fu
IGJlIG1vZGlmaWVkIGJ5IHRoZSBkcml2ZXIuCj4+Pgo+Pj4gVGhpcyBlbmFibGVzIHZkcGFfc2lt
X25ldCBkcml2ZXIgdG8gaW52b2tlIGNwdV90b192ZHBhc2ltMTYoKSBlYXJseQo+Pj4gZW5vdWdo
IGp1c3QgYWZ0ZXIgdmRwYXNpbSBkZXZpY2UgY3JlYXRpb24gaW4gc3Vic2VxdWVudCBwYXRjaC4K
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cj4+
PiBSZXZpZXdlZC1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4+IFdlbGwgdGhhdCB3
b3JrcyBmb3IgbGVnYWN5IGFuZCBtb2Rlcm4gZGV2aWNlcyBidXQgbm90IGZvciB0cmFuc2l0aW9u
YWwgb25lcy4KPj4gV2l0aG91dCB0cmFuc2l0aW9uYWwgZGV2aWNlIHN1cHBvcnQgdmVuZG9ycyBh
cmUgcmVsdWN0YW50IHRvIGFkZCBtb2Rlcm4KPj4gZmVhdHVyZXMgc2luY2UgdGhhdCB3aWxsIGJy
ZWFrIG9sZCBndWVzdHMgLi4uICBJIHN1c3BlY3Qgd2UgbmVlZCB0byBlaXRoZXIgYWRkIGEKPj4g
bmV3IGlvY3RsIGVuYWJsaW5nIG1vZGVybiBtb2RlLCBvciBhYnVzZSBTRVRfRkVBVFVSRVMgYW5k
IGNhbGwgaXQgZnJvbQo+PiBxZW11IG9uIGZpcnN0IGNvbmZpZyBzcGFjZSBhY2Nlc3MuCj4+Cj4g
IEZyb20gbWdtdCB0b29sIGtlcm5lbCBwb2ludCBvZiB2aWV3LAo+IChhKSBjb25maWcgc3BhY2Ug
ZGVjb2RpbmcgZGVwZW5kcyBvbiBjdXJyZW50IGZlYXR1cmUgdmVyc2lvbiBiaXQKPiAoYikgZmVh
dHVyZSBnZXQvc2V0IGFuZCBjb25maWcgcmVhZCBhcmUgbm90IGF0b21pYyBjYWxsYmFja3MKPgo+
IE1nbXQuIHRvb2wga2VybmVsIGNvZGUgbmVlZCB0byByZWFkIHRoZW0gaW4gc2luZ2xlIGNhbGwg
ZnJvbSB0aGUgdmVuZG9yIGRyaXZlci4KPiBJIG5lZWQgdG8gYWRkIG1nbXRfZGV2LT5vcHMtPmdl
dF9mZWF0dXJlc19jb25maWcoc3RydWN0IHZpcnRpb19mZWF0dXJlc19jb25maWcqKSBjYWxsbGJh
Y2sgdGhhdCByZXR1cm5zIHZhbHVlIG9mIGJvdGggYXRvbWljYWxseSBpbiBzdHJ1Y3R1cmUgbGlr
ZSBiZWxvdy4KPgo+IHN0cnVjdCB2aXJ0aW9fZmVhdHVyZXNfY29uZmlnIHsKPiAJdTY0IGZlYXR1
cmVzOwo+IAl1bmlvbiB7Cj4gCQlzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgbmV0Owo+IAkJc3Ry
dWN0IHZpcnRpb19ibG9ja19jb25maWcgYmxrOwo+IAl9IHU7Cj4gfQo+Cj4gV2hhdCBkbyB5b3Ug
dGhpbms/CgoKSSdtIHdhaXQgZm9yIE1pY2hhZWwgdG8gY2xhaXJmeSBob3cgdGhlIGRlcGVuZGVu
Y3kgd2lsbCBsb29rIGxpa2UuIEUuZyAKd2l0aG91dCBtdWx0aXF1ZXVlLCBzaG91bGQgd2UgY29u
c2lkZXIgdGhlIGNvbmZpZyBhczoKCnN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyB7CiDCoMKgwqDC
oMKgwqDCoCB1OCBtYWNbNl07CiDCoMKgwqDCoMKgwqDCoCBsZTE2IHN0YXR1czsKIMKgwqDCoMKg
wqDCoMKgIGxlMTYgcmVzZXJ2ZWQ7CiDCoMKgwqDCoMKgwqDCoCBsZTE2IG10dTsKfTsKCm9yCgpz
dHJ1Y3QgdmlydGlvX25ldF9jb25maWcgewogwqDCoMKgwqDCoMKgwqAgdTggbWFjWzZdOwogwqDC
oMKgwqDCoMKgwqAgbGUxNiBzdGF0dXM7CiDCoMKgwqDCoMKgwqDCoCBsZTE2IG10dTsKfTsKCkFu
ZCBJIHdvbmRlciB3aGV0aGVyIG9yIG5vdCB0byByZXVzZSBjb25maWcgaXMgdGhlIGJlc3QgY2hv
aWNlIHdoaWNoIApuZWVkcyB0byBkZWFsIHdpdGggZmVhdHVyZS4KClRoYW5rcwoKCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
