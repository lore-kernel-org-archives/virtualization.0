Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E7392B81
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097696; cv=none; b=mkMZSR+YaqiuppCo7/t0frdHwiTYhDXJcedmSaX6JHiB7fcKzxE8M45I/mcyC2Ur6tuifv/VJQsW17IoxjnYWqXgvRxGDoN/lP9blV/GwyYaNCyzwhhAVazBsH+UjzjGX/iJK+tMAm7YpEAtqA1njMKk/+gC0oRgixOsyQAZToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097696; c=relaxed/simple;
	bh=9JzOfqiTFO39kgxFQWVLYY5umNJRQRPCw/NtCy7HzoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmtJLZjibISAXw0llc1jC9QL015GeJRpjCU94tiUB3TGyWIkFAFBmPtGhVVc4KLyIfppb7lJJi5hmTLsgX+K6TfDEjDjIJXA0LbMnjt8P9oydkYALSl88+aTxk39zoxR6MX+6r6wYVrNzCeR4+XyWv+e1FqMIjmeY9dm1FCw24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYF6OI1p; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYF6OI1p"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-648ff033fb2so1268926d50.0
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 08:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097688; x=1769702488; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4nNXaOW8SsH8VsbBiV479RmC0+eq7tMcFo5rcunlQoQ=;
        b=TYF6OI1pn/gc3gjBGJWmQ//Arwj8YNU2WEFXt189DmLWZh1l16YK8a4JQH+rBx1al8
         AswbqgDUDeK1Bi5xwn0UUDjrDG7Sw3HX3vbmcAW49ptOyxc/UFla1uX7/8DliYnPwaXR
         PJZot/5xIcih27p2B4EiLLwb68tHxdaRXuK+FhvpUalLSUL+M/rnPxCMiDlZFFrEwMcV
         7/yMXDW7yZyWi/jEzOR8EZ0M0ZKly1CJbU2u4McTtLFQuiLCc0pm/biVPMVPALYDBu8S
         ufyhRrIGZlNW/TRZNlpJ9tiVMVEt6Zs8ZlsjtkalILqi5p6Cz1K4EkONts6uyyB5IjYk
         WTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097688; x=1769702488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nNXaOW8SsH8VsbBiV479RmC0+eq7tMcFo5rcunlQoQ=;
        b=H5cCLyYMFp9JnK9zTOmAzudD2G4l5Pg7wkD1gi2iKb/2frbWV6pGxzF1sSiegzvCXp
         uTJFDFho7Em+0mbkywEnEDOiPVd4c3F8v1aPNZPCnmHofDZVEfV74JCyZc0VqE+Py0sg
         7SpCCYMRiGydCsTbYv0DL99Nmj6dk/Ugfa2jBxdw5lipVRVu7Dl7BXGZpKKkxmmrx0Sc
         nkkauGW6pmO0UDl+TiMkukxtTYBrSXGJ0vGL07FAwwE0K9Ys2ITkypXncTucXfDIzUqH
         McGvHD9vaAMKKRnfjeOOLhgqhuTyv6EBvPZqbLFM3SzSsibGb8vxQ0uYW+nPhJqfrltm
         Ae2w==
X-Forwarded-Encrypted: i=1; AJvYcCV0QyD3CKxgd7hzTA5Y6aelIbhk1Kjyun5JPXJXGaAh36gmQmgFy4nvfnNMOp6jTha04FrNZ19ycLWEyw/IsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxntdy0zyiSZdAujiy4IhoURHjyrSXH24bwGqiKyr1DbULHDriU
	NoU8wFF4gCLrVk4q+iYrfLkSYBBhgW6uuJu7KiewRQ3QoQ1HLcMWTEC+
X-Gm-Gg: AZuq6aJevnIxQZ/isYHDW3cxOhYP0/55xuzMrIz04stHp1LpVwVgK2LU0CU1IW5ESMP
	2Ln/H8y0zmX+pe1KqaZTDHtPiUpIiQ5XCkXYwX9QMHexoF0n4Vq1mSEbekYQDLnR0n3gUpwSCvj
	ZZK10+zMAwFqUUM0XrXsGDCpbXdeQFxnY6FGgSaPxVpcPAnjpU+oX83ptPkAL/Bns3cS3tMukLv
	xZ3Azcpq4d89OV4ZIM9BIaCdrGtKNv6iX5nJE006G2uzlyQlT0Ic1NVTOYPZE/2/ObnGVAiDWc1
	9hKLlUPyUkXdQO38n32Milgol/uVTysZCosbb5o1n79i5+TtP9mQi8OgPayVDkvVIKRt0t1IBwh
	7IlZpf9wO9qIuhuGm5Kud/eVS3z3caCGTh6D/HdBQpHYbAfLh+Bk5Wq6CWJBI2beHKUZVHf66ac
	Xr/kEa+Hg8akNG4i6xdwuphjQ5oRU3DueH6w==
X-Received: by 2002:a05:690e:d8b:b0:649:4689:c4a9 with SMTP id 956f58d0204a3-6494689c534mr4815658d50.89.1769097685513;
        Thu, 22 Jan 2026 08:01:25 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170acbdbsm9523979d50.13.2026.01.22.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:01:24 -0800 (PST)
Date: Thu, 22 Jan 2026 08:01:23 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v16 00/12] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aXJJ0yjZB5mT162B@devvm11784.nha0.facebook.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
 <aXH7YCgl0qI2dF1T@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXH7YCgl0qI2dF1T@sgarzare-redhat>

On Thu, Jan 22, 2026 at 02:55:36PM +0100, Stefano Garzarella wrote:
> On Wed, Jan 21, 2026 at 02:11:40PM -0800, Bobby Eshleman wrote:
> > This series adds namespace support to vhost-vsock and loopback. It does
> > not add namespaces to any of the other guest transports (virtio-vsock,
> > hyperv, or vmci).
> > 
> > The current revision supports two modes: local and global. Local
> > mode is complete isolation of namespaces, while global mode is complete
> > sharing between namespaces of CIDs (the original behavior).
> > 
> > The mode is set using the parent namespace's
> > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> > created. The mode of the current namespace can be queried by reading
> > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> > has been created.
> > 
> > Modes are per-netns. This allows a system to configure namespaces
> > independently (some may share CIDs, others are completely isolated).
> > This also supports future possible mixed use cases, where there may be
> > namespaces in global mode spinning up VMs while there are mixed mode
> > namespaces that provide services to the VMs, but are not allowed to
> > allocate from the global CID pool (this mode is not implemented in this
> > series).
> > 
> > Additionally, added tests for the new namespace features:
> > 
> > tools/testing/selftests/vsock/vmtest.sh
> > 1..25
> > ok 1 vm_server_host_client
> > ok 2 vm_client_host_server
> > ok 3 vm_loopback
> > ok 4 ns_host_vsock_ns_mode_ok
> > ok 5 ns_host_vsock_child_ns_mode_ok
> > ok 6 ns_global_same_cid_fails
> > ok 7 ns_local_same_cid_ok
> > ok 8 ns_global_local_same_cid_ok
> > ok 9 ns_local_global_same_cid_ok
> > ok 10 ns_diff_global_host_connect_to_global_vm_ok
> > ok 11 ns_diff_global_host_connect_to_local_vm_fails
> > ok 12 ns_diff_global_vm_connect_to_global_host_ok
> > ok 13 ns_diff_global_vm_connect_to_local_host_fails
> > ok 14 ns_diff_local_host_connect_to_local_vm_fails
> > ok 15 ns_diff_local_vm_connect_to_local_host_fails
> > ok 16 ns_diff_global_to_local_loopback_local_fails
> > ok 17 ns_diff_local_to_global_loopback_fails
> > ok 18 ns_diff_local_to_local_loopback_fails
> > ok 19 ns_diff_global_to_global_loopback_ok
> > ok 20 ns_same_local_loopback_ok
> > ok 21 ns_same_local_host_connect_to_local_vm_ok
> > ok 22 ns_same_local_vm_connect_to_local_host_ok
> > ok 23 ns_delete_vm_ok
> > ok 24 ns_delete_host_ok
> > ok 25 ns_delete_both_ok
> > SUMMARY: PASS=25 SKIP=0 FAIL=0
> > 
> > Thanks again for everyone's help and reviews!
> 
> Thank you for your hard work and patience!
> 
> I think we've come up with an excellent solution that's also not too
> invasive.

Thanks, and I appreciate all of the work you and other maintainers put
into this as well! I think we honed in on a great solution too.
> 
> All the patches have my R-b, I've double-checked and tested this v16.
> Everything seems to be working fine (famous last words xD).
> 
> So this series is good to go IMO!
> 
> Next step should be to update the vsock(7) namespace.

Sounds good, I'll follow up with that and CC you + other reviewers that
participated here.

Thanks again,
Bobby
