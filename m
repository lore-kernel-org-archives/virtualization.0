Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A30118E29
	for <virtualization@lists.linux.dev>; Mon,  4 Nov 2024 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730688333; cv=none; b=QuT2NxJSxHFzQ5vUyOgRwulasQlDdi0ho1UWB8YEF2YS48SYwlJtCxXqrPRdyP3NXdEdxEJ0PyMeE09AU6ewRn+hNnlkpBBm/jDbn9BSpkLXwxKXljIk8ntdyEEQSPs1NUMyhMBOOMvSg1+UPlV+r5rMNIN/beZLQw9xwoM0PBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730688333; c=relaxed/simple;
	bh=jsgdTX+H2BCb7+bHl6hFQLAaK6roe3D9XtFvpTGfs/w=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Z3ByxW41UAxA0x/6bp8vFj9fq9FL/7GiKUKvKCA20xDlAN/Afpn3uo0wqYb+Z0446MJKSAxCxI1sDekl4KIvFP17TBsiV8/2c7/VgPEtfExJVlCoVyGOv5KGc97EUx1skjfbzH15Lg+ngjE7IWUz2g/BjJkHkbHt2Tu9BCjM4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TTpnZdIE; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TTpnZdIE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730688328; h=Message-ID:Subject:Date:From:To;
	bh=VMJ0qNC7D3RhewOuf4cdyfmebiUIbRwkpgu9S0MsSDk=;
	b=TTpnZdIEhQmNJfmGQHF2L+0E28itDFF1ZcLBNaADSfzCsoSUBaQYMGD2D6zqyA3w7i7+eGZ5NKPpeLJoS6JaJbDpsTesZLZJM+qoICuOTFClKXpPg3wNzHLZK0l5cOVCCcyAiPFhapaRE2fLEfMsmrBCWrLDCqs7lMwr7Qxx0QE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIZlEgZ_1730688325 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 10:45:25 +0800
Message-ID: <1730688315.6177652-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [resend PATCH 1/2] dim: make dim_calc_stats() inputs const pointers
Date: Mon, 4 Nov 2024 10:45:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 intel-wired-lan@lists.osuosl.org,
 linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org,
 oss-drivers@corigine.com,
 virtualization@lists.linux.dev,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Arthur Kiyanovski <akiyano@amazon.com>,
 Brett Creeley <brett.creeley@amd.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 David Arinzon <darinzon@amazon.com>,
 "David S. Miller" <davem@davemloft.net>,
 Doug Berger <opendmb@gmail.com>,
 Eric Dumazet <edumazet@google.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Felix Fietkau <nbd@nbd.name>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Geetha sowjanya <gakula@marvell.com>,
 hariprasad <hkelam@marvell.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jason Wang <jasowang@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Leon Romanovsky <leon@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Louis Peens <louis.peens@corigine.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Noam Dagan <ndagan@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Roy Pledge <Roy.Pledge@nxp.com>,
 Saeed Bishara <saeedb@amazon.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Shannon Nelson <shannon.nelson@amd.com>,
 Shay Agroskin <shayagr@amazon.com>,
 Simon Horman <horms@kernel.org>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20241031002326.3426181-1-csander@purestorage.com>
In-Reply-To: <20241031002326.3426181-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 30 Oct 2024 18:23:25 -0600, Caleb Sander Mateos <csander@purestorage.com> wrote:
> Make the start and end arguments to dim_calc_stats() const pointers
> to clarify that the function does not modify their values.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>


Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  include/linux/dim.h | 3 ++-
>  lib/dim/dim.c       | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/dim.h b/include/linux/dim.h
> index 1b581ff25a15..84579a50ae7f 100644
> --- a/include/linux/dim.h
> +++ b/include/linux/dim.h
> @@ -349,11 +349,12 @@ void dim_park_tired(struct dim *dim);
>   *
>   * Calculate the delta between two samples (in data rates).
>   * Takes into consideration counter wrap-around.
>   * Returned boolean indicates whether curr_stats are reliable.
>   */
> -bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
> +bool dim_calc_stats(const struct dim_sample *start,
> +		    const struct dim_sample *end,
>  		    struct dim_stats *curr_stats);
>
>  /**
>   *	dim_update_sample - set a sample's fields with given values
>   *	@event_ctr: number of events to set
> diff --git a/lib/dim/dim.c b/lib/dim/dim.c
> index 83b65ac74d73..97c3d084ebf0 100644
> --- a/lib/dim/dim.c
> +++ b/lib/dim/dim.c
> @@ -52,11 +52,12 @@ void dim_park_tired(struct dim *dim)
>  	dim->steps_left   = 0;
>  	dim->tune_state   = DIM_PARKING_TIRED;
>  }
>  EXPORT_SYMBOL(dim_park_tired);
>
> -bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
> +bool dim_calc_stats(const struct dim_sample *start,
> +		    const struct dim_sample *end,
>  		    struct dim_stats *curr_stats)
>  {
>  	/* u32 holds up to 71 minutes, should be enough */
>  	u32 delta_us = ktime_us_delta(end->time, start->time);
>  	u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
> --
> 2.45.2
>
