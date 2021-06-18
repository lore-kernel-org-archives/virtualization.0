Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F38C48BE8
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 07:44:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC672613AA
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 07:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC672613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81DFF40510;
	Fri, 18 Jun 2021 07:44:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wbseg155KIHP; Fri, 18 Jun 2021 07:44:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DF64D40462;
	Fri, 18 Jun 2021 07:44:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92A8CC000D;
	Fri, 18 Jun 2021 07:44:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BD9AC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 566EC605F6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:44:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CF2SkWmi5RlA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:44:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85917605F4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:44:08 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id b11so7341584edy.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xrVDbV297cRNejKsonngV4vGhbIFMI93Q9VE4px56sk=;
 b=DJrFso3Sd/PK31zGllWY1zpb+A/KUBtA1E8u5Qir0hsdifTQYSdRZW1U6CNektQcl7
 8Gwsv7C1odv1jrBJeUaUkxlcjlp8X1pKeC2J+1DP3IUSv0CsFCITaq8JZc3WjTws7uPQ
 4IxWmREr3j6FYQj+LSiYl4jQTvWE68g/xCWzMfT0kpokkoIFlm0HlOIaovz3NUm3XRbN
 wE7uyBGbqLDvxaWPAzFanMx77+YZjL556iOB0wbtNEUUYyaZWtg3ae9HJjDoNyKVy1IK
 fvCBuKgdbz3tUsMUMs1z8Q2cwdxKNYtxY/sI/BfDgxkDL/babYZa0vN5UhC3RLA+ilVb
 2Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xrVDbV297cRNejKsonngV4vGhbIFMI93Q9VE4px56sk=;
 b=BkJFd16/tixETVyNYTCM6DdWxoR+V4M5c/j6tt/or3V+N3R0yrICS6wKh1o0l8UOeP
 xrDCiyefEu90R0KbMwsUJAWvk4/Lv23HY9AMWpqMcA3b+CnQz8935FYlzchxel1Jklr7
 gfrwkciDD7UAcqBDuHtLyPYzf3fDQR0olEEOIjJMyqceOcZaqIRlGhyxCDSfU7h5g7N2
 9GPH0Dj9HRIj7ZnfpxIAHjD/QJWmtOhZ96UAkZE7cpv5Rf4mYLbt/yzyO0RTf8efgsh4
 k9ajONZE1lKnW83XaZxKj726AhoDBwQr4oO6lKjS1fXOXr6+oUmGMmv0e9uskmGkXjaJ
 lRYg==
X-Gm-Message-State: AOAM532xO/wq9Kl9wCYY3DjGYmEUPSnUGvyDjnVdo3zYrBq79liaHXV/
 c0iGGTJrk8IjQpyxOKzl8zE1Eg==
X-Google-Smtp-Source: ABdhPJzREIN0+D0Q7W8RSrNNQ4NDgbr/Euk9okd86tzehslscukuMpktyxR1ml4l0LZerVVX4xGYvQ==
X-Received: by 2002:a05:6402:17d3:: with SMTP id
 s19mr1921993edy.222.1624002246807; 
 Fri, 18 Jun 2021 00:44:06 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id cf26sm680470ejb.38.2021.06.18.00.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 00:44:06 -0700 (PDT)
Date: Fri, 18 Jun 2021 09:43:47 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 3/6] ACPI: Add driver for the VIOT table
Message-ID: <YMxOs8MV+nlCKq7j@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-4-jean-philippe@linaro.org>
 <5a16c21f-ca02-1016-80e9-c374a6fe2b25@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5a16c21f-ca02-1016-80e9-c374a6fe2b25@redhat.com>
Cc: lorenzo.pieralisi@arm.com, mst@redhat.com, catalin.marinas@arm.com,
 joro@8bytes.org, sudeep.holla@arm.com, rjw@rjwysocki.net, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 guohanjun@huawei.com, baolu.lu@linux.intel.com, will@kernel.org,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Wed, Jun 16, 2021 at 03:26:08PM +0200, Eric Auger wrote:
> > +	default:
> > +		pr_warn("Unsupported node %x\n", hdr->type);
> > +		ret = 0;
> > +		goto err_free;
> > +	}
> > +
> > +	/*
> > +	 * To be compatible with future versions of the table which may include
> > +	 * other node types, keep parsing.
> > +	 */
> nit: doesn't this comment rather apply to the default clause in the
> switch.

Yes, the comment doesn't accurately explain the code below, I'll tweak it.

        /*
         * A future version of the table may use the node for other purposes.
         * Keep parsing.
         */

> In case the PCI range node or the single MMIO endoint node does
> not refer to any translation element, isn't it simply an error case?

It is permissible in my opinion. If a future version of the spec appends
new fields to the MMIO endpoint describing some PV property (I can't think
of a useful example), then the table can contain the vIOMMU topology as
usual plus one MMIO node that's only here to describe that property, and
doesn't have a translation element. If we encounter that I think we should
keep parsing.

> > +	if (!ep->viommu) {
> > +		pr_warn("No IOMMU node found\n");
> > +		ret = 0;
> > +		goto err_free;
> > +	}

> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
