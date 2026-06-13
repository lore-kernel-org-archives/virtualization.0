Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA73337BAB;
	Sat, 13 Jun 2026 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372464; cv=none; b=AjphqBCvRNnte6JdHbNe0UJDMqy8OC+yOeNJfDogDDU6Hmtd9NqyHeGQmcjOWBD6k1XnjB1lrJLpordNV3ej6i5+YKT6jzaEGKRhuWJavF6vQKYbyX/ipIWXVtXcyQwGvAvJ+lB9cabbQWLfjbrmZuap4wo1oB8zpuYeeoYt8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372464; c=relaxed/simple;
	bh=AboEpq74/WBc775JzVtIVO091l4o8Krsoy0WsixDZEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Axh+eNaXpx77c71bG/EP2w7lwDhQIyJui3farFU6urIc64zwirzvP01X5UYkjp3KbzTNCG/cNwsXn9wPnbekLOgla9Gl0dLjBjWs5jUQ0lxqypmbOos9cyrOE20enPA+LosRsPrH+ltbMblamdE1tIhfP/dUdnPgMh2ZIBtIiYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se05z4+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se05z4+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ABE1F000E9;
	Sat, 13 Jun 2026 17:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781372463;
	bh=Yq0axNxLwkvk6LIfPvofD2aHIWPRY9vZrE9NiO2JNmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Se05z4+NB77aojJ5HHctC2iLYwDnDYa3T/0E0sEIzPZALTGkP07OvIblJnrNo9V+v
	 ufmGRnMFc5jFe8Tva6pvCBbrGVUzhuPyQ6dS8T9yHPOjKF9AEfW0OvD0L68RbxM3V6
	 dFr2iLv6G9i9GVh+jGuU7+5MXH7qeyGiVZJmKZrcNe3OnBzcaJCGICliVIKXeO9OCG
	 4vIlkz69ZDvszzbwCjf7pt2s5iOAyfx8PX6UWXATvpBbHgJFRcgP5/XRmVyUxLLODw
	 vzdAFWpnZ0HG60St5K+7IKFw77OyT0ZsgrpyFluLLObz8KFOakOtkgjkBBLn4kspe8
	 UJPzIMcPcByzA==
Date: Sat, 13 Jun 2026 10:40:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Raf Dickson <rafdog35@gmail.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, pabeni@redhat.com, stefanha@redhat.com,
 bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com,
 leonardi@redhat.com, horms@kernel.org, edumazet@google.com
Subject: Re: [PATCH net-next v3 4/4] vsock: fold sk_acceptq_removed() into
 vsock_remove_pending()
Message-ID: <20260613104057.3b170fc8@kernel.org>
In-Reply-To: <aivjf4TZU4Q_s20y@sgarzare-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
	<20260612045216.105796-5-rafdog35@gmail.com>
	<aivjf4TZU4Q_s20y@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 12:48:14 +0200 Stefano Garzarella wrote:
> >@@ -773,7 +774,6 @@ static void vsock_pending_work(struct work_struct *work)
> > 	if (vsock_is_pending(sk)) {
> > 		vsock_remove_pending(listener, sk);
> >  
>      ^^
> There is an extra blank line that we can now remove here.
> 
> BTW, the code LGTM:

Since the merge window is upon us - also updated when applying.
