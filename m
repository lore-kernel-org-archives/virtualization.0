Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC99EC433FE
	for <virtualization@archiver.kernel.org>; Sat, 29 Jan 2022 08:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74FB060C12;
	Sat, 29 Jan 2022 08:15:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vj_ZSaoReYO6; Sat, 29 Jan 2022 08:15:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 157DD6077D;
	Sat, 29 Jan 2022 08:15:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBBC5C0011;
	Sat, 29 Jan 2022 08:15:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2E56C000B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9168440116
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IAnOwvjVjpOi
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:15:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5595B400AF
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643444104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/AmWnbDa3ZHDENpvKpm30KocL/1g4LiipQ8O0X+mswk=;
 b=LU1wdSgPXUxCJpO2GctWTKImNUiJxK0fOuanOyXPyzxHr10HNJHe7Pds1odhCqzvkWoRuv
 DgmTxGXwtj6NHolZNxUrzXBkJg30i1p/AOqcJTFevcvFq1tC0UdDHiWoGoynahbmn9PSG8
 35Y0tHbqgBk8FDUOBLfP3id+pdN7n0U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-skJRj8U6NUOSNPTyXCwMWw-1; Sat, 29 Jan 2022 03:15:02 -0500
X-MC-Unique: skJRj8U6NUOSNPTyXCwMWw-1
Received: by mail-pj1-f72.google.com with SMTP id
 mz1-20020a17090b378100b001b7a123cbe9so2051660pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 00:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=/AmWnbDa3ZHDENpvKpm30KocL/1g4LiipQ8O0X+mswk=;
 b=SA84tZ8WtxKDVNMkkLtuTb0fgI6bcjdjbcCLbesuq9uv4CW7w5YzPhsG+0cCiyWUWb
 j4ZFNs32B2z9Mp7mFUnn/AK1XtnjNYH/NsDFVLqsgdy9YPPwjkkbVnW4gQTYcAV8dYpQ
 q7moHRzXSOlL78oSAtXfdesPoZwVt+awOLHQ/isxJajgqpXa6r5TQSM8nlIwzm8PTb42
 Orwy7FCYVvYeufgPatnO/XhR7M6w2+5sIewl+lUkPk4Y4WxcQ7TGsfIpBZucBLmuIfCY
 dWTKoXheYixavMQhsJFxOjhJ9KmAWBQpGFih3sLN8sKDzRNCpkHVDk2q99DM+9cy7GcB
 wpdg==
X-Gm-Message-State: AOAM532dXT5dcYrwaMSQNkRrxoqK4Q0UMQMKZEHraSoWOrZFLgPhjxex
 sb9DiuzkIQuZIclaKirWQRcl5d7a+EBS1sXMFOOMO3+M/i8Sgt4JiHCHCn5/6/TqmA6ThJUWDdV
 xoZ2ZVExdQZMEJYEsiQaw9JJMs9qraZW46gdpWcrAsg==
X-Received: by 2002:a17:902:d4ca:: with SMTP id
 o10mr11954553plg.29.1643444101635; 
 Sat, 29 Jan 2022 00:15:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6ES+YqoIkoHiAEL1QcXo8Ga7bsBHgrlf+9UmNR1khbkLHGyZMAdZoUw3GeYJWT4U3EpW78g==
X-Received: by 2002:a17:902:d4ca:: with SMTP id
 o10mr11954539plg.29.1643444101414; 
 Sat, 29 Jan 2022 00:15:01 -0800 (PST)
Received: from [10.72.12.112] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c17sm12617308pfv.68.2022.01.29.00.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jan 2022 00:15:00 -0800 (PST)
Message-ID: <04720687-f6b9-1ed9-c4da-30a965743065@redhat.com>
Date: Sat, 29 Jan 2022 16:14:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 15/31] vdpa: Add vhost_svq_get_num
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-16-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-16-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRoaXMg
cmVwb3J0cyB0aGUgZ3Vlc3QncyB2aXNpYmxlIFNWUSBlZmZlY3RpdmUgbGVuZ3RoLCBub3QgdGhl
IGRldmljZSdzCj4gb25lLgoKCkkgdGhpbmsgd2UgbmVlZCB0byBleHBsYWluIGlmIHRoZXJlIGNv
dWxkIGJlIGEgY2FzZSB0aGF0IHRoZSBTVlEgc2l6ZSBpcyAKbm90IGVxdWFsIHRvIHRoZSBkZXZp
Y2UgcXVldWUgc2l6ZS4KClRoYW5rcwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJl
eiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ct
dmlydHF1ZXVlLmggfCAxICsKPiAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMg
fCA1ICsrKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAt
LWdpdCBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggYi9ody92aXJ0aW8vdmhv
c3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gaW5kZXggMzUyMWU4MDk0ZC4uMDM1MjA3YTQ2OSAxMDA2
NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gKysrIGIvaHcv
dmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+IEBAIC0yOSw2ICsyOSw3IEBAIGNvbnN0
IEV2ZW50Tm90aWZpZXIgKnZob3N0X3N2cV9nZXRfc3ZxX2NhbGxfbm90aWZpZXIoCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgVmhvc3RTaGFk
b3dWaXJ0cXVldWUgKnN2cSk7Cj4gICB2b2lkIHZob3N0X3N2cV9nZXRfdnJpbmdfYWRkcihjb25z
dCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX2FkZHIgKmFkZHIpOwo+ICt1aW50MTZfdCB2aG9zdF9z
dnFfZ2V0X251bShjb25zdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxKTsKPiAgIHNpemVfdCB2
aG9zdF9zdnFfZHJpdmVyX2FyZWFfc2l6ZShjb25zdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3Zx
KTsKPiAgIHNpemVfdCB2aG9zdF9zdnFfZGV2aWNlX2FyZWFfc2l6ZShjb25zdCBWaG9zdFNoYWRv
d1ZpcnRxdWV1ZSAqc3ZxKTsKPiAgIAo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hh
ZG93LXZpcnRxdWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+IGlu
ZGV4IDBmMmMyNDAzZmYuLmYxMjllYzgzOTUgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0
LXNoYWRvdy12aXJ0cXVldWUuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1
ZXVlLmMKPiBAQCAtMjEyLDYgKzIxMiwxMSBAQCB2b2lkIHZob3N0X3N2cV9nZXRfdnJpbmdfYWRk
cihjb25zdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxLAo+ICAgICAgIGFkZHItPnVzZWRfdXNl
cl9hZGRyID0gKHVpbnQ2NF90KXN2cS0+dnJpbmcudXNlZDsKPiAgIH0KPiAgIAo+ICt1aW50MTZf
dCB2aG9zdF9zdnFfZ2V0X251bShjb25zdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxKQo+ICt7
Cj4gKyAgICByZXR1cm4gc3ZxLT52cmluZy5udW07Cj4gK30KPiArCj4gICBzaXplX3Qgdmhvc3Rf
c3ZxX2RyaXZlcl9hcmVhX3NpemUoY29uc3QgVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSkKPiAg
IHsKPiAgICAgICBzaXplX3QgZGVzY19zaXplID0gc2l6ZW9mKHZyaW5nX2Rlc2NfdCkgKiBzdnEt
PnZyaW5nLm51bTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
