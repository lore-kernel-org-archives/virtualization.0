Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A670CC433F5
	for <virtualization@archiver.kernel.org>; Sat, 29 Jan 2022 07:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 236F66107D;
	Sat, 29 Jan 2022 07:57:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2nDsctSurXWX; Sat, 29 Jan 2022 07:57:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 98E0260812;
	Sat, 29 Jan 2022 07:57:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67B25C001A;
	Sat, 29 Jan 2022 07:57:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A5CFC000B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 07:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D88FC83E83
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 07:57:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JUjaiWhLITMV
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 07:57:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3BFBE83E82
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 07:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643443041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QkafsaZps3dDz9BRkZqTxUflY/BaeGS+eaV1LY84TSk=;
 b=RfKlVousRtJc3iXnzSchpn/f34HMifV36309JZr2QHauRk53WswjYv1pd2IUWoINqyT9uq
 KvZbmvn5Ol2JMqoUKdSm05vMx4F1tHNW1B9Rq4en2noz6VCPXjy8cC4ya3qKZmeX61OS8u
 m60fiLz4D0CCsB3AlMscIHJ436ejFcc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-tbIhLNJKOeao5SkAEXG26g-1; Sat, 29 Jan 2022 02:57:18 -0500
X-MC-Unique: tbIhLNJKOeao5SkAEXG26g-1
Received: by mail-pj1-f70.google.com with SMTP id
 mz1-20020a17090b378100b001b7a123cbe9so2026245pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 23:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QkafsaZps3dDz9BRkZqTxUflY/BaeGS+eaV1LY84TSk=;
 b=mPFDqAtZfTDECW5l94qPfKIvdGFY+E6b/Ynxl44ZiPlaI0GeL1LYCIl5ikln/sxtYU
 QV0cNCytCwB/H6aItZi4iR8BYIql+mhrWJuf4ZNhzu6ZDkxbTApREu0jbhT2hDcXN0qf
 /90YduvpxdVEDOs163O75qq/+cFJqHzIZHcXE8++yIrXKfz3/uZgC8xry54TecpF2JsL
 cvy7xDymSXp8/dgZWf/KIAokmYz9v+kD/EQ4aqb+SkdbQzWPIql/VKHGZXkaslAkIryd
 ssrSx6gJ6H9QuxeOQQ7g/8tTUr/xI6YVAi25taIZvnNlFCzLkqv31bZvfVUJDegWWAsz
 pNOw==
X-Gm-Message-State: AOAM530uvN4Qq45SiegAvUThVVeaggsiPsFs/9lbzXyjfCdTK62gRJh5
 fBBH++OIr4DNgbdHDSSfjSiot8i+pniyvOuzq7K4RuYfGa315O3Nnjej6jXuZGUSHeSWk6gTPNj
 ct2msoDzSPALW5gPdlyLGWHOCM1EcS12YWXyszh6m2w==
X-Received: by 2002:a63:1c10:: with SMTP id c16mr9352614pgc.275.1643443037323; 
 Fri, 28 Jan 2022 23:57:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoWDIZLjuFBvxtCOzzo4d+2mkQA6jW+Z88WYfhoCNaja1pAwTGCEIc5alZWL7lbK05EhNm5g==
X-Received: by 2002:a63:1c10:: with SMTP id c16mr9352603pgc.275.1643443037029; 
 Fri, 28 Jan 2022 23:57:17 -0800 (PST)
Received: from [10.72.12.112] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k12sm11998772pfc.107.2022.01.28.23.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jan 2022 23:57:16 -0800 (PST)
Message-ID: <05ff460b-1d9a-935b-8a1d-28ba0b5be8b8@redhat.com>
Date: Sat, 29 Jan 2022 15:57:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 07/31] vhost: dd vhost_svq_get_svq_call_notifier
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-8-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-8-eperezma@redhat.com>
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
YWxsb3dzIHZob3N0LXZkcGEgZGV2aWNlIHRvIHJldHJpZXZlIGRldmljZSAtPiBzdnEgY2FsbCBl
dmVudGZkLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+CgoKV2hhdCBkaWQgJ2RkJyBtZWFuIGluIHRoZSB0aXRsZT8KClRoYW5rcwoKCj4gLS0t
Cj4gICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIHwgIDIgKysKPiAgIGh3L3Zp
cnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgfCAxMiArKysrKysrKysrKysKPiAgIDIgZmls
ZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92
aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1
ZS5oCj4gaW5kZXggNGM1ODNhOTE3MS4uYTc4MjM0YjUyYiAxMDA2NDQKPiAtLS0gYS9ody92aXJ0
aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRv
dy12aXJ0cXVldWUuaAo+IEBAIC0xOCw2ICsxOCw4IEBAIHR5cGVkZWYgc3RydWN0IFZob3N0U2hh
ZG93VmlydHF1ZXVlIFZob3N0U2hhZG93VmlydHF1ZXVlOwo+ICAgdm9pZCB2aG9zdF9zdnFfc2V0
X3N2cV9raWNrX2ZkKFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEsIGludCBzdnFfa2lja19mZCk7
Cj4gICBjb25zdCBFdmVudE5vdGlmaWVyICp2aG9zdF9zdnFfZ2V0X2Rldl9raWNrX25vdGlmaWVy
KAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0
IFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEpOwo+ICtjb25zdCBFdmVudE5vdGlmaWVyICp2aG9z
dF9zdnFfZ2V0X3N2cV9jYWxsX25vdGlmaWVyKAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY29uc3QgVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSk7Cj4g
ICAKPiAgIHZvaWQgdmhvc3Rfc3ZxX3N0b3AoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSk7Cj4g
ICAKPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyBiL2h3
L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiBpbmRleCA4OTkxZjBiM2MzLi4yNWZj
ZGYxNmVjIDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMK
PiArKysgYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4gQEAgLTU1LDYgKzU1
LDE4IEBAIHN0YXRpYyB2b2lkIHZob3N0X2hhbmRsZV9ndWVzdF9raWNrKEV2ZW50Tm90aWZpZXIg
Km4pCj4gICAgICAgZXZlbnRfbm90aWZpZXJfc2V0KCZzdnEtPmhkZXZfa2ljayk7Cj4gICB9Cj4g
ICAKPiArLyoqCj4gKyAqIE9idGFpbiB0aGUgU1ZRIGNhbGwgbm90aWZpZXIsIHdoZXJlIHZob3N0
IGRldmljZSBub3RpZmllcyBTVlEgdGhhdCB0aGVyZQo+ICsgKiBleGlzdHMgcGVuZGluZyB1c2Vk
IGJ1ZmZlcnMuCj4gKyAqCj4gKyAqIEBzdnEgU2hhZG93IFZpcnRxdWV1ZQo+ICsgKi8KPiArY29u
c3QgRXZlbnROb3RpZmllciAqdmhvc3Rfc3ZxX2dldF9zdnFfY2FsbF9ub3RpZmllcigKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBWaG9zdFNo
YWRvd1ZpcnRxdWV1ZSAqc3ZxKQo+ICt7Cj4gKyAgICByZXR1cm4gJnN2cS0+aGRldl9jYWxsOwo+
ICt9Cj4gKwo+ICAgLyoqCj4gICAgKiBTZXQgYSBuZXcgZmlsZSBkZXNjcmlwdG9yIGZvciB0aGUg
Z3Vlc3QgdG8ga2ljayBTVlEgYW5kIG5vdGlmeSBmb3IgYXZhaWwKPiAgICAqCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
