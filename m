Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D43C433F5
	for <virtualization@archiver.kernel.org>; Sat, 29 Jan 2022 08:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95D214014D;
	Sat, 29 Jan 2022 08:20:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8qo6HmsoVXGs; Sat, 29 Jan 2022 08:20:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D06A7400AF;
	Sat, 29 Jan 2022 08:20:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 912A2C0011;
	Sat, 29 Jan 2022 08:20:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50BA3C000B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3897960071
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:20:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qC4MIVigje6G
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:20:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AD5360AE2
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643444421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUvaXBeYFYqIFBRUBXZDha8iyJ6iXQ2Wr2dPtTHLNxk=;
 b=Rqw0NoR7+b4gS/uPGcd+CcGJQWTbUOjAxUvAfBuV81q4QutVWEQvyglXFzsJlbhywIXKX6
 dWqKvnjxiaAUyIE99HE4488dY/bl9sj9EeWA3sXHUUoHXM7PF2mPAB4inXEb57PqxE+h/Y
 VS3Yv+frkPnSPuSagBAursOqV2Y905g=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-QdRAGSMKNRyOwVVr32GuTw-1; Sat, 29 Jan 2022 03:20:20 -0500
X-MC-Unique: QdRAGSMKNRyOwVVr32GuTw-1
Received: by mail-pg1-f199.google.com with SMTP id
 p29-20020a634f5d000000b003624b087f05so4755824pgl.7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 00:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=RUvaXBeYFYqIFBRUBXZDha8iyJ6iXQ2Wr2dPtTHLNxk=;
 b=337Jhq79d+IEub/rCbS4AOWRaTolmFffucMeB9PH4o3tyES/NVpux23jy6SfcGIWWw
 JDIeGa0O7nOI4WNI+dKz9MSnDiNd9eQkEJqPNGOSTLvBzc9DSUIPVgTV9S6jEXrEtIBz
 MqKzh7lYhksS5IjP1Kk8h6RWVh0+8RyQW/nYyM/LnQByFPZH8jwnm7qzwl8s3e+xVFHt
 +xDCH5oN88DaJZZMg/QFDO2i3sWVOA3/3zQLfa8u071baZvHRwQQCvJnH6sJyWL+R8q6
 vW/a+vr9mAJWrDFol9NruwPB5z0MfZ69jsCJA5kIPAxwAjtGsY0XUsQMqbI/q+sLSQEz
 TJEA==
X-Gm-Message-State: AOAM5332fx3PGtr36UJT720UiFBIpZ9kr+i6bI2Lf50OXTaf1UYs/oVZ
 EXdihVf0DAG74nrDPXzudl/+4sCILYewc6HhEA22DckLqIwyedRdGsZkE/8yXRE7xlggsIUPX47
 y4rPbCXC5h7qeiBl9KxtwJ5fRCMcTVWLWYQ+XZxu5KQ==
X-Received: by 2002:a17:90b:911:: with SMTP id
 bo17mr13915811pjb.165.1643444419309; 
 Sat, 29 Jan 2022 00:20:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6gwpcpp5qLQfr02/uT3lvvEljwPojpW9Is/AeoJ/I/4YeaoiQIQITWzDGqSTgHxTKumlLRA==
X-Received: by 2002:a17:90b:911:: with SMTP id
 bo17mr13915795pjb.165.1643444419113; 
 Sat, 29 Jan 2022 00:20:19 -0800 (PST)
Received: from [10.72.12.112] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id oj7sm4958823pjb.43.2022.01.29.00.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jan 2022 00:20:18 -0800 (PST)
Message-ID: <f0e549eb-3485-01f5-88cb-f5681fc74abc@redhat.com>
Date: Sat, 29 Jan 2022 16:20:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 16/31] vhost: pass queue index to vhost_vq_get_addr
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-17-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-17-eperezma@redhat.com>
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

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IERvaW5n
IHRoYXQgd2F5IGFsbG93cyB2aG9zdCBiYWNrZW5kIHRvIGtub3cgd2hhdCBhZGRyZXNzIHRvIHJl
dHVybi4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQu
Y29tPgo+IC0tLQo+ICAgaHcvdmlydGlvL3Zob3N0LmMgfCA2ICsrKy0tLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9o
dy92aXJ0aW8vdmhvc3QuYyBiL2h3L3ZpcnRpby92aG9zdC5jCj4gaW5kZXggN2IwM2VmY2NlYy4u
NjRiOTU1YmEwYyAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3QuYwo+ICsrKyBiL2h3L3Zp
cnRpby92aG9zdC5jCj4gQEAgLTc5OCw5ICs3OTgsMTAgQEAgc3RhdGljIGludCB2aG9zdF92aXJ0
cXVldWVfc2V0X2FkZHIoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpZHgsIGJvb2wgZW5hYmxl
X2xvZykKPiAgIHsKPiAtICAgIHN0cnVjdCB2aG9zdF92cmluZ19hZGRyIGFkZHI7Cj4gKyAgICBz
dHJ1Y3Qgdmhvc3RfdnJpbmdfYWRkciBhZGRyID0gewo+ICsgICAgICAgIC5pbmRleCA9IGlkeCwK
PiArICAgIH07Cj4gICAgICAgaW50IHI7Cj4gLSAgICBtZW1zZXQoJmFkZHIsIDAsIHNpemVvZihz
dHJ1Y3Qgdmhvc3RfdnJpbmdfYWRkcikpOwo+ICAgCj4gICAgICAgaWYgKGRldi0+dmhvc3Rfb3Bz
LT52aG9zdF92cV9nZXRfYWRkcikgewo+ICAgICAgICAgICByID0gZGV2LT52aG9zdF9vcHMtPnZo
b3N0X3ZxX2dldF9hZGRyKGRldiwgJmFkZHIsIHZxKTsKPiBAQCAtODEzLDcgKzgxNCw2IEBAIHN0
YXRpYyBpbnQgdmhvc3RfdmlydHF1ZXVlX3NldF9hZGRyKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwK
PiAgICAgICAgICAgYWRkci5hdmFpbF91c2VyX2FkZHIgPSAodWludDY0X3QpKHVuc2lnbmVkIGxv
bmcpdnEtPmF2YWlsOwo+ICAgICAgICAgICBhZGRyLnVzZWRfdXNlcl9hZGRyID0gKHVpbnQ2NF90
KSh1bnNpZ25lZCBsb25nKXZxLT51c2VkOwo+ICAgICAgIH0KCgpJJ20gYSBiaXQgbG9zdCBpbiB0
aGUgbG9naWMgYWJvdmUsIGFueSByZWFzb24gd2UgbmVlZCBjYWxsIAp2aG9zdF92cV9nZXRfYWRk
cigpIDopID8KClRoYW5rcwoKCj4gLSAgICBhZGRyLmluZGV4ID0gaWR4Owo+ICAgICAgIGFkZHIu
bG9nX2d1ZXN0X2FkZHIgPSB2cS0+dXNlZF9waHlzOwo+ICAgICAgIGFkZHIuZmxhZ3MgPSBlbmFi
bGVfbG9nID8gKDEgPDwgVkhPU1RfVlJJTkdfRl9MT0cpIDogMDsKPiAgICAgICByID0gZGV2LT52
aG9zdF9vcHMtPnZob3N0X3NldF92cmluZ19hZGRyKGRldiwgJmFkZHIpOwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
