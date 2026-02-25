Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2418838F94C
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013933; cv=none; b=e8kSdYpYNXpNaut4Sg5WvEXMdltxLPI1dYTsFhrWNJ8E35xgZzw5MNeLKBnXIchwEIgqbNC44v1rsZce/qW4TXa0/EZs9qq3aP2I96ylsiDWS2RfNUmbWEACiJKmqDhF8/Zaf2/2wseKbc5foMeiZgODVoRAY4YIHAdcSGuPG54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013933; c=relaxed/simple;
	bh=137Htqus0VCz2fkUEoX0C6QiaDNRn9ss7lhpg4S4VP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PT38B8/MXwVsIhGc0elshY2/B6OiiKSBStExWn3yGYYFjQraup/uHuvedmYEgXVWm67YQP5VrM8ldEfj3MYjOalJIAcHUEwsgpzHB/IFVFCiDvPE357PWdqlVvna05CXwRqfKP1Cr1wT0+5SqP5jMLA3glBh/J7OajooCwBoTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QB3tKVJG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QB3tKVJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCbdDmWBjVylwCV0fkm3KEsq7bDVRfaF0cb6VnbpnMg=;
	b=QB3tKVJG1jVkFRUmiykLJiKO/fKhJmAco+FvMFFi28LbVAdZ8ephDt/3Q4ER3u0kxB7Vk/
	XBdhtRtl6DBje53jmfQo85K6SlS089+9QiGLVwymlICPDdo5OOc6Viqb5dzxy/SSbPEmYl
	f437h6EmN8pp5W63+wRSBL6RhrlT0W4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-mnmqTRWaMs6Z6xnF70uK4w-1; Wed, 25 Feb 2026 05:05:25 -0500
X-MC-Unique: mnmqTRWaMs6Z6xnF70uK4w-1
X-Mimecast-MFC-AGG-ID: mnmqTRWaMs6Z6xnF70uK4w_1772013924
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4398c78d7acso860368f8f.2
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 02:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772013924; x=1772618724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCbdDmWBjVylwCV0fkm3KEsq7bDVRfaF0cb6VnbpnMg=;
        b=KVzxG+OoAMj5h+tqeedwkCkgECXMs20/saWt8PKflUAF/w3R5ZTJQjauW5LVEQLEvK
         udfpP1pNMtyMSDbGufxiUztrpJWd2KiuZphOlY3itcR0cl8QbNo9awpEQ6GxmW+G6itf
         HckNSGl0RyrEjrrieQwIDAnZs5C3pj6u5VJ6b0oV4Yjw49nemiNisRtB8/JKlFBBsHGl
         MbY6zaZTme9UmYGn/SfwKlan9yUlIXzRhjIBP/bBpXHeaP/E3mndtOeF0Rv/9g03ANgo
         QG9noT5c96n1guYJGXIM5g3TFADdKenIGJCzZi9D7mgercJT9JAy73bHPclC/FrtzNoE
         doig==
X-Forwarded-Encrypted: i=1; AJvYcCUQpR9+AR5ek+GR4zbyHjl8rBLj1gdCDxX8xzVSSoxorZNV2EdodUUzdnzUaJzdXZfTDJakC0knAe1SbYRJpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn3LwT6pLnsqsDQW7orsxxMMc3hjg6rAwkx16HkU566pati6yM
	Ovo9E492p17a+CGNa75YA+njSuvvXT/HXUqxLrbftBHMdQzFnMGTSypoHzoQHjb4Uwxm3AYhv5D
	rfg9+3Wo64P7cUUDYl8zrqzNO7lsZ9F9lmQ2Euuy6rmvzdDQWG3uPeFf7oFzZZnet/M9H
X-Gm-Gg: ATEYQzwbCpuSYxRAM8Z7BHqXqqKDiIeI+cy7qY6W9c6fvO2/jupunIorvroI/LySApR
	utcSqVCrJyXjDpxIGFBii2n6oR0wQL5dA/v91+GuzSTctDD3Uspe3G5jjAB4bQnv/ntpbAgKGT8
	cRxhViW5uxF/QcMf/huozHqO/F6QFcGbP0m5vEvHH8zTnRJ8JXwixnChWELwd/vc6AY5G/zI07P
	dFf0ktVHBheI1HDQ7FhjwIKkYHvb6HN06RAmdb1lwDOj9LOalUgHjnBoylEamADe0gvqAcBDHeZ
	6acmZrkaRIkuuAu0VS3nnQ9aNzamdikZEV5+j9pBJ3mRB1g5TQlsh2pQSg3VxTzOBczxiu3WupO
	kT9g0rjbKao/BB6ve+wUybgIWMNNll7BH9zajhxYyQ7R73Q==
X-Received: by 2002:a05:6000:2086:b0:435:8aa0:a30c with SMTP id ffacd0b85a97d-4396f182df7mr27572600f8f.48.1772013924313;
        Wed, 25 Feb 2026 02:05:24 -0800 (PST)
X-Received: by 2002:a05:6000:2086:b0:435:8aa0:a30c with SMTP id ffacd0b85a97d-4396f182df7mr27572536f8f.48.1772013923743;
        Wed, 25 Feb 2026 02:05:23 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00768sm31641564f8f.10.2026.02.25.02.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:05:22 -0800 (PST)
Date: Wed, 25 Feb 2026 05:05:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Srujana Challa <schalla@marvell.com>, pabeni@redhat.com,
	jasowang@redhat.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com,
	kshankar@marvell.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225050441-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
 <20260225044528-mutt-send-email-mst@kernel.org>
 <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jL4bdcPVDUo7X7GaAGfNFpwmk2keBnnMmSyb5nBTwfE_1772013924
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2026 at 05:52:29PM +0800, Xuan Zhuo wrote:
> On Wed, 25 Feb 2026 04:47:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Feb 25, 2026 at 05:36:06PM +0800, Xuan Zhuo wrote:
> > > On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > > > > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > > > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > > > > > redundant runtime max check.
> > > > > > > >
> > > > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > > > ---
> > > > > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > index eeefe8abc122..768ad5523dfa 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > > >  		}
> > > > > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > > > > -			dev_warn(&vdev->dev,
> > > > > > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > > > -		}
> > > > > > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > > > > > >
> > > > > > > Do we really need this check?
> > > > > > >
> > > > > > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > > > > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > > > > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > > > > > defines this.
> > > > > >
> > > > > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > > > > >
> > > > > > We never *need* BUILD_BUG_ON by definition, what this does is
> > > > > > document the assumption.
> > > > > >
> > > > > >
> > > > > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > > > > > the future, this check would no longer enforce the intended limit correctly.
> > > > > >
> > > > > > then it would fail build.
> > > > >
> > > > > So, does this mean we don't need to account for the case where
> > > > > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> > > > >
> > > > > Thanks.
> > > > >
> > > >
> > > > yes.
> > >
> > > Why?
> > >
> > > If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of 64, does this
> > > violate the spec?
> >
> > not the value of key_sz. If type of key_sz
> >
> >
> > i actually do not understand the question. this is not what BUILD_BUG_ON
> > checks.
> 
> So this is the issue. Originally, the code checked whether the value of key_sz
> was less than NETDEV_RSS_KEY_LEN. However, switching to a type_max check means
> it no longer covers the scenario I described. Therefore, I think this is
> unreasonable.
> 
> Thanks


patch 1 is unreasonable i think.

which is why patchsets should have a cover letter btw so
one can reply to just patch 1.


> >
> > > > the code makes assumptions but it documents them and not
> > > > just documents them, build will fail if they are violated.
> > >
> > > About this, I am ok.
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > >
> > > > > >
> > > > > > >
> > > > > > > Moreover, you should add a cover letter.
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >  	}
> > > > > > > >
> > > > > > > >  	return 0;
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > > >
> > > > > >
> > > >
> >

