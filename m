Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22F3C01;
	Tue,  8 Jul 2025 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007732; cv=none; b=XkjFdxknqZGqaI13UbNW0N1PcDGqq8cqk7fROhI6EHn5HWnSlWHdsrDRX3CDO9CNJoKPDjT1xcmhGx3VuO6T5pMoeJE5ZTiai3DY8+4QGXJuw1sOQnKAXIAW3/sVCrzcBfX/eLPD43c8R9BOTZGNk4LkIirYOHaC3LGHAQKTD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007732; c=relaxed/simple;
	bh=ggOq0+nzV05/VSnotq5oUum4/hLESHCJ41Lf6rzFU3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cC92qmb1xwSQhjxZDfmXBN3iRn/Zd0RFh+Iyq8Kn25vy9jvozuCNdMAp3Se1dT44xT7YkqQy6lRZtmSj4BZyP918L/cqW/NXH/znJDIsBMv48Ydbf9+QvI9Y3govED3BM/HIY1IobJQ6FctL+iRdzp+GkuDiGFsvaoCT5f7JEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Gqnkh++N; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Gqnkh++N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=DZoekFWDQRKYS8E//rmMDVjwcHRmk9UG+oNvcbgcvko=; b=Gqnkh++NdrrEy6eq
	Z4VZVz+V47pRptvyZxxV/ID/De2WXDpJSTPe46C9TkSgO1qzr6ncjKK1sgriRC0fLFPMmT383TU9b
	6BAme5M/yoN/Cb70eXFllJIKFdhPIWxNu1e6M33BN3E5mqMe0vPSUwG1IN1S55VzNsViOoAUOGGMG
	+h3PAZDWJNu3+ik/pLlvR3NVFYUjqAHCXBQ2oIz5bgLw/mOOE0b24PEE5tNCqyOS2MOHBV+Wp1VYH
	BmTXI9XS8sQnzPjl2H/VFLgYoDUgFNzWyGxuS4SL8XZ+L6j6QjDMVKlXsd+2nbSx1PpUjWd/bg3sP
	Wj163Y2bE8KsUNAYuw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uZFEu-00Erpy-0A;
	Tue, 08 Jul 2025 20:48:32 +0000
Date: Tue, 8 Jul 2025 20:48:31 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: kraxel@redhat.com, airlied@redhat.com, mripard@kernel.org
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	airlied@gmail.com, simona@ffwll.ch, virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm: qxl: Deadcoding
Message-ID: <aG2EH86lesn7VZNZ@gallifrey>
References: <20250413171058.271234-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250413171058.271234-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 20:46:26 up 72 days,  5:00,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   A couple of small deadcodings for qxl.  The first
> just cleans up a couple of trivial unusued wrappers.
> The second cleans out some debugfs code that's been unused
> for a few years.
> 
> Dave
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Hi All,
  A gentle ping on this clean up set from April.

Thanks in advance,

Dave

> 
> Dr. David Alan Gilbert (2):
>   drm: qxl: Remove dead qxl_io_flush_* functions
>   drm: qxl: Remove unused debugfs code
> 
>  drivers/gpu/drm/qxl/qxl_cmd.c     | 10 ----------
>  drivers/gpu/drm/qxl/qxl_debugfs.c | 29 -----------------------------
>  drivers/gpu/drm/qxl/qxl_drv.h     | 12 ------------
>  3 files changed, 51 deletions(-)
> 
> -- 
> 2.49.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
