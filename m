Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16B53D0C4
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176025; cv=none; b=IVMP4zVCzd/+JSNOBHIQvXBaQK57xDZ1uT4JHDCTcDv95eXnjzd2EUUCZZmBafEwNeNyEJ3FV9xWXI/TzEhdyWKmosZMCYJ1F81u+9CI8vwZndIE1E25X6+zZk4xlBTez3jwF7NgwSCvkleI6VZHRmaJu8JSj/GzI7HBYI1wQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176025; c=relaxed/simple;
	bh=TtCwQmW9z7VLSlbkIUYvUJ6XV+W61FfizwGxp/7PXxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k3BfPRlZJfzW4aRc5JQQ9vqxcDMSx49t+zhAshjqJNRvaEEE0dtIocdBDhKBGt5XiVP3bWhirEuTT1npZfcJxWmPOCfN/Lng6gDW1NtiwY+f2t9iUhixdbXSzY/fzsL/29CAgdsuJAE3QFDU7O8KUGqZjp7QvIp7wFW+P64nH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iO9n4n4p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iO9n4n4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792176021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plc50fRCIOdcKHDZ5D5nq9FAVnLtqLtSVPaltfZbIaM=;
	b=iO9n4n4phFlCEHsDnKmRV5n3MDmlwFv2eKca1PUO9m/2WdHFjW1h0B5YT/d+pu5czbfQq7
	HAyXFr93EH8lpKFkt+X5Eg8YvNParexvDj9ZZK1bcXvUnwISzmR5wsGDwF3VoUV1dN6Cxr
	Wv2yrb7OYhZ6rQ0von5xdBR2TPHL8Q8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-VDDHevPlMSi_SKe0vzo1LQ-1; Fri, 16 Oct 2026 18:40:20 +0000
X-MC-Unique: VDDHevPlMSi_SKe0vzo1LQ-1
X-Mimecast-MFC-AGG-ID: VDDHevPlMSi_SKe0vzo1LQ_1792176019
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48af4046a3bso73862f8f.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 11:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792176019; x=1792780819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plc50fRCIOdcKHDZ5D5nq9FAVnLtqLtSVPaltfZbIaM=;
        b=pre7+lvK0kfVXrvC5ljwYnN1yehhGUsnkc4RZGA3Mm+IiPuY5zBgNnKZgAE1g/zBSu
         ExDmFfrCD36Ge5WYLT5TZuoIN0EOVaJSImtOC/OEpAbQjXwTspPjODaivJqFiIS4Ziy8
         k6rcyS2u7KvIReaXGnahn+yHb7kr3DzUn3Qx33PUTdjh+bUSP7T/hgHJey78raC8/uyt
         LjPh5yyiq379IvCT8nZWPD4ZbSncIoZsvSq61HeJgbyVCdn6EhznFHuztWlY5Y4Nu6Nf
         g+tE75LvzvnzMn6E7E7d+44pa6EodH0ZrRtEpWsKPQesIQDluS8w9RTu8Tv3hcEczjgS
         +HVg==
X-Forwarded-Encrypted: i=1; AKwUvBwsXh4d455Fr9K15XqDle2bTVAKUhjC1U7sOHBoJOM2yVQboAA/S3Cf4rwR05smjkkt+cjf0kXMRHegnNlySQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLKd87QywQE7vhoOF7g+HA+LNDmgPnaozeLBq0M1X/MkwdlsF5O
	zlb9YkzaGV4TTLqMf2FXNPdGxYaVsObDwsJ3G20FilKESgxwdhMXRO34p1Y4q+RffroZA0hMvaQ
	LkpxbPBQ2R59rZtlwuOEmfR3lPkahaQjiBchm+olDQqY0bHP7zG6yG86JKmElO21yjQTM
X-Gm-Gg: AYBFou0xkHx882rJE0hXa9zP5I8ippKg2bHcriGKWiqwJNTgJgzDaMBJv3HEcPqm0Kz
	q9rhNYpfhHd4lYIRVJ56w2JAntPMGZVPXpXIIyNHDR11wgN47Q8ADbIwp6ez4u9MuTPdKyu2/1I
	j/ZMIlHBlpHyW4ywCUzdDvHPq/OiAWQs41gfAJXtYV4y2QV5E8lqFPh5qPsLxL1+eaZ2NWNY6GD
	+K/L4W+qze0+c0mUowTAohjrk2tVTsjSbkYlefgJGC/7Wce6HUNW7BmIIxgZ/Oux8DVUUhRa62Z
	LP4ClEkE4WZ2+HyUToUemz4ByjCsus5NjpgmTcdPcl2RAM0Jlt72WJ6FQTUKggGH9ENvypw=
X-Received: by 2002:a05:600c:3e85:b0:4a1:d798:b08a with SMTP id 5b1f17b1804b1-4a1d798b0d4mr12241575e9.21.1792176019014;
        Fri, 16 Oct 2026 11:40:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3e85:b0:4a1:d798:b08a with SMTP id 5b1f17b1804b1-4a1d798b0d4mr12240665e9.21.1792176018224;
        Fri, 16 Oct 2026 11:40:18 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73fb:d100:601d:d7d4:d03f:527b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cc642573sm56208515e9.2.2026.10.16.11.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:40:16 -0700 (PDT)
Date: Fri, 16 Oct 2026 14:40:13 -0400
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
Message-ID: <20261016143944-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>
 <20261016051827-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.1d7ce6b64753a@gmail.com>
 <20261016134823-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.2deaddfb31bd9@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.2deaddfb31bd9@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uIzC2_yzBbVN_uHx21Lr8JRsOdiCAH8ohBEou3nayjk_1792176019
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2026 at 02:19:39PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Fri, Oct 16, 2026 at 11:30:17AM -0400, Willem de Bruijn wrote:
> > > Michael S. Tsirkin wrote:
> > > > On Thu, Oct 15, 2026 at 01:50:54PM -0400, Willem de Bruijn wrote:
> > > > > Michael S. Tsirkin wrote:
> > > > > > The ingress validation as implemented by the previous
> > > > > > patch is stricter than what it replaced: GSO
> > > > > > packets whose checksum metadata matches no transport header are
> > > > > > dropped, and non-GSO ones get their checksum completed in place.
> > > > > > Such packets used to pass with the metadata unvalidated,
> > > > > > and with no overhead.
> > > > > > 
> > > > > > I judge that this should not affect any deployments, but there is still
> > > > > > some risk that it does.  In case a deployment depends on them anyway,
> > > > > > provide a per-netns switch to get the old behavior back:
> > > > > > 
> > > > > > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > > > > > 
> > > > > > The default is validating.
> > > > > > 
> > > > > > Assisted-by: LLM
> > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > ---
> > > > > >  Documentation/admin-guide/sysctl/net.rst | 15 +++++++
> > > > > >  include/linux/virtio_net.h               | 23 ++++++++++
> > > > > >  include/net/netns/core.h                 |  1 +
> > > > > >  net/core/dev.c                           |  6 +++
> > > > > >  net/core/net_namespace.c                 |  1 +
> > > > > >  net/core/sysctl_net_core.c               | 54 ++++++++++++++++++++++++
> > > > > >  6 files changed, 100 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > > > > index e586e17fc7a5..7f230929c37e 100644
> > > > > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > > > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > > > > @@ -246,6 +246,21 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > > > > >  Default: 1 (on)
> > > > > >  
> > > > > >  
> > > > > > +virtio_net_hdr_csum_check
> > > > > > +-------------------------
> > > > > 
> > > > > Make more generic, virtio_net_hdr_validate?
> > > > > 
> > > > > In case we add more validation in the future (as we have in the past),
> > > > > without having to introduce multiple such knobs.
> > > > 
> > > > But it's uapi, are you sure we'll be able to change the meaning
> > > > of an existing knob, even if we keep the name vague?
> > > > 
> > > > > > +
> > > > > > +When processing packets with a virtio net header (through tun, tap, a
> > > > > > +packet socket or a virtio network device) that request checksum offload
> > > > > > +(VIRTIO_NET_HDR_F_NEEDS_CSUM), validate the packet: complete the checksum
> > > > > > +in software, or drop the packet where the header does not match it.
> > > > > > +
> > > > > > +When disabled, the header is trusted not to corrupt the packet, and the
> > > > > > +checksum is offloaded to hardware (or not verified if it never reaches
> > > > > > +hardware). This is only safe if no protocol is processing the packets.
> > > > > > +
> > > > > > +Default: 1 (on)
> > > > > > +
> > > > > > +
> > > > > >  wmem_default
> > > > > >  ------------
> > > > > >  
> > > > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > > > > index 357115ff0ec2..aa2f8ac4657c 100644
> > > > > > --- a/include/linux/virtio_net.h
> > > > > > +++ b/include/linux/virtio_net.h
> > > > > > @@ -5,6 +5,7 @@
> > > > > >  #include <linux/if_vlan.h>
> > > > > >  #include <linux/ip.h>
> > > > > >  #include <linux/ipv6.h>
> > > > > > +#include <linux/jump_label.h>
> > > > > >  #include <linux/netdevice.h>
> > > > > >  #include <linux/udp.h>
> > > > > >  #include <net/gso.h>
> > > > > > @@ -78,6 +79,19 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> > > > > >  	*thoff = nhoff + iph->ihl * sizeof(u32);
> > > > > >  	return iph;
> > > > > >  }
> > > > > > +/* Defined in net/core/dev.c, enabled while any network namespace
> > > > > > + * has net.core.virtio_net_hdr_csum_check set to 0.
> > > > > > + */
> > > > > 
> > > > > Should this be a global sysctl, rather than per netns?
> > > > 
> > > > 
> > > > For customers I work with, it would be much less useful.
> > > 
> > > Third option: make it an integer rather than a boolean.
> > > 
> > > 0: no validation
> > > 1: current level of validation
> > > 2 and beyond: if we have to extend it later
> > > 
> > > Not pretty, I'll admit. So fine to keep as is too if you prefer.
> > > But I do foresee more changes in this area, if history is a guide.
> > >  
> > > > 
> > > > > Even if per-netns, most likely do not want it writable by netns root
> > > > > with user namespaces.
> > > > >
> > > > > That is the equivalent of ns_capable(CAP_NET_RAW), which is the cause
> > > > > of many crashes due to bad packets ingested by, e.g., a packet socket.
> > > > 
> > > > Hmm, yes i get that. Two knobs? a. verify b. the per netns value ro? Both
> > > > on by default?
> > > 
> > > A single system wide field is simplest.
> > > 
> > > Is there a benefit to making this configurable on a per netns basis?
> > 
> > As I tried to explain: a specific container breaks, you decide to trust it,
> > you do not need to trust all.
> 
> Ok
> 
> > > If so, that's fine too. As long as root-in-namespace cannot modify it,
> > > so readonly indeed.
> > 
> > 
> > Right. So I envision along the lines of:
> > 
> > net.core.virtio_net_hdr_validate_all - validate packets from any netns,
> > netns root can not change it, only host root
> > 
> > net.core.virtio_net_hdr_validate - per netns
> 
> Then skip the global option, as it's just a convenience: the same can be
> achieved by iterating over all the per-netns settings.
> 
> Per netns validation, but only settable by root, not by root-in-namespace.

Hmm I don't know how to achieve that. Are there examples of such
options?

