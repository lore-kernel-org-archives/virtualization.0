Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE743C11F66
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 04:11:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881E361CC7
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 04:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881E361CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4348B402A8;
	Tue, 29 Jun 2021 04:11:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RB-jIe-whuU3; Tue, 29 Jun 2021 04:11:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8D356400DE;
	Tue, 29 Jun 2021 04:11:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 540D0C001A;
	Tue, 29 Jun 2021 04:11:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46BEBC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02DB1403C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:11:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nsy0_s5dSg0a
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:11:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1237A40341
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624939870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=artctqxsXOBji6dZlUYYfDDilnt3HH/T60QvobzscDY=;
 b=YZT/4XRl066ZtTOCcetvTRH9LwohOJpfd4shwpKM0VTYBTXcCScIKnrwgUy+kzeVtbY7Ar
 2csefGi1IonOv2ZsmOy+L2m2xhnuRPCXzS3YYQtD4qZpW5nAendl6W6krnd+jjTkS2NTKj
 MBbn3FdDQpP1lIuXtAU/Q6ezLC4Pqdw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-x2cC49C6Ms2B1dUNzO_u1w-1; Tue, 29 Jun 2021 00:11:05 -0400
X-MC-Unique: x2cC49C6Ms2B1dUNzO_u1w-1
Received: by mail-pg1-f198.google.com with SMTP id
 17-20020a630b110000b029022064e7cdcfso13398244pgl.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 21:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=artctqxsXOBji6dZlUYYfDDilnt3HH/T60QvobzscDY=;
 b=quakrc+9aiMjqG2kkhoSCFQrq5rhl8xISD8G6k4/tpPEhPDrjXDLgJdVaRLK05+hIm
 pbtkXrvTZ9IO06j/eQz6KCnd5/1UVuGMXx4U4xjRH+5f2/hOpsnRkcFEDdfetPuGtgol
 nmaIVkBzqaVD/R0QcwrisMLNujdvfdMC7l++z260cMEzyuGcghkMasw4rDDHf1Q3f/Gm
 fB6/hba4DkWuPhF4TWL/lDVJNyTOTWbm5zHhpvwPfqwb3Rna7wC+Ff4lD9u9/newiqIg
 ujPSYa//dLZKk7gWZOKb1YOBOh+dTQ1omZB5WoKtr2mKIfltzG7JFnydNJWFjk69wSAZ
 gxVg==
X-Gm-Message-State: AOAM533EGdxiYGyHHLhrjjfUlHcSWSGDHSeNY3ZDL/gtpCDX1fqI/NdR
 XQMuyLf8DdC63TBqIAz5iiF3wu0OmKN2regSEJxM5jC0GZMRf8XAWP0l6eiQc/mubxRsPT3zjYR
 qNELRka642c+MF8eHk83aEFSAChjouWorayy3p8TCgQ==
X-Received: by 2002:a62:b616:0:b029:303:aa7b:b2e0 with SMTP id
 j22-20020a62b6160000b0290303aa7bb2e0mr28469460pff.21.1624939864874; 
 Mon, 28 Jun 2021 21:11:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEtTsRWTzX+1HKlyYauA7LaEp1VCLZNHRfy5MStjoYEhho4d0zuZ1s0SoSqwSCB7kvsITcEw==
X-Received: by 2002:a62:b616:0:b029:303:aa7b:b2e0 with SMTP id
 j22-20020a62b6160000b0290303aa7bb2e0mr28469429pff.21.1624939864605; 
 Mon, 28 Jun 2021 21:11:04 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id cs1sm1085868pjb.56.2021.06.28.21.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jun 2021 21:11:04 -0700 (PDT)
Subject: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
To: "Liu, Xiaodong" <xiaodong.liu@intel.com>,
 Xie Yongji <xieyongji@bytedance.com>, "mst@redhat.com" <mst@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "parav@nvidia.com" <parav@nvidia.com>, "hch@infradead.org"
 <hch@infradead.org>,
 "christian.brauner@canonical.com" <christian.brauner@canonical.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "bcrl@kvack.org" <bcrl@kvack.org>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "mika.penttila@nextfour.com" <mika.penttila@nextfour.com>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210628103309.GA205554@storage2.sh.intel.com>
 <bdbe3a79-e5ce-c3a5-4c68-c11c65857377@redhat.com>
 <BYAPR11MB2662FFF6140A4C634648BB2E8C039@BYAPR11MB2662.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <41cc419e-48b5-6755-0cb0-9033bd1310e4@redhat.com>
Date: Tue, 29 Jun 2021 12:10:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB2662FFF6140A4C634648BB2E8C039@BYAPR11MB2662.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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
Content-Type: text/plain; charset="iso-2022-jp"; Format="flowed"; DelSp="yes"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


在 2021/6/28 下午1:54, Liu, Xiaodong 写道:
>> Several issues:
>>
>> - VDUSE needs to limit the total size of the bounce buffers (64M if I was not
>> wrong). Does it work for SPDK?
> Yes, Jason. It is enough and works for SPDK.
> Since it's a kind of bounce buffer mainly for in-flight IO, so limited size like
> 64MB is enough.


Ok.


>
>> - VDUSE can use hugepages but I'm not sure we can mandate hugepages (or we
>> need introduce new flags for supporting this)
> Same with your worry, I'm afraid too that it is a hard for a kernel module
> to directly preallocate hugepage internal.
> What I tried is that:
> 1. A simple agent daemon (represents for one device)  `preallocates` and maps
>      dozens of 2MB hugepages (like 64MB) for one device.
> 2. The daemon passes its mapping addr&len and hugepage fd to kernel
>      module through created IOCTL.
> 3. Kernel module remaps the hugepages inside kernel.


Such model should work, but the main "issue" is that it introduce  
overheads in the case of vhost-vDPA.

Note that in the case of vhost-vDPA, we don't use bounce buffer, the  
userspace pages were shared directly.

And since DMA is not done per page, it prevents us from using tricks  
like vm_insert_page() in those cases.


> 4. Vhost user target gets and maps hugepage fd from kernel module
>      in vhost-user msg through Unix Domain Socket cmsg.
> Then kernel module and target map on the same hugepage based
> bounce buffer for in-flight IO.
>
> If there is one option in VDUSE to map userspace preallocated memory, then
> VDUSE should be able to mandate it even it is hugepage based.
>

As above, this requires some kind of re-design since VDUSE depends on  
the model of mmap(MAP_SHARED) instead of umem registering.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
