Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EE2C325D
	for <virtualization@lists.linux.dev>; Mon,  6 Oct 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762638; cv=none; b=GhXk/0LfJIp3SLtpvZUYIEk0RCKM/jH1fYaUtYj05lHxOg4lsnYQ4/EcpfgJ6T7YbuYIN9TpjTmbCMyJ20lDLzdE7Vk+Fv3D4yXk8zxYuMjV1fin4ArGR0O2UEI8I+kNwRkV5hwXtj4zIhuxrKK916EXsNJAEKEx/6Y3k1o5vwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762638; c=relaxed/simple;
	bh=jhanX6T0C/CgFwpJufY1Z11zs77Vwb4iEfdm4wPkXWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jacN9VWVE1xO+x8d7pXQmuHfqTGu/vxXPPRmFSPruRU2zunS2lTYnjs/DoP0rPWjoWQ3VKCRdHX0RK1481B2iSvSvTHFiTIkablGUZu0TEPdsDscirFKcM3/X8mOiTkET5dvgsumMqfYtsZPQWn6GlPga5vNTARHLoc0CJ5xnWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMz6WpbJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMz6WpbJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759762635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp5ApOjH4RCi6YxBNf6Q9TZoHxlt3LqlFYkBMPytEDg=;
	b=DMz6WpbJf4MNkqU4FJ1POT8iYq8mDjNxH/ZRaJC+gmCxsAWXd6KstxJVtVk/REiceSp1Jf
	pCbgfesgtgJcusksk/8vmKSsoGpp7ldFmeAcK5/P2irBMyzJ51lzzxUar+iQ9weYnpgv28
	up3rjQ56fLb+OD0L85cL/jWD1SVBmdA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-4yFAtWOSOsiHj4JXwKtbzg-1; Mon, 06 Oct 2025 10:57:14 -0400
X-MC-Unique: 4yFAtWOSOsiHj4JXwKtbzg-1
X-Mimecast-MFC-AGG-ID: 4yFAtWOSOsiHj4JXwKtbzg_1759762633
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ed9557f976so3336292f8f.3
        for <virtualization@lists.linux.dev>; Mon, 06 Oct 2025 07:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759762633; x=1760367433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp5ApOjH4RCi6YxBNf6Q9TZoHxlt3LqlFYkBMPytEDg=;
        b=dcq8LC0Ko0R0wHFGl5uPV2xW31TCg/40ZWwXoGYBH75xM7RkiZ/cmxNkXtuom5Wm9t
         lbSmnY/gPZdWXy7HehYmXYngopaYGOUGiZVMvx9jDJshSTGAIQAlVWW19y+syf3uSSYU
         eNgBM64CK6BwfV1PME2yDt9QWpYdyEqwW47f+qw1giOgDKa7ehuHVf6GYOfE798lxX6H
         DJmAmRZYGOXHDVvxatVCUsLEMzBD9HJRVOEpmeGqObfHUp3ZV8FgaQXFWqg+BrdNod/2
         utTbma/uMZBuUqlK8vX0JeEdPQd465U6sRwnlTPuIYi6zqmFSp7s29Joq79u4pPyQ95x
         fTCg==
X-Forwarded-Encrypted: i=1; AJvYcCWUuqAq5QdAtOXBgPn31moRBQ4dolWlZdCaBoJ+hldqJU0z6T7/eUrQwNMEp9pyZTF7C5bB5xUkPNZlI3B4Sg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8ntY6iuvLbNj2MxcuccvAKkU3DnGeGCORmvt6SagXEAhB5dwA
	Irz0VX/3W2Qo7AAIIo5J8fJws9aCCl58O7vISVd1ElWBK7wlhwAE9r8avFSEYR4x1LZ0yndwWmU
	y5XHSLJZr0KV91Gk6IqmYiOZXvH/hztcmgRTBuujYVtI2WfrXAlKnZJoKv7oXhKUUcdDC
X-Gm-Gg: ASbGncuND4UcqZFBXrvHskWDpY19tqb/5P7eC3QciB/6AVj2SEuYN6hZyreTYUPK2EZ
	LoXhSCk4ROQlxNqxQG4JBhBjIFlyr5cbNaLrjSFFbqtWBkPhcrg2KneuaGWe1+i0eeYJ9PYDNP9
	2xGClbkvNCREspJ8IRsGSqsrfsDEDmF29IQDnhxaMgxZW/YS4R4rffIzRzwBJhRaoM1ze+FT7nE
	Jc/j01l5mwLvqt4i7/gfy9GGZ3arpSYDfawtxRydE0wU1ibjNZZQ+okH393rnTwfRhpFM9OpLRO
	YpR5OwdpZ4MG8AKERfFsjrPRIKqj3PXVaA0atKM=
X-Received: by 2002:a05:6000:2c0b:b0:3ea:c893:95c6 with SMTP id ffacd0b85a97d-4256714d54cmr7467171f8f.18.1759762632892;
        Mon, 06 Oct 2025 07:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhCh+WQlE03GS/5i0teFXU29iwxX265IzFV+HGIBnzz3VE2lFdRIe6xVdZDphPiu/L9OdYuA==
X-Received: by 2002:a05:6000:2c0b:b0:3ea:c893:95c6 with SMTP id ffacd0b85a97d-4256714d54cmr7467149f8f.18.1759762632376;
        Mon, 06 Oct 2025 07:57:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f02a8sm21594716f8f.39.2025.10.06.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:57:11 -0700 (PDT)
Date: Mon, 6 Oct 2025 10:57:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: stable@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Daniel Verkamp <dverkamp@chromium.org>, Amit Shah <amit@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
Message-ID: <20251006105608-mutt-send-email-mst@kernel.org>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
 <20251006062851-mutt-send-email-mst@kernel.org>
 <a4e912547211eed865bdf769647936c1e3034e4e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a4e912547211eed865bdf769647936c1e3034e4e.camel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CaUyHcK6Ojr24vLQyW4Xmz_rcf_c8uIv1_YX4s6jigY_1759762633
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 06, 2025 at 04:15:10PM +0200, Filip Hejsek wrote:
> On Mon, 2025-10-06 at 06:29 -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 18, 2025 at 01:13:24AM +0200, Filip Hejsek wrote:
> > > Hi,
> > > 
> > > I would like to request backporting 5326ab737a47 ("virtio_console: fix
> > > order of fields cols and rows") to all LTS kernels.
> > > 
> > > I'm working on QEMU patches that add virtio console size support.
> > > Without the fix, rows and columns will be swapped.
> > > 
> > > As far as I know, there are no device implementations that use the
> > > wrong order and would by broken by the fix.
> > > 
> > > Note: A previous version [1] of the patch contained "Cc: stable" and
> > > "Fixes:" tags, but they seem to have been accidentally left out from
> > > the final version.
> > > 
> > > [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.com/
> > > 
> > > Thanks,
> > > Filip Hejsek
> > 
> > But I thought we are reverting it?
> 
> I'm kinda confused by this question, because I thought you already
> understood the situation.

Yes - I just noticed this backport request stood unanswered and
I thought it's a good idea to make stable maintainers know it's
not yet the time to do the backport.

Sorry if I did it in a confusing way.


> I sent this backport request after a discussion with Max in the revert
> thread, from which I got the impression that the virtio spec
> maintainers were unwilling to change the spec to match the Linux
> implementation. That impression might have been wrong though.
> 
> When you sent Linus a pull request containing the revert, I realized
> that there was no consensus about which side should be fixed (spec or
> Linux) and told you that I think it should be reverted only if the spec
> is also changed. You then sent a spec change patch [1] to the virtio
> mailing list.
> 
> I'm not familiar with how decisions about the virtio spec are made, so
> I don't know if that change is going to be accepted or not.
> 
> [1]: https://lore.kernel.org/virtio-comment/7b939d85ec0b532bae4c16bb927edddcf663bb48.1758212319.git.mst@redhat.com/t/
> 
> Best regards,
> Filip Hejsek

