Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E819309C
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616644; cv=none; b=JUM59Zrrgd0qaeFu2vsBHEWL7Z+Xsitv+4r9p6SAHn4FwB54x+SyUisvph6EMQeNoP6IgfdkMj83bEWr5vVlbKL2DOf/CmvyEVbPbNy9d0wdtrWSSGzksq+RI2nFQo0iX2wvOBSr8EDYa1SvNJNPtZvCUtBaGLAeq1bnIdh8Q8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616644; c=relaxed/simple;
	bh=QLxX4Rpj7zYvuJpj/kPpfbxaCfiDItCMeqMDeGVl4V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6uC5nAicLt1yYxLXs7Ya+4lP+sEoJ5foBrnpiAB7dGlVr5EZ7OgwS+JzdUUceqhs6IvZ37Ovc100O3OjhHE/Hf2CwsE1kAiztgCL4szs3UBYz7t+LhvDyogMpaFqeJK02eUPyu7iiBdujHnY0Nf+JnJ9B/u6oBP1AcKuoRhiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cLgEJ/pa; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cLgEJ/pa"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cc129c78fso108899e87.2
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718616640; x=1719221440; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8QLktAGNTjUFJei+a7Yp7B+dYTOmyOgcx1VIYD5aK+o=;
        b=cLgEJ/pakBnQOYn+F68Ij7PODzsYsZ85T2EMkHo3N+KmDzqz1KbDXdzwcMMjrsidEd
         aTjRQRpkH25zsLX60cneDSx5Fupzw6lvJRzejgHTB7QPzfL7Wg6DA7dAemTS7bH5ndpR
         vheYtVnHkjIyA+ItEN5iZ+0tjZMb8hdlyHwS8U9L0m1KiyhoIO3CIL52yNzRIVx9uFRD
         KUaqJVpduzm/Uk+onZjFRNTRNPQuA6/Gm8Rzyme2IiyOGUqreQUtM7gw//KAAMi/q2ir
         UmPQ4bjDn+29xi2eVTpNGSIgP8jyboghffaEZfWJzM7mqqiYmykGLBlsbP2raboyhr7w
         nzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616640; x=1719221440;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QLktAGNTjUFJei+a7Yp7B+dYTOmyOgcx1VIYD5aK+o=;
        b=IivljjyKLanyVZ4lf2S5PrNfL5NlEReuzctmIe/H0QTZ5xSkHvwuQyiBUO1GJgPm93
         A0jkmhqJGfn9D2m8h7y7iyIGwGJtLrUxJzZzvmS1aIY5fIW7vo+t30TGsjdQyvECSpId
         5fcwsIxxkY/apIbHAHhlyPbTfQTqq9U2BS3jCisTVEauvu0Mut8gkEe0tnLW18JCP5cw
         6KD6VOY7fU+BoDVVIpxxPiWSjhhnWiPtG0oGajiAzCS/0mKFN+pYj0ZhhMDi7c5nGBiR
         Fu4dtVR6AyIUcHRzj5ANkjRARWzCWO4B+Tiu/eXNKjuBOLBy+/NjsD5sOons1ovbiN+C
         Ih8A==
X-Forwarded-Encrypted: i=1; AJvYcCVTyA6jc8MVYZbpNfDGRQhOH9oyPVd5LRyrHQqmEgKzNKt6DFIiqmcGiqTIGfXr5cWKdzP/NbT1gx54HMFpCTY/ixGvzGyBiYGa0mtdR3o=
X-Gm-Message-State: AOJu0YwIVh2CoqA8OZ80Bh0lknzLgfN6Bi6doopyJNO5qy9vAXM6z9Gu
	NCVFxAH52juaT0ayi637BMJ6C3hlJ3/mgopTY9PFJQawZT38QBehj8S1W63tESM=
X-Google-Smtp-Source: AGHT+IFeQQ3VLHyWUDWMF94tKcMqEnxKjztlgo/DGQL+ULZYyDevfiUpxD8t+PLZ6eWIpx+EZWjgJQ==
X-Received: by 2002:a19:385b:0:b0:52c:9846:3b8c with SMTP id 2adb3069b0e04-52ca6e6c7ffmr5359133e87.41.1718616640555;
        Mon, 17 Jun 2024 02:30:40 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e71dcsm188650685e9.44.2024.06.17.02.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:30:39 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:30:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZnACPN-uDHZAwURl@nanopsycho.orion>
References: <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
 <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion>
 <20240610101346-mutt-send-email-mst@kernel.org>
 <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>

Mon, Jun 17, 2024 at 03:44:55AM CEST, jasowang@redhat.com wrote:
>On Mon, Jun 10, 2024 at 10:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Fri, Jun 07, 2024 at 01:30:34PM +0200, Jiri Pirko wrote:
>> > Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
>> > >On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
>> > >> >True. Personally, I would like to just drop orphan mode. But I'm not
>> > >> >sure others are happy with this.
>> > >>
>> > >> How about to do it other way around. I will take a stab at sending patch
>> > >> removing it. If anyone is against and has solid data to prove orphan
>> > >> mode is needed, let them provide those.
>> > >
>> > >Break it with no warning and see if anyone complains?
>> >
>> > This is now what I suggested at all.
>> >
>> > >No, this is not how we handle userspace compatibility, normally.
>> >
>> > Sure.
>> >
>> > Again:
>> >
>> > I would send orphan removal patch containing:
>> > 1) no module options removal. Warn if someone sets it up
>> > 2) module option to disable napi is ignored
>> > 3) orphan mode is removed from code
>> >
>> > There is no breakage. Only, hypotetically performance downgrade in some
>> > hypotetical usecase nobody knows of.
>>
>> Performance is why people use virtio. It's as much a breakage as any
>> other bug. The main difference is, with other types of breakage, they
>> are typically binary and we can not tolerate them at all.  A tiny,
>> negligeable performance regression might be tolarable if it brings
>> other benefits. I very much doubt avoiding interrupts is
>> negligeable though. And making code simpler isn't a big benefit,
>> users do not care.
>
>It's not just making code simpler. As discussed in the past, it also
>fixes real bugs.
>
>>
>> > My point was, if someone presents
>> > solid data to prove orphan is needed during the patch review, let's toss
>> > out the patch.
>> >
>> > Makes sense?
>>
>> It's not hypothetical - if anything, it's hypothetical that performance
>> does not regress.  And we just got a report from users that see a
>> regression without.  So, not really.
>
>Probably, but do we need to define a bar here? Looking at git history,
>we didn't ask a full benchmark for a lot of commits that may touch

Moreover, there is no "benchmark" to run anyway, is it?


>performance.
>
>Thanks
>
>>
>> >
>> > >
>> > >--
>> > >MST
>> > >
>>
>
