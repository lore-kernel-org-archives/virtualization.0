Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C518DB29
	for <virtualization@lists.linux.dev>; Thu,  3 Apr 2025 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709378; cv=none; b=bTAgQnQwoDMb3GPKiaRmWgqtD41Zz+a1rf9g5q5IPsUpemhC70mIEu6pdGjvWE6mPSH8Ef+nKyIKLPFDacyyj5+5qyg3zKjkuoYudjsP/760Xil5TPhbsxTIhCMEQlSFTb8RBvhpau/yPOtvCIwl2uK+kk6Q9zsCWKE/LTEpKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709378; c=relaxed/simple;
	bh=OxFQkTUUwkX1q6k8xQRbHlDEFB1zaVhWsRAl9W5U5hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M68zz6J3nmXvrHmte6dGWc6pFepvmWkRjWmImhQVBZyehJ2MnW74JURkO18ibXjwdknpyJ4fsURk3UYjJ4cE6wQ5xSQRfGYtwm6ICFYRjWA3rkZWumP2wPbJWrRE3ACMX5/5YCXmu/8ocxnYMVYziU+hvL36luOpb8B2y1IGY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVD7JF8R; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVD7JF8R"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7398d65476eso1009319b3a.1
        for <virtualization@lists.linux.dev>; Thu, 03 Apr 2025 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743709376; x=1744314176; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dw5EaN/FeaV+PKwcwp5SEhnuatGIwWCjLsFP+3LpIU0=;
        b=MVD7JF8RMyCUi0jmyGvwd1oH0BnFbERyaZHXiCFkFSHMZc9SLRjzYNT8X/PkPf3E96
         kox/5+ozvWjbxi5aqibYWxQ/1LKbZX7HhW1l9TPvlTxF6IrjC063NALcBWm4UNB2HvPm
         DtJlr6D40mx+jnbzGvcJ/NDvjm+FK3xXgb5X8AJ9SHH2nj9MFCgJ44tDsayYCzT+woyr
         e00/u6fImMhBUCWSy2f5xW6DuXs49gPODfmXDmhnI1GwGM6I+dueQMQcvsQavt+LQcfI
         4E052+WIenWUy9YZCTFcsBERzRKR2QpK3JspPH058zOdjUER7xztyCZUqXxmHsuRo6L/
         yMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743709376; x=1744314176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw5EaN/FeaV+PKwcwp5SEhnuatGIwWCjLsFP+3LpIU0=;
        b=To3Ub8FMEkZATH8o2unqZn6pUCQOoEN92hGNKdEhdGrvNYTjKsvqq9HtMNjzCn6whE
         c3GZPieqktOEczj6H0IzAWRBjraoTxogkJl1wMX+uJgWegVx4HKom4leuL9+nUmqob+r
         bvuztJmOhhG6cmER6taZ+FZvdphBDycUItNLzZ3vA5Pwu70FddIJam60m0EyLA1XSZ5E
         oLjFVsAOj1yWmWP34kNDqx+a1RNRUMrMaaVEKhnHB4Bt47Yl3INsl6/LajEZsVP90RTd
         v2G7/ntyD5JfOK3qf4XC5vf2yBxs8ySwAoYoW8M3a83eNoPxYREkcy6Qb3SJZIaUjn8s
         T7fA==
X-Forwarded-Encrypted: i=1; AJvYcCW12D3suTo8Myo5/LfwclQl7/LK+e/heDDf6QKNPlnFPDxHSbKJwBaf2LCBNoPd1ukChePmvxflrAYwuePjBA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyd77rf4O6QBTDPl+HGjcJL7mIORtqOLtpOOttb9aoyZLHAnrZf
	hUSdvts3owomUvT7TEYO3ZuZOtnlkT9BWpIt/l1uiYwtzsHamkyc
X-Gm-Gg: ASbGnctlVS7voSp8DWqik/wjdOWZqyNDYGKloqdB6J4Rc0ql+dOzzyHMjYQ/KvJjjt0
	rz5tGZtMh9HJS0D5mk+WF80y5OoYbg8jkl4qIj4H8NAjzLwsZfMcFVdfGvK2sQyeIs8sslYmyb5
	6QxU1ldq0WnJBP05Rspyx/3VAuxEzXlnX7zk3LwmzJag7JQOhge3DJ9N39I8054ggX0/dWDAR9W
	7Q7ftaQMVmmI62Bgx+ruKraze8Uff0MSv2IruXoC6ZLBBsVN5d3qe8cZwl/zzPEk9pknoodSGqP
	AjJkbGX7bpAmEhFHcAeUxizvAd4kMVFN9zzrvoGjWoLd3Mt+u1K4WojHiYPeGFGQ7JZ/lprub8h
	R
X-Google-Smtp-Source: AGHT+IGTqm5ICR8EBlvvydBUIxaddn+H75GcdEQ/shNDpVkFY10lp50cz3ahcnw+0GlRzFfpgJP+zQ==
X-Received: by 2002:a05:6a00:2e0f:b0:732:706c:c4ff with SMTP id d2e1a72fcca58-739d6457e97mr7220468b3a.7.1743709375559;
        Thu, 03 Apr 2025 12:42:55 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d98064fdsm1897473b3a.84.2025.04.03.12.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:42:54 -0700 (PDT)
Date: Thu, 3 Apr 2025 12:42:46 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
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
Message-ID: <Z+7ktkvIeNbf39D3@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <r6a6ihjw3etlb5chqsb65u7uhcav6q6pjxu65iqpp76423w2wd@kmctvoaywmbu>
 <Z-w47H3qUXZe4seQ@redhat.com>
 <Z+yDCKt7GpubbTKJ@devvm6277.cco0.facebook.com>
 <CAGxU2F7=64HHaAD+mYKYLqQD8rHg1CiF1YMDUULgSFw0WSY-Aw@mail.gmail.com>
 <Z-0BoF4vkC2IS1W4@redhat.com>
 <Z+23pbK9t5ckSmLl@devvm6277.cco0.facebook.com>
 <Z+26A3sslT+w+wOI@devvm6277.cco0.facebook.com>
 <4c2xz3xhpdjvb6jmdw7ctsebpza5lcs4gevr5wlwwyt64usr2i@o5qt2msfyvvw>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c2xz3xhpdjvb6jmdw7ctsebpza5lcs4gevr5wlwwyt64usr2i@o5qt2msfyvvw>

On Thu, Apr 03, 2025 at 11:33:14AM +0200, Stefano Garzarella wrote:
> On Wed, Apr 02, 2025 at 03:28:19PM -0700, Bobby Eshleman wrote:
> > On Wed, Apr 02, 2025 at 03:18:13PM -0700, Bobby Eshleman wrote:
> > > On Wed, Apr 02, 2025 at 10:21:36AM +0100, Daniel P. Berrangé wrote:
> > > > On Wed, Apr 02, 2025 at 10:13:43AM +0200, Stefano Garzarella wrote:
> > > > > On Wed, 2 Apr 2025 at 02:21, Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> > > > > >
> > > > > > I do like Stefano's suggestion to add a sysctl for a "strict" mode,
> > > > > > Since it offers the best of both worlds, and still tends conservative in
> > > > > > protecting existing applications... but I agree, the non-strict mode
> > > > > > vsock would be unique WRT the usual concept of namespaces.
> > > > >
> > > > > Maybe we could do the opposite, enable strict mode by default (I think
> > > > > it was similar to what I had tried to do with the kernel module in v1, I
> > > > > was young I know xD)
> > > > > And provide a way to disable it for those use cases where the user wants
> > > > > backward compatibility, while paying the cost of less isolation.
> > > >
> > > > I think backwards compatible has to be the default behaviour, otherwise
> > > > the change has too high risk of breaking existing deployments that are
> > > > already using netns and relying on VSOCK being global. Breakage has to
> > > > be opt in.
> > > >
> > > > > I was thinking two options (not sure if the second one can be done):
> > > > >
> > > > >   1. provide a global sysfs/sysctl that disables strict mode, but this
> > > > >   then applies to all namespaces
> > > > >
> > > > >   2. provide something that allows disabling strict mode by namespace.
> > > > >   Maybe when it is created there are options, or something that can be
> > > > >   set later.
> > > > >
> > > > > 2 would be ideal, but that might be too much, so 1 might be enough. In
> > > > > any case, 2 could also be a next step.
> > > > >
> > > > > WDYT?
> > > >
> > > > It occured to me that the problem we face with the CID space usage is
> > > > somewhat similar to the UID/GID space usage for user namespaces.
> > > >
> > > > In the latter case, userns has exposed /proc/$PID/uid_map & gid_map, to
> > > > allow IDs in the namespace to be arbitrarily mapped onto IDs in the host.
> > > >
> > > > At the risk of being overkill, is it worth trying a similar kind of
> > > > approach for the vsock CID space ?
> > > >
> > > > A simple variant would be a /proc/net/vsock_cid_outside specifying a set
> > > > of CIDs which are exclusively referencing /dev/vhost-vsock associations
> > > > created outside the namespace. Anything not listed would be exclusively
> > > > referencing associations created inside the namespace.
> > > >
> > > > A more complex variant would be to allow a full remapping of CIDs as is
> > > > done with userns, via a /proc/net/vsock_cid_map, which the same three
> > > > parameters, so that CID=15 association outside the namespace could be
> > > > remapped to CID=9015 inside the namespace, allow the inside namespace
> > > > to define its out association for CID=15 without clashing.
> > > >
> > > > IOW, mapped CIDs would be exclusively referencing /dev/vhost-vsock
> > > > associations created outside namespace, while unmapped CIDs would be
> > > > exclusively referencing /dev/vhost-vsock associations inside the
> > > > namespace.
> > > >
> > > > A likely benefit of relying on a kernel defined mapping/partition of
> > > > the CID space is that apps like QEMU don't need changing, as there's
> > > > no need to invent a new /dev/vhost-vsock-netns device node.
> > > >
> > > > Both approaches give the desirable security protection whereby the
> > > > inside namespace can be prevented from accessing certain CIDs that
> > > > were associated outside the namespace.
> > > >
> > > > Some rule would need to be defined for updating the /proc/net/vsock_cid_map
> > > > file as it is the security control mechanism. If it is write-once then
> > > > if the container mgmt app initializes it, nothing later could change
> > > > it.
> > > >
> > > > A key question is do we need the "first come, first served" behaviour
> > > > for CIDs where a CID can be arbitrarily used by outside or inside namespace
> > > > according to whatever tries to associate a CID first ?
> > > 
> > > I think with /proc/net/vsock_cid_outside, instead of disallowing the CID
> > > from being used, this could be solved by disallowing remapping the CID
> > > while in use?
> > > 
> > > The thing I like about this is that users can check
> > > /proc/net/vsock_cid_outside to figure out what might be going on,
> > > instead of trying to check lsof or ps to figure out if the VMM processes
> > > have used /dev/vhost-vsock vs /dev/vhost-vsock-netns.
> 
> Yes, although the user in theory should not care about this information,
> right?
> I mean I don't even know if it makes sense to expose the contents of
> /proc/net/vsock_cid_outside in the namespace.
> 
> > > 
> > > Just to check I am following... I suppose we would have a few typical
> > > configurations for /proc/net/vsock_cid_outside. Following uid_map file
> > > format of:
> > > 	"<local cid start>		<global cid start>		<range size>"
> 
> This seems to relate more to /proc/net/vsock_cid_map, for
> /proc/net/vsock_cid_outside I think 2 parameters are enough
> (CID, range), right?
> 

True, yes vsock_cid_map.

> > > 
> > > 	1. Identity mapping, current namespace CID is global CID (default
> > > 	setting for new namespaces):
> > > 
> > > 		# empty file
> > > 
> > > 				OR
> > > 
> > > 		0    0    4294967295
> > > 
> > > 	2. Complete isolation from global space (initialized, but no mappings):
> > > 
> > > 		0    0    0
> > > 
> > > 	3. Mapping in ranges of global CIDs
> > > 
> > > 	For example, global CID space starts at 7000, up to 32-bit max:
> > > 
> > > 		7000    0    4294960295
> > > 	
> > > 	Or for multiple mappings (0-100 map to 7000-7100, 1000-1100 map to
> > > 	8000-8100) :
> > > 
> > > 		7000    0       100
> > > 		8000    1000    100
> > > 
> > > 
> > > One thing I don't love is that option 3 seems to not be addressing a
> > > known use case. It doesn't necessarily hurt to have, but it will add
> > > complexity to CID handling that might never get used?
> 
> Yes, as I also mentioned in the previous email, we could also do a
> step-by-step thing.
> 
> IMHO we can define /proc/net/vsock_cid_map (with the structure you just
> defined), but for now only support 1-1 mapping (with the ranges of
> course, I mean the first two parameters should always be the same) and
> then add option 3 in the future.
> 

makes sense, sgtm!

> > > 
> > > Since options 1/2 could also be represented by a boolean (yes/no
> > > "current ns shares CID with global"), I wonder if we could either A)
> > > only support the first two options at first, or B) add just
> > > /proc/net/vsock_ns_mode at first, which supports only "global" and
> > > "local", and later add a "mapped" mode plus /proc/net/vsock_cid_outside
> > > or the full mapping if the need arises?
> 
> I think option A is the same as I meant above :-)
> 

Indeed.

> > > 
> > > This could also be how we support Option 2 from Stefano's last email of
> > > supporting per-namespace opt-in/opt-out.
> 
> Hmm, how can we do it by namespace? Isn't that global?
> 

I think the file path is global but the contents are tied per-namespace,
according to the namespace of the process that called open() on it.
This way the container mgr can write-once lock it, and the namespace
processes can read it?

> > > 
> > > Any thoughts on this?
> > > 
> > 
> > Stefano,
> > 
> > Would only supporting 1/2 still support the Kata use case?
> 
> I think so, actually I was thinking something similar in the message I just
> sent.
> 
> By default (if the file is empty), nothing should change, so that's fine
> IMO. As Paolo suggested, we absolutely have to have tests to verify these
> things.
> 

Sounds like a plan! I'm working on the new vsock vmtest now and will
include the new tests in the next rev.

Also, I'm thinking we should protect vsock_cid_map behind a capability,
but I'm not sure which one is correct (CAP_NET_ADMIN?). WDYT?

Thanks!
