Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF572C433DB
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 04:10:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E37522583
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 04:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E37522583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CDDBE86FDE;
	Tue,  5 Jan 2021 04:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6RpUlyjfXQ6u; Tue,  5 Jan 2021 04:10:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3E93286D73;
	Tue,  5 Jan 2021 04:10:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C730C0891;
	Tue,  5 Jan 2021 04:10:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC2F3C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D25CB85BEE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v2EW5j_MNWQz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:10:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 00ACA85BB5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609819810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dT2rLC0d09/u9EF932LGHm38h2GYKdxtIzh0CShwNPw=;
 b=OMsqu59YPTQkX+VQjmexlMGLAhkalMx5xjVf1y1MsVMfuCG2JGUOwEgmNVHEDx7bh/Nlis
 gCwlNEpD9PPFMGMVkxcQuB9WhP8G6dPiwkSmMwDKEHtG4AvChLSNqD1+CgiVmFh1q/OiXW
 fy0PQLHs4f8rwrcFPIXAK+XKy/G5o6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-pmypdNfSPUmJbS28SFXKWQ-1; Mon, 04 Jan 2021 23:10:09 -0500
X-MC-Unique: pmypdNfSPUmJbS28SFXKWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1CDF8014D8;
 Tue,  5 Jan 2021 04:10:07 +0000 (UTC)
Received: from [10.72.13.192] (ovpn-13-192.pek2.redhat.com [10.72.13.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9DEB1002382;
 Tue,  5 Jan 2021 04:10:02 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 4/7] vdpa: Define vdpa mgmt device, ops and
 a netlink interface
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210104033141.105876-1-parav@nvidia.com>
 <20210104033141.105876-5-parav@nvidia.com>
 <b08ede5d-e393-b4f8-d1d8-2aa29e409872@redhat.com>
 <BY5PR12MB432236DE09EBC2E584C07FCDDCD20@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b7a4602d-daae-dde1-a064-2ee07cf84309@redhat.com>
Date: Tue, 5 Jan 2021 12:10:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB432236DE09EBC2E584C07FCDDCD20@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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

Ck9uIDIwMjEvMS80IOS4i+WNiDM6MjQsIFBhcmF2IFBhbmRpdCB3cm90ZToKPgo+PiBGcm9tOiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBNb25kYXksIEphbnVhcnkg
NCwgMjAyMSAxMjozMyBQTQo+Pgo+PiBPbiAyMDIxLzEvNCDkuIrljYgxMTozMSwgUGFyYXYgUGFu
ZGl0IHdyb3RlOgo+Pj4gVG8gYWRkIG9uZSBvciBtb3JlIFZEUEEgZGV2aWNlcywgZGVmaW5lIGEg
bWFuYWdlbWVudCBkZXZpY2Ugd2hpY2gKPj4+IGFsbG93cyBhZGRpbmcgb3IgcmVtb3ZpbmcgdmRw
YSBkZXZpY2UuIEEgbWFuYWdlbWVudCBkZXZpY2UgZGVmaW5lcyBzZXQKPj4+IG9mIGNhbGxiYWNr
cyB0byBtYW5hZ2UgdmRwYSBkZXZpY2VzLgo+Pj4KPj4+IFRvIGJlZ2luIHdpdGgsIGl0IGRlZmlu
ZXMgYWRkIGFuZCByZW1vdmUgY2FsbGJhY2tzIHRocm91Z2ggd2hpY2ggYQo+Pj4gdXNlciBkZWZp
bmVkIHZkcGEgZGV2aWNlIGNhbiBiZSBhZGRlZCBvciByZW1vdmVkLgo+Pj4KPj4+IEEgdW5pcXVl
IG1hbmFnZW1lbnQgZGV2aWNlIGlzIGlkZW50aWZpZWQgYnkgaXRzIHVuaXF1ZSBoYW5kbGUKPj4+
IGlkZW50aWZpZWQgYnkgbWFuYWdlbWVudCBkZXZpY2UgbmFtZSBhbmQgb3B0aW9uYWxseSB0aGUg
YnVzIG5hbWUuCj4+Pgo+Pj4gSGVuY2UsIGludHJvZHVjZSByb3V0aW5lIHRocm91Z2ggd2hpY2gg
ZHJpdmVyIGNhbiByZWdpc3RlciBhCj4+PiBtYW5hZ2VtZW50IGRldmljZSBhbmQgaXRzIGNhbGxi
YWNrIG9wZXJhdGlvbnMgZm9yIGFkZGluZyBhbmQgcmVtb3ZlIGEKPj4+IHZkcGEgZGV2aWNlLgo+
Pj4KPj4+IEludHJvZHVjZSB2ZHBhIG5ldGxpbmsgc29ja2V0IGZhbWlseSBzbyB0aGF0IHVzZXIg
Y2FuIHF1ZXJ5IG1hbmFnZW1lbnQKPj4+IGRldmljZSBhbmQgaXRzIGF0dHJpYnV0ZXMuCj4+Pgo+
Pj4gRXhhbXBsZSBvZiBzaG93IHZkcGEgbWFuYWdlbWVudCBkZXZpY2Ugd2hpY2ggYWxsb3dzIGNy
ZWF0aW5nIHZkcGEKPj4+IGRldmljZSBvZiBuZXR3b3JraW5nIGNsYXNzIChkZXZpY2UgaWQgPSAw
eDEpIG9mIHZpcnRpbyBzcGVjaWZpY2F0aW9uCj4+PiAxLjEgc2VjdGlvbiA1LjEuMS4KPj4+Cj4+
PiAkIHZkcGEgbWdtdGRldiBzaG93Cj4+PiB2ZHBhc2ltX25ldDoKPj4+ICAgICBzdXBwb3J0ZWRf
Y2xhc3NlczoKPj4+ICAgICAgIG5ldAo+Pj4KPj4+IEV4YW1wbGUgb2Ygc2hvd2luZyB2ZHBhIG1h
bmFnZW1lbnQgZGV2aWNlIGluIEpTT04gZm9ybWF0Lgo+Pj4KPj4+ICQgdmRwYSBtZ210ZGV2IHNo
b3cgLWpwCj4+PiB7Cj4+PiAgICAgICAic2hvdyI6IHsKPj4+ICAgICAgICAgICAidmRwYXNpbV9u
ZXQiOiB7Cj4+PiAgICAgICAgICAgICAgICJzdXBwb3J0ZWRfY2xhc3NlcyI6IFsgIm5ldCIgXQo+
Pj4gICAgICAgICAgIH0KPj4+ICAgICAgIH0KPj4+IH0KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBQ
YXJhdiBQYW5kaXQ8cGFyYXZAbnZpZGlhLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBFbGkgQ29oZW48
ZWxpY0BudmlkaWEuY29tPgo+Pj4gUmV2aWV3ZWQtYnk6IEphc29uIFdhbmc8amFzb3dhbmdAcmVk
aGF0LmNvbT4KPj4+IC0tLQo+Pj4gQ2hhbmdlbG9nOgo+Pj4gdjEtPnYyOgo+Pj4gICAgLSByZWJh
c2VkCj4+PiAgICAtIHVwZGF0ZWQgY29tbWl0IGxvZyBleGFtcGxlIGZvciBtYW5hZ2VtZW50IGRl
dmljZSBuYW1lIGZyb20KPj4+ICAgICAgInZkcGFzaW0iIHRvICJ2ZHBhc2ltX25ldCIKPj4+ICAg
IC0gcmVtb3ZlZCBkZXZpY2VfaWQgYXMgbmV0IGFuZCBibG9jayBtYW5hZ2VtZW50IGRldmljZXMg
YXJlCj4+PiBzZXBhcmF0ZWQKPj4KPj4gU28gSSB3b25kZXIgd2hldGhlciB0aGVyZSBjb3VsZCBi
ZSBhIHR5cGUgb2YgbWFuYWdlbWVudCBkZXZpY2VzIHRoYXQgY2FuCj4+IGRlYWwgd2l0aCBtdWx0
aXBsZSB0eXBlcyBvZiB2aXJ0aW8gZGV2aWNlcy4gSWYgeWVzLCB3ZSBwcm9iYWJseSBuZWVkIHRv
IGFkZAo+PiBkZXZpY2UgaWQgYmFjay4KPiBBdCB0aGlzIHBvaW50IG1seDUgcGxhbiB0byBzdXBw
b3J0IG9ubHkgbmV0Lgo+IEl0IGlzIHVzZWZ1bCB0byBzZWUgd2hhdCB0eXBlIG9mIHZkcGEgZGV2
aWNlIGlzIHN1cHBvcnRlZCBieSBhIG1hbmFnZW1lbnQgZGV2aWNlLgo+Cj4gSW4gZnV0dXJlIGlm
IGEgbWdtdCBkZXYgc3VwcG9ydHMgbXVsdGlwbGUgdHlwZXMsIHVzZXIgbmVlZHMgdG8gY2hvb3Nl
IGRlc2lyZWQgdHlwZS4KPiBJIGd1ZXNzIHdlIGNhbiBkaWZmZXIgdGhpcyBvcHRpb25hbCB0eXBl
IHRvIGZ1dHVyZSwgd2hlbiBzdWNoIG1nbXQuIGRldmljZSB3aWxsL21heSBiZSBhdmFpbGFibGUu
CgoKSSB3b3JyeSBpZiB3ZSByZW1vdmUgZGV2aWNlX2lkLCBpdCBtYXkgZ2l2ZXMgYSBoaW50IHRo
YXQgbXVsdGlwbGUgbWdtdCAKZGV2aWNlcyBuZWVkcyB0byBiZSByZWdpc3RlcmVkIGlmIGl0IHN1
cHBvcnRzIG11bHRpcGxlIHR5cGVzLgoKU28gaWYgcG9zc2libGUgSSB3b3VsZCBsaWtlIHRvIGtl
ZXAgdGhlIGRldmljZV9pZCBoZXJlLgoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
