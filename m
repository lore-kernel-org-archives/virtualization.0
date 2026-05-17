Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407836F42B;
	Sun, 17 May 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779024794; cv=none; b=i/MarQ+bsR7kCXZ7svlOTrJeJwLKFnPhNuszcsb4RkT2kJ9mf+f4dS0q/Yzn7G1WeYgVBDJzFbG07YkhLA9p6WDDk3TuZmBNNALNZR6AFbttJLSB1n36oSC2P/zl2S44DZxxwEueUqgu4NhlxRPowudqjxtRsMUQIahGGgS5Mgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779024794; c=relaxed/simple;
	bh=Dd+qYRnIsFVdUKIkcEzgoiP5rrSOKiJtuqruDAo7iS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5ZpCf6LQoRufyszl0q6dWeoNiRsTxO3z/DqhawfphRwfdqo4pa2YDoWfgjj1n9pAQoA8YfnWQoIgOJVYJPzkvtTAWTeF6vgRsbdu015MNa1UYOHZag92l5MfZ8wXrvpl6QNq8hkgcITLQ/mhBfCxMYvcBMYEKy9I0h069Tid9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHvtmNMU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHvtmNMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6242C2BCB0;
	Sun, 17 May 2026 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779024794;
	bh=Dd+qYRnIsFVdUKIkcEzgoiP5rrSOKiJtuqruDAo7iS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHvtmNMUlzUvv95sbzZ2JkAenI5CFINoHFwJ0xKuf6QUHlOr9psl5q9Q3XEuc0M2X
	 xUTcMXPTl6r8QPN/7UmfD98EuI89lqxuWsMxy9lL+rnZCNapP8m2h81rI/w2fSkjgo
	 BUqZ1+mJh31TCenMHYxduOsPulSRGtmeuueWYelnh9JlM9nXtemDK4FfOs81H7M9sf
	 mv9e4O1NwNe3zZ2TmxPpoabwn1ruuTCy9KNpJFW6plwcPj0qFRNbjtgUAYxysnn36h
	 OgjBkzph47iKz0gTlLZToNL0lZHjRll68EqC6oF9Oy+ywIAh0mWFC43lxcOkP83Lmy
	 jdiy50WZUex1Q==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	AVKrasnov@sberdevices.ru,
	edumazet@google.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	kuba@kernel.org,
	leonardi@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been added to the 6.6-stable tree
Date: Sun, 17 May 2026 09:33:06 -0400
Message-ID: <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515114521-mutt-send-email-mst@kernel.org>
References: <2026051553-santa-unretired-a417@gregkh> <20260515113503-mutt-send-email-mst@kernel.org> <2026051526-banish-strife-6dba@gregkh> <20260515114521-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > What's the status of that fix?
>
> Stefano posted v3 and is working on v4.
>
> >  Should it be reverted elsewhere?
>
> Donnu. With the change we have no DoS but the socket gets silently
> broken.  Eric felt given the brokenness is upstream already it's better
> to work on a fix on top, not revert.

Dropped from the 6.6, 6.12, 6.18, and 7.0 queues. We'll pick up Stefano's
follow-up once it lands upstream.

Thanks.

--
Thanks,
Sasha
