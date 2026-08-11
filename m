Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156BB2459C5
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462812; cv=none; b=RGtSQ6alNglSu/juiBKBdxF2Iu+JhNMBcmroBBJpUWIbzwFQbpe63pCzyBRK79c5nNmLn/IXeJdseFzyJm4naNLT9kRgun35MA9GCr0X3M9yycgqZczmk6aZNpSOmVJiGJGuR6im4q4ScPA9abRQ0/T7r+ZiBQMNNo9EplT6E3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462812; c=relaxed/simple;
	bh=JPe8MOaG1G7WLNOmM+vlfy2BcME184+seWmbJMG7CZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trGNmfyKyTnA1cNSNuxSK/XNn86OiCGlJpk6xdVlYGb+PMnvMLXYZT0s1tRcoF/syC5Ls0EcWCpWOC/6/GRF2eQgZluGWpHmuo+SIBRJCgncavFCRTq/ri+U1GLbyq88aV3x6czb2fN09xlDT7MR+ZGSMuaKbeiRPXkGyDnjgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpEDs3It; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpEDs3It"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8369E1F000E9;
	Tue, 11 Aug 2026 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462810;
	bh=JPe8MOaG1G7WLNOmM+vlfy2BcME184+seWmbJMG7CZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bpEDs3It9eJUZe4vuzXxAWk6WYVr5x5yu17hYrVUyqEl5yh8h5cFFYvdSa01kkWoF
	 +gRcrjqvLu0USRmKVJ17GTJfnpA1qJUbGbcZsMRW8Zo64q5VipacfoPuIOYhyPd/VJ
	 GWzUzQwT/RBw7Cj+j0OcaR+ItUvt/Q1CPP15XKND4PNd8XHxD/FKsL3E3NyuiHoX2A
	 hdJEKIKUS0QYDQ4hhVlwa6ltZhAWBPX9E6YYAwhbV22yVbL0lmu4Z9415V9mwR8GUE
	 A7CRgHGpVSG1h+Hdw1QRs5pX6MLd/LVCHMJG7UubKwmjj21w9njxZmnbfu7T1snqg+
	 QGSkxcM7L/UuA==
Date: Tue, 11 Aug 2026 08:40:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Longjun Tang <lange_tang@163.com>
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, tanglongjun@kylinos.cn
Subject: Re: [PATCH] virtio_net: add rx-alloc-fail counter
Message-ID: <20260811084009.35273d2a@kernel.org>
In-Reply-To: <20260811091045.115238-1-lange_tang@163.com>
References: <20260811091045.115238-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 17:10:45 +0800 Longjun Tang wrote:
> Count buffer and skb allocation failures on the rx queue and
> report them via rx-alloc-fail in netdev qstats.

please repost and CC netdev@ (if you haven't already)
