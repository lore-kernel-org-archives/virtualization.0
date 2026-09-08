Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1B394492;
	Tue,  8 Sep 2026 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852559; cv=none; b=S4tNk8v7du2rANof/YGe0u1fcQa2em4a+UcUUS6YZ/1Fb5TZjy4sDFtVpPSXwHWhSjoaG6R+N/6BjfPoIUuOpQ+iAHJDsc3DKFRBvLi6oFYlNbTCzkA2KmPu5do/6S7bPhgFULc5uAa0gAH/Vmf1acOYsLI3Mjbpib4AYsbJNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852559; c=relaxed/simple;
	bh=tJkqs30o+i74kwpbgxSRT2kQNjeQe8YkmKgxdoAHZDs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=slIQYKBXDbY2sV0t8FzjInyjLFqu+o7GaVHny1HjcBV7x5yYFf1hAs6bGp62epkq0XmZJjeasoLpezI4v2gnDuxa79vVLUwASqu6JMNmDYDxcSBCCo0VhyuqHfpnAv+G6sUU1SeCfnwVe1dXd5MD6rjRepnWm9ojMWEWTJvP9RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMKYyM1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMKYyM1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A141F00A3A;
	Tue,  8 Sep 2026 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788852557;
	bh=ElAtuWbE+yqcbTjG45DzqB3eCUQaFOtLYoirm4N9njk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cMKYyM1iPpJIY5N6wDCaWQhjQkC1WRPngk87DJYRxZr/ecjFYMB9fH71AUIc565tz
	 Qc0n8aKI8aygMWxLeRgSTyUU2Md64eazmD37u+Krw8pKRsM8gfZkmXlFGxJtENH6LH
	 nsJA4ndWPwoKkxQLOrvEmGKOFbhJtLZBnvUDiadSGORtXI8sWU4GLrO35PfTBjorHK
	 jhYoMvmbpzgKNofgx7WOgeKfsfBelPMRwifVBUtg4Wum03OAbPB9N48JK+MFx0jVRI
	 nKrTdQUMo9/Sj+0LpPkP4V/+eCyAbmIPjmiQOf4MZ2iYJMtz5raHLy++60Lhz+1JEO
	 01YWQ++LbRAbQ==
Subject: Re: [PATCH net] selftests/drivers/net: include lib/sh/*.sh
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, jv@jvosburgh.net,
 olteanv@gmail.com, leitao@debian.org, jiri@resnulli.us, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 petrm@nvidia.com, matttbe@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, liuhangbin@kylinos.cn
Date: Tue, 08 Sep 2026 07:29:16 +0000
Message-ID: <178885255602.219967.561231920123759325@kernel.org>
In-Reply-To: <20260907-selftest_lib_defer-v1-1-8af94645aaa3@kylinos.cn>
References: <20260907-selftest_lib_defer-v1-1-8af94645aaa3@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Incomplete fix:
  `tools/testing/selftests/drivers/net/netdevsim/Makefile` is the only…

--

selftests/drivers/net: include lib/sh/*.sh

This adds $(wildcard ../../net/lib/sh/*.sh) to TEST_INCLUDES in the
drivers/net selftest Makefiles so that net/lib/sh/defer.sh gets installed
by "make install", and sorts the TEST_INCLUDES lists while at it.

> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index d5bf4cb638a8c..ab39c2e508f0a 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -3,6 +3,7 @@ CFLAGS += $(KHDR_INCLUDES)
>  
>  TEST_INCLUDES := $(wildcard lib/py/*.py) \
>  		 $(wildcard lib/sh/*.sh) \
> +		 $(wildcard ../../net/lib/sh/*.sh) \
>  		 ../../net/lib.sh \
>  
>  TEST_GEN_FILES := \

[Severity: Medium]
Was drivers/net/netdevsim intentionally left out?  It is the only Makefile
under tools/testing/selftests/drivers/net/ that this patch does not touch,
and it defines no TEST_INCLUDES at all:

tools/testing/selftests/drivers/net/netdevsim/Makefile:
	TEST_PROGS := \
		devlink.sh \
		...
		peer.sh \
		...
	# end of TEST_PROGS

	TEST_FILES := \
		ethtool-common.sh
	# end of TEST_FILES

	include ../../../lib.mk

Its installed scripts do consume the net shell libraries.  peer.sh does:

	lib_dir=$(dirname $0)/../../../net
	source $lib_dir/lib.sh

and devlink.sh, devlink_in_netns.sh, devlink_trap.sh, fib.sh,
fib_notifications.sh, hw_stats_l3.sh, nexthop.sh and psample.sh do:

	lib_dir=$(dirname $0)/../../../net/forwarding
	source $lib_dir/lib.sh

which reaches net/lib.sh, and that unconditionally sources defer.sh:

tools/testing/selftests/net/lib.sh:
	net_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
	source "$net_dir/lib/sh/defer.sh"

There is also no automatic fallback for this target, since the top-level
Makefile only matches the exact strings net, drivers/net and
drivers/net/hw:

tools/testing/selftests/Makefile:
	# Networking tests want the net/lib target, include it automatically
	ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
	ifeq ($(filter net/lib,$(TARGETS)),)
		INSTALL_DEP_TARGETS := net/lib
	endif
	endif

So does the failure quoted in the changelog still reproduce with:

	make INSTALL_PATH=/tmp/kself TARGETS=drivers/net/netdevsim \
		-C tools/testing/selftests install

The commit message says the patch "adds a wildcard to include all shell
files for drivers/net tests that consume net lib.sh" — should that claim be
narrowed, or netdevsim covered too?

Note the gap in netdevsim is wider than defer.sh: adding only
$(wildcard ../../../net/lib/sh/*.sh) would not be enough, since
../../../net/lib.sh and ../../../net/forwarding/lib.sh are not installed
either (plus devlink_lib.sh, fib_offload_lib.sh and tc_common.sh, which
several of those scripts source).

For reference, drivers/net/dsa is also not in the default TARGETS list and
this patch does cover it, and drivers/net/{mlxsw,ocelot,microchip} have no
Makefile so they are not installable targets at all.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907-selftest_lib_defer-v1-1-8af94645aaa3%40kylinos.cn
