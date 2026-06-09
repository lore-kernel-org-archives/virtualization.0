Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCE361640
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jun 2026 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970904; cv=none; b=CRoygMFjizYVhXjeaZljYOmDetUxrtcB5SDiPs73m4qfeS82ltJrAXbpyHzcGtTbUjzX5ap4TjSunfY7DUTMZt93TiONDCSCQxtznDq0GyLoUVIQGXcq4dTDXY9GHrEDUxrjdGmJWniOT34wEitMIHmZu/Dz7gIZjKRqLeUeD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970904; c=relaxed/simple;
	bh=c7JD3w02JBo5tsTPDMmw4GptFNlt/PbYFnc2NsI8qaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7PkkOcGVThpEoXBq17FFMTpr4M0QHFHgfLFMDWBfi2xR0hPnn8zh5bf/38Vocsj2bJBj4DrEpu657X8l9Cw7BEjeOOkAZwfQfyu8N5IBPGng9WliXfBkzNShJt0ihm1A3rYF5c/O9lRZyyVZLJ0Yf5zrVrFWD1bDXiiYDf0mR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgajasKG; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgajasKG"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30C396F342
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jun 2026 02:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ejz4kOIJd729 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Jun 2026 02:08:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 82B8A6EE27
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82B8A6EE27
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgajasKG
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 82B8A6EE27
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jun 2026 02:08:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B910740A41;
	Tue,  9 Jun 2026 02:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22211F00898;
	Tue,  9 Jun 2026 02:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780970901;
	bh=fsHEdsO8gQZ7KC1cppmjOB+DDC9HC3XZJCn72ObCXLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LgajasKGMygU6JenratQCZdYHxi5XgKKuGJr6rYg4jBIfWny22QRAo8U9cEeJv56D
	 ccYDvKLs5WbYIvKvXIwb4YJuOICx5fQe9dQwrwMmEE0J8ruc11lfqQs4KGBoTuzZA/
	 fys19H8Pi228p2NN4VzMLVqaQIQh/vhvBSzl9lfEq2UhJbdQ/56uTkNAMYDrdFo+J0
	 6s61qeiGOtruVcKNRjAHV1Hu/23KGjojoZYDWfYjRBi8uCLYQgRFak6iSXQpXlhpGY
	 tH3QZpsI13qnkOvBizLMgbOuN9tWSU8nyKlfp9t2ZVDCN5h6rkrjHVPlmj9lZxPtFD
	 fFh1J2T8ogGwQ==
Date: Mon, 8 Jun 2026 19:08:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Bobby Eshleman
 <bobby.eshleman@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman
 <horms@kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, rulkc@linuxtesting.org
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
Message-ID: <20260608190820.71785304@kernel.org>
In-Reply-To: <20260605115314.552321-1-avkrasnov@rulkc.org>
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 14:53:14 +0300 Arseniy Krasnov wrote:
> Logically it was based on TCP implementation, so to make further
> support easier, rewrite it in the TCP way.

Does not apply:

$ git pw series apply 1106582
Failed to apply patch:
Applying: vsock/virtio: rework MSG_ZEROCOPY flag handling
error: sha1 information is lacking or useless (net/vmw_vsock/virtio_transport_common.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0001 vsock/virtio: rework MSG_ZEROCOPY flag handling
-- 
pw-bot: cr
