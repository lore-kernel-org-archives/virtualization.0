Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6E2F84F;
	Sat, 27 Jun 2026 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782522276; cv=none; b=nbniuM2AsWI+2H4S8PCXQuBEAeVv4F3/mNddxhxUUbAJ00pE6nm9D3UxiVjSKwhVEN6i/CrCUnt2aXZH7U9b14bRjq9fJ3Nk57SYMBLGA0UVPXx5AS83oUD5LWkcIRZ1ofPYIbZLdtCEDujFvTNT/gjF1uVFPO87IjMYssllE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782522276; c=relaxed/simple;
	bh=mZeJONeWC2+4NAO16Z4Q4zs8uJzgi3MSlcGjfB7ggDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edjp/CcFgl9uLrOQP5XalyKMsVKNRXRJmGKIjcVkII4U8fn4KrWWbgbmvkXTaP9n1AAF709O50m7YfvSDdcgwkR31SDV8/xsV+zvJ5B/dV1DrB1c604RHVnWRUbR3gXF4vaAUuwd6Ql+ZVLNTstiDaJjpKGkl+fGmkSeQcSORsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZkmGFrM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZkmGFrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A5F1F000E9;
	Sat, 27 Jun 2026 01:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782522275;
	bh=mZeJONeWC2+4NAO16Z4Q4zs8uJzgi3MSlcGjfB7ggDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cZkmGFrMR+ImhXOM5F3WmWB0SGF7d+fViBKGBWx3xpkybsMYL8p3PIwd6jDnc1vqX
	 h44GKaSG/LFK16roKmJWyf863RHH8ebjl864/j3bkR1wILR9UKAERU2xEiVqEBawZq
	 Gf9IqDWqicQbp8Z9CDHx14AwXK1Vl8uuGMmHW/yHjisjDLKUnyh9pwOSNFNN9Tm4e6
	 nm0ocNA7giTXBnBtgbRjREHZ2TeLhWttJyMg7X+GtCj+ONTZPS3rid53NlMH/zS6wL
	 ObPppVDRndlKjCI8nEf2XsUYu/UgpKIFxG+xVlFsKGRYXbqCQUVGitBH5zcsY2XCM+
	 vVAh9QiBLAefw==
Date: Fri, 26 Jun 2026 18:04:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 eperezma@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Jason Wang's email address
Message-ID: <20260626180433.3e302324@kernel.org>
In-Reply-To: <20260626022039.96139-1-jasowang@redhat.com>
References: <20260626022039.96139-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 10:20:38 +0800 Jason Wang wrote:
> I will use jasowangio@gmail.com for future review and discussion

Do you want to add a mailmap entry, too?
Otherwise I think you'll get CCed twice (once for MAINTAINERS and once
because you given tags to previous changes)
