Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3242225DA
	for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729823775; cv=none; b=EmFXrvX0izDZoB8zSC4iDKAREhIDik6hazJ0xf2H/84jI9xxabEwF7YECcfXm4CGhQbGoZ05Kc6Z4YgEl2PyUpW75trn/pDfKkt46/ToqLZQMraTv7M7c2A4THWtEkWEy2+9LZjIN216bc9ZYPDECVg8NORUYOJW2ohsXAZ5Xcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729823775; c=relaxed/simple;
	bh=8tXTJq0tG/6yIVDyuTeuiExlPBwjmzg1klBdfzn6QvA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=KuT6J2UWOdgDVUT5WXfkijqn3YFGTpjHtA99w6J2PjqxsoqWOnZcNrZkg7sf4hOZ9+gvZy9BAwP8Fo4dSCaLjf1yjJTN1iduqHC2reYs+NdS1B6bu0SW5Dvjbs17oYsaB2UvKPMtG6/1ec4/rL31Wair+CixHfZQL3Ry4LAnfps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wVdCCA57; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wVdCCA57"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729823769; h=Message-ID:Subject:Date:From:To;
	bh=8tXTJq0tG/6yIVDyuTeuiExlPBwjmzg1klBdfzn6QvA=;
	b=wVdCCA577xlJN5RlUSP+GXAsRH7SAPF7ojQue5DvcRQbUS8Yk0kAw2oqWhU6963Rldsw6SqHXIQe2rQkB8Hm58L9+VZornlmIovyXbeJ6+aWkodupERvnrFEfJu1XrbDR1TFYY9OV1z5f3AGzt/WEq8QfCR9pwbb3hnHtsW14Po=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WHqq4m9_1729823767 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 10:36:08 +0800
Message-ID: <1729823753.4548287-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/5] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Fri, 25 Oct 2024 10:35:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux.dev,
 "Si-Wei Liu" <si-wei.liu@oracle.com>,
 netdev@vger.kernel.org
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
 <6aaee824-a5df-42a4-b35e-e89756471084@redhat.com>
In-Reply-To: <6aaee824-a5df-42a4-b35e-e89756471084@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 17 Oct 2024 15:42:59 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
>
>
> On 10/14/24 05:12, Xuan Zhuo wrote:
> > When the frag just got a page, then may lead to regression on VM.
> > Specially if the sysctl net.core.high_order_alloc_disable value is 1,
> > then the frag always get a page when do refill.
> >
> > Which could see reliable crashes or scp failure (scp a file 100M in size
> > to VM):
> >
> > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > of a new frag. When the frag size is larger than PAGE_SIZE,
> > everything is fine. However, if the frag is only one page and the
> > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > overflow may occur.
> >
> > Here, when the frag size is not enough, we reduce the buffer len to fix
> > this problem.
> >
> > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> This looks like a fix that should target the net tree, but the following
> patches looks like net-next material. Any special reason to bundle them
> together?

Sorry, I forgot to add net-next as a target tree.

This may look like a fix. But the feature was disabled in the last Linux
version. So the bug cannot be triggered, so we don't need to push to the net
tree.

Thanks.

>
> Also, please explicitly include the the target tree in the subj on next
> submissions, thanks!
>
> Paolo
>
>
