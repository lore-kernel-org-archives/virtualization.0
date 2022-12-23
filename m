Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC24C4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 09:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D80C8215A;
	Fri, 23 Dec 2022 09:40:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D80C8215A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ygo1U0Eu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0p8Qimeif1vw; Fri, 23 Dec 2022 09:40:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1BB2182110;
	Fri, 23 Dec 2022 09:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BB2182110
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1808C0071;
	Fri, 23 Dec 2022 09:40:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F90AC0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 09:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DAC9B82113
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 09:40:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DAC9B82113
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jdKl2PHgXt_E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 09:40:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72A6782110
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72A6782110
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671788421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYdCTqml4c7ljbUVU4kZcoEb18gRQ5azwzQzokRe0Yk=;
 b=Ygo1U0EuA50agyZTLi2oC0eSDAeSC9IeKdpr6hgEaMHA3SCnXg+/Sxb/bEcKWEVgINJuzR
 xg2poEFjTbGKxD+Xzjy765+GvC0fQ1dtFHf1F6UqBWmlndXatNxGVN50zKxkrHPVY4P7Kr
 urvNzG3PBl574Gh/F9nt0jczuAh1S9U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-MivDwm-sMCOgQeJ1S6H5mQ-1; Fri, 23 Dec 2022 04:40:19 -0500
X-MC-Unique: MivDwm-sMCOgQeJ1S6H5mQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 m8-20020a05600c3b0800b003d96bdce12fso284039wms.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 01:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dYdCTqml4c7ljbUVU4kZcoEb18gRQ5azwzQzokRe0Yk=;
 b=ASqMoFKjXrSYLS5/MY0Jbz9h54UHk1Dn9KlRPIYtzgazh1RD6vgGKLo/tfaHADuudK
 q9MJgpS78nVRIZYAAcsP5Wur9fBnVWB3e+dcsHufWjLzwKF7PC526RzvOZcMCiF4fMD+
 n4gvh25F5BVdG7OKZ/kflWevfzNVP8VHEkL4ERK3F8egoflU9vANxbOmFaGDN94J0Jdy
 +6thf3q4COjRtBJPl67uMnoTkWlH+61pKlojDivLd65TwUXIMefp0pkQwZ1xjQhj1M2F
 kYnVAcL27ESPpgf59+rHg4JCqZ1k+lrtjofTKnhqFxDixkMHdJen7nAVNBBVsapP8ZUb
 qM3g==
X-Gm-Message-State: AFqh2kq4j5gFeVpvFXixyfFMBFS8NIBnt3/AxVGWHtQ/SuZFXY4fmTFQ
 qkiL/7hjWgBfgz0a5vf2MG9h+GSrCdDIPSh21OF1h1srRk2fVozB/Bgn+x5/cySIeXk8us0Aw9p
 ZC7f4q5QvcnxAPK71q8dLRGjBbnoTgi2ou0AWOocNvg==
X-Received: by 2002:a05:600c:3b22:b0:3c6:e63e:814b with SMTP id
 m34-20020a05600c3b2200b003c6e63e814bmr6654807wms.2.1671788418726; 
 Fri, 23 Dec 2022 01:40:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtPQ3uPs0KjP5mtjfcVVsKM5D3DKI+aZQLipe0tFV+bETDeJScFVeATD1YLHh9iingWOI6IKw==
X-Received: by 2002:a05:600c:3b22:b0:3c6:e63e:814b with SMTP id
 m34-20020a05600c3b2200b003c6e63e814bmr6654789wms.2.1671788418429; 
 Fri, 23 Dec 2022 01:40:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:ab00:3d8e:16c4:a38d:2827?
 (p200300cbc707ab003d8e16c4a38d2827.dip0.t-ipconnect.de.
 [2003:cb:c707:ab00:3d8e:16c4:a38d:2827])
 by smtp.gmail.com with ESMTPSA id
 o27-20020a05600c511b00b003c6f8d30e40sm9565434wms.31.2022.12.23.01.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Dec 2022 01:40:18 -0800 (PST)
Message-ID: <c8ea7076-f107-c340-6b34-6b22a9369da5@redhat.com>
Date: Fri, 23 Dec 2022 10:40:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] virtio_balloon: high order allocation
To: Soichiro Ueda <the.latticeheart@gmail.com>, mst@redhat.com,
 jasowang@redhat.com, akpm@linux-foundation.org
References: <20221223093527.12424-1-the.latticeheart@gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221223093527.12424-1-the.latticeheart@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: cwd@google.com, linux-kernel@vger.kernel.org, kalutes@google.com,
 linux-mm@kvack.org, mhiramat@kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 23.12.22 10:35, Soichiro Ueda wrote:
> At present, the VirtIO balloon device driver allocates pages
> one by one using alloc_page(), and frees them using put_page().
> 
> This changes it so that the driver allocates high order pages
> by using alloc_pages(), and frees them using __free_pages() if possible.
> By doing so, the CPU performance of inflation and deflation
> should be improved.
> 
> The effect of this change has been confirmed by benchmarks that measure
> the elapsed time of inflation and deflation.
> 
> The results are here:
> 
> 16 pages inflation:
>    before: 119,779 ns
>    after : 115,655 ns (-3.4%)
> 64 pages inflation:
>    before: 156,977 ns
>    after : 150,961 ns (-3.8%)
> 256 pages inflation:
>    before: 218,649 ns
>    after : 208,490 ns (-4.6%)
> 16 pages deflation:
>    before: 78,112 ns
>    after : 68,288 ns (-12.6%)
> 64 pages deflation:
>    before: 97,205 ns
>    after : 80,491 ns (-17.194%)
> 256 pages deflation:
>    before: 122,742 ns
>    after : 107,526 ns (-12.4%)

How does this affect page migration / balloon compaction etc?

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
