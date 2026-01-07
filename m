Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8832AAAC
	for <virtualization@lists.linux-foundation.org>; Wed,  7 Jan 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788667; cv=none; b=gk/qJDRDd1GKLY6VwDMPaq/XFd9o42+BIafQciSuRfVJ9yoiBT8fJmQVDcGgMRlpKrNK932HP/5NfVQeo3AFmaRpOgrn6hPr4kY37snINH3/PBkh5tZlLGRGGD8gvWrWlfbamNHmfV9cBB7j3xygs67ndttfXSL/+VnXWkJyFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788667; c=relaxed/simple;
	bh=IsygWTMZdTG0Nq6crJvMpuu1naoy0zMIB4K4PhC/N+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWch7AUZ0bOY4/UElD194cgCGw2WjLwlPs5VxaxSV4KdovQzDwgsR8mVevCMCkTeOX01AUARTryNOt5BbhMct11LBEyZsaU2mp/MgaFTk7Wi3+2srP2plS/76q9snECGjMaggwVlzQ1eIDO1+Zaksva04pkkN4Q7lRFWexDoEyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQPBqY3d; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQPBqY3d"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE21340327
	for <virtualization@lists.linux-foundation.org>; Wed,  7 Jan 2026 12:24:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0hE8xiCWjQDK for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jan 2026 12:24:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1DA1E4022E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DA1E4022E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IQPBqY3d
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1DA1E4022E
	for <virtualization@lists.linux-foundation.org>; Wed,  7 Jan 2026 12:24:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 44FBF406D7;
	Wed,  7 Jan 2026 12:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7A2C4CEF7;
	Wed,  7 Jan 2026 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767788663;
	bh=IsygWTMZdTG0Nq6crJvMpuu1naoy0zMIB4K4PhC/N+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQPBqY3d1wDsYM2p0cWdND2XmtPcU6sME/U61WJINvoK0+GWxk+WGZrcW5N1NQM1N
	 73Sb6VNbTLeyVeVtSvcGuq01XdzERHaNnnCSIpllqmR85o83ujea5Gm5hz2MczeBy/
	 JHWs91IWhHNoW7DLlmSc8UndW/pTYDFOLFNQ7GY00vA2nrOibnCos/9s1USnf0dGuD
	 qEvBv22WKdjZnB8dCGLvYpmSR5Unp3anb0PsaOw6LL7fGw1RXS2LJG9DTpV/RznDhd
	 0/H8+MMiRmpEnx0rGGoIo6HoQhpSHd0SRTD8/G338qS7bZt6Mel6qlFXr6gHiG7O2V
	 h2Fospv+Dq25g==
Date: Wed, 7 Jan 2026 12:24:18 +0000
From: Simon Horman <horms@kernel.org>
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, dtatulea@nvidia.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/3] vdpa/mlx5: reuse common function for MAC address
 updates
Message-ID: <20260107122418.GB196631@kernel.org>
References: <20251229071614.779621-1-lulu@redhat.com>
 <20251229071614.779621-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229071614.779621-2-lulu@redhat.com>

On Mon, Dec 29, 2025 at 03:16:13PM +0800, Cindy Lu wrote:
> Factor out MAC address update logic and reuse it from handle_ctrl_mac().
> 
> This ensures that old MAC entries are removed from the MPFS table
> before adding a new one and that the forwarding rules are updated
> accordingly. If updating the flow table fails, the original MAC and
> rules are restored as much as possible to keep the software and
> hardware state consistent.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 95 +++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6e42bae7c9a1..c87e6395b060 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2125,62 +2125,48 @@ static void teardown_steering(struct mlx5_vdpa_net *ndev)
>  	mlx5_destroy_flow_table(ndev->rxft);
>  }
>  
> -static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
> +static int mlx5_vdpa_change_new_mac(struct mlx5_vdpa_net *ndev,
> +				    struct mlx5_core_dev *pfmdev,
> +				    const u8 *new_mac)
>  {
> -	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> -	struct mlx5_control_vq *cvq = &mvdev->cvq;
> -	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
> -	struct mlx5_core_dev *pfmdev;
> -	size_t read;
> -	u8 mac[ETH_ALEN], mac_back[ETH_ALEN];
> -
> -	pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
> -	switch (cmd) {
> -	case VIRTIO_NET_CTRL_MAC_ADDR_SET:
> -		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)mac, ETH_ALEN);
> -		if (read != ETH_ALEN)
> -			break;
> -
> -		if (!memcmp(ndev->config.mac, mac, 6)) {
> -			status = VIRTIO_NET_OK;
> -			break;
> -		}
> +	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
> +	u8 old_mac[ETH_ALEN];
>  
> -		if (is_zero_ether_addr(mac))
> -			break;
> +	if (is_zero_ether_addr(new_mac))
> +		return -EINVAL;
>  
> -		if (!is_zero_ether_addr(ndev->config.mac)) {
> -			if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
> -				mlx5_vdpa_warn(mvdev, "failed to delete old MAC %pM from MPFS table\n",
> -					       ndev->config.mac);
> -				break;
> -			}
> +	if (!is_zero_ether_addr(ndev->config.mac)) {
> +		if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
> +			mlx5_vdpa_warn(mvdev, "failed to delete old MAC %pM from MPFS table\n",
> +				       ndev->config.mac);
> +			return -EIO;
>  		}
> +	}
>  
> -		if (mlx5_mpfs_add_mac(pfmdev, mac)) {
> -			mlx5_vdpa_warn(mvdev, "failed to insert new MAC %pM into MPFS table\n",
> -				       mac);
> -			break;
> -		}
> +	if (mlx5_mpfs_add_mac(pfmdev, (u8 *)new_mac)) {
> +		mlx5_vdpa_warn(mvdev, "failed to insert new MAC %pM into MPFS table\n",
> +			       new_mac);
> +		return -EIO;
> +	}
>  
>  		/* backup the original mac address so that if failed to add the forward rules
>  		 * we could restore it
>  		 */
> -		memcpy(mac_back, ndev->config.mac, ETH_ALEN);
> +		memcpy(old_mac, ndev->config.mac, ETH_ALEN);
>  
> -		memcpy(ndev->config.mac, mac, ETH_ALEN);
> +		memcpy(ndev->config.mac, new_mac, ETH_ALEN);

...

Hi Cindy,

I realise that this makes the diffstat significantly more verbose.
And hides material changes. So perhaps there is a nicer way to do this.

But with the current arrangement of this patch, I think that
the indentation from just above, until the end of this function
needs to be updated.

I.e. the following incremental patch on top of this one.

This was flagged by Smatch.

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index c87e6395b060..c796f502b604 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2149,48 +2149,48 @@ static int mlx5_vdpa_change_new_mac(struct mlx5_vdpa_net *ndev,
 		return -EIO;
 	}
 
-		/* backup the original mac address so that if failed to add the forward rules
-		 * we could restore it
-		 */
-		memcpy(old_mac, ndev->config.mac, ETH_ALEN);
+	/* backup the original mac address so that if failed to add the forward rules
+	 * we could restore it
+	 */
+	memcpy(old_mac, ndev->config.mac, ETH_ALEN);
 
-		memcpy(ndev->config.mac, new_mac, ETH_ALEN);
+	memcpy(ndev->config.mac, new_mac, ETH_ALEN);
 
-		/* Need recreate the flow table entry, so that the packet could forward back
-		 */
-		mac_vlan_del(ndev, old_mac, 0, false);
+	/* Need recreate the flow table entry, so that the packet could forward back
+	 */
+	mac_vlan_del(ndev, old_mac, 0, false);
 
-		if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
-			mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
+	if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
+		mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
 
-			/* Although it hardly run here, we still need double check */
-			if (is_zero_ether_addr(old_mac)) {
-				mlx5_vdpa_warn(mvdev, "restore mac failed: Original MAC is zero\n");
-				return -EIO;
-			}
+		/* Although it hardly run here, we still need double check */
+		if (is_zero_ether_addr(old_mac)) {
+			mlx5_vdpa_warn(mvdev, "restore mac failed: Original MAC is zero\n");
+			return -EIO;
+		}
 
-			/* Try to restore original mac address to MFPS table, and try to restore
-			 * the forward rule entry.
-			 */
-			if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
-				mlx5_vdpa_warn(mvdev, "restore mac failed: delete MAC %pM from MPFS table failed\n",
-					       ndev->config.mac);
-			}
+		/* Try to restore original mac address to MFPS table, and try to restore
+		 * the forward rule entry.
+		 */
+		if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
+			mlx5_vdpa_warn(mvdev, "restore mac failed: delete MAC %pM from MPFS table failed\n",
+				       ndev->config.mac);
+		}
 
-			if (mlx5_mpfs_add_mac(pfmdev, old_mac)) {
-				mlx5_vdpa_warn(mvdev, "restore mac failed: insert old MAC %pM into MPFS table failed\n",
-					       old_mac);
-			}
+		if (mlx5_mpfs_add_mac(pfmdev, old_mac)) {
+			mlx5_vdpa_warn(mvdev, "restore mac failed: insert old MAC %pM into MPFS table failed\n",
+				       old_mac);
+		}
 
-			memcpy(ndev->config.mac, old_mac, ETH_ALEN);
+		memcpy(ndev->config.mac, old_mac, ETH_ALEN);
 
-			if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
-				mlx5_vdpa_warn(mvdev, "restore forward rules failed: insert forward rules failed\n");
+		if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
+			mlx5_vdpa_warn(mvdev, "restore forward rules failed: insert forward rules failed\n");
 
-			return -EIO;
-		}
+		return -EIO;
+	}
 
-		return 0;
+	return 0;
 }
 
 static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
