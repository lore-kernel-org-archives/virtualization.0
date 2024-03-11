Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF51F519
	for <virtualization@lists.linux.dev>; Mon, 11 Mar 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159864; cv=none; b=J3VtnAnER5sWGgSdkVDwB2jl1iIHTlvWv5sdnSF/455ejLw2+teslcKm8zd6B8pBQ4I6G/JMFOzbUuB0a8Q5bzVl52LD/4raWK39bL8qmY0Bf58OrMhV2d5yUwobMI64CMUEVzHeXOpjeHVcIiKzSc9A+Pj+OgYMj8wPKk5lcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159864; c=relaxed/simple;
	bh=uvc2srdklbEZWRyAUkveO2lIu9fiESGPXlIMmlZAhO4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cIP8iYFrvyoJXeeeiGi5omOOUAaabXnqh3amiY0nvOm3bihWyGZmuhoSi2LWoQsGb9SUee8mmKsWerY4Jm8LRFh2V1lxbQ8TDYMxTbsAoUEs3vXgicrVsH58h2K/2WaQkfD+wP2NB6DsyvPy3zCMdpua+iESMyXO3EPfoEyZbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1sLTcXm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1sLTcXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710159863; x=1741695863;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=uvc2srdklbEZWRyAUkveO2lIu9fiESGPXlIMmlZAhO4=;
  b=Y1sLTcXmWGgKbtAe6SI93tixrKz49B7qeB3sRoOqYG4I5juRtMCUrY8H
   bGFc5kEQi9MorjChpkEhIX0Fp4o9myLaLAwAV1fVEalNcy6EdvX8180wE
   7k1clj57ZrI/PdIchgVQnPyYtuZJc8N414DU+BxZHcCg7njeQNO2beN1W
   +Ee2F+vhJNtn93sSS8u546s5cZaX0vDnXJ0qy/6SY0jdAdjXXREZZzJcn
   AmzI6whRtfMx3fA6m8YuCu6DAJ3xtXDIYBBqEs62p2Z0VppvMQ6PdWVZI
   Wosa9rZWf7PMS8IT/VZ5+LGJBsiIAIGOW15xMYLHqYe6236zKG1c3wxgY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15956665"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15956665"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11240984"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:24:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 Mar 2024 14:24:11 +0200 (EET)
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
    Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
    Johannes Berg <johannes@sipsolutions.net>, 
    Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Mathieu Poirier <mathieu.poirier@linaro.org>, 
    Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
    Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
    Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org, 
    platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
    linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH vhost v2 0/4] refactor the params of find_vqs()
In-Reply-To: <20240311072113.67673-1-xuanzhuo@linux.alibaba.com>
Message-ID: <576263bc-5e86-5288-7fc5-de214dc622dd@linux.intel.com>
References: <20240311072113.67673-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-925155278-1710159757=:1071"
Content-ID: <c2f52b25-b189-ac04-112b-c9f04d16b66f@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-925155278-1710159757=:1071
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f3d0e1c1-ebcb-baa0-324b-5ca93ffa7301@linux.intel.com>

On Mon, 11 Mar 2024, Xuan Zhuo wrote:

> This pathset is splited from the
>=20
>      http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.ali=
baba.com
>=20
> That may needs some cycles to discuss. But that notifies too many people.
>=20
> But just the four commits need to notify so many people.
> And four commits are independent. So I split that patch set,
> let us review these first.
>=20
> The patch set try to  refactor the params of find_vqs().
> Then we can just change the structure, when introducing new
> features.
>=20
> Thanks.
>=20
> v2:
>   1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen
>=20
> v1:
>   1. fix some comments from ilpo.jarvinen@linux.intel.com
>=20
>=20
> Xuan Zhuo (4):
>   virtio: find_vqs: pass struct instead of multi parameters
>   virtio: vring_create_virtqueue: pass struct instead of multi
>     parameters
>   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
>   virtio_ring: simplify the parameters of the funcs related to
>     vring_create/new_virtqueue()

FWIW,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-925155278-1710159757=:1071--
