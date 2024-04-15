Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB1157469
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217186; cv=none; b=XTT1JMMabAq030+ZJZBgbpbMWMuIWRml7DA5dHLmOzLOT71flik32s2SU1CjnlfGcK/IqZMIlHw6wPEf0GD11exOR4xY68NUo8LGwvf5C33hkC4Cp0w/UhghhyZA1rdlvRZBABU+GvvoI3xuCJUfoDNKwz85XgCkmMZ3qPYJlTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217186; c=relaxed/simple;
	bh=Ou+FvOs1B0WuJzy4wjnTiHrS07o3mwtSQsNGZnNkSo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4uFbh5DJqUgusN4clcuvdFoDuJtGIlqpAJNs8szAbKfKddwq85wJl3R+h65PzIy5AEkxVo0sZMvIjW9BK0knlvYRKuzkJjfe2fSe4aUct8iVk6BkT4zwZX0IaaRaydy/cRk71xlDvFEH+fh9JnGrFlwU1KEIFMzvmitI8J/8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+JMXU1f; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+JMXU1f"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61ad5f2c231so15808837b3.2
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713217184; x=1713821984; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4Igzsw7nTVFssFguk/Rbj2YFohqP9KtmCQuZOOHSCU=;
        b=G+JMXU1fEh1N0hSPQzMEqvLy/Ls8t8scvXIZx1Pw0QC2g77DElgDhC60a0/e3iL9c5
         Ulq1fg07FOcz+Xx5bUfAk3Th1Z4SUJjjLJYC7x6Q8LUKQLRJwUP1gTR2Xewnglv21/Ln
         D4UHXIhZ8f3Y/SPBjNoDCtAVAwdik+XNlxkSEQpogPcS01QdOYMO3fTpkxOiFI8VDdyZ
         Vy9dfzexMl2yazchki34bvIrP9CycsFifwCTssHZ2cKFLKW/apGp7aE7S8QxCznlZ0OK
         RZaoypdoBuHeV3B97Zc1NfXfODtNwLsV2fo4UfIUr2ddoiIyv3SBFVcL0y12AtUQucEe
         b8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713217184; x=1713821984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Igzsw7nTVFssFguk/Rbj2YFohqP9KtmCQuZOOHSCU=;
        b=tJ0nKFvAN+bbhaIFzCc4wt+8kmWwU4lMf+VE+fdTmncg5rkb0hQ/YGjFwPhcs3O244
         ZxEzvrWRzr+0Q5cUUbQWN6oKcGxdE+C6cewmVbD/yXe0MOnlqrvN34/vhALI1bAjk6eH
         QKNQe8hRfxhlTv9nV8i14HhPnzTNjcEJMJGOTAwXnNH+xughhELsc/IPnx0GSYq4wX9l
         LOPAveYHaBS+TtNABh+EGPBO4mFUYxnxR29YuLBocOaVWn1o1Ycx/AjRssHnb6bdY5yG
         wVrh0rckzDkcS4Q+WsqKNU5rnt7V2P2vrzq21/AIshy7nf/GwdiXB8BjpkvN/be4xjhQ
         YLFg==
X-Forwarded-Encrypted: i=1; AJvYcCUnsqLfJuSTCcu3To9HTjVudM/UM5UI5UKjaX39aAJDep6bk3MPb395bNHYtnjvhMLHFLvPKcaZptnY+Z5MhabXsBwLRaOmqKWiH98y2uI=
X-Gm-Message-State: AOJu0YzGNM9FsHV3TBPLU90PGgtKfmFVT4J5W981OrEqa6OKvN5kbFsg
	OkJ1T1Va7CfdphY6yO+Fqd8JmMe7ZvqEapvb1zrsSonwsU8LS7Y2
X-Google-Smtp-Source: AGHT+IEuBFvQdGq8XC+xGsXmOG6swS+A7y4Wz4C+E83HgqZ7NES/HexAlN3tWxT3W9BaCURm0cI74g==
X-Received: by 2002:a0d:f584:0:b0:618:8a27:f26 with SMTP id e126-20020a0df584000000b006188a270f26mr8434646ywf.48.1713217184009;
        Mon, 15 Apr 2024 14:39:44 -0700 (PDT)
Received: from localhost ([2001:18c0:22:6700:503f:95a9:a73f:4ee8])
        by smtp.gmail.com with ESMTPSA id l25-20020a05620a211900b0078d67d40c49sm6825704qkl.70.2024.04.15.14.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:39:43 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:39:42 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v2 5/6] selftests: forwarding: add
 wait_for_dev() helper
Message-ID: <Zh2enn9ArVKDrdIy@f4>
References: <20240415162530.3594670-1-jiri@resnulli.us>
 <20240415162530.3594670-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415162530.3594670-6-jiri@resnulli.us>

On 2024-04-15 18:25 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The existing setup_wait*() helper family check the status of the
> interface to be up. Introduce wait_for_dev() to wait for the netdevice
> to appear, for example after test script does manual device bind.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - reworked wait_for_dev() helper to use slowwait() helper
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 254698c6ba56..e85b361dc85d 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -746,6 +746,19 @@ setup_wait()
>  	sleep $WAIT_TIME
>  }
>  
> +wait_for_dev()
> +{
> +        local dev=$1; shift
> +        local timeout=${1:-$WAIT_TIMEOUT}; shift
> +
> +        slowwait $timeout ip link show dev $dev up &> /dev/null

Sorry, I just noticed that this includes the "up" flag. I was confused
for a while until I realized that `ip` returns success even if the
interface is not up:

# ip link set dev eth1 down
# ip link show dev eth1 up
# echo $?
0

So wait_for_dev() really does just wait for the device to appear, not
for it to be up. If you agree, please remove the 'up' keyword to avoid
confusion.
