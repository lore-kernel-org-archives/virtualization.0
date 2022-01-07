Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806BBC433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 05:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2BB46FC45;
	Fri,  7 Jan 2022 05:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wOI0EsLCPu90; Fri,  7 Jan 2022 05:14:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B218860759;
	Fri,  7 Jan 2022 05:14:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84D56C002F;
	Fri,  7 Jan 2022 05:14:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9B7BC002F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9238083455
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pLWmHcQb1Was
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:14:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF7578344C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641532483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vdh5whYX/Y6oJQCs8f9rDL726P/jBX4JEZCoYQ0vgWc=;
 b=WY809/Bynxnpx2hmEuPcrM/WpyjMbl3/qrxV4mvunu9QMVNXQJ0p9GMnGlD2XiFkjx2B/U
 NFvNoKb3i6+j2Wrymek88DFte3YsSjzj974Lc6BTF94r5x9uBOhurM77u0onloSMdD5vti
 xLv8l9BRGbmddUgOFp30Kw61q5H+ePU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-XvtqvnDiORenBkf0yRMi-Q-1; Fri, 07 Jan 2022 00:14:39 -0500
X-MC-Unique: XvtqvnDiORenBkf0yRMi-Q-1
Received: by mail-pj1-f71.google.com with SMTP id
 y15-20020a17090a600f00b001b3501d9e7eso2066864pji.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 21:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Vdh5whYX/Y6oJQCs8f9rDL726P/jBX4JEZCoYQ0vgWc=;
 b=FBmQ/ACb+OX3eLKTkyErZmVMt+g7TwdENHv5ek5pUU7tAjOThy57ejvQXD3PUlhfpH
 anlNSJ2cIlMmiOHyk/eKhmj+dMAysgDfel64pOgDrDr0wWmRlcaK85EL/wdbyyL5x2EM
 2khRnfldQDBYkcNv2nAl3+gPV9eXcR7J1MwynkD6WI1tPw5HxmXSkw6tSmAcUD+N0/pI
 hs8cCIaJ+U58xfq5nyL4lWU4UYL0Lv0VVGAIfE+XfXLU3Kpgg7gFhgkKN/pqIHjEI68w
 bdiUDRMFbnZqVWLhh+LKEFXdVAm6uHd82X3zA/Ipg6Ah6lNJdor7cPEP0w+OrP4mISyp
 i6Yw==
X-Gm-Message-State: AOAM531Iyd5MxbEH6Wy3mlFykuuQknhreEdM6ezzGyqKtsa+ECCZoN2K
 7Fikf4z4rW8D7i9dTFiOA4H0nmjv0UoQ9mbAwIQQdJ5RpL/fcu8FYa+2YFXNwzEMLtvsduzCEtv
 Cmtt3oKZ4EoVnvOCeb7Aaqskro/7s6GasEEBaMbO4rw==
X-Received: by 2002:a17:902:8209:b0:149:eceb:f229 with SMTP id
 x9-20020a170902820900b00149ecebf229mr6885064pln.149.1641532478619; 
 Thu, 06 Jan 2022 21:14:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvZLweJgrH01JOGXw7PzlJFdyvfMHqX8oNBHKpdfzqnYGjg24nOm67eR0ru+2hv9U4L46r3w==
X-Received: by 2002:a17:902:8209:b0:149:eceb:f229 with SMTP id
 x9-20020a170902820900b00149ecebf229mr6885043pln.149.1641532478326; 
 Thu, 06 Jan 2022 21:14:38 -0800 (PST)
Received: from [10.72.13.245] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j16sm4303986pfj.16.2022.01.06.21.14.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jan 2022 21:14:37 -0800 (PST)
Message-ID: <64a83310-2be4-b43c-dc29-f32b0dac46c1@redhat.com>
Date: Fri, 7 Jan 2022 13:14:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v7 04/14] vdpa: Read device configuration only if
 FEATURES_OK
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-5-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220105114646.577224-5-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lvivier@redhat.com, eperezma@redhat.com, si-wei.liu@oracle.com
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

CuWcqCAyMDIyLzEvNSDkuIvljYg3OjQ2LCBFbGkgQ29oZW4g5YaZ6YGTOgo+IEF2b2lkIHJlYWRp
bmcgZGV2aWNlIGNvbmZpZ3VyYXRpb24gZHVyaW5nIGZlYXR1cmUgbmVnb3RpYXRpb24uIFJlYWQK
PiBkZXZpY2Ugc3RhdHVzIGFuZCB2ZXJpZnkgdGhhdCBWSVJUSU9fQ09ORklHX1NfRkVBVFVSRVNf
T0sgaXMgc2V0Lgo+Cj4gUHJvdGVjdCB0aGUgZW50aXJlIG9wZXJhdGlvbiwgaW5jbHVkaW5nIGNv
bmZpZ3VyYXRpb24gcmVhZCB3aXRoIGNmX211dGV4Cj4gdG8gZW5zdXJlIGludGVncml0eSBvZiB0
aGUgcmVzdWx0cy4KPgo+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29t
PgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4g
djUgLT4gdjY6Cj4gMS4gVXNlIGNmX211dGV4IHRvIHNlcmlhbGl6ZSB0aGUgZW50aXJlIG9wZXJh
dGlvbnMKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhLmMgfCA0NSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
dmRwYS5jIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+IGluZGV4IDUxMzRjODNjNGEyMi4uNDQ5NDMy
NWNhZTkxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMKPiArKysgYi9kcml2ZXJz
L3ZkcGEvdmRwYS5jCj4gQEAgLTM5Myw2ICszOTMsMjEgQEAgdm9pZCB2ZHBhX21nbXRkZXZfdW5y
ZWdpc3RlcihzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldikKPiAgIH0KPiAgIEVYUE9SVF9TWU1C
T0xfR1BMKHZkcGFfbWdtdGRldl91bnJlZ2lzdGVyKTsKPiAgIAo+ICtzdGF0aWMgdm9pZCB2ZHBh
X2dldF9jb25maWdfdW5sb2NrZWQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LAo+ICsJCQkJICAg
ICB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ICsJCQkJICAgICB2b2lkICpidWYsIHVuc2lnbmVkIGlu
dCBsZW4pCj4gK3sKPiArCWNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkZXYt
PmNvbmZpZzsKPiArCj4gKwkvKgo+ICsJICogQ29uZmlnIGFjY2Vzc2VzIGFyZW4ndCBzdXBwb3Nl
ZCB0byB0cmlnZ2VyIGJlZm9yZSBmZWF0dXJlcyBhcmUgc2V0Lgo+ICsJICogSWYgaXQgZG9lcyBo
YXBwZW4gd2UgYXNzdW1lIGEgbGVnYWN5IGd1ZXN0Lgo+ICsJICovCj4gKwlpZiAoIXZkZXYtPmZl
YXR1cmVzX3ZhbGlkKQo+ICsJCXZkcGFfc2V0X2ZlYXR1cmVzKHZkZXYsIDApOwo+ICsJb3BzLT5n
ZXRfY29uZmlnKHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwo+ICt9Cj4gKwo+ICAgLyoqCj4gICAg
KiB2ZHBhX2dldF9jb25maWcgLSBHZXQgb25lIG9yIG1vcmUgZGV2aWNlIGNvbmZpZ3VyYXRpb24g
ZmllbGRzLgo+ICAgICogQHZkZXY6IHZkcGEgZGV2aWNlIHRvIG9wZXJhdGUgb24KPiBAQCAtNDAz
LDE2ICs0MTgsOCBAQCBFWFBPUlRfU1lNQk9MX0dQTCh2ZHBhX21nbXRkZXZfdW5yZWdpc3Rlcik7
Cj4gICB2b2lkIHZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2ln
bmVkIGludCBvZmZzZXQsCj4gICAJCSAgICAgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVuKQo+
ICAgewo+IC0JY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmln
Owo+IC0KPiAgIAltdXRleF9sb2NrKCZ2ZGV2LT5jZl9tdXRleCk7Cj4gLQkvKgo+IC0JICogQ29u
ZmlnIGFjY2Vzc2VzIGFyZW4ndCBzdXBwb3NlZCB0byB0cmlnZ2VyIGJlZm9yZSBmZWF0dXJlcyBh
cmUgc2V0Lgo+IC0JICogSWYgaXQgZG9lcyBoYXBwZW4gd2UgYXNzdW1lIGEgbGVnYWN5IGd1ZXN0
Lgo+IC0JICovCj4gLQlpZiAoIXZkZXYtPmZlYXR1cmVzX3ZhbGlkKQo+IC0JCXZkcGFfc2V0X2Zl
YXR1cmVzKHZkZXYsIDApOwo+IC0Jb3BzLT5nZXRfY29uZmlnKHZkZXYsIG9mZnNldCwgYnVmLCBs
ZW4pOwo+ICsJdmRwYV9nZXRfY29uZmlnX3VubG9ja2VkKHZkZXYsIG9mZnNldCwgYnVmLCBsZW4p
Owo+ICAgCW11dGV4X3VubG9jaygmdmRldi0+Y2ZfbXV0ZXgpOwo+ICAgfQo+ICAgRVhQT1JUX1NZ
TUJPTF9HUEwodmRwYV9nZXRfY29uZmlnKTsKPiBAQCAtODEzLDcgKzgyMCw3IEBAIHN0YXRpYyBp
bnQgdmRwYV9kZXZfbmV0X2NvbmZpZ19maWxsKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgc3Ry
dWN0IHNrX2J1ZmYgKm1zCj4gICAJdTY0IGZlYXR1cmVzOwo+ICAgCXUxNiB2YWxfdTE2Owo+ICAg
Cj4gLQl2ZHBhX2dldF9jb25maWcodmRldiwgMCwgJmNvbmZpZywgc2l6ZW9mKGNvbmZpZykpOwo+
ICsJdmRwYV9nZXRfY29uZmlnX3VubG9ja2VkKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihjb25m
aWcpKTsKPiAgIAo+ICAgCWlmIChubGFfcHV0KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01B
Q0FERFIsIHNpemVvZihjb25maWcubWFjKSwKPiAgIAkJICAgIGNvbmZpZy5tYWMpKQo+IEBAIC04
MzgsMTIgKzg0NSwyMyBAQCB2ZHBhX2Rldl9jb25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYsIHN0cnVjdCBza19idWZmICptc2csIHUzMiBwb3J0aWQsCj4gICB7Cj4gICAJdTMyIGRl
dmljZV9pZDsKPiAgIAl2b2lkICpoZHI7Cj4gKwl1OCBzdGF0dXM7Cj4gICAJaW50IGVycjsKPiAg
IAo+ICsJbXV0ZXhfbG9jaygmdmRldi0+Y2ZfbXV0ZXgpOwo+ICsJc3RhdHVzID0gdmRldi0+Y29u
ZmlnLT5nZXRfc3RhdHVzKHZkZXYpOwo+ICsJaWYgKCEoc3RhdHVzICYgVklSVElPX0NPTkZJR19T
X0ZFQVRVUkVTX09LKSkgewo+ICsJCU5MX1NFVF9FUlJfTVNHX01PRChleHRhY2ssICJGZWF0dXJl
cyBuZWdvdGlhdGlvbiBub3QgY29tcGxldGVkIik7Cj4gKwkJZXJyID0gLUVBR0FJTjsKPiArCQln
b3RvIG91dDsKPiArCX0KPiArCj4gICAJaGRyID0gZ2VubG1zZ19wdXQobXNnLCBwb3J0aWQsIHNl
cSwgJnZkcGFfbmxfZmFtaWx5LCBmbGFncywKPiAgIAkJCSAgVkRQQV9DTURfREVWX0NPTkZJR19H
RVQpOwo+IC0JaWYgKCFoZHIpCj4gLQkJcmV0dXJuIC1FTVNHU0laRTsKPiArCWlmICghaGRyKSB7
Cj4gKwkJZXJyID0gLUVNU0dTSVpFOwo+ICsJCWdvdG8gb3V0Owo+ICsJfQo+ICAgCj4gICAJaWYg
KG5sYV9wdXRfc3RyaW5nKG1zZywgVkRQQV9BVFRSX0RFVl9OQU1FLCBkZXZfbmFtZSgmdmRldi0+
ZGV2KSkpIHsKPiAgIAkJZXJyID0gLUVNU0dTSVpFOwo+IEBAIC04NjcsMTEgKzg4NSwxNCBAQCB2
ZHBhX2Rldl9jb25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCBza19i
dWZmICptc2csIHUzMiBwb3J0aWQsCj4gICAJaWYgKGVycikKPiAgIAkJZ290byBtc2dfZXJyOwo+
ICAgCj4gKwltdXRleF91bmxvY2soJnZkZXYtPmNmX211dGV4KTsKPiAgIAlnZW5sbXNnX2VuZCht
c2csIGhkcik7Cj4gICAJcmV0dXJuIDA7Cj4gICAKPiAgIG1zZ19lcnI6Cj4gICAJZ2VubG1zZ19j
YW5jZWwobXNnLCBoZHIpOwo+ICtvdXQ6Cj4gKwltdXRleF91bmxvY2soJnZkZXYtPmNmX211dGV4
KTsKPiAgIAlyZXR1cm4gZXJyOwo+ICAgfQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
