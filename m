Return-Path: <SRS0=6TmO=HR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6DDC433E0
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 14:32:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33A364E51
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 14:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33A364E51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE0E987108;
	Mon, 15 Feb 2021 14:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EuZhleg4tncn; Mon, 15 Feb 2021 14:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3376E86FAF;
	Mon, 15 Feb 2021 14:32:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE3FCC0893;
	Mon, 15 Feb 2021 14:32:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14E8DC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E21756F4A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XsWA8fGKWiAb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:32:24 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 1D0586F4AA; Mon, 15 Feb 2021 14:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 422EA600C9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:32:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3857464DF4;
 Mon, 15 Feb 2021 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1613399541;
 bh=wkAC5+Pz1fyPNEDU1s3uWND5jzs7Q96skLsoF5pmDvY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XZ9fhlHw2ebNfM71Rug5UflI2pWXxWLEJY+08rXCXjNAeDgQqhAyt0K9IhHTCDU7s
 wsbGwqlowVRZ2N+DHDdfYrNLW+ET8fMu30uonh/xQBSFZiWAlMXWna0lBS57v4b65P
 I8vKTQaoUvoFgPYxo2sIK6WMXh5MRP4y7rNpMDxk=
Date: Mon, 15 Feb 2021 15:32:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH for 5.10] vdpa_sim: fix param validation in
 vdpasim_get_config()
Message-ID: <YCqF891BLn5zsUwd@kroah.com>
References: <20210211162519.215418-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210211162519.215418-1-sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eli Cohen <elic@nvidia.com>
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

On Thu, Feb 11, 2021 at 05:25:19PM +0100, Stefano Garzarella wrote:
> Commit 65b709586e222fa6ffd4166ac7fdb5d5dad113ee upstream.

No, this really is not that commit, so please do not say it is.

> Before this patch, if 'offset + len' was equal to
> sizeof(struct virtio_net_config), the entire buffer wasn't filled,
> returning incorrect values to the caller.
> 
> Since 'vdpasim->config' type is 'struct virtio_net_config', we can
> safely copy its content under this condition.
> 
> Commit 65b709586e22 ("vdpa_sim: add get_config callback in
> vdpasim_dev_attr") unintentionally solved it upstream while
> refactoring vdpa_sim.c to support multiple devices. But we don't want
> to backport it to stable branches as it contains many changes.
> 
> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> Cc: <stable@vger.kernel.org> # 5.10.x
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 6a90fdb9cbfc..8ca178d7b02f 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -572,7 +572,7 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
>  {
>  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>  
> -	if (offset + len < sizeof(struct virtio_net_config))
> +	if (offset + len <= sizeof(struct virtio_net_config))
>  		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
>  }

I'll be glad to take a one-off patch, but why can't we take the real
upstream patch?  That is always the better long-term solution, right?

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
