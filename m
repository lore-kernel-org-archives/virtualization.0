Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A233CA;
	Thu, 17 Apr 2025 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894198; cv=none; b=H0KZXNy+qrBatInCSOK2dgHCNDu7WWOEtGckuWnnGvGKQzvae5zEDTqJSdpnxtzlgFcul2NbNkoLWNsuVFkgQEtX/83Proay+/U8k7iBLrEdBCXQSwSvN1dF2HMiUhwrIjnN2vIJbUa86mnSddTC5+g6ndwucE3rnfQx9DbqWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894198; c=relaxed/simple;
	bh=8TFjBczHKnTvJ3MTEQ94Fw2Ne8CUHfKdkjyyCBHRAuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sydgWtRvmqCT6B2/9yabioEFbJYnyVYOYpRMpcaOLVAj1aUGlscY7OmRmRtamvScENYyTnQtrEJTk1Dd2CIysgTEegvgJeGUu2rmDqwcrTn2MhR+KNfbb+Rd3ldXGSYUXKSyuU2P1xLw39BybFdtXFfe3+5zwzoDtm6yt3HB0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWZamPF4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWZamPF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D721BC4CEE4;
	Thu, 17 Apr 2025 12:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744894198;
	bh=8TFjBczHKnTvJ3MTEQ94Fw2Ne8CUHfKdkjyyCBHRAuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWZamPF41PwtyIufd/kgBetUwINPN6EpKXAcHWlkb+j6hxkZGsLTWuKh0cYoprCdK
	 PqViRRpfvFTvNYF5qwa6Y7T7js9UyNpgp9AEEnMIi/u4xXfhEhl00Ll1occHYTbARj
	 dM45C4o4HVgCkmq1EWjIV+9GGvugwgD5rnfYY1XDloiZCWDbwg5ROtkQnhq5tSJC4R
	 tbzHJPFYD5J43U+R8Dp40xhI/v/QzQCPDFFcAojJs9HihDc4FbWP+BLk6GZJ5yu60F
	 N194Y2pj8cbDYzO8v1lAPpAqk3WKnOuwx7o7T3sObppu8LdFHQs3CIHzfXMZgd6h97
	 T8OEjAgxU+SzA==
Date: Thu, 17 Apr 2025 07:49:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Conor Dooley <conor+dt@kernel.org>, virtualization@lists.linux.dev,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] dt-bindings: virtio: pci-iommu: Add ref to
 pci-device.yaml
Message-ID: <174489419437.1539982.2018240621474238639.robh@kernel.org>
References: <20250407165341.2934499-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407165341.2934499-1-robh@kernel.org>


On Mon, 07 Apr 2025 11:53:40 -0500, Rob Herring (Arm) wrote:
> The virtio pci-iommu is a PCI device, so it should have a reference to
> the pci-device.yaml schema. The pci-device.yaml schema defines the 'reg'
> format as a schema, so the text description for 'reg' can be dropped.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/virtio/pci-iommu.yaml          | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 

Applied, thanks!

