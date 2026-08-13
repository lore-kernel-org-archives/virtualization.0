Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F9438494;
	Fri, 14 Aug 2026 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706877; cv=none; b=bOaCJGg00tiZc/WQp+yLzYF59lENKQKg67NH5L1OvBnnvpl1oZgc5Rx0tzxZ2QR6h7TUGJlqAO0mbYbNpzq2pQ9R1+zeLR9RQznRZB2W5mm4U2/8G/MDiooPBcVKDeIbA7GCFGlEaJ62pCQzwkrOcoUPuWkBwNZVlfAu2nuXfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706877; c=relaxed/simple;
	bh=cOwnHjqwb7+GN+sbhaHzJATUw+qP2cMg9spKZvjC4L0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UQBhOgyBxpCGe5jx6si8LaAt0U9EG3IEUv46VPBsuaAzpIfwqDYSEbX3UwItZJZOdLgeRUdFRlWu4TLCWN7DRziISZCboH6hN+SKg6VtCzakySVu0ipRlNHvqcCxsXCDExX2SBNVC1+O5RKX1V3dGah44waixiU6iwej8ie6/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsC+yu6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsC+yu6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1C11F000E9;
	Fri, 14 Aug 2026 11:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786706874;
	bh=XypQbDmrRn7Fo5L7rCCFu+y4IEw1RhruNWIXt34BfRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EsC+yu6aT1feDka+zEtA4V8Zc8M6q57CfdzyNLQxex+nnPAtkwE9UxKWHWvmGcgWl
	 t991RSsgiPQWhq4SSchZiG1fHpOqc5Z3K6KV4CASbXVeVRjSA1dHMLSIvlMGFKG0RN
	 ZmlFZ65EgI+aX4ZO94FXuqOEWYLCicY2evGi1bqMkEe4KtMI3qanLYKCOJuF8tNiKS
	 R2jRbDE/cTFdDpTnwyZp3yQeXXQGjNTBXAvqGP9T3XnjuBXtHgadF1TczGQ2QXIyuh
	 2z/1zS+YEBYCg+kF5KgO5iKdh31580nMb/c+H4pRM0aUp6h+ESqnRcbQnA2T02bVWq
	 k7uy1zhDPlFDw==
From: Mark Brown <broonie@kernel.org>
To: quic_haixcui@quicinc.com, Jasper Wise <jaspwise@amazon.co.uk>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nh-open-source@amazon.com
In-Reply-To: <20260813084618.613172-1-jaspwise@amazon.co.uk>
References: <20260813084618.613172-1-jaspwise@amazon.co.uk>
Subject: Re: [PATCH] spi: virtio: mark device ready before registering the
 controller
Message-Id: <178663892150.110398.12479342103868472704.b4-ty@b4>
Date: Thu, 13 Aug 2026 17:35:21 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cOwnHjqwb7+GN+sbhaHzJATUw+qP2cMg9spKZvjC4L0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqfvu2qiMail/2+iNE7GFOaUkNfufeNPtr0JYZ2
 yAxNUU0nP6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCan77tgAKCRAk1otyXVSH
 0AH4B/9OGkVAZWwly6Y924PPmcSxMBmEExYb6+eylM5dMkUPufQ+rUvMa/G+rQyjqm1l5KgyEQ0
 u2HyecjkimCmpTS2m6qHZld2uGkyHvb/JZlcZKONfwFxuyg6hxZxMtdT1rkQ0dV7iYKn2vtVvo2
 jgK0hjGI+CKZPasZ8LDeV3fCLsgm2lJ6F9DeRFIGm3gsJ4d9Dab8ZA5Up/Xgb+QoRCIOndc+lMW
 LFenlBlHcM5qYo+OUD/AhIyO/iAkpZBV8oz0N3CMLiVw1OZ8d34mRfo9JmPuBFzNYouQ8eTuiBu
 0Q8u9SVHTh7qaRzZ7d+JhdofU1UqtKOnb4jMWXE7m20k2F+z
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 13 Aug 2026 08:46:18 +0000, Jasper Wise wrote:
> spi: virtio: mark device ready before registering the controller

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: virtio: mark device ready before registering the controller
      https://git.kernel.org/broonie/spi/c/11058bd3d47d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

