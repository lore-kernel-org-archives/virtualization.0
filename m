Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAEAB672
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 00:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115425; cv=none; b=Sz1E1PAjKrpokxlFztDps+DAYSsKuMEXPxYBDwhGgwqiV3WyXe052mJ+ccsC7BaLNN1r+7EOLZLEgrPg+0xN/gOen6/MvQ9pNgQLmJRL2b9wL8qIp+WfhgumS+TzNxjC9tbeZEoJdAHyLxLZoNWL8Axq5ycxvqw8zmxH9gUip2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115425; c=relaxed/simple;
	bh=Zm86rbf4ViZ/eAdZ8KwSBeinjex6AZ0RQ+kgPGLr94c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=peMiLOCTgJcA3+gySERZpLZC4NtDI0VKYFXRxdtuiFmIUV29oMscgP27oNnJLmrvHvf7QCw76WZSmNa3AZC+1+LIBeFyxspsgC3L31i+xiDkjYewIuNaxhAxHHgp//GFrB9R7+SNNOERFuIhM/2r4/eNY0HEBxtUw0+Xq7D8jfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnafOhVk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnafOhVk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764115422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKRmZiEMk1to2WJzzrJwnxFSNJVHABWSWDpvrtN4fR4=;
	b=MnafOhVkjS3D+WodypZ4R1xInY95tf7OWGD3kcDhOMfoVjthyYrPb6CXSYI/vcW4PnnCYt
	yDAwcJjqDzJk9ifgy/EKImDGCbiK6Abi2tPRlbHEHYqnrWPVEA0ASv6qV7AWmkkoJxsEir
	C++e4dzNPUzrf30J2COC1iXVA16eCKc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-Wgynr0goOuWOsX1k3HBY3A-1; Tue, 25 Nov 2025 19:03:40 -0500
X-MC-Unique: Wgynr0goOuWOsX1k3HBY3A-1
X-Mimecast-MFC-AGG-ID: Wgynr0goOuWOsX1k3HBY3A_1764115419
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cceeeb96so3679491f8f.1
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 16:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764115419; x=1764720219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKRmZiEMk1to2WJzzrJwnxFSNJVHABWSWDpvrtN4fR4=;
        b=wjEggQzVM0vj3Gpb60DD4CWMC8loK9pRswqVyZl2n8fERmzJcXei5xXXjSkni373mJ
         CbppmLzaeAOCZHlpMYLEk5Se2RuVT59dM73aS5Pgj9SDNVklfhCq+5v3bFK7YDbnQFYs
         TTTxLGA7a1TFH8fCeTS5FmZf6SdgSEwd7aisgd9zStPa8C5QMQIPMiya5BPZgtQck++o
         lQq+kstP9QoQm4fB5UQdjF5/gI0A1t1swKNjN73GvmIsei2feWdJXU8Fh/uFJwmLW+cf
         fwvqEIe9P6//TjyzAhDzluuGRUU4HdccIKK4AMkr3ewyWtuKhdmC82LxVD2fA/MFUl4l
         RZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV9zGLfdf6/0iaPyoo4S2CMFDsXgbaeczCAyy2s9DEmD0rT4ctT2VzKoE+sTbqDqg/zSFklJ587/NcxkbjQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywcr5hofNh/ZM1Xb3I+9bttJq8kJcTS+0klcH+qesxkR/ooa0+l
	tqCSLgL3o6Xssr9IzSjWwwbwPz2Y39tZ9DEXTwEV+6AQcvePeRNIBDm01g/vX15cCTENavFydeF
	HPIDPHb6hRNkdMt7cdHODJ/ZW4rMCFyKyujpBdLq0SnVMQ5P1P8PQnv966g7fHoadds7I
X-Gm-Gg: ASbGncvYurxJ70l5dfIrBFHW1cOWmm1kLJv7u13cONLQH7YpYxQYLpQebjOmpJn87w8
	+7AnuqzekfoTA4mc7qAWD50AZfuoS3v24qlvM3X/FcV71M7M7iNKu4ylZQhHPVkY+AHwSI0KpTS
	b+QZ/C+TbkECH21y894V60G4XFEXqCT0bAn63fXKE6j+Nxs8kaDDDBYSnH/cxIjujYG5iyLIIon
	eaRbWCUZEMWi/D87cAgSHO1njgszLNFeTm8tpS4HrPw+tICawFyqYp4aIW4SfXdPjVbTkCpEm3K
	TZsG7b1MgI6gVXGb1vragrIsRpWyk1U6zhBWgTG4qSbZXYxzMgYCFpJqS+H5vHpd+s30ILcw940
	WG8c/pMbaYkFGaAQcpG7UNI5ZaYGxbg==
X-Received: by 2002:a05:6000:24c3:b0:429:c450:8fad with SMTP id ffacd0b85a97d-42cc1d196a9mr18800457f8f.53.1764115419528;
        Tue, 25 Nov 2025 16:03:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBR55J7x3MTf+kofKm9ivnzfPRH5t94S9N5E/qvOiFWaJNtYDvbjL54tC9IkLOFKqnZLIwfA==
X-Received: by 2002:a05:6000:24c3:b0:429:c450:8fad with SMTP id ffacd0b85a97d-42cc1d196a9mr18800423f8f.53.1764115418994;
        Tue, 25 Nov 2025 16:03:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35c2sm36014357f8f.25.2025.11.25.16.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 16:03:38 -0800 (PST)
Date: Tue, 25 Nov 2025 19:03:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Message-ID: <20251125190207-mutt-send-email-mst@kernel.org>
References: <20251125175117.995179-1-jon@nutanix.com>
 <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
 <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nBP39NAmu-YTaCoIpeJP-4-f-YgBUQnJS3iwTtipyjQ_1764115419
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Nov 25, 2025 at 08:00:55PM +0000, Jon Kohler wrote:
> 
> 
> > On Nov 25, 2025, at 12:57 PM, Paolo Abeni <pabeni@redhat.com> wrote:
> > 
> > CC netdev
> 
> Thats odd, I used git send-email --to-cmd='./scripts/get_maintainer.pl,
> but it looks like in MAINTAINERS, that only would have hit
> VIRTIO CORE AND NET DRIVERS, which does not include netdev@
> 
> Should that have ?
> L: netdev@vger.kernel.org <mailto:netdev@vger.kernel.org>
> 
> Said another way, should all changes to include/linux/virtio_net.h
> be cc’d to netdev DL?
> 
> I suspect the answer is yes, I’ll send a patch for that in the
> interest of not having this issue again :)

I think yes. But only virtio net not core. I guess we should
split net from core then.

> > 
> > On 11/25/25 6:51 PM, Jon Kohler wrote:
> >> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
> >> GSO tunneling.") inadvertently altered checksum offload behavior
> >> for guests not using UDP GSO tunneling.
> >> 
> >> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
> >> has_data_valid = true to virtio_net_hdr_from_skb.
> >> 
> >> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
> >> which passes has_data_valid = false into both call sites.
> >> 
> >> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
> >> for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
> >> guests are forced to recalculate checksums unnecessarily.
> >> 
> >> Restore the previous behavior by ensuring has_data_valid = true is
> >> passed in the !tnl_gso_type case.
> >> 
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> ---
> >> include/linux/virtio_net.h | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> >> index b673c31569f3..570c6dd1666d 100644
> >> --- a/include/linux/virtio_net.h
> >> +++ b/include/linux/virtio_net.h
> >> @@ -394,7 +394,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
> >> tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
> >>     SKB_GSO_UDP_TUNNEL_CSUM);
> >> if (!tnl_gso_type)
> >> - return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> >> + return virtio_net_hdr_from_skb(skb, hdr, little_endian, true,
> >>        vlan_hlen);
> >> 
> >> /* Tunnel support not negotiated but skb ask for it. */
> > 
> > virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
> > which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.
> 
> Ah! Good eye, I’ll see what trouble I can get into and send a v2
> > 
> > I think you need to add another argument to
> > virtio_net_hdr_tnl_from_skb(), or possibly implement a separate helper
> > to take care of csum offload - the symmetric of
> > virtio_net_handle_csum_offload().
> > 
> > Also you need to CC netdev, otherwise the patch will not be processed by
> > patchwork.
> > 
> > /P
> 
> No problems on cc’ing netdev, just didn’t realize this one header didn’t
> auto cc the list. Will keep an eye on that, and happy to send a patch to
> MAINTAINERS file for discussion.

