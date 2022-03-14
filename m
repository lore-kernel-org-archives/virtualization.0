Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A555C433FE
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 06:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A284E405BE;
	Mon, 14 Mar 2022 06:15:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T17eCXx-UFlg; Mon, 14 Mar 2022 06:15:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E998B400D6;
	Mon, 14 Mar 2022 06:15:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB63AC0012;
	Mon, 14 Mar 2022 06:15:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E6B3C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 255E8414E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3EcDONf6zfyW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:15:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8957041504
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647238504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKkdg3dntOwBcgbQm1XQO9eQ5wZ2M2nVD2q0bsmUAZ0=;
 b=RLKWLDgZDq+UN35XMjCjpgJuEYiLnXjysnJa5q5dNfckJCfGPZ+20Jl+TpPTNf4Em6RabB
 HJnIEk1gmRVKGd5HIxdImxP3gcfRaQwDVQasZaZ2enqzqV/V88nk4YFpbEC7M77XPrdiUo
 rtbtCKe+Z0IQjVUbr48Rflf2pRcyBkY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-nIkI3qxzOoar3VIpRrdl_w-1; Mon, 14 Mar 2022 02:15:02 -0400
X-MC-Unique: nIkI3qxzOoar3VIpRrdl_w-1
Received: by mail-pg1-f197.google.com with SMTP id
 v4-20020a63f844000000b003745fd0919aso9425911pgj.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Mar 2022 23:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=KKkdg3dntOwBcgbQm1XQO9eQ5wZ2M2nVD2q0bsmUAZ0=;
 b=tEEuB+EKM377Qh5876sQI8OClvRehRwNBIo5M/PCQM5Afmr7RvXhM2HSVqJRCsYVon
 8a7R3RpnEnw8FlKLp2jEhEsWaVWPErAnzWV5+Qe+9mTW1FwVBQ/dN+K+uVpTHYE8bb9y
 PMGKroB6KAhB2kHK7uw78FO+uoJRQNqlooOfjZb9ukKdwuGlC1Wqys2ACplzdc5gabOd
 CdhJUx55QBcmdgeUpxNLFTMe2vThoZLMBmVSq25tNDA37Fme83N7AZeeWx+6MnzBW4P7
 lTlV3OGUflf9rT/Bt5RszDuM9FIwr3NVG3MNRwxmuzbLWOOM4Lynbq4RbDSYmxB+sQEJ
 vopg==
X-Gm-Message-State: AOAM5330iorRyyAvlNBb4R9NcKG7YX+a2FzjnbTjfhO/9Y24lH8YYz3U
 zOUvcngumdSnKHW0mxs1KERAjzq3BNZxESVWAOF6NwsjeFxdvuPKLiwMzvnDjBu3KfWJ1vBFn85
 7aopVfYQ0J4Jn55FsAaeIDlq6GIFEfLG9D+T+qNhOdw==
X-Received: by 2002:a62:3896:0:b0:4f7:87dc:de5b with SMTP id
 f144-20020a623896000000b004f787dcde5bmr16575140pfa.49.1647238501355; 
 Sun, 13 Mar 2022 23:15:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCjegCsMLdY4MyXbQThlNlXg5KFF47BFkhiTqq+eHo94WlQutLx6EM8a5QWMl/FeDK0C4Hbg==
X-Received: by 2002:a62:3896:0:b0:4f7:87dc:de5b with SMTP id
 f144-20020a623896000000b004f787dcde5bmr16575124pfa.49.1647238501100; 
 Sun, 13 Mar 2022 23:15:01 -0700 (PDT)
Received: from [10.72.13.210] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a628f12000000b004f743724c75sm18185318pfd.53.2022.03.13.23.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 23:15:00 -0700 (PDT)
Message-ID: <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
Date: Mon, 14 Mar 2022 14:14:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH] virtio-blk: support polling I/O
To: Suwan Kim <suwan.kim027@gmail.com>, mst@redhat.com, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220311152832.17703-1-suwan.kim027@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzMvMTEg5LiL5Y2IMTE6MjgsIFN1d2FuIEtpbSDlhpnpgZM6Cj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fYmxrLmggYi9pbmNsdWRlL3VhcGkvbGludXgv
dmlydGlvX2Jsay5oCj4gaW5kZXggZDg4OGYwMTNkOWZmLi4zZmNhZjkzN2FmZTEgMTAwNjQ0Cj4g
LS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ibGsuaAo+ICsrKyBiL2luY2x1ZGUvdWFw
aS9saW51eC92aXJ0aW9fYmxrLmgKPiBAQCAtMTE5LDggKzExOSw5IEBAIHN0cnVjdCB2aXJ0aW9f
YmxrX2NvbmZpZyB7Cj4gICAJICogZGVhbGxvY2F0aW9uIG9mIG9uZSBvciBtb3JlIG9mIHRoZSBz
ZWN0b3JzLgo+ICAgCSAqLwo+ICAgCV9fdTggd3JpdGVfemVyb2VzX21heV91bm1hcDsKPiArCV9f
dTggdW51c2VkMTsKPiAgIAo+IC0JX191OCB1bnVzZWQxWzNdOwo+ICsJX192aXJ0aW8xNiBudW1f
cG9sbF9xdWV1ZXM7Cj4gICB9IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpOwoKClRoaXMgbG9va3Mg
bGlrZSBhIGltcGxlbWVudGF0aW9uIHNwZWNpZmljICh2aXJ0aW8tYmxrLXBjaSkgb3B0aW1pemF0
aW9uLCAKaG93IGFib3V0IG90aGVyIGltcGxlbWVudGF0aW9uIGxpa2Ugdmhvc3QtdXNlci1ibGs/
CgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
