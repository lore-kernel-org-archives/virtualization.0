Return-Path: <SRS0=VcnQ=GR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D452BC433DB
	for <virtualization@archiver.kernel.org>; Thu, 14 Jan 2021 04:18:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3527923107
	for <virtualization@archiver.kernel.org>; Thu, 14 Jan 2021 04:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3527923107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A6418693D;
	Thu, 14 Jan 2021 04:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZiveSKwcpbX; Thu, 14 Jan 2021 04:18:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E10048693C;
	Thu, 14 Jan 2021 04:18:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF150C088B;
	Thu, 14 Jan 2021 04:18:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C707CC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 04:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A59EE20401
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 04:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BR268jtIlemv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 04:18:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 653A2203F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 04:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610597884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eRMqhJYEIzS7qqs8p7MdIVwG7fzXeZHJWGj3Ki4v9wE=;
 b=TpEOS7Ti/aGokUC/sUZo9wJu5hTAS63KGMKWo4j6OTTva0lXZWftxgkCqRWfZoaMYSdUGR
 CDxe1Pc2tP93DPLl+cyjCdalYyOFFXi9ZX9FEr0a5Kw5q5dR6W7xB7OBC/niF1FLEwxyJl
 DOfzxqM0q0iXCyCCrdj8Uh+u1BS4dfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-ci9WnyBDP6-D8H5oYr2dIw-1; Wed, 13 Jan 2021 23:18:03 -0500
X-MC-Unique: ci9WnyBDP6-D8H5oYr2dIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CED44107ACF7;
 Thu, 14 Jan 2021 04:18:01 +0000 (UTC)
Received: from [10.72.12.100] (ovpn-12-100.pek2.redhat.com [10.72.12.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34F64614FA;
 Thu, 14 Jan 2021 04:17:54 +0000 (UTC)
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <66dc44ac-52da-eaba-3f5e-69254e42d75b@redhat.com>
Date: Thu, 14 Jan 2021 12:17:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4322EC8D0AD648063C607E17DCAF0@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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

Ck9uIDIwMjEvMS83IOS4iuWNiDExOjQ4LCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4KPj4gRnJvbTog
TWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPj4gU2VudDogVHVlc2RheSwgSmFu
dWFyeSA1LCAyMDIxIDY6NTMgUE0KPj4KPj4gT24gVHVlLCBKYW4gMDUsIDIwMjEgYXQgMTI6MzA6
MTVQTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Pj4KPj4+PiBGcm9tOiBNaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+Pj4+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgNSwg
MjAyMSA1OjQ1IFBNCj4+Pj4KPj4+PiBPbiBUdWUsIEphbiAwNSwgMjAyMSBhdCAxMjowMjozM1BN
ICswMDAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4+Cj4+Pj4+PiBGcm9tOiBNaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+Pj4+Pj4gU2VudDogVHVlc2RheSwgSmFudWFyeSA1
LCAyMDIxIDU6MTkgUE0KPj4+Pj4+Cj4+Pj4+PiBPbiBUdWUsIEphbiAwNSwgMjAyMSBhdCAxMjoz
MjowM1BNICswMjAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4+Pj4gRW5hYmxlIHVzZXIgdG8g
Y3JlYXRlIHZkcGFzaW0gbmV0IHNpbXVsYXRlIGRldmljZXMuCj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+
Pj4+ICQgdmRwYSBkZXYgYWRkIG1nbXRkZXYgdmRwYXNpbV9uZXQgbmFtZSBmb28yCj4+Pj4+Pj4K
Pj4+Pj4+PiBTaG93IHRoZSBuZXdseSBjcmVhdGVkIHZkcGEgZGV2aWNlIGJ5IGl0cyBuYW1lOgo+
Pj4+Pj4+ICQgdmRwYSBkZXYgc2hvdyBmb28yCj4+Pj4+Pj4gZm9vMjogdHlwZSBuZXR3b3JrIG1n
bXRkZXYgdmRwYXNpbV9uZXQgdmVuZG9yX2lkIDAgbWF4X3ZxcyAyCj4+Pj4+Pj4gbWF4X3ZxX3Np
emUgMjU2Cj4+Pj4+Pj4KPj4+Pj4+PiAkIHZkcGEgZGV2IHNob3cgZm9vMiAtanAKPj4+Pj4+PiB7
Cj4+Pj4+Pj4gICAgICAiZGV2Ijogewo+Pj4+Pj4+ICAgICAgICAgICJmb28yIjogewo+Pj4+Pj4+
ICAgICAgICAgICAgICAidHlwZSI6ICJuZXR3b3JrIiwKPj4+Pj4+PiAgICAgICAgICAgICAgIm1n
bXRkZXYiOiAidmRwYXNpbV9uZXQiLAo+Pj4+Pj4+ICAgICAgICAgICAgICAidmVuZG9yX2lkIjog
MCwKPj4+Pj4+PiAgICAgICAgICAgICAgIm1heF92cXMiOiAyLAo+Pj4+Pj4+ICAgICAgICAgICAg
ICAibWF4X3ZxX3NpemUiOiAyNTYKPj4+Pj4+PiAgICAgICAgICB9Cj4+Pj4+Pj4gICAgICB9Cj4+
Pj4+Pj4gfQo+Pj4+Pj4KPj4+Pj4+IEknZCBsaWtlIGFuIGV4YW1wbGUgb2YgaG93IGRvIGRldmlj
ZSBzcGVjaWZpYyAoZS5nLiBuZXQKPj4+Pj4+IHNwZWNpZmljKSBpbnRlcmZhY2VzIHRpZSBpbiB0
byB0aGlzLgo+Pj4+PiBOb3Qgc3VyZSBJIGZvbGxvdyB5b3VyIHF1ZXN0aW9uLgo+Pj4+PiBEbyB5
b3UgbWVhbiBob3cgdG8gc2V0IG1hYyBhZGRyZXNzIG9yIG10dSBvZiB0aGlzIHZkcGEgZGV2aWNl
IG9mCj4+Pj4+IHR5cGUKPj4+PiBuZXQ/Cj4+Pj4+IElmIHNvLCBkZXYgYWRkIGNvbW1hbmQgd2ls
bCBiZSBleHRlbmRlZCBzaG9ydGx5IGluIHN1YnNlcXVlbnQKPj4+Pj4gc2VyaWVzIHRvCj4+Pj4g
c2V0IHRoaXMgbmV0IHNwZWNpZmljIGF0dHJpYnV0ZXMuCj4+Pj4+IChJIGRpZCBtZW50aW9uIGlu
IHRoZSBuZXh0IHN0ZXBzIGluIGNvdmVyIGxldHRlcikuCj4+Pj4+Cj4+Pj4+Pj4gK3N0YXRpYyBp
bnQgX19pbml0IHZkcGFzaW1fbmV0X2luaXQodm9pZCkgewo+Pj4+Pj4+ICsJaW50IHJldDsKPj4+
Pj4+PiArCj4+Pj4+Pj4gKwlpZiAobWFjYWRkcikgewo+Pj4+Pj4+ICsJCW1hY19wdG9uKG1hY2Fk
ZHIsIG1hY2FkZHJfYnVmKTsKPj4+Pj4+PiArCQlpZiAoIWlzX3ZhbGlkX2V0aGVyX2FkZHIobWFj
YWRkcl9idWYpKQo+Pj4+Pj4+ICsJCQlyZXR1cm4gLUVBRERSTk9UQVZBSUw7Cj4+Pj4+Pj4gKwl9
IGVsc2Ugewo+Pj4+Pj4+ICsJCWV0aF9yYW5kb21fYWRkcihtYWNhZGRyX2J1Zik7Cj4+Pj4+Pj4g
ICAJfQo+Pj4+Pj4gSG1tIHNvIGFsbCBkZXZpY2VzIHN0YXJ0IG91dCB3aXRoIHRoZSBzYW1lIE1B
QyB1bnRpbCBjaGFuZ2VkPwo+Pj4+Pj4gQW5kIGhvdyBpcyB0aGUgY2hhbmdlIGVmZmVjdGVkPwo+
Pj4+PiBQb3N0IHRoaXMgcGF0Y2hzZXQgYW5kIHBvc3Qgd2UgaGF2ZSBpcHJvdXRlMiB2ZHBhIGlu
IHRoZSB0cmVlLAo+Pj4+PiB3aWxsIGFkZCB0aGUKPj4+PiBtYWMgYWRkcmVzcyBhcyB0aGUgaW5w
dXQgYXR0cmlidXRlIGR1cmluZyAidmRwYSBkZXYgYWRkIiBjb21tYW5kLgo+Pj4+PiBTbyB0aGF0
IGVhY2ggZGlmZmVyZW50IHZkcGEgZGV2aWNlIGNhbiBoYXZlIHVzZXIgc3BlY2lmaWVkCj4+Pj4+
IChkaWZmZXJlbnQpIG1hYwo+Pj4+IGFkZHJlc3MuCj4+Pj4KPj4+PiBGb3Igbm93IG1heWJlIGp1
c3QgYXZvaWQgVklSVElPX05FVF9GX01BQyB0aGVuIGZvciBuZXcgZGV2aWNlcwo+PiB0aGVuPwo+
Pj4gVGhhdCB3b3VsZCByZXF1aXJlIGJvb2sga2VlcGluZyBleGlzdGluZyBuZXQgdmRwYV9zaW0g
ZGV2aWNlcyBjcmVhdGVkIHRvCj4+IGF2b2lkIHNldHRpbmcgVklSVElPX05FVF9GX01BQy4KPj4+
IFN1Y2ggYm9vayBrZWVwaW5nIGNvZGUgd2lsbCBiZSBzaG9ydCBsaXZlZCBhbnl3YXkuCj4+PiBO
b3Qgc3VyZSBpZiBpdHMgd29ydGggaXQuCj4+PiBVbnRpbCBub3cgb25seSBvbmUgZGV2aWNlIHdh
cyBjcmVhdGVkLiBTbyBub3Qgc3VyZSB0d28gdmRwYSBkZXZpY2VzIHdpdGgKPj4gc2FtZSBtYWMg
YWRkcmVzcyB3aWxsIGJlIGEgcmVhbCBpc3N1ZS4KPj4+IFdoZW4gd2UgYWRkIG1hYyBhZGRyZXNz
IGF0dHJpYnV0ZSBpbiBhZGQgY29tbWFuZCwgYXQgdGhhdCBwb2ludCBhbHNvCj4+IHJlbW92ZSB0
aGUgbW9kdWxlIHBhcmFtZXRlciBtYWNhZGRyLgo+Pgo+PiBXaWxsIHRoYXQgYmUgbWFuZGF0b3J5
PyBJJ20gbm90IHRvIGhhcHB5IHdpdGggYSBVQVBJIHdlIGludGVuZCB0byBicmVhawo+PiBzdHJh
aWdodCBhd2F5IC4uLgo+IE5vLiBTcGVjaWZ5aW5nIG1hYyBhZGRyZXNzIHNob3VsZG4ndCBiZSBt
YW5kYXRvcnkuIFVBUEkgd29udCcgYmUgYnJva2VuLgoKCklmIGl0J3Mgbm90IG1hbmRhdG9yeS4g
RG9lcyBpdCBtZWFuIHRoZSB2RFBBIHBhcmVudCBuZWVkIHRvIHVzZSBpdHMgb3duIApsb2dpYyB0
byBnZW5lcmF0ZSBhIHZhbGlkYXRlIG1hYz8gSSdtIG5vdCBzdXJlIHRoaXMgaXMgd2hhdCBtYW5h
Z2VtZW50IAoobGlidmlydCB3YW50KS4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
