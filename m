Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782F30E0F2
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143462; cv=none; b=sAYpItVjVq2crgAIAktwQxPlA5g7s3i6sm13dz7YI15zgJplQeA9xGFz2k+kaGLAgG+lK+2uTINkFyEqWbhAuoTqEPZnZiYBLzsncfQENCSvvf2xT0A/o84PTR7swBJccixOJwGP7Pnm7Rtz/50RFmOTwAL6Nii2GxM/su1GSW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143462; c=relaxed/simple;
	bh=EULeSIJ8HNnMPsQZ4YnhJWYAbD8Oae+53dQmmt9inXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=X3vhylFYOTf3g+Ac5RXYK9qULLwLGLhx0THsKGERLjxJpeiyG6wzVX/0lr8DbOIQ5vjBJm9zpoSveR1khk8gTYQmLsEA9Tb91jtSIYQLsrF2HF0RBTT6ah7ah5Aa7qYMX5WQh0YdkKfyRSPDfyHGNoRH2g6G0dkXyIdET1OCdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqxYI4DH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqxYI4DH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792143460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEPuNhSxsbUvh+PW3O30AyJYlH++sXV5pTbl3odzk7E=;
	b=XqxYI4DH8gD1zWiiceV4GYWN5vqXxNZW3MUaeoAksja61e1oxNvvYh6l/elkWy0ibMlQ6T
	KEIJkh4h9f7sYd3hbQCHiFvhc8MRN/YzBipqt6dtldGydlkQYTyK//JQKOhILjaHnfh5Nn
	m/ZTCjAI6Ir49oiY6GTDQyojRxrKbNs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-LTzSIxtJN0iJNvyfD_6xgw-1; Fri, 16 Oct 2026 09:37:38 +0000
X-MC-Unique: LTzSIxtJN0iJNvyfD_6xgw-1
X-Mimecast-MFC-AGG-ID: LTzSIxtJN0iJNvyfD_6xgw_1792143458
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4887e5afd67so4817577f8f.3
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 02:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143457; x=1792748257;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEPuNhSxsbUvh+PW3O30AyJYlH++sXV5pTbl3odzk7E=;
        b=sxF+M+EiqV9l4FTZEcLr46yj1tdms9Oz224pY0eopz/gh9c52edkNWrZiEbGUrwIio
         mi3aaD1ciCY1ku5JSR4iqYjvIdLpmXGI0jN/gDIaHi3Atrn0zGY8YJfrWjG5N0yl0tJm
         W6kmAXU/QjyqZkHY/wJCp5CsODVBmQseCAif1Mdv5v0M2v3ZmJP+0958c4RfZGy98qBj
         EOVuilEObCISAEF5SbFdnDXWaTKH7bJplgDym29fIHK2Hj3pSY+QjwGEyXUtHrGinGhR
         64EDd+sdykJJ6Ay0gJhAa3B4SGymq6xxtG0et5z4e+EgzjDk7a/J2VYHUoJRAZU3LuMt
         HohQ==
X-Forwarded-Encrypted: i=1; AKwUvBzW8UeGTvutZd+q8cwnUzBbkuMgift0HwlfxOHIesfN/2QyKFsDaCeSJwGueWFLuV7/rM3Hm3vJKTs8pKc+7w==@lists.linux.dev
X-Gm-Message-State: AFq9FYK2XW7d3YA7SGMeWf9oPR9dz1NWWvXR1jZeyff4z+VF2Ww/c/WN
	LQtKCHyN51zB+aHKzpCZvy5mmcsAJxzBlISkW46L3eyxUywbuCLgNX+41oo4hIk7O8+kPJtYYKv
	h82+HEDQKtpNevaBZ8VfUs+SNOO/XoWFcOqYcyr++zaJHCGO7KbfSFtt191Otw0D3IwMs
X-Gm-Gg: AYBFou1oXJhc41TvS0uTuQ3vbbOz/dkzk1uDQL4ZwPI6gvqsl6RwqKSgAO6p78/6cMx
	/gJSVUJRQtbEfJKRoV+RJkDb3dY7RslKvxsY2ZfMxIuSaFU9pOk6jwFmfRl/glI2caYzR2Piuh/
	SA9W19QzvOCTfSFW9yB+U28QVHSW4rOyVjVnjgk1ehzR2/KCUA33h7mHB0YqN7a/9b1cYH9SS9u
	b/ZHmi1ubNJslhJzHXZSBNdts1gn4P/eFlT0UqtnwvhR1mxdpDRTwKVKFSC9W03eNdXMw9CO+1w
	2KZYwt0FjP7KQmCNjLvIAdgNh8QyicaY7gfS+QeYVsK5ssbrPtogjazsT0LmJDm9C7F8oA==
X-Received: by 2002:a5d:64e3:0:b0:48d:fd48:86c0 with SMTP id ffacd0b85a97d-48dfd48878dmr4551002f8f.47.1792143457367;
        Fri, 16 Oct 2026 02:37:37 -0700 (PDT)
X-Received: by 2002:a5d:64e3:0:b0:48d:fd48:86c0 with SMTP id ffacd0b85a97d-48dfd48878dmr4550928f8f.47.1792143456859;
        Fri, 16 Oct 2026 02:37:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5008e7sm3899434f8f.43.2026.10.16.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:37:36 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:37:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Message-ID: <20261016053633-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
 <20261015085119-mutt-send-email-mst@kernel.org>
 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aOcJK7KhF4HbJqo2njql7sngJ7tKLmTSTBo0sT0mr9Y_1792143458
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2026 at 02:55:23PM +0200, Johannes Berg wrote:
> On Thu, 2026-10-15 at 08:52 -0400, Michael S. Tsirkin wrote:
> > On Thu, Oct 15, 2026 at 02:47:01PM +0200, Johannes Berg wrote:
> > > On Thu, 2026-10-15 at 08:41 -0400, Michael S. Tsirkin wrote:
> > > > virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> > > > it cannot make sense of, but the vector raw transport ignored
> > > > its return value: rejected packets went on into the stack with
> > > > their metadata unvalidated.
> > > > 
> > > > Propagate the failure.
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  arch/um/drivers/vector_transports.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> > > > index e1fb2a76fdff..8b7548458663 100644
> > > > --- a/arch/um/drivers/vector_transports.c
> > > > +++ b/arch/um/drivers/vector_transports.c
> > > > @@ -210,7 +210,9 @@ static int raw_verify_header(
> > > >  		return 1;
> > > >  
> > > >  	skb_set_network_header(skb, ETH_HLEN);
> > > > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > > > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > > > +			virtio_legacy_is_little_endian()) < 0)
> > > > +		return -1;
> > > >  	return 0;
> > > > 
> > > 
> > > Seems it'd be simpler to just
> > > 
> > > 	return virtio_net_hdr_to_skb(...);
> > > 
> > > As far as I can tell, the function only returns -EINVAL or 0 (never a
> > > positive value), and the caller only cares about negative (error) or
> > > positive (no checksum needed), so that'd be equivalent?
> > > 
> > > johannes
> > 
> > if raw_verify_header can safely return any errno - i did not want to
> > audit it.
> 
> You already used an LLM and still didn't want to? ;-)

I don't really trust it to do code audits especially in code I
do not test.

> I checked briefly (by hand) and it seems fine, it's assigned to the
> function pointer, which only has two callers on the _kern.c side.
> 
> johannes

Thanks, will make the change.

-- 
MST

