Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C72421D
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5w/c0SR"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C923D60F9B
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 13:10:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C923D60F9B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b5w/c0SR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39-WRXOiyBuX
	for <virtualization@lists.linux-foundation.org>;
	Mon,  4 Dec 2023 13:10:44 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CE3FC60739
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 13:10:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE3FC60739
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id EEA1CB80D18;
	Mon,  4 Dec 2023 13:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C485BC433C8;
	Mon,  4 Dec 2023 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701695441;
	bh=mH6UFinR2jS1kpwOBQ++DpQNO6L7gqAEnFvCgBuoLGY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b5w/c0SRgBX7jvWNhtbcglu86+s3q51ywjLP3jI4BbPueqnGvCE4mRLSYh6CwMJep
	 BQ5wOt7tbnK0reMAMwxSJ5mYyrqf+bKyB1BO1Vo73kYNZw5DRm8gGYaQmihn/r7sjV
	 QUQUN1nl+cK0kz6oI4jh9CaKFBla9wc/xnlBYah61rwfHR40DEbTS7VhCYYgQtRXHA
	 X9+y24Pxug1KsnjC54SQ76+l/aScZcROHdhQxFJWg53/u3ppa0I0k3k8Rp067G9lz4
	 iqmdJ0zJyHBgZ0pAzXMoAVq/e4qAsqhes2p+voBMI5trJm7ePTYCFpyAUWZDcAfrJz
	 Abc3YWhRCACxg==
From: Leon Romanovsky <leon@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>,
 virtualization@lists.linux-foundation.org,
 Dragos Tatulea <dtatulea@nvidia.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <galp@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231201104857.665737-1-dtatulea@nvidia.com>
References: <20231201104857.665737-1-dtatulea@nvidia.com>
Subject:
 Re: (subset) [PATCH vhost 0/7] vdpa/mlx5: Add support for resumable vqs
Message-Id: <170169543706.44375.3181832396401755311.b4-ty@kernel.org>
Date: Mon, 04 Dec 2023 15:10:37 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Fri, 01 Dec 2023 12:48:50 +0200, Dragos Tatulea wrote:
> Add support for resumable vqs in the driver. This is a firmware feature
> that can be used for the following benefits:
> - Full device .suspend/.resume.
> - .set_map doesn't need to destroy and create new vqs anymore just to
>   update the map. When resumable vqs are supported it is enough to
>   suspend the vqs, set the new maps, and then resume the vqs.
> 
> [...]

Applied, thanks!

[1/7] vdpa/mlx5: Expose resumable vq capability
      https://git.kernel.org/rdma/rdma/c/b24910e1be0e76

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
