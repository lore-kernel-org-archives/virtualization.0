Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11313A3FD
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829311; cv=none; b=RbUuMFv8nbOZxM6Qo7ez6qaIgBUNbXcs899DEXFeR0aVtNNWvwvj4qFjd1inHD1+QQh+Na2DhvRXyR14Tn6M0wy0ZfPT+K1fUh48CWnfK11emqXUCkDr9Dk7RvSSe+QlnxGjUKQa1opltr6AqF2C+oAj6uhfwMZNGSBru7G5708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829311; c=relaxed/simple;
	bh=PahFC0lyvlrBYnxKY7AMx8m5hNxr3/ZXsW7cm6JpSic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdeVrARsPA3keZ1vtoZxsgq3uxTneWEcuKXvSNlcKOrLLkCI8Gjngx/7b1E72/huW3FgM4uvp1MJwt0kOQwU15/G9MwJmH/c1i1dEY9uuWamo22HWEAPO2kBolcnmxUAAjOM/vz6GPNMH5hYsLMnwFt29knaX74gk6jVLkR5cUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iqF91SDp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iqF91SDp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cAmODblFkfgQYO+fg2NXIynxfhH6O07W/NkOwpVIwFA=; b=iqF91SDpFlK91KZ4kuPVALI5cQ
	+Jo7Jr/UpwVA79kZtB/R3C0tOEFnuV5JuPk4DweMV5S5HI9+Pi/+OPZy000aM4jKijW+6rXG9rjhZ
	65TgKdQz+LdJ88jihco4P849FdW/IikpdrlvBGVzmwmBTshRDg6a2AK8nLIqTthGoRAXZsop8/ND5
	nboANjoudbSMm6kYq+14RrDUZNDj9q66XL65ZYII5Sy10MRr2vG/lKyBiSkttAtIJ/LRxnFSEzdcH
	LRpk5qa5Ln7JTCW41HEqTMJ/GZdF9b8u9o/wUrNfPjbPiXOYvHJINpea3ocFQBNEAkuQQLjBUfPVa
	8nkkznMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWcSP-0000000FVmX-0RJX;
	Wed, 24 Jul 2024 13:55:05 +0000
Date: Wed, 24 Jul 2024 06:55:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	iamjoonsoo.kim@lge.com, lstoakes@gmail.com, penberg@kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
	v-songbaohua@oppo.com, virtualization@lists.linux.dev,
	hailong.liu@oppo.com, torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqEHuaUGuuUaL_AY@infradead.org>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
 <ZqD9-yzGxQIFlxGQ@infradead.org>
 <ZqD_ydjhUI_GCgSg@tiehlicka>
 <ZqEAUbtkIMCwVpgB@infradead.org>
 <ZqECPiU-3fJozzpB@tiehlicka>
 <400b2f6f-f7f0-4888-99ee-7327faad7e5c@suse.cz>
 <ZqED4bEIJGGHxsHY@infradead.org>
 <ZqEGAh6R7yoR5L1n@tiehlicka>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqEGAh6R7yoR5L1n@tiehlicka>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 24, 2024 at 03:47:46PM +0200, Michal Hocko wrote:
> OK, now it makes more sense ;) I have absolutely no objections to
> prefering scoped NO{FS,IO} interfaces of course. And that would indeed
> eliminate a need for defining GFP_NO{FS,IO}_NOFAIL alternatives.

Yes.  My proposal would be:

GFP_NOFAIL without any modifiers it the only valid nofail API.

File systems / drivers can combine іt with the scoped nofs/noio if
needed.

