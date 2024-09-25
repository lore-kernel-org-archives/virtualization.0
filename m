Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495713698E
	for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275214; cv=none; b=cntSn3Cgk+8QJREmxOOis/wvvu02xbHZRBtZb6YnX2kJloo1+YM4bp4t38z48Oh1fDSN+cvxbF222M74tv8FQEaEjF2ZXrDBzw8EobwBmSouAwziv9lNPjLEpbk6dFIe8N0jfX32nHn7RpPS4w6GgJZg/r7sz0ByLmtOlEsPpj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275214; c=relaxed/simple;
	bh=fIEp7HsBKrhDah4FlszeQNbwKd4OBJVi932m8+XSfJQ=;
	h=MIME-Version:Content-Type:From:To:Message-ID:In-Reply-To:
	 References:Subject:Date; b=Jyn9d7GkkQScafqDYmSWOkhW7M4u+rRAD1SoZjiErWoGCa4udse2TNZf05FicJQQTB4JFYPm9b2JIHmMrUzrdWTib0fPaZBm5iwbAg3WEMP1ddt0YTOFNdE0eoQnGyrsrpk14/t8102svii1C5tc2zhVsEcge2RGBLEW0Vz4fiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpkU1d/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpkU1d/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3425C4CEC3;
	Wed, 25 Sep 2024 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727275213;
	bh=fIEp7HsBKrhDah4FlszeQNbwKd4OBJVi932m8+XSfJQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=FpkU1d/HQps5lSwOFeDAFUBwt/iBsJVr0G9QYFaLo864OgyYjcU4g3rflIn20hnIN
	 EpjwUJW8He3nhLLiEOq0DErM1T6Z5iju85ci9S7l32gZX26feu+k8v/lbvLB3DF+WX
	 s11lDhLDsKNr0Zg42ks8zSga4DSBKA7MHpFhghHUGIY1SEVTyuDmtASLmxLx7fCQR6
	 TYG6Oz91TeeRZEtqU1PcWm1HM+HONMMj1Q4o26AaS//mzfoulhksBJMFUVg2AbL7RE
	 DhYPbv62Sl6gkygue6pg3i1BgznFfSbkT7wnFgA1iPfQq/aByq3S7/nmex20Ack/8o
	 t9J9qep5Q5Hcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A1843809A8F;
	Wed, 25 Sep 2024 14:40:17 +0000 (UTC)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: Bugspray Bot <bugbot@kernel.org>
To: alexey.makhalov@broadcom.com, konstantin@linuxfoundation.org, 
 helpdesk@kernel.org, virtualization@lists.linux.dev, 
 ajay.kaher@broadcom.com
Message-ID: <20240925-b219322-d9b831a5fff0@bugzilla.kernel.org>
In-Reply-To: <20240925-sturdy-red-seagull-2c17a6@lemur>
References: <20240925-sturdy-red-seagull-2c17a6@lemur>
Subject: Re: Bouncing maintainer: Alexey Makhalov
X-Bugzilla-Product: kernel.org
X-Bugzilla-Component: Helpdesk
X-Mailer: bugspray 0.1-dev
Date: Wed, 25 Sep 2024 14:40:17 +0000 (UTC)

Hello:

This conversation is now tracked by Kernel.org Bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=219322

There is no need to do anything else, just keep talking.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

