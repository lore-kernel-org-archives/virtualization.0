Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5C2C6379F
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 17:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA4A141843;
	Mon, 30 Jan 2023 17:09:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA4A141843
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sLC8JHsVbGDg; Mon, 30 Jan 2023 17:09:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9722241837;
	Mon, 30 Jan 2023 17:09:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9722241837
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 761F5C0032;
	Mon, 30 Jan 2023 17:09:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B5C7C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 17:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48AA081E48
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 17:09:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48AA081E48
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fqoKpQlrw7hS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 17:09:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76FAE81E44
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76FAE81E44
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 17:09:29 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id b5so5047039plz.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VcAkkG+7EQ87q1yuQfzrNQ/CVfL1BPFACyrSB5AzC9E=;
 b=YXD5ijCmXWVmOiQaLGwFG6mzlwVl/ifHvN0gKAT5MQYVwj7/LWtONc4EuEoU3ZFG/A
 LJXkUfOFWah9t5nCWEqlB6eLPoYcZjAAT1gqCoZ5RhX6RgSZeGynt7tB4AOEHPSIiS8k
 M//KQNhfVWD5Ry3uVxWvCPH0sDKxXOt02fy6n7EMzBxdtDDcYORpRyScha6DplQAMbko
 6RH1eN3xIZqmojsfF2epqfjyvK9ENq5JykDdIILYZEAxIPX0iOkCt11ctmPM2owKuLlp
 Gym1Gm72OgUOLVeBfOzIu/D3z0oNTH7W0lhKNhzDL/yo+0uyurjpwFrkZN7EyAONFtly
 tmIQ==
X-Gm-Message-State: AFqh2koMbOkkx8DNFHsCPaf5lsS+gendXHXAvYn64YUPKN6d0szB8ZgK
 dH7aodcrtHnXk10squfe/4g=
X-Google-Smtp-Source: AMrXdXsoThEeXwb5X9zNdrMM/dBzAwAKgsQUh4DVjXEWAVyR5f6ZoR++CGV0u6k+ufH+Ks5WBdnq6g==
X-Received: by 2002:a17:902:f646:b0:194:46e0:1b61 with SMTP id
 m6-20020a170902f64600b0019446e01b61mr52496709plg.63.1675098568615; 
 Mon, 30 Jan 2023 09:09:28 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:5016:3bcd:59fe:334b?
 ([2620:15c:211:201:5016:3bcd:59fe:334b])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a170902b49000b0019602263feesm8042186plr.90.2023.01.30.09.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jan 2023 09:09:27 -0800 (PST)
Message-ID: <2bab7050-dec7-3af8-b643-31b414b8c4b4@acm.org>
Date: Mon, 30 Jan 2023 09:09:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 01/23] block: factor out a bvec_set_page helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-2-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230130092157.1759539-2-hch@lst.de>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Eric Dumazet <edumazet@google.com>, target-devel@vger.kernel.org,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 Mike Marshall <hubcap@omnibond.com>, linux-cifs@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, io-uring@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, devel@lists.orangefs.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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

On 1/30/23 01:21, Christoph Hellwig wrote:
> Add a helper to initialize a bvec based of a page pointer.  This will help
> removing various open code bvec initializations.

Why do you want to remove the open-coded bvec initializations? What is 
wrong with open-coding bvec initialization? This patch series modifies a 
lot of code but does not improve code readability. Anyone who encounters 
code that uses the new function bvec_set_page() has to look up the 
definition of that function to figure out what it does.

> -	iv = bip->bip_vec + bip->bip_vcnt;
> -
>   	if (bip->bip_vcnt &&
>   	    bvec_gap_to_prev(&bdev_get_queue(bio->bi_bdev)->limits,
>   			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
>   		return 0;
>   
> -	iv->bv_page = page;
> -	iv->bv_len = len;
> -	iv->bv_offset = offset;
> +	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
>   	bip->bip_vcnt++;

Has it been considered to use structure assignment instead of 
introducing bvec_set_page(), e.g. as follows?

bip->bip_vec[bip->bip_vcnt] = (struct bio_vec) {
       .bv_page = page, .bv_len = len, .bv_offset = offset };

Thanks,

Bart.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
