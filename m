Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F5C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 04:35:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1567860F23
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 04:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1567860F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C834A40119;
	Wed, 13 Oct 2021 04:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fsaxc1Q_wB_t; Wed, 13 Oct 2021 04:35:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 40E074012C;
	Wed, 13 Oct 2021 04:35:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 147E5C000F;
	Wed, 13 Oct 2021 04:35:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E4D9C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 300316079B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oWO61siyR8bw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:35:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 79C3F606C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634099738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wINfqaz/O9+HOfkraCCTULcrWKcCZkgynSGL3NU7D0A=;
 b=PoMzRYziCei54c64Tyudx+ik+jxDHLUDi6wgOpJMwhR/YPR2mOygS7PtyL6S7PEJPCXIY/
 EM9x27zSkvOi9Ez64eWmD+XczSuaD7KlikVIBCVzGqQhyyEBXsfWCxBmxSdMXj9LiCGz2l
 MaovFbl05i77+Eefb8nBIga7Qtv+6D8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-Naszxl5JOliS9Fe9Upw6QA-1; Wed, 13 Oct 2021 00:35:37 -0400
X-MC-Unique: Naszxl5JOliS9Fe9Upw6QA-1
Received: by mail-pj1-f70.google.com with SMTP id
 u13-20020a17090a4bcd00b00198e965f8f4so2874535pjl.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=wINfqaz/O9+HOfkraCCTULcrWKcCZkgynSGL3NU7D0A=;
 b=qncVan/n4QIxRNCpdIy9weec+GKzWjLmOXgLZgIFEC93yFzcsoQS5cvmvRKkW7XDft
 koqMSrWBXMfrrJ5+j+qxrToNpABheSRM5EeJlWAGAl8b0SCNzVB8b6eVp2EcJRtE4DqO
 0CgTQuXXqOSyi3PDjMYSIifKnnO4f2giZZULsL6utQhLyK2xn7OyLYifWI/qx9NJm66k
 QAi0MxHgU96JP0opHnF6zNyoK8MjXtRIxiq4SA9pN6JMXN7RWqjCA4ekB/vPFO6TXaft
 owFTWHDmfz+5ExkuT8UuLL4igyrOTjh+/qXHEAK8DJ6Og4MiHCBpRyyb9F8ZWaJqIICH
 +7zQ==
X-Gm-Message-State: AOAM5330xMKDMg00FqSar4b98IS2kyoKJyUGePY0CUmkzH8deX1JtfTQ
 vXRRMQymTLkKzvZa/ItjI+KwB8s10v6mF+7pzeqXznEHlnFTO62LqC+AKhTZR46qZwlb8iS10kO
 jAnOFKTsahuMLZodufOnZaVPppEh10o8CBn3S5c9TpQ==
X-Received: by 2002:a17:90a:a41:: with SMTP id
 o59mr10895509pjo.243.1634099736112; 
 Tue, 12 Oct 2021 21:35:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymiYQaYUkD/ivm8TOAXah7gxwTiuwVjOxrS6LXgOCSK8Aa0tJWdo8QgnQyN2XZGxA7NmShCw==
X-Received: by 2002:a17:90a:a41:: with SMTP id
 o59mr10895484pjo.243.1634099735814; 
 Tue, 12 Oct 2021 21:35:35 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x129sm12562543pfc.140.2021.10.12.21.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 21:35:35 -0700 (PDT)
Subject: Re: [RFC PATCH v4 16/20] vhost: Check for device
 VRING_USED_F_NO_NOTIFY at shadow virtqueue kick
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-17-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f77b8efb-9d6b-5f35-2285-72f2dc59c26a@redhat.com>
Date: Wed, 13 Oct 2021 12:35:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001070603.307037-17-eperezma@redhat.com>
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

CuWcqCAyMDIxLzEwLzEg5LiL5Y2IMzowNSwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFNpZ25l
ZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAg
aHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyB8IDExICsrKysrKysrKystCj4gICAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAt
LWdpdCBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgYi9ody92aXJ0aW8vdmhv
c3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4gaW5kZXggZGY3ZTZmYTNlYy4uNzc1ZjhkMzZhMCAxMDA2
NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4gKysrIGIvaHcv
dmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+IEBAIC0xNzMsNiArMTczLDE1IEBAIHN0
YXRpYyB2b2lkIHZob3N0X3N2cV9hZGQoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgVmlydFF1
ZXVlRWxlbWVudCAqZWxlbSkKPiAgICAgICBzdnEtPnJpbmdfaWRfbWFwc1txZW11X2hlYWRdID0g
ZWxlbTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCB2aG9zdF9zdnFfa2ljayhWaG9zdFNoYWRv
d1ZpcnRxdWV1ZSAqc3ZxKQo+ICt7Cj4gKyAgICAvKiBNYWtlIHN1cmUgd2UgYXJlIHJlYWRpbmcg
dXBkYXRlZCBkZXZpY2UgZmxhZyAqLwoKCkkgZ3Vlc3MgdGhpcyB3b3VsZCBiZSBiZXR0ZXI6Cgog
wqDCoMKgwqDCoMKgwqAgLyogV2UgbmVlZCB0byBleHBvc2UgYXZhaWxhYmxlIGFycmF5IGVudHJp
ZXMgYmVmb3JlIGNoZWNraW5nIHVzZWQKIMKgwqDCoMKgwqDCoMKgwqAgKiBmbGFncy4gKi8KCihC
b3Jyb3dlZCBmcm9tIGtlcm5lbCBjb2RlcykuCgpUaGFua3MKCgo+ICsgICAgc21wX21iKCk7Cj4g
KyAgICBpZiAoIShzdnEtPnZyaW5nLnVzZWQtPmZsYWdzICYgVlJJTkdfVVNFRF9GX05PX05PVElG
WSkpIHsKPiArICAgICAgICBldmVudF9ub3RpZmllcl9zZXQoJnN2cS0+a2lja19ub3RpZmllcik7
Cj4gKyAgICB9Cj4gK30KPiArCj4gICAvKiBIYW5kbGUgZ3Vlc3QtPmRldmljZSBub3RpZmljYXRp
b25zICovCj4gICBzdGF0aWMgdm9pZCB2aG9zdF9oYW5kbGVfZ3Vlc3Rfa2ljayhFdmVudE5vdGlm
aWVyICpuKQo+ICAgewo+IEBAIC0xOTcsNyArMjA2LDcgQEAgc3RhdGljIHZvaWQgdmhvc3RfaGFu
ZGxlX2d1ZXN0X2tpY2soRXZlbnROb3RpZmllciAqbikKPiAgICAgICAgICAgICAgIH0KPiAgIAo+
ICAgICAgICAgICAgICAgdmhvc3Rfc3ZxX2FkZChzdnEsIGVsZW0pOwo+IC0gICAgICAgICAgICBl
dmVudF9ub3RpZmllcl9zZXQoJnN2cS0+a2lja19ub3RpZmllcik7Cj4gKyAgICAgICAgICAgIHZo
b3N0X3N2cV9raWNrKHN2cSk7Cj4gICAgICAgICAgIH0KPiAgIAo+ICAgICAgICAgICB2aXJ0aW9f
cXVldWVfc2V0X25vdGlmaWNhdGlvbihzdnEtPnZxLCB0cnVlKTsKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
