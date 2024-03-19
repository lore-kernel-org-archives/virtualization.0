Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0721774A
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867751; cv=none; b=ubeN7umFAzxcDnQp5HHw4TJSWCu1ycoShgU5oI82hBz3RZCc0LQNSKUVCb6gD7ordmS7VqyaGUAAcqDLd7k9VnjLSgSYb2o16EllLowuLNVJsVVU9I79lEtpdbTbYDCkRgvab0SR2D+bCkhds9YMAmHo+P8Zji02xc6Gw3cnYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867751; c=relaxed/simple;
	bh=NEc05I+rTU4/JuelaKgQ4IyPTQ0H76OYPzmTt7m7RIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J258zjVHMJ7bj86jAPlmwiJvP61NuWo2zzFPaEcV4D1aIsMgMu/mLPv/7LNaDqy4FAP5w18I2CqYq5qp9lJkP4JI+BdfQykhEn3OqIJPVytegpAbMo/A4ENAM+hu/AHAC+jhFQuASYEQYqu4X5SIO9Beq5mqGUhhZYmySw9Of4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXfTGUAn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXfTGUAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710867748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a8beK9o4CrqMjgYaQ491JsYBWa5Slv4g/6T01a+VX1o=;
	b=KXfTGUAnM9+UCw5VFfGBjk8bJSuVsopCrXteRuTvUR9og3SxiJupqKzxQnh+hqkF6gktOh
	otjpO35n4oeMBnBgeT60RHC6zwYjdFVacIVJrQsIR4czrMo69vszrzwr8bLZvUFM9jp4G7
	rhdZXggYHK4+0VYC93qpnUualCfLp8o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-yixgyT-JN22LFn7t7dsBQg-1; Tue, 19 Mar 2024 13:02:26 -0400
X-MC-Unique: yixgyT-JN22LFn7t7dsBQg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed483c2ecso1972471f8f.0
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 10:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867745; x=1711472545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8beK9o4CrqMjgYaQ491JsYBWa5Slv4g/6T01a+VX1o=;
        b=p+jk0pV2BM0PXo7l1z5oCFTfrZvNLQmcxKrfnAudNlIS1QutrzUds5fRcc6TduUBQ6
         581wnjFF1WfmDo15zwOHXl6jkqeYD62eXlFKoCxprX6rLncpHodfNYkNA8VHS2oTa9JO
         wL7JJkqM+jc1Tb4oDC4gr9ZoBzTJddRGn48EzB1u9J9qM2L9EvepEQ3MV94imvZqwVwe
         eyIyiZnFzNsv4IatgFAaGrNHvIWlcv1jp8dxkd4xQd4/Wyjr1oJs4lENQDSH5f9mL9iQ
         GUOx+YpyLtOscykeun4alUIhGp4xqPR0Hp+kxqZiJ7/S9h+dOvQIsBoYY+g0ZyLR30md
         9Mxg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Xn2EsPKRJBNFJMDea2QdYCM/cFL/ZaJr6NNUz8+SzriYWWfhFBT3CfLOCZEjjmRPCxP1Ocaw8/goIplngn0dCqi5qHzC29ROm31G+fU=
X-Gm-Message-State: AOJu0Yx6TrMTKmgR1XjEZ/8T9b9XQRcecD+R4w97v0szrHGR33fOH3nb
	5KsGFww0TWTo74aOPPyt9dQbISRxBMrsveyy453WoGwMqGJEaJYQgkIPiL8PN9m0flKR3Om4NKe
	E+iGFNzxSCwssApTIfbud21Y3+JLpithu2o0U4yBXiWXWs8QLGaBCtlawdPuT9uYS
X-Received: by 2002:a5d:5960:0:b0:33e:8b17:cba9 with SMTP id e32-20020a5d5960000000b0033e8b17cba9mr11095793wri.27.1710867745358;
        Tue, 19 Mar 2024 10:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzO61I6qyhxeHnoYP5x2/CxYtmFxlw9j9yxPEye28IDwg9lWh842pna6ChiRQlMEcRQr3PQw==
X-Received: by 2002:a5d:5960:0:b0:33e:8b17:cba9 with SMTP id e32-20020a5d5960000000b0033e8b17cba9mr11095762wri.27.1710867744875;
        Tue, 19 Mar 2024 10:02:24 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id k3-20020adff5c3000000b0033e7eba040dsm12903856wrp.97.2024.03.19.10.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:02:24 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:02:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Zhu Lingshan <lingshan.zhu@intel.com>, jasowang@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 08/10] vDPA: report virtio-block write zeroes
 configuration to user space
Message-ID: <20240319130118-mutt-send-email-mst@kernel.org>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-9-lingshan.zhu@intel.com>
 <kr2l5cuwdblc5o3xae324uxc2gmphe4wffgunthvhnjfbhqkmz@erwxl3v22gdy>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <kr2l5cuwdblc5o3xae324uxc2gmphe4wffgunthvhnjfbhqkmz@erwxl3v22gdy>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 05:36:01PM +0100, Stefano Garzarella wrote:
> On Mon, Feb 19, 2024 at 02:56:04AM +0800, Zhu Lingshan wrote:
> > This commits reports write zeroes configuration of
> > virtio-block devices to user space, includes:
> > 1)maximum write zeroes sectors size
> > 2)maximum write zeroes segment number
> > 
> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > ---
> > drivers/vdpa/vdpa.c       | 23 +++++++++++++++++++++++
> > include/uapi/linux/vdpa.h |  2 ++
> > 2 files changed, 25 insertions(+)
> > 
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index bf3fa90908a7..adbcbc7b18b2 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -1064,6 +1064,26 @@ static int vdpa_dev_blk_discard_config_fill(struct sk_buff *msg, u64 features,
> > 	return 0;
> > }
> > 
> > +static int
> > +vdpa_dev_blk_write_zeroes_config_fill(struct sk_buff *msg, u64 features,
> > +				     const struct virtio_blk_config *config)
> > +{
> > +	u32 val_u32;
> > +
> > +	if ((features & BIT_ULL(VIRTIO_BLK_F_WRITE_ZEROES)) == 0)
> > +		return 0;
> > +
> > +	val_u32 = __virtio32_to_cpu(true, config->max_write_zeroes_sectors);
> > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC, val_u32))
> > +		return -EMSGSIZE;
> > +
> > +	val_u32 = __virtio32_to_cpu(true, config->max_write_zeroes_seg);
> > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG, val_u32))
> > +		return -EMSGSIZE;
> 
> Should we cover also `config->write_zeroes_may_unmap` ?


This review came too late I applied the patch. Generally
if I don't see any response in about
a week I assume there is not interest.
> > +
> > +	return 0;
> > +}
> > +
> > static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> > 				    struct sk_buff *msg)
> > {
> > @@ -1099,6 +1119,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> > 	if (vdpa_dev_blk_discard_config_fill(msg, features_device, &config))
> > 		return -EMSGSIZE;
> > 
> > +	if (vdpa_dev_blk_write_zeroes_config_fill(msg, features_device, &config))
> > +		return -EMSGSIZE;
> > +
> > 	return 0;
> > }
> > 
> > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > index 30887931a220..797d5708492f 100644
> > --- a/include/uapi/linux/vdpa.h
> > +++ b/include/uapi/linux/vdpa.h
> > @@ -68,6 +68,8 @@ enum vdpa_attr {
> > 	VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEC,	/* u32 */
> > 	VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEG,	/* u32 */
> > 	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
> > +	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
> > +	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
> > 
> > 	/* new attributes must be added above here */
> > 	VDPA_ATTR_MAX,
> > -- 
> > 2.39.3
> > 
> > 

