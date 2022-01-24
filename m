Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7494C433FE
	for <virtualization@archiver.kernel.org>; Mon, 24 Jan 2022 04:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3682960DB7;
	Mon, 24 Jan 2022 04:33:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-BJRsMCzXnY; Mon, 24 Jan 2022 04:33:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D749060D73;
	Mon, 24 Jan 2022 04:33:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95D68C0031;
	Mon, 24 Jan 2022 04:33:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8A15C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 04:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F859824E3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 04:33:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TkgbO-ng1agW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 04:33:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB401824CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 04:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642998780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ywVkSjYqwGhEXuzDaFXOjbRRmnLvl8ZmyDiptv9Gj0o=;
 b=Rb6SBG59Yyl6AWwqBwebj8tcEhZ99/HRO5NofXmLcUEas65iieVdfl5N4rfCA0tTRRdJpT
 lWcyQo20Qxa8w44UDk7fJdmIFjOTKxpqPLGdbTOQFm2ujW81f4CzbOyVBBac82HR13njt7
 QH8K6kwLDtd4Mh2V6mZczYHJ8/sxwcg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-dGihN4_tM8Cj0YGoes3dGw-1; Sun, 23 Jan 2022 23:32:58 -0500
X-MC-Unique: dGihN4_tM8Cj0YGoes3dGw-1
Received: by mail-pg1-f198.google.com with SMTP id
 o20-20020a656a54000000b003441a994d60so9200311pgu.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 20:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ywVkSjYqwGhEXuzDaFXOjbRRmnLvl8ZmyDiptv9Gj0o=;
 b=iYUa107yMxRdVju/HL84sjFYvicLDGQjCb0c9IoBYHSYYE+UdGojnWAwARgZ/6S1sS
 5Vri2wkzUjiXyiGFdGlG4dkzQlBuJPAaGX5M1ge+ZKRgT3MHI4924s3YFjt45v1ZIfW6
 oDEtwsUJbCc0xNJY72zJ7Y7L68Z9zM6+/nqEkLoxasxB/+0lzpZ01hWYIhU0y/KSkwJN
 gFsLtp3Pba8omTUQbV2nFTLwlnDuevrDA0HHxcBXgCTa9kA+ncENngauWbfvvSdk8Q5b
 cMfbd/Hj2R8WVo22vfAhCHp7uBjWO/qPUdQbSj/FHHSnRk/uDkELskjzOhg876SGaqvm
 B3Hw==
X-Gm-Message-State: AOAM531VAONGFX1LFrf75lq5EcYxryZqtO5NJuJduklqnc8TDnuNEjXi
 Gi9b0ph/nBlPUV5c4w3qR05QCgYJ6Qn5cqglVmfMBB4yEW4mcLupETpK6TnsJAY3UbZk1ek5oop
 uLcO/G/S90OiUmuKpDHc8TI7GE6RXjxW7xMC5xDdhrQ==
X-Received: by 2002:a17:90a:de0f:: with SMTP id
 m15mr239261pjv.86.1642998777724; 
 Sun, 23 Jan 2022 20:32:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmjGFIoJVqeqwAWMaE4+RtrcG9zQLuG9z0Loa5SLrS4BNNb3F3WCc9CHZeL4zodWm9EXdc1w==
X-Received: by 2002:a17:90a:de0f:: with SMTP id
 m15mr239234pjv.86.1642998777471; 
 Sun, 23 Jan 2022 20:32:57 -0800 (PST)
Received: from xz-m1.local ([94.177.118.73])
 by smtp.gmail.com with ESMTPSA id g22sm14229089pfj.99.2022.01.23.20.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jan 2022 20:32:57 -0800 (PST)
Date: Mon, 24 Jan 2022 12:32:47 +0800
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH 21/31] util: Add iova_tree_alloc
Message-ID: <Ye4r7tKFhP9VaT5/@xz-m1.local>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-22-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220121202733.404989-22-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Gautam Dawar <gdawar@xilinx.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization@lists.linux-foundation.org, Eric Blake <eblake@redhat.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBKYW4gMjEsIDIwMjIgYXQgMDk6Mjc6MjNQTSArMDEwMCwgRXVnZW5pbyBQw6lyZXog
d3JvdGU6Cj4gK2ludCBpb3ZhX3RyZWVfYWxsb2MoSU9WQVRyZWUgKnRyZWUsIERNQU1hcCAqbWFw
LCBod2FkZHIgaW92YV9iZWdpbiwKPiArICAgICAgICAgICAgICAgICAgICBod2FkZHIgaW92YV9s
YXN0KQo+ICt7Cj4gKyAgICBjb25zdCBETUFNYXBJbnRlcm5hbCAqbGFzdCwgKmk7Cj4gKwo+ICsg
ICAgYXNzZXJ0KGlvdmFfYmVnaW4gPCBpb3ZhX2xhc3QpOwo+ICsKPiArICAgIC8qCj4gKyAgICAg
KiBGaW5kIGEgdmFsaWQgaG9sZSBmb3IgdGhlIG1hcHBpbmcKPiArICAgICAqCj4gKyAgICAgKiBU
T0RPOiBSZXBsYWNlIGFsbCB0aGlzIHdpdGggZ190cmVlX25vZGVfZmlyc3QvbmV4dC9sYXN0IHdo
ZW4gYXZhaWxhYmxlCj4gKyAgICAgKiAoZnJvbSBnbGliIHNpbmNlIDIuNjgpLiBVc2luZyBhIHNl
cHBhcmF0ZWQgUVRBSUxRIGNvbXBsaWNhdGVzIGNvZGUuCj4gKyAgICAgKgo+ICsgICAgICogVHJ5
IHRvIGFsbG9jYXRlIGZpcnN0IGF0IHRoZSBlbmQgb2YgdGhlIGxpc3QuCj4gKyAgICAgKi8KPiAr
ICAgIGxhc3QgPSBRVEFJTFFfTEFTVCgmdHJlZS0+bGlzdCk7Cj4gKyAgICBpZiAoaW92YV90cmVl
X2FsbG9jX21hcF9pbl9ob2xlKGxhc3QsIE5VTEwsIGlvdmFfYmVnaW4sIGlvdmFfbGFzdCwKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWFwLT5zaXplKSkgewo+ICsgICAg
ICAgIGdvdG8gYWxsb2M7Cj4gKyAgICB9Cj4gKwo+ICsgICAgLyogTG9vayBmb3IgaW5uZXIgaG9s
ZSAqLwo+ICsgICAgbGFzdCA9IE5VTEw7Cj4gKyAgICBmb3IgKGkgPSBRVEFJTFFfRklSU1QoJnRy
ZWUtPmxpc3QpOyBpOwo+ICsgICAgICAgICBsYXN0ID0gaSwgaSA9IFFUQUlMUV9ORVhUKGksIGVu
dHJ5KSkgewo+ICsgICAgICAgIGlmIChpb3ZhX3RyZWVfYWxsb2NfbWFwX2luX2hvbGUobGFzdCwg
aSwgaW92YV9iZWdpbiwgaW92YV9sYXN0LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbWFwLT5zaXplKSkgewo+ICsgICAgICAgICAgICBnb3RvIGFsbG9jOwo+ICsg
ICAgICAgIH0KPiArICAgIH0KPiArCj4gKyAgICByZXR1cm4gSU9WQV9FUlJfTk9NRU07Cj4gKwo+
ICthbGxvYzoKPiArICAgIG1hcC0+aW92YSA9IGxhc3QgPyBsYXN0LT5tYXAuaW92YSArIGxhc3Qt
Pm1hcC5zaXplICsgMSA6IGlvdmFfYmVnaW47Cj4gKyAgICByZXR1cm4gaW92YV90cmVlX2luc2Vy
dCh0cmVlLCBtYXApOwo+ICt9CgpIaSwgRXVnZW5pbywKCkhhdmUgeW91IHRyaWVkIHdpdGggd2hh
dCBKYXNvbiBzdWdnZXN0ZWQgcHJldmlvdXNseT8KCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC9DQUNHa01FdFpBUGQ5eFFUUF9SNHcyOTZOX1F6N1Z1VjFGTG5iNTQ0ZkVWb1lP
MG9mK2dAbWFpbC5nbWFpbC5jb20vCgpUaGF0IHNvbHV0aW9uIHN0aWxsIHNvdW5kcyB2ZXJ5IHNl
bnNpYmxlIHRvIG1lIGV2ZW4gd2l0aG91dCB0aGUgbmV3bHkKaW50cm9kdWNlZCBsaXN0IGluIHBy
ZXZpb3VzIHR3byBwYXRjaGVzLgoKSU1ITyB3ZSBjb3VsZCBtb3ZlICJETUFNYXAgKnByZXZpb3Vz
LCAqdGhpcyIgaW50byB0aGUgSU9WQVRyZWVBbGxvY0FyZ3MqCnN0dWN0dXJlIHRoYXQgd2FzIHBh
c3NlZCBpbnRvIHRoZSB0cmF2ZXJzZSBmdW5jIHRob3VnaCwgc28gaXQnbGwgbmF0dXJhbGx5IHdv
cmsKd2l0aCB0aHJlYWRpbmcuCgpPciBpcyB0aGVyZSBhbnkgYmxvY2tlciBmb3IgaXQ/CgpUaGFu
a3MsCgotLSAKUGV0ZXIgWHUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
