Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880971;
	b=bBUH4RPCDv55eArh6z3+Dbmbf6uJEH+G3G7xIGPTMpqlmGGteZnchjzuYJvT4jRIgLik
	 a44l+SSkPjyRP21S6bYO4keux0UXkbSrNghCNhzg3Z1jMlpMgDQaxIvoRFn+8llh5JGY3
	 MSrgchuiEfdhuVCCvDQCTycbw/x01/mWNtWKAakUf/xCIyO37uopKqnitpgJLmC6WWKGI
	 DQU3+rmz/yeJRsER4rGpXRt4idhAaPKWIEHHN80sPDgtwLW5F2txupmLCDwovqbaZ9MWw
	 gz0k53z3Xl5KNgyilStCSPV2o1fm0QxruuGLLtinE6shZh75e4FzEIQTzTBhsmD2Haw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880971;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=TF5E3OxCLAJ3K3Gd6E9eJewNudqtRFJYUapbQ/RTLVBgutQ8MINSk7Jfk8NuWJXzKixa
	 onDZWDDJu7Epuh/tvxCd3+ln7OydTP/VY707wUj1iURAd2vQB8ZWA+3AkvHMJL2hhMdZi
	 ej4LeKG9WksqnEbUGtq/dFETm9CWiwvA7MVKHMy91VmPI+dKfcY0snyRbf7wMEzApN/kD
	 2Bvv89ciieqcUjfqW6IkIw3HLHCj7kubXl4SoYtuvaaA1jngVIofc3gil7yXn0ADw4Dau
	 LyFHW+BGQz6uCuPjlROcna1/fCoCsQYKnHW/YqfVSkY5QLmffRaFepuKfod39l3ElBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOp5rUHy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA64606A323;
	Tue, 17 Nov 2026 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOp5rUHy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEBB1F000C5;
	Tue, 17 Nov 2026 02:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794880971;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cOp5rUHyDo+SsInYRjOh70eTPyKlarvFhp5IwOJyWSPEItEUADIFhRUgYYO/IIPSc
	 Qaabcbh7XayvCcCVoc+eDA617yURGvWk/RVDCZVSiZXyj27BrBssJ0OGBg0DeE5+wt
	 48KpwmmXymfz2fAQ0z5yshGwgAbBGZ1MKiS8g93sZu2Dv4FplhhTGC1NZalg9+AI9v
	 vsTt30yVqjEMa2lq3SpiXQdTJekpIm0h7km41fx0e9l0qyXrX0EBgqWauZo96Kz7AT
	 IePR7KoSSe0NvcroYKqmLoBWQOU1GzV106d5Ow/JCiP65uEQ0Xo4cY6ypgjMPEQ4a5
	 K5Ed1wH8zn5ig==
From: netdev-bot+sinfo@kernel.org
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>,
 Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Zeng <kylebot@openai.com>,
 Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net] vsock: only undo SS_CONNECTING when connect() fails
Date: Tue, 17 Nov 2026 02:02:49 +0000
Message-ID: <179488096997.3291.4060234902207167832@kernel.org>
In-Reply-To: <20261116-vsock-connect-close-v1-1-43fb125973dd@meta.com>
References: <20261116-vsock-connect-close-v1-1-43fb125973dd@meta.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
