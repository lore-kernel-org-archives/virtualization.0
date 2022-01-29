Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5DCC433EF
	for <virtualization@archiver.kernel.org>; Sat, 29 Jan 2022 08:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 54CFC4048B;
	Sat, 29 Jan 2022 08:06:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8xRDJphk9Ksu; Sat, 29 Jan 2022 08:06:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 85A9E400AF;
	Sat, 29 Jan 2022 08:06:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57163C0011;
	Sat, 29 Jan 2022 08:06:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B170C000B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 305E882EFC
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:06:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fta6hIUyYJpO
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:06:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C3C0E82EB5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643443568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m18Lyfi5XZgrFQHudZavcCK/JJKhyYgzVv8UrJDPYFg=;
 b=hs2u5E7EejtfuZKqQq2xb0PJ6DwHviwGNWtQyrPYFVYkYNRkV4fd2X0HhoEWaaBYvW6smo
 R3sdLDKMuva+1eV/4NsVB13JeqHOR8Jo6t53Um13GD3U7hfBDY0/QqhbcP3IpRwpKmfEZE
 Ghr/bpp3WmxHMF6pUFxSAP7Plqk1TV0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-GSE_Io6oP_CYcMzoriZBrA-1; Sat, 29 Jan 2022 03:06:06 -0500
X-MC-Unique: GSE_Io6oP_CYcMzoriZBrA-1
Received: by mail-pg1-f198.google.com with SMTP id
 r13-20020a638f4d000000b0034c8f73f9efso4727216pgn.4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 00:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=m18Lyfi5XZgrFQHudZavcCK/JJKhyYgzVv8UrJDPYFg=;
 b=wcpIzrMjSnsSi+0xyQ6ccAeIN2cA5hGf36r/W49QX88FFbpd193E0/RvOla40wJkIi
 /MLtuAKSqdrgu2G1nZsNVewYqdsqfW0lQVCMZ+fGIS4CRn/2xPHn9AeUhdfIORS30oh8
 QUOEHtd+zd+oB1ECGRz5EJ3QwsKXmOsG2lEHlvomr8VEQ78A2G/D7KjjEQmfptSVSjUc
 +CVLEKxPGIliYxKH1oT8ECR+dY2LnAd++cgIEa22+BagRhUvey9rO2Dyi5af1G54wK2A
 0V9NXCZonfCXzJjv5mn2ZCDtTkL38FiuH8yyN79vINsG1WGSW1J+MyxK7BxZyPcq8CiV
 AI1Q==
X-Gm-Message-State: AOAM531k9YZgd2vqrCEpVFJ4OxpDCbf9PhNbZ6cZMp/h9/5v4cM+QLIC
 4+KBFO0IwMK2QMjUe5HNVJiHx5sfk3l3WqjWzUcGRVWit4+MZwIoC22S5JP7V4RQWEvy/hEhfKS
 jGCjKJk5Ncn0WORv0EYGTNyBb72nwqutEneGZ7mYA6w==
X-Received: by 2002:a05:6a00:b85:: with SMTP id
 g5mr11772665pfj.56.1643443565945; 
 Sat, 29 Jan 2022 00:06:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXku+9gZRmvlQdHa2a5m7Cq9TWfUZ7rERC50OfbZwsYoGbEGc7yF4LbQc5axpPXDwqG3xsOA==
X-Received: by 2002:a05:6a00:b85:: with SMTP id
 g5mr11772635pfj.56.1643443565722; 
 Sat, 29 Jan 2022 00:06:05 -0800 (PST)
Received: from [10.72.12.112] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b24sm8416040pgs.1.2022.01.29.00.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jan 2022 00:06:05 -0800 (PST)
Message-ID: <cbfbd909-4ee8-8ad2-effd-4b9f60270581@redhat.com>
Date: Sat, 29 Jan 2022 16:05:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 09/31] vhost-vdpa: Take into account SVQ in
 vhost_vdpa_set_vring_call
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-10-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-10-eperezma@redhat.com>
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

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFNpZ25l
ZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAg
aHcvdmlydGlvL3Zob3N0LXZkcGEuYyB8IDIwICsrKysrKysrKysrKysrKysrKy0tCj4gICAxIGZp
bGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IGlu
ZGV4IDE4ZGUxNGYwZmIuLjAyOWY5OGZlZWUgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0
LXZkcGEuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBAQCAtNjg3LDEzICs2ODcs
MjkgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF92cmluZ19raWNrKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldiwKPiAgICAgICB9Cj4gICB9Cj4gICAKPiAtc3RhdGljIGludCB2aG9zdF92ZHBhX3Nl
dF92cmluZ19jYWxsKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX2ZpbGUgKmZpbGUpCj4gK3N0
YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJpbmdfZGV2X2NhbGwoc3RydWN0IHZob3N0X2RldiAq
ZGV2LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2
aG9zdF92cmluZ19maWxlICpmaWxlKQo+ICAgewo+ICAgICAgIHRyYWNlX3Zob3N0X3ZkcGFfc2V0
X3ZyaW5nX2NhbGwoZGV2LCBmaWxlLT5pbmRleCwgZmlsZS0+ZmQpOwo+ICAgICAgIHJldHVybiB2
aG9zdF92ZHBhX2NhbGwoZGV2LCBWSE9TVF9TRVRfVlJJTkdfQ0FMTCwgZmlsZSk7Cj4gICB9Cj4g
ICAKPiArc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF92cmluZ19jYWxsKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2
aG9zdF92cmluZ19maWxlICpmaWxlKQo+ICt7Cj4gKyAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9
IGRldi0+b3BhcXVlOwo+ICsKPiArICAgIGlmICh2LT5zaGFkb3dfdnFzX2VuYWJsZWQpIHsKPiAr
ICAgICAgICBpbnQgdmRwYV9pZHggPSB2aG9zdF92ZHBhX2dldF92cV9pbmRleChkZXYsIGZpbGUt
PmluZGV4KTsKPiArICAgICAgICBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxID0gZ19wdHJfYXJy
YXlfaW5kZXgodi0+c2hhZG93X3ZxcywgdmRwYV9pZHgpOwo+ICsKPiArICAgICAgICB2aG9zdF9z
dnFfc2V0X2d1ZXN0X2NhbGxfbm90aWZpZXIoc3ZxLCBmaWxlLT5mZCk7CgoKVHdvIHF1ZXN0aW9u
cyBoZXJlIChoYWQgc2ltaWxhciBxdWVzdGlvbnMgZm9yIHZyaW5nIGtpY2spOgoKMSkgQW55IHJl
YXNvbiB0aGF0IHdlIHNldHVwIHRoZSBldmVudGZkIGZvciB2aG9zdC12ZHBhIGluIAp2aG9zdF92
ZHBhX3N2cV9zZXR1cCgpIG5vdCBoZXJlPwoKMikgVGhlIGNhbGwgY291bGQgYmUgZGlzYWJsZWQg
YnkgdXNpbmcgLTEgYXMgdGhlIGZkLCBJIGRvbid0IHNlZSBhbnkgCmNvZGUgdG8gZGVhbCB3aXRo
IHRoYXQuCgpUaGFua3MKCgo+ICsgICAgICAgIHJldHVybiAwOwo+ICsgICAgfSBlbHNlIHsKPiAr
ICAgICAgICByZXR1cm4gdmhvc3RfdmRwYV9zZXRfdnJpbmdfZGV2X2NhbGwoZGV2LCBmaWxlKTsK
PiArICAgIH0KPiArfQo+ICsKPiAgIC8qKgo+ICAgICogU2V0IHNoYWRvdyB2aXJ0cXVldWUgZGVz
Y3JpcHRvcnMgdG8gdGhlIGRldmljZQo+ICAgICoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
