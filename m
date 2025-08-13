Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC42E7BAE
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094071; cv=none; b=Lh/bk5hP27YVMSxUSWMpCqZAMWGQfdp53wvFG8XRYJTKewzLiL4xo3YJnI9uzAUXLPGR2KXch56fLUcHCSdkujopQ77warVxoChl+O+iRXxBWFfRO9Mocbdu/KMORDe0Kpuf7kD6LQZrdmMjHleh2R/IT1/4YAAbXaQmGnkaGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094071; c=relaxed/simple;
	bh=JoDDS4LeSQmC1QJQNfeWrK3O8ZAH9lPZgCYUEfL/bKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uZequC9y8XO1uMk3cdx8T/7wUlNCbzZvz0Hc4v8MnEmaak1mr6IIINDqDLtDZceoITR4PziCDPYWWNdGlxcF9cGaBbmBqnnkNQ8b+ibueFBCxljmvTyCNhjEYRN77G3/XVdUSbVpBlVoMDrjzMNZRZqKqrDPXp2UfgGhk860Tpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A0D112FC;
	Wed, 13 Aug 2025 07:07:40 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91DEF3F5A1;
	Wed, 13 Aug 2025 07:07:47 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:07:34 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: cristian.marussi@arm.com
Subject: [REGRESSION] Virtio networking issues on v6.17-rc1
Message-ID: <aJycJvs3xztfD5Rm@pluto>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Not sure if it has been already reported but in a kvmtool/guest setup moving
the guest kernel from v6.16 to v6.17-rc1 I completely lost host-guest network
functionality....in a very funny way, though, I'd say...

In fact NO error is apparently reported in the guest kernel log and the
interfaces seems perfectly up an running both sides, but looking at the
host/guest interfaces you can see that ALL received frames are indeed dropped:


enp0s1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
....
        ether 02:15:15:15:15:15  txqueuelen 1000  (Ethernet)           <<<<<<<<<<<<<<<<
        RX packets 125  bytes 17948 (17.5 KiB)
        RX errors 0  dropped 125 overruns 0  frame 0
        TX packets 1207  bytes 51182 (49.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


...on the host same..(taken later on...)

tap0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.33.1  netmask 255.255.255.0  broadcast 192.168.33.255
        ether 8a:10:f6:df:a1:70  txqueuelen 1000  (Ethernet)
        RX packets 804  bytes 43904 (42.8 KiB)
        RX errors 0  dropped 804  overruns 0  frame 0
        TX packets 101  bytes 14408 (14.0 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

....and for a good reason, apparently, since sniffing around on the Host TAP
interface I can see a never ending stream of:

$ sudo tcpdump -i tap0
listening on tap0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
22:40:42.309158 00:00:00:00:00:00 (oui Ethernet) > 00:00:00:00:00:00 (oui Ethernet), ethertype Unknown (0xffff), length 54:
	0x0000:  ffff ffff 0215 1515 1515 0806 0001 0800  ................       <<<<<<<<<<<<<
	0x0010:  0604 0001 0215 1515 1515 c0a8 2102 0000  ............!...
	0x0020:  0000 0000 c0a8 2101                      ......!.

... DST/SRC Macs are just all zeros WHILE in the payload you can spot my guest
SRC mac address 0215 1515 1515  :P

...or on a different instance:

tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on tap0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
14:57:57.127171 00:00:00:00:00:00 (oui Ethernet) > 00:00:00:00:00:00 (oui Ethernet), ethertype Unknown (0x3333), length 82: 
	0x0000:  0000 0002 0215 1515 1515 86dd 6000 0000  ............`...
	0x0010:  0010 3aff fe80 0000 0000 0000 0015 15ff  ..:.............
	0x0020:  fe15 1515 ff02 0000 0000 0000 0000 0000  ................
	0x0030:  0000 0002 8500 26b0 0000 0000 0101 0215  ......&.........
	0x0040:  1515 1515                                ....

...so it seems the frame is 'shifted' by 10 bytes or more and random
garbage pollutes the Ether frame...

I am using a vanilla kvmtool at:

	ba6830e vfio: include libgen.h (for musl compatibility)

and run with:

	lkvm run -c 4 -m 4G -k $IMAGE_DEF --network virtio -d $ROOTFS_DEF -p "earlycon loglevel=8"

and I could reproduce this on a RaspberryPI_5 with a Host Kernel v6.6 and on an APPLE M1
with Host Kernel v6.12.

Has anybody seen something similar ? Did I miss something obvious ?

...never saw this happening before on any previous kernel version.

Thanks,
Cristian
