Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532BC31A6D
	for <virtualization@lists.linux.dev>; Tue,  7 Nov 2023 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w08HM++n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35B6C4339A;
	Tue,  7 Nov 2023 18:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699382505;
	bh=qRl7D92TRp1jOXPKIShTNC57HQTaGm5gk2QTBXKsEDE=;
	h=Date:From:To:Subject:From;
	b=w08HM++n6e1kH+W4N8uyzQ00EKrvB5OHfoyiJiUuXCI0GsJJ7i59xg2nsXubSrkgY
	 M91JudYAcUOI9zrkK0YtgJbpozM/Q9RI/tzlibGg12u7g6rh+A/npEVWPC6Y1NEDg7
	 eLem6++WFQvV8QZfmRA9YDTkXLwfQ7ycfxbhNF9s=
Date: Tue, 7 Nov 2023 13:41:44 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: virtualization@lists.linux.dev
Subject: The new list address is: virtualization@lists.linux.dev (old one
 still works)
Message-ID: <20231107-agile-garrulous-silkworm-cbd8d5@meerkat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello:

This is a test of the new list address. Please update any of your address
books to reflect this change, but keep in mind that the old address should
continue to work for the foreseeable future.

-K
