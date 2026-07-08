Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064D4028D8
	for <virtualization@lists.linux.dev>; Wed,  8 Jul 2026 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500141; cv=none; b=PKhgV6/2hugnwo73DmSEFXc+v8MT/R/TxC756OMLuusyxUINacUT4+3LDYNdeo5STmViuUBG/NNSlM9UpT7zHHiyT3ZSEnbavvtHM4Gayum3+0IBly0D3f3oecOml3uK7vjpjggeYJTN3j6a1RkT10xqF7iwTsHFBzmGLvFee2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500141; c=relaxed/simple;
	bh=LrhEbLSxsFCV2EGe3KsKnfpv2xsw+MjT3I3fHAkrdvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ap0LL17KNaKkMrXEvBJAIz8RahPnBeZaY8lXWZuHMmQBJH6ZBRJi7e9iHhdF1wRQjTjhqmMgSPRDKnB+wXRc3bsTqulfwOXopOz2bMNOkWlNIW2xlA9z+IGmI9h+m18iZMCABwi2YTS9/rbZc9HJdO9Kcn2U8Hp6H3UL5rOCbe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFcKj6e6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFcKj6e6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783500139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmMU+EsZ9VD1RTQBTt6H2ulayInlrK2cv4kko1/OW2c=;
	b=AFcKj6e66j/Me2AwL9Auq6xfypM+rvLxMSBSns1ePe2oTlhPdTgcqERaXZc7cB1WY3IALi
	lfbX7H/un4Yg0sZjwNpF/MBKSNpW0yo6W2qDoiwLkhZbM5Rc6KC7tzINmb/OmdBsDNbu33
	eplgXrlZs38Zy4dXtvgK1Xl7u07QDtY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-_1SMQZEAP7SCqk7AvpAlAw-1; Wed, 08 Jul 2026 04:42:18 -0400
X-MC-Unique: _1SMQZEAP7SCqk7AvpAlAw-1
X-Mimecast-MFC-AGG-ID: _1SMQZEAP7SCqk7AvpAlAw_1783500137
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bd52dae6so3201355e9.0
        for <virtualization@lists.linux.dev>; Wed, 08 Jul 2026 01:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783500137; x=1784104937;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmMU+EsZ9VD1RTQBTt6H2ulayInlrK2cv4kko1/OW2c=;
        b=SRWYKt6r5nJPEYIYA9gebSPvXwXVICoynIVNg15YwkCCHykMDAPORUNGr6Z1rEcfpP
         XO/hEUpkL5BHt20MZyIhZUpsIQ4lF2TF9BtSSReW5/+4nODJgTdtHQNYwxovKVj8Zb62
         kuHr/qkcw+S0DBf/oLJnwWcsIEnM4Fjj1lk8tfEAYEWbN3TgoiwVB/GS1dx4U5svsP7b
         QzuSTYMBL3viUh9ff+3pl1h45+jDTiBbeDDl0ZT9Gg/sXn5jr13zF9zf5ypowCupFvpB
         4aUCw10pAFKzSZL96cxrNB1Y7jT0Nk6XJAIu/koqPZ/gByDXmXZK5wIPlvZQ0giyb6cq
         MM2A==
X-Forwarded-Encrypted: i=1; AHgh+Rp1gdFxo/5tnOkJlnsIkocKwAMWK2z0sc7HW887YJ/MOD1OgzzvAlFsHSKv7jp49V0cyqNZSFf8b1adcHA9DQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx31tEDTFBlkr4KWCO9Qz0T6Qmk6GZjCiaOvlabqli5bmPu096h
	/iJWiF2G6jfK2tI4YNSgudUhNWvcJZJvav3L140jmPjdV33zFl3y389tovqOoYEypqvX6HdUboi
	NNvgeT3IAs8D/2m/b3hGmP/tSFO7A3kJcc86ToSO66JRw6cqQki6ohrYwBXoVTHoGXDzg
X-Gm-Gg: AfdE7cn8MJgA9r5RlYT5A9u+MZblBGUf0senfpZamfSg7oRCuo8B1PqyvwarMbYAsZe
	hcdBpvOLP2lSECDY1FaCjZYUZro4/9oEpm02FpFBgdSkNz33AsBcnPz3KzqZPmWOThIzE3AQ+rx
	ONqPYIE3aSRmDiaN0dLSDvYmOghnhrbAC5fqtCooUsdCcbly1hiwce3IvYY5jCBeLIjN1WMKx32
	1VCUH2ES4h1NokNpwDcbBxASUNSKYvpjrqrL4qWqsDzvmzsWpTY8BZ6N5qWLeHdhL6Y/R/Lf2mT
	pHBs7we0ebZ2ZQsGe3IheEA5MO1MpM1u91KV7ixJoBSS4oKuYox53Dvz697lqWl+cQqCyVQxuJ7
	HPh4FZF8b8BVfKWBnPD5zRaANiFDiPiFX
X-Received: by 2002:a05:600c:630a:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-493e686c848mr14560015e9.29.1783500136986;
        Wed, 08 Jul 2026 01:42:16 -0700 (PDT)
X-Received: by 2002:a05:600c:630a:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-493e686c848mr14559595e9.29.1783500136377;
        Wed, 08 Jul 2026 01:42:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039af67sm47289710f8f.17.2026.07.08.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:42:15 -0700 (PDT)
Date: Wed, 8 Jul 2026 04:42:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Adam Litke <agl@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4] virtio_balloon: prime stats vq after
 virtio_device_ready()
Message-ID: <20260708043903-mutt-send-email-mst@kernel.org>
References: <135278ef075f563ca5b0f3a40e2afcfeb7454f99.1783457622.git.mst@redhat.com>
 <9e2c389b-ae96-40bb-8edd-5f8a68b571df@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9e2c389b-ae96-40bb-8edd-5f8a68b571df@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: owDBX42FZp-lKPmJ_0RMFsevNc8TH2Dx23rpbXcb4to_1783500137
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2026 at 10:13:58AM +0200, David Hildenbrand (Arm) wrote:
> On 7/7/26 23:00, Michael S. Tsirkin wrote:
> > The virtio spec requires the driver not to kick the device before
> > DRIVER_OK is set.  init_vqs() primes the stats virtqueue with a buffer
> > and kicks the device before virtio_device_ready() is called in
> > virtballoon_probe(), violating this requirement.
> > 
> > Further, if the device responds to the early kick by processing the
> > buffer before DRIVER_OK, stats_request() fires and queues
> > update_balloon_stats_work.  Should probe then fail and free vb, the work
> > runs against freed memory.
> > 
> > To fix, move buffer setup to after DRIVER_OK. Be careful to
> > disable update_balloon_stats_work while this is going on,
> > to make sure it does not race with the setup.
> > 
> > Testing: tested that stats still work after the change.
> > 
> > Fixes: 9564e138b1f6 ("virtio: Add memory statistics reporting to the balloon driver (V4)")
> > Reported-by: Sashiko:gemini-3.1-pro-preview
> > Cc: David Hildenbrand <david@kernel.org>
> > Assisted-by: Claude:claude-sonnet-4-6
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> > v4: extract stats_update_and_send() helper; call get_buf() before
> >     updating stats buffer in stats_handle_request().
> >     also ignore add bug failures (never trigger anyway) (reported by sashiko)
> > v3: add disable_work comment and BUG_ON -> WARN_ON_ONCE (David Hildenbrand)
> > v2: check that work enable/disable is balanced; explain how add_outbuf
> >     never fails in probe/restore
> >  drivers/virtio/virtio_balloon.c | 67 +++++++++++++++++++--------------
> >  1 file changed, 39 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 088b3a0e6ce6..4c4b9bea4356 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -417,6 +417,17 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
> >  	return idx;
> >  }
> >  
> > +static void stats_update_and_send(struct virtio_balloon *vb)
> > +{
> > +	struct scatterlist sg;
> > +	unsigned int num_stats;
> 
> Could do
> 
> 	const unsigned int num_stats = update_balloon_stats(vb);
> 


Indeed, a bit nicer. Thanks.

> LGTM.
> 
> -- 
> Cheers,
> 
> David

