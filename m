Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9198FC433F5
	for <virtualization@archiver.kernel.org>; Sun, 30 Jan 2022 06:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22426400E0;
	Sun, 30 Jan 2022 06:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iIx_0rc7QSLI; Sun, 30 Jan 2022 06:52:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6DDBB40436;
	Sun, 30 Jan 2022 06:52:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45899C001A;
	Sun, 30 Jan 2022 06:52:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54FA7C000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42BAD60B63
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9DmqTbpif1db
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:52:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 103FC60D66
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643525525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppbgrqXXRvr7WyHpfHnKCXNAPOBM3v0wXQdYjLGRVqs=;
 b=KN1Wf400oNztqXn7k/z+7fCLHACNr6N1Z0IqWAPFwXt+r8eq+1euc0LAVHUlVJeb6rGWmG
 M726FPl8af0acBTPtxjjO/ckjw5YNj11mJyMXRxAl5KMB/yat6aqK1hgIYkwhPwS1pXhU8
 1kuxkudSz9T2tmClDmRqDa/FYyub79o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-N8DNnSZ0O-m5BZJJ9djb7g-1; Sun, 30 Jan 2022 01:52:02 -0500
X-MC-Unique: N8DNnSZ0O-m5BZJJ9djb7g-1
Received: by mail-pj1-f69.google.com with SMTP id
 q1-20020a17090a064100b001b4d85cbaf7so9100768pje.9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 22:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ppbgrqXXRvr7WyHpfHnKCXNAPOBM3v0wXQdYjLGRVqs=;
 b=nnkl4Gbx/p5tPgZo4+Tk7TuAdoH5vwj0PTU2knlOKu3VGpgxF2ytmse0hSB58lQW8j
 P3ZAZmfsLUJyCn7XBBl6udjY8JBa0+pKRHj98dGQazwqtD7OXJ9/usOSB2Wgg/fYPMeT
 TzSqaAgul6fa+LXlgYr+tHWRa7MCmjhH/E2FLqJAjnbtbzsaoYkKR/xOma5bakSCOzAw
 6cRhV3vOz4d1KO+HkDlaDkRkBaNtYTlpH2/ZAjoJaVSxNUyg8oyuxzd0tIKQs2IBLU+V
 pYqqOMWQFsFrFVZjnGTVzFogq4e9XLtGrcvQ1lIoLGbKfuYkk5DMMHVe/jzaM52Bt1nE
 POsg==
X-Gm-Message-State: AOAM533b8H0NhrJQpWB95p7cB2cqpK2bCnvMGfoDt1EoanxcmKL2sdBI
 alq9dq0fRngRx3dDbiGknaQZj9wxkGfFmzIuhBJz6LsFNuMHMwcIsGaDH3Wn4cQP+Yr8VIvu5zP
 kXbyfMeMuRHAbfJlzvucUiHAYbJhHeoMUB9CrGlYNQA==
X-Received: by 2002:a17:902:c702:: with SMTP id
 p2mr15500589plp.140.1643525521144; 
 Sat, 29 Jan 2022 22:52:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJqc8TQvZT00Y1zuKxJk5dWauNsccg1caSt4rH8kMQ1e2YmRsCOhVzmvBHplUeHja2YOW6JA==
X-Received: by 2002:a17:902:c702:: with SMTP id
 p2mr15500559plp.140.1643525520910; 
 Sat, 29 Jan 2022 22:52:00 -0800 (PST)
Received: from [10.72.12.243] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id rj1sm7435920pjb.49.2022.01.29.22.51.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jan 2022 22:52:00 -0800 (PST)
Message-ID: <2391fb35-15df-abd4-192e-7b124c289c6e@redhat.com>
Date: Sun, 30 Jan 2022 14:51:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 29/31] vdpa: Make ncs autofree
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-30-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-30-eperezma@redhat.com>
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

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFNpbXBs
aWZ5aW5nIG1lbW9yeSBtYW5hZ2VtZW50Lgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6ly
ZXogPGVwZXJlem1hQHJlZGhhdC5jb20+CgoKVG8gcmVkdWNlIHRoZSBzaXplIG9mIHRoaXMgc2Vy
aWVzLiBUaGlzIGNhbiBiZSBzZW50IGFzIGFuIHNlcGFyYXRlIHBhdGNoIAppZiBJIHdhcyBub3Qg
d3JvbmcuCgpUaGFua3MKCgo+IC0tLQo+ICAgbmV0L3Zob3N0LXZkcGEuYyB8IDUgKystLS0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvbmV0L3Zob3N0LXZkcGEuYyBiL25ldC92aG9zdC12ZHBhLmMKPiBpbmRleCA0MTI1
ZDEzMTE4Li40YmVmYmE1Y2M3IDEwMDY0NAo+IC0tLSBhL25ldC92aG9zdC12ZHBhLmMKPiArKysg
Yi9uZXQvdmhvc3QtdmRwYS5jCj4gQEAgLTI2NCw3ICsyNjQsOCBAQCBpbnQgbmV0X2luaXRfdmhv
c3RfdmRwYShjb25zdCBOZXRkZXYgKm5ldGRldiwgY29uc3QgY2hhciAqbmFtZSwKPiAgIHsKPiAg
ICAgICBjb25zdCBOZXRkZXZWaG9zdFZEUEFPcHRpb25zICpvcHRzOwo+ICAgICAgIGludCB2ZHBh
X2RldmljZV9mZDsKPiAtICAgIE5ldENsaWVudFN0YXRlICoqbmNzLCAqbmM7Cj4gKyAgICBnX2F1
dG9mcmVlIE5ldENsaWVudFN0YXRlICoqbmNzID0gTlVMTDsKPiArICAgIE5ldENsaWVudFN0YXRl
ICpuYzsKPiAgICAgICBpbnQgcXVldWVfcGFpcnMsIGksIGhhc19jdnEgPSAwOwo+ICAgCj4gICAg
ICAgYXNzZXJ0KG5ldGRldi0+dHlwZSA9PSBORVRfQ0xJRU5UX0RSSVZFUl9WSE9TVF9WRFBBKTsK
PiBAQCAtMzAyLDcgKzMwMyw2IEBAIGludCBuZXRfaW5pdF92aG9zdF92ZHBhKGNvbnN0IE5ldGRl
diAqbmV0ZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ICAgICAgICAgICAgICAgZ290byBlcnI7Cj4g
ICAgICAgfQo+ICAgCj4gLSAgICBnX2ZyZWUobmNzKTsKPiAgICAgICByZXR1cm4gMDsKPiAgIAo+
ICAgZXJyOgo+IEBAIC0zMTAsNyArMzEwLDYgQEAgZXJyOgo+ICAgICAgICAgICBxZW11X2RlbF9u
ZXRfY2xpZW50KG5jc1swXSk7Cj4gICAgICAgfQo+ICAgICAgIHFlbXVfY2xvc2UodmRwYV9kZXZp
Y2VfZmQpOwo+IC0gICAgZ19mcmVlKG5jcyk7Cj4gICAKPiAgICAgICByZXR1cm4gLTE7Cj4gICB9
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
