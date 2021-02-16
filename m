Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29B7C433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 06:35:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD8964DF0
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 06:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD8964DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F0B58675C;
	Tue, 16 Feb 2021 06:35:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Mc6nraKaA7W; Tue, 16 Feb 2021 06:35:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5064A86690;
	Tue, 16 Feb 2021 06:35:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23619C0893;
	Tue, 16 Feb 2021 06:35:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83613C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 06:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 77B7985618
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 06:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NK4zrDKAbAea
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 06:35:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 040048554A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 06:35:56 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9DB364DDA;
 Tue, 16 Feb 2021 06:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613457355;
 bh=JyrtpZs3nYiCe3lUIYAVThOqh4wJbPYr0RlJDjeDkjg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q9cM3sN/iw/E5UBd3Lweuiw84wvHuanw14mFpmpS3uEqH26cfZex5oqlNDHIjOzY5
 CJ4KgCLsiTEyBhsfZ+yVuHfEdg0og1hs+mMdi/9t+J+DQUlS9KE5rffSlsIWRg3HCM
 MwBHk5Dhqa0iRODR76SCh+McfkLEEgQZASSslTbODH6ec9Lwb9DKFNPLHFT6Wl7hMk
 U2VuN9kd536E78U+Mld2RIxtK2wFjTx/EzPE3BMVcmEcuNiH5eDX5UVJNeprXGe5YT
 tLj8rmYjRTJ3BMWCMCQSdlgIp+MZ3K1uaI/mRwPF4kME+6Am2TCyjhk+65oEbrzGoe
 GuXFYO9V0WT6A==
Date: Tue, 16 Feb 2021 08:35:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Extract correct pointer from driver data
Message-ID: <YCtnxyTHJl9TU87L@unreal>
References: <20210216055022.25248-1-elic@nvidia.com>
 <20210216055022.25248-2-elic@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210216055022.25248-2-elic@nvidia.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com
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

On Tue, Feb 16, 2021 at 07:50:22AM +0200, Eli Cohen wrote:
> struct mlx5_vdpa_net pointer was stored in drvdata. Extract it as well
> in mlx5v_remove().
>
> Fixes: 74c9729dd892 ("vdpa/mlx5: Connect mlx5_vdpa to auxiliary bus")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6b0a42183622..4103d3b64a2a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2036,9 +2036,9 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>
>  static void mlx5v_remove(struct auxiliary_device *adev)
>  {
> -	struct mlx5_vdpa_dev *mvdev = dev_get_drvdata(&adev->dev);
> +	struct mlx5_vdpa_net *ndev = dev_get_drvdata(&adev->dev);
>
> -	vdpa_unregister_device(&mvdev->vdev);
> +	vdpa_unregister_device(&ndev->mvdev.vdev);
>  }

IMHO, The more correct solution is to fix dev_set_drvdata() call,
because we are regustering/unregistering/allocating "struct mlx5_vdpa_dev".

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 88dde3455bfd..079b8fe669af 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1995,7 +1995,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	if (err)
 		goto err_reg;

-	dev_set_drvdata(&adev->dev, ndev);
+	dev_set_drvdata(&adev->dev, mvdev);
 	return 0;

 err_reg:

>
>  static const struct auxiliary_device_id mlx5v_id_table[] = {

> --
> 2.29.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
