Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B0FC433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 01:37:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A269F64F5F
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 01:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A269F64F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 77BFE85F41;
	Thu,  4 Feb 2021 01:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KEzlH1iMuqOC; Thu,  4 Feb 2021 01:37:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 60A8B84DFF;
	Thu,  4 Feb 2021 01:37:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 352AFC0174;
	Thu,  4 Feb 2021 01:37:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32E66C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 01:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 15C09864C5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 01:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uL6EbNue58Fj
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 01:37:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C2A2486146
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 01:37:27 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id d20so2070556oiw.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Feb 2021 17:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=39A9Boqpl+Q5qPNytwKZXYAQVcXFAhqxO5/2wT5npug=;
 b=mod0Don/QV9FTi/EJbgWnJ0gQMIaaAjgFdaq7/FFT8PBXQK25y/Mxcbw8zGv0HBAju
 qAMlCH4EkZFYZqil7Jor2YuLPQrsvMAGXeG3HFuSx8ZCUnLcyfMTm+Zm+jzFRL+BuczU
 I0fKU2F/dBI8lJBGBL38DW0T5G//wfSoPV7klAoI4dPVa3/0h89/Wfqodxic65/lU6oa
 SsPrweW25ZC//g7uJe5qWkWK1hwS1L3zkpU90fy5k4jpvvLrPjTdNKZx2AUd8y/7GFMX
 14pNV0OL/47YqwrQUsk+bdQ2Mk9paqv9VJyaLE/KWXvOIScjsusYwEWMySmb4Wc1TSzW
 GhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=39A9Boqpl+Q5qPNytwKZXYAQVcXFAhqxO5/2wT5npug=;
 b=Xjvg4R+yFOJTereLIecBAO5f/kkHrPt56hI2F44pQFp7NudPT9NE+Y2RraqeDw7OBT
 07JQk3P8wNk519pe6PTGZdQK0SQw9wjEdshlIhOkqTZlcCfOXSK1PJck3x0sBYfmVjWD
 4nDKlsuqUOg0G6ys5x0E3QQ8an9k3/Il7RiqFaJ1iaoo95ysJ9SXbwgoNR7RndWvjO0G
 cMniMRFSGulZ/iMRSbNOuFENrhLwnTQSbom7SzCqcZHXSXIfBz9x50mUJqeZO1ZJBgNQ
 sMbNrMh/2JPvJ8DmCX2KGu2mqTrt1FsyqXbz8Pz1e3D4mhkInZfn1SnB0b9+NKDV2DSo
 7t6w==
X-Gm-Message-State: AOAM532tobqXVc3mN45k8BL6pWNzpPMZ2L4ueKTP7n+7eJKoiYYlp9Xp
 2yy++nvSkCRWTl7adce24+c=
X-Google-Smtp-Source: ABdhPJwkqnu6CPAUAxUy0ZLKytwwS1bcdhX4vQ7WglWWFz4vphsh9+ISO2BRaWsFJWa3wGHvDHtwTA==
X-Received: by 2002:aca:cc96:: with SMTP id c144mr3752003oig.10.1612402647014; 
 Wed, 03 Feb 2021 17:37:27 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.50])
 by smtp.googlemail.com with ESMTPSA id 68sm803189otr.16.2021.02.03.17.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 17:37:25 -0800 (PST)
Subject: Re: [PATCH iproute2-next v3 1/5] Add kernel headers
To: Parav Pandit <parav@nvidia.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 stephen@networkplumber.org, mst@redhat.com, jasowang@redhat.com
References: <20210122112654.9593-3-parav@nvidia.com>
 <20210202103518.3858-1-parav@nvidia.com>
 <20210202103518.3858-2-parav@nvidia.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <abc71731-012e-eaa4-0274-5347fc99c249@gmail.com>
Date: Wed, 3 Feb 2021 18:37:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202103518.3858-2-parav@nvidia.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 2/2/21 3:35 AM, Parav Pandit wrote:
> Add kernel headers to commit from kernel tree [1].
>    79991caf5202c7 ("vdpa_sim_net: Add support for user supported devices")
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git branch: linux-next
> 

Thinking about this flow a bit more: If new features to
uapi/linux/vdpa.h are coming through Michael's tree which is not sent
via net-next, then I think this header needs to be managed like the rdma
uapi files. In that case it should be added to iproute2 as
vdpa/include/uapi/linux and you / vdpa dev's will be responsible for
managing updates. In general, this should not be a trend, but seems to
be needed since vdpa is more than just a networking tool.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
