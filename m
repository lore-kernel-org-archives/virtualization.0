Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B4DF5B
	for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275183; cv=none; b=ZDhrgXOfPjF6VaOXLugI4SST86jRU6vxAsBWh269n/dwz1s1/lxC0ZYAkFZJP5UUMZz2/tf7DL7v1fFE1IrbeUY1j1+SBuDp3ka45W8pRglIgYUp6CdBHotWp7BPuiFkmrzhIQeZscjZCQeERqn6MVFse7+2A6UkHxjwcn1SX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275183; c=relaxed/simple;
	bh=21wbgKYb9Cu7jLF+6HJ4DpiPp6nRraL01FSsEhQSCPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oii6OPmtJJzQX+0RbvAV+nhnXBNmwHGBG8ScJvFjQAas9PsfMujPTIZBQv/ZqjUEb3E+np7oBsZU+JrI8LSDg0zqfxAd8pCi89Vq9hZ3NET7b5T7weHRdezBqm/c40N9kM3iUUoat7GF57Q91dM2+rYe/hvYP1gcG+AeOd76wdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tXwEyQL8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tXwEyQL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4118C4CEC3;
	Wed, 25 Sep 2024 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727275183;
	bh=21wbgKYb9Cu7jLF+6HJ4DpiPp6nRraL01FSsEhQSCPc=;
	h=Date:From:To:Cc:Subject:From;
	b=tXwEyQL8J99NpgppQdSwBmEXvge4Yp9zoheM1sgxHgtZJCrcPUGSrUXspz9fSDB5P
	 ZP7sl4Zs2poM62kMs61+B8p5cx09r463HBF5aJn9XC2ibK8BYex2+u96j40nNxgYr9
	 cU8eih0fe/JA2h2WXfuul0C5+TmO44WHfOIl5hFY=
Date: Wed, 25 Sep 2024 10:39:41 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: virtualization@lists.linux.dev, helpdesk@kernel.org
Subject: Bouncing maintainer: Alexey Makhalov
Message-ID: <20240925-sturdy-red-seagull-2c17a6@lemur>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello:

I'm reaching out to the list associated with this subsystem:

  - VMWARE HYPERVISOR INTERFACE

The email address for the only maintainer listed for that subsystem is
bouncing:

  M: Alexey Makhalov <alexey.amakhalov@broadcom.com>

This appears to be a typo in the email address, because I do see email coming
in from <alexey.makhalov@broadcom.com> on the mailing lists. Please send in a
patch to correct all MAINTAINERS entries to the valid address.

Best regards,
--
Konstantin Ryabitsev
Linux Foundation

bugspray track
