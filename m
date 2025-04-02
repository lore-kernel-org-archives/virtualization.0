Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C871F4168
	for <virtualization@lists.linux.dev>; Wed,  2 Apr 2025 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743632907; cv=none; b=Zq/6Mya/yTg81sH4RDT/KVfMQbdx24XHyjFww7uiCLINGfmKesRUAeCDWY4PriDSP4HsFplPgytGMi2Msr7XH/OBqkp7StGDVqJQFstSErL7sAsg17ABHRPTwIL6KeDx2147AC16KGVwAim+wRc5l9aS19DXCUQOaOMmw5FZIG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743632907; c=relaxed/simple;
	bh=0OpwP0nOVkqFr1A9xs6Ac/M4Q6N13WihMhL0PnP1Z6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgyub1TaRQdAOv6KkuNW8qdaUEjnauxfOXoXKol4DBCshcMNuW3filSfoe92p4EdbIEyj87m4kPV27LARLiL1JWNHYhxxIx+66IWzBszmHWRHKNVXqhyFGIsoSDAITj3ni72dw394WTFZVzbEriyDgrLNHzsvjqKJ5zTfNaqVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdZMds1O; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdZMds1O"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224100e9a5cso3173325ad.2
        for <virtualization@lists.linux.dev>; Wed, 02 Apr 2025 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743632905; x=1744237705; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yXllTqI4s65vesFZcUdhMkK73ncFDlJDEPi3mG19ehk=;
        b=LdZMds1O1oBxEqLxUBWGnQGS5n8SkbDPIQjg8F6tUbHZi2cZ2iJqhYKm1WirsS7rwf
         NjvBpfxay3g15m0P/KDahA7h4WJvJPDFZoFkik47tM7nf23oikl0ZZ8yqrl7uQeREY3A
         vzpGxCiC3IdL6GgDqcfOqGzIYcxtbVmShED/+PDr+zS1DeM+4Z7zDnqUeydhXE/8PrEM
         9abpqfhlkkPigY9CtEaiHwQmGF1yH+QvoZ9FtpePSUfhOHLtdAl9mMltCHzNIgXqlJY+
         DqDzHQy7+Gj68iAS78I27FHgvXwb9IYS+yUMjwh28M2+NuNoS2NtCDi1P2mXr+Vq++V7
         GF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743632905; x=1744237705;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXllTqI4s65vesFZcUdhMkK73ncFDlJDEPi3mG19ehk=;
        b=dwOSQHUd2oDr1BVyT4rdkN3wCd9DRg/c82Ztyt4J4a4Un5wMGjonyKs5Q2pRsPhTI+
         FjO5ZcCf3IbkjgYnTNue9iZyyMhRHeC7i0UQao1Nf61eQr4Lh/X2XpF77ZyFF80lfMP8
         FqMa8jQzIiedhcRSRHIVtzEHPtQ6BW8BqlODbzeX5FFkmCvR///+Mu32uSrxZXUmInOV
         Xm19ftBFFXqvnTpKRCFSrUyPsAKwHWGz+096U1tqw7ajkIhTkjR18+nlFpxYo/bLD80Z
         CGMiGSNcQ3b8RIZxdTfJv4ZdfSjcA4NElmGF3DZKfC0Aj2dfOx8fpjpU8xl6hsmDqOXh
         IfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrFu0ld5L743OUVWVAT/wwX+PmQMCpjX8GurggGorpDvLnm9QFuVIdmYqeamTDTWId47wWBJmIP9fC7AhJvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYoWFZrcMvInof6I+OaJrYm1TRvhuxfREu8Kf44Kgnmw1Jzb4h
	OUTTrcaMOOIIeTHIIPmwpGXkQAXm6os+uj3be04Wox+1QaXvfVDT
X-Gm-Gg: ASbGncvQ6M4InE4KHCjAVUDb/H059bqF/vsSFq150CzC9yPujFxUbCCDssKFKNUIcqN
	SSsXZrq7v3Taq0BJaucpSbiMHVAcEoniTrBw9DPurMGZ7zKi8IM/gEsCAx10aVtMA+HdGDXobw5
	AaFLb3Y4v828sAw5d0dpir36oAjEl/v4ncWAQG3NIBaDKnSntWH+91PAxmPoSee7T/UUHyKlu+i
	3YotsJ5NN6q965YmC0gLoDe1A1mzhnt/b50cp/6RISs5sf2zOpe86VRpp70idK+rOcoLw9tJan1
	nT/fXh5OBiq+dVudJ3Vmfc4cdVqnWDL55g1gUpTo8IN7tThgUB1I3jguMTih3nBug6Q=
X-Google-Smtp-Source: AGHT+IEi3/Az0kN6/qk5PEcOPsRQRcT8R3qSFIbNneHvLBHXZk97kL5tuRnk3IdLpKHf2gczG5Szfw==
X-Received: by 2002:a17:902:ecc3:b0:224:826:277f with SMTP id d9443c01a7336-2292f9db08fmr272480865ad.33.1743632904725;
        Wed, 02 Apr 2025 15:28:24 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c015fsm932655ad.56.2025.04.02.15.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 15:28:22 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:28:19 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vsock: add namespace support to vhost-vsock
Message-ID: <Z+26A3sslT+w+wOI@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <r6a6ihjw3etlb5chqsb65u7uhcav6q6pjxu65iqpp76423w2wd@kmctvoaywmbu>
 <Z-w47H3qUXZe4seQ@redhat.com>
 <Z+yDCKt7GpubbTKJ@devvm6277.cco0.facebook.com>
 <CAGxU2F7=64HHaAD+mYKYLqQD8rHg1CiF1YMDUULgSFw0WSY-Aw@mail.gmail.com>
 <Z-0BoF4vkC2IS1W4@redhat.com>
 <Z+23pbK9t5ckSmLl@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z+23pbK9t5ckSmLl@devvm6277.cco0.facebook.com>

On Wed, Apr 02, 2025 at 03:18:13PM -0700, Bobby Eshleman wrote:
> On Wed, Apr 02, 2025 at 10:21:36AM +0100, Daniel P. Berrangé wrote:
> > On Wed, Apr 02, 2025 at 10:13:43AM +0200, Stefano Garzarella wrote:
> > > On Wed, 2 Apr 2025 at 02:21, Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> > > >
> > > > I do like Stefano's suggestion to add a sysctl for a "strict" mode,
> > > > Since it offers the best of both worlds, and still tends conservative in
> > > > protecting existing applications... but I agree, the non-strict mode
> > > > vsock would be unique WRT the usual concept of namespaces.
> > > 
> > > Maybe we could do the opposite, enable strict mode by default (I think 
> > > it was similar to what I had tried to do with the kernel module in v1, I 
> > > was young I know xD)
> > > And provide a way to disable it for those use cases where the user wants 
> > > backward compatibility, while paying the cost of less isolation.
> > 
> > I think backwards compatible has to be the default behaviour, otherwise
> > the change has too high risk of breaking existing deployments that are
> > already using netns and relying on VSOCK being global. Breakage has to
> > be opt in.
> > 
> > > I was thinking two options (not sure if the second one can be done):
> > > 
> > >   1. provide a global sysfs/sysctl that disables strict mode, but this
> > >   then applies to all namespaces
> > > 
> > >   2. provide something that allows disabling strict mode by namespace.
> > >   Maybe when it is created there are options, or something that can be
> > >   set later.
> > > 
> > > 2 would be ideal, but that might be too much, so 1 might be enough. In 
> > > any case, 2 could also be a next step.
> > > 
> > > WDYT?
> > 
> > It occured to me that the problem we face with the CID space usage is
> > somewhat similar to the UID/GID space usage for user namespaces.
> > 
> > In the latter case, userns has exposed /proc/$PID/uid_map & gid_map, to
> > allow IDs in the namespace to be arbitrarily mapped onto IDs in the host.
> > 
> > At the risk of being overkill, is it worth trying a similar kind of
> > approach for the vsock CID space ?
> > 
> > A simple variant would be a /proc/net/vsock_cid_outside specifying a set
> > of CIDs which are exclusively referencing /dev/vhost-vsock associations
> > created outside the namespace. Anything not listed would be exclusively
> > referencing associations created inside the namespace.
> > 
> > A more complex variant would be to allow a full remapping of CIDs as is
> > done with userns, via a /proc/net/vsock_cid_map, which the same three
> > parameters, so that CID=15 association outside the namespace could be
> > remapped to CID=9015 inside the namespace, allow the inside namespace
> > to define its out association for CID=15 without clashing.
> > 
> > IOW, mapped CIDs would be exclusively referencing /dev/vhost-vsock
> > associations created outside namespace, while unmapped CIDs would be
> > exclusively referencing /dev/vhost-vsock associations inside the
> > namespace. 
> > 
> > A likely benefit of relying on a kernel defined mapping/partition of
> > the CID space is that apps like QEMU don't need changing, as there's
> > no need to invent a new /dev/vhost-vsock-netns device node.
> > 
> > Both approaches give the desirable security protection whereby the
> > inside namespace can be prevented from accessing certain CIDs that
> > were associated outside the namespace.
> > 
> > Some rule would need to be defined for updating the /proc/net/vsock_cid_map
> > file as it is the security control mechanism. If it is write-once then
> > if the container mgmt app initializes it, nothing later could change
> > it.
> > 
> > A key question is do we need the "first come, first served" behaviour
> > for CIDs where a CID can be arbitrarily used by outside or inside namespace
> > according to whatever tries to associate a CID first ?
> 
> I think with /proc/net/vsock_cid_outside, instead of disallowing the CID
> from being used, this could be solved by disallowing remapping the CID
> while in use?
> 
> The thing I like about this is that users can check
> /proc/net/vsock_cid_outside to figure out what might be going on,
> instead of trying to check lsof or ps to figure out if the VMM processes
> have used /dev/vhost-vsock vs /dev/vhost-vsock-netns.
> 
> Just to check I am following... I suppose we would have a few typical
> configurations for /proc/net/vsock_cid_outside. Following uid_map file
> format of:
> 	"<local cid start>		<global cid start>		<range size>"
> 
> 	1. Identity mapping, current namespace CID is global CID (default
> 	setting for new namespaces):
> 
> 		# empty file
> 
> 				OR
> 
> 		0    0    4294967295
> 
> 	2. Complete isolation from global space (initialized, but no mappings):
> 
> 		0    0    0
> 
> 	3. Mapping in ranges of global CIDs
> 
> 	For example, global CID space starts at 7000, up to 32-bit max:
> 
> 		7000    0    4294960295
> 	
> 	Or for multiple mappings (0-100 map to 7000-7100, 1000-1100 map to
> 	8000-8100) :
> 
> 		7000    0       100
> 		8000    1000    100
> 
> 
> One thing I don't love is that option 3 seems to not be addressing a
> known use case. It doesn't necessarily hurt to have, but it will add
> complexity to CID handling that might never get used?
> 
> Since options 1/2 could also be represented by a boolean (yes/no
> "current ns shares CID with global"), I wonder if we could either A)
> only support the first two options at first, or B) add just
> /proc/net/vsock_ns_mode at first, which supports only "global" and
> "local", and later add a "mapped" mode plus /proc/net/vsock_cid_outside
> or the full mapping if the need arises?
> 
> This could also be how we support Option 2 from Stefano's last email of
> supporting per-namespace opt-in/opt-out.
> 
> Any thoughts on this?
> 

Stefano,

Would only supporting 1/2 still support the Kata use case?

Thanks,
Bobby
