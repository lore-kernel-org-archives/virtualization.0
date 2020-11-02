Return-Path: <SRS0=4MNw=EI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED9C388F2
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 17:03:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA99220786
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 17:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FAzSHDs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA99220786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9B4DA872F5;
	Mon,  2 Nov 2020 17:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BU6Su5dGecnw; Mon,  2 Nov 2020 17:03:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F2E24872E5;
	Mon,  2 Nov 2020 17:03:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8C3BC0889;
	Mon,  2 Nov 2020 17:03:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 574D5C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 17:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4413E86ACF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 17:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pd0YHGwTIAZj
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 17:03:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1724B8688F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=8R9siPqKWQkaZsoyJP4hgDCdyshjHYVTZKbppBnGdqc=; b=FAzSHDs6kcdBpZZIh++eooksKw
 JVNWWK0TevpgD757i9gABdsindQ0fmCtpQo5XottcABwgUduPrbJxKSB1jB8jBdMSgmrAjjmcZP/W
 pibknGDMZ0EB5qklmGUbijqLs1qdiJiBluQUIpkHCueBTWJXVZPAaG2pqDQlz/vgcKjViduh46tap
 HcqzHO54V61MlXc25/YkDJS1v51/kimxezVLx+AAj/LaK668hQm9LPzz4qfxsFBFzkyKhRWkZaglj
 61CTWeIiIpbolBzVuokLoPjGdtIj0+VMSqBI3QghKU07/98DkgoBJoy5J2jh/eWBQPribDUOpkgvi
 zCZVKCPw==;
Received: from [2601:1c0:6280:3f0::60d5]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZdEg-0002QW-QC; Mon, 02 Nov 2020 17:03:15 +0000
Subject: Re: linux-next: Tree for Nov 2 [drivers/vdpa/vdpa_sim/vdpa_sim.ko]
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201102162845.3eb6598e@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d3d50a94-cdc5-572b-e9ca-3ee5638d21ee@infradead.org>
Date: Mon, 2 Nov 2020 09:03:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102162845.3eb6598e@canb.auug.org.au>
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On 11/1/20 9:28 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20201030:
> 

on x86_64:

when CONFIG_NET is not enabled:

ERROR: modpost: "mac_pton" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!


Should VDPA_SIM, IFCVF, MLX5_VDPA_NET depend on NET or NETDEVICES?



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
