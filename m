Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ED7C636D3
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 14:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B4D860B32;
	Tue, 31 Jan 2023 14:00:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B4D860B32
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hNBqq1Va
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SCARkzB9z4gW; Tue, 31 Jan 2023 14:00:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 20D3360B29;
	Tue, 31 Jan 2023 14:00:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20D3360B29
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7241C0033;
	Tue, 31 Jan 2023 14:00:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AFEFC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 14:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39F934160F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 14:00:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39F934160F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hNBqq1Va
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ls3ViUzgcDm1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 14:00:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDB7F40E47
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDB7F40E47
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675173614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sW7aiMox0CriK8aU+HN+jb3vaXSIy6HBnrk2aPiMthI=;
 b=hNBqq1VaLUmj3Gv1bRG7q+5EQCO429IY7U/08wZlnbsDbr814ZlRjHZ0QxfnaGFtdWzpni
 tDLuxG8mKUlU8g0iKrrkVJslJvv5Pg/tJEf+A+xr1EDIPxSAPiLpbQV/Nn1IDqcMMhscrK
 f3/M7EcB/tK+JCmXdbEaboSZ0rFgfhs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-2V0ubT3xMamrkDFwyeGZVQ-1; Tue, 31 Jan 2023 09:00:12 -0500
X-MC-Unique: 2V0ubT3xMamrkDFwyeGZVQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 o5-20020a05600c4fc500b003db0b3230efso11313745wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 06:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sW7aiMox0CriK8aU+HN+jb3vaXSIy6HBnrk2aPiMthI=;
 b=F1f3iN0e5s2zivhTSP6Yby61Qxjm7iAtjrblTc2hQMgGLEeBQT4hC8cbwL4LLl/8hA
 sYJ2FtFRQHwZQgugSpFw+aG8tz1C++Oj12XlFX0sm9lu7ufVFCR0AmE2aVrVVJ4LNCGv
 H5IKJP94kQFhXxTKF1oxqHpBJerh66ihtGdnuyCnvPQRKvAkvNJ8okzQL4g1OZj4w4gV
 PtkMNElaG6zjt/xE5Lz3MIP1p0PIymHz3T5cMmaBDG6ldKWM/Q263fC5xZNQRtbwxZmP
 tx5iQ7XIjqV6cZGam5QdwI44iYIpC6ZeCKmb3mDgUglKLvrG76PHsmDEBqyNMTUiwGeU
 +LiA==
X-Gm-Message-State: AO0yUKUzALAEpXX8MFLXfq06DKhOxyvDS/CbcCQticoS206dIEguBiF7
 RhIPPuKyLPhrpmkDhs11vn6aDlEVV3usI6bBnuL2XkNnF20vRyyj9exBH80WNLrul+eDiu2c75E
 9i6bRKvvBIkkldzSla5kaoXGA1l0jk+kBgJM4sIB0Kg==
X-Received: by 2002:a05:600c:3b84:b0:3dc:1031:14c4 with SMTP id
 n4-20020a05600c3b8400b003dc103114c4mr3752230wms.14.1675173611367; 
 Tue, 31 Jan 2023 06:00:11 -0800 (PST)
X-Google-Smtp-Source: AK7set94yYHCQtMUhLwwFZW2Tw85+OPCk5GgL8jU/FYp0b92bP94albwy2k0jgp6h4ZElMMLuWMq1g==
X-Received: by 2002:a05:600c:3b84:b0:3dc:1031:14c4 with SMTP id
 n4-20020a05600c3b8400b003dc103114c4mr3752186wms.14.1675173611028; 
 Tue, 31 Jan 2023 06:00:11 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3?
 (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de.
 [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
 by smtp.gmail.com with ESMTPSA id
 e38-20020a05600c4ba600b003dc434900e1sm11512963wmp.34.2023.01.31.06.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Jan 2023 06:00:10 -0800 (PST)
Message-ID: <658eda9c-d716-fcb7-ba0c-b36f646195f1@redhat.com>
Date: Tue, 31 Jan 2023 15:00:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 01/19] mm: Introduce vm_account
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <748338ffe4c42d86669923159fe0426808ecb04d.1674538665.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <748338ffe4c42d86669923159fe0426808ecb04d.1674538665.git-series.apopple@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kselftest@vger.kernel.org, rds-devel@oss.oracle.com, daniel@ffwll.ch,
 kvm@vger.kernel.org, linux-rdma@vger.kernel.org, jhubbard@nvidia.com,
 linux-fpga@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, mkoutny@suse.com, jgg@nvidia.com, hannes@cmpxchg.org,
 bpf@vger.kernel.org, surenb@google.com, tjmercier@google.com,
 io-uring@vger.kernel.org
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

On 24.01.23 06:42, Alistair Popple wrote:
> Kernel drivers that pin pages should account these pages against
> either user->locked_vm or mm->pinned_vm and fail the pinning if
> RLIMIT_MEMLOCK is exceeded and CAP_IPC_LOCK isn't held.
> 
> Currently drivers open-code this accounting and use various methods to
> update the atomic variables and check against the limits leading to
> various bugs and inconsistencies. To fix this introduce a standard
> interface for charging pinned and locked memory. As this involves
> taking references on kernel objects such as mm_struct or user_struct
> we introduce a new vm_account struct to hold these references. Several
> helper functions are then introduced to grab references and check
> limits.
> 
> As the way these limits are charged and enforced is visible to
> userspace we need to be careful not to break existing applications by
> charging to different counters. As a result the vm_account functions
> support accounting to different counters as required.
> 
> A future change will extend this to also account against a cgroup for
> pinned pages.

The term "vm_account" is misleading, no? VM_ACCOUNT is for accounting 
towards the commit limit ....

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
