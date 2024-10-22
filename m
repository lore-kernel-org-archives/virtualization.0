Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F81A08B2
	for <virtualization@lists.linux.dev>; Tue, 22 Oct 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607049; cv=none; b=oKR+6/JOOeQnqy3uC4pGkbsDrohIpMS2imzAfSoDn62f0BJJB28lY3eg1Pk0Xo18TEhjXUZHyPL70V5l+w/7xXNcMqb3WVdGE89G2cla/pF5pnY6dyO9JjQ3EivH8wyWNRiorcI/btNGJXpUMSXYYn3+oV+O88HHIp3ytlFvsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607049; c=relaxed/simple;
	bh=EhL9si2Aq9wHNWf9k5afcj+BM8ybMHw5TENWRjpVaig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH8l6Rc6wbBOhu0oUgqHyowBsykgtj4U2wXQ/Uk3+rpaU/rocz10jDu8jxL8pObD/Guhccvemnof14tnyxtt2PqWHZgFi5b4yk5FFhLzxkzjI0JowRqCW/3J/sROsHGHDyXCaCownIBX7MGquVU+RtmszbV/k+m/tKus7L44x7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=l1GaSOG8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="l1GaSOG8"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46094b68e30so44289661cf.0
        for <virtualization@lists.linux.dev>; Tue, 22 Oct 2024 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729607046; x=1730211846; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSO/dlnnjdqEtRccDwku+xGxeoL8AGwZjql6S0C/leE=;
        b=l1GaSOG8kuKmTLu2qnVCWaVu6aC1fOohK/Qid/XqNm6J+I0gKw7R28uhBd/Z9TJKaF
         YduIp8+n0+GEOCtJkBYZRBijf+2OdviMC503+SC31Z18FnyYAc912CTIRKT7+va5hvI4
         NDMuQu0WOvdo0yuSV1q9gZmqymI0BG8q7weeqrLFK238QZyaDK/qarH4pcVBSftnpx60
         4MGcMMPsKpIfJDqoyeYaynU/fgF/JkPCCMsOtJP17a4ofoIdPZqcadgk/CQR20nuWL8p
         FCmx4mKQuLKPSeJBE8IjIGsrFo9sqcv4imn3eyarJM4DoHRyNN9NXeTebxcnjyMCA2gd
         J8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607046; x=1730211846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSO/dlnnjdqEtRccDwku+xGxeoL8AGwZjql6S0C/leE=;
        b=PsJ5bblfL9DW7Y2EgUIUs0z8xwff0Do+5SRFVmrUhDx+YocT30hCZE+zyl0QXKbAbi
         rZEMuWgUGHBqv5abdvxdkDj54zR6tEgTpave0rBc5JLIAHQazsS+pcUFObecg5DoruHL
         gzeHM3lkKOJoKbt+Dz1gkiJ3gwB3InPSgvqMgUn6kW4MjoGRIBIEKSOAQSjjJp5V4JmW
         HrrWr7woBzVXfrOiZ9K/1dIB0p9TJ8raaiiHSVx8FhH925MwwsIF8ZooyK5a/KjK8RrV
         4Zqzfas3C610luxZKp3tncLt4tS7449PXqN2m+8+ntezic7LoQ1rdr1W61cUWnwLvGa/
         HRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvJ1iJn6O0qpqhNZ0nRuoNKQCDSR2unDmZiwklhnI258GizyDC4g16akQlpTknrAc6aFWka6ID+S8rvXtClQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFFgQg/kLIKKM9+LIKdbluFImzKksjYH4fmjfycoRV0O1pOAEC
	SP3n1dZ6/1Yv2GjL/qgvRbEcjLqxVaIokg/BoOaApIJmhKsMLrzFdo/HhJS9OhI=
X-Google-Smtp-Source: AGHT+IF5fbaOto1AQAWktpGH/+6Tqp835/6zpFVXMyPZpiyi3+BOxKZkfPeAjgw/eug8GyrAW4p2RQ==
X-Received: by 2002:ac8:5f07:0:b0:460:8f9a:9760 with SMTP id d75a77b69052e-460aed02689mr228595451cf.2.1729607046421;
        Tue, 22 Oct 2024 07:24:06 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3d70a6bsm29593711cf.63.2024.10.22.07.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:24:05 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:24:07 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>, John Groves <John@groves.net>,
	virtualization@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
	qemu-devel@nongnu.org, Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com,
	wangkefeng.wang@huawei.com, John Groves <jgroves@micron.com>,
	Fan Ni <fan.ni@samsung.com>,
	Navneet Singh <navneet.singh@intel.com>,
	=?utf-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <Zxe1h8-E-OcO9cG3@PC2K9PVX.TheFacebook.com>
References: <20240815172223.00001ca7@Huawei.com>
 <fc05d089-ce04-42d2-a0d7-ea32fd73fe90@redhat.com>
 <Zu07AU3aUrHBMXaw@PC2K9PVX.TheFacebook.com>
 <1238f2a3-88a2-4996-92f2-05735801002b@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1238f2a3-88a2-4996-92f2-05735801002b@redhat.com>

On Tue, Oct 22, 2024 at 11:33:07AM +0200, David Hildenbrand wrote:
> On 20.09.24 11:06, Gregory Price wrote:
> 
> > The only concern is when insufficient ZONE_NORMAL exists to support
> > ZONE_MOVABLE capacity - but this is unlikely to be the general scenario AND
> > can be mitigated w/ existing mechanisms.
> 
> It might be worthwhile looking at
> Documentation/admin-guide/mm/memory-hotplug.rst "auto-movable" memory
> onlining polciy. It might not fit all sue cases, though (just like
> ZONE_MOVABLE doesn't)
> 

I managed to miss auto-movable in my last pass through there. Though for
our use-case, forcibly preventing ZONE_NORMAL for all CXL is the preferred
option in an effort to keep as much kernel resources out of high latency
memory.

So I think we're just going to end up using memhp_default_state, and that'll
be mostly fine.

> > 
> > Manually onlined capacity defaults to ZONE_MOVABLE.
> > 
> > It would be nice to make this behavior consistent, since the general opinion
> > appears to be that this capacity should default to ZONE_MOVABLE.
> 
> It's much easier to shoot yourself into the foot with ZONE_MOVABLE, that's
> why the default can be adjusted manually using "online_movable" with e.g.,
> memhp_default_state.
> 
> It's all a bit complicated, because there are various use cases and
> mechanisms for memory hotplug ... IIRC RHEL defaults with its udev rules to
> "ZONE_MOVABLE" on bare metal and "ZONE_NORMAL" in VMs. Except on s390, where
> we default to "offline" (standby memory ....).
> 
> I once worked on a systemd unit to make this configuration easier (and avoid
> udev rules), and possibly more "automatic" depending on the detected
> environment.
>

Appreciate the additional context, thanks!

~Gregory
 
> -- 
> Cheers,
> 
> David / dhildenb
> 
