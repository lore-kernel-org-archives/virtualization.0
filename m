Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773621;
	b=2fzxzGEelPBbuHwfRTb7zQMDe5RwJRabFc3NP7LTCwo2u6L7ZTjdoCHArg/faW630LH4
	 U+raVWWGKIt/QKNLX2Fhn5nhgKd2W9zakdClbEVFhfyFIawVYXMYvGx9gE9Z2gyas5IEl
	 2K4+igHjKXL2Jx3LOZvuJK085ifi9IVo4McZbePVmyFjj9s1k8qHd0NEPAXguD0YEeIa0
	 YeTge651qveZ9Zca+XGsLucf9U9ll/A1cwsRSZ5lV/xqt9gyNZzNCwOY5bh3AXYE1NYff
	 cejbtq4/QF2UnffFELN4l7I06mXfAVf3/fBhtnH4SrvIHOBNehGg1bjrqnMJnTcK9rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773621;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=ahjTpkvsebEzgSsBGnOTA13+FZieyFL43I5PSnK11a8=;
	b=iHQYhhkLRR40JKCSyvU1ZrQH805yrZ8IG+uo6/bei6fmy+6OtPvYKQ3erTAxqGO6XTcQ
	 NGeff6KYH1V7VyH2C4fi3elPPjMduBYXV9/ygxlsXK1dJHibnxpFReK7fTUN3yoxfroR2
	 cAZ/is9NN7diLCpjb6z68qqiNs/dNaSySSUYnJ8uui57a3bpuQaVkd4ffocbRNYKggTG1
	 YjXdMLPSLt8xBoD2UcLG5vjHUg/WebgmtMeX09VPWKdNqGuKsIu2PTjc3/MDF4JRizvj0
	 IQHDi2W7D2I3pK2ytWSENY2PGQeZ11SlEMc3+HDHsB2PHhrDZioq6H2tvP2KdQyzWLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eF4cwcBL;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED44606A31A
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 16:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ED44606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eF4cwcBL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792773620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahjTpkvsebEzgSsBGnOTA13+FZieyFL43I5PSnK11a8=;
	b=eF4cwcBLIAmnlYXIUzq8jAQMiwUNqBvGcy1C7p8YVN+keCUQQwc32Hi+oHwAiopwI41WM7
	Z+JxySSB0Hz+2ecDHb1NNOaO2sJw/3r8zvUFZMfBWilXcNFX7YVceE1gq3Ch55/j8A/vK3
	btYJfdWWoz+ucSDP7jBJRNT/dD20kmM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-ROV5nWs8MzGI83Kp-C6ZoA-1; Fri, 23 Oct 2026 12:40:18 -0400
X-MC-Unique: ROV5nWs8MzGI83Kp-C6ZoA-1
X-Mimecast-MFC-AGG-ID: ROV5nWs8MzGI83Kp-C6ZoA_1792773618
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1895ffc83so7892265e9.3
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 09:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773617; x=1793378417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ahjTpkvsebEzgSsBGnOTA13+FZieyFL43I5PSnK11a8=;
        b=cR4XcZbfFFrittIddhPG1T26GFhkR0rP2l+m/MK35RMXDPPV07LnUSri+7JDUrO/nH
         U1SDGco6rjyLOp96uJ55YxnGP44bvLpflkGQAjr2+FZR0G+WKjTUoCqKTR4YDxALhS+X
         toBCOrg070E9Q7rPLACgafGWt75FjrLNuoFIUEyTjyfbQxgdd9eDQKxYtUxGRnDw2Hnh
         bs8UDQWAMcG2lBLn9TTGkyqYNdHFpaSzOnGI3Hp3VnXOUSEcxmz8/pMP50jhUH2/h9nJ
         sxowMYQti9aaN1IKF5jvtJmTTvIOo7lrYJjZtNzJSOIqrHo0/FvMAqnZstl2yKRqWR69
         OtmQ==
X-Forwarded-Encrypted: i=1; AKwUvBysxpssK/F8IMe+4mKQliVmS7RRdmyy2cIyPKTsBUsmNhmCfw8zKUhtVhEJ53bzTSEzw0wBUiKIJEjtVt1ENQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKl6ulL+9P3prwxXFejeFg9vzT3YWlxU4o2ESDE37M66J8X572U
	i0Q/x2VLKKCiLro8auT1SNYMnuknuPud26DDfuWPxtt3WpdNuiD6KTmeOIioOT8wEDBwq6LMQw1
	5W7QB1kXI7CASwjcfy0w5mfPiay2Uz61FgIDtxvf1wxCMCZgRxQPJIoU+Hd321b3q1Au+
X-Gm-Gg: AYBFou1frTsbXHrsacVqRRlOlYFHXlDW+SsEg0gB4QOjdyqbRXHmepiZzQnz90XGQyj
	aNcQyCEo+YH7ACCqbUZND/rj/JLN0dBrE5tIIlKCnbz4ptCdS8774UrRe40qiciay6M4TzMl/Xf
	VDg2XsS3lXp453lxkbevXUJfS7o7zJv7YjiD6aiAfuT+iYN4n8ZOZVUWDd/EWHga7erWcAdMJT/
	tC0D+CQzLHgP7L9Kc1/3AOA0GDHT/CU0+SMpdPCIolfpsRxkf99lz894NA60J3dcOA+9rh3leP5
	b2dhz8h3a37UfI/R2Qn7/alecyQpTwk0jUCKxOYpvebVgE639myHX6o809Y2J823WIe0Z7Y=
X-Received: by 2002:a05:600c:8b23:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a211edccbbmr46397785e9.28.1792773617462;
        Fri, 23 Oct 2026 09:40:17 -0700 (PDT)
X-Received: by 2002:a05:600c:8b23:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a211edccbbmr46397475e9.28.1792773616868;
        Fri, 23 Oct 2026 09:40:16 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a312fcdc63sm5911635e9.2.2026.10.23.09.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:40:16 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:40:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Cheng Yongkang <teel4res@gmail.com>, virtualization@lists.linux.dev,
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH net] net: virtio_net: decode tunnel csum_start as
 little-endian
Message-ID: <20261023123931-mutt-send-email-mst@kernel.org>
References: <179268538303.70821.1734486381476363942@gmail.com>
 <sashiko-outbox-182939@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-182939@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mXHxRaDuRRbYbaCaH81jEgFvNkrDW4PFdmGOhVTeCs0_1792773618
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 23, 2026 at 04:09:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] net: virtio_net: sparse __virtio16 mismatch in virtio_net_hdr_tnl_to_skb()
> --
> 
> commit ba7ce0ae4b2dfb77c6b110ada68faaf66de9237f
> Author: Cheng Yongkang <teel4res@gmail.com>
> 
> net: virtio_net: decode tunnel csum_start as little-endian
> 
> This commit changes virtio_net_hdr_tnl_to_skb() in include/linux/virtio_net.h
> to always decode hdr->csum_start as little-endian during tunnel header offset
> validation, matching the subsequent call to __virtio_net_hdr_to_skb().
> 
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index d6466f96cdd00..ddc6341747e53 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -324,7 +324,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	inner_l3min = virtio_l3min(inner_isv6);
> >  	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
> >  
> > -	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
> > +	inner_th = le16_to_cpu(hdr->csum_start);
> >  	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
> >  	outer_th = le16_to_cpu(vhdr->outer_th_offset);
> >  	if (outer_th < outer_l3min ||
> 
> [Severity: Low]
> Does passing hdr->csum_start directly to le16_to_cpu() in
> virtio_net_hdr_tnl_to_skb() trigger sparse endianness warnings when building
> callers such as drivers/net/virtio_net.c and drivers/net/tun.c with C=1?
> 
> Unlike vhdr->inner_nh_offset and vhdr->outer_th_offset, which are declared as
> __le16 in struct virtio_net_hdr_v1_hash_tunnel, hdr->csum_start is declared as
> __virtio16 in include/uapi/linux/virtio_net.h:
> 
> struct virtio_net_hdr {
> 	...
> 	__virtio16 csum_start;	/* Position to start checksumming from */
> 	__virtio16 csum_offset;	/* Offset after that to place checksum */
> };
> 
> In include/linux/virtio_byteorder.h, __virtio16_to_cpu() performs the forced
> cast from __virtio16 to __le16 before calling le16_to_cpu():
> 
> static inline u16 __virtio16_to_cpu(bool little_endian, __virtio16 val)
> {
> 	if (little_endian)
> 		return le16_to_cpu((__force __le16)val);
> 	else
> 		return be16_to_cpu((__force __be16)val);
> }
> 
> Should this use __virtio16_to_cpu(true, hdr->csum_start) instead, matching the
> __virtio_net_hdr_to_skb(skb, hdr, true, ...) call below and
> __cpu_to_virtio16(true, hdr_len) in __virtio_net_set_tnl_hdrlen()?


Ah no wait, this is not my v6. My v6 is ok.


> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/179268538303.70821.1734486381476363942@gmail.com?part=1

