Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2E27781D
	for <virtualization@lists.linux.dev>; Fri,  8 Aug 2025 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655320; cv=none; b=KIP9G8CvznbaWdXS9fexGcnSZJ0jrGJ3mpLuHyek5hikoH+bGnw1JoddjWxF4vuVqzP/hb+mZ2f8rCo53DPaqvg4rNEXbemKHCO5rv5o8k/m1HSfD2a3XGJoP4cDDHJAbajyMoovv5Jay/b3PdbdhJy+hoYBQI/+GSbUcrYcJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655320; c=relaxed/simple;
	bh=KjlLTJox+aEPkr7SyVNi+vSqzknO8UAJgxNui7KfZqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5t86+js/msagSmWd36ipMSPW0te+1BaFEYE+6jKtDQNhEZbZMvv5msiji1tfZCDmR5xeUUaXJ63ZGtpE0FWHc7OHoPjjDD0mBDuxE4JQLzSQvXeNrg6YQBxI+8+uMKRnsnk/GZ9W0iEPZUtApAy+10ZA1jAq3/URPYEB4wByA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nn0RlVvw; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nn0RlVvw"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-707389a2fe3so18665356d6.2
        for <virtualization@lists.linux.dev>; Fri, 08 Aug 2025 05:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754655317; x=1755260117; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjlLTJox+aEPkr7SyVNi+vSqzknO8UAJgxNui7KfZqI=;
        b=nn0RlVvwevLQ3091xnDjvRZtr3uLG0kw+5+CovUOpM16fGeL4OGBZX4DBLhIs3Qme6
         0HwamN/3ogcpnFYkLOYrKM/Dvv7RGbvhdSBaEkibEqVOJo0r3fZwyNoS7sib9HvymrAP
         d3xrYao5GdLYpqT2jEvPZgMoYBXZX/O2qlOwynx6b/wipU8beOYKvT6POFzXLNBFWWN3
         sDaUC4Zrjrj/RgbRazmOHOyY3WozQajyxFaSw8sF0S8LrtyrdyueE6H8Ad9BER9uD8Fp
         Pqy6BgOJlAHVWTBb5GtiJ/B/M1aJ615GfDCHHR3zh+B4LcVKQUdarnjuIaDvFInS1qdm
         5cSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754655317; x=1755260117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjlLTJox+aEPkr7SyVNi+vSqzknO8UAJgxNui7KfZqI=;
        b=Yhsv4gFQQ+sLY49BYzRUB4lTd8p9UXrSqx550pekV3o93yUhoRm3XYbChCjs9xNglF
         nPtDPo/z/gi3IBDNvpUSHmCALOnuD5TDzvdeShp1tYJVafr0mIZX94tzpbdP345yAj3i
         6rE+0Ig9t0YFSZr8/iFVB7OSqNIoPuHzgpUqNmqsqCN5nksYSHywiepoWWMryMAewIW8
         6AxHstGiKLOcxE1klWOm8Z8Ot8PPtjMtWfEMUOZYOdmaxYIJ53Ip8k9s+qelNzVGr206
         GzrLeMGVPU+qi4MCtzCRUsTULH2fbdzTeNLJIT+NaI0tv5oopUwOzyEvxnfM47q+KuHu
         c7/w==
X-Forwarded-Encrypted: i=1; AJvYcCVa8UG3piZO1sMCiNARcw+3vcj/2QJ1I4XBCOJdqVVh4kljCDsnY/EbcheRUtvBtgCmP8nECh/k7+Z1tgm/6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXbNoPqqMhqSFcrxE0XXU4MLxks3MbCF6utvsYgCw7fwAOavR0
	/oHyjAVgrYjP8KDpi6q3tNL2TNo9A5eu4umdFuaUj6c5HaEUxXnVU+Ak82/25gaLVG8vi1xWS/d
	1pqNy
X-Gm-Gg: ASbGnctJWjgZKRCZdcBRhD63oea37bHiKGeRmgT/hySSlKwPGfHg2X+JTk5xJEAnL06
	56l3GwoWUOquCxRTxGArOm0516kP1XQAO8+jqwMvIJHGJVlhjlrxLQTb5GrEhTtbeDGe74Gw/w/
	2YrFgPmKFZQDQsZmF9tC48QbxnSMOyW995L33eNS7tyBIb5SaI85voPhFNUY2k5+gzdej/xK+EZ
	SeoMVFy0xIquoNjm4pj9GjjKYnn2pW/MUyIs4rguqMDT3xSm5JMbujahOw18Lu+cPjz04o7Dd5f
	7kE5X2/Ur9JMITNklPDBkc6SvtXcBkqMae9IyQ9r/g8wi+0fx73RgCuaCt533g9uY/SG0slnWts
	yWaWg2ENL/VRfeJxBgnco+G7UOozSbNnvCZWomhxVFNqzP8kBGN2Q2fYLVTsFnYRQoxUa8xGwBs
	opzQk=
X-Google-Smtp-Source: AGHT+IFydq6l6b5JXXNn6gOqeE0yXEq9dZ/J9DKgW7tPI3RiBa0ZAO/jnR4IhHmIeHf5pIqVx18YPw==
X-Received: by 2002:a05:6214:29cb:b0:709:3d74:2ed5 with SMTP id 6a1803df08f44-7099a301143mr35261076d6.29.1754655317080;
        Fri, 08 Aug 2025 05:15:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cddc290sm112232056d6.63.2025.08.08.05.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 05:15:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ukM0B-0000000256j-2zO9;
	Fri, 08 Aug 2025 09:15:15 -0300
Date: Fri, 8 Aug 2025 09:15:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com
Subject: Re: [PATCH v3 2/3] iommu/of: fix device tree configuration for PCI
 devices
Message-ID: <20250808121515.GE377696@ziepe.ca>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
 <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>

On Wed, Aug 06, 2025 at 02:55:38PM -0700, Shyam Saini wrote:
> Individual PCI devices lack dedicated device tree nodes, but

This is not the case, you can put PCI devices in the DT as well, there
is a syntax for it. Why not do that and have the FW populate it on the
device node itself?

You should CC all the device tree maintainers on something like this
as well.

Jason
