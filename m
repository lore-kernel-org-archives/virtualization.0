Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0D2ECD19
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111531; cv=none; b=knx/Co9XQ32bWHiUkdH7DvWqowfXRw1ZnPNEy3/XnIHeyQ5lfXZCcPyQoJl6c4fxutwEiKIJyHlTz5MMfWo0L0L4t/IvPZNX3ExBxKhLGWnbgAFB9EWaDk+v40T9GVzPHUJNrA2UJl/GWsxKmG0FVwK7TRS+eKG/jVxCVOL/JFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111531; c=relaxed/simple;
	bh=BD0r+9duyb0Je7KN6QwZlA2llUYLAAoXVTwTTHeoZb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jItwMPaUPW15FWy1Q8w9t5+elUwDEfh7Ryky+z4MHFVzOuJa8qeE16uXmtnUE6CQVhkEjNc6+CRV0r8ZFrpbD+UAzGpLqdNZCvGyXuffIx8gehMzR/i/+CtnrsC4XleTH9fKvoyIZSq0RlAkJHCEowJXRZaZwiwXz/VlyZT7b/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8Qtm84/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8Qtm84/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761111526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AO9bGgHA9SRDMxQBFatU3saNKYYbXbIllCsnpW+/KUs=;
	b=F8Qtm84/xJtpNgns68525nodqE6euSz+WOKNGjFLybqRXB5HfqIQKTJZ//9BpNXfcR84uN
	WzwA3VM4tmH83sU6+tEVH2VmWPZCbXeri+8R1n/5youoSs1GRt1X0EuwU/XZj688EtfN+A
	kscov5oxbPN6VhjdEaNqDFPbjlrig/g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-6miqtC2XNqmbDnanbxYejQ-1; Wed, 22 Oct 2025 01:38:44 -0400
X-MC-Unique: 6miqtC2XNqmbDnanbxYejQ-1
X-Mimecast-MFC-AGG-ID: 6miqtC2XNqmbDnanbxYejQ_1761111523
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4284525aecbso3330228f8f.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 22:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111523; x=1761716323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AO9bGgHA9SRDMxQBFatU3saNKYYbXbIllCsnpW+/KUs=;
        b=qL2LktksTyovkHU61u75crDvUY+6Qussn5Cq1+OzwnD9IWxx74WLZyeu4EiOHOZ2Eb
         ecUi3xkkf5CHjPd4u2TvPy/dh89NoARFsNnPcKl/uD6lTga5b79ZD/I95pWI3tEpcc9w
         5MJgc+2bysxK4fSieot3iaHAPH834rAUBmXJBWDEmvQ6K6yT7Gv+8snYGJBSLfrftN0s
         /TFTO1fnnH7XZ3KZ5B2Tp7aDKNXVvwQQkwPMP2eon4FToxd6e9NUbokUZjLIhhC53WSM
         1fohHlENEfAdpPtB4+z/SsjamfpwWmVXH3Weyym2oX4cRe3iYY0pQ6WJ9jNa5izn691Z
         g0jA==
X-Forwarded-Encrypted: i=1; AJvYcCXexVzUGslatO6A7NKlSBk9XWpO8j77HbzEqGaD0Atje4dh3xirgMXat51FZT2GsdBfGwaOSgp3Xw/3t4+0gA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNebDAJgRAVStyG3P6aTe/jS1SGkQhWBUY2TQYV6RCU1jSTLnU
	bbmkLXITBnI8jczrtt5wH5TR3U/rr9xSwr/pkx7C+QurSRmB4R0e5SPk+tSMV7eWu56UOvcdbdF
	wG2gkRGunPzlenz8udW1tHWEQigUVwb4vJFMWvvfcsbTtS5sGGvowZ7gDhMjeMJBIyJDA
X-Gm-Gg: ASbGnct9wUzxVtnkVcWJPCooy88nohXHXnkZbUer6hOZQvlxUeJQhWluVinyT450uvL
	uxEhQ2Sc8bhY60wAGR8PvAqv+M+gehgjTPwRqD2hCh3+vuL7DoZVUzddVLTRGZnp4HiTQbqtFcd
	CfVC/MIvEPel7W2g0wW7WMmW3OzKI8gBF70AIB7vmEZVGv4sX1PAFZPQjgULPOMsAWFO90TS5Gs
	3KaCThK/7xBFj+fNwAYjUjkCVFbMZPXb/S9XYjphvj1aV9aVxldZyzGji1UQVGcE17Qn9FMj+3Y
	yEHE04jEloddkKnqYVD6KMoLl9+towkd8qw/A0CzOL7gwQWSql9NBNEv6e/82ewdrD//
X-Received: by 2002:a05:6000:400a:b0:427:492:79e6 with SMTP id ffacd0b85a97d-42704d83d9amr12240057f8f.2.1761111523097;
        Tue, 21 Oct 2025 22:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjl/ZOfjT4Svi3ER983luOVRdvr+S2/sxG9MG9uyIZrwESjrcFAROjL57Mw6QZVPlN9sOhBw==
X-Received: by 2002:a05:6000:400a:b0:427:492:79e6 with SMTP id ffacd0b85a97d-42704d83d9amr12240028f8f.2.1761111522433;
        Tue, 21 Oct 2025 22:38:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a9a9sm23976991f8f.29.2025.10.21.22.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:38:41 -0700 (PDT)
Date: Wed, 22 Oct 2025 01:38:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio: clean up features qword/dword terms
Message-ID: <20251022013753-mutt-send-email-mst@kernel.org>
References: <cover.1761058274.git.mst@redhat.com>
 <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@redhat.com>
 <8138fb02-f7c5-4c83-a4cb-d86412d8c048@lunn.ch>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8138fb02-f7c5-4c83-a4cb-d86412d8c048@lunn.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _uy7ZSY1Ia4VylqyECd2uB56YYTz-1PtvxBzgPI4iU0_1761111523
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 22, 2025 at 04:20:52AM +0200, Andrew Lunn wrote:
> > @@ -1752,7 +1752,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
> >  
> >  		/* Copy the net features, up to the user-provided buffer size */
> >  		argp += sizeof(u64);
> > -		copied = min(count, VIRTIO_FEATURES_DWORDS);
> > +		copied = min(count, (u64)VIRTIO_FEATURES_ARRAY_SIZE);
> 
> Why is the cast needed? Why was 2 O.K, but (128 >> 6) needs a cast?

It's not - a leftover from one of the approaches I tried, thanks!

> > -#define VIRTIO_FEATURES_DWORDS	2
> > -#define VIRTIO_FEATURES_MAX	(VIRTIO_FEATURES_DWORDS * 64)
> > -#define VIRTIO_FEATURES_WORDS	(VIRTIO_FEATURES_DWORDS * 2)
> > +#define VIRTIO_FEATURES_BITS	(128)
> >  #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
> > -#define VIRTIO_DWORD(b)		((b) >> 6)
> > +#define VIRTIO_U64(b)		((b) >> 6)
> > +
> > +#define VIRTIO_FEATURES_ARRAY_SIZE VIRTIO_U64(VIRTIO_FEATURES_BITS)
> 
> 	Andrew

