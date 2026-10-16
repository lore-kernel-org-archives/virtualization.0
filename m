Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F54772B2;
	Fri, 16 Oct 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151556; cv=none; b=dtk64DJbhlvo6QQaoau8OOfLh7pDOwGfnRqcKKn2It+Tm2Az44N3t9zyrce4zowYRi8nQ2n7yWhRi+TggGBy2qhj1oLxzRHdAmBo2a0R8kXqNr+IN/jbG2wtOXifNRTJMLTyuW1UqEU1gM/gl6vBv3TSRmqmFa4BoRgpdWe0PHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151556; c=relaxed/simple;
	bh=oa9f/2v1sR+ykNNWDoUx6e84AN0mDVBk+4Ba+4On3u8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=onVqcCxbujfTANCQDt7nzSj/3XyV7mYp5AWx4u7kKf/cmF75In7WPKd/XnrxaRROr2mdZtcdO2yZ/CdG3CTfl7k3CCmk/VLg3b4LsA1x0cFVBnI9D/pa8VrwKvSap5riy5oPxpa/48DPuuwqWmzpOzmOwky30oBIAzTVcoCMMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXJhVJuS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXJhVJuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1909B1F000C7;
	Fri, 16 Oct 2026 11:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792151555;
	bh=oa9f/2v1sR+ykNNWDoUx6e84AN0mDVBk+4Ba+4On3u8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bXJhVJuSfGPszEBsc3oqDZOybZVKfDR9jVQN1GTbPnAd9DP2MhsdFsiIoJTSSDYoJ
	 UipWIA9XIKKucazhfzv+s9BqfJ1G97JiwAIh3eQH8DLE/rUaNhYbxLOnMwnfjajVcD
	 ySDMFZPvrPz7Dk9OD4iTkL74dBIquAfU//8hYPmEMaOWbAhY3hi+ZMwIgH+u+zEUZZ
	 xk7DfOVXGcUGKyWMGAi/6pAfUPFwgTstII7aci7tRRddgqlvg4+aIfmnzmUJXOBiFz
	 C1q0iO6o/TlT6rW3X71i1AR85y10Tm2mDJLqNf6FvyDFe3UrC97VfHyEtC94LzrShs
	 3ryCddCgAXZTg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang
 <jasowangio@gmail.com>, Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, Rusty Russell
 <rusty@rustcorp.com.au>, Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH net-next v2 7/7] virtio_net: cleanup protocol calculation
In-Reply-To: <3c828204754ba2218e419f8d0a20bede7d8dffe1.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <3c828204754ba2218e419f8d0a20bede7d8dffe1.1792067836.git.mst@redhat.com>
Date: Fri, 16 Oct 2026 13:52:32 +0200
Message-ID: <87mrsd50cf.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Michael S. Tsirkin" <mst@redhat.com> writes:

> A trivial cleanup removing a duplicated code line.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
