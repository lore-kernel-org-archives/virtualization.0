Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0BB3AE71B
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005363; cv=none; b=MTTJp3zC2z2oJkb4hk/YzmepNz2aOzT8psIwxGlwLFIlK5Qc/UtgCy4741Se5UDmPDHjJk4ivR0AWKgpOfQSYAnC3OctjwiQVa/VmqaReujNju36Xu5cRri46yMdEzrcBZuTpPTCoRToMRCmWE+69QiIFMBOXVRIIJctNv2fKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005363; c=relaxed/simple;
	bh=go5t4J2oCqftUfdoUso726J9QdhgF091WBBQZFq2rJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6g0gXj3g3mxzTBQ3v9y7eJJgJE99tmUxAyaNM5Mjcg4HNtQ8j86RafTwWGzjNIlQquCCgoYzsxjY0r7OBnY1VRFwZT8nMztDzqmYn7E1eSp2LX0umPHLYBG1Mxj30uVdeLh/CVoVJ0mwa02otxGtiI2HLhbbVXClWvURtv3Cv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imMP9pgM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imMP9pgM"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a1462573caso88645ad.0
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769005361; x=1769610161; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Df9DnST7C0sPqC8cKGnMiT7cxfRi0XBTWHY9JjLQ7zk=;
        b=imMP9pgMw3An003kzIKUIZ2p5C1YpTti8hNMZYl735lUCQHEBp2hwvfPNJ5dDF9z11
         LLpXyJOAiABW29XhO4DRJntWqxf8uWaDQ1l5ck98UCp6nV+MZWw9pgAaPcUkWv/VWc4g
         KmJLtEmK26sduHIgbdgEPjTGNVAD1wJdvQ07G8NcSCZqB0fqARHLQqxfXo06Z9KgWOg4
         Mgwe9rDlLZPj8LDjjCwyNzeoWHqOIvorod2tWhqEm7qBxFFDlvb0OQa3FvXvASF9EQsb
         dXaV8JyLDoCyJ0ILTGjLGkpaw92pDPvJy0Vj4zbr2HrRPG8Be6w7leETcgaztiBoB1KQ
         xVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769005361; x=1769610161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Df9DnST7C0sPqC8cKGnMiT7cxfRi0XBTWHY9JjLQ7zk=;
        b=MWRrVx7rKxx1nxWdQHfoyyQ8ILzPEFKPDbsk4zC88Wk6R3Qg1b80WgY/sbdtGscbpd
         vL9ZldgWubU1uOVJq1SMdX4VM2HTDqc6yvFp74HU5AAdJXjVerRwCIFQqkl9cEVtEWSv
         RJ3yKx42AZg52E7xr+S3VwcsSF4BnX2Cq8FsD6+1jiwaoK5aVNEZDDxe6xzFAeNhh3vr
         pQ/xLDsTgcOH3ablMHrg0OC+7MD42DL0sVCh8hWGlaQw5nXcID8pYvKhGiZcKPAThOge
         V1MaoM8Y+Ta+RbVUcCdeC93NmvIgYfVC0A6m5ejlHX8bCYnA7SuffGOKVdg4eNX5mdiP
         SQmA==
X-Forwarded-Encrypted: i=1; AJvYcCXy7EOsuZ6ZNIYlNSRRhjsNDYL3KeNUdm2jY7jj+qbkzZYmvCiRySG040hWYWczBwWGeeLwGk3s79QgnQgnYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH1pJCMkbfqzVLuOE+tHuV88LRjbrmBC4lqVdH7N9IUBcBk3f9
	2U486rytp/5WU9CdOrf74eKloh7CA8PjK0h3J6VTX79PE7piI3VrwniUBhBQ0F7vdA==
X-Gm-Gg: AZuq6aIeTdT+lmf71C0pNz7kSXh1h0iII91KxGF6vZ8wKlR5VE3Ll9XDYxo9XGPUrft
	gEfPtxbEDkQZVVOXPJlJE+DqccarnmUU6Wikhf9GzxxRuYzsqmQOdj3Dzi+REjk3c0ttZpDt9e3
	Dj0qCZ5EpjZ3lodPD8Y9MwHFC7XOX1y4RUCDnS6IASigomvTkweEnU+zeQg1D6bBvbLwkgbq+7V
	8DxhocZBRm2AIoJ/9TSsisATqbnYArCWPFB6lcfeD0NlI1plWLoxS5nh3PSN5EC4Nr8mhTy7bVT
	Mbgz6llRG7oH0oSv3ki4G6lgHHYqSWWNprbMP2pzHWPfr9/OGcXgCmsSJOLu+zEkvBzsaMWrgKG
	6jIRynDRWoIY9WS0FU2OsEWmK9ME+7l/QOLq3FIsHacPH1fBF0MDKDz3/Y+cIj6XhraihdCz8Rx
	Fx/2hFpy7EGy8YqpAobS7HjRYz2KprDFqh3Mf0MH9IXPUUDT6i
X-Received: by 2002:a17:903:1c8:b0:295:5405:46be with SMTP id d9443c01a7336-2a7a23cc8f3mr2519245ad.1.1769005361111;
        Wed, 21 Jan 2026 06:22:41 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce6a9sm159451235ad.34.2026.01.21.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:22:40 -0800 (PST)
Date: Wed, 21 Jan 2026 14:22:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <aXDhJ89Yru577jeY@google.com>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121134712.GZ961572@ziepe.ca>

On Wed, Jan 21, 2026 at 09:47:12AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 02:59:16PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Use the new dma_buf_attach_revocable() helper to restrict attachments to
> > importers that support mapping invalidation.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 5fceefc40e27..85056a5a3faf 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> >  	if (priv->revoked)
> >  		return -ENODEV;
> >  
> > +	if (!dma_buf_attach_revocable(attachment))
> > +		return -EOPNOTSUPP;
> > +
> >  	return 0;
> >  }
> 
> We need to push an urgent -rc fix to implement a pin function here
> that always fails. That was missed and it means things like rdma can
> import vfio when the intention was to block that. It would be bad for
> that uAPI mistake to reach a released kernel.
> 
> It's tricky that NULL pin ops means "I support pin" :|
> 

I've been wondering about this for a while now, I've been sitting on the
following:

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index a4d8f2ff94e4..962bce959366 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1133,6 +1133,8 @@ int dma_buf_pin(struct dma_buf_attachment *attach)

        if (dmabuf->ops->pin)
                ret = dmabuf->ops->pin(attach);
+       else
+               ret = -EOPNOTSUPP;

        return ret;
 }

But didn't get a chance to dive in the history yet. I thought there's a
good reason we didn't have it? Would it break exisitng dmabuf users?

Praan
