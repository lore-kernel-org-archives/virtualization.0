Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D539019AD89
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396417; cv=none; b=t8NOkgtLeY3QAxCimRuLXzY5ckkLQTxTcIAxoKdahgFv4HGWNI5CV3of0SHo5tLXL4q0+l6/3JYN5mZrfyI1jZQoIiwfIk+fpHw4M8FSlaqbppAdnl+NFqaF69RKnn8lZt/gsjhFBuCHaOVnoEyMbkKZnRymXlHqNC7OPkXwefw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396417; c=relaxed/simple;
	bh=PFBm2I4N5jYoUgCLRmxJIOtwy7bj+cX6hvDXoT5qs+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YKHRtVQNykZHFljf7VtSBrAF9a3EYKb39586UbWnEkVpCOSTcIV2CV1O553H6DYivdMkR4mIRA+kL2WyVVlPaUfE6uXMEFuaSEJQqDcQYSgzceEXpJfB75Cqv9UCDJTRNl9fiDyXe/tAWHP2Co4s2rcaHnKqngDGMSs1DD9Th0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WY2FYx2T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WY2FYx2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742396413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Znos5WaUC4/XydmSkRRiQaq6by5qPuZbVqgImjMATjw=;
	b=WY2FYx2TqW91msJ2BnwTZP3OysLRB25FzaIzhfWRI6bDv7QwzQUj8aLCHQsf14rK+/mJeg
	hRgFLwjwWMrKsZoXAimtO61gd6aGy+uOEV7HQK8VfdFkzqLn1Oj6AJa38zE7vCx9WantMk
	KjSsG4T4S12G/R5D0E78l6GaLR5gA/E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-Xp_vLVsYPsiP9YDB7cTXyw-1; Wed, 19 Mar 2025 11:00:11 -0400
X-MC-Unique: Xp_vLVsYPsiP9YDB7cTXyw-1
X-Mimecast-MFC-AGG-ID: Xp_vLVsYPsiP9YDB7cTXyw_1742396410
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39141ffa913so4111130f8f.2
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 08:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396410; x=1743001210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Znos5WaUC4/XydmSkRRiQaq6by5qPuZbVqgImjMATjw=;
        b=E1Di556TI4zjArNsv1ISQ0zxumFKe7TSnyjJXRzlDSerlwf6xGDRA5TtsODNIZnT/s
         qeb5FrDwIkynWagHzFORkfE1cLmHCqBq/IFHdBeDxlYvSLXKILoHKEt/r9TlBWfj3iMe
         Vd5VCEtFAJpTusSURU5lS0i3SfxfIBMkIN77s0oUdyMLHfrhEhfUldqf1zb5l2jbZ7dG
         efjmFznqYkYjEezfMZWnEO2lCs2BE3L8I1/U6fu6yHSQbSrvpDHbaN1lNwBF3XYqZFQ0
         gm5PfcyNQk4baSOzY6K9sc4sxdPikJ5gDmgz93FkHIbokbp5LOpTv8KpjALJS7Ayodum
         8nkw==
X-Forwarded-Encrypted: i=1; AJvYcCWez/1GQzXCrzRZ4KiuPcuAX0KZROU8TyNj734UR31fZw9DN7jL+WdhluMjkotSdUeG2aqDkiMUFow9ByxNhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdzwzezxVctOFSFmv4A71ELVy4PJ8xgMwcJC6Tmzg4oH6NABb9
	iLvqe1Jhu2hpsSzK8zZhu8uZuOLjtok+N/Ainf0gvquFRvjeepQuJm+Kz+NXWaB24iPyZrWE9Ka
	5hM70Y3jfHvWHAerL+FWiigFz0CR3Gbgn4qJoJMsKFEDmImOKrLF5Q42b9eoNH0ZG
X-Gm-Gg: ASbGncuNXULSBnGuqqJEv64UJJZ/anNkHESND1cSrrElC1HZlhno3VE7NS5AY7+ySOj
	bsUi9SUKr6pAXILUv5mRF/0YzR3TcS5qDQ2lBuYw780Me3v1bahEwXg6KguNRk3GWzn7wOI/rWW
	NaXHV0jSEgZRKjfcVMXWR092H9BkEHlDap/ftV+To2Lq8vqvfo9juiOedlxxdTDf6W1n4nm8gaH
	cx91wbHG0lw78XskP5iflP3tfs6PLE5hH0AgHtf65CR1o7+cxwtXsevUjIkk95C4mT+3XV3RHfa
	XT0MFgzlQQ==
X-Received: by 2002:a5d:47c9:0:b0:391:12a5:3c95 with SMTP id ffacd0b85a97d-399739d4817mr2819060f8f.22.1742396410335;
        Wed, 19 Mar 2025 08:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtQGh+I2vuGaNYtN5Wod5Mm6S3SyNqy9i9AO1JYL9vJ/bbEsx6r52lPyyaG5tlRjOWFPfqNQ==
X-Received: by 2002:a5d:47c9:0:b0:391:12a5:3c95 with SMTP id ffacd0b85a97d-399739d4817mr2819012f8f.22.1742396409808;
        Wed, 19 Mar 2025 08:00:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3978ef9a23bsm16981307f8f.15.2025.03.19.08.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:00:09 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:00:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, arnd@arndb.de,
	gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
	schnelle@linux.ibm.com, pasic@linux.ibm.com
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio spec
Message-ID: <20250319105852-mutt-send-email-mst@kernel.org>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
 <649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
 <f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
 <dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W2MV3B8RgC9hP20rpXSh9m2_EAll4b7SrEvuOnZZMks_1742396410
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Mar 19, 2025 at 02:00:44PM +0100, Maximilian Immanuel Brandtner wrote:
> On Tue, 2025-03-18 at 15:25 +0100, Amit Shah wrote:
> > On Tue, 2025-03-18 at 11:07 +0100, Maximilian Immanuel Brandtner
> > wrote:
> > > On Mon, 2025-03-03 at 12:54 +0100, Amit Shah wrote:
> > > > On Tue, 2025-02-25 at 10:21 +0100, Maximilian Immanuel Brandtner
> > > > wrote:
> > > > > According to the virtio spec[0] the virtio console resize
> > > > > struct
> > > > > defines
> > > > > cols before rows. In the kernel implementation it is the other
> > > > > way
> > > > > around
> > > > > resulting in the two properties being switched.
> > > > 
> > > > Not true, see below.
> > > > 
> > > > > While QEMU doesn't currently support resizing consoles, TinyEMU
> > > > 
> > > > QEMU does support console resizing - just that it uses the
> > > > classical
> > > > way of doing it: via the config space, and not via a control
> > > > message
> > > > (yet).
> > > > 
> > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/virtio_console.c#n1787
> > > > 
> > > > https://lists.nongnu.org/archive/html/qemu-devel/2010-05/msg00031.html
> > > > 
> > > > > diff --git a/drivers/char/virtio_console.c
> > > > > b/drivers/char/virtio_console.c
> > > > > index 24442485e73e..9668e89873cf 100644
> > > > > --- a/drivers/char/virtio_console.c
> > > > > +++ b/drivers/char/virtio_console.c
> > > > > @@ -1579,8 +1579,8 @@ static void handle_control_message(struct
> > > > > virtio_device *vdev,
> > > > >  		break;
> > > > >  	case VIRTIO_CONSOLE_RESIZE: {
> > > > >  		struct {
> > > > > -			__u16 rows;
> > > > >  			__u16 cols;
> > > > > +			__u16 rows;
> > > > >  		} size;
> > > > >  
> > > > >  		if (!is_console_port(port))
> > > > 
> > > > This VIRTIO_CONSOLE_RESIZE message is a control message, as
> > > > opposed
> > > > to
> > > > the config space row/col values that is documented in the spec.
> > > > 
> > > > Maybe more context will be helpful:
> > > > 
> > > > Initially, virtio_console was just a way to create one hvc
> > > > console
> > > > port
> > > > over the virtio transport.  The size of that console port could
> > > > be
> > > > changed by changing the size parameters in the virtio device's
> > > > configuration space.  Those are the values documented in the
> > > > spec. 
> > > > These are read via virtio_cread(), and do not have a struct
> > > > representation.
> > > > 
> > > > When the MULTIPORT feature was added to the virtio_console.c
> > > > driver,
> > > > more than one console port could be associated with the single
> > > > device.
> > > > Eg. we could have hvc0, hvc1, hvc2 all as part of the same
> > > > device. 
> > > > With this, the single config space value for row/col could not be
> > > > used
> > > > for the "extra" hvc1/hvc2 devices -- so a new
> > > > VIRTIO_CONSOLE_RESIZE
> > > > control message was added that conveys each console's dimensions.
> > > > 
> > > > Your patch is trying to change the control message, and not the
> > > > config
> > > > space.
> > > > 
> > > > Now - the lack of the 'struct size' definition for the control
> > > > message
> > > > in the spec is unfortunate, but that can be easily added -- and I
> > > > prefer we add it based on this Linux implementation (ie. first
> > > > rows,
> > > > then cols).
> > > 
> > > Under section 5.3.6.2 multiport device operation for
> > > VIRTIO_CONSOLE_RESIZE the spec says the following
> > > 
> > > ```
> > > Sent by the device to indicate a console size change. value is
> > > unused.
> > > The buffer is followed by the number of columns and rows:
> > > 
> > > struct virtio_console_resize { 
> > >         le16 cols; 
> > >         le16 rows; 
> > > };
> > > ```
> > 
> > Indeed.
> > 
> > 
> > > It would be extremely surprising to me if the section `multiport
> > > device
> > > operation` does not document resize for multiport control messages,
> > > but
> > > rather config messages, especially as VIRTIO_CONSOLE_RESIZE is
> > > documented as a virtio_console_control event.
> > 
> > You're right.
> > 
> > I was mistaken in my earlier reply - I had missed this
> > virtio_console_resize definition in the spec.  So indeed there's a
> > discrepancy in Linux kernel and the spec's ordering for the control
> > message.
> > 
> > OK, that needs fixing someplace.  Perhaps in the kernel (like your
> > orig. patch), but with an accurate commit message.
> 
> So should I send a patch v2 or should the spec be changed instead? Or
> would you like to first await the opinion of the spec maintainers?
> 
> The mail I initially sent to the virtio mailing list seems to have
> fallen on deaf ears. I now added Michael Tsirkin to this thread so that
> things might get going.


If we can fix the driver to fit the spec, that's best.
We generally try to avoid changing the spec just because
drivers are buggy.

> > 
> > Like I said, I don't think anyone is using this control message to
> > change console sizes.  I don't even think anyone's using multiple
> > console ports on the same device.
> > 
> > > In fact as far as I can tell this is the only part of the spec that
> > > documents resize. I would be legitimately interested in resizing
> > > without multiport and I would genuinely like to find out about how
> > > it
> > > could be used. In what section of the documentation could I find
> > > it?
> > 
> > See section 5.3.4 that describes `struct virtio_console_config` and
> > this note:
> > 
> > ```
> >     If the VIRTIO_CONSOLE_F_SIZE feature is negotiated, the driver
> > can
> > read the console dimensions from cols and rows. 
> > ```
> > 
> > 		Amit

