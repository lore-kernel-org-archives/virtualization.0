Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898C204C25
	for <virtualization@lists.linux.dev>; Tue,  1 Apr 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517535; cv=none; b=KegtcWifSjTsGiEE87yakFrCzU+8Fl5t6Vh0jgFrSYQPrDinEVKAbXjVfZ8GBcoeQzaFOL3Rt52dnGZ9OeDnZY+7vJWzVvvC5wCIoHBGrFf/Wx0eZER4njJmfqYEhP4TLjX0ZQiyEjLMO64UF0X6BaIAiUtWxfdru91D8X1PZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517535; c=relaxed/simple;
	bh=1/AAu4ml4MViQ+FpwPBEj6HozYXlOVT2sbaEwqNFQ8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ7tcG4dFKv++y3MvKb+2vRjbdwtRtNZvMU6+oTcXHy18BnZWJr3WRLA6hIl/8EGm2bNWzfyyUgkPUBCdlUnt+vD4kbx/tUeRHCKE4R7/gV34uLsg5w+dflLazzUm3T/CiKUn9sBlCrhB07Gs6htVLEFoPK3dKk4qF6Z/4v1lXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSgojhG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSgojhG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743517532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pdWXSeKX0PhjDWr9770PlQZO6x2YyeElurh57OPstnA=;
	b=bSgojhG+KeJvYRCIQ7kkCSF1bDIzDaG0iucx39LC3oLv9wKKQZjO58pBuEgxlABGJk2jl1
	wnM1nsAG2fvnOwU6zryBRUWj0QFWd6hDQO7zcqyYSn8vrhHhS/scPaQ8Ta23l/sPUA75s2
	8IcWVJ+yFmm0aDTIfRErCOciGe+/9r8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-R3U1Q6zGOcmXxmy9eBN0PA-1; Tue,
 01 Apr 2025 10:25:28 -0400
X-MC-Unique: R3U1Q6zGOcmXxmy9eBN0PA-1
X-Mimecast-MFC-AGG-ID: R3U1Q6zGOcmXxmy9eBN0PA_1743517527
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59079195608B;
	Tue,  1 Apr 2025 14:25:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.107])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5E9A1955BEF;
	Tue,  1 Apr 2025 14:25:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6A25018000A4; Tue, 01 Apr 2025 16:25:24 +0200 (CEST)
Date: Tue, 1 Apr 2025 16:25:24 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1] MAINTAINERS: Add Dmitry Osipenko as drm/virtio
 co-maintainer
Message-ID: <l2ndn2jo2swv4unuc5r7fm3of6w3teyytpqfpgcvkdwnp3fubc@ect2rh2ikmhn>
References: <20250401130151.2238772-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130151.2238772-1-dmitry.osipenko@collabora.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Apr 01, 2025 at 04:01:51PM +0300, Dmitry Osipenko wrote:
> I was helping to co-maintain VirtIO-GPU driver in drm-misc with
> permission from Gerd Hoffmann for past 2 years and would like to
> receive new patches directly into my inbox. Add myself as co-maintainer.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

