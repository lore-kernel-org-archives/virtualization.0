Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426AA41B34C
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303527; cv=none; b=iWENfn/aA29u34sMreUtTIBgkpeq0imBLqf73K6p9tXnouhBOPTtf0iIRqs2/U4GCwEN9cPTV5/Jpfn7Ovfbzh0a9kAp1O3bXA1o7gJqlGSBD13FvmYTtE4qRSTvrIQUpbNAePW571W2JFBVVY+XewXfH36dz8EtiLadiZ0VFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303527; c=relaxed/simple;
	bh=r4B2Ie8qQ9e+bddAPy/IrxMyxgCLdGouLxcA6jhMbCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+LDZ8oN/DvGw1SvIw9bl6VLgy8C4rqIjT3crDV6ac9cQEnbgQZUYfR0t4iX/yuHTdkZXteIB3KHWVAI7xR+BUFqXkNlDyrqmF9SxPvWnptR+828+aA8JH8KGZENm9qOAHzhC3NVDq4GmRYFipoyH73nN0wtOxXd9Hua1nKMbZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CcIpH5Pc; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CcIpH5Pc"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a367a1dbbso17929616d6.0
        for <virtualization@lists.linux.dev>; Thu, 05 Feb 2026 06:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770303526; x=1770908326; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6paZ1/dfF6ZJkTrV436UqQ3Veg/Kl0esrhdcHdeVKCQ=;
        b=CcIpH5PcWymgtilkdazIWKNHGP1Cx+HfDfK2IHcFX++a0di4V1B0O2N7iXHGz7Y+YI
         CrYCDN/XgKOorpr+xgTNtPVOLKEeHddlFzRUp1bKTDHPjXHNiUxKyw9cm9QmgdZHR6VR
         A3z9kGx91CCRDGG2MWwCEFdl+sRGloNu99BpAuUbfomp7Vafh8+K6vt80oDnDKeUHPcl
         dQM0BtnOUug/V1AB2W3gXBYTw4Cf/bBjbSSjHCVMySHWqFAAoU/iuiyFgoEq+B3DE4wd
         lQ4wTDvb/9do/jLbVctYbDMVL6n3/wUA34fURSoUvlfnZ9ACzAQ7EBZk35Gkv8LOtOIi
         SHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770303526; x=1770908326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6paZ1/dfF6ZJkTrV436UqQ3Veg/Kl0esrhdcHdeVKCQ=;
        b=tSB9yR441ST4wJM9LTMhl4tCDIEDmg3WVGL6Lv58zLXyaOez31cKd0VxiUmnjSIqxu
         3iKCa7ytgynN56Uh2RXlbO6YHV0hp4HJJYcDMpCYYm4M5bcynBZaeUWrf4wtyrk1B5DH
         MHBMLiNUSmLmRy0ie9M1nCaizYpWrmDltdWqxnWOdrWI9Eo5b/RP+H/QXyo2hmOcnBlD
         RkfRwOrJ6Lrz9BcQbcP5saQ1qzcH6eB44lp6lx6EJB+l9AUAa60zO+rPV7S+m6XkEYgU
         oVug/Z8qt/2l4vdpvJ+lfB24n/ubFGnWlYRC12mYbxGUMsvJSNhCn53l5flTrUISujuj
         8/nA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5GFNy3Cox9Yv0kjAcEbBcblbWEO+6uE+rGtGRhjG7cficnX4TkhkZQbDkbqzMFk9zuwueHJMozin04AbsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ6xP90U98lY/HUoPx94h73xOAg8uRl+j9R/2Pj+TJ4SMjgANJ
	beamP0bJ/PcpUyE0gydoLnj1hJAMUhvy1ReqqXXo0xajc9meektRGc8+YpXrkgu1Q3k=
X-Gm-Gg: AZuq6aJkqF4Pw/LuRm9fay3UAkwss46jxnvqh8sFoW/J3q0deAfWD/98Ad1m0EpVjrd
	Vc1QOLgrozp2oDyKcI3lSVjQjXsVINITex6klba1NYisHxlLp/nWzvTZtcr9xsyzrvezP71H9Mz
	tAhP5HczW6Qinmyk+A76ahms+VroCqY+3+cDfKMIYaaigbNk9CuTtyoFUfArIcVtH7BqaDxKa8s
	rwAZ5HgtK805l0O+iAAYXzk7XlAGXUvn4YMlY/kzVobAZey7PDmM6OCnvv9egto3g4pRxzE0/V2
	pcJz150kuT6jd3N+Lpciw/NZ7unkv012mC5LVMpOK3l4lEbebWTkP4vlLLsdlFDm3epke5LB8Y4
	gnQ65L6/5Azmz//g33gDuCy/JFqXK1TYXE/xUV7hs+xCyKIS9rG+pAf6s3AEveIR9LZF9War3AQ
	3BKewZUiIRVCF1NEwfPeeBv80H4nOhRO17DZcBzdFjKJErANQMJ16ZqCSAin8BDX2b5m0=
X-Received: by 2002:ad4:5bc1:0:b0:894:6d0b:502 with SMTP id 6a1803df08f44-895221eff32mr95805386d6.59.1770303526139;
        Thu, 05 Feb 2026 06:58:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521bffb41sm43278866d6.4.2026.02.05.06.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:58:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vo0of-00000000zky-02N9;
	Thu, 05 Feb 2026 10:58:45 -0400
Date: Thu, 5 Feb 2026 10:58:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Leon Romanovsky <leon@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v7 7/8] vfio: Permit VFIO to work with pinned importers
Message-ID: <20260205145844.GM2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260131-dmabuf-revoke-v7-7-463d956bd527@nvidia.com>
 <fb9bf53a-7962-451a-bac2-c61eb52c7a0f@amd.com>
 <20260204095659.5a983af2@shazbot.org>
 <ac33ad1a-330c-4ab5-bb98-4a4dedccf0da@amd.com>
 <20260205121945.GC12824@unreal>
 <20260205142111.GK2328995@ziepe.ca>
 <f27ad57b-d935-4ffa-a65c-9f6b5d9a1f9a@amd.com>
 <1b7ee5ad-6dde-415a-8e06-93daddc9bcef@app.fastmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b7ee5ad-6dde-415a-8e06-93daddc9bcef@app.fastmail.com>

On Thu, Feb 05, 2026 at 07:41:11AM -0700, Alex Williamson wrote:
> >> From https://anongit.freedesktop.org/git/drm/drm-misc
> >>  * branch                          drm-misc-next -> FETCH_HEAD
> >> 
> >> $ git show FETCH_HEAD
> >> commit 779ec12c85c9e4547519e3903a371a3b26a289de
> >> Author: Alexander Konyukhov <Alexander.Konyukhov@kaspersky.com>
> >> Date:   Tue Feb 3 16:48:46 2026 +0300
> >> 
> >>     drm/komeda: fix integer overflow in AFBC framebuffer size check
> >> 
> >> $ git merge-base  FETCH_HEAD 61ceaf236115f20f4fdd7cf60f883ada1063349a
> >> 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
> >> $ git describe --contains 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
> >> v6.19-rc6^0
> >> 
> >> $ git log --oneline 61ceaf236115f20f4fdd7cf60f883ada1063349a ^FETCH_HEAD
> >> 61ceaf236115f2 vfio: Prevent from pinned DMABUF importers to attach to VFIO DMABUF
> >> 
> >> Just pull Alex's tree, the drm-misc-next tree already has v6.19-rc6,
> >> so all they will see is one extra patch from Alex in your PR.
> >> 
> >> No need to backmerge, this is normal git stuff and there won't be
> >> conflicts when they merge a later Linus tag.
> >
> > Correct, but that would merge the same patch through two different 
> > trees. That is usually a pretty big no-go.
> 
> Applying the patch through two different trees is a no-go, but
> merging the same commit from a shared branch or tag is very common
> and acceptable.  It's the same commit after all, there is no
> conflict, no duplicate commit.  When the trees are merged, the
> commit will exist once in the log.  Thanks,

+1

This is how shared branches work. There is no issue here.

Jason
