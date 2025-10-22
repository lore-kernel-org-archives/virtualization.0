Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E3846F
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097386; cv=none; b=H4GU5ADjmJyIpdMfAPZcV9ByF6y69ScA6dqnFa+8ylXhMTubXSSRmhHHO/d+8g8JWINp0Wc2TNGTTIt1yf+6Zg7ApfMd8TpeQKHKAepZ4BFf2AThk3y7+9fsFeMJyJhK1RMA++ARQuz9Sui50o/9B/GD5g+JHNhjCnaoMCygWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097386; c=relaxed/simple;
	bh=Auhxjg5pNRBAFMysZdzEa2AyUIKO6XZwWubyCzixAlc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=YfhPHwiKlTUUlyhkklg5ZMwds/X6DQpFyK84kJ6CDi1OytJRRqd1neo7w03MH195aneT7x8xB0oG7GAlWBRtuXUicGmFAsxlY7p12km7G2boJRaBzLWCyBUbDA2r2qsRebdW9KPDpvFnJ+2ZUR8eAyhM+JVFTemCjtPrL4Gt7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uX27FIxI; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uX27FIxI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761097375; h=Message-ID:Subject:Date:From:To;
	bh=Auhxjg5pNRBAFMysZdzEa2AyUIKO6XZwWubyCzixAlc=;
	b=uX27FIxILXOaIEZK6QYOjtugdYZECsljRicVt9bzVgtsrf7Jeb4ONu2n2PMSGHprBgHpCpnyc7OzispVMkR4c1Y0301LaebhcvyYy03G4hNJ9M0oNZMja4MYlCtIm+dyz0bvJAZQaGWMz2r2wXMQb4sqZrrozYtIcb2fuUJE+EI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqkgZ5F_1761097374 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 09:42:55 +0800
Message-ID: <1761097355.5092716-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: fix header access in big_packets mode
Date: Wed, 22 Oct 2025 09:42:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wen Xin <w_xin@apple.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20251016223305.51435-1-w_xin@apple.com>
 <1760662656.1338146-1-xuanzhuo@linux.alibaba.com>
 <20251017163856.4c554cc8@kernel.org>
In-Reply-To: <20251017163856.4c554cc8@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 17 Oct 2025 16:38:56 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri, 17 Oct 2025 08:57:36 +0800 Xuan Zhuo wrote:
> > http://lore.kernel.org/all/20251013020629.73902-1-xuanzhuo@linux.alibaba.com
> >
> > do the same thing.
>
> Could you repost that? looks like there were some questions,
> but nobody sent review tags even tho they were answered..


YES. In my todo list.


