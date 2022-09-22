Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C59EC6FA8B
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 09:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E807F8330B;
	Thu, 22 Sep 2022 09:10:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E807F8330B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ObGiHtZW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VHRhXXp9A3Wl; Thu, 22 Sep 2022 09:10:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7D1EA8329A;
	Thu, 22 Sep 2022 09:10:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D1EA8329A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53D2EC0033;
	Thu, 22 Sep 2022 09:10:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C008C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29B4061051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:10:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29B4061051
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ObGiHtZW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hV4RtLXx_5af
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:10:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 777F561038
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 777F561038
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663837844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=morPVWV2ApZvdpDztZBUk6AXlt+AabwlvFbLlrqV78g=;
 b=ObGiHtZWNRNrtlKaW7JkNT60zgb9RFyw0H8TZL9zN63v6eOvvHHxjh8LaDaVlNln5uKT7j
 zNI/dN0PI/Acc3SgJQm3gPU4+MfSpyYEyLsziUokL8WJbU3+1/Sf+RJXnQBs+iaNrmH8LV
 tYJL6MG7Jud4EQsu3yNkMdsUF649Y3Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-m8oV4cmsN7u-_v2LCcBY8g-1; Thu, 22 Sep 2022 05:10:40 -0400
X-MC-Unique: m8oV4cmsN7u-_v2LCcBY8g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5-20020a05600c028500b003b4d2247d3eso2469559wmk.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date;
 bh=morPVWV2ApZvdpDztZBUk6AXlt+AabwlvFbLlrqV78g=;
 b=TOpc7JvrilsuhWvlLcRkiAIB1u4bX20LDaUwp38VrZgJPdIph93rXerLz2DaHWN0WM
 zl+ve0ixOS4eDbmi0Z9MltWzScj8S8EH09vbWr4/TVBQAOKHteXfKN1UQCDIUiWZa2hZ
 TU9yHPCWikCBwnGwGvBZPMGZcvNqQWuNCcR1wMcf5hpSQtf2az5UFR5dHRci3yrhFdgl
 7+QoyEu0CzR5UX4eTXl60Ji+YsN57MAyLK8XhaQoIrBT9lphuj6Tc4q2qP7drj1/1n3B
 TmSKPRJpWDCxRm2eHN+bfhBna998+6wNBD2q3DX3kj/1h+cNqfw5ZIx7VJojzUGovoJm
 Y6Ag==
X-Gm-Message-State: ACrzQf2GMg+Y5E4CbdatI+ymdUwHzUgv1EDo4yVZQNqt8k79shuXBnvG
 ebXzpGtMJE7UmFXgUieuE/DQv2mWayJ99+IS6O8yKlZcN9WPU9V+rQtpLhiMN1kf5IUtpyXa5l2
 PiyMT0WfM3/9wshQb8Le+WAjHz9qH9tkjkFJLHiUGpA==
X-Received: by 2002:a5d:5b19:0:b0:22b:237c:3de8 with SMTP id
 bx25-20020a5d5b19000000b0022b237c3de8mr1273134wrb.285.1663837839814; 
 Thu, 22 Sep 2022 02:10:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7VpYxGn7XvbqoxWHkJ4g1p2oLdCxcI0CJ5KNSjNQGKsAc575PVXhFFaCl71jQAm7KG4p3Ttw==
X-Received: by 2002:a5d:5b19:0:b0:22b:237c:3de8 with SMTP id
 bx25-20020a5d5b19000000b0022b237c3de8mr1273106wrb.285.1663837839605; 
 Thu, 22 Sep 2022 02:10:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-76.dyn.eolo.it.
 [146.241.104.76]) by smtp.gmail.com with ESMTPSA id
 i10-20020a05600c354a00b003b462b314e7sm5498478wmq.16.2022.09.22.02.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 02:10:38 -0700 (PDT)
Message-ID: <f3ad0de40b424413ede30abd3517c8fad0c3caca.camel@redhat.com>
Subject: Re: [PATCH] Do not name control queue for virtio-net
From: Paolo Abeni <pabeni@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Junbo <junbo4242@gmail.com>
Date: Thu, 22 Sep 2022 11:10:37 +0200
In-Reply-To: <20220918081713-mutt-send-email-mst@kernel.org>
References: <20220917092857.3752357-1-junbo4242@gmail.com>
 <20220918025033-mutt-send-email-mst@kernel.org>
 <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
 <20220918081713-mutt-send-email-mst@kernel.org>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
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

T24gU3VuLCAyMDIyLTA5LTE4IGF0IDA4OjE3IC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4gT24gU3VuLCBTZXAgMTgsIDIwMjIgYXQgMDU6MDA6MjBQTSArMDgwMCwgSnVuYm8gd3Jv
dGU6Cj4gPiBoacKgTWljaGFlbAo+ID4gCj4gPiBpbiB2aXJ0aW8tbmV0LmMKPiA+IMKgIMKgIC8q
IFBhcmFtZXRlcnMgZm9yIGNvbnRyb2wgdmlydHF1ZXVlLCBpZiBhbnkgKi8KPiA+IMKgIMKgIGlm
ICh2aS0+aGFzX2N2cSkgewo+ID4gwqAgwqAgwqAgwqAgY2FsbGJhY2tzW3RvdGFsX3ZxcyAtIDFd
ID0gTlVMTDsKPiA+IMKgIMKgIMKgIMKgIG5hbWVzW3RvdGFsX3ZxcyAtIDFdID0gImNvbnRyb2wi
Owo+ID4gwqAgwqAgfQo+ID4gCj4gPiBJIHRoaW5rIHRoZSBBdXRob3Igd2hvIHdyaXRlIHRoZSBj
b2RlCj4gCj4gd2FpdCwgdGhhdCB3YXMgbm90IHlvdT8KCkkgYmVsaWV2ZSAndGhlIEF1dGhvcicg
cmVmZXJzIHRvIHRoZSBhdXRob3Igb2YgdGhlIGN1cnJlbnQgY29kZSwgbm90IHRvCnRoZSBhdXRo
b3Igb2YgdGhlIHBhdGNoLgoKQEp1bmJvOiB0aGUgY29udHJvbCBxdWV1ZSBpcyBjcmVhdGVkIG9u
bHkgaWYgdGhlIFZJUlRJT19ORVRfRl9DVFJMX1ZRCmZlYXR1cmUgaXMgc2V0LCBwbGVhc2UgY2hl
Y2sgdGhhdCBpbiB5b3VyIHNldHVwLgoKVGhhbmtzCgpQYW9sbwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
