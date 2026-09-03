Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B84E8E1A;
	Thu,  3 Sep 2026 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452769; cv=none; b=cefeTnMXQz5//OaagppePJ6wi6YOFgWARliAGY57/OgEWp9fGFAUPskySQnVcnHdksxPLpohbOa02oPfEcceFoXdpSYNioJgndalMUOnXVC7wRngLOAFd8TtME2sqzlsT7Hmv4paXkUhn6x6xcWaI2ZbreavNuDMGkKxoT6vf2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452769; c=relaxed/simple;
	bh=Og59F8yzv67J158UPsSsM5lFNF4EuqRf14ZZN0FKw9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFxIElLHcJpnB1ESX+tr8YEBpsIx0DfvWFKHz9z/3Wc9Quentwx2MOZeJiTaTnNIgFDQ3aQs9W0HjDMVZYBm7/5s2kPSaJx7oJe/TqQMSMv8SV9KmUYh1GBUFXpxPDZZTVHWGOgZakmq8k5dBOrKGvP1EcnEvc7kW8YRZyR5Ltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXRSn420; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXRSn420"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5511C1F000E9;
	Thu,  3 Sep 2026 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788452768;
	bh=tBFnYjRmfcdV1M1q0twcPje4ka6He7iANUg+2x5MoEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fXRSn4208M62IytZTrpuK9A0SuPM20XutgfSGr4gBxwXFKR9jdHSUUj6OzoghOUhc
	 Ld1nDTS+mEYggrs56BjrYnCngcwBkU6310KUrUOOgxG91fwkbZ5PSfNJFq0gEnqI0v
	 7FdSHFLCWka/c18sP5VAIsDFUzbeMnctuQa3fit+ta4iT/LJnCAxCEgFeG3F2bgxFh
	 erhroMglOSPXgz4ZAr1uy8vinRA9IGVtQBRXaZaoE7NajSNlCHHHgCKX5oe/2fsK3X
	 J++3PZmOzed8euo/KxiIdrDzxorS/IJ8IpslCw0Q8Wg5AHBDRYrHDoSNAe9fQmjw1R
	 OoPs1C+GybLdQ==
Date: Thu, 3 Sep 2026 18:26:05 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
	corbet@lwn.net, meted@linux.ibm.com, ynorov@nvidia.com,
	tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
	seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
	rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
	srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
	vineeth@bitbyteword.org, arighi@nvidia.com, pauld@redhat.com,
	christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: Re: [PATCH v12 01/13] sched/cputime: Add kcpustat_field_total helper
Message-ID: <apmfne3iBct7oNTp@localhost.localdomain>
References: <20260903063240.268775-1-sshegde@linux.ibm.com>
 <20260903063240.268775-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903063240.268775-2-sshegde@linux.ibm.com>

Le Thu, Sep 03, 2026 at 12:02:28PM +0530, Shrikanth Hegde a écrit :
> Provide a new helper function which sums up a given type of cpustat
> over a specified cpumask.
> 
> This allows the caller's code to be simpler and avoids duplication.
> For example, subsequent patch in the steal governor use this exact
> same pattern when calculating steal time.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Yury Norov <ynorov@nvidia.com>
> Reviewed-by: Mete Durlu <meted@linux.ibm.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
