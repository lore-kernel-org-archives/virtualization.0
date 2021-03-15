Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB188C433E6
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 07:52:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4095664E49
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 07:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4095664E49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D95BD8348C;
	Mon, 15 Mar 2021 07:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f4GnWCHywp4b; Mon, 15 Mar 2021 07:52:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B2A183443;
	Mon, 15 Mar 2021 07:52:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11793C000A;
	Mon, 15 Mar 2021 07:52:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7091EC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 07:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CFE483455
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 07:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ErE3CkIFgSSN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 07:52:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4379183443
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615794758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3VcyCK15wuo7OnaOdUlq2bza4tGVkBBmoXXTmML6Bg=;
 b=hnaksWImQGfRmAj4ejiiuviZ9A/5QcjPsO/kdgDZ/JbnnIAxlxLNVUB4BarHUPrrBoLO4X
 qmvo5k37X6G9xiK6CzmIPBvCEwzYaehXskskF6r8Bz4XNGH/3y7wFuXUTcwX1LsFuibuNl
 x36PH6X9UPTWRPy34dMpwAjdRd8T/eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-QbWxkMulMV6r7TYiz1r-2A-1; Mon, 15 Mar 2021 03:52:35 -0400
X-MC-Unique: QbWxkMulMV6r7TYiz1r-2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57C5983DD26;
 Mon, 15 Mar 2021 07:52:33 +0000 (UTC)
Received: from [10.36.112.254] (ovpn-112-254.ams2.redhat.com [10.36.112.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B094410023BE;
 Mon, 15 Mar 2021 07:52:29 +0000 (UTC)
Subject: Re: [PATCH 15/17] iommu: remove DOMAIN_ATTR_NESTING
To: Christoph Hellwig <hch@lst.de>
References: <20210301084257.945454-1-hch@lst.de>
 <20210301084257.945454-16-hch@lst.de>
 <3e8f1078-9222-0017-3fa8-4d884dbc848e@redhat.com>
 <20210314155813.GA788@lst.de>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3a1194de-a053-84dd-3d6a-bff8e01ebcd3@redhat.com>
Date: Mon, 15 Mar 2021 08:52:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210314155813.GA788@lst.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>,
 virtualization@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-msm@vger.kernel.org
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

Hi Christoph,

On 3/14/21 4:58 PM, Christoph Hellwig wrote:
> On Sun, Mar 14, 2021 at 11:44:52AM +0100, Auger Eric wrote:
>> As mentionned by Robin, there are series planning to use
>> DOMAIN_ATTR_NESTING to get info about the nested caps of the iommu (ARM
>> and Intel):
>>
>> [Patch v8 00/10] vfio: expose virtual Shared Virtual Addressing to VMs
>> patches 1, 2, 3
>>
>> Is the plan to introduce a new domain_get_nesting_info ops then?
> 
> The plan as usual would be to add it the series adding that support.
> Not sure what the merge plans are - if the series is ready to be
> merged I could rebase on top of it, otherwise that series will need
> to add the method.
OK I think your series may be upstreamed first.

Thanks

Eric
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
