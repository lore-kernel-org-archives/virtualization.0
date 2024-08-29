Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962E1B013F
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942533; cv=none; b=H30WpX3mCrLBItems2vkMcNY9cFGDDEe/PWqVbS7V5VAAFsU2gMUTXahCZBT3LjF/ZKlVu0bbnHf8OKc/htRN/DjcT/mw6mlk1xkZbfsDWXG+ifGAll0RBmK9TXsbhHXKvLl5UgtD3oRN9CSP3GfhP5CFQCigrKBaJt/+8AV5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942533; c=relaxed/simple;
	bh=FAL3Wk1GJKv1jtOh0SKb2Eaa3RAQlRHvFE9FQ3MaL28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=U6u83XZw8QzE5rNMfIzDreGj6ynj7ZuuomYgKfd9Q4TwjZSVAG2IyeR/0xLC4bam0b9ccn2BLH11Pu9V7tHaKKRIDCsrxGl4hBDah9T8mlHXzAlzt28JKUEqsTgaOsJILv1/a3pBsQC62vDTnsZPTh8vL5TWNxNidZ20Om2NGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFAw4q06; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFAw4q06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724942531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zMnahuLuC6i0N7ypZMSGEalm8mu6MNOeiFUlojCltE=;
	b=bFAw4q06YBbdNpz+CbYj5Y1Dr57Nlh9QT43USKmccvCvtIYzKAGIXnF/Qd8CdXfkl4m4h2
	fJqX3X8gJE2zXu5RuQHtQYINOxeC5RfrcJ/A9O7o4yQ4CdTX4O1lycrwpEfcJHryZFI9g9
	Hl+oTn4sQkNnlQnKOZhoHN/JG+YrO1g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-CEx8op_pNtGNc5tti0rqaA-1; Thu, 29 Aug 2024 10:42:07 -0400
X-MC-Unique: CEx8op_pNtGNc5tti0rqaA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5bedba9894dso592150a12.1
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 07:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942527; x=1725547327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zMnahuLuC6i0N7ypZMSGEalm8mu6MNOeiFUlojCltE=;
        b=u/SuCAdvm9zYK/DpnI6sXeoZxXe+yUcABwW6Sx+kixw83Ue/+o5Ex6RakxDIEUH9AS
         y4bphDlPDLYnym5IItMN5qzHiYhpEV9+JTDSzbTUsfUwY6lMEj2M2BNynupb74/qkiQQ
         OEdqTH38nijApIrWOp60HrR1WQCCNTeCMf5cWFkeJ/Lh37WA4wbSytpgEv0CMYVRVIkx
         5L1FUjuAReIArcs8NTP7yajjpP9+dDZQ1eJGDqeZnYFU1E9/JwrCSvjPvv2d8Ps45Jgt
         MurmfzuIWTLpa1m7tSpHfF05Lvh2R0j/J9Bb2MNR0F/euVI7gyhkdUIPjsrSiUqdsN4K
         uSiA==
X-Forwarded-Encrypted: i=1; AJvYcCUcuJi5ONucvp3fMUxjhl0n/PGU9pJmllC69jLKiMO5KTX9xPB6jTj0uszjf9WYzUlhmlhTJ+MrJBKveRi1wQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFyk1O+M7f0YJozDScmGGfDYeK1X6H4yTP7G7Uskej285MO0qq
	5psuIamY7Tm4jz/IIgOtTy0wS0xGI27YfC14GjfZtz4Uhm8VT8tNJkvilDQCD1gr0sU38TbjqQQ
	UJgeVBN7WvX9h5e9TsQKDFc3TpV4hfL6sbwyqdUtp03K6S8q6Kta8ZTSpoKJBC9xu
X-Received: by 2002:a05:6402:278c:b0:5c0:a8c0:3960 with SMTP id 4fb4d7f45d1cf-5c21ed31e90mr2671882a12.4.1724942526555;
        Thu, 29 Aug 2024 07:42:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3Qxba/RJ3kvosiIqlnL9lYOS9AAEMC71M0lm83PE0iqKT0MhcHZDjA9fDLzTLomsiWqg1kg==
X-Received: by 2002:a05:6402:278c:b0:5c0:a8c0:3960 with SMTP id 4fb4d7f45d1cf-5c21ed31e90mr2671689a12.4.1724942525532;
        Thu, 29 Aug 2024 07:42:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:f3dd:4b1c:bb80:a038:2df3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989195e6bsm86599066b.99.2024.08.29.07.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:42:05 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:41:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Philipp Stanner <pstanner@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
Message-ID: <20240829104124-mutt-send-email-mst@kernel.org>
References: <20240829141844.39064-1-pstanner@redhat.com>
 <20240829141844.39064-7-pstanner@redhat.com>
 <20240829102320-mutt-send-email-mst@kernel.org>
 <CAHp75Ve7O6eAiNx0+v_SNR2vuYgnkeWrPD1Umb1afS3pf7m8MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve7O6eAiNx0+v_SNR2vuYgnkeWrPD1Umb1afS3pf7m8MQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Aug 29, 2024 at 05:26:39PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 29, 2024 at 5:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 04:16:25PM +0200, Philipp Stanner wrote:
> > > In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
> > > pcim_iomap_regions() is placed on the stack. Neither
> > > pcim_iomap_regions() nor the functions it calls copy that string.
> > >
> > > Should the string later ever be used, this, consequently, causes
> > > undefined behavior since the stack frame will by then have disappeared.
> > >
> > > Fix the bug by allocating the strings on the heap through
> > > devm_kasprintf().
> > >
> > > Cc: stable@vger.kernel.org    # v6.3
> > > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
> > > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> >
> > Post this separately, so I can apply?
> 
> Don't you use `b4`? With it it as simple as
> 
>   b4 am -P 6 $MSG_ID_OF_THIS_SERIES
> 
> -- 
> With Best Regards,
> Andy Shevchenko

I can do all kind of things, but if it's posted as part of a patchset,
it is not clear to me this has been tested outside of the patchset.

-- 
MST

