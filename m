Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB998C433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:12:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296706136A
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296706136A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6B0C40F56;
	Wed,  7 Apr 2021 07:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tj-TbQtV__V0; Wed,  7 Apr 2021 07:12:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35B6740658;
	Wed,  7 Apr 2021 07:12:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EB02C000C;
	Wed,  7 Apr 2021 07:12:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75CE3C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DD28849A4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:12:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2NKgncXN57ul
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:12:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D41F1828DF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617779536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LCCHFqxl45UB8tFcsq8T2OGGPE6fXb2L7eFA8ugQ4U=;
 b=h9wfCG904GSqO+06cgqrzm4uYQk2fgHmljmrRIXk0jnapH6Jx1vZVfvV7xmADRJv2DACUH
 dmyeNWE7/aySBXbkmjo4xeJXZL46mjdrebnFW6a2Q4xzaUDPmsiexK9btMO420V7we2kj0
 6YyQ7RWvxovB5fR5DQr4gxsZbNM0Y1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-cGDrDvGJMJS7iwxO_DU6rg-1; Wed, 07 Apr 2021 03:12:14 -0400
X-MC-Unique: cGDrDvGJMJS7iwxO_DU6rg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BF1279EC2;
 Wed,  7 Apr 2021 07:12:13 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-160.pek2.redhat.com
 [10.72.13.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F3406E401;
 Wed,  7 Apr 2021 07:12:08 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 04/14] vdpa: Introduce query of device
 config layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-5-parav@nvidia.com>
 <021bd627-953d-2a68-93e5-b4c750569230@redhat.com>
 <BY5PR12MB432289ECA113D8DCD4EA1582DC759@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fdc137cf-ad6a-5eec-01cf-52c0165b6229@redhat.com>
Date: Wed, 7 Apr 2021 15:12:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB432289ECA113D8DCD4EA1582DC759@BY5PR12MB4322.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC83IM/CzucxOjEwLCBQYXJhdiBQYW5kaXQg0LS1wDoKPgo+PiBGcm9tOiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDcs
IDIwMjEgOToyNiBBTQo+IFsuLl0KPj4+ICAgIC8qKgo+Pj4gICAgICogc3RydWN0IHZkcGFfY29u
ZmlnX29wcyAtIG9wZXJhdGlvbnMgZm9yIGNvbmZpZ3VyaW5nIGEgdkRQQSBkZXZpY2UuCj4+PiAg
ICAgKiBOb3RlOiB2RFBBIGRldmljZSBkcml2ZXJzIGFyZSByZXF1aXJlZCB0byBpbXBsZW1lbnQg
YWxsIG9mIHRoZSBAQAo+Pj4gLTE2NCw2ICsyMDAsMTAgQEAgc3RydWN0IHZkcGFfaW92YV9yYW5n
ZSB7Cj4+PiAgICAgKgkJCQlAYnVmOiBidWZmZXIgdXNlZCB0byB3cml0ZSBmcm9tCj4+PiAgICAg
KgkJCQlAbGVuOiB0aGUgbGVuZ3RoIHRvIHdyaXRlIHRvCj4+PiAgICAgKgkJCQljb25maWd1cmF0
aW9uIHNwYWNlCj4+PiArICogQGdldF9jZV9jb25maWc6CQlSZWFkIGRldmljZSBzcGVjaWZpYyBj
b25maWd1cmF0aW9uIGluCj4+PiArICoJCQkJY3B1IGVuZGlhbm5lc3MuCj4+PiArICoJCQkJQHZk
ZXY6IHZkcGEgZGV2aWNlCj4+PiArICoJCQkJQGNvbmZpZzogcG9pbnRlciB0byBjb25maWcgYnVm
ZmVyIHVzZWQgdG8KPj4gcmVhZCB0bwo+Pgo+Pgo+PiBTbyBJIHdvbmRlciB3aGF0J3MgdGhlIHJl
YXNvbiBmb3IgaGF2aW5nIHRoaXM/IElmIGl0J3Mgb25seSB0aGUgcmVhc29uIG9mCj4+IGVuZGlh
biwgd2UgY2FuIGp1c3QgdXNlIGdldF9jb25maWcuCj4+Cj4gRGlkbid0IGZvbGxvdyB5b3VyIHN1
Z2dlc3Rpb24uCj4gSG93IGRvZXMgaW4ga2VybmVsIG1hbmFnZW1lbnQgdG9vbCBjYWxsZXIgZ2V0
X2NvbmZpZyAga25vdyBob3cgdG8gZG8gZW5kaWFuZW5zcyBjb252ZXJzaW9uPwoKCkxFIHNob3Vs
ZCBiZSB1c2VkLCBzbyBpdCdzIHRoZSByZXNwb25zaWJpbGl0eSBvZiB0aGUgdkRQQSBwYXJlbnQg
Cihkcml2ZXIpIHRvIGRvIHRoZSBlbmRpYW4gY29udmVyc2lvbi4KCgo+IE9yIHlvdSBhcmUgcHJv
cG9zaW5nIHRvIHNlbmQgdGhpcyB3aG9sZSB2aXJ0aW9fY29uZmlnIHN0cnVjdHVyZSBhcyBiaW5h
cnkgZGF0YSB0byB1c2VyIHNwYWNlIHZpYSBuZXRsaW5rPwo+IElmIHNvLCBpdCBpcyBub3QgYSBw
cmFjdGljZSBpbiBuZXRsaW5rIHRvIHJldHVybiBzdHJ1Y3QuCgoKSSBkb24ndCBnZXQgaGVyZSwg
aXQgc2hvdWxkIHdvcmsgYXMgbWFjIGFkZHJlc3MgSSB0aGluay4KCgo+Cj4gQWxzbyBtYWtpbmcg
bmV0bGluayB1c2VyIHNwYWNlIHRvIHVuZGVyc3RhbmQgX192aXJ0aW8xNiBkb2Vzbid0IHNvdW5k
IGNvcnJlY3QuCj4gT2Z0ZW4gb3JjaGVzdHJhdGlvbiBpcyBub3Qgd3JpdHRlbiBpbiBDLiBJIGNh
bm5vdCB0aGluayBvZiByZXR1cm5pbmcgdmlydGlvX25ldF9jb25maWcgdmlhIG5ldGxpbmsgc29j
a2V0IGlmIGl0IGlzIHlvdXIgdGhvdWdodC4KCgpJJ20gbm90IHN1cmUgSSBnZXQgaGVyZS4gX192
aXJ0aW8xNiBpcyBwYXJ0IG9mIHVhcGkgd2hpY2ggaXMgZGVmaW5lZCAKdmlydGlvX3R5cGVzLmgg
c28gZGlkIHRoZSB2aXJ0aW9fbmV0X2NvbmZpZy4gRHVwbGljYXRpbmcgdGhvc2UgdGhyb3VnaCAK
ZGVkaWNhdGVkIG5ldGxpbmsgYXR0ciBsb29rcyBsaWtlIGJ1cmRlbi4gRS5nIHlvdSBuZWVkIHRv
IGludHJvZHVjZSBuZXcgCmF0dHJzIGZvciBlYWNoIGZpZWxkIG9mIHRoZSBjb25maWcgZm9yIGV2
ZXJ5IHZpcnRpbyBkZXZpY2VzIGFuZCBrZWVwIGl0IAp1cC10by1kYXRlIHdpdGggdGhlIHZpcnRp
byB1YXBpcy4KCgo+Cj4gQW5kIGRlY29kaW5nIGl0IHJlcXVpcmVzIHRvIHF1ZXJ5IGZlYXR1cmVz
IHRvby4gUXVlcnlpbmcgZmVhdHVyZXMgYW5kIGNvbmZpZyBhcmUgbm90IGF0b21pYyBzbyBwYXJz
ZWQgdmFsdWUgY2FuIGJlIHdyb25nLgoKClNvIEkgdGhpbmsgZGV2aWNlIHNob3VsZCBtYWludGFp
biBhIHN0YWJsZSBmZWF0dXJlcyB0aGF0IHdpbGwgaXMgCnJldHVybmVkIGJ5IGdldF9mZWF0dXJl
cygpLCBvdGhlcndpc2UgYSBsb3Qgb2YgdGhpbmdzIHdpbGwgYmUgYnJva2VuLgoKCj4KPiBFbmRp
YW5uZXNzIGhhcyB0byBiZSBzZWxmLWNvbnRhaW5lZCBpbiBmaWVsZHMgcmV0dXJuIHZpYSBuZXRs
aW5rLiBXaXRoIHRoYXQgYmFzZWxpbmUsIGxldHMgdGhpbmsgZnVydGhlci4KCgpUaGVuIG1hbmRh
dGluZyBMRSBzZWVtIHNlbGYtY29udGFpbmVkLgoKCj4KPj4gV2UgZG9uJ3QgcGxhbiB0byBleHBv
c2UgYSBsZWdhY3kgb3IgdHJhbnNpdGlvbiBkZXZpY2UsIHNvIHdlIGNhbiBzaW1wbHkgZG8KPj4g
dGhlIGVuZGlhbiBjb252ZXJzaW9uIGluIHRoZSBkZXZpY2UuCj4+Cj4gSSBhbSBiaXQgY29uZnVz
ZWQgd2l0aCBNaWNoYWVsJ3Mgc3VnZ2VzdGlvbiBpbiB2MSBbMV0uCj4KPiBWSVJUSU9fRl9WRVJT
SU9OXzEgaXMgc2V0IHRvZGF5IGJ5IG1seDUgYW5kIGlmY3ZmIGRyaXZlci4KCgpJJ3ZlIGhhZCBz
b21lIGRpc3Vjc3Npb24gd2l0aCBNaWNoYWVsLCB0aGUgY29uY2x1c2lvbiBpcyB0aGF0IHdlIHNo
b3VsZCAKb25seSBhZHZlcnRpc2UgKG9yIG1hbmRhdGUpIGEgbW9kZXJuIGRldmljZSB0byBiZSBl
eHBvc2VkIHVzZXJzcGFjZS4gCk90aGVyd2lzZSBpdCBjb3VsZCBiZSBhIGxvdCBvZiBidXJkZW4u
IFFlbXUgY2FuIHN0aWxsIHByZXNlbnQgYSAKdHJhbnN0aXRvbmFsIGRldmljZSBieSBkb2luZyB0
aGUgZW5kaWFuIGNvbnZlcnNpb24gd2hlbiBuZWNlc3NhcnkgaW4gdGhlIAptaWRkbGUuIEknbSB3
b3JraW5nIG9uIHRoZSBRZW11IHBhdGNoZXMgdG8gZG8gdGhhdC4KClRoYW5rcwoKCj4KPj4gVGhl
biB3ZSBjYW4gc3RpY2sgdG8gdGhlIHVhcGkgb2YgdmlydGlvX25ldF9jb25maWcgYW5kIHRoZXJl
J3Mgbm8gbmVlZCBmb3IgdGhlCj4+IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19YWFg/Cj4+Cj4gWzFd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzIwMjEwMjI0MDIwMzM2LW11
dHQtc2VuZC1lbWFpbC1tc3RAa2VybmVsLm9yZy8KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
