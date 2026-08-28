Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3785C1922FD
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882577; cv=none; b=SKoxUmI+w7fyhmH7TrGhPq03TJOX9jutvywwmDkkhiVH1XTZd4yyhY9PCBfngTgT2YcrcL//YoHPxIUnvLF1eWYWh1+SYR3OeGbGcKPishd5TxwiAoX4fBMGGklKw1hpeH3IoYcYLacidBTOemPtvY0SQ+C760ziqNfu/6FYYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882577; c=relaxed/simple;
	bh=JqtT4/1VNaufIEE32rrynp2orypDkdMbFcv921TFbm8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qn/Y16b/IDDPxDkVB7gpJzP1jfNlIBFU4M7Kxs0Vdzznjf7+iY/ojX3KnQYkdG0U0qjfvpVvQwcuzbP9e7HlZxYq8u3mtSRuBjV38gzUDewfM2HuLmJl6Fx/5SB18k1OZ102jjcwtRn0SQ8mV4fdZBZe5iYMPlcGnRXCM/FITyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DuIHYT8X; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DuIHYT8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1787882572; x=1788141772;
	bh=UKxbeAn47/2NNFP5SzE1kHmFcRG4Vr0q6jvXkTYz15s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DuIHYT8XzozvBrkOFrWMwRiTkyM+4AeCSj7qRP11OYKoeEYtcIr5xXne/ZWMcm6r1
	 Ju+3fcWOO6Jr2zEqibwWM/LSytA5xszV7BR/RbE3hYg6CBrSbi/5K0fQwF06yI447y
	 0M3KBhXiBekBHx7oiu6Vz7Q8+HjmcryE2ArRIYGq1buz+YaSEUNz5wLp61ymJPIYrU
	 aTFCfAJAiVJXC6cWEJRTDO5snDtIfCWHnZt6qVFh9wd0Cw782hUpqbj3ubvKceGo/5
	 D5kTfit3IrMLDEdasoarS/nE7NQO73r3WQQ/ukeucxwycm93cCQgDCSzXYGoJxWZXU
	 CTqfk8uuQ13SQ==
Date: Fri, 28 Aug 2026 02:02:48 +0000
To: Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>, Shuah Khan <shuah@kernel.org>
From: Aaron Paterson <apaterson@pm.me>
Cc: =?utf-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] fuse: report a request refused for a live nodeid
Message-ID: <20260828020241.92045-1-apaterson@pm.me>
In-Reply-To: <cover.1787873791.git.apaterson@pm.me>
References: <cover.1787873791.git.apaterson@pm.me>
Feedback-ID: 6356313:user:proton
X-Pm-Message-ID: 223b030157c78b545fc11495bdfa4d1567a6665d
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The measurements in the cover letter were taken on 6.18.5. I have now run
the same comparison on current mainline, so the numbers sit on the tree
the series is posted against: v7.2-15794-g1b78070aaef6, inside the 7.3
merge window.

Both kernels come from the mainline git tree directly rather than from
applying the patches at build time. The unpatched arm is that commit as
it stands; the patched arm is the same commit with these five applied.
So the only difference between the two kernels is the series as posted.

  arm  fs/fuse  virtio_fs  opens    refused
   A   stock    stock      315076   22646 (7.2%)
   D   patched  patched    407169   0

Every refusal on arm A is the contradiction the probe exists to report:
open answered ENOENT while stat on the same path a moment later still
described the file. On arm D there are none.

The refusal rate is lower here than the 14.0% the cover letter reports
for 6.18.5. It is a race, so the rate moves with load and with how fast
the guest gets through its loop, and the arms above were taken while the
host was busy building the other kernel. What does not move is which
side of zero each arm lands on.

The probe is the one described in the cover letter: one process replaces
a file by rename while another opens the same name as fast as it can.
The server is Apple's Virtualization virtio-fs, which releases an inode
as soon as a rename displaces the name it was looked up by, and is what
makes the refusal observable at all.

