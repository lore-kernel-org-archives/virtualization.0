Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A1BC4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 07:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF577822F4;
	Mon,  6 Nov 2023 07:27:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF577822F4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RsLu0LKq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SCH4D_F3TQM2; Mon,  6 Nov 2023 07:27:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 953B081E84;
	Mon,  6 Nov 2023 07:27:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 953B081E84
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CDDDC0071;
	Mon,  6 Nov 2023 07:27:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD999C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86F78822F2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:27:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86F78822F2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r2c1KhKTyKf7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:27:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D5B6981E84
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:27:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5B6981E84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699255672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=43URkpYtRBGE0OYmyASXAaiR9gWD2J5xkyb/eiFUiBk=;
 b=RsLu0LKqlCFfQcEsvKKaKTbNgRvqrpVw3W3Ox8fFDgPbhqWRMrQdLeuAGAbBmT2YocJHuH
 P7FZ+LH6jVcu2abILAPooko8H42TcRLnApp7j2Bmnk1Kx7/84bwJUeKLKKYUuRg4GDLUXk
 LIoTdZSWSgsvuVALSteJRUSpQDNf9wU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-KXL4CkFYP56HlJyw9TAMyQ-1; Mon, 06 Nov 2023 02:27:50 -0500
X-MC-Unique: KXL4CkFYP56HlJyw9TAMyQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507cb169766so3869167e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Nov 2023 23:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699255669; x=1699860469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43URkpYtRBGE0OYmyASXAaiR9gWD2J5xkyb/eiFUiBk=;
 b=L20Zk8QMGuZpkQmcR7tFbecesIjtFsF7BZc0rI+UzdRhoNevjUKeTPPQIrXSxj2EH3
 G8mVFgEhnjpgjiRvXuSn2dFNTJY+JVfYY/9SHmkrYGKGL+9rOGw+F6060RCx/3rQbOto
 fSgXn3eeuIMV5ZkONRRpZgkqv3qx0cr0Wz1pDRE6gLDf+ufddrEcdSX7n5ZT7kZtZ9oN
 pi6K/VCcidMz68tchvocdlHaqTzhjoBA4XIilUngjetGGrTC5siXlCjGha4Q0EZTehhS
 z4Mxm5Kx5YROmYvBRJzemecK4X9dHUhuqTTztot1A6i0O3x6IjlIcfgEAFn1IrOuZzou
 QBHw==
X-Gm-Message-State: AOJu0Yyyo59XnnorLPEWqJkwE5ggwdt/Jqr46IWHJ8/TjpMKf6+Rb83J
 hiwfl9bF8Z1DFBmjyrZHbqGRYFFZizR0ye5VpJAXOLaWjXFS/R+XLjcb3c6BKVRUJ0qa9m/Pvcf
 AYoCHqxk4bvFMP5NqF2duGMBZ9rJsCcAOt4DfkVO2hbGkjhGvHD8mvAJs/A==
X-Received: by 2002:a19:e011:0:b0:503:fc2:bfaf with SMTP id
 x17-20020a19e011000000b005030fc2bfafmr19235617lfg.33.1699255669567; 
 Sun, 05 Nov 2023 23:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeuHCmPxbI1vFCSmuwsvTXlqbF/Vv6BpaewiH5OFPHTfdUlAVBDe19efaIgP47YNORg4NZHGPl5Yde3mGZKnw=
X-Received: by 2002:a19:e011:0:b0:503:fc2:bfaf with SMTP id
 x17-20020a19e011000000b005030fc2bfafmr19235608lfg.33.1699255669287; Sun, 05
 Nov 2023 23:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231103171641.1703146-4-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Nov 2023 15:27:38 +0800
Message-ID: <CACGkMEt+HRZbCDGUefu268P7+0QffDpMA-RHzArhjZ2i-zRWEw@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: yi.l.liu@intel.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 jgg@nvidia.com
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

T24gU2F0LCBOb3YgNCwgMjAyMyBhdCAxOjE34oCvQU0gQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4KPiBWSE9TVF9WRFBBX1NFVF9JT01NVV9GRDogYmluZCB0aGUgZGV2aWNlIHRv
IGlvbW11ZmQgZGV2aWNlCj4KPiBWRFBBX0RFVklDRV9BVFRBQ0hfSU9NTVVGRF9BUzogQXR0YWNo
IGEgdmRwYSBkZXZpY2UgdG8gYW4gaW9tbXVmZAo+IGFkZHJlc3Mgc3BhY2Ugc3BlY2lmaWVkIGJ5
IElPQVMgaWQuCj4KPiBWRFBBX0RFVklDRV9ERVRBQ0hfSU9NTVVGRF9BUzogRGV0YWNoIGEgdmRw
YSBkZXZpY2UKPiBmcm9tIHRoZSBpb21tdWZkIGFkZHJlc3Mgc3BhY2UKPgo+IFNpZ25lZC1vZmYt
Ynk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+CgpBcyBkaXNjdXNzZWQgaW4gdGhlIHByZXZp
b3VzIHZlcnNpb24sIGFueSByZWFzb24vYWR2YW50YWdlcyBvZiB0aGlzCmNvbXBhcmVkIHRvIGp1
c3QgaGF2aW5nIGEgc2luZ2xlICBWRFBBX0RFVklDRV9BVFRBQ0hfSU9NTVVGRF9BUz8KClRoYW5r
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
