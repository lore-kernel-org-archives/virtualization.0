Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7A21C9F3
	for <virtualization@lists.linux.dev>; Fri, 18 Apr 2025 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744999085; cv=none; b=ViJ0VUQ4z4P8+Xdi5gey0dOX5e4i/kDjf281uEMTtjbTiBMpYeLSpvzXp8NsocmAMmP6cJUdTyNU92M4IT9U1iMN8GFrRfW24x2DZAuUseln1gw2qFPG2I9VUpYgtY/VDEJkPvZAzRs0jFZ3eTicAqGEMPzqmMCTvZdPLSlFfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744999085; c=relaxed/simple;
	bh=+iuicaO2ZLC9As16m3h2Zjp/ZCP3hJ0WL048subJKIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcTB6+8YbbQBZBACtJxhmzVc+QLZxz8RGbXHtC9pgSwsZyoiv4WUzZ2FNa4duk1tQa0LgP9BJpbQ0oNir/6ejW8hpVb/ILqodNbsCdxjzPX28guA5ueAQEuyBNTfx8FCb+fm9MelsJVCMnbd6uOI/bGBWbSDBiQjdjO6gJHxQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djDQsQ4F; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djDQsQ4F"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so1851909b3a.2
        for <virtualization@lists.linux.dev>; Fri, 18 Apr 2025 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744999083; x=1745603883; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SW+tjIRc0AX+aTZhnNtpBaCEsRQ7numGTe8SeYWYC6s=;
        b=djDQsQ4FwDjc37RO9Qd4wXoaHpvtKuD1suqjfSZPE0XzswTx39cvjGlnXmembrsqCR
         4MFN8oHkS+LXkmspC94dXDXy25N/pEbIlwqMF2D3MOXiXQSQxcxogCA1L0vON/AGTPiI
         cIwW8U2eYXql8hDbEXPLvpy+jCaaoLN27fgeqdtv5fmmPAWHxhLls9Oq7AJEkjsm0Hpa
         qq71BumArZCnDn6vT4urVr9IBf27XGqyXEF/8lsdoUSnwMhbNdk0oaDhwIsD43hQUBkT
         g5F3NKkin0YkwYs7SbezP/DWWt7NtCyi+boyZJ7jvoHJ1xCD2sExp+U8tJZ2+hfReAYL
         s7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744999083; x=1745603883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SW+tjIRc0AX+aTZhnNtpBaCEsRQ7numGTe8SeYWYC6s=;
        b=J7S1OMz1z0crmxk3yId0cAP+CDBatPqGhm2JOgXjUgOhhDBsDoFLN3jOGxCvF4rObu
         67lNNhFSU064YzcE523P7ZF8LRahR2oP1yBcXlk60F2WSCpWJ2VojEECgNRUyzQeL2Uu
         XtxaUs5DXYDOHS1T1tnNSaMjZdKNHi/etbd/F8UKIxlaPcr8uHG5WzfE3/rkyLlOiEEr
         TKNtrzY8uEBXsoVlmMTeByjd72Lxiu+8b/Pfm86M8fRQCuTH4C3lWRAGNEecdvwtAszb
         8q/2TP6k/q/h+XYhab6ZB2ZBImVtvWKgpuY6Dq+h4Bp5aYq+9emEDX6CSgeXpKpxc7Md
         3v4A==
X-Forwarded-Encrypted: i=1; AJvYcCViUw2Xv+5ZOj6NmE6g1zzgVB6jLE08x6z/QvTgyRPWGCvmDxAAamX0iISwPyfvNJJpp+TBtg7gZyhGAtcXbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxw/7qdDZPgO8uWdj0ju6VhROj4LcMfbBK4U1j60qwM/uv0Bt82
	S6WLE2/Bmq49NQlXR4FxKJn8C5PX8rN8QD+WPMd4317aa38oCDHH
X-Gm-Gg: ASbGncvf4CO2ezC1JTkuEYQbRScIKfOiSTnQTYki3jLJFAQtX0MAjJLQwc1uayO7Qs7
	vo9EZ0G63+xXasugwR73H1I6azwX6VO+c1VGolW9KHq30aFK1c6/RBoL9O60phMUu9AdQHbFUoy
	uWdX5sfx7q98mV5f04zwxPNY22r1w85O5N+G5dW9SVoGlA9XyD4SxnJ8AxTPxL6EmVwvsiduu+o
	M3t0KKk59B4Va12MR+Z58nB5W2KIGaLODEJiq443pTOWsRkd8h1lBJrppfEQycMBumShAoQF2CH
	1VEGh5bb8zMrUAPxxIoQ5JKSQqgFYDuIjqatzX7umCxSb18lI1eM4TKl/elmoK4t25giNx0x
X-Google-Smtp-Source: AGHT+IEbgq3jwmjK4u9tvaN1T1FGkQcruTs8eW7QiNt2zXcFuImLwX/xWrVRPy+awAKrid+LehwadA==
X-Received: by 2002:a05:6a00:a91:b0:737:6d4b:f5f8 with SMTP id d2e1a72fcca58-73dc1568775mr4422634b3a.17.1744999082560;
        Fri, 18 Apr 2025 10:58:02 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e46e3sm1954817b3a.59.2025.04.18.10.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:58:01 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:57:52 -0700
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
Message-ID: <aAKSoHQuycz24J5l@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <r6a6ihjw3etlb5chqsb65u7uhcav6q6pjxu65iqpp76423w2wd@kmctvoaywmbu>
 <Z-w47H3qUXZe4seQ@redhat.com>
 <Z+yDCKt7GpubbTKJ@devvm6277.cco0.facebook.com>
 <CAGxU2F7=64HHaAD+mYKYLqQD8rHg1CiF1YMDUULgSFw0WSY-Aw@mail.gmail.com>
 <Z-0BoF4vkC2IS1W4@redhat.com>
 <Z+23pbK9t5ckSmLl@devvm6277.cco0.facebook.com>
 <Z-_ZHIqDsCtQ1zf6@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-_ZHIqDsCtQ1zf6@redhat.com>

On Fri, Apr 04, 2025 at 02:05:32PM +0100, Daniel P. Berrangé wrote:
> On Wed, Apr 02, 2025 at 03:18:13PM -0700, Bobby Eshleman wrote:
> > On Wed, Apr 02, 2025 at 10:21:36AM +0100, Daniel P. Berrangé wrote:
> > > It occured to me that the problem we face with the CID space usage is
> > > somewhat similar to the UID/GID space usage for user namespaces.
> > > 
> > > In the latter case, userns has exposed /proc/$PID/uid_map & gid_map, to
> > > allow IDs in the namespace to be arbitrarily mapped onto IDs in the host.
> > > 
> > > At the risk of being overkill, is it worth trying a similar kind of
> > > approach for the vsock CID space ?
> > > 
> > > A simple variant would be a /proc/net/vsock_cid_outside specifying a set
> > > of CIDs which are exclusively referencing /dev/vhost-vsock associations
> > > created outside the namespace. Anything not listed would be exclusively
> > > referencing associations created inside the namespace.
> > > 
> > > A more complex variant would be to allow a full remapping of CIDs as is
> > > done with userns, via a /proc/net/vsock_cid_map, which the same three
> > > parameters, so that CID=15 association outside the namespace could be
> > > remapped to CID=9015 inside the namespace, allow the inside namespace
> > > to define its out association for CID=15 without clashing.
> > > 
> > > IOW, mapped CIDs would be exclusively referencing /dev/vhost-vsock
> > > associations created outside namespace, while unmapped CIDs would be
> > > exclusively referencing /dev/vhost-vsock associations inside the
> > > namespace. 
> > > 
> > > A likely benefit of relying on a kernel defined mapping/partition of
> > > the CID space is that apps like QEMU don't need changing, as there's
> > > no need to invent a new /dev/vhost-vsock-netns device node.
> > > 
> > > Both approaches give the desirable security protection whereby the
> > > inside namespace can be prevented from accessing certain CIDs that
> > > were associated outside the namespace.
> > > 
> > > Some rule would need to be defined for updating the /proc/net/vsock_cid_map
> > > file as it is the security control mechanism. If it is write-once then
> > > if the container mgmt app initializes it, nothing later could change
> > > it.
> > > 
> > > A key question is do we need the "first come, first served" behaviour
> > > for CIDs where a CID can be arbitrarily used by outside or inside namespace
> > > according to whatever tries to associate a CID first ?
> > 
> > I think with /proc/net/vsock_cid_outside, instead of disallowing the CID
> > from being used, this could be solved by disallowing remapping the CID
> > while in use?
> > 
> > The thing I like about this is that users can check
> > /proc/net/vsock_cid_outside to figure out what might be going on,
> > instead of trying to check lsof or ps to figure out if the VMM processes
> > have used /dev/vhost-vsock vs /dev/vhost-vsock-netns.
> > 
> > Just to check I am following... I suppose we would have a few typical
> > configurations for /proc/net/vsock_cid_outside. Following uid_map file
> > format of:
> > 	"<local cid start>		<global cid start>		<range size>"
> > 
> > 	1. Identity mapping, current namespace CID is global CID (default
> > 	setting for new namespaces):
> > 
> > 		# empty file
> > 
> > 				OR
> > 
> > 		0    0    4294967295
> > 
> > 	2. Complete isolation from global space (initialized, but no mappings):
> > 
> > 		0    0    0
> > 
> > 	3. Mapping in ranges of global CIDs
> > 
> > 	For example, global CID space starts at 7000, up to 32-bit max:
> > 
> > 		7000    0    4294960295
> > 	
> > 	Or for multiple mappings (0-100 map to 7000-7100, 1000-1100 map to
> > 	8000-8100) :
> > 
> > 		7000    0       100
> > 		8000    1000    100
> > 
> > 
> > One thing I don't love is that option 3 seems to not be addressing a
> > known use case. It doesn't necessarily hurt to have, but it will add
> > complexity to CID handling that might never get used?
> 
> Yeah, I have the same feeling that full remapping of CIDs is probably
> adding complexity without clear benefit, unless it somehow helps us
> with the nested-virt scenario to disambiguate L0/L1/L2 CID ranges ?
> I've not thought the latter through to any great level of detail
> though
> 
> > Since options 1/2 could also be represented by a boolean (yes/no
> > "current ns shares CID with global"), I wonder if we could either A)
> > only support the first two options at first, or B) add just
> > /proc/net/vsock_ns_mode at first, which supports only "global" and
> > "local", and later add a "mapped" mode plus /proc/net/vsock_cid_outside
> > or the full mapping if the need arises?
> 
> Two options is sufficient if you want to control AF_VSOCK usage
> and /dev/vhost-vsock usage as a pair. If you want to separately
> control them though, it would push for three options - global,
> local, and mixed. By mixed I mean AF_VSOCK in the NS can access
> the global CID from the NS, but the NS can't associate the global
> CID with a guest.
> 
> IOW, this breaks down like:
> 
>  * CID=N local - aka fully private
> 
>      Outside NS: Can associate outside CID=N with a guest.
>                  AF_VSOCK permitted to access outside CID=N
> 
>      Inside NS: Can NOT associate outside CID=N with a guest
>                 Can associate inside CID=N with a guest
>                 AF_VSOCK forbidden to access outside CID=N
>                 AF_VSOCK permitted to access inside CID=N
> 
> 
>  * CID=N mixed - aka partially shared
> 
>      Outside NS: Can associate outside CID=N with a guest.
>                  AF_VSOCK permitted to access outside CID=N
> 
>      Inside NS: Can NOT associate outside CID=N with a guest
>                 AF_VSOCK permitted to access outside CID=N
>                 No inside CID=N concept
> 
> 
>  * CID=N global - aka current historic behaviour
> 
>      Outside NS: Can associate outside CID=N with a guest.
>                  AF_VSOCK permitted to access outside CID=N
> 
>      Inside NS: Can associate outside CID=N with a guest
>                 AF_VSOCK permitted to access outside CID=N
>                 No inside CID=N concept
> 
> 
> I was thinking the 'mixed' mode might be useful if the outside NS wants
> to retain control over setting up the association, but delegate to
> processes in the inside NS for providing individual services to that
> guest.  This means if the outside NS needs to restart the VM, there is
> no race window in which the inside NS can grab the assocaition with the
> CID
> 
> As for whether we need to control this per-CID, or a single setting
> applying to all CID.
> 
> Consider that the host OS can be running one or more "service VMs" on
> well known CIDs that can be leveraged from other NS, while those other
> NS also run some  "end user VMs" that should be private to the NS.
> 
> IOW, the CIDs for the service VMs would need to be using "mixed"
> policy, while the CIDs for the end user VMs would be "local".
> 

I think this sounds pretty flexible, and IMO adding the third mode
doesn't add much more additional complexity.

Going this route, we have:
- three modes: local, global, mixed
- at first, no vsock_cid_map (local has no outside CIDs, global and mixed have no inside
	CIDs, so no cross-mapping needed)
- only later add a full mapped mode and vsock_cid_map if necessary.

Stefano, any preferences on this vs starting with the restricted
vsock_cid_map (only supporting "0 0 0" and "0 0 <size>")?

I'm leaning towards the modes because it covers more use cases and seems
like a clearer user interface?

To clarify another aspect... child namespaces must inherit the parent's
local. So if namespace P sets the mode to local, and then creates a
child process that then creates namespace C... then C's global and mixed
modes are implicitly restricted to P's local space?

Thanks,
Bobby
