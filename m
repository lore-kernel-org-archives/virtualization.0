Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007522FD7B8
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119109; cv=none; b=kf9/6GbcIU40hSsbT4XP3oKPMuLb9QlYHoh6tSB3vsYqS/zq2ryi3T067NdqISPIksYnOSzAeCf5GeVcMUA/GgMUx+Sj3Ux7e0oBqoYEutplQRmqxiP7VKN9zepwHi099jQP/6iMbbWV3vkBdBQM7o/bLz4SBF6M5MUgvi0np1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119109; c=relaxed/simple;
	bh=XOXbOQPhfVD/dCaWCxaCyMMo0br8RlwPHVIRqyoU28E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHEaOh5gpVnx6Gh06MUO++TIMrvIJMlS+0e7UKaO/xHOoRU+UffcU1d6LQ+4KEK7iwVK5sgENWPP6NMmHGSOLPKxjTnVYz2bZELY8OGjz6oUr133Xno4MKYKdereRNYYhr8Lk11xvrNmvNWNuRsgwJLvVny81cCaYJbL90750/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ECB12B;
	Wed, 13 Aug 2025 14:04:58 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B629E3F738;
	Wed, 13 Aug 2025 14:05:04 -0700 (PDT)
Date: Wed, 13 Aug 2025 22:04:54 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [REGRESSION] Virtio networking issues on v6.17-rc1
Message-ID: <aJz99mhpyGZ7Woyu@pluto>
References: <aJycJvs3xztfD5Rm@pluto>
 <aJzU1JsV5we-QqgQ@pluto>
 <aa46dd09-a450-4633-a647-b04781599c87@redhat.com>
 <aJz1_HzPsEyvY6HN@pluto>
 <146fd5f7-c694-4606-afa5-522c5c05d9ff@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146fd5f7-c694-4606-afa5-522c5c05d9ff@redhat.com>

On Wed, Aug 13, 2025 at 10:41:28PM +0200, Paolo Abeni wrote:
> On 8/13/25 10:31 PM, Cristian Marussi wrote:
> > On Wed, Aug 13, 2025 at 09:51:30PM +0200, Paolo Abeni wrote:
> >> On 8/13/25 8:09 PM, Cristian Marussi wrote:
> >>> On Wed, Aug 13, 2025 at 03:07:34PM +0100, Cristian Marussi wrote:
> >>>> Not sure if it has been already reported but in a kvmtool/guest setup moving
> >>>> the guest kernel from v6.16 to v6.17-rc1 I completely lost host-guest network
> >>>> functionality....in a very funny way, though, I'd say...
> >>>>
> >>>> In fact NO error is apparently reported in the guest kernel log and the
> >>>> interfaces seems perfectly up an running both sides, but looking at the
> >>>> host/guest interfaces you can see that ALL received frames are indeed dropped:
> >>>>
> >>>>
> >>>> enp0s1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
> >>>> ....
> >>>>         ether 02:15:15:15:15:15  txqueuelen 1000  (Ethernet)           <<<<<<<<<<<<<<<<
> >>>>         RX packets 125  bytes 17948 (17.5 KiB)
> >>>>         RX errors 0  dropped 125 overruns 0  frame 0
> >>>>         TX packets 1207  bytes 51182 (49.9 KiB)
> >>>>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> >>>>
> >>>>
> >>>> ...on the host same..(taken later on...)
> >>>>
> >>>> tap0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
> >>>>         inet 192.168.33.1  netmask 255.255.255.0  broadcast 192.168.33.255
> >>>>         ether 8a:10:f6:df:a1:70  txqueuelen 1000  (Ethernet)
> >>>>         RX packets 804  bytes 43904 (42.8 KiB)
> >>>>         RX errors 0  dropped 804  overruns 0  frame 0
> >>>>         TX packets 101  bytes 14408 (14.0 KiB)
> >>>>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> >>>>
> >>>> ....and for a good reason, apparently, since sniffing around on the Host TAP
> >>>> interface I can see a never ending stream of:
> >>>>
> >>>> $ sudo tcpdump -i tap0
> >>>> listening on tap0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> >>>> 22:40:42.309158 00:00:00:00:00:00 (oui Ethernet) > 00:00:00:00:00:00 (oui Ethernet), ethertype Unknown (0xffff), length 54:
> >>>> 	0x0000:  ffff ffff 0215 1515 1515 0806 0001 0800  ................       <<<<<<<<<<<<<
> >>>> 	0x0010:  0604 0001 0215 1515 1515 c0a8 2102 0000  ............!...
> >>>> 	0x0020:  0000 0000 c0a8 2101                      ......!.
> >>>>
> >>>> ... DST/SRC Macs are just all zeros WHILE in the payload you can spot my guest
> >>>> SRC mac address 0215 1515 1515  :P
> >>>>
> >>>
> >>> I bisected this regression to:
> >>>
> >>> 56a06bd40fab64448aa6b84aa06b3dc470c1254a is the first bad commit
> >>>
> >>> commit 56a06bd40fab64448aa6b84aa06b3dc470c1254a
> >>> Author: Paolo Abeni <pabeni@redhat.com>
> >>> Date:   Tue Jul 8 17:55:02 2025 +0200
> >>>
> >>>     virtio_net: enable gso over UDP tunnel support.
> >>>     
> >>>     If the related virtio feature is set, enable transmission and reception
> >>>     of gso over UDP tunnel packets.
> >>>     
> >>>     Most of the work is done by the previously introduced helper, just need
> >>>     to determine the UDP tunnel features inside the virtio_net_hdr and
> >>>     update accordingly the virtio net hdr size.
> >>>     
> >>>     Acked-by: Jason Wang <jasowang@redhat.com>
> >>>     Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >>>
> >>>  drivers/net/virtio_net.c | 85 ++++++++++++++++++++++++++++++++++++------------
> >>>
> >>> Reverting this commit on top of v6.17-rc1 solves for me and network works fine again.
> >>
> >> Thanks for reporting, I was not aware yet of this regression.
> >>
> > 
> > Hi Paolo,
> > 
> > I spotted this issue on my setup this morning.
> > 
> >> Apparently there is mismatch between the negotiated features (that
> >> determinate the virtio net header size) and the actually virtio header
> >> used by both the guest and the host, which is totally unexpected.
> >>
> > 
> > Have the UAPI headers been updated ? ... I could not see any change...
> > (not that I am very familiar with virtio core :D)
> 
> The virtio feature space has been extended from 64 bits to 128 and the
> blamed commit is the first using the 'extended' virtio features
> negotiation.

Understood, thanks for the explanation.

> 
> But, modulo bugs, the extended space should be used only if the
> hypervisors exposes the relevant capabilities. kvmtool does not do that.
> 

Ah, ok...I was hoping it was just a matter of kvmtool still to have to
update headers but maybe there's something more.

> >> Could you please share the host kernel version, the arch and the kvmtool
> >> version? Also I understand you only upgraded the guest kernel, without
> >> any other setup changes, am I correct?
> >>
> > 
> > The arch is arm64, I could reproduce on a Raspberry Pi5 with host v6.6 and on
> > an Apple M1 (running Linux natively) with a v6.12.
> > 
> > Both host kernels are from the original distros unchanged (Debian and Fedora)
> > 
> > In both cases I compiled from scratch (make clean && make) kvmtool on the
> > respective arm64 Host using the current top of tree from origin/master at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git/log/
> > 
> > 	commit 	ba6830eec0f5 ("vfio: include libgen.h (for musl compatibility)")
> > 
> > Run kvmtoool baer simple with
> > 	
> > 	lkvm run -c 4 -m 4G -k $IMAGE_DEF --network virtio -d $ROOTFS_DEF -p "earlycon loglevel=8"
> > 
> > All was fine till v6.16, and it is my usual setup and update procedure that never failed really
> > as long as I update kvmtool in sync.
> > Not sure if something is still missing from kvmtool master repo for v6.17 but it seems reasonably
> > updated (July25).
> > 
> > I wonder if no one else had this issue on arm64/kvmtool....that would made my 'regression'
> > suspiciously tied tomy setup..
> 
> Thanks for the detailed reproduction steps.
> 
> I agree it should be some bad iteration with the arm arch and/or
> kvmtool. I hope an arm system is not required to reproduce the issue,
> because I don't have any of them handy.

Thanks for having a look, hope not to have made noise for nothing and
maybe it is just a matter of a pending udpate from kvmtool guys...indeed
looking at their mailing list there is a pending patch to update headers
to v6.16 (for unrelated reasons)...

https://lore.kernel.org/kvm/20250729095745.3148294-2-andre.przywara@arm.com/T/#u

....but I suppose it would not be enough to catch with v6.17 changes
anyway.

Anyway if you need to test any fix on arm64 just let me know and I can do it
(...modulo my incoming holiday end-of-next-week :P)

> 
> I should be able to dig into this tomorrow afternoon my time.
>

No worries...no rush...I have a good workaround for now...I just wanted to
raise a flag to make sure I am not hallucinating on my own :D 

Thanks for you help

Cheers,
Cristian
