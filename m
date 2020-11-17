Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DCEC2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 14:24:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6C2221FC
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 14:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOzLSVK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6C2221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3CEE085D26;
	Tue, 17 Nov 2020 14:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OzodvOGViu8K; Tue, 17 Nov 2020 14:24:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3322E84CCE;
	Tue, 17 Nov 2020 14:24:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22727C0891;
	Tue, 17 Nov 2020 14:24:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5529AC07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 505CB214E6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mn-zgJ6cXZ8h
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:24:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 61F5F20029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605623077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8MXJQ13wlrPLVjvOrheKkQMsdGs3KmerIV6Oa+JEIc8=;
 b=BOzLSVK6zTWe37V3GWDXi79QW2tJI16eJkTrOjyKZ+5s7exUlcfUG5SAqAWbRYF3jnoPVD
 TaERZWR/S4/3HZkkEWqqZYzmKJXb07chpcASFgRUDONsphhAEWC0a4SW8LOFDHHgTW5Oda
 7Z0o+06jJ9feFpBfGZ1Bwbk8bnhXk2E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-oanYVb0LOEy7H5RWQurtcw-1; Tue, 17 Nov 2020 09:24:35 -0500
X-MC-Unique: oanYVb0LOEy7H5RWQurtcw-1
Received: by mail-wr1-f70.google.com with SMTP id c8so13115075wrh.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 06:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8MXJQ13wlrPLVjvOrheKkQMsdGs3KmerIV6Oa+JEIc8=;
 b=CMWXhXNIng90F0klUTqd9lE/NbMAI0R+LeIMNtuabnho7R91J0ObOozRnq7HRFgIlp
 c6U/OXqxvicCvoAS9OT1U1fad5OWFp/dvM8TcqG97oQGyOGkKgMl5lFBFBQjeUpVECmP
 /IWvEpGJjMTblUQgMXwLt6eAGXk0K0l0Q9Cu9xLVYP1MzUCzUvWm1MKmQz7OMccSq35b
 YFgtD8+nWfrIipxP7oJfEQ52pGu8j5dS9t67qotJT02bSdaNb6EVlTqZIJPS1TbXmx+h
 lWc14JTRNfLiipaqjCzWfzRs4+iS+PzGBD4YlPZtc2P0PFT4jSoffVn3592aJpULrAL/
 m7dA==
X-Gm-Message-State: AOAM532CamvLs8ZKhK77Qzum7E4IeuIQHO6hqNQi9M501QeNDFTl+DAh
 XFgXQHRzcu4/QbPsvZ9UoLYV/nK6PNliRusUQ2oUs+yU3PNauen+jEq3y3Ev7TrI4ScQSaLR+F1
 nEtd/sHGYNR/dSOQsq8RJTgl/rGlXL/hoG6Im7gIx2A==
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr4871108wmk.131.1605623074686; 
 Tue, 17 Nov 2020 06:24:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydnM46ZfQJNcAZFkhGd7NjWAJ1JVIN1mUpc5vg0UqJ/iXNrwfvl7LgGewFVWVhELyVxfaDGw==
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr4871085wmk.131.1605623074442; 
 Tue, 17 Nov 2020 06:24:34 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id 109sm28800836wra.29.2020.11.17.06.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 06:24:33 -0800 (PST)
Date: Tue, 17 Nov 2020 15:24:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 06/12] vdpa_sim: add struct vdpasim_device to store
 device properties
Message-ID: <20201117142430.qqlh5d5d6smbfxur@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-7-sgarzare@redhat.com>
 <20201117112305.GE131917@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201117112305.GE131917@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Nov 17, 2020 at 11:23:05AM +0000, Stefan Hajnoczi wrote:
>On Fri, Nov 13, 2020 at 02:47:06PM +0100, Stefano Garzarella wrote:
>> Move device properties used during the entire life cycle in a new
>> structure to simplify the copy of these fields during the vdpasim
>> initialization.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.h     | 17 ++++++++------
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 33 ++++++++++++++--------------
>>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  8 +++++--
>>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  9 +++++---
>>  4 files changed, 38 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> index 6a1267c40d5e..76e642042eb0 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> @@ -40,12 +40,17 @@ struct vdpasim_virtqueue {
>>  	irqreturn_t (*cb)(void *data);
>>  };
>>
>> +struct vdpasim_device {
>> +	u64 supported_features;
>> +	u32 id;
>> +	int nvqs;
>> +};
>> +
>>  struct vdpasim_init_attr {
>> -	u32		device_id;
>> -	u64		features;
>> +	struct vdpasim_device device;
>
>It's unclear to me what the exact purpose of struct vdpasim_device is.
>At least the name reminds me of struct device, which this is not.
>
>Should this be called just struct vdpasim_attr or struct
>vdpasim_dev_attr? In other words, the attributes that are needed even
>after intialization?

Yes, they are attributes that are needed even after intialization,
so I think vdpasim_dev_attr should be better.

I'll change it and I'll try to write a better commit message.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
