Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A02C1A3
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871053; cv=none; b=PzhDZ9SWRKDb5l+Qtihsg4VghPHivyDYbu0I7fcKT55TjJf+AaG+jLWPsqkhG1RuKYRPvah7MPfJ/JPuFDpD4Q75XvFzeNqDWvIHU0UuXAwusAMVbWlhyLelbHSAhkP5es69uKbcH5O/OfFMEhQjKMcZu6648FKexYw2Q4Apsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871053; c=relaxed/simple;
	bh=egx2s2hDJ9Hl8/mkB4qiJaNgQlX8ufkf1/e4UeGjicU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iMD7Q9l2rBFj1EyKYzEfd9zn3SoFfFdAq+vCY83UpmGAVZdQwKcTKYzaBXbK2eycBjeR1pO5ZFpYjdACdKjFD9Fhegw18CqD09GVUT+5P06w8tTvAl7uqMpynDJm5pIqip7GRLQj+NAW6egjrSNxvYZ5zwDVBxyIRBw0OJxzigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJ7tce7H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJ7tce7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710871051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8f0+FvSXuV99yJd+lHzugD0TJ+QbCsdwKMuIpK1cM54=;
	b=JJ7tce7HDwsnuOL8ZUNBJFUKlyrpmdOMEMPcXDqU+tzTx9SxxuwjF2drZCC05LRJree+ek
	n/KY5io/7yBaVrGZ7SCHGOclDAd7MWGSftxayoBLiQNXyQxtltayaYkA3n4Kc3Rs6tiHZ+
	GvnYwOWVaZdrIdwgjVhEr/jJvH7qGT4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-B1JG17m1PDynxSbNSS1KFQ-1; Tue, 19 Mar 2024 13:57:29 -0400
X-MC-Unique: B1JG17m1PDynxSbNSS1KFQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-414105984aeso13601215e9.0
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 10:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871048; x=1711475848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f0+FvSXuV99yJd+lHzugD0TJ+QbCsdwKMuIpK1cM54=;
        b=JVdDxsqEd1oGAt9sLAZvJ+mTrJ3//u7Ua6BdDKrgJ5O3TTg0t5gJFQK0qIM9PvQTnC
         MCx3H7X7ISsIHZ+36r4PW4MiRcEPcXkute4ISVu0XTu7dsTwNRQLKAFggM0iQ9jgYK5e
         RAuc0aqp1IuSnMi1OxdvUEB4kBySKBl9jFoNUL8Z9Ipb+MMkN7TFrb1dDxwStVviZOaX
         B+WllLpZ+KLX0CG9M79pvw4yZaDAdWkfbp+VwXkTW/f1yMKmCQci+LuLCBShiNJnajQ5
         3SAtxhUGzv92tttO50zjikhQBTKbmxLjmD+VZTzOOFYZZRVTFuvyyq5J65y4mSkOwZoM
         dpyg==
X-Forwarded-Encrypted: i=1; AJvYcCUZMf6KeF7TynfwKKC+GoCGk0Ad4NFsAUY08guCjDSemIrcCzviIA1C5uagojQyEbVKGsiXC0rOaliG8TfSe4lhETyZTJ1f/jQ+Nd9gmwA=
X-Gm-Message-State: AOJu0Yww0ZMmHfH3eGRlglehsPzc8RovD7bvS5eEbZ9H2HVUYDYHVzmK
	CFZ4frIh7ZmW0wKQoSsq5YJ1nlO8nFJHTTIQIU9NGLthH19IdDIpaW2ayTkjXQvAWcKhrNamNZ1
	hJs/29dEw57HXudx3HcR1dwlyRcmj6IUZaLUpnG/zZyLl3P8mrCTtuN3KQBKiNSi8
X-Received: by 2002:a05:600c:4f88:b0:412:efc8:299b with SMTP id n8-20020a05600c4f8800b00412efc8299bmr2267301wmq.39.1710871048516;
        Tue, 19 Mar 2024 10:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrr4QvKBOmTxw9swuBxXPwmIP9nK2q9aXCMDx/maCtKBoVftmIkW4rcNStC4FaSBlGCa9WcA==
X-Received: by 2002:a05:600c:4f88:b0:412:efc8:299b with SMTP id n8-20020a05600c4f8800b00412efc8299bmr2267290wmq.39.1710871048028;
        Tue, 19 Mar 2024 10:57:28 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c501400b00414112a6159sm7050481wmr.44.2024.03.19.10.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:57:27 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:57:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Zhu Lingshan <lingshan.zhu@intel.com>, jasowang@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 08/10] vDPA: report virtio-block write zeroes
 configuration to user space
Message-ID: <20240319135639-mutt-send-email-mst@kernel.org>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-9-lingshan.zhu@intel.com>
 <kr2l5cuwdblc5o3xae324uxc2gmphe4wffgunthvhnjfbhqkmz@erwxl3v22gdy>
 <20240319130118-mutt-send-email-mst@kernel.org>
 <disso3ouyi3wrxqx5fa2v2kiaub3lsfdfwhhf3ghpf56oegczj@gwzaojtdoln5>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <disso3ouyi3wrxqx5fa2v2kiaub3lsfdfwhhf3ghpf56oegczj@gwzaojtdoln5>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 06:08:13PM +0100, Stefano Garzarella wrote:
> On Tue, Mar 19, 2024 at 01:02:21PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Mar 19, 2024 at 05:36:01PM +0100, Stefano Garzarella wrote:
> > > On Mon, Feb 19, 2024 at 02:56:04AM +0800, Zhu Lingshan wrote:
> > > > This commits reports write zeroes configuration of
> > > > virtio-block devices to user space, includes:
> > > > 1)maximum write zeroes sectors size
> > > > 2)maximum write zeroes segment number
> > > >
> > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > ---
> > > > drivers/vdpa/vdpa.c       | 23 +++++++++++++++++++++++
> > > > include/uapi/linux/vdpa.h |  2 ++
> > > > 2 files changed, 25 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > index bf3fa90908a7..adbcbc7b18b2 100644
> > > > --- a/drivers/vdpa/vdpa.c
> > > > +++ b/drivers/vdpa/vdpa.c
> > > > @@ -1064,6 +1064,26 @@ static int vdpa_dev_blk_discard_config_fill(struct sk_buff *msg, u64 features,
> > > > 	return 0;
> > > > }
> > > >
> > > > +static int
> > > > +vdpa_dev_blk_write_zeroes_config_fill(struct sk_buff *msg, u64 features,
> > > > +				     const struct virtio_blk_config *config)
> > > > +{
> > > > +	u32 val_u32;
> > > > +
> > > > +	if ((features & BIT_ULL(VIRTIO_BLK_F_WRITE_ZEROES)) == 0)
> > > > +		return 0;
> > > > +
> > > > +	val_u32 = __virtio32_to_cpu(true, config->max_write_zeroes_sectors);
> > > > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC, val_u32))
> > > > +		return -EMSGSIZE;
> > > > +
> > > > +	val_u32 = __virtio32_to_cpu(true, config->max_write_zeroes_seg);
> > > > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG, val_u32))
> > > > +		return -EMSGSIZE;
> > > 
> > > Should we cover also `config->write_zeroes_may_unmap` ?
> > 
> > 
> > This review came too late I applied the patch. Generally
> > if I don't see any response in about
> > a week I assume there is not interest.
> 
> Ooops, sorry about that! I should add me as a reviewer for vDPA
> otherwise lately it's hard for me to monitor patches :-(
> 
> BTW, some comments can be resolved with later patches if you think it
> makes sense to resolve them.
> 
> Thanks,
> Stefano

Sure. Once the pressure to merge the patch is gone not everyone
will bother though, it might be easier for you to send the patch on top.

-- 
MST

