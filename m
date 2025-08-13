Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90837242909
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108580; cv=none; b=CKgaKa9P6efqpae4JhcS072KA3OKQf1emr0MjJnJJecWRxzlb8aC58f3Yj6uyw+z74r6j7G4iD5/4ailC4PGXuG9LNQ6wiWtjED/g7Z/6wkueoa1CwIgUiuZQ8VmT53RjpfLb/BoKZWCsQT6K5COllDzQl8y0twUjk40gQgtNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108580; c=relaxed/simple;
	bh=GlDOMdxmLM+PeTrZxZpYeZ2MR1WHL2glQ1Z7w/sIURU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxYKsOdfq8s9oxkZGIudKdE3/8wmHisUni2TEgXPRZdcNXku9B41n3575n5y8azeo971QyR9XMqJHSCdIO7RC4tW7p45ylNoB6h22/weThguc6xV1UXJ3n1Eh1nwoU99Ld/cQEd4UloWXuJe8s7tk48V56BiJ4XaJZDXAVHZecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CCFC12FC;
	Wed, 13 Aug 2025 11:09:27 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A64F33F5A1;
	Wed, 13 Aug 2025 11:09:33 -0700 (PDT)
Date: Wed, 13 Aug 2025 19:09:24 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: cristian.marussi@arm.com, Jason Wang <jasowang@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [REGRESSION] Virtio networking issues on v6.17-rc1
Message-ID: <aJzU1JsV5we-QqgQ@pluto>
References: <aJycJvs3xztfD5Rm@pluto>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJycJvs3xztfD5Rm@pluto>

On Wed, Aug 13, 2025 at 03:07:34PM +0100, Cristian Marussi wrote:
> Hi,
> 

Hi,

> Not sure if it has been already reported but in a kvmtool/guest setup moving
> the guest kernel from v6.16 to v6.17-rc1 I completely lost host-guest network
> functionality....in a very funny way, though, I'd say...
> 
> In fact NO error is apparently reported in the guest kernel log and the
> interfaces seems perfectly up an running both sides, but looking at the
> host/guest interfaces you can see that ALL received frames are indeed dropped:
> 
> 
> enp0s1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
> ....
>         ether 02:15:15:15:15:15  txqueuelen 1000  (Ethernet)           <<<<<<<<<<<<<<<<
>         RX packets 125  bytes 17948 (17.5 KiB)
>         RX errors 0  dropped 125 overruns 0  frame 0
>         TX packets 1207  bytes 51182 (49.9 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> 
> 
> ...on the host same..(taken later on...)
> 
> tap0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet 192.168.33.1  netmask 255.255.255.0  broadcast 192.168.33.255
>         ether 8a:10:f6:df:a1:70  txqueuelen 1000  (Ethernet)
>         RX packets 804  bytes 43904 (42.8 KiB)
>         RX errors 0  dropped 804  overruns 0  frame 0
>         TX packets 101  bytes 14408 (14.0 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> 
> ....and for a good reason, apparently, since sniffing around on the Host TAP
> interface I can see a never ending stream of:
> 
> $ sudo tcpdump -i tap0
> listening on tap0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> 22:40:42.309158 00:00:00:00:00:00 (oui Ethernet) > 00:00:00:00:00:00 (oui Ethernet), ethertype Unknown (0xffff), length 54:
> 	0x0000:  ffff ffff 0215 1515 1515 0806 0001 0800  ................       <<<<<<<<<<<<<
> 	0x0010:  0604 0001 0215 1515 1515 c0a8 2102 0000  ............!...
> 	0x0020:  0000 0000 c0a8 2101                      ......!.
> 
> ... DST/SRC Macs are just all zeros WHILE in the payload you can spot my guest
> SRC mac address 0215 1515 1515  :P
>

I bisected this regression to:

56a06bd40fab64448aa6b84aa06b3dc470c1254a is the first bad commit

commit 56a06bd40fab64448aa6b84aa06b3dc470c1254a
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Jul 8 17:55:02 2025 +0200

    virtio_net: enable gso over UDP tunnel support.
    
    If the related virtio feature is set, enable transmission and reception
    of gso over UDP tunnel packets.
    
    Most of the work is done by the previously introduced helper, just need
    to determine the UDP tunnel features inside the virtio_net_hdr and
    update accordingly the virtio net hdr size.
    
    Acked-by: Jason Wang <jasowang@redhat.com>
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>

 drivers/net/virtio_net.c | 85 ++++++++++++++++++++++++++++++++++++------------

Reverting this commit on top of v6.17-rc1 solves for me and network works fine again.

Thanks,
Cristian
