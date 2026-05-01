Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916ED26C39E;
	Fri,  1 May 2026 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777679569; cv=none; b=d4XyBdjKWExIp9kloRrJltLoeiPnCZDHNQMvokJivpb/tPCahlwm7VP6fTcXbuS6/BUJqFevS5eDOeZr6NFtqchsAppLS+UXCAB07BBA0Pv8MzARusZHAHx86MMyszs0EfhC4UgpFmkySQVaCK2t7pAap8Zcq2C+jloXY500uV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777679569; c=relaxed/simple;
	bh=FX4PXwR541nk9lqlpg4ZyWwJ0QQeR085TUZDYDxe0JM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMQtEsEYmBuI7C9Spfx8eO/xWZoS6dbZXmyHhuvN9vmhcdGRiJdMWlFsRehh2/OIGC4spX/N3Qpo0690u/C8iUQGlajs0tCY/2q1hWOhmLMaXcriDvX8My/IF1IwlcMy+2Iu5EKKH7WCNl/VbIVqB+J/QKAYmSRrJADbNJ4o0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCSuiiD6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCSuiiD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87969C2BCB4;
	Fri,  1 May 2026 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777679569;
	bh=FX4PXwR541nk9lqlpg4ZyWwJ0QQeR085TUZDYDxe0JM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCSuiiD6ZPC2W9yrDUa+OApu0jbE2HOK9AwTbkyBPuov+iVJ7IYUQRGDc5hP/azYQ
	 v9Rj3bXmv/4WuEPoTbWCl9QzCk6m7hNXjaGB96nf5nmM39b7sgyOaVAoZ31dE9efTV
	 ZuKg8RqfOtpPXU1tr1Uo2/WgZuKs/rjZWdcKMiONlM21sOJbQ9rcDG+2hyXJKqaDtG
	 PIXHHh0tBvGhlM/VwmVn2ZSiEdlhUmMKkZ903eUGWTo6j4Hjri7W0gusynCM1L+TKc
	 VQjnqsrsXSYzKjypOHrwcHHcB8zSSI/2P2H3dhhXz5GDQk0vvou9+98QaCiZuf/+dG
	 1RvD1ZSMnZ+vg==
Date: Fri, 1 May 2026 16:52:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, kasan-dev@googlegroups.com, Andrew Morton
 <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>,
 Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Hongren Zheng
 <i@zenithal.me>, linux-usb@vger.kernel.org, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcov: refactor common handle ID into
 kcov_common_handle_id
Message-ID: <20260501165247.7ed4511f@kernel.org>
In-Reply-To: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
References: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 16:15:33 +0200 Jann Horn wrote:
> Store common handle IDs in "struct kcov_common_handle_id", which consumes
> no space in non-KCOV builds.
> This cleanup removes #ifdef boilerplate code from subsystems that
> integrate with KCOV (in particular in usbip_common.h and skbuff.h, see the
> diffstat).
> This should also make it easier to add KCOV remote coverage to more
> subsystems in the future.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>
