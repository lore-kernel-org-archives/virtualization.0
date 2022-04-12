Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0D0C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 12:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A996361015;
	Tue, 12 Apr 2022 12:35:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NS9jVPocuhJY; Tue, 12 Apr 2022 12:35:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4AC3B60E3A;
	Tue, 12 Apr 2022 12:35:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20730C0033;
	Tue, 12 Apr 2022 12:35:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9412C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 12:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A462D40189
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 12:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IlLCISE8sMko
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 12:35:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6974E4053C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649766929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJqglimaomRAKenwQeCDnCnI75AgWyOOY6lOl0E6tbs=;
 b=Qh/XsueH5OQSbq4hWk2PEJ6QaSWoHBXlNQQ6XehhGV0OWgXrfHmFG+Hob6iFZa1cKC8VUZ
 Mv/Ya4Y+8TWmDepwj213gjso1j75jFnhaEc9UoMKysuAnAvr7w/U0A1kPMMPJlq+QQgsjv
 kqAka+sWE2ZemdyXYssoYXflfRunoXY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-bfEyegAvN2GK3FeIvBxSwA-1; Tue, 12 Apr 2022 08:35:28 -0400
X-MC-Unique: bfEyegAvN2GK3FeIvBxSwA-1
Received: by mail-wm1-f70.google.com with SMTP id
 n17-20020a05600c501100b0038e731cf5e1so1223403wmr.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 05:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=iJqglimaomRAKenwQeCDnCnI75AgWyOOY6lOl0E6tbs=;
 b=kGONgL8UFGVtUVBZov4JRmii6zK/SoE7kEhTKvAucSqs29Myt1t0iwxDncQj4us4T/
 Sx+8C/wpN6Lp3WKyPUACh3+fRLWx2lcHsQEfpaov+4ZoY53YlusPqXy/8TBRmb8Z74pl
 kI3PumxIXB++KnNifbf4+LW9bM2V6S/hgO76oimQKSIY1BhWCQn7+CLX+oc8O++J9/a6
 LCAX7nZF/mERiN6AHA+D3FO8IZBu3nQekHm19ejuwYHafkihTNoQtspY9BLd6sJqPUhT
 MnAEt5m2qQTjiKREjFvAwSBrlft7WP+ZasfMzaRYOe9ca6xh7Ww3UgDBru7saf/izvA/
 rh9Q==
X-Gm-Message-State: AOAM5335+SNZ9mRivuR02UA9SgfnNyOX3bOvONNPrRtHocrTFjes4o6W
 jU9Cbqd7naeUH0jxNWNg3k6yl3MXDjT7oL3hBiBJv1NBbgDcT0OkKTqD+CGBbSVnTpenzLaFhBT
 uulzVO1dQd1DPbu0nLTTZ8sc8bExFkoB6P8xW+zl5PA==
X-Received: by 2002:a05:6000:1f8e:b0:207:a52d:f611 with SMTP id
 bw14-20020a0560001f8e00b00207a52df611mr9182378wrb.266.1649766927062; 
 Tue, 12 Apr 2022 05:35:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydZ5Q8ljJxU2bpbKbM9Dux/MSsB7WSQBOCEUZQwPv9Vg5TXtMNLisSRZglh2z5p3/OYrFUJA==
X-Received: by 2002:a05:6000:1f8e:b0:207:a52d:f611 with SMTP id
 bw14-20020a0560001f8e00b00207a52df611mr9182354wrb.266.1649766926776; 
 Tue, 12 Apr 2022 05:35:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3?
 (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de.
 [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a5d4e08000000b002054b5437f2sm28472436wrt.115.2022.04.12.05.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 05:35:26 -0700 (PDT)
Message-ID: <9ba426a0-3cbf-2794-39bc-bc0dfbeb3841@redhat.com>
Date: Tue, 12 Apr 2022 14:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v10 0/5] Use pageblock_order for cma and
 alloc_contig_range alignment.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20220406151858.3149821-1-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220406151858.3149821-1-zi.yan@sent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 virtualization@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
 Eric Ren <renzhengeek@gmail.com>, Mel Gorman <mgorman@techsingularity.net>,
 Mike Rapoport <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>
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

On 06.04.22 17:18, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi David,

Hi!

> 
> This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
> and alloc_contig_range(). It prepares for my upcoming changes to make
> MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-04-05-15-54.

Sorry for the late reply, I've got way too many irons in the fire right now.

> 
> I also added "Content-Type: text/plain; charset=UTF-8" to all email bodies
> explicitly, please let me know if you still cannot see the emails in a
> proper format.

Oh, thanks! But no need to work around Mimecast mailing issues on your
side. This just has to be fixed for good on the RH side ...


I yet heave to give #3 a thorough review, sorry for not commenting on
that earlier. It's a bit more involved, especially, with all the
possible corner cases :)

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
