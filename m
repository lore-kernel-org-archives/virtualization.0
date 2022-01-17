Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD84C433F5
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 06:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2BC9402D8;
	Mon, 17 Jan 2022 06:40:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AJ9zRCj3wp9X; Mon, 17 Jan 2022 06:40:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 642394023D;
	Mon, 17 Jan 2022 06:40:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 346AEC0039;
	Mon, 17 Jan 2022 06:40:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EA11C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57EA7402EE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:40:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RrdGIFxoIaZK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:40:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F09514023D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642401625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1E8hjpydB+1Ebcg5NG3WSQev5EeNdXP/CDEeZweK/0=;
 b=csLPON8Qn15XhfHZxxpA0hC1WCKyZip5vPrXvXPlgPQmC2JieH98ODW++bSR7evYWel8hh
 pXKFLr7EcNaRvLulQS/GRHzErPhQepGKNCG6vHZmWxV95bVBIO8u1Bj0r9VqIqcEY4Dzuc
 hZoo6HygaUtuDrbXx4J5shvGTJCMy8E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-rFxiD6JPNGqRx_Bvm1EtSQ-1; Mon, 17 Jan 2022 01:40:20 -0500
X-MC-Unique: rFxiD6JPNGqRx_Bvm1EtSQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 j13-20020a17090a318d00b001b3e4f72bfbso10299017pjb.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jan 2022 22:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=z1E8hjpydB+1Ebcg5NG3WSQev5EeNdXP/CDEeZweK/0=;
 b=ZVuCwEmHaB3TdpVBD9aald5SCuhM675G/dC7FBY6Ztjgpg9N+QpTsbfDS4xPbTflbt
 0tqDxqwj2S578CHvoptiJDHWj+Mhn6CMEUvJmNz69vIMmLmQYwUx+r/bqXuky/sHxmtO
 1U2f8YMuWbn7HLXgvcoVm+16Ry2Fes3VifqpInLo46q9MvQunkh+6zTLjRt1tgsQZu7m
 g7H9IaUlZKZVz7kVurW5oEKfbl5II19gjB4Sz66wjgCR9CWLS2Qu4PaFnqHJZoJr1gNL
 jmoerdPMWQ9xKbulNdBHSXP6+YoS1XW6M4yWvN7/Qk/q4M9HOq2/E0k4ClSJyLrA4rc+
 u/Yg==
X-Gm-Message-State: AOAM532ArXCHPSwc4mN3yls4Gwls7jF5nQwwU6mUXuy0OsOQK3wvj0af
 VYB+KwxqAP7euzBVfLJC1ghrCNhetaNVNlbsvMYyWLXVpjSVN1SlANEmznbU9tX1ZaYFYERjOMw
 KiFuqc+R9ltWmqwMRNBfYXjnDGI+pa6GkxhIis7xAeA==
X-Received: by 2002:a17:903:11d0:b0:149:a969:400c with SMTP id
 q16-20020a17090311d000b00149a969400cmr21317010plh.120.1642401616157; 
 Sun, 16 Jan 2022 22:40:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuBZ9AYJjw5KpCOAVuPoXkf9CMob/mn9UwVMIe1y13FBPLr9fe56+zJZi7vmL3oQex3gPhfQ==
X-Received: by 2002:a17:903:11d0:b0:149:a969:400c with SMTP id
 q16-20020a17090311d000b00149a969400cmr21316998plh.120.1642401615926; 
 Sun, 16 Jan 2022 22:40:15 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z29sm3431743pfg.87.2022.01.16.22.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jan 2022 22:40:15 -0800 (PST)
Message-ID: <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
Date: Mon, 17 Jan 2022 14:40:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] virtio_mem: break device on remove
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20220114214324.239444-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220114214324.239444-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzEvMTUg5LiK5Y2INTo0MywgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBB
IGNvbW1vbiBwYXR0ZXJuIGZvciBkZXZpY2UgcmVzZXQgaXMgY3VycmVudGx5Ogo+IHZkZXYtPmNv
bmZpZy0+cmVzZXQodmRldik7Cj4gLi4gY2xlYW51cCAuLgo+Cj4gcmVzZXQgcHJldmVudHMgbmV3
IGludGVycnVwdHMgZnJvbSBhcnJpdmluZyBhbmQgd2FpdHMgZm9yIGludGVycnVwdAo+IGhhbmRs
ZXJzIHRvIGZpbmlzaC4KPgo+IEhvd2V2ZXIgaWYgLSBhcyBpcyBjb21tb24gLSB0aGUgaGFuZGxl
ciBxdWV1ZXMgYSB3b3JrIHJlcXVlc3Qgd2hpY2ggaXMKPiBmbHVzaGVkIGR1cmluZyB0aGUgY2xl
YW51cCBzdGFnZSwgd2UgaGF2ZSBjb2RlIGFkZGluZyBidWZmZXJzIC8gdHJ5aW5nCj4gdG8gZ2V0
IGJ1ZmZlcnMgd2hpbGUgZGV2aWNlIGlzIHJlc2V0LiBOb3QgZ29vZC4KPgo+IFRoaXMgd2FzIHJl
cHJvZHVjZWQgYnkgcnVubmluZwo+IAltb2Rwcm9iZSB2aXJ0aW9fY29uc29sZQo+IAltb2Rwcm9i
ZSAtciB2aXJ0aW9fY29uc29sZQo+IGluIGEgbG9vcCwgYW5kIHRoaXMgcmVhc29uaW5nIHNlZW1z
IHRvIGFwcGx5IHRvIHZpcnRpbyBtZW0gdGhvdWdoCj4gSSBjb3VsZCBub3QgcmVwcm9kdWNlIGl0
IHRoZXJlLgo+Cj4gRml4IHRoaXMgdXAgYnkgY2FsbGluZyB2aXJ0aW9fYnJlYWtfZGV2aWNlICsg
Zmx1c2ggYmVmb3JlIHJlc2V0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19tZW0uYyB8
IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVt
LmMKPiBpbmRleCAzOGJlY2Q4ZDU3OGMuLjMzYjhhMTE4YTNhZSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVt
LmMKPiBAQCAtMjg4OCw2ICsyODg4LDggQEAgc3RhdGljIHZvaWQgdmlydGlvX21lbV9yZW1vdmUo
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICAJCXZpcnRpb19tZW1fZGVpbml0X2hvdHBs
dWcodm0pOwo+ICAgCj4gICAJLyogcmVzZXQgdGhlIGRldmljZSBhbmQgY2xlYW51cCB0aGUgcXVl
dWVzICovCj4gKwl2aXJ0aW9fYnJlYWtfZGV2aWNlKHZkZXYpOwo+ICsJZmx1c2hfd29yaygmdm0t
PndxKTsKCgpXZSBzZXQgdm0tPnJlbW92aW5nIHRvIHRydWUgYW5kIGNhbGwgY2FuY2VsX3dvcmtf
c3luYygpIGluIAp2aXJ0aW9fbWVtX2RlaW5pdF9ob3RwbHVnKCkuIElzbid0IGlzIHN1ZmZpY2ll
bnQ/CgpUaGFua3MKCgo+ICAgCXZpcnRpb19yZXNldF9kZXZpY2UodmRldik7Cj4gICAJdmRldi0+
Y29uZmlnLT5kZWxfdnFzKHZkZXYpOwo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
