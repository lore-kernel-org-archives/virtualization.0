Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2032B130
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791423427; cv=none; b=JBXzCWgWtECT3IPa9Z6JVjhrhXVnbFIfnAqQqmYawXOuGx/vIw4Un6kZVAiYHAMMoCH2NOVIrpNaNT5GXTTO82BeP05sHeg4ew3j/tSAJejcGJONA4COKHGs+wlI5HZ9v9ZpulrXfASeDMxjSmGh9DgePUHObP4pKc0PEnEKP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791423427; c=relaxed/simple;
	bh=MwicRoOYV1zDQfwoWO+5FEWl54/aiijI+WJoGLBOTIg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=c9ygE3EiRhO+MxO3datwitb65uA0G7tSsQU1siAQt4qFQslgUA/LD8AQgnO0Cyvk/BCt95Lr4jsNMKmMGOti8Raq5Gw5cybDdvi/9tzdVwFWfUwkrFYb/mpn9aHKySira4ZQ1sSYL6X8lSL02KvRgmKHvuDyxKkIWWdRyNSQH90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rvs/2ugk; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rvs/2ugk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791423416; h=Message-ID:Subject:Date:From:To;
	bh=MwicRoOYV1zDQfwoWO+5FEWl54/aiijI+WJoGLBOTIg=;
	b=Rvs/2ugkNOZXOBA/ZipiX/DCQFbz20MeKhsRrM7JYYZL82a3YmbmcFzm2NBwpcHX922QwIg16DppVZ0sJA0Pv6TEXKG7WziVhHaq6pppBjExlpfdtDi/7qnbM5AfC92Vk1/YcnNcP3LxZbmle5pvM22REJ+drYfRv6w0bOE1CsE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XCIFUV3_1791423415;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0XCIFUV3_1791423415 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 09:36:55 +0800
Message-ID: <1791423335.8486545-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC] virtio-net: AF_XDP zero-copy TX checksum offload
Date: Thu, 8 Oct 2026 09:35:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Azadeh Aftahi <aftahi334@gmail.com>
Cc: magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com,
 sdf@fomichev.me,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 mst@redhat.com,
 jasowangio@gmail.com,
 eperezma@redhat.com
References: <9DB6FE89-98AB-47CF-9B57-5F47FBB6DAE8@gmail.com>
In-Reply-To: <9DB6FE89-98AB-47CF-9B57-5F47FBB6DAE8@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 5 Oct 2026 17:28:35 -0500, Azadeh Aftahi <aftahi334@gmail.com> wrote:
> Hi all,
>
> I'm planning to work on single-buffer AF_XDP zero-copy TX checksum offload for virtio-net.
>
> Current net-next's virtnet_xsk_xmit_one() does not consume XSK TX checksum metadata and uses the shared zeroed virtio header.
>
> I found Xuan's 2021 proposal anticipating separate headers for checksum support, and the merged 2024 zero-copy TX series, but I couldn't find a checksum-specific follow-up implementation.
>
> The proposed scope is to map the existing XSK checksum metadata API to VIRTIO_NET_F_CSUM, using a DMA-safe per-packet virtio header whose lifetime extends until TX completion, with corresponding completion, reset, and unbind cleanup.
>
> I would keep the initial scope limited to single-buffer TX: no multi-buffer RX, timestamps, launch time, or GSO.
>
> I'd also add checksum and header-lifetime coverage using the existing XSK selftest framework with QEMU/TAP.
>
> Is anyone already working on this? If not, does this scope and per-packet-header approach sound reasonable for a follow-up patch?

It seems no one has taken this work forward yet; I would welcome it if you were
to do so.

Thanks.


>
> Thanks,
> Azadeh
