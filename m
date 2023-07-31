Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E7FC001DC
	for <virtualization@archiver.kernel.org>; Mon, 31 Jul 2023 06:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6826060E03;
	Mon, 31 Jul 2023 06:24:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6826060E03
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S7oKCc6Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wodckZpR67Jr; Mon, 31 Jul 2023 06:24:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E6D5560A8D;
	Mon, 31 Jul 2023 06:24:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6D5560A8D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A27ECC0071;
	Mon, 31 Jul 2023 06:24:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCCCCC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8EC1860AA8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:24:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EC1860AA8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mbWkBa5ENm-s
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:24:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C464760A8D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:24:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C464760A8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690784649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFujNs0s393AKJL9Pn5KqZK/kd8R31aOCdV5SggcTOg=;
 b=S7oKCc6ZQsiRPSnztsRbtVU/v+xYQeOYBacxJOMZ8kql53nO0n0TK4z2xxKZXR7HQ+QJtN
 08GktQSVyVLSJrxvj1mlLy8eXWBpccz2YHLPwu02h5d6MT5M2Gwf3MoSuTCHAu4Zra+vo8
 xuxKrZZsduBYK65JQ5RD3FV373ljFSY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-F7lUdTV3PwCkVC_gTure7Q-1; Mon, 31 Jul 2023 02:24:08 -0400
X-MC-Unique: F7lUdTV3PwCkVC_gTure7Q-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1bb8f751372so45443445ad.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jul 2023 23:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690784647; x=1691389447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFujNs0s393AKJL9Pn5KqZK/kd8R31aOCdV5SggcTOg=;
 b=et6cJvNyXFgTdm4xvTwJsu2kGpmMbLYUoOHSl7UPEcDBWMTlD6AFvqVzrc/sI6KWsk
 yevXSHD0772kqC3h4rxODR9NDupKG3iah+W9D/qXCqPN6ghqcHtTeP6OkNb9GCBhxqUM
 MijI7oZZy5ZK+kctccLn5f54i6C8NglfIpcUZDS5JgJ9GPvQDkcyuMff3oowgyyBdgmE
 D+iOo6NRaCq7lbvngaBroU7wMjFMj/4n4G2Ig8qHwxEYnlvqIDCdvXiCuxnE6ZOZhwYD
 f57e7nWW0N4Sca2r7zIYja/vvZ/Xw4Usr34dfEVuXX0QpO7kBs6hCdVvYGoXA2HTV6LE
 hOhg==
X-Gm-Message-State: ABy/qLaHgS6qbLLBf2mwlsCH1GGLDv1MwtZ70NZIc+pbt3LzV81jxzGz
 ZfO7rA5Iv9H4BIXZnzF+mNnxdK07q4xWzWmEkSNQOeIk4kqbazTBGrxGwJM9QrhpogY0YFJgk50
 apD16q80l8Icx1C03EafYdod8xrZ48LAwWfAvyu94WA==
X-Received: by 2002:a17:902:6b88:b0:1b8:16c7:a786 with SMTP id
 p8-20020a1709026b8800b001b816c7a786mr7837692plk.4.1690784647337; 
 Sun, 30 Jul 2023 23:24:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH7mH2Qi6DFfl6DwSxvSKUPeZPkzsuIKf9buf/HUaThSCbGhjgk9r38CsiEE+rud7IO8Nb3ow==
X-Received: by 2002:a17:902:6b88:b0:1b8:16c7:a786 with SMTP id
 p8-20020a1709026b8800b001b816c7a786mr7837667plk.4.1690784647016; 
 Sun, 30 Jul 2023 23:24:07 -0700 (PDT)
Received: from [10.72.112.185] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a170902b7c500b001b5247cac3dsm7590352plz.110.2023.07.30.23.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 23:24:06 -0700 (PDT)
Message-ID: <66cd33fd-5d92-915e-e7ac-9eb564936eab@redhat.com>
Date: Mon, 31 Jul 2023 14:24:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230725130709.58207-3-gavinl@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gavi@nvidia.com,
 virtualization@lists.linux-foundation.org, Heng Qi <hengqi@linux.alibaba.com>,
 bpf@vger.kernel.org
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

CuWcqCAyMDIzLzcvMjUgMjE6MDcsIEdhdmluIExpIOWGmemBkzoKPiBBZGQgaW50ZXJydXB0X2Nv
YWxlc2NlIGNvbmZpZyBpbiBzZW5kX3F1ZXVlIGFuZCByZWNlaXZlX3F1ZXVlIHRvIGNhY2hlIHVz
ZXIKPiBjb25maWcuCj4KPiBTZW5kIHBlciB2aXJ0cXVldWUgaW50ZXJydXB0IG1vZGVyYXRpb24g
Y29uZmlnIHRvIHVuZGVybHlpbmcgZGV2aWNlIGluCj4gb3JkZXIgdG8gaGF2ZSBtb3JlIGVmZmlj
aWVudCBpbnRlcnJ1cHQgbW9kZXJhdGlvbiBhbmQgY3B1IHV0aWxpemF0aW9uIG9mCj4gZ3Vlc3Qg
Vk0uCj4KPiBBZGRpdGlvbmFsbHksIGFkZHJlc3MgYWxsIHRoZSBWUXMgd2hlbiB1cGRhdGluZyB0
aGUgZ2xvYmFsIGNvbmZpZ3VyYXRpb24sCj4gYXMgbm93IHRoZSBpbmRpdmlkdWFsIFZRcyBjb25m
aWd1cmF0aW9uIGNhbiBkaXZlcmdlIGZyb20gdGhlIGdsb2JhbAo+IGNvbmZpZ3VyYXRpb24uCj4K
PiBTaWduZWQtb2ZmLWJ5OiBHYXZpbiBMaSA8Z2F2aW5sQG52aWRpYS5jb20+Cj4gUmV2aWV3ZWQt
Ynk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPgo+IFJldmlld2VkLWJ5OiBK
aXJpIFBpcmtvIDxqaXJpQG52aWRpYS5jb20+Cj4gQWNrZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4K
ClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
