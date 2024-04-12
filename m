Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB83F9E0
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954823; cv=none; b=HQ8uzblWmT9ApDhBcaedAfOB4+t/gQfZ7XMEpmGXkMigp97w+AZtGt61E2EJv/OJ4CYLbXD3h3P3HSdJ9kVdaLxwEhZRLVwIvD2DCm8sKuBibKJuj6yEWLRVfZw59lDp83toCU+OARDsh421p1kB9YG24GOhqFJfKiOdAQJ1FTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954823; c=relaxed/simple;
	bh=YbDtsX6Bxnl33uhn4lJTpEdXyZqFprD4LyrXiZo/sBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+HGYyRbObI/b76ciGAknwq5hMybKdYqwhjOpt3H/6LgDoFIA0rYIgzCK5MR+oqYkqr9kdCJlXyqU5OiAEWn9PyoJL13EQ03NM1WZ1wDKuj6gc5ASaNSkaT7TJMr2agLQbCBjHR6kBBt06bGUep6zDWLQs13mSWjealwQSOotrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4qGRmHM; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4qGRmHM"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4dac4791267so515442e0c.1
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712954820; x=1713559620; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8KmL2nyn4jWlGFSn8KqIuSl3GHAumDP1gAvaqPxNDoQ=;
        b=Z4qGRmHM3pqsCPcXEPQ2mcKaRxK4ipV05q3VG2TEQwAWxoAn4wh02kzOuxfNfwHwos
         Qw21Z0J5HwTWki69vC5AB8bh1Mm+PwbHAOPFJCsCwIaDWQvlLEy+R7rq8aZxcbM3jFh1
         XjgSbolWNyWgxq42RXUiPsoBjFjROASP6Mjlm3GDg5yyZe7GkzPjU85MqU4NoofJT6sc
         Y8xyHthvGy65/HwcjFfbu49K0n1QGm1uT0OVo/Os9UwLvFz+sKI9dvGgab1OGhCu4Gmi
         OC95D7X50TnireiLFR94xD7oIPfin06zIBfZR9n/9BW5NgmfBccHuSs8Syfhp23SkBlL
         GbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954820; x=1713559620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KmL2nyn4jWlGFSn8KqIuSl3GHAumDP1gAvaqPxNDoQ=;
        b=kQ5nRwjTIvmo20oeUT4ee5IbnpnvOEfVVyQlE/PsSle3bUVojuD7Q50dw6mAZIJ8Zr
         C9P/jxpNNMlW3RR1PskcOM7hcD80hlUnS/F9KzbINLBSCkbu6jtVJkrNQfHNcWJM6OD3
         YQrDemw4RIueQpqGSl+4Ga/3HBx5HIhidHLIAl6eI0bYIzDhULiti3Apgl9CC2JmdMF1
         jHBeytirg5JAxgAbzJyLBGGrioh5JUj28VRf/dqAxfJxNFH2CPVqa//n/RqTR4IU1Bts
         pUEnOvUqufBzgRn1X1hSfsyoEQyZzUUCwz2brQAgoTabvL8KyGZDc+WmcAbhHEZpvLjf
         wUiA==
X-Forwarded-Encrypted: i=1; AJvYcCWs251rzj5HA1cssKRbpY9N+Bj/Yl+wuogbOW8h7KGx1kD0qTj3iXba8KnStn3r/jjFWhCAnF+exRBMz80Bp5gzQTajBGse6mtbsSuMiXs=
X-Gm-Message-State: AOJu0YyFXyp45t6nDDovRyrTIuApwEeoVNFHJw2eb5P1/DCdhm8C+r6I
	bJNtJ86lZ+yHeRBan0xT2SVlAK8uHFVB2vnwKhUQ7GKKOeJP4/rL
X-Google-Smtp-Source: AGHT+IHM2miLX2tcVafyyhzFoWw8So4ETDOFnSZdLf8WCGGhlntQHz7m+UVucs06+uQ1URBh6HdI1A==
X-Received: by 2002:a05:6122:2221:b0:4d4:32e1:e7b4 with SMTP id bb33-20020a056122222100b004d432e1e7b4mr3944460vkb.4.1712954820361;
        Fri, 12 Apr 2024 13:47:00 -0700 (PDT)
Received: from localhost ([142.169.16.165])
        by smtp.gmail.com with ESMTPSA id ee2-20020a0562140a4200b0069b5839d26dsm1276761qvb.9.2024.04.12.13.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:47:00 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:46:58 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 6/6] selftests: virtio_net: add initial tests
Message-ID: <ZhmdwiGi-r6eDyB-@f4>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-7-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412151314.3365034-7-jiri@resnulli.us>

On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Introduce initial tests for virtio_net driver. Focus on feature testing
> leveraging previously introduced debugfs feature filtering
> infrastructure. Add very basic ping and F_MAC feature tests.
> 
> To run this, do:
> $ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests
> 
> Run it on a system with 2 virtio_net devices connected back-to-back
> on the hypervisor.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/drivers/net/virtio_net/Makefile |   5 +
>  .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
>  .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
>  create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 6dab886d6f7a..a8e40599c65f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -20,6 +20,7 @@ TARGETS += drivers/s390x/uvdevice
>  TARGETS += drivers/net
>  TARGETS += drivers/net/bonding
>  TARGETS += drivers/net/team
> +TARGETS += drivers/net/virtio
>  TARGETS += dt
>  TARGETS += efivarfs
>  TARGETS += exec
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
> new file mode 100644
> index 000000000000..c6edf5ddb0e4
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0+ OR MIT
> +
> +TEST_PROGS = basic_features.sh
> +
> +include ../../../lib.mk

Makefile is missing something like

TEST_FILES = \
	virtio_net_common.sh \
	#

TEST_INCLUDES = \
	../../../net/forwarding/lib.sh \
	../../../net/lib.sh \
	#

Without those, these files are missing when exporting the tests, such as
with:

cd tools/testing/selftests/
make install TARGETS=drivers/net/virtio_net/
./kselftest_install/run_kselftest.sh
