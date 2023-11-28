Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C850255
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dhEQZBE7"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-41cba6e8e65so31401761cf.2
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 14:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701210752; x=1701815552; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXmxZJr3Rk1RKmtjvCLdJSQvKQY1rkK5dlcrmMuZJj4=;
        b=dhEQZBE75HRZ1ozQU8hFhiQHtYFwIdVJ7IQm+965H/NDb7dmGsDgSN6AyjMSmIObdz
         ySzLB30fPax1/QijqGFmSz1VPsh/gf2G08ppdtqJbIenhZlnPe2en8SWZ8hNxObcoYlq
         Lm8FwISQNIZq4JxlQAqxrvMQoEklu1V3cFRHrCdSc7b8hEI4GYZDjwuq0+/YMAuQmE94
         g1UulsqrL/et/vmMWUhBL6xvaMhgtAeR5mq3jam1L8izk4NRzliJUimdN45KbzroghlM
         5Mr2J1u9wsA+k4Oyck7EG9rmJRZiTyq6+SRw0OyUdsldKo8xEBkZTaNBtam72h8y0uxp
         1OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701210752; x=1701815552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXmxZJr3Rk1RKmtjvCLdJSQvKQY1rkK5dlcrmMuZJj4=;
        b=rYp3UcUFPkDvUFny56IFend1v4szM2OgAVP2vBjk5rTtAry/xqfW+d5H2ID99WHtww
         JpR+tTMWV8h3wjiABpDS9S3izksVX3e03Iun4bhhcyEpX31QRtU3KOF5nwlyU74ZuCkS
         T2XP2cxESQGJiUfcpD7wl1P6dnsea88kIXOU0RkOmDq0cYB1ekAGtr9wHl55MvzxlBzB
         1dZ4oYiF/U7UXiVbULRbLifuF18xFNsTfvPxIjNpxOXYqZrhwbTMyTtrjLaBifqtJIA6
         gyU11BnBP0087Dlc/XAgXD2ZCSChFN/DhOGWxZRwVFF0ef4cbRbSPRkB14DcEdShTiZM
         IDiw==
X-Gm-Message-State: AOJu0YxiCHnCKGaNF7bNgpMDMJYhywQ/OFDTdkgCT3KuVRCUHd2rhJtH
	rpqY5fwQDiCBQa0uFyutsgVpwCobC8XMJXGhBk4Yaw==
X-Google-Smtp-Source: AGHT+IGpMWKNhES/9/sulDYyAvK/WWWt51B5qkJu4RoDrGLcGdrRp1qT0nJmPQj10gvcniDpUMl30iZYOH63zrZzia0=
X-Received: by 2002:a05:622a:5da6:b0:423:a0e1:c58f with SMTP id
 fu38-20020a05622a5da600b00423a0e1c58fmr10804025qtb.59.1701210751688; Tue, 28
 Nov 2023 14:32:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com> <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
In-Reply-To: <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 28 Nov 2023 17:31:54 -0500
Message-ID: <CA+CK2bB3nHfu1Z6_6fqN3YTAzKXMiJ12MOWpbs8JY7rQo4Fq0g@mail.gmail.com>
Subject: Re: [PATCH 00/16] IOMMU memory observability
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com, 
	jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com, joro@8bytes.org, 
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com, 
	netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, virtualization@lists.linux.dev, 
	wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 4:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Nov 28, 2023 at 12:49=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > From: Pasha Tatashin <tatashin@google.com>
> >
> > IOMMU subsystem may contain state that is in gigabytes. Majority of tha=
t
> > state is iommu page tables. Yet, there is currently, no way to observe
> > how much memory is actually used by the iommu subsystem.
> >
> > This patch series solves this problem by adding both observability to
> > all pages that are allocated by IOMMU, and also accountability, so
> > admins can limit the amount if via cgroups.
> >
> > The system-wide observability is using /proc/meminfo:
> > SecPageTables:    438176 kB
> >
> > Contains IOMMU and KVM memory.
> >
> > Per-node observability:
> > /sys/devices/system/node/nodeN/meminfo
> > Node N SecPageTables:    422204 kB
> >
> > Contains IOMMU and KVM memory memory in the given NUMA node.
> >
> > Per-node IOMMU only observability:
> > /sys/devices/system/node/nodeN/vmstat
> > nr_iommu_pages 105555
> >
> > Contains number of pages IOMMU allocated in the given node.
>
> Does it make sense to have a KVM-only entry there as well?
>
> In that case, if SecPageTables in /proc/meminfo is found to be
> suspiciously high, it should be easy to tell which component is
> contributing most usage through vmstat. I understand that users can do
> the subtraction, but we wouldn't want userspace depending on that, in
> case a third class of "secondary" page tables emerges that we want to
> add to SecPageTables. The in-kernel implementation can do the
> subtraction for now if it makes sense though.

Hi Yosry,

Yes, another counter for KVM could be added. On the other hand KVM
only can be computed by subtracting one from another as there are only
two types of secondary page tables, KVM and IOMMU:

/sys/devices/system/node/node0/meminfo
Node 0 SecPageTables:    422204 kB

 /sys/devices/system/node/nodeN/vmstat
nr_iommu_pages 105555

KVM only =3D SecPageTables - nr_iommu_pages * PAGE_SIZE / 1024

Pasha

>
> >
> > Accountability: using sec_pagetables cgroup-v2 memory.stat entry.
> >
> > With the change, iova_stress[1] stops as limit is reached:
> >
> > # ./iova_stress
> > iova space:     0T      free memory:   497G
> > iova space:     1T      free memory:   495G
> > iova space:     2T      free memory:   493G
> > iova space:     3T      free memory:   491G
> >
> > stops as limit is reached.
> >
> > This series encorporates suggestions that came from the discussion
> > at LPC [2].
> >
> > [1] https://github.com/soleen/iova_stress
> > [2] https://lpc.events/event/17/contributions/1466
> >
> > Pasha Tatashin (16):
> >   iommu/vt-d: add wrapper functions for page allocations
> >   iommu/amd: use page allocation function provided by iommu-pages.h
> >   iommu/io-pgtable-arm: use page allocation function provided by
> >     iommu-pages.h
> >   iommu/io-pgtable-dart: use page allocation function provided by
> >     iommu-pages.h
> >   iommu/io-pgtable-arm-v7s: use page allocation function provided by
> >     iommu-pages.h
> >   iommu/dma: use page allocation function provided by iommu-pages.h
> >   iommu/exynos: use page allocation function provided by iommu-pages.h
> >   iommu/fsl: use page allocation function provided by iommu-pages.h
> >   iommu/iommufd: use page allocation function provided by iommu-pages.h
> >   iommu/rockchip: use page allocation function provided by iommu-pages.=
h
> >   iommu/sun50i: use page allocation function provided by iommu-pages.h
> >   iommu/tegra-smmu: use page allocation function provided by
> >     iommu-pages.h
> >   iommu: observability of the IOMMU allocations
> >   iommu: account IOMMU allocated memory
> >   vhost-vdpa: account iommu allocations
> >   vfio: account iommu allocations
> >
> >  Documentation/admin-guide/cgroup-v2.rst |   2 +-
> >  Documentation/filesystems/proc.rst      |   4 +-
> >  drivers/iommu/amd/amd_iommu.h           |   8 -
> >  drivers/iommu/amd/init.c                |  91 +++++-----
> >  drivers/iommu/amd/io_pgtable.c          |  13 +-
> >  drivers/iommu/amd/io_pgtable_v2.c       |  20 +-
> >  drivers/iommu/amd/iommu.c               |  13 +-
> >  drivers/iommu/dma-iommu.c               |   8 +-
> >  drivers/iommu/exynos-iommu.c            |  14 +-
> >  drivers/iommu/fsl_pamu.c                |   5 +-
> >  drivers/iommu/intel/dmar.c              |  10 +-
> >  drivers/iommu/intel/iommu.c             |  47 ++---
> >  drivers/iommu/intel/iommu.h             |   2 -
> >  drivers/iommu/intel/irq_remapping.c     |  10 +-
> >  drivers/iommu/intel/pasid.c             |  12 +-
> >  drivers/iommu/intel/svm.c               |   7 +-
> >  drivers/iommu/io-pgtable-arm-v7s.c      |   9 +-
> >  drivers/iommu/io-pgtable-arm.c          |   7 +-
> >  drivers/iommu/io-pgtable-dart.c         |  37 ++--
> >  drivers/iommu/iommu-pages.h             | 231 ++++++++++++++++++++++++
> >  drivers/iommu/iommufd/iova_bitmap.c     |   6 +-
> >  drivers/iommu/rockchip-iommu.c          |  14 +-
> >  drivers/iommu/sun50i-iommu.c            |   7 +-
> >  drivers/iommu/tegra-smmu.c              |  18 +-
> >  drivers/vfio/vfio_iommu_type1.c         |   8 +-
> >  drivers/vhost/vdpa.c                    |   3 +-
> >  include/linux/mmzone.h                  |   5 +-
> >  mm/vmstat.c                             |   3 +
> >  28 files changed, 415 insertions(+), 199 deletions(-)
> >  create mode 100644 drivers/iommu/iommu-pages.h
> >
> > --
> > 2.43.0.rc2.451.g8631bc7472-goog
> >
> >
