Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF04C0015E
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 19:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E47DA611BF;
	Wed, 26 Jul 2023 19:28:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E47DA611BF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2MmS470d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TEyAvbvusAVm; Wed, 26 Jul 2023 19:28:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5C2E660ECA;
	Wed, 26 Jul 2023 19:28:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C2E660ECA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B5A6C0072;
	Wed, 26 Jul 2023 19:28:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFF2AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BFBD41E55
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BFBD41E55
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=2MmS470d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJuAhb_RMI6e
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:02 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BC0A41E52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4BC0A41E52
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DA74D61C77;
 Wed, 26 Jul 2023 19:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E606EC433C8;
 Wed, 26 Jul 2023 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1690399678;
 bh=F7Dod8/nvUA0tq0PCrFVeNauL6pXHKi/K+D/3mDf+Kk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2MmS470dbMJnDxmAM2gHkqoof8mpjP05HKaqd+FAk8g/e9KuqxYDrFRP3VDijSLrP
 CMi/B3ijrjBqhbbofNfnruBkFepKbiuCbXBQZk2fF64Cxt4a1Hex3vqobOSoAALNqv
 18F0FHQDiBentOHsEEaJB+3UAskjBKpXQfhyhAlk=
Date: Wed, 26 Jul 2023 21:27:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH 2/2] vdpa: Enable strict validation for netlinks ops
Message-ID: <2023072650-flight-reshuffle-65a0@gregkh>
References: <20230726185104.12479-1-dtatulea@nvidia.com>
 <20230726185104.12479-3-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230726185104.12479-3-dtatulea@nvidia.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Lin Ma <linma@zju.edu.cn>
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

On Wed, Jul 26, 2023 at 09:49:44PM +0300, Dragos Tatulea wrote:
> The previous patch added the missing nla policies that were required for
> validation to work.
> 
> Now strict validation on netlink ops can be enabled. This patch does it.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/vdpa.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index f2f654fd84e5..a7612e0783b3 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1257,37 +1257,31 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>  static const struct genl_ops vdpa_nl_ops[] = {
>  	{
>  		.cmd = VDPA_CMD_MGMTDEV_GET,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_mgmtdev_get_doit,
>  		.dumpit = vdpa_nl_cmd_mgmtdev_get_dumpit,
>  	},
>  	{
>  		.cmd = VDPA_CMD_DEV_NEW,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_dev_add_set_doit,
>  		.flags = GENL_ADMIN_PERM,
>  	},
>  	{
>  		.cmd = VDPA_CMD_DEV_DEL,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_dev_del_set_doit,
>  		.flags = GENL_ADMIN_PERM,
>  	},
>  	{
>  		.cmd = VDPA_CMD_DEV_GET,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_dev_get_doit,
>  		.dumpit = vdpa_nl_cmd_dev_get_dumpit,
>  	},
>  	{
>  		.cmd = VDPA_CMD_DEV_CONFIG_GET,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_dev_config_get_doit,
>  		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>  	},
>  	{
>  		.cmd = VDPA_CMD_DEV_VSTATS_GET,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>  		.flags = GENL_ADMIN_PERM,
>  	},
> -- 
> 2.41.0
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
