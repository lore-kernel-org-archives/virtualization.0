Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795491F16B
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646411; cv=none; b=V5MvkpfmTh0PBG4a5Oe+39CLNuFbY5u2iV1Gclvmb7qlbc8nt5BHgOtxhGHHugGwNU95Qu88eTeIrlWwbtsXvCcX3UqWUB426NUia5tvFzc5uyZkb7LVTDrDFYwIdjkGj0U7M2f8FDEW3CTU5yqQ1O6ZZL2EAk3aqCgxkpnlN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646411; c=relaxed/simple;
	bh=3GpRrQB1DypQLUYLxyCLDjQ561KIZeotsWfmMyEWDf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Q1X6yUs0JAV7tsTIU9lXSuln3eH1N4enEIKClUttGtun8wGf5wGJlvPkM2OrMxtgZTZ+X2gSwWxS362CL8S9pe6rP/1CsdkvT1BSX/7mh9kl99d2XZ4ZshQMzmtKMgLYKPHEO1ZAc78mOXH8CWVNMM6aHndYrAWgAIs/W5DYpHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIcoOAiX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIcoOAiX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740646408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyvlqtbZaeJM3spFnINaDI06hIqM+bBC6L0QBlOLKJ8=;
	b=jIcoOAiX1Kd2ws3NqXtvZGwPPxLOQf2jPwaBTSS9u8PQ/kDTYAHZFg4GZ+nk/+Xq91RDa8
	4jQHVd/kUfckeLaPf9P+02EWPBFrKCjAXrFQVcFtwOyNaousZ+Gfh0MVF3yTWZ14oOPP7/
	iowTVR/M02nTiFNpecZkbpKV+qrnRHI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-u4-_J--KP1KFCaxoATW60g-1; Thu, 27 Feb 2025 03:53:27 -0500
X-MC-Unique: u4-_J--KP1KFCaxoATW60g-1
X-Mimecast-MFC-AGG-ID: u4-_J--KP1KFCaxoATW60g_1740646406
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4c0c1738so570472f8f.1
        for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 00:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646406; x=1741251206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyvlqtbZaeJM3spFnINaDI06hIqM+bBC6L0QBlOLKJ8=;
        b=Q/xiz1LBKEua6kzIwcEZaLilhwTqLJBEATqzMQkcr3FTE7WnrJKURnzKi76Zdr/x34
         27wXKNl9gC48N3HIyW4YgWIrGArO9Tm9a7hJbPZsz+ooIMAlL/R+WFWg6hyu4K5KMBfZ
         Fjlx6Gn5bUyjJ+Dy4Ejlg499hcgZ/X8ZCUTDRHH9NyTFoY82Dp31pKEiuUcdgFxTUgt4
         +20Kr5LeonpWLHowqhntzfC9f/bXaRZhq2WPHFmxZO2PP5NL7ASrfSWGq3ISqyuEMhjR
         vYxkHaGFy3Nwyl8J5O/DnRXDNEZPI4z3E6xXFiIOqNjEXj4ChARtG/hQz0crO4bqMsXr
         kcRg==
X-Forwarded-Encrypted: i=1; AJvYcCV21aMH5h81+QEo5MfBb2HOupgALJXB0OenTuFwmT80fiLCdktkybV8wqrWPFpoasqqOh2dTXqwNtrCR1hv0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YysSb6gC1cOkf26H2N6nenUWLrl7ywbVEH4fDfKfzSYUXzAer95
	E78ZLQHgPn+xvs50lzQo3M6EM8N0owuaNTPk8wKl90cbgS+XsDBF1k5Y5+NKqV3IXjWpJnWOQXm
	YBrl7iAjfFNTwJ1TZagEsDaMhYkwT21npa1CDm6gBK2nTYWdevGPtuDdeS+YOuLK7
X-Gm-Gg: ASbGncvBLv/qZcK+1sJeG8ebJc7BS+0tRHrNjQjpmGpxtZIExk6nU9URYgMrwAr1rt/
	cyRUpzIz0UiSkkyYpq2G+1cgbGE3RKlW44F/uaj6eZkydqOHA6RzF7WKXUnVwo3HHQbELX6mo+X
	/4R24Qqpk2YS9Bi2fOgbUWO4oGtZzjYQzHgVysOC2pdcPdS0DnCOCQw9TVV5CQ1QhEc/Pw7u+lc
	Vw7/2AA5qsRpr4MuFokUqtDoi043WTFBF7gcSAJOSX1Uv6Jzbh3h9KiVld0s/IY5nWw8KC4qqRC
X-Received: by 2002:a05:6000:188d:b0:390:de67:2661 with SMTP id ffacd0b85a97d-390de672726mr3623246f8f.14.1740646405856;
        Thu, 27 Feb 2025 00:53:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZtPZ71xXc3/ezwCo25Ggz6REeCkcCkX8Y7Z6psxHYAImpw+ef4XDuShBy1cgFq9Op/H86MA==
X-Received: by 2002:a05:6000:188d:b0:390:de67:2661 with SMTP id ffacd0b85a97d-390de672726mr3623228f8f.14.1740646405519;
        Thu, 27 Feb 2025 00:53:25 -0800 (PST)
Received: from redhat.com ([2.52.7.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d12sm1361883f8f.58.2025.02.27.00.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:53:24 -0800 (PST)
Date: Thu, 27 Feb 2025 03:53:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, israelr@nvidia.com,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	oren@nvidia.com, nitzanc@nvidia.com, dbenbasat@nvidia.com,
	smalin@nvidia.com, larora@nvidia.com, izach@nvidia.com,
	aaptel@nvidia.com, parav@nvidia.com, kvm@vger.kernel.org
Subject: Re: [PATCH v1 0/2] virtio: Add length checks for device writable
 portions
Message-ID: <20250227034434-mutt-send-email-mst@kernel.org>
References: <20250224233106.8519-1-mgurtovoy@nvidia.com>
 <20250227081747.GE85709@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250227081747.GE85709@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KTc2zLdo-OWsDbN3K_st28IGtywJg6Wb8EeDlZeJ-j0_1740646406
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2025 at 04:17:47PM +0800, Stefan Hajnoczi wrote:
> On Tue, Feb 25, 2025 at 01:31:04AM +0200, Max Gurtovoy wrote:
> > Hi,
> > 
> > This patch series introduces safety checks in virtio-blk and virtio-fs
> > drivers to ensure proper handling of device-writable buffer lengths as
> > specified by the virtio specification.
> > 
> > The virtio specification states:
> > "The driver MUST NOT make assumptions about data in device-writable
> > buffers beyond the first len bytes, and SHOULD ignore this data."
> > 
> > To align with this requirement, we introduce checks in both drivers to
> > verify that the length of data written by the device is at least as
> > large as the expected/needed payload.
> > 
> > If this condition is not met, we set an I/O error status to prevent
> > processing of potentially invalid or incomplete data.
> > 
> > These changes improve the robustness of the drivers and ensure better
> > compliance with the virtio specification.
> > 
> > Max Gurtovoy (2):
> >   virtio_blk: add length check for device writable portion
> >   virtio_fs: add length check for device writable portion
> > 
> >  drivers/block/virtio_blk.c | 20 ++++++++++++++++++++
> >  fs/fuse/virtio_fs.c        |  9 +++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > -- 
> > 2.18.1
> > 
> 
> There are 3 cases:
> 1. The device reports len correctly.
> 2. The device reports len incorrectly, but the in buffers contain valid
>    data.
> 3. The device reports len incorrectly and the in buffers contain invalid
>    data.
> 
> Case 1 does not change behavior.
> 
> Case 3 never worked in the first place. This patch might produce an
> error now where garbage was returned in the past.
> 
> It's case 2 that I'm worried about: users won't be happy if the driver
> stops working with a device that previously worked.
> 
> Should we really risk breakage for little benefit?
> 
> I remember there were cases of invalid len values reported by devices in
> the past. Michael might have thoughts about this.
> 
> Stefan


Indeed, there were. This is where Jason's efforts to validate
length stalled.

See message id 20230526063041.18359-1-jasowang@redhat.com

I am not sure I get the motivation for this patch. And yes, seems to
risky especially for blk. If it's to help device validation, I suggest a
Kconfig option.


-- 
MST

