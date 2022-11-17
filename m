Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18F2C4332F
	for <virtualization@archiver.kernel.org>; Thu, 17 Nov 2022 05:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 28FBD402E8;
	Thu, 17 Nov 2022 05:41:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28FBD402E8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=abtXIiS1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Htbt7vUEGmZR; Thu, 17 Nov 2022 05:41:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BA4AE40141;
	Thu, 17 Nov 2022 05:41:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA4AE40141
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 873D4C0033;
	Thu, 17 Nov 2022 05:41:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB873C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 05:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 729CB60FEE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 05:41:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 729CB60FEE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=abtXIiS1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uVhmdCfqKE-5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 05:41:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E87360FDF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E87360FDF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 05:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668663688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9i5bBHXarWBNpwYg9IlDvcz3U/Nel/XFZb0RmyQNDsk=;
 b=abtXIiS1CRjXB6PPyptTnfiNZz2e+Cw6A/IjDOEIwR3K5ZmSqM0JpjhQJGgAsACQKOA7/V
 i4gP/gD2iGY9muutcplOrYcFFBjVLX2UKnaRZyu28kpDW9xUnaZZ98BCIbmTWuvaKLEu3S
 HMu2FSgAOuQHWsdcBydT2LtUWpXKvfM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-NhlgVFoxPQC2X3o5qHmGxA-1; Thu, 17 Nov 2022 00:41:27 -0500
X-MC-Unique: NhlgVFoxPQC2X3o5qHmGxA-1
Received: by mail-pl1-f200.google.com with SMTP id
 b18-20020a170903229200b00186e357f3b9so641303plh.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 21:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9i5bBHXarWBNpwYg9IlDvcz3U/Nel/XFZb0RmyQNDsk=;
 b=wdi/vP1tAU1Vc2tPwIyBSDu7RTJC7MiP/IQ1Zh+EKQ6ZPfr/ObNnRUUNCHZlWC1vR0
 yHFZGvNMHHZgADIHKfFqhj9Agru/9po7iGP4c0vPl3j18iRShxdnRZR4qGTdaRLMSUvr
 qst+T4XZoEtbwXfusonrMII6j8uNZNWF3kl6ykCQh5o6o/bDDszqDLb8WjLdoafu/WSb
 WzKBfGMeySWOwzXCmBpIwvuR9ZXdqgH6zgi6xdK9hReFwuoUZG5vLY9ua6PzBEt3Z6YM
 bmhAoHFsFnZSvnzg3NvLrz3fZdMDycFosJWJNXFk8JXFyHe0G7BuMErduI7ozVZo75sF
 88WA==
X-Gm-Message-State: ANoB5pnbD/wy8jh48qZIrgSfbwKnzR++sjwb0w0CQ8FFketisNVxIdnw
 vYBznE4IUeQ6AzGBPcQivozHw9hGD+tgZ3hRVdrx8wBrUXEypaKFlcg9mvOzWlQqAMaAzJToglW
 QAtgw3xtJ4iicBtNNk4K4Z9Hambe/7EWE6ZrXrZnpvQ==
X-Received: by 2002:a63:fc0a:0:b0:434:7885:6ade with SMTP id
 j10-20020a63fc0a000000b0043478856ademr702140pgi.243.1668663686246; 
 Wed, 16 Nov 2022 21:41:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6fNU4nHL/6+Ar9MdJvKzV6qm1HYnDkSUOg39Ow7s1Dnaj9BHRG29AiXTUXFSINqGtDJ42+ig==
X-Received: by 2002:a63:fc0a:0:b0:434:7885:6ade with SMTP id
 j10-20020a63fc0a000000b0043478856ademr702125pgi.243.1668663685946; 
 Wed, 16 Nov 2022 21:41:25 -0800 (PST)
Received: from [10.72.13.24] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 r21-20020a6560d5000000b0046ec7beb53esm166470pgv.8.2022.11.16.21.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Nov 2022 21:41:25 -0800 (PST)
Message-ID: <b7dc0077-aa27-7802-c30e-ec87e172ecbb@redhat.com>
Date: Thu, 17 Nov 2022 13:41:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] tools/virtio: fix vrinth_test hang
To: Liming Wu <liming.wu@jaguarmicro.com>, mst@redhat.com
References: <20221115111746.858-1-liming.wu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221115111746.858-1-liming.wu@jaguarmicro.com>
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

CuWcqCAyMDIyLzExLzE1IDE5OjE3LCBMaW1pbmcgV3Ug5YaZ6YGTOgo+IHZyaW5naF90ZXN0IGhh
bmdzIG9uIF9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSgpIGJlY2F1c2UgYHZxc19saXN0X2xvY2tgCj4g
aXMgbm90IGluaXRpYWxpemVkLgo+Cj4gTGV0J3MgaW5pdGlhbGl6ZSBpdCAgYmVmb3JlIGNhbGwg
X192cmluZ19uZXdfdmlydHF1ZXVlKCkKPgo+IFNpZ25lZC1vZmYtYnk6IExpbWluZyBXdSA8bGlt
aW5nLnd1QGphZ3Vhcm1pY3JvLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KClRoYW5rcwoKCj4gLS0tCj4gICB0b29scy92aXJ0aW8vdnJpbmdoX3Rlc3Qu
YyB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1n
aXQgYS90b29scy92aXJ0aW8vdnJpbmdoX3Rlc3QuYyBiL3Rvb2xzL3ZpcnRpby92cmluZ2hfdGVz
dC5jCj4gaW5kZXggZmE4N2I1OGJkNWZhLi45OGZmODA4ZDZmMGMgMTAwNjQ0Cj4gLS0tIGEvdG9v
bHMvdmlydGlvL3ZyaW5naF90ZXN0LmMKPiArKysgYi90b29scy92aXJ0aW8vdnJpbmdoX3Rlc3Qu
Ywo+IEBAIC0zMDgsNiArMzA4LDcgQEAgc3RhdGljIGludCBwYXJhbGxlbF90ZXN0KHU2NCBmZWF0
dXJlcywKPiAgIAo+ICAgCQlndmRldi52ZGV2LmZlYXR1cmVzID0gZmVhdHVyZXM7Cj4gICAJCUlO
SVRfTElTVF9IRUFEKCZndmRldi52ZGV2LnZxcyk7Cj4gKwkJc3Bpbl9sb2NrX2luaXQoJmd2ZGV2
LnZkZXYudnFzX2xpc3RfbG9jayk7Cj4gICAJCWd2ZGV2LnRvX2hvc3RfZmQgPSB0b19ob3N0WzFd
Owo+ICAgCQlndmRldi5ub3RpZmllcyA9IDA7Cj4gICAKPiBAQCAtNDU1LDYgKzQ1Niw3IEBAIGlu
dCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCj4gICAJZ2V0cmFuZ2UgPSBnZXRyYW5nZV9p
b3Y7Cj4gICAJdmRldi5mZWF0dXJlcyA9IDA7Cj4gICAJSU5JVF9MSVNUX0hFQUQoJnZkZXYudnFz
KTsKPiArCXNwaW5fbG9ja19pbml0KCZ2ZGV2LnZxc19saXN0X2xvY2spOwo+ICAgCj4gICAJd2hp
bGUgKGFyZ3ZbMV0pIHsKPiAgIAkJaWYgKHN0cmNtcChhcmd2WzFdLCAiLS1pbmRpcmVjdCIpID09
IDApCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
