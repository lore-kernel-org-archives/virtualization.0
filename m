Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D513C1402
	for <virtualization@lists.linux.dev>; Fri,  1 May 2026 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777655833; cv=none; b=UdpKFkdVAicCQZs4Tygwsg1ONhM24ovno3n3Acxu7+EnqJYaPrBQbd63+JEo+/qiEadw1sLw0wbfo0QUMccmkVJyC+rIhaTrTZjP90jLDTHDrStSrXGiv8A1W99bwwJ2W59D0LdD+fZGhcSy9OESjDjmlQQBNlTo1omUxHd7nfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777655833; c=relaxed/simple;
	bh=xwsp5iLrZTea6MovIEVmsFdqYQsIpNreqjgakR/5M2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHLGPaSMVzUuTLDHwTsAozTwn83JtkIm3LsKyblC+Jp1RKxTxu9LiHSF6gFVZVwZOfJFAhFeJdJ/md998+J49d7dBCU0nYYv4EZgw4at9BHMaEl1B16l+IMqsKJcYdGRakef54W9ZAJ3STn2NA7JGIlwYmpvQUDqFpXyhoBi3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AF2s9JFc; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF2s9JFc"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso1926904e0c.0
        for <virtualization@lists.linux.dev>; Fri, 01 May 2026 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777655828; x=1778260628; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJodchoUfkckB4s8xFgqZ8OCBPEaMXgDR5WFvqCUTds=;
        b=AF2s9JFccESQN1XxZXZd3Zp8FJZG5c1JWN7MSA2ngQYIkuPBss+xJH/Vpw/odEYQU1
         y//KhhediVsoDLKEzkFpHFR/oJdnDqCInF34BKrsqhLKDgBu4C9v4gX2qwxAzGjieXTI
         F+QZpOP4XcHkSLtm9tSzClCb7mq/mzsI4KME9xMZX/BPTA/Z3kMtYtYCS0i4D5vl0C/f
         PPxS4ho9o3iJnW3206maqlU6dZPU4CfKhPqlgBNR11zq2RDEGWYaq0O+/K/qmw5lcmiZ
         t+C6PVPk6cqDyBsctk+pCLy0YzFR553u0lbuqAKH5LYlMmuEeX59GkpFDq8Dxmee5tmn
         IO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777655828; x=1778260628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJodchoUfkckB4s8xFgqZ8OCBPEaMXgDR5WFvqCUTds=;
        b=Y0TrecUYbo3NEokmgnaqvTR7Tsl4V81jmcwhEjtgLI+1xSHkiEUy3xBcVziDCkJk5V
         70tIz6ZdY+S936h0/wSact22TjBrRMddKI5HukT4XR3qMJwcxuBse8nnIqposZmRu43p
         ABz8Yd9cW3pQVebf4DtrYTcNpyIQ8j2fYYZ8n/dOa/TfcDxCgOXsvdBPJBBuLDRZitm6
         v5bMiKSQfJjCJUiOS2pXDIO31kpkpRxp9Vmn/0K1DIpH6XDEQH1x3cdXiGvlmBfWejEZ
         SeGuEUB1A7+x2VXBdVlQLYSfCxmc4LonSjJmvztb5LL8b1/+m4Rvev5NcwRAtSuO4Y/4
         dZiA==
X-Forwarded-Encrypted: i=1; AFNElJ+ToODGIY/wvMkCPsAm0Rb9pTF9KvpbE+nlVZwkwOGsKx9RhYPYYH+IQoubFeF9fD1YIrj7ckSw2EBogCU5SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxH3KtMVhHpbUxQMbt3oTC7YVgtlyW11sl+5IGN7C1TvQmekJP
	KxliXQ0pY9496hbsms/OZmsf6EWunmJ67kXpzeQExr+RgYnVqXksLaC8
X-Gm-Gg: AeBDiess/4iaxh30Es+V7H5qDAsxUz9iyw4eywpf3W5PsPO+zpLve6Q0k8oHEZxMoSK
	Yckar5qbT3hIWyZ+SS/LraHxqypwYKxSbVa4MFFEuJ8TMdpNTmghCncySHNibRMwFtCDV5SITxQ
	btDStD9LB8xrSjYNhiFSBlIr8ilsLyvIzDr28JfW0uVyvBoRVlhpJke0z8sFos5asguYezqQD1e
	9F3Qi/+cT/DzxXK3EH+Ga8jIjEmSakPO9cN/jUC+CzganonOpA/acYIT5xCv/g/D+tSNu7+i1aS
	cK9zqwryMRPe/2Lje0gI6QBgtaQT8N3tzpbf/JVq2T9+wOOTgQNF9eNM6G+YVnPGKxQ2oZyLJtL
	nwEAtvEA+plBs7pY/+UIBeaB3jZFXKFNWUR11Qz1n652SIaZYVRV00PVZt/efn0b4HZnM+PH9M6
	3B5AbFCSbSm+YdrzEOMZZCnd43BgQ6sjiAZ6GKuHdcU4FL/X1rynfTermX3A==
X-Received: by 2002:a05:6122:d27:b0:56d:aa1f:e48a with SMTP id 71dfb90a1353d-5750c701da6mr187767e0c.12.1777655828173;
        Fri, 01 May 2026 10:17:08 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f814:45::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d953sm33669716d6.3.2026.05.01.10.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:17:07 -0700 (PDT)
Date: Fri, 1 May 2026 10:17:03 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf.kernel@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 3/3] net: selftests: add getsockopt_iter
 regression tests
Message-ID: <afTgD99BJQxR8YDc@devvm29614.prn0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
 <20260501-getsock_one-v1-3-810ce23ea70e@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-getsock_one-v1-3-810ce23ea70e@debian.org>

On Fri, May 01, 2026 at 08:52:53AM -0700, Breno Leitao wrote:
> Add a single kselftest covering the proto_ops getsockopt_iter
> conversions for AF_NETLINK and AF_VSOCK, using one fixture per protocol:
> 
> netlink:
> 
> NETLINK_PKTINFO covers the flag-style int path (exact size, oversize
> clamp, undersize -EINVAL); NETLINK_LIST_MEMBERSHIPS covers the
> size-discovery path that always reports the required buffer length back
> via optlen, even when the user buffer is too small to receive any group
> bits.
> 
> vsock:
> SO_VM_SOCKETS_BUFFER_SIZE covers the u64 path (exact size, oversize
> clamp, undersize -EINVAL).
> 
> Each fixture also exercises an unknown optname and a bogus level so
> the returned-length / errno semantics preserved by the sockopt_t
> conversion are pinned down.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

This all looks good to me. My only thought was
SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW/OLD would be a nice add-on for testing
greater than u64, but probably overkill since you already have
NETLINK_LIST_MEMBERSHIPS.

Code all looks reasonable.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  tools/testing/selftests/net/getsockopt_iter.c | 213 ++++++++++++++++++++++++++
>  2 files changed, 214 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index a275ed5840265..baa30287cf222 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -176,6 +176,7 @@ TEST_GEN_PROGS := \
>  	bind_timewait \
>  	bind_wildcard \
>  	epoll_busy_poll \
> +	getsockopt_iter \
>  	icmp_rfc4884 \
>  	ipv6_fragmentation \
>  	proc_net_pktgen \
> diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
> new file mode 100644
> index 0000000000000..179f9e84926fd
> --- /dev/null
> +++ b/tools/testing/selftests/net/getsockopt_iter.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Quick test for getsockopt{_iter} tests.
> + *
> + * Each fixture targets one converted protocol and pins down the
> + * returned-length / errno semantics across buffer-size variations,
> + * an unknown optname and a bogus level.
> + *
> + * - netlink: NETLINK_PKTINFO covers the flag-style int path; the
> + *   NETLINK_LIST_MEMBERSHIPS cases cover the size-discovery path
> + *   that always reports the required buffer length back via optlen,
> + *   even when the user buffer is too small to receive any group bits.
> + * - vsock:   SO_VM_SOCKETS_BUFFER_SIZE covers the u64 path.
> + *
> + * Author: Breno Leitao <leitao@debian.org>
> + */
> +
> +#include <errno.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <linux/netlink.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/vm_sockets.h>
> +#include <sys/socket.h>
> +#include "kselftest_harness.h"
> +
> +#ifndef AF_VSOCK
> +#define AF_VSOCK 40
> +#endif
> +
> +/* ---------- netlink ---------- */
> +
> +FIXTURE(netlink)
> +{
> +	int fd;
> +};
> +
> +FIXTURE_SETUP(netlink)
> +{
> +	int group = RTNLGRP_LINK;
> +
> +	self->fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> +	if (self->fd < 0)
> +		SKIP(return, "AF_NETLINK socket: %s", strerror(errno));
> +
> +	/* Joining a multicast group grows nlk->ngroups so the
> +	 * NETLINK_LIST_MEMBERSHIPS path has a non-zero size to report.
> +	 */
> +	if (setsockopt(self->fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
> +		       &group, sizeof(group)) < 0)
> +		SKIP(return, "NETLINK_ADD_MEMBERSHIP: %s", strerror(errno));
> +}
> +
> +FIXTURE_TEARDOWN(netlink)
> +{
> +	if (self->fd >= 0)
> +		close(self->fd);
> +}
> +
> +TEST_F(netlink, pktinfo_exact)
> +{
> +	int val = -1;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
> +				&val, &optlen));
> +	ASSERT_EQ(sizeof(int), optlen);
> +	ASSERT_TRUE(val == 0 || val == 1);
> +}
> +
> +TEST_F(netlink, pktinfo_oversize_clamped)
> +{
> +	char buf[16] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
> +				buf, &optlen));
> +	ASSERT_EQ(sizeof(int), optlen);
> +}
> +
> +TEST_F(netlink, pktinfo_undersize)
> +{
> +	char buf[2] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
> +				 buf, &optlen));
> +	ASSERT_EQ(EINVAL, errno);
> +}
> +
> +TEST_F(netlink, list_memberships_size_discovery)
> +{
> +	socklen_t optlen = 0;
> +	char dummy;
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK,
> +				NETLINK_LIST_MEMBERSHIPS,
> +				&dummy, &optlen));
> +	ASSERT_GT(optlen, 0);
> +	ASSERT_EQ(0, optlen % sizeof(__u32));
> +}
> +
> +TEST_F(netlink, list_memberships_full_read)
> +{
> +	__u32 buf[64] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK,
> +				NETLINK_LIST_MEMBERSHIPS,
> +				buf, &optlen));
> +	ASSERT_GT(optlen, 0);
> +	ASSERT_LE(optlen, sizeof(buf));
> +	ASSERT_EQ(0, optlen % sizeof(__u32));
> +}
> +
> +TEST_F(netlink, bad_level)
> +{
> +	int val;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, SOL_SOCKET + 1, NETLINK_PKTINFO,
> +				 &val, &optlen));
> +	ASSERT_EQ(ENOPROTOOPT, errno);
> +}
> +
> +TEST_F(netlink, bad_optname)
> +{
> +	int val;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, SOL_NETLINK, 0x7fff,
> +				 &val, &optlen));
> +	ASSERT_EQ(ENOPROTOOPT, errno);
> +}
> +
> +/* ---------- vsock ---------- */
> +
> +FIXTURE(vsock)
> +{
> +	int fd;
> +};
> +
> +FIXTURE_SETUP(vsock)
> +{
> +	self->fd = socket(AF_VSOCK, SOCK_STREAM, 0);
> +	if (self->fd < 0)
> +		SKIP(return, "AF_VSOCK socket: %s", strerror(errno));
> +}
> +
> +FIXTURE_TEARDOWN(vsock)
> +{
> +	if (self->fd >= 0)
> +		close(self->fd);
> +}
> +
> +TEST_F(vsock, buffer_size_exact)
> +{
> +	uint64_t val = 0;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
> +				SO_VM_SOCKETS_BUFFER_SIZE,
> +				&val, &optlen));
> +	ASSERT_EQ(sizeof(uint64_t), optlen);
> +	ASSERT_GT(val, 0);
> +}
> +
> +TEST_F(vsock, buffer_size_oversize_clamped)
> +{
> +	char buf[16] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
> +				SO_VM_SOCKETS_BUFFER_SIZE,
> +				buf, &optlen));
> +	ASSERT_EQ(sizeof(uint64_t), optlen);
> +}
> +
> +TEST_F(vsock, buffer_size_undersize)
> +{
> +	char buf[4] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK,
> +				 SO_VM_SOCKETS_BUFFER_SIZE,
> +				 buf, &optlen));
> +	ASSERT_EQ(EINVAL, errno);
> +}
> +
> +TEST_F(vsock, bad_level)
> +{
> +	uint64_t val;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, SOL_SOCKET + 1,
> +				 SO_VM_SOCKETS_BUFFER_SIZE,
> +				 &val, &optlen));
> +	ASSERT_EQ(ENOPROTOOPT, errno);
> +}
> +
> +TEST_F(vsock, bad_optname)
> +{
> +	uint64_t val;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK, 0x7fff,
> +				 &val, &optlen));
> +	ASSERT_EQ(ENOPROTOOPT, errno);
> +}
> +
> +TEST_HARNESS_MAIN
> 
> -- 
> 2.52.0
> 
