Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FC7C4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 03:29:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFBF60FF2
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 03:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DFBF60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5F43605AF;
	Mon,  9 Aug 2021 03:29:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iI3cy01SXOnr; Mon,  9 Aug 2021 03:29:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 86900605BA;
	Mon,  9 Aug 2021 03:29:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E1C1C0010;
	Mon,  9 Aug 2021 03:29:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33BE9C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 232E7605BA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D20ocFcMhCXJ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:29:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68D8A605AF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628479767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tt+PFaJzEc0ptTvvuSYYQ6Bz14J73Y9yAxVu0Fi1/KU=;
 b=NmkVtXLeZHBOCWuPQ4gGodCADxEkXqFYwUZDtJlri/L1CPeTmoQhMYzD5ukz61UQ2U6smU
 MFCi4qXHtBx9B3wYnk2+fsCI+9+84/HVMwlTgzL9TlR1b+H5LUiy/xx6SjM3wFrS7bfAhn
 rc4QutsV8TOX4x4BYvRbq8iUvWiwPSY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-Z2eLIzzDOiGxTsvN3gcbMw-1; Sun, 08 Aug 2021 23:29:26 -0400
X-MC-Unique: Z2eLIzzDOiGxTsvN3gcbMw-1
Received: by mail-pl1-f199.google.com with SMTP id
 h19-20020a170902eed3b029012d3624d993so142605plb.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Aug 2021 20:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Tt+PFaJzEc0ptTvvuSYYQ6Bz14J73Y9yAxVu0Fi1/KU=;
 b=MaV72/I0cVw8YOW6UzdBEOZvdqD1ayPiefigHPOB+a1zRkgZwc5m9j0vpfUygPiC6L
 AHU/+1npObtP4ffW71LYFvsQMpASTR8LMgMXgKs7zclsUjKcxdDCakm2bR/rBdxwAmrf
 Cx6gMAMlb8D4bCEs26D8HmFdLJfXI91HutBWrvp2iN3L5oStLamky4cY7pgtwV9PZgmp
 aHLL81uCdbmg0qR+VPcG2VGbZFu4ciCLFCLYiywXcCGeLOXqU0TQUraihth5UG3FVEEK
 Gq6kEgp+pNcgjk0C3V4shq6lN/yee7GXCFikngMdjsa6GHP5XarqcXvZmoIN0Iw8M7sp
 OgNw==
X-Gm-Message-State: AOAM531n+a5DmFz22BGNTjrYula6c83usm8y7/XXpN2fbJCr9hCNwgL2
 BmT5j857T/LuGzNAp4nH/98JBDow5dNBsbD42MlW/c9wmXS97dsYls4L4jUlCc6Ad+XVm08HXyp
 mCwR4WN59ZNazz7MYJ8+qE8XLw9bDtYcpsQztwhBHpg==
X-Received: by 2002:a65:68d1:: with SMTP id k17mr730066pgt.285.1628479764905; 
 Sun, 08 Aug 2021 20:29:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ6wWMhR0dUpL8uB9l6lPzfMQm8oCDlQrdWjRvAjFl1+HCFPyh8ijunoSt9V6Y3KsNQMNvVg==
X-Received: by 2002:a65:68d1:: with SMTP id k17mr730051pgt.285.1628479764679; 
 Sun, 08 Aug 2021 20:29:24 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o127sm18530076pfb.48.2021.08.08.20.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Aug 2021 20:29:24 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <be8a0173-b7fb-eabf-bc4a-9492133674ef@redhat.com>
 <PH0PR12MB54814CEFF97574642C78171BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dfcd8c33-7a67-9a75-426b-17585e2efe21@redhat.com>
Date: Mon, 9 Aug 2021 11:29:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54814CEFF97574642C78171BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CuWcqCAyMDIxLzgvOSDkuIrljYgxMToxMywgUGFyYXYgUGFuZGl0IOWGmemBkzoKPiBIaSBKYXNv
biwKPgo+PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBN
b25kYXksIEF1Z3VzdCA5LCAyMDIxIDg6MzggQU0KPj4+IEZvciBleGFtcGxlIGNyZWF0b3IgKGh5
cGVydmlzb3IpIG9mIHRoZSB2ZHBhIGRldmljZXMga25vd3MgdGhhdCBhCj4+PiBndWVzdCBWTSBp
cyBnaXZlbiA0IHZjcHVzLCBTbyBoeXBlcnZpc29yIGNyZWF0ZXMgYSB2ZHBhIGRldmljZXMgd2l0
aAo+Pj4gY29uZmlnIHNwYWNlIGxheW91dCBhcywgbWF4X3ZpcnRxdWV1ZV9wYWlycyA9IDQuCj4+
PiBBbmQgdGhlIE1BQyBhZGRyZXNzIGNob3NlbiBieSBoeXBlcnZpc29yIGluIG1hY1s2XS4KPj4+
Cj4+PiBHdWVzdCBWTSBldGh0b29sIGNhbiBzdGlsbCBjaG9zZSB0byB1c2UgbGVzcyBudW1iZXIg
b2YgY2hhbm5lbHMuCj4+Pgo+Pj4gVHlwaWNhbGx5LAo+Pj4gZXRodG9vbCBpcyBmb3IgZ3Vlc3Qg
Vk0uCj4+PiB2ZHBhIGRldmljZSBpcyBpbiBoeXBldmlzb3IuCj4+Pgo+Pj4gSG93IGNhbiBoeXBl
cnZpc29yIGNvbXBvc2UgYSB2ZHBhIGRldmljZSB3aXRob3V0IGFueSB0b29sPwo+Pj4gSG93IGNh
biBpdCB0ZWxsIGV0aHRvb2wsIHdoYXQgaXMgc3VwcG9ydGVkIGFuZCB3aGF0IGFyZSB0aGUgZGVm
YXVsdHM/Cj4+Cj4+IFJlcmVhZCB0aGUgY292ZXIgbGV0dGVyOgo+Pgo+PiAiCj4+Cj4+IFRoaXMg
cGF0Y2hzZXQgZW5hYmxlcyB1c2VycyB0byBzZXQgdGhlIG1hYyBhZGRyZXNzIGFuZCBtdHUgb2Yg
dGhlIHZkcGEKPj4gZGV2aWNlIG9uY2UgdGhlIGRldmljZSBpcyBjcmVhdGVkLgo+Pgo+PiAiCj4+
Cj4+IEl0IGxvb2tzIHRvIG1lIHRoZSBtZWNoYW5pc20gdGhhdCBpbnRyb2R1Y2VkIGluIHRoZSBz
ZXJpZXMgaXMgbm90IGZvcgo+PiBwcm92aXNpb25pbmcgYnV0IGZvciBwb3N0LWNyZWF0aW9uIGNv
bmZpZ3VyYXRpb24/Cj4+Cj4+Cj4+PiBJIG11c3QgYmUgbWlzdW5kZXJzdGFuZGluZyB5b3VyIGNv
bW1lbnQgYWJvdXQgZXRodG9vbC4KPj4+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4/Cj4+Cj4+IEkg
Z3Vlc3MgdGhlIG1lYW5pbmcgaXMgdGhhdCwgaWYgdGhlIHZEUEEgaXMgYXNzaWduZWQgdG8gZ3Vl
c3QsIGl0J3MgdGhlCj4+IGNoYXJnZSBvZiBndWVzdCB0byBjb25maWd1cmUgdGhlIE1UVS9NQUMv
UlNTIHZpYSB0aGUgZXhpc3RpbmcgbWFuYWdlbWVudAo+PiBpbnRlcmZhY2UgbGlrZSBldGh0b29s
L2lwcm91dGUyIG5ldGxpbmsgcHJvdG9jb2wuIFRoZSBjb250cm9sIHZpcnRxdWV1ZQo+PiBpcyBk
ZXNpZ25lZCBmb3IgdGhpcy4KPj4KPj4gQnV0IGlmIGl0IHdhcyB1c2VkIGZvciBwcm92aXNpb25p
bmcsIGl0IGxvb2tzIGxpa2UgYW5vdGhlciB0b3BpYyB3aGljaAo+PiBzaG91bGQgYmUgZG9uZSBk
dXJpbmcgdGhlIGRldmljZSBjcmVhdGlvbi4KPiBXZSBhbHJlYWR5IGRpc2N1c3NlZCBhbmQgYWdy
ZWVkLCB0aGF0IEkgc2hvdWxkIGNoYW5nZSB0aGVzZSBwYXJhbXMgYXMgY3JlYXRpb24gdGltZSBw
YXJhbXMgaW5zdGVhZCBwb3N0LWNyZWF0aW9uLgo+IFdlIHdlcmUgd2FpdGluZyBmb3IgTWljaGFl
bCB0byByZXNwb25kIGlmIGhlIGlzIG9rIHdpdGggZWl0aGVyCj4gKGEpIGV4dGVuZGlibGUgaW5k
aXZpZHVhbCBwYXJhbSBvcgo+IChiKSBzaG91bGQgcHJlZmVyIHRvIHNlZSBhIHR5cGVjYXN0IGJh
c2VkIHN0cnVjdHVyZSBibG9iIGNvbWluZyB0aHJvdWdoIG5ldGxpbmsuCgoKUmlnaHQuIFNvIGl0
J3MgZm9yIGNyZWF0aW9uIHRpbWUgcGFyYW1zLgoKTWljaGFlbCwgcGxlYXNlIGFkdmlzZSB3aGlj
aCB3YXkgaXMgYmV0dGVyLgoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
