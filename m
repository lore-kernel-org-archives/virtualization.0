Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1F1C433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 06:44:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE1D64FFC
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 06:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE1D64FFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA79B83D63;
	Wed, 10 Mar 2021 06:44:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ka_EaDn4T5h8; Wed, 10 Mar 2021 06:44:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8913383C7B;
	Wed, 10 Mar 2021 06:44:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E9F9C000A;
	Wed, 10 Mar 2021 06:44:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12995C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 06:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E850F40182
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 06:44:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iPtxAi1cPvoZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 06:44:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D547430CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 06:44:09 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id l2so10743006pgb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Mar 2021 22:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/L+QoKkOaRmU+ASvLNzwIcYpCDJy7YDyKr/EVlNlog0=;
 b=hxg4SSMV7xEVGPAW+t4tjP+JM78kHwcrNk681W1WE7+p1kZ+xj/MAPeulJrQLfQ1gy
 MY78f9vcxT4ACEKQGyIeTjycuHdQ+upNs2h+l9ApfTQMwjzeo4xnXbO/yblNUCKz5aZx
 uED3zpD38W8XSVH3qz/7bY0vwOBbwEphFHXZ18/jS+mMFhAJD61ZEKe9OLlY1tIoLbzx
 Hm4FOHEJG1JyndZauPZufaRXdfPMrANl50bTCqfPxEwJVDso5EgwcoE1PKQ7NJ3gcWV8
 HL/+SHNCGzQD/5Kr1tBefd59ZIOJrtnWoY+1pz4BVbPDMk6q+AkjYCS7yvPX5a8RPezL
 f9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=/L+QoKkOaRmU+ASvLNzwIcYpCDJy7YDyKr/EVlNlog0=;
 b=KVwsMO3I/5EDvkmFBUV1aVIU1ZkzNMtCvVYmmsmy9J2hUTpkLq2ZqdBL87b2q7moxF
 nD+JlXNlilv+9hEPayqd03eTOuRdhBOLhATkHFOZK7Ci2D7E24ddEV2Ewkuae+q6NcrX
 Z3zUJTmxx18yXGKw9BsL+3Q3ywCCxNpX5T+OMAIDtoYlmwlBm+2l1vjRCnY+4AVGuagf
 5Oqj2MyOoQ568nwSbR8buSVVwjm6ZdV1VjPu7CF3YDGcQS68N3Ld/bNsOI7dRMuIq7LM
 ZbuXrKBzJf/eUjftpblmgRdzpBfEC9B06/xZSKSvqJuN4SXNmjyuowPfYiUXEiKWiP6g
 rNQw==
X-Gm-Message-State: AOAM530ulO9imVBRwniqBYRq/dzigXiy2vJDtgpH+4fHpxRN7x9kX3Cd
 X8tcIqYSHVQMrB2kV/rzB70=
X-Google-Smtp-Source: ABdhPJyE9h1PLlojbu2FEG7rbWy4ivd0UsQWUfjnGqJufCi7a81cp7kJM+Xb8r/K5gK+wLcal7iYSA==
X-Received: by 2002:a63:4850:: with SMTP id x16mr1517211pgk.176.1615358648951; 
 Tue, 09 Mar 2021 22:44:08 -0800 (PST)
Received: from google.com ([2620:15c:211:201:f896:d6be:86d4:a59b])
 by smtp.gmail.com with ESMTPSA id o1sm4933251pjp.4.2021.03.09.22.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 22:44:08 -0800 (PST)
Date: Tue, 9 Mar 2021 22:44:05 -0800
From: Minchan Kim <minchan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 9/9] zsmalloc: remove the zsmalloc file system
Message-ID: <YEhqtTEhm3BnJ7hH@google.com>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-10-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309155348.974875-10-hch@lst.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "VMware, Inc." <pv-drivers@vmware.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Daniel Vetter <daniel@ffwll.ch>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Nitin Gupta <ngupta@vflare.org>
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

On Tue, Mar 09, 2021 at 04:53:48PM +0100, Christoph Hellwig wrote:
> Just use the generic anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Minchan Kim <minchan@kernel.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
