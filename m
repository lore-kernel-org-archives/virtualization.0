Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F25EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 03:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E955240408;
	Tue, 17 May 2022 03:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3C8IzR1brH-L; Tue, 17 May 2022 03:16:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8E6044014E;
	Tue, 17 May 2022 03:16:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67FBBC0039;
	Tue, 17 May 2022 03:16:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CED8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E01A641965
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1wMh-T8u0KLR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:16:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E976D41961
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652757388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbRnVcp9O0meW2XEU0F+s/z0o2SVTL/R9a0ui4zYqpQ=;
 b=PupdD+X8+mT5kDuciN3QXyUH9RiRzLURn4NAWQwWqYv43lNwl3VH4m+dBfPbNKxOKOjCLw
 pVcfs8NYQKAl040U+vItPFi8XGyeZGGplcuj6RJbpkoE12CGuwPU5sAFmIIz8xcE7v9nkS
 zkXukhbAfhShWXiwdPjGAZbHD43i8Ok=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-Om8_naTOOaeqk3r43zaFbw-1; Mon, 16 May 2022 23:16:27 -0400
X-MC-Unique: Om8_naTOOaeqk3r43zaFbw-1
Received: by mail-pg1-f197.google.com with SMTP id
 d125-20020a636883000000b003db5e24db27so6789084pgc.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=GbRnVcp9O0meW2XEU0F+s/z0o2SVTL/R9a0ui4zYqpQ=;
 b=OOBfuquxtwED774Tde2y9jpEjDuIdF1jepfSyVi6I8ia0v6FbX2KcYJNdK/uO3XEDA
 0YxvOls3bNFtk9dP/btHJ/1/rwwTR8+iQvrbJIBHmDtP1gxAkpTGftWOQOEvCTGdQT5Q
 qgu7auvXNgw+aZJQLfHxP03Uuf9LgngP/WDVBLJKmIB8DBEwzEKJ5O6DRk4M+9jROIIb
 zksFLQGrewdAk9vo0Fzk0O0tJd8BVrbELGEUcY5GMWHw8MIUJbpKJKtljQKwIGii/dHz
 3H2PmL+9z/6GNi/nA479YijyLuryiwGx5APSLtSghHrJGJyUMOPZs7qpePEFbsYbqat/
 +yWQ==
X-Gm-Message-State: AOAM533CMvDCBJnsk9nPxeHGaoA9PIDXGDz6hzRcbQcvfxU5yft1kVNN
 b/psPRYsWgz688KyYWuOgHVJi2qWP6TxYq/ri/0q5Mn8cLFHE8cg6GUjcycTs0P1gl8DKeYDF+M
 1IE7UsbeK7psRkAslPAbME2vI8B8Hl9FHW2v3wHILSg==
X-Received: by 2002:a63:6808:0:b0:3c5:7405:1cd4 with SMTP id
 d8-20020a636808000000b003c574051cd4mr17975741pgc.444.1652757386743; 
 Mon, 16 May 2022 20:16:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUuMjm7kJMFw/O87FcoHf3F/S46amDUYGLOu/Pt1g3owcEYFf6PR/j0Mt1SvdXglSAw099/Q==
X-Received: by 2002:a63:6808:0:b0:3c5:7405:1cd4 with SMTP id
 d8-20020a636808000000b003c574051cd4mr17975721pgc.444.1652757386523; 
 Mon, 16 May 2022 20:16:26 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a170902d58900b0015e8d4eb2b8sm7703147plh.258.2022.05.16.20.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 20:16:26 -0700 (PDT)
Message-ID: <3d4600f1-b34d-ffad-256b-65cba1c9c380@redhat.com>
Date: Tue, 17 May 2022 11:16:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 2/8] vhost: flush dev once during vhost_dev_stop
To: Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, arbn@yandex-team.com
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-3-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220515202922.174066-3-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CuWcqCAyMDIyLzUvMTYgMDQ6MjksIE1pa2UgQ2hyaXN0aWUg5YaZ6YGTOgo+IFdoZW4gdmhvc3Rf
d29ya19kZXZfZmx1c2ggcmV0dXJucyBhbGwgd29yayBxdWV1ZWQgYXQgdGhhdCB0aW1lIHdpbGwg
aGF2ZQo+IGNvbXBsZXRlZC4gVGhlcmUgaXMgdGhlbiBubyBuZWVkIHRvIGZsdXNoIGFmdGVyIGV2
ZXJ5IHZob3N0X3BvbGxfc3RvcAo+IGNhbGwsIGFuZCB3ZSBjYW4gbW92ZSB0aGUgZmx1c2ggY2Fs
bCB0byBhZnRlciB0aGUgbG9vcCB0aGF0IHN0b3BzIHRoZQo+IHBvbGxlcnMuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBNaWtlIENocmlzdGllIDxtaWNoYWVsLmNocmlzdGllQG9yYWNsZS5jb20+CgoKQWNr
ZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZl
cnMvdmhvc3Qvdmhvc3QuYyB8IDYgKysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhv
c3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+IGluZGV4IDFkODRhMjgxOGM2Zi4uOWY4ZGUw
NGJiNjczIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ICsrKyBiL2RyaXZl
cnMvdmhvc3Qvdmhvc3QuYwo+IEBAIC02NTMsMTEgKzY1MywxMSBAQCB2b2lkIHZob3N0X2Rldl9z
dG9wKHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPiAgIAlpbnQgaTsKPiAgIAo+ICAgCWZvciAoaSA9
IDA7IGkgPCBkZXYtPm52cXM7ICsraSkgewo+IC0JCWlmIChkZXYtPnZxc1tpXS0+a2ljayAmJiBk
ZXYtPnZxc1tpXS0+aGFuZGxlX2tpY2spIHsKPiArCQlpZiAoZGV2LT52cXNbaV0tPmtpY2sgJiYg
ZGV2LT52cXNbaV0tPmhhbmRsZV9raWNrKQo+ICAgCQkJdmhvc3RfcG9sbF9zdG9wKCZkZXYtPnZx
c1tpXS0+cG9sbCk7Cj4gLQkJCXZob3N0X3dvcmtfZGV2X2ZsdXNoKGRldi0+dnFzW2ldLT5wb2xs
LmRldik7Cj4gLQkJfQo+ICAgCX0KPiArCj4gKwl2aG9zdF93b3JrX2Rldl9mbHVzaChkZXYpOwo+
ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodmhvc3RfZGV2X3N0b3ApOwo+ICAgCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
