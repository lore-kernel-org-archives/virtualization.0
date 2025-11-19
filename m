Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD773191C3
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536852; cv=none; b=FbBNj553dvTlQs3bU1FXNsQWJetvMqydou1O6KRB8JmmQfm3rSFAsw2ZygeCmwaB83MdI6KbmUs9Bd3nSsU5MxoanfEKHgZQFFVJGoCFVeD7ADf60cbzT5LizyCKuRt0EvvQUgNKQcK/9SYK+hERT1wPQIDFzLjUBC+ZRJltLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536852; c=relaxed/simple;
	bh=d5oYqbc0GgF/St+ssRaSW3VtqPJr3GgkpOW0pTSozDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RLG3ogyHBvLo0JmgQyaayWldAQmNA/VH41O/vtfAu//ORNrP6NWPOUu7eHRcMw9eAh83yzp6DrwOD+YjddnS087axc+HYcgBEkKBw/HwkWCyC68clAQFEQFMCDeubypDbMlHWwrcXUqcmLtSkqUiU6naAUh4VTgo8v3EVHlPnro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOn5b9gq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOn5b9gq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763536849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbs5x7EWq0AowysP4qe5fQSEKCrLE5l2y4/OAyhVQl4=;
	b=cOn5b9gqm1bMU40d9vRhFSMu2pRS8NA9/nWKVETI+xqbCsitjNg1pt08zcoiVb2qw3xj3J
	oVqu0R15h1446HPF/MMYTaXM5esSAcK7OVyOt23UnaUymkQNKXiiNuhhK9QYqQem6fWVFB
	GkcabPUudDnztu485O6iNMh7b6HWL+s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-v41VPqJINjGo6CwPz16Wtw-1; Wed, 19 Nov 2025 02:20:48 -0500
X-MC-Unique: v41VPqJINjGo6CwPz16Wtw-1
X-Mimecast-MFC-AGG-ID: v41VPqJINjGo6CwPz16Wtw_1763536847
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779393221aso12086925e9.2
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763536847; x=1764141647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbs5x7EWq0AowysP4qe5fQSEKCrLE5l2y4/OAyhVQl4=;
        b=cxSNEIo8lGQESZcdwXbXYTJJPZpv5d4nO2C3KJxv/ce0qBNncYS199MrD0+I6c0jbW
         bpKmr3HEyXkGAzzMS9ccNvdxIYO2izAD955c9rEjPk21n5U+tlRkWDzFD2qKqgycmtDi
         b2RpxIJZIyb4YrgO7EfbxqhL2IJqE5bLfLHoEJQuhNTB+/wqIsvKGnpw/2qeDNzaYf0l
         0Yu8P/HBorXPpG6shxa+4UsJq6ZEOqbJyeb2eGBvkgbNfUshpA7AlO+YrI1cT+ff7N0v
         uXiRGiiMY4CFhLdGCVJB72qZZVNwpj061oEvY1Oq6HDXJA9bgHkiM6bVkW7+OeCw8mij
         gZWg==
X-Forwarded-Encrypted: i=1; AJvYcCWYTByo+j2PHpLfgJuVGOFrMtdtC3L6KpDNU/fLjo5hIqecGeucrqoq4YLDZOzYvo3Usr5trAsn7DDAj0jxTA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywt24MWJY0/+b+3YpRr0d9o0QXG8F+HUHNP0TiCHpYVbIkZSrdy
	jEOHANZD11ywX5FTNeRrcfwRAtU+DkZ2jpfMYWR6r1K1nFwe1/WJcyUXqi/cDcv0J5eFDJ9isls
	aaqH/Q454WPpCPwisysO7rtnjLXVvQgBdSwjPfTmJBvLKpNPHaYYXi0xpWjoltfZOIF+g
X-Gm-Gg: ASbGncuc7JtapTBMKt7JJLiAKtxL/D0+AyHoDFHUJlh8gq/gjU7cFDXnySiNRWHmV4s
	Tkn6VC+tQN5cIuw98huOqj4c2p7BgZHC1gTVTFW9lSxEUUC2+I0Z+yR7QJuLCD+X++m6yyx9moO
	9UV9eJUVYBr6FfwywROcsV9bQtk50MLYpLhz5riQqmA2RaX1eNPcFdgbe+UG03gLCbjAJ+tzfq3
	q4eDzMeAjDlPSk9YvTtCkYnTO0zIeQewnBSJPqQybgxR4TbEShkG4ii5l0KuDAW8maGg6acFvXw
	D5XmTm/zilf12XLTE3YAwDdTaXVWLbdPMkUJvr5ezwek+NMrmJXekLBpIfkdvKx45khTmvCIzd+
	JiDzYVCmhCg4+rWGZaY5+2lK+HkHVVQ==
X-Received: by 2002:a05:600c:1f1a:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-477b19ed12cmr8577705e9.32.1763536847351;
        Tue, 18 Nov 2025 23:20:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcCRyKAbuj6bf2L9WOClmuRroF9Z4nNGU8pZ4mhfeKrFqqwk0OsFutE0zlAxf7gESv3lyM9g==
X-Received: by 2002:a05:600c:1f1a:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-477b19ed12cmr8577485e9.32.1763536846939;
        Tue, 18 Nov 2025 23:20:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1076865sm32222375e9.13.2025.11.18.23.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:20:45 -0800 (PST)
Date: Wed, 19 Nov 2025 02:20:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251119021926-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
 <d2b57943-0991-4823-9997-2bd6044c7abc@nvidia.com>
 <20251119020521-mutt-send-email-mst@kernel.org>
 <e7b5bb24-0ea0-4b73-8548-3b67872a742d@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e7b5bb24-0ea0-4b73-8548-3b67872a742d@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DqH7-SeOt15lBHzxN_Le3NDnVArcnvcfgMcxw4Nexxk_1763536847
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:17:28AM -0600, Dan Jurgens wrote:
> On 11/19/25 1:06 AM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:03:36AM -0600, Dan Jurgens wrote:
> >> On 11/18/25 3:31 PM, Michael S. Tsirkin wrote:
> >>> On Tue, Nov 18, 2025 at 08:38:59AM -0600, Daniel Jurgens wrote:
> >>>> Add support for IP_USER type rules from ethtool.
> >>>>
> >>>> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> >>>> +		      const struct ethtool_rx_flow_spec *fs)
> >>>> +{
> >>>> +	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
> >>>> +	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
> >>>> +
> >>>> +	mask->saddr = l3_mask->ip4src;
> >>>> +	mask->daddr = l3_mask->ip4dst;
> >>>> +	key->saddr = l3_val->ip4src;
> >>>> +	key->daddr = l3_val->ip4dst;
> >>>> +
> >>>> +	if (l3_mask->proto) {
> >>>
> >>> you seem to check mask for proto here but the ethtool_usrip4_spec doc
> >>> seems to say the mask for proto must be 0. 
> >>>
> >>>
> >>> what gives?
> >>>
> >>
> >> Then for user_ip flows ethtool should provide 0 as the mask, and based
> >> on your comment below I'm verifying that.
> > 
> > but if it does then how did this patch work in your testing?
> 
> Why wouldn't it work? For IP only flows the proto field is not relevant.
> It only filters on IP address, not port.

I mean it's dead code with mask 0.

> > 
> >> I can move this hunk to the TCP/UDP patch if you prefer.
> > 
> > 
> > not sure what you mean so I can't comment on that.
> > generally it's best to add code in the same patch where
> > it's used - easier to review.
> > 
> 
> the l3_mask->proto will only be set for TCP/UDP flows.

I'd move it there in that case then.

-- 
MST

