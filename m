Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5A5C433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:49:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F8E60E78
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42F8E60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E1586079B;
	Wed, 13 Oct 2021 03:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lZu7DJp9ln-R; Wed, 13 Oct 2021 03:49:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB77560744;
	Wed, 13 Oct 2021 03:49:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3F36C0011;
	Wed, 13 Oct 2021 03:49:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88388C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 775B880DAE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m_DZljqX4xuT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:49:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D3D4C80DAD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634096960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nc561+saWJMTudX0gcwoL+PiV5ic65YeUcHohjLIlJ0=;
 b=GtNN9jjLIDUtRrxgRnn8ZPOwlw/1mze7oOexebJeohAOFB2FcRvTdeK2RRC3YVJyfR9rge
 r9AsfUHQ93d+/duHcMm0FQAUanqLtA8iN+/Fl3MK3Pt+oIK36dx4B6u7bwKllmCI82aE0z
 00M/485LiqPhL/0Fjt/xZ67sJ781XPs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-q8OXyHb2Mi-3w7gkx15prg-1; Tue, 12 Oct 2021 23:49:19 -0400
X-MC-Unique: q8OXyHb2Mi-3w7gkx15prg-1
Received: by mail-pf1-f200.google.com with SMTP id
 c123-20020a621c81000000b004446be17615so798295pfc.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 20:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Nc561+saWJMTudX0gcwoL+PiV5ic65YeUcHohjLIlJ0=;
 b=3WZrfWLyzcpDcHRn/YdJyfDOTnG84nXxLp5bZtrcZRVydtUOAWOYBuFEk6+zYuMGKe
 TseMX+dKA4sx6nmqglgek28GiQSjmAgetLS/Ri9ZKNgfEN3DVWkoaaWKlfD3E7ljspqb
 PzbNDPt6T2Am5bue03buCtoaw1Q+hQu2G2ktzTayq+bmGLgImg3yaypNK1SX9YHnWka0
 u14+kuLSfjZF29fZb4z6XX5FtmpbIib4w5Os2XENBnyv519GbSjpJ6SGtnM8xjEBIl+e
 ACA4LWJqq06d02bgcFga9kGMO6tNgyYQ6VKEXEAFwc7hNnGNJybCZkqeFDFFWTrKVZWf
 9gTw==
X-Gm-Message-State: AOAM530ucaz7uMQDehGdYAOmghZBFO9y6ShGHVNiFSmgL0CtTog3KMhx
 A9FgVEvA+z+uqWxYaE+zM65fkBMVTSUwcYskIGItK207ZUqRDjGvxdH2HWCIdprJcoM1VetTEvp
 abji9A5U2xlJjjv4Hlg3NqcOyyGBob37lJKwBXNah5g==
X-Received: by 2002:a17:902:8b83:b029:12c:cbce:a52f with SMTP id
 ay3-20020a1709028b83b029012ccbcea52fmr33479379plb.9.1634096958356; 
 Tue, 12 Oct 2021 20:49:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp/w9WOLm+s/zGkpqTH9LhI2NC+37oxCG/DQLSpvGBV5AYay992DvMB4K3Df/+MFIoVxELeA==
X-Received: by 2002:a17:902:8b83:b029:12c:cbce:a52f with SMTP id
 ay3-20020a1709028b83b029012ccbcea52fmr33479356plb.9.1634096958112; 
 Tue, 12 Oct 2021 20:49:18 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x10sm12657741pfn.172.2021.10.12.20.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 20:49:17 -0700 (PDT)
Subject: Re: [RFC PATCH v4 11/20] vhost: Route host->guest notification
 through shadow virtqueue
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-12-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <69c4056c-4a9b-8480-80a0-2b78c9b90ffb@redhat.com>
Date: Wed, 13 Oct 2021 11:49:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001070603.307037-12-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzEwLzEg5LiL5Y2IMzowNSwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRoaXMg
d2lsbCBtYWtlIHFlbXUgYXdhcmUgb2YgdGhlIGRldmljZSB1c2VkIGJ1ZmZlcnMsIGFsbG93aW5n
IGl0IHRvCj4gd3JpdGUgdGhlIGd1ZXN0IG1lbW9yeSB3aXRoIGl0cyBjb250ZW50cyBpZiBuZWVk
ZWQuCj4KPiBTaW5jZSB0aGUgdXNlIG9mIHZob3N0X3ZpcnRxdWV1ZV9zdGFydCBjYW4gdW5tYXNr
cyBhbmQgZGlzY2FyZCBjYWxsCj4gZXZlbnRzLCB2aG9zdF92aXJ0cXVldWVfc3RhcnQgc2hvdWxk
IGJlIG1vZGlmaWVkIGluIG9uZSBvZiB0aGVzZSB3YXlzOgo+ICogU3BsaXQgaW4gdHdvOiBPbmUg
b2YgdGhlbSB1c2VzIGFsbCBsb2dpYyB0byBzdGFydCBhIHF1ZXVlIHdpdGggbm8KPiAgICBzaWRl
IGVmZmVjdHMgZm9yIHRoZSBndWVzdCwgYW5kIGFub3RoZXIgb25lIHRoYSBhY3R1YWxseSBhc3N1
bWVzIHRoYXQKPiAgICB0aGUgZ3Vlc3QgaGFzIGp1c3Qgc3RhcnRlZCB0aGUgZGV2aWNlLiBWZHBh
IHNob3VsZCB1c2UganVzdCB0aGUKPiAgICBmb3JtZXIuCj4gKiBBY3R1YWxseSBzdG9yZSBhbmQg
Y2hlY2sgaWYgdGhlIGd1ZXN0IG5vdGlmaWVyIGlzIG1hc2tlZCwgYW5kIGRvIGl0Cj4gICAgY29u
ZGl0aW9uYWxseS4KPiAqIExlZnQgYXMgaXQgaXMsIGFuZCBkdXBsaWNhdGUgYWxsIHRoZSBsb2dp
YyBpbiB2aG9zdC12ZHBhLgoKCkJ0dywgdGhlIGxvZyBsb29rcyBub3QgY2xlYXIuIEkgZ3Vlc3Mg
dGhpcyBwYXRjaCBnb2VzIGZvciBtZXRob2QgMy4gSWYgCnllcywgd2UgbmVlZCBleHBsYWluIGl0
IGFuZCB3aHkuCgpUaGFua3MKCgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXo8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
