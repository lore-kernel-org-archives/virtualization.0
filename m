Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2C51850BC;
	Wed, 26 Jun 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408923; cv=none; b=Xn8WoMgI8pX6gtYBnqk2/aLetALBg6Jv0oQRmQEZVt65iiBDECKqXuyrRJd3/jhL1GslKYB4oGDKOsChMhNqzn5FkqnQjmmwKhKWJbxRotS1P+gAkZuA8iD9JsazoBJra1N0M7sPSioVHNCxh9dbizHTyCPuXBA7YWJG2V6kiwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408923; c=relaxed/simple;
	bh=K19aU+29zeZcJ3frko2cJmIO5k73MSNWKAXAl+XEBc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYAZ/Or02j3MX/IbEsQvLjnzT0TJ0+NXTd+j0icTSnvW3JBAzusZzi67iKgAUmWRT3KhdDRGEJXV4XVR2pOolD16t39qyPmv6F3VaP+hq85LogMenoCdb4LPNd+TUG+osigN31cuw5EEDvGD800OPkr1RlnR/jGeXD5rcC195XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpUa90C8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpUa90C8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1116AC2BD10;
	Wed, 26 Jun 2024 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719408923;
	bh=K19aU+29zeZcJ3frko2cJmIO5k73MSNWKAXAl+XEBc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VpUa90C8RzRLUXLW75wKPDRjAYdM/dBQCSIJyjSydBxjjLnlUAXwzZQnCqoQbkdZ9
	 ioyKJBWtz6Hi7vvOdYssfB4FFJvrm5RtY4/Ji+dIV1zeyxc3doUzJrrgVBqVu7/tjB
	 aUMz5HzXIpY9twOKG6tzuFhLhu9ntJF5/uxAE7gZk2oLx9KzMrukvNxsB/9gjjux2o
	 lu92igpTDXbVJVHM4+CKE5erX4w//mJzODnYU82pYWHC/VEyqtszPwZu9tJ2YzhtZ5
	 MPw1zA5hnIHvqnlukMB1cT7ONRLVJItLb6wwZY7q7xziZiZQuKDxL9qljbCeOFT2d2
	 P8CIPjwt9wmgg==
From: Maxime Ripard <mripard@kernel.org>
To: airlied@redhat.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	noralf@tronnes.org,
	Chen Ni <nichen@iscas.ac.cn>
Cc: Maxime Ripard <mripard@kernel.org>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] drm/qxl: Add check for drm_cvt_mode
Date: Wed, 26 Jun 2024 15:35:12 +0200
Message-ID: <171940890752.2204713.11667399517595004219.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621071031.1987974-1-nichen@iscas.ac.cn>
References: <20240621071031.1987974-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 21 Jun 2024 15:10:31 +0800, Chen Ni wrote:
> Add check for the return value of drm_cvt_mode() and return the error if
> it fails in order to avoid NULL pointer dereference.
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime
