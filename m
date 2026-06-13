Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0B70830;
	Sat, 13 Jun 2026 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781387081; cv=none; b=uuA2SE9KY3OYvisgZtGLg2424VQwP9hYLQXC//D5RGwa/1vcloFlvZzzhJ8MlJRxOwb6E5Jmpe+l4bP9oXCJgJhsoySGdhLTqKIl60MQJ9FtYZXvUdY8i+2ZZnZep842y4q6CL7a3x0CuDY/vCgzW7R3WTPVzyNEUk7Q0KrMeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781387081; c=relaxed/simple;
	bh=qm0c/7OqOrnZF819uwAs5sHM0Jrpdt9zlsXwPCKTmpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=la2q0Cnei0vEnsppsspSH6Tu47YQBV1Fb1SkbF7HDDPGDNrZ8FiqJRo/q+CefjfiASGn6tZQDAnoF7V32wlsOFgPji7JoVHmPviV1vqwzdGsmkyHWnXfNUDMhyxuHvscSkYgU9H5UJG9nSdjq/3Hig9BGOc1gBlYTHyDnjz/zGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwel8ahi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwel8ahi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7DB1F000E9;
	Sat, 13 Jun 2026 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781387080;
	bh=VTV3hvkfnFtSxcZwKkRw+CPpLJ0bwEj286O8Akrc30o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hwel8ahiwoji/cs9e+YwduWGKtvE43RoGsDZ+zTq7dPRUrHm9Neb0FkZ+ldR2iI4r
	 bRygPatiiWFRB0n/d9etgCmr6aeYh475zpTMC3gziAzuDoPE3b3VIoGiWW5XX2iALa
	 hQF8BPmtgOrjuuHhAeL2zU5m6ZW3ZtGCGfr5LbOijd0ig//fHV+jCwvF8brBap9iq+
	 uL2+wiM3tWAzZVWfTeNbkhl8xGMwSmUuy/iiiHrmDdpl1lBglhzVAgCI3w3GeFSUBs
	 nNYY7aSBFuuXMaWk25Llhli49eylbAetSE1L1GMYkXdxdcg+rchxgN24eHX56eCyb+
	 yGVxEmLXj8g6A==
Date: Sat, 13 Jun 2026 14:44:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
Message-ID: <20260613144438.767f8069@kernel.org>
In-Reply-To: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
References: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 16:16:48 +0800 Menglong Dong wrote:
> +	/* If both rq->vq and fill ring are empty, and then the user submit
> +	 * all the chunks to the fill ring and check the wake up flag
> +	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
> +	 * we will lose the chance to wake up the rx napi, so we have to
> +	 * set the need_wakeup flag here.
> +	 */

TBH all the comments you're adding are harder to understand than the
code itself ;( Please try to phrase them better or just remove them.
