Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD72773E4
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505602; cv=none; b=rnoSJZ4tjjPiOjXIunqv3YJ43B7JTrFXjDVreG0HAuEHtb/dGsBZJG9Fa6EplyZB4rvgZcfDuMWDRsqzgpKjwd5ku+/wmJWwvhqy3Q0XxZWkvRA24F5PCVcJ9VmYWFBcrQ30efMZFNoUXSVTGz3n3dgy4fFYNqOiN+73N+GBjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505602; c=relaxed/simple;
	bh=pcJMnwVwfVuhAv0NrDemuQ0DXz73W8XvYi+UP7Aov6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ykcj83kxNpBRtwF+AnulaMqPqE54OHgNqRZfXGtqHwDwiOmcQhlTurc9KlRS2klTDSlqJ/7aRZ5/97GQXxVjxxH7PvV+hgFg0VdnZCXJS3m28qcmGPzRLl+NkJVn4NIe65RG61fgcLDqO/KpHWVTYHJ+DX+usU11W0YJVytL0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REtHU9vx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REtHU9vx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763505598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGwomD69lix3vazkeV/4gZbgPJ4JRm/KwTTbCvFqgvs=;
	b=REtHU9vxTal9QsGu06B+WpH8i4q8yRuSOCDAhnPq2TVHFYO8gfhGJMCphc7l3tz/5c/orX
	PUtl4fEgrRzGIubFbU89VtwBsHHwrHCIuhIWSzQYpGpcJ/ZL/0liEm/8fhbK/6C+7b0zou
	1BSLMvApKJYO3HAfmam9WfQFnC+vZtY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-As5kJKJaPRGhHwYiy13tHw-1; Tue, 18 Nov 2025 17:39:57 -0500
X-MC-Unique: As5kJKJaPRGhHwYiy13tHw-1
X-Mimecast-MFC-AGG-ID: As5kJKJaPRGhHwYiy13tHw_1763505596
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a0ddd1d4so22857505e9.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 14:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505596; x=1764110396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGwomD69lix3vazkeV/4gZbgPJ4JRm/KwTTbCvFqgvs=;
        b=wYtoKSk9eKBzwoT7Zym9p+Z1oKIuCojCmDh+iSUg/Aw0sSJUbUn6JCBtwgCTLu0Cq3
         7kjGh1TIKxS4bG0ZoP3Gn0xl9tOkouggdPWz9REUdCpgFMi4ibWKq/eo2xPLCy6xVMmg
         PjNEzMuVlhqs77eiP1MT9YJrUh4Doeq29DFodi02CAakNe3DlDEpDhw448ocwdEAbU1W
         EdsRZAnd37OgKSzrhZmKQZjOIkbbw6hBRthlWHwq+7p4dN8yRrIYDnD3tTJsfXmT+7JC
         Yflo0f4BGrhj72ux9FEr3Kn+sKSDx4Rq7WL1IDImi9aT8IY+gwTp9RuG2Ay6lc7p/Y8C
         3HtA==
X-Forwarded-Encrypted: i=1; AJvYcCUKLLteTlc4K457j3oZfG7JPWlXnt2ltviYEoikTxplftLwr81sp0IilKU2YpdTcacbAhSLFGzazwMM3DCoOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiOiLhOmx3JuA5j6fhUDopTyj9b/+32UoEgfQC/s/UJagnVF2m
	iai2tgo7ljXs96p1QjYrQEloGMCSnG8bBrVTLlP44vt9qDFt2cPfOTlUqXbSlpXc1n7ZqNIK4MW
	ACxMqsUvPqjhGArQjD0kkLfif5t752u5AMAGbYF5ScqAcFnHo6pl/uO4cSTKTmxNUNFBw
X-Gm-Gg: ASbGncvVxMUJmFIjCcOhP1RzkQweuHJ3CPtWZw7/+tivcl/38P1PPSRI0b4slvQzTvX
	pl99SYSSQYHBydqvV5NV+uOocYmvDGOih8SDyS/fPNP4rUTeMDyLM1rpZ0DaV7p33rK0+9X9rQ/
	InPNK8RcbkaQuqgckVBImZCE4aBA5US3I00sUo9nxuEpO2Rdq5sO8ZV6B8cmXhmU6hlIeJzaBba
	mz+nGO4EqgUj21dips5h/8ezrKVvqhptk0j9v5ldLk2zLY5uZHfsjqV3jD34lp2+GXRfZaQn6x+
	lTYkGwISNS0NrE8oC0zPYvKlHL7iNLraa6hseAI6yFC+T58j80QGIvg9zuA7oEOmnerUKC4VWln
	5hnPlDyWjH7NGL1APJhxYSf8da6QsEg==
X-Received: by 2002:a05:6000:2893:b0:42b:4267:83e3 with SMTP id ffacd0b85a97d-42b59328eecmr17242528f8f.5.1763505596148;
        Tue, 18 Nov 2025 14:39:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD1WXbpeTqGswyhHCbNu0ZoFpF+0A5MJA/2kp3FgmfFeFluN/ImIhzShp3w5/uqusP1NAnZg==
X-Received: by 2002:a05:6000:2893:b0:42b:4267:83e3 with SMTP id ffacd0b85a97d-42b59328eecmr17242508f8f.5.1763505595682;
        Tue, 18 Nov 2025 14:39:55 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206aasm34790802f8f.40.2025.11.18.14.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:39:55 -0800 (PST)
Date: Tue, 18 Nov 2025 17:39:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 12/12] virtio_net: Add get ethtool flow
 rules ops
Message-ID: <20251118173847-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-13-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-13-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fxja-kQe8e7y8HsDNhc7hmTX-E5s28Mdyo2wKT8dBxs_1763505596
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:39:02AM -0600, Daniel Jurgens wrote:
> @@ -5665,6 +5672,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
>  	return vi->curr_queue_pairs;
>  }
>  
> +static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	int rc = 0;

not sure you should do this btw - it is set on all paths,
and if you do not set it here then compiler will warn if
we add a clause and forget to set rc.

> +
> +	switch (info->cmd) {
> +	case ETHTOOL_GRXCLSRLCNT:
> +		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
> +		break;
> +	case ETHTOOL_GRXCLSRULE:
> +		rc = virtnet_ethtool_get_flow(&vi->ff, info);
> +		break;
> +	case ETHTOOL_GRXCLSRLALL:
> +		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
> +		break;
> +	default:
> +		rc = -EOPNOTSUPP;
> +	}
> +
> +	return rc;
> +}
> +
>  static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);

