Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B347ECF7;
	Mon,  7 Sep 2026 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782794; cv=none; b=lcthb+Fi1/H+wKGxnem4S7tWphmBGAqS3ApBtUvGO/tGRv+c8ZhFbm5aAxG7r/paCdBlkFhThbVBCQiqZjIprEBubklaqn18L3w7jWboBwAoLTBu7uOyszN1Weh5G8ZmU4v4hMDWowiyon4GyNOFB3vKb+ZUjR2wynVyisoHymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782794; c=relaxed/simple;
	bh=piInyLgkcbDyzpblMqGAf2ynunGkgJ4We8r7EwXq64M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVk2T9DONfvcNHrmsC0r43mXxNjSE16uC0Uq9MysJUtnJ5881B3FPTQ+ipntAGObIpdLQv+T5bjBtnDZPKWB/s1+lCeBgQKDTgBbFMEL8uDxAkecokUT2MAZmHR7Dx3+wjP1zVB48zdSFgqvhMkDiaH5xJIcZohJMHp1ud7lPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=eDZNiepM; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="eDZNiepM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=eqN+lGGowV/0PJOpQ1jZTWLYGirGXTEyq2f7xgjKbOY=; b=eDZNiepMtBaKYeKraQipuckICA
	59VH4/wNICYoM+4MZDtZijGsjP/EF2AXDVoRuE5VqXF8dAOurqlwek2PI6XHex6OIMm6HH/gtKK3a
	2KFzYTUybztBPWCMkryrVayc5P39+C3f25iFdGE0rTbs1xGO0qeIVIiNz/hL7t3ZQ8bsYZa3pg1UP
	q40uQMQzsPC0xAZUdI2mQ+UW81o+wVd0ZbTK2yI8O7BOkJ+SN8mp/1O3sDf8Tt7LDVQfz224QQNCi
	8Od9cGrRnfSnpgKsvpKGWCFcoO6zdzaoR3IkrKrqC9GuXoPwfuwTb2lGnYjn3bN81/UFhJICv2mwf
	HMhUfNEg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x3Y6s-001Ukf-2j;
	Mon, 07 Sep 2026 12:06:03 +0000
Date: Mon, 7 Sep 2026 05:05:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jay Vosburgh <jv@jvosburgh.net>, Vladimir Oltean <olteanv@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Petr Machata <petrm@nvidia.com>, 
	Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net] selftests/drivers/net: include lib/sh/*.sh
Message-ID: <ap6oi4YujKEgoKhu@gmail.com>
References: <20260907-selftest_lib_defer-v1-1-8af94645aaa3@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907-selftest_lib_defer-v1-1-8af94645aaa3@kylinos.cn>
X-Debian-User: leitao

On Mon, Sep 07, 2026 at 03:28:09PM +0800, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> When I tried to install and run bonding selftests via:
> 
>   make INSTALL_PATH=/tmp/kself TARGETS=drivers/net/bonding \
>      -C tools/testing/selftests install
> 
> Some tests fail because net/lib/sh/defer.sh is missing:
> 
>   /tmp/kself/net/forwarding/../lib.sh: line 5: /tmp/kself/net/lib/sh/defer.sh: No such file or directory
> 
> One option is to add defer.sh directly to TEST_INCLUDES. Alternatively,
> follow the approach from commit f72aa1b27628 ("selftests: net: include
> lib/sh/*.sh with lib.sh"), which pulls in all .sh files to accommodate
> future changes to the library directory.
> 
> This patch adds a wildcard to include all shell files for drivers/net
> tests that consume net lib.sh. TEST_INCLUDES is also sorted to avoid
> ordering‑related problems for future modifications. The team driver is
> not affected by this bug, but we use the wildcard for it as well, rather
> than listing only defer.sh.
> 
> Fixes: a6e263f125cd ("selftests: net: lib: Introduce deferred commands")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

Reviewed-by: Breno Leitao <leitao@debian.org>
