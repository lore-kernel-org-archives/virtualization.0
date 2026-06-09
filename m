Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E33F077F
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jun 2026 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998527; cv=none; b=cwJ4Uw8PTE32CST/CX3xE+aIwjlbBfc6kMoEMtz8nz7ajdTW5VRfV3LjLV5SBfGwRS4ybAqGAgmJ2f74yKj+oomRx7EI3ShMbb2MuTIhyPeGSY4DxaGkybsTxry0chMbgCZjmE/KPwXh7FDypwMbBDWU6XT0Bj1HIdQbjfE0S1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998527; c=relaxed/simple;
	bh=QdtnFTqoS1oY2E32jFZfL4GrvAxiwbAg8YbssX9PAPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoI1R1MyXTW6opSbWZWMmoxQW8p6D7w/yhC38CbIQeTvp0KnGAUJDfrzIZkDcfw2mCY58QVIOxrp8+GIislwGTwrNdJk/0jMUVa6zs0EyoFxKC0htXdVGNA1fGlxNMDtBNDorjNvuTOG/mJYtg1AFe218khnck1oF1e0RdXtEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=KzdqJ7zE; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="KzdqJ7zE"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A566C42E8F
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jun 2026 09:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.791
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRod8LlbmHUq for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Jun 2026 09:48:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=155.212.184.193; helo=mail.rulkc.org; envelope-from=avkrasnov@rulkc.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6248E42E59
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6248E42E59
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rulkc.org header.i=@rulkc.org header.a=rsa-sha256 header.s=dkim header.b=KzdqJ7zE
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6248E42E59
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jun 2026 09:48:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE8081000E6;
	Tue,  9 Jun 2026 12:48:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1780998518; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=++Cs2JBZqXYs4iI+cjVHpwGDyqJVzN4jXYl2vkWqga0=;
	b=KzdqJ7zEUO8/inpTW/TPejhvka7GGxtLYV52bori/ctOfyl56y18WgFqJxEBW4qZbGcJdZ
	MQLkWkb5JClzlmGmUf8P5R3Ft2hBmv5i7fiZtiKGffozOoWGndQaF+oaYrwR9VLrFR0hou
	mzqGi2OQk/lUHvRMekJAaVi8fxim/cua4gn5UOVtqt+uQr+rkIElcIcIZEUhuj8++KQVM6
	hfhH5XR81kcJUbxD8VwqRa3bMLtu1NyRvfOuYrsYsbbuUcd7SubPHW2aDoKXVYEA03XAOU
	+xR8PraxG7+fQc1K1ZOiKmSxYkHrYtK/eoPSpJMsXLvsyMUfy2c/WgmSGmhzZA==
Message-ID: <76d3872f-8bd6-4b90-b84d-77e638e50cf6@rulkc.org>
Date: Tue, 9 Jun 2026 12:48:19 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, rulkc@linuxtesting.org
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
 <20260608190820.71785304@kernel.org>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@rulkc.org>
In-Reply-To: <20260608190820.71785304@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi, I'll rebase it on latest net-next

Thanks

On 09/06/2026 05:08, Jakub Kicinski wrote:
> On Fri,  5 Jun 2026 14:53:14 +0300 Arseniy Krasnov wrote:
>> Logically it was based on TCP implementation, so to make further
>> support easier, rewrite it in the TCP way.
> Does not apply:
>
> $ git pw series apply 1106582
> Failed to apply patch:
> Applying: vsock/virtio: rework MSG_ZEROCOPY flag handling
> error: sha1 information is lacking or useless (net/vmw_vsock/virtio_transport_common.c).
> error: could not build fake ancestor
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> Patch failed at 0001 vsock/virtio: rework MSG_ZEROCOPY flag handling
