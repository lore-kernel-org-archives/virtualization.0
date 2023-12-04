Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA673F9D6
	for <virtualization@lists.linux.dev>; Mon,  4 Dec 2023 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVLjR8vd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAA6C433C8;
	Mon,  4 Dec 2023 08:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701679430;
	bh=lDOXjN/W84Vq3sykgf0bUUGkHQwP88whG8TRkS7Nx44=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WVLjR8vdJwdvEjNXZSMe8Lp1vcM5owgcUib2prYQjTy0EgDp0Om8FIjXQcQ1rbcbQ
	 fQLWWvEOllo3g9AmgI7Gjg7cOagUiRiV7SnKfzGFuNkCuA0rbBz65oBUfqTwreubxD
	 QVQdwh2v5ZRtFRbx9CDxwJN5LNyFBjlU3ciSzYovIt2RuI0hdP0x5KETnIWYCmskBK
	 kKCcVdf6QvWPD3uE8T4h9PdVMciyQjO9UtIlvW6JloR7eQN7kFuAWmV79kmcBkWDKm
	 5JpF+Qki6Casz1xtMtz5hQ2LSrHqd87jUHqVH8/B2v5Y+VcZgjM+VrCJ9OQeStZJSv
	 CF1MrnJ1MrbRA==
From: Maxime Ripard <mripard@kernel.org>
To: airlied@redhat.com, kraxel@redhat.com, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
 daniel@ffwll.ch, heminhong <heminhong@kylinos.cn>
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231110055031.57360-1-heminhong@kylinos.cn>
References: <20231110055031.57360-1-heminhong@kylinos.cn>
Subject: Re: [PATCH] drm/qxl: remove unused declaration
Message-Id: <170167942791.3617818.9387915211880062681.b4-ty@kernel.org>
Date: Mon, 04 Dec 2023 09:43:47 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Fri, 10 Nov 2023 13:50:31 +0800, heminhong wrote:
> Some functions are never used by the driver,
> removing the functions declaration, it can be reducing program size,
> and improving code readability and maintainability.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

