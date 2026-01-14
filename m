Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B702EACF2
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410745; cv=none; b=IklPgnuCgghTEsk/LcXjDYZ1rC1rHkMxeGFlQiXnvOl9SS73TBsYhPAw88ona4Wm5q9FL4iIUm87XHmUPqcR19b6EwvA5hrbKKv0GWQtHzUP8UFfT7tUXrcUPkonAbYOSPEKiYv+n2vhaAACiVo4L9Vc+M8564caexB4uu5ji48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410745; c=relaxed/simple;
	bh=p77GEG+mB5piIaHLHG+aeaef+IL/MBZBpezD3NGQ3tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stewVjQcITxFWQTcbqihK+6n/UQpRRNKXo6hGuTzZzSv2MdWaO53a7hvJYoK5wj0JIa6UJ2SAn/+him/pSkagJ4TfDD5a2bBIv8qB+h29aLXKMKM4fGE5MNJWHOp/gFtkPiJ9SpG3k5nJOQVMhQ3Rqz7PWtuoMpijBkOfNZyOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Wn13rNqi; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Wn13rNqi"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b1bfd4b3deso2660285a.2
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 09:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768410743; x=1769015543; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLZK+PqSn6nIdPCyk8+Al7PM0O31XRvufO9b7gKXcTo=;
        b=Wn13rNqi2pkbM+nNfoz7H0qwwD9Aos8HpXnfcLF9qiysqtUMlOsQNBRh6mxRQQe7v+
         yXuy2h+fzYM16QT8BgQHey1ModQwja1HNQk4Qffv3ASBkYJuH2uvUWEyZanOisQO/K2Q
         06FsezDrLG4eM5Y9UmQzNABR7wOdG5MsWbqzOieRTDjwFJjq+tBodrWF35YkXPDnm0y6
         uhpC/vAwwBpGHfZrmscr6l6fXiV0tob1BdY1ZG9/s/NAYuJHDE0OsV74znWUzbP/UYrY
         vuFv0BavOO36B0GodmeIG6mS9iB2mBL0TLyUStnW8fLZmMiIU8tLDnKzzunWCizn6y0A
         BcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768410743; x=1769015543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLZK+PqSn6nIdPCyk8+Al7PM0O31XRvufO9b7gKXcTo=;
        b=aSzqcYF+O0S+0Dw9ge3fPIbKnfYbBJWWZ/hcrz5YMhd4G3hg5776iJwsEaB5cklzAr
         r+SoGs0F5v/aKs+cp//GccMYyQP00oxTrFFVdJshSwy2+TEU4IxnwoVCy3tywQrxBOQQ
         CExDdQfPBDA5g58dMxsv55oiBeyGXx7ysrOUO9iWf1BqA1wrxfcME3/Y2YqNvNG5+0Oy
         xcLocsxtuIM++cmNU3/ER/spxNktpHVEeGefuRJCqygOs64Q8Fq5ol/NkPUd9B3/GPl6
         cLecxsEuWwX73IG8DfS95xIdXKPb/0ZRlv6AhnOM55/cO4slwHayif896RMAYEmHy7GC
         uuPw==
X-Forwarded-Encrypted: i=1; AJvYcCXnvEtEXJb+z7bjv7z5wEqV93QcKFKB8hqEVjflEaYGodKmYABc6issL0lAkaxfVsfZedO3MHYYscyKcVi4qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPNxe4qB9uOXQvPiwRg8ndhHrdj6MklCw9QT0gIG/pDRkeDvH8
	7s/sH6iDmCA3VyB5IK3X0tVdWrJGRbADA3ztIUcPi+DHlP2TwVsjowlkCLoz2UmBdhA=
X-Gm-Gg: AY/fxX4wJ7IKVRUNCSkvu8CDP9IFo5hDpvw+rzrmadrMeFqVLy+8YXfeOLG0C/AT5k3
	2ggiWFfIB/WM+ZLlerFtSx1bCE3CiZJhzIniGB+rrr/+JZpM+7trOniZdbOxQlnHuuQSddEvy5s
	K7rQLPkQbFUnLwgWoLIXIjStpXk32EFoQPKVHnRo7iY1gTUz0NAi0NNMAAAaDdJt4sZ/fW11Yn6
	JAO2xNGbSzdMbs3BGibH20ADiTsDgZLUcXQ+HsKNFef0kX9PG9R5PLbyyFclIFsuJP5mDMVS4eK
	Zm4ugpPVlkrLv1mb9iJLF4hTjt8OM1QWiczHtJxsPRdjz6WkyIov9ICxhD786kUKCM0wZEmnxea
	eO8rkgjaWS9mmy0BwKjoKy5J65MdPBXotjx/IoZv98zf4OK8sYSY6BH96zE67Rt7Jl4WyeKy1GO
	qHHe2twofoy7o/7IW90z9yo4hkCCxIuKgAc+3n4oVbioYK/J7U/gpReRXZOF+M1x3afLM6MhwZo
	ifVmR/8
X-Received: by 2002:a05:620a:f03:b0:8b2:d6eb:8203 with SMTP id af79cd13be357-8c531808de8mr358190785a.69.1768410743009;
        Wed, 14 Jan 2026 09:12:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530be76d1sm201549285a.48.2026.01.14.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:12:22 -0800 (PST)
Date: Wed, 14 Jan 2026 12:11:49 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 2/8] mm/memory_hotplug: extract __add_memory_resource()
 and __offline_memory()
Message-ID: <aWfOVd3_GGTNHKNt@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-3-gourry@gourry.net>
 <c4ed9675-269c-4764-86d5-87f4f83fc74d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ed9675-269c-4764-86d5-87f4f83fc74d@kernel.org>

On Wed, Jan 14, 2026 at 11:14:21AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:51, Gregory Price wrote:
> > Extract internal helper functions with explicit parameters to prepare
> > for adding new APIs that allow explicit online type control:
> > 
> >    - __add_memory_resource(): accepts an explicit online_type parameter.
> >      Add MMOP_SYSTEM_DEFAULT as a new value that instructs the function
> >      to use mhp_get_default_online_type() for the actual online type.
> >      The existing add_memory_resource() becomes a thin wrapper that
> >      passes MMOP_SYSTEM_DEFAULT to preserve existing behavior.
> > 
> >    - __offline_memory(): extracted from offline_and_remove_memory() to
> >      handle the offline operation with rollback support. The caller
> >      now handles locking and the remove step separately.
> 
> 
> I don't understand why this change is even part of this patch, can you
> elaborate? You don't add any "explicit parameters to prepare for adding new
> APIs that allow explicit online type control" there.
> 
> So likely you squeezed two independent things into a single patch? :)
>
> Likely you should pair the __add_memory_resource() change with the
> add_memory_driver_managed() changed and vice versa.
> 

I tried to keep the refactor work and the new feature work separate.

But yeah that's fair i can just add them to the respective path.

> > +	/* Use system default online type from mhp_get_default_online_type(). */
> > +	MMOP_SYSTEM_DEFAULT,
> 
> I don't like having fake options as part of this interface.
> 
> Why can't we let selected users use mhp_get_default_online_type() instead?
> Like add_memory_resource(). We can export that function.
> 

Wasn't sure if that was preferred, I can do that.

I think i eventually ended up doing that in DAX anyway, I just never
came back around to clean it up.

ack.

~Gregory
