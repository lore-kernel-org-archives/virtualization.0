Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81B41F7F2
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855979; cv=none; b=UXbaixOQ3xGPKgc2s8S0xyngwoYXvpT5SIp1s/kqXoDS5z7P/9siiUnRkjxTBZms2WAhHd4jRPbzUnoxzkBzAJbb9Y9rpXYCezghH9O21VqgI/bb5lGGOmQYsRSCYAfDMYhKRzihd8dD363A5Z8/WLMQOcjJXFOwkKpK7S5lMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855979; c=relaxed/simple;
	bh=/BXFWZN5Xa4s/xdgxF2eJ8EqBcoHNX0gRRmhWnwa3lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9zBkAylB9Pu2cy1E+XogsniQvOLuZKctU7RKVu9RoTowEBaVBXPecsXh9pQn0Xv94VsZCYdpjRPoiWUEYxpxYwiHvYTsK3dEhTKrVhQTKLv7CLakzFwHArIRTPcOzExve9nx2t+ijl9jAg4k6Ba43uYv8QW5YXm6di2BQSYNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qqdS3cKR; arc=none smtp.client-ip=95.215.58.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qqdS3cKR"
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=/BXFWZN5Xa4s/xdgxF2eJ8EqBcoHNX0gRRmhWnwa3lg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788855975; v=1; x=1789460775;
 b=qqdS3cKRHFjpEDFqtrMh/m8R53vKK7AbbbzqZ6dsTrcFdLLBmi/3TLUPCb8boKYcLo62Z9KH
 BmRWlOLLnX4maU7fwE58nsSfmywjCeUyoIxtyNprSHhSnZqroTuiAU12GFIO9LXaHEacARKTfKC
 2omg2Fks52VC+AEW11ahMiaA=
X-Envelope-To: virtualization@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id d5be76637a52d664;
	Tue, 08 Sep 2026 08:26:14 +0000
X-Mizu-Trace-ID: d5be76637a52d664
X-Migadu-Flow: FLOW_OUT
Date: Tue, 8 Sep 2026 16:26:02 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	jv@jvosburgh.net, olteanv@gmail.com, leitao@debian.org,
	jiri@resnulli.us, mst@redhat.com, jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, petrm@nvidia.com,
	matttbe@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] selftests/drivers/net: include lib/sh/*.sh
Message-ID: <ap_GmmpU95LQvzTC@fedora>
References: <20260907-selftest_lib_defer-v1-1-8af94645aaa3@kylinos.cn>
 <178885255602.219967.561231920123759325@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178885255602.219967.561231920123759325@kernel.org>

On Tue, Sep 08, 2026 at 07:29:16AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] Incomplete fix:
>   `tools/testing/selftests/drivers/net/netdevsim/Makefile` is the only…
> 
> --
> 
> selftests/drivers/net: include lib/sh/*.sh
> 
> This adds $(wildcard ../../net/lib/sh/*.sh) to TEST_INCLUDES in the
> drivers/net selftest Makefiles so that net/lib/sh/defer.sh gets installed
> by "make install", and sorts the TEST_INCLUDES lists while at it.
> 
> > diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> > index d5bf4cb638a8c..ab39c2e508f0a 100644
> > --- a/tools/testing/selftests/drivers/net/Makefile
> > +++ b/tools/testing/selftests/drivers/net/Makefile
> > @@ -3,6 +3,7 @@ CFLAGS += $(KHDR_INCLUDES)
> >  
> >  TEST_INCLUDES := $(wildcard lib/py/*.py) \
> >  		 $(wildcard lib/sh/*.sh) \
> > +		 $(wildcard ../../net/lib/sh/*.sh) \
> >  		 ../../net/lib.sh \
> >  
> >  TEST_GEN_FILES := \
> 
> [Severity: Medium]
> Was drivers/net/netdevsim intentionally left out?  It is the only Makefile
> under tools/testing/selftests/drivers/net/ that this patch does not touch,
> and it defines no TEST_INCLUDES at all:
> 
> tools/testing/selftests/drivers/net/netdevsim/Makefile:
> 	TEST_PROGS := \
> 		devlink.sh \
> 		...
> 		peer.sh \
> 		...
> 	# end of TEST_PROGS
> 
> 	TEST_FILES := \
> 		ethtool-common.sh
> 	# end of TEST_FILES
> 
> 	include ../../../lib.mk

Yes, netdevsim doesn't have TEST_INCLUDES at all. I think it deserves
its own separate patch.

Thanks
Hangbin
