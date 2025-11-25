Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F3325492
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080742; cv=none; b=c5OTuqzOdnKrxEs5hCDjDzOQ7lJETu/ECK7Yy79vtPyJJ1cCBrWSpcdt6EM5Nhn3kCO3Xi4O+5kpGFt2WUiNdAElb0KcCmI+fUbmH2lv7IbTpMeaePr1RDw9WDL0EemVq/CWH6+6EY34QMjy/08q/cqpsk+5mzuDFHm5uZR9GvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080742; c=relaxed/simple;
	bh=qVH4EgDap5qTz2I7vTky5yddvl4rhwAfwva1oxLfzPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=twa9pz04Ke2HL8PLnOnsJVPWWrF6dT+4YFRyZjLAd9Pdnhxto3ATg7+bLBPKxqAnNPxJoJqokXlrSxmkDz6ItqPfmvfMXSzXryfvX83GZK/FN0hX+YFCB1fqf3etpgAqLplv1lXccsmUXezCGfP6kL6VnEF5H2Ru4wPUiogKWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0ilBhc+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0ilBhc+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764080739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr0i1Bnz9J7tkbwtcawYQEZH/SpsaGOcMG1YHu/LOuk=;
	b=d0ilBhc+guYx11fJTXH/XA7hkZ1oT+HVaf2ssoxo+iB3F+mfqOWjC1ueYVgm7PXFLhUz8b
	BGACnewmmkikJ7Sx5TNzj7Nr18k89z7iaM1TEcUVz6+YQ/+ewTyg3YsDD+W1HCAJHX6rTj
	9JmtEvLOCkrZtnlWZ4ZaY2zBvcavPUI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-td1ELWk4MjCzN9G196nc1g-1; Tue, 25 Nov 2025 09:25:38 -0500
X-MC-Unique: td1ELWk4MjCzN9G196nc1g-1
X-Mimecast-MFC-AGG-ID: td1ELWk4MjCzN9G196nc1g_1764080737
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cce847c4so3826027f8f.2
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 06:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080737; x=1764685537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr0i1Bnz9J7tkbwtcawYQEZH/SpsaGOcMG1YHu/LOuk=;
        b=cw4/sareJONrpKb5BT8/1GZJDpp7vPOiS4HDooUuJgYi9UCMcxXK8RC6OYbFprlBwz
         rxEwh2MUsWgo0C87DPp9/Mp3c2B03qNczp3eVHcrDFDaXLencC64B+Grns7Y702MrM4I
         t1Ub6NXsvVYt4ourDHk3XLTLa0cq5eX2zo+jMrOiBM7p9/OZzLE67XZeiITUSePrpU18
         oLGA1Kr8sQOFTmZDo5isOnNDK3Kz6WtRbMM4gBZs8d62PXdRyYuNNt/+TGzIbaaiqeq+
         tzJ26s+VChwBlFhyYCNtY5uIfjSqqJ25GqRC3Pvlp4Z6HCpWSFtbg+M3c/z3U+NL0/Wa
         k2ug==
X-Forwarded-Encrypted: i=1; AJvYcCUjuJrbDLANELeIUZ7vKRyrBZI6R1YanEexuYC723Lq27c3yjRxLLZcXQjwS08xBURDpI4v6AytuKjgEyksRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkXza0XyzcRgXRkGUIHmdxU/wyZwTVrXfNsb8aubghDUotoDOE
	dA3Ap+Xh6DoWV2yBi3FZwLtclrSXVba7mUlSpEJRiByjqNsvY12bPg7EVW0oVww3B0CJ/9+KBxF
	vf+iyXZTfasezUg9o5VXe5Eu5uKgrIMsIvoSJbiw9KfumWntyLUyqyx/kKdy0qypEeZdK
X-Gm-Gg: ASbGncvHpcV2xoWD5dXCROIDBSOo1BlrAh8IG3xm4DwDzAPGJ6akwhZ5LWEfNO/OkA/
	26NecXygb4q3DEVyevtvmKND+zUTnRmoO4qBoZSPSjLA9cfQyIGomcvXiFIiKGxPgyxiFJAFN50
	cTPH3iOR2eZ/01wrehne0+f6qcs7wTBPp5y6ODo47HbDXVeLzOui5TcukD0P/bVz0Dyd3Ub40Pl
	L9YQSvs+MsNek7aFSEDC1lwO/ChcCn8Epc0B/LkG2kHSSjuk+an3VbWFAR7MTDDN63dTUq3FDbX
	d1JoXro+u8Er7So6P3EumeEjtTpEaZNm6EPgiNV3xo4H28fOX3pUqcl/HJ2uuiIN+IYfqLRvwtZ
	yh3199o9suElYI6A=
X-Received: by 2002:a05:600c:548b:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-477c01c4c03mr159629735e9.23.1764080736781;
        Tue, 25 Nov 2025 06:25:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGWUY3ORBZQM8nQhsClHy4gnQBeQmJgXaZyttfwnGynYrZLxOGj2nr3DxzGuetAdDy9u3GgQ==
X-Received: by 2002:a05:600c:548b:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-477c01c4c03mr159629425e9.23.1764080736339;
        Tue, 25 Nov 2025 06:25:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf355933sm262722995e9.2.2025.11.25.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:25:35 -0800 (PST)
Date: Tue, 25 Nov 2025 09:25:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20251125092418-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119191524.4572-8-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5b4j-yXX0rgThzfbKFL9TVUppOal6LIcsy3o5jAuaAo_1764080737
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:15:18PM -0600, Daniel Jurgens wrote:
> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
> +				       struct ethtool_rx_flow_spec *fs,
> +				       u16 curr_queue_pairs)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +	int err;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	err = validate_flow_input(ff, fs, curr_queue_pairs);
> +	if (err)
> +		return err;
> +
> +	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
> +	if (!eth_rule)
> +		return -ENOMEM;
> +
> +	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
> +		       GFP_KERNEL);
> +	if (err)
> +		goto err_rule;
> +
> +	eth_rule->flow_spec = *fs;
> +
> +	err = build_and_insert(ff, eth_rule);
> +	if (err)
> +		goto err_xa;


btw kind of inelegant that we change fs->location if build_and_insert fails.
restore it?

> +	return err;
> +
> +err_xa:
> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> +
> +err_rule:
> +	fs->location = RX_CLS_LOC_ANY;
> +	kfree(eth_rule);
> +
> +	return err;
> +}

