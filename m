Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48338C423
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110902; cv=none; b=opwOxya9d5+YLxGNcHYBMq8cqQ0OfLsc7XNMnNqj0r0HhGO2Cx4eXZBEqenEjCjziZlTK73p88UvWcBaSbde0twtT/Ls0qarM/fVdvBHgXZLxuOZx7neMl3Bi9FuzzVWOv0tVZA54rgVNnE6fTxKdJTVzZQfYFtobffoYvEMU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110902; c=relaxed/simple;
	bh=UZtF34Vd2lYkDQz9Tj53ng6mbr0aZ5lncjPWUtOhKhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+J6JuvbPLTqok6FfmEnoMt9mkcHjyxBs4FNYR64R6GeeKnrPOS/0O21GxQaBjDXTWmTZ3taSbCOgtfSgn53duBjAvx7oagcvKvKXrY6y3NHT73Oss2wkl7ddzubbFZuiKSfPklifj+Q13t8XfjTtAkBEbjDd6O21yhMnUhrf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=GsmngRAM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jZbhrWQb; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="GsmngRAM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jZbhrWQb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3AA1BEC0434;
	Mon, 13 Apr 2026 16:08:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 16:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776110898;
	 x=1776197298; bh=j9hwhFGrKakk1ZNtRUR/kYRE8yWC3+RviEbKeWqEAJw=; b=
	GsmngRAMsOVggUG3jTpsViF5qPFayFXZarYjLOjOjbWd/pNSaUD6r1Q3aZrBJiKG
	80DmVnJXGC1Hs2vehCqpqoL+YiXYxKvJhyIdGS7yTeTb3sD72+VKmvWxTmw/h0We
	FILa1Rvv0s8iNYTtmkxSANdVJJssWOwiVm5tWk78jsw88jJcbb93dxQqK6VjbwGC
	a60HvJYivqsgLnqJgfsoFd29a65a/zhTvC9V3ixqSIgkleY3N5Yniv5p/PzSjq4D
	kbuHIQXoCOVqnpknTCQ6g5MMZVtGVReUaVFtlVt4Ve/qk/hExn/oj9Zv2Pk988Td
	FybUnpcP2V1gjId6Fc1npw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776110898; x=
	1776197298; bh=j9hwhFGrKakk1ZNtRUR/kYRE8yWC3+RviEbKeWqEAJw=; b=j
	ZbhrWQbKW3ACdEmXTLIxXQ9/Lm5nNEQlgrYx8XxKPhqfP873QRE9rwzOhh/mjZo3
	xrqUN1Ghh3knJ4WBZEPrQDgCwk439KS4yoWBwAJ7gV2Etdha+w8qxoI1NUZp1JVx
	pvz459ZxAUaLJ8c6J50rC4u4J/I0ffavaP2S2huavTefDTFqJwf5a56W7D9sxKnu
	Joe4hwb9h1I87g41Vp95D0ULyJ+rueNJzzwk2eMwdofeRg9+e/Um2t/gg4jMU1z1
	oemnnItkuL11rrnMsPBfYeUGdVPpctqTr5C1o5WVda0EQHeLxVfuB/3GO6HCe4JR
	Sp5VFFxQordo1xAlb8lDg==
X-ME-Sender: <xms:MU3daVp_2LPGOKvQKOHkYpVhiMdOTssV5yolN_P_ZAwIQXgKrne3Eg>
    <xme:MU3daf0lA0t5N1tkCGUVlbjMt5qVrRuT_U833x7MAYD6xZqd1rtlH2sy5EC6XQ4DF
    UZ67k51TDzfXjD3EX3tqhUTwrUYOEze1cV3ibaERI5PdC3ff1tR>
X-ME-Received: <xmr:MU3dadw8L7nVKYTaMV-faiaIT7f6H9i0UBWPPquWrt90jL6SUDyxD_h5Wko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhuohhjihhnhhhuihdrlhhirghmsegshihtvggurg
    hntggvrdgtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohep
    hihishhhrghihhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhkohhlohhthhhumh
    hthhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehkvghvihhnrdhtihgrnhesihhn
    thgvlhdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvhhirhhtuhgrlhhiiigrthhiohhnsehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MU3dabgXE49HNPo2dy5vp2JaPcYRO8idKBsPpHR3DmXXZqdux_zw6Q>
    <xmx:MU3daQqtXnfntuJrDXAcMKerdaIFgLZ2zNfdPdA2R5aV2IRWk1RFvw>
    <xmx:MU3daSh84wrFl8_IKyJpQdfVqMSTEyEJtCeYUfp-qOfzFZiEFmhplA>
    <xmx:MU3daSPoEvmf2UBDQU4Uuw_1jVw-QjQ00vyL-9hrue0gh9M7iY1P7A>
    <xmx:Mk3daZiUkt65xzOqKUBqUTqkC5v-ldC05Oy0a0R_sA4hORyrfcpaXyag>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 16:08:16 -0400 (EDT)
Date: Mon, 13 Apr 2026 14:08:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Jinhui Guo" <guojinhui.liam@bytedance.com>, "Yishai Hadas"
 <yishaih@nvidia.com>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Shameer Kolothum"
 <skolothumtho@nvidia.com>, "Kevin Tian" <kevin.tian@intel.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, alex@shazbot.org
Subject: Re: [RESEND PATCH] vfio/virtio: Fix lock/unlock mismatch in
 virtiovf_read_device_context_chunk()
Message-ID: <20260413140815.3ada32eb@shazbot.org>
In-Reply-To: <20260413073603.30538-1-guojinhui.liam@bytedance.com>
References: <20260413073603.30538-1-guojinhui.liam@bytedance.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 15:36:03 +0800
"Jinhui Guo" <guojinhui.liam@bytedance.com> wrote:

> virtiovf_read_device_context_chunk() takes migf->list_lock with
> spin_lock() but releases it with spin_unlock_irq().  This mismatch
> can incorrectly enable interrupts if they were already disabled
> when the lock was acquired, leading to unbalanced IRQ state.
> 
> Fix by using spin_lock_irq() to match spin_unlock_irq().
> 
> Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live migration functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/vfio/pci/virtio/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
> index 35fa2d6ed611..9fc24788fc04 100644
> --- a/drivers/vfio/pci/virtio/migrate.c
> +++ b/drivers/vfio/pci/virtio/migrate.c
> @@ -621,7 +621,7 @@ virtiovf_read_device_context_chunk(struct virtiovf_migration_file *migf,
>  
>  	buf->start_pos = buf->migf->max_pos;
>  	migf->max_pos += buf->length;
> -	spin_lock(&migf->list_lock);
> +	spin_lock_irq(&migf->list_lock);
>  	list_add_tail(&buf->buf_elm, &migf->buf_list);
>  	spin_unlock_irq(&migf->list_lock);
>  	return 0;

Yes, that fixes the bug, but why are we using a spinlock-irq here in
the first place?  I think this just copied the mlx5 vfio-pci variant
driver, which does make use of their list_lock under hardirq context,
but no such use case exists in this virtio driver.

A more complete fix would be to to convert list_lock to a mutex.
Thanks,

Alex
