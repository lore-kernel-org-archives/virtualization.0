Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E1582BAD
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173093; cv=none; b=ia52TaUsN8dH9K0VYDatk3XhsrMf8ImkcliLAoURAKxDvbgpyAJEpS+HkyVmjd1M0d4yF5vBlwPQHIyASIBRuoAbTdEvgYsuKnNF+/neIWmwyJ/xCOmMzvv3LpPp9WvoPjL6rZjydNEik3oLgkHkKjucSJ6NPlbg9ckOlI2BBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173093; c=relaxed/simple;
	bh=mcjHbTCaVayfmlcAGqrGUKY2cLvBM1brbv0Ml34HCNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uMRvCBEzQWUxHjnG2jk84K0jJTEkJTevn8PePgCxdrVdKvTqh73RiINIbv8OuoyxNVqySEKlAhQuYtkcrCgZsFKsmf4cU4i2zSmwim1YRhEdiHuYqAh24/BmzPOToANvY//tl/Y4pOZ7R/IrQ+/oDEauUkeR0OU3TrhVmENG83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=URkt+nKM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URkt+nKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792173090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W74nlXHsz1uD6EVItToAyocJ9byMIagIgs9+oTaSxM0=;
	b=URkt+nKMg4bQJ8PyQICVZF3Mmnbjp3FnerYtIIrbaZ5IAAYI+DkkT2bxbvRvIoRNGxZkPH
	B3i7hoDybQYYpn9nq91Zlb2tdIDRd1bL+s+aOxTDOWasY1RGvxFKrZZV2n0it7XDsjWKiC
	W/mNrlEvFbJ9ZHfBTgK3TLOSdsRAS1M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-Dm_uSsB8NNC-QTOaNFzCqQ-1; Fri, 16 Oct 2026 17:51:29 +0000
X-MC-Unique: Dm_uSsB8NNC-QTOaNFzCqQ-1
X-Mimecast-MFC-AGG-ID: Dm_uSsB8NNC-QTOaNFzCqQ_1792173088
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c4f6f66dfso34678f8f.3
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 10:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792173088; x=1792777888;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W74nlXHsz1uD6EVItToAyocJ9byMIagIgs9+oTaSxM0=;
        b=dKWH7dlkeXZ4nk2Ovn5W9zvznn2d9VsN2DUZEq5UBaO09o1oQIssUY9FJw8+g8lEuF
         fuGxTsCkORi3i+Kae99ESf5IaKgGet7+6uHUtMiwuZMCNBGDTAEWwExLu7wWMxert5UX
         vN3p8f6TXrulDsMYQiYuQ2dzhUrEDPV9Ab7UdCrrZrWTf2Zb9NgKY7R1Kgz/iyKCKkcL
         OpUTmcbOLUwJo8SewfLh7WTjefgfahohuyyjtngfaPvZlP4q2bouURooCEWy4SoZb6OK
         YN3bgw3YgVZ1W7JEeuQPN67jBZne4g0N19HMVpXH/W5x6ELcerU7PNxw3YSSK0clAmY1
         2ohA==
X-Forwarded-Encrypted: i=1; AKwUvByy624EnjscE75Sdlie2fTgwEsQCeOFOsC+vc8w3Uesaid6hqs6L1poxZZuuNmrKd5wgXeC0MEiZOf12VIP3w==@lists.linux.dev
X-Gm-Message-State: AFq9FYL1PZr9x+x0ZBi6X+7esd8J1HECLnzexgz5J76wkNck3WKsCbkb
	FIrP0m62JYseTolcTE4+dsCZGOlq++N6lzX/G597nZeatjwcCBvjNQnU0SfZfIZQ9JxT5fEFhgA
	K97aqeDJCuStZpdD2I53YlczBDlUMtxGZ1wyRkFXMwN21bzs7r1rZdWvS40lGSPKSGS+A
X-Gm-Gg: AYBFou2MoggnvfcFFDVfK2P40SNMVYfQUw5LSWvdwrchbJ++m62wadzrZZKJ0FSKAl/
	pkvr08jn2oG4BJ+EI1gzAMiiu2t3xsqGo9+TDpC51kYL2Z3BqiUymb0CVy5IwoWszKrF6PILotY
	lqBprJCNtBeHTtQdpFwt0qYp9EFv5zKYc6lVwPH+18B+cMqS3QUocBqcL1LAnwL8buFBIBcTeHI
	oTmVt24LoVNfyafyMZfl5Z+46B3Q/t4POgKGlqBu/RVneuEVWA0+tvlhQA9RdB94Dmk9+gWhiCy
	41bh/T2rTd6zjVi/MMgFxWNFF+xxakg+4dNdaA5zmZK7sfYuWrDZAKRAtM6pflWsy3SZH+8=
X-Received: by 2002:a05:6000:40e1:b0:48b:1c:d6e1 with SMTP id ffacd0b85a97d-48e07f9ebc9mr605350f8f.43.1792173087861;
        Fri, 16 Oct 2026 10:51:27 -0700 (PDT)
X-Received: by 2002:a05:6000:40e1:b0:48b:1c:d6e1 with SMTP id ffacd0b85a97d-48e07f9ebc9mr605297f8f.43.1792173087273;
        Fri, 16 Oct 2026 10:51:27 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73fb:d100:601d:d7d4:d03f:527b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfe4d2321sm6861579f8f.19.2026.10.16.10.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:51:26 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:51:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/7] net: add a sysctl to opt out of virtio
 net hdr checksum validation
Message-ID: <20261016134823-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>
 <20261016051827-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.1d7ce6b64753a@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.1d7ce6b64753a@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ffY0_dzIWxqdB04bxS2yhlE5_aYOhcyaldUAE8_e6yc_1792173088
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2026 at 11:30:17AM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Thu, Oct 15, 2026 at 01:50:54PM -0400, Willem de Bruijn wrote:
> > > Michael S. Tsirkin wrote:
> > > > The ingress validation as implemented by the previous
> > > > patch is stricter than what it replaced: GSO
> > > > packets whose checksum metadata matches no transport header are
> > > > dropped, and non-GSO ones get their checksum completed in place.
> > > > Such packets used to pass with the metadata unvalidated,
> > > > and with no overhead.
> > > > 
> > > > I judge that this should not affect any deployments, but there is still
> > > > some risk that it does.  In case a deployment depends on them anyway,
> > > > provide a per-netns switch to get the old behavior back:
> > > > 
> > > > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > > > 
> > > > The default is validating.
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  Documentation/admin-guide/sysctl/net.rst | 15 +++++++
> > > >  include/linux/virtio_net.h               | 23 ++++++++++
> > > >  include/net/netns/core.h                 |  1 +
> > > >  net/core/dev.c                           |  6 +++
> > > >  net/core/net_namespace.c                 |  1 +
> > > >  net/core/sysctl_net_core.c               | 54 ++++++++++++++++++++++++
> > > >  6 files changed, 100 insertions(+)
> > > > 
> > > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > > index e586e17fc7a5..7f230929c37e 100644
> > > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > > @@ -246,6 +246,21 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > > >  Default: 1 (on)
> > > >  
> > > >  
> > > > +virtio_net_hdr_csum_check
> > > > +-------------------------
> > > 
> > > Make more generic, virtio_net_hdr_validate?
> > > 
> > > In case we add more validation in the future (as we have in the past),
> > > without having to introduce multiple such knobs.
> > 
> > But it's uapi, are you sure we'll be able to change the meaning
> > of an existing knob, even if we keep the name vague?
> > 
> > > > +
> > > > +When processing packets with a virtio net header (through tun, tap, a
> > > > +packet socket or a virtio network device) that request checksum offload
> > > > +(VIRTIO_NET_HDR_F_NEEDS_CSUM), validate the packet: complete the checksum
> > > > +in software, or drop the packet where the header does not match it.
> > > > +
> > > > +When disabled, the header is trusted not to corrupt the packet, and the
> > > > +checksum is offloaded to hardware (or not verified if it never reaches
> > > > +hardware). This is only safe if no protocol is processing the packets.
> > > > +
> > > > +Default: 1 (on)
> > > > +
> > > > +
> > > >  wmem_default
> > > >  ------------
> > > >  
> > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > > index 357115ff0ec2..aa2f8ac4657c 100644
> > > > --- a/include/linux/virtio_net.h
> > > > +++ b/include/linux/virtio_net.h
> > > > @@ -5,6 +5,7 @@
> > > >  #include <linux/if_vlan.h>
> > > >  #include <linux/ip.h>
> > > >  #include <linux/ipv6.h>
> > > > +#include <linux/jump_label.h>
> > > >  #include <linux/netdevice.h>
> > > >  #include <linux/udp.h>
> > > >  #include <net/gso.h>
> > > > @@ -78,6 +79,19 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> > > >  	*thoff = nhoff + iph->ihl * sizeof(u32);
> > > >  	return iph;
> > > >  }
> > > > +/* Defined in net/core/dev.c, enabled while any network namespace
> > > > + * has net.core.virtio_net_hdr_csum_check set to 0.
> > > > + */
> > > 
> > > Should this be a global sysctl, rather than per netns?
> > 
> > 
> > For customers I work with, it would be much less useful.
> 
> Third option: make it an integer rather than a boolean.
> 
> 0: no validation
> 1: current level of validation
> 2 and beyond: if we have to extend it later
> 
> Not pretty, I'll admit. So fine to keep as is too if you prefer.
> But I do foresee more changes in this area, if history is a guide.
>  
> > 
> > > Even if per-netns, most likely do not want it writable by netns root
> > > with user namespaces.
> > >
> > > That is the equivalent of ns_capable(CAP_NET_RAW), which is the cause
> > > of many crashes due to bad packets ingested by, e.g., a packet socket.
> > 
> > Hmm, yes i get that. Two knobs? a. verify b. the per netns value ro? Both
> > on by default?
> 
> A single system wide field is simplest.
> 
> Is there a benefit to making this configurable on a per netns basis?

As I tried to explain: a specific container breaks, you decide to trust it,
you do not need to trust all.

> If so, that's fine too. As long as root-in-namespace cannot modify it,
> so readonly indeed.


Right. So I envision along the lines of:

net.core.virtio_net_hdr_validate_all - validate packets from any netns,
netns root can not change it, only host root

net.core.virtio_net_hdr_validate - per netns


both set by default, validation runs if either is set.

-- 
MST

