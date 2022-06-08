Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AC2C43334
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 09:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 059FF40103;
	Wed,  8 Jun 2022 09:59:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EDfUGNFZ7Q60; Wed,  8 Jun 2022 09:59:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8598840025;
	Wed,  8 Jun 2022 09:59:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5812AC0032;
	Wed,  8 Jun 2022 09:59:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D30DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 09:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B075400F3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 09:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eQmoxHh3yeOL
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 09:59:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7404840025
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 09:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654682378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7ko0a61KQIEYlZE2OolrSj5KPboqylHtHlNY2Rk0xk=;
 b=VaxoQa74af1KpBUfmYVcmRpHxUBU73u40BqwdLOciO6zi09uLfV8SFOJIzsZvUiWmGRBte
 pVScgcOnTr2fbdx/xfEe21XK+wko0i7sUburY16pt3SZOBspJIA2BVV/L+TL0Nvi6EFJXK
 TnmxPLhFRPltOknj5hWKKjUVs+44CuI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-Lt-JhEvEPtCbhL4XFso1SQ-1; Wed, 08 Jun 2022 05:59:35 -0400
X-MC-Unique: Lt-JhEvEPtCbhL4XFso1SQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 z13-20020a7bc7cd000000b0039c4a238eadso2482226wmk.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Jun 2022 02:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=X7ko0a61KQIEYlZE2OolrSj5KPboqylHtHlNY2Rk0xk=;
 b=NcJNPk521hS+Cn+WXPSTMqMIlE7MjgSmaJgPoLTQEQcVSvv8avdVK9+wgZqBsAfBu7
 jIJHxssscYa8UNWhykY4jjZIunsxYL+1txViSCQ7jbPoi8Xs+h1BKTQTccpjD9fjV7n/
 HeX3h851mhm0COW5hxx8DVRIFWK8LbI3grCLWmpXkPzIgIYCp3ilXRBo630XoNd9Mh+f
 5IfSenXaeB/5MNi0ZnrtVVnaMpuwuOIPHkaP4p30Zd8fQzjbMrJY+tqTOSFnwxZFSBt7
 0eeTrb3fUlB61Ei2IGkFPzulN2i2eE2ohBA5MCc7pLRztvmezy78/unj4DsJRGBg6uAA
 c2ew==
X-Gm-Message-State: AOAM533PT++oJ6i6VfdrjwRDSdS88fDTBhmkvd3YJHVQ8PXko3iFC75d
 0Z+bkL/MFQlplYubx0gNTti3PBbFlJAm1ckEWSc+/Y9b9gi3mayFi0HMaytWhjCgV9iwJyIMAir
 aYOTyDfE+33nbcUBz0zTNPNRZAJzfAdICe78vbnJ8cA==
X-Received: by 2002:a05:600c:154d:b0:394:8d64:9166 with SMTP id
 f13-20020a05600c154d00b003948d649166mr33665201wmg.102.1654682374082; 
 Wed, 08 Jun 2022 02:59:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4BCTXIM51kCwL6Z6H/hpvqsMvzu1fv9X/GhiUOzp5r00CIAo0BKvmPAyhZ/PubqP5kGP1SQ==
X-Received: by 2002:a05:600c:154d:b0:394:8d64:9166 with SMTP id
 f13-20020a05600c154d00b003948d649166mr33665171wmg.102.1654682373804; 
 Wed, 08 Jun 2022 02:59:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ad00:db2:4c6:8f3a:2ec4?
 (p200300cbc705ad000db204c68f3a2ec4.dip0.t-ipconnect.de.
 [2003:cb:c705:ad00:db2:4c6:8f3a:2ec4])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a05600c1d9300b003942a244f39sm2898272wms.18.2022.06.08.02.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jun 2022 02:59:33 -0700 (PDT)
Message-ID: <36cc5e2b-b768-ce1c-fa30-72a932587289@redhat.com>
Date: Wed, 8 Jun 2022 11:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: Matthew Wilcox <willy@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-16-willy@infradead.org>
 <e4d017a4-556d-bb5f-9830-a8843591bc8d@redhat.com>
 <Yp9fj/Si2qyb61Y3@casper.infradead.org>
 <Yp+lU55H4igaV3pB@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 15/20] balloon: Convert to migrate_folio
In-Reply-To: <Yp+lU55H4igaV3pB@casper.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 Rafael Aquini <aquini@redhat.com>, Minchan Kim <minchan@kernel.org>,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 07.06.22 21:21, Matthew Wilcox wrote:
> On Tue, Jun 07, 2022 at 03:24:15PM +0100, Matthew Wilcox wrote:
>> On Tue, Jun 07, 2022 at 09:36:21AM +0200, David Hildenbrand wrote:
>>> On 06.06.22 22:40, Matthew Wilcox (Oracle) wrote:
>>>>  const struct address_space_operations balloon_aops = {
>>>> -	.migratepage = balloon_page_migrate,
>>>> +	.migrate_folio = balloon_migrate_folio,
>>>>  	.isolate_page = balloon_page_isolate,
>>>>  	.putback_page = balloon_page_putback,
>>>>  };
>>>
>>> I assume you're working on conversion of the other callbacks as well,
>>> because otherwise, this ends up looking a bit inconsistent and confusing :)
>>
>> My intention was to finish converting aops for the next merge window.
>>
>> However, it seems to me that we goofed back in 2016 by merging
>> commit bda807d44454.  isolate_page() and putback_page() should
>> never have been part of address_space_operations.
>>
>> I'm about to embark on creating a new migrate_operations struct
>> for drivers to use that contains only isolate/putback/migrate.
>> No filesystem uses isolate/putback, so those can just be deleted.
>> Both migrate_operations & address_space_operations will contain a
>> migrate callback.

That makes sense to me. I wonder if there was a design
decision/discussion behind that. CCing Rafael.

@Rafael, full mail at

https://lkml.kernel.org/r/Yp+lU55H4igaV3pB@casper.infradead.org

> 
> Well, that went more smoothly than I thought it would.
> 
> I can't see a nice way to split this patch up (other than making secretmem
> its own patch).  We just don't have enough bits in struct page to support
> both ways of handling PageMovable at the same time, so we can't convert
> one driver at a time.  The diffstat is pretty compelling.

Yes, splitting rather overcomplicates stuff.

> 
> The patch is on top of this patch series; I think it probably makes
> sense to shuffle it to be first, to avoid changing these drivers to
> folios, then changing them back.

Absolutely.

> 
> Questions:
> 
> Is what I've done with zsmalloc acceptable?  The locking in that
> file is rather complex.
> 
> Can we now eliminate balloon_mnt / balloon_fs from cmm.c?  I haven't even
> compiled thatfile , but it seems like the filesystem serves no use now.
> 
> Similar question for vmw_balloon.c, although I have compiled that.

IIRC, virtio-balloon, cmm and vmw_balloon all have the mnt/fs just for
page migration purposes. So if one can get rid of them, all should be
able to get rid of them. Essentially everything that uses the balloon
compaction framework.

That should go into separate patches then.

> 
> ---
> 
> I just spotted a bug with zs_unregister_migration(); it won't compile
> without CONFIG_MIGRATION.  I'll fix that up if the general approach is
> acceptable.
> 
>  arch/powerpc/platforms/pseries/cmm.c |   13 --------
>  drivers/misc/vmw_balloon.c           |   10 ------
>  include/linux/balloon_compaction.h   |    6 +---
>  include/linux/fs.h                   |    2 -
>  include/linux/migrate.h              |   27 ++++++++++++++----
>  include/linux/page-flags.h           |    2 -
>  mm/balloon_compaction.c              |   18 ++++++------
>  mm/compaction.c                      |   29 ++++++++-----------
>  mm/migrate.c                         |   23 ++++++++-------
>  mm/secretmem.c                       |    6 ----
>  mm/util.c                            |    4 +-
>  mm/z3fold.c                          |   45 ++++++------------------------
>  mm/zsmalloc.c                        |   52 +++++++++--------------------------
>  13 files changed, 83 insertions(+), 154 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 15ed8206c463..2ecbab3db723 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -578,23 +578,10 @@ static int cmm_balloon_compaction_init(void)
>  		return rc;
>  	}
>  
> -	b_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
> -	if (IS_ERR(b_dev_info.inode)) {
> -		rc = PTR_ERR(b_dev_info.inode);
> -		b_dev_info.inode = NULL;
> -		kern_unmount(balloon_mnt);
> -		balloon_mnt = NULL;
> -		return rc;
> -	}
> -
> -	b_dev_info.inode->i_mapping->a_ops = &balloon_aops;


Are you missing similar updates to drivers/virtio/virtio_balloon.c ?

At least, there we're also using balloon_aops, so this patch shouldn't
compile.


Skimming over it, nothing else jumped at me.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
