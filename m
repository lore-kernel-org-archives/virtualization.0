Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EDE2571C7;
	Fri, 17 Jul 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283318; cv=none; b=nezDRTFzuvCQVj3GHrJbeovMFJv6+YDFBQiu6ciE4BMd6rVw7TzRdek/0Ik3F8RcZutJbx44qi+E5jE5Uzs5TnTrANOObhOVJprK5CKb3FlPzvx6LzwzZUtIQvVSOVHCu7sVKNE331u7zRg5hUsU65GiCmwWZ1xV26bNpFQ7/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283318; c=relaxed/simple;
	bh=hRM1b4ACwvqDiejcv0bQoBjh00zlRe2NJASWU9GfltU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBz9doBpuAVeEVnZ7nSmVWNltpaFFX22dqE+tKztTc+dZEGugRww7YnXmdeX0OYUHlNJGQxO+OWUGpnPNyvzj2y6G5bCZhZSHPxaMtBTFswoFz/znvTwATFFG1eVUKC18n7JgvxjCD+3/IWd84DeaSzSkfF5uwKtrFxNE05kM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iLcCc4XQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iLcCc4XQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAFC1F000E9;
	Fri, 17 Jul 2026 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784283316;
	bh=tO9+Vh/OyMJCiSCXAjLnrdhlHe+cVLjVIqUGgCCGmmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iLcCc4XQorqoG68AZM5liWprLiY4nNaD5nkLWAezrvT0tEAWbVF+mShF2Cp241GlH
	 92pCUea52eXMBviYC+S6It22S8yJDkZW8RQfsLDCmyKwTgoQqzVJux0E2tch/5cths
	 3hWjgyfXzm1kqbF5hqCHOG9K0g/lMuEF1gHi+bUU=
Date: Fri, 17 Jul 2026 12:15:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <2026071757-grout-composer-165d@gregkh>
References: <20260715142337.22811-2-harimishal1@gmail.com>
 <20260715164139.40957-1-harimishal1@gmail.com>
 <b2176313-b444-4f66-a71c-647b92cc16a8@kernel.org>
 <2026071635-relive-flogging-2a81@gregkh>
 <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
 <20260717014134-mutt-send-email-mst@kernel.org>
 <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
 <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717060822-mutt-send-email-mst@kernel.org>

On Fri, Jul 17, 2026 at 06:10:41AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jul 17, 2026 at 04:59:32AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Jul 17, 2026 at 10:39:40AM +0200, David Hildenbrand (Arm) wrote:
> > > > On 7/17/26 07:48, Michael S. Tsirkin wrote:
> > > > > On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> > > > >>> Or do we just always trust virtio mem devices explicitly?
> > > > >>
> > > > >> It's hard for me to understand where we draw the line, really.
> > > > >>
> > > > >> But maybe MST can clarify what we care about in virtio world where the
> > > > >> hypervisor is fully in charge of the device,
> > > > > 
> > > > > Generally:
> > > > > - The guest is expected to whitelist drivers (most drivers have not
> > > > >   been audited).
> > > > 
> > > > But even if you audited your driver, who makes sure that we consider all ways
> > > > where the device could mess with us?
> > > 
> > > A lot of this is up to a correct setup. For example, make sure all
> > > filesystems are encrypted and refuse to mount unencrypted ones.
> > > 
> > > > Something feels off here.
> > > > 
> > > > Handling selected out-of-spec scenarios like this feels like a band-aid. Happy
> > > > to be corrected.
> > > 
> > > Well Documentation/security/snp-tdx-threat-model.rst puts it like this:
> > > 	It is important to note
> > > 	that this doesn’t imply that the host or VMM are intentionally
> > > 	malicious, but that there exists a security value in having a small CoCo
> > > 	VM TCB.
> > > 
> > > and
> > > 
> > > 	While traditionally the host has unlimited access to guest data and can
> > > 	leverage this access to attack the guest, the CoCo systems mitigate such
> > > 	attacks by adding security features like guest data confidentiality and
> > > 	integrity protection.
> > > 
> > > 
> > > now, when we are talking about "mitigation" it is indeed becoming a bit
> > > murky.
> > > 
> > > 
> > > For me, a rule of thumb I came up with is that if the validation happens
> > > to also be helful for users e.g. to work around buggy devices,
> > > or maybe because we feel failing gracefully is nice because this
> > > will allow to later make use of this config and old drivers will
> > > fail but at least not panic, then it is good to include.
> > 
> > Why not do what USB does?  Don't trust the device until AFTER probe()
> > succeeds?  All of the needed checking should happen before then, as that
> > is a "slow path" so lots of validation and the like can happen at that
> > point.
> > 
> > After that, during the normal data paths, after the driver is bound,
> > trust it all you want as attempting to validate every single packet is
> > just going to be impossible.
> > 
> > thanks,
> > 
> > greg k-h
> 
> People do expect that data path validation at this point.

Ok, so you want this patch :)

And more, as you need to treat everything from the host as "untrusted",
and it must be "verified".  Much like the proposed Rust patches we keep
slowly working on, which would make this much more obvious as to exactly
what needs to be verified, and where it happens.

thanks,

greg k-h
