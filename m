Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51684A21
	for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302367; cv=none; b=lVJClZfFBdZxDwmGtZkvNdkLhLYDVuISUzypLsHnlLxtgyN21iffGtXfg68E+Nm0OQy6KJME8qWQkGWM6Mh1dBYNfBcC9l2X1u85IVYPwIY1TQg7+ColOTzCaQ+fKhdM8LMHeFJOdeau6ALidm8+MIGrWfZ6cgN+UZZQhV3aS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302367; c=relaxed/simple;
	bh=sZOnK1aeLSOPpk9wS2utqsMObUtLnJUI/AIc757QsFY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=t7ixDy1UnQOXWbcep0iZ8rCbcKaer3xP3S1OxYHowr03uIq+ti+yIEqy297giYTvyh5JVwoLXOK+WQnhQJib/h2eMzJwsL9JaiRCla9eoPRiMd3Dp4LvKPfRw+yeDwuLOiZXF5cjuMfWMEFqKgHbjIzk8PET4qrn138qpNdadtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NAjveYIa; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NAjveYIa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722302357; h=Message-ID:Subject:Date:From:To;
	bh=01UZHdydYYAgRYChk9eT/vFNzPkghP7L50ewNEGelrk=;
	b=NAjveYIabSKsk3aHdhgWatvWzON+Y7c7MzWwwTqFsq1utGOi+QmpYbX/KWrwjSiHxXJm4oGN0N0zXpu732gujtDBezOENLlO8yx1wdzLh78Y1BXTOyJxmpF7hpxArIXRWK+pZEmT/B7CxnntO5Ah1jh4nukrQOFyzPS36pYKYfA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0WBdZO0r_1722302039;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WBdZO0r_1722302039)
          by smtp.aliyun-inc.com;
          Tue, 30 Jul 2024 09:13:59 +0800
Message-ID: <1722302031.9577713-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] tools/virtio:Fix the wrong format specifier
Date: Tue, 30 Jul 2024 09:13:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: eperezma@redhat.com,
 zhujun2@cmss.chinamobile.com,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 mst@redhat.com,
 jasowang@redhat.com
References: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 24 Jul 2024 00:41:08 -0700, Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:
> The unsigned int should use "%u" instead of "%d".
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>  tools/virtio/ringtest/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
> index 5a18b2301a63..e471d8e7cfaa 100644
> --- a/tools/virtio/ringtest/main.c
> +++ b/tools/virtio/ringtest/main.c
> @@ -276,7 +276,7 @@ static void help(void)
>  	fprintf(stderr, "Usage: <test> [--help]"
>  		" [--host-affinity H]"
>  		" [--guest-affinity G]"
> -		" [--ring-size R (default: %d)]"
> +		" [--ring-size R (default: %u)]"
>  		" [--run-cycles C (default: %d)]"
>  		" [--batch b]"
>  		" [--outstanding o]"
> --
> 2.17.1
>
>
>
