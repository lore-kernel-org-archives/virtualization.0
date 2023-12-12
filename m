Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319AC5CBD
	for <virtualization@lists.linux.dev>; Tue, 12 Dec 2023 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpvqmhUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702350026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/GWabnUccw3NaInncXMDYCSfx9WQ13D52xz9bmZnXo=;
	b=PpvqmhUtBQ4wh5RjBUj0W7qaxdN74enldde8+XUJgzt2RQWygRvwt+WuVu4O38qUh3TdtW
	SDTUl88+guslCurLhbZ2CcJKDYJ8UWn1/I4gbmT41UU/VizO1mo1MyJ1UriTgOk44TV3XQ
	gP6DD8QCSgac9QPpuErMt8TTaXqA+6s=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-7AtkX2HvP2aZHQ0yjociNg-1; Mon, 11 Dec 2023 22:00:25 -0500
X-MC-Unique: 7AtkX2HvP2aZHQ0yjociNg-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58ceea508bfso6701180eaf.0
        for <virtualization@lists.linux.dev>; Mon, 11 Dec 2023 19:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702350025; x=1702954825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/GWabnUccw3NaInncXMDYCSfx9WQ13D52xz9bmZnXo=;
        b=KEK1MvZuwqWnN2T5XHV0dNbbgJdQPM++TsfpQhQVWXxYaZGFT8tWNNXpCE4HVcGkjN
         KpjajpYyDqmByMdSe5bpxsxplD2WwjL8aYDDLhdL3g7u4AochSCAykB5JApLUMXXrq/R
         kyTVMzYsEtX6fhYPwbDwpVDiB3IkWOj4OFLhjNWYcggdVBszlGAPhJI34IfqWvdxgjN3
         8Ns8glGkzu2j1pz2iySvU0J56DpqjBrQcnPBnvQ+2v78h312utejgw/WnWK0G1Y5RceS
         s3r03tgddjxhVzI6CRHtzuJlkYeTig/O1bRJ28RPWLYZsfJfD/EZVWclZDaeg1sFC+3Z
         QQ0A==
X-Gm-Message-State: AOJu0YxbLlD9DBuozE65n9lCNA9ch/MxUrxyKmzPpHAdvImI/j65MB27
	/Wn8xYg3gpKmUqdB97rTrpNWYVVYgAD1r5PGMMWd844X3MLnRdHPNbeo5KtS1Ca6Cw+XdLEl38s
	vfj1tJjoAJcdmc8ARr81DgkFBmwcwXxsTxapPiu6UOH8=
X-Received: by 2002:a05:6358:260e:b0:16e:4c3:f8c3 with SMTP id l14-20020a056358260e00b0016e04c3f8c3mr6935869rwc.11.1702350024816;
        Mon, 11 Dec 2023 19:00:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEp3OwNK9PoGoQnXeeX4+viPi6Hk3B5tFT4RIMaX8AFHJ44Lb0NnCW5h1v++Uvw9C1SRvVa6MdgSmune5oTLWk=
X-Received: by 2002:a05:6358:260e:b0:16e:4c3:f8c3 with SMTP id
 l14-20020a056358260e00b0016e04c3f8c3mr6935850rwc.11.1702350024367; Mon, 11
 Dec 2023 19:00:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com> <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org> <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org> <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org> <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231211115329-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Dec 2023 11:00:12 +0800
Message-ID: <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tobias Huschle <huschle@linux.ibm.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Peter Zijlstra <peterz@infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:54=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Dec 11, 2023 at 03:26:46PM +0800, Jason Wang wrote:
> > > Try reducing the VHOST_NET_WEIGHT limit and see if that improves thin=
gs any?
> >
> > Or a dirty hack like cond_resched() in translate_desc().
>
> what do you mean, exactly?

Ideally it should not matter, but Tobias said there's an unexpectedly
long time spent on translate_desc() which may indicate that the
might_sleep() or other doesn't work for some reason.

Thanks

>
> --
> MST
>

