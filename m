Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032E4290E
	for <virtualization@lists.linux.dev>; Mon,  8 Apr 2024 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558159; cv=none; b=plulsJWJhV4u6UkLlZLbb4Uz4ZAP7BjVlZgrx4ZXhzaFyRh9Mt5CVDTC4GXxq/kpEXPZJ1fL8AVCBMVDEH/g9G+9r1w0gLjE/jEI9H7Dw0v80ar7xq/0OaUXY6oMTlvgKizfU8sVV2pan4OPVLjce8W2i/kutUHpAAjwEbB1BIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558159; c=relaxed/simple;
	bh=GB58bQle6/TE9XhpcBSQjj6cikX2bR8e+VuUWv1u+SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLcWx+MfAlOgzqSnrxC+oq9rImNBtwFtXf6VdJp7CSBhNSwaZaktcGO1scRdtTTmiUJVC+GKRNZ9f+HB/udznEG9KCaLaxG3SI/AbpDachxeyzd/0F5DeIwZhFNvQeea/rusU40Hla311AiHggN8GvQH95J6up2DiC59tj8xcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=R2VjOaGH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="R2VjOaGH"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51d05c50b2so98543366b.0
        for <virtualization@lists.linux.dev>; Sun, 07 Apr 2024 23:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1712558156; x=1713162956; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB58bQle6/TE9XhpcBSQjj6cikX2bR8e+VuUWv1u+SE=;
        b=R2VjOaGHWtymMHm769s5N6VYFGm0I33tjhad+riluWWBj7M1FbDXAzNL/hmdY8KurX
         WXHztgV54BmlfTriMMCEXUvSA0Mc/5nK1H6jM7tvyngpBhJByqHSQLPIGIrW+TAG1Lks
         0Ksa9PNL/ERDzi8bgIqUg9DekAyudhOkuR0F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558156; x=1713162956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GB58bQle6/TE9XhpcBSQjj6cikX2bR8e+VuUWv1u+SE=;
        b=fRUe9MtZVyJQwHoKTiN9NHXJs7ji0BCbGNjvrkmlGAFW0Fc0m85aUecMal1Mmsj7fX
         ledqpWGBUD9eI2iaF9U+ByWnv9DHkGqQKWURr02y7HH0GK1YYY80fUSLHDwnUv58OnWL
         ddCbeEy2COvC3Yy9zXAh6NyXpx3Y2GglDoC8unQNaCNdU32ikqvMBHl6LQ28MQ+9tHFy
         WfILVck/CSCkUwzpZyhlpKfbEqDZb9xklJfQedtL+YN3JWOGwSjMYa7SU93WsBfM+JUA
         f+ft+FPQcaiftww+6fS5E0j/1GSPJuqcD+Y5ipVR4EEcTfsh9467miw1qw2BjoVDp+F7
         21Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXMn03ddYhphEZ4mQB8uBEbcULCVs0a7K9RCLWXI+5lpB4RP9vtcnAupfmj8FcBZR/wkKZPZhU41hJfAobNuu2we9s/oW8kGLdKXRIBWFg=
X-Gm-Message-State: AOJu0YxqyCsGlrI/tSMl1MfbdGLNptgY+kEQm0s7WPV6Cd5CCdHxpYOc
	zBXZvwT356iXP3sxZXPLOx5x43WNn7CvvP1IbwLtfH8AMj+sF5tYhlo3x9j9TlHeKPcRbgYk4L0
	iRKjVk8nh6ITSGCW7E52lQxQND8T4oRhfRzJE
X-Google-Smtp-Source: AGHT+IHgOG1QFRsazaJJTQAM1OpfXlCUvvdH9XD6u9F4YJ8KIuAm8siPgnu/FFrnysbhWv7Ny+9JXK+VCjeK9WS7Rgs=
X-Received: by 2002:a17:906:565a:b0:a51:9737:f23d with SMTP id
 v26-20020a170906565a00b00a519737f23dmr4595803ejr.70.1712558156369; Sun, 07
 Apr 2024 23:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+9S74hbTMxckB=HgRiqL6b8ChZMQfJ6-K9y_GQ0ZDiWkev_vA@mail.gmail.com>
 <20240319131207.GB1096131@fedora> <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
 <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com>
 <CA+9S74g5fR=hBxWk1U2TyvW1uPmU3XgJnjw4Owov8LNwLiiOZw@mail.gmail.com>
 <CACGkMEt4MbyDgdqDGUqQ+0gV-1kmp6CWASDgwMpZnRU8dfPd2Q@mail.gmail.com>
 <CA+9S74hUt_aZCrgN3Yx9Y2OZtwHNan7gmbBa1TzBafW6=YLULQ@mail.gmail.com>
 <CA+9S74ia-vUag2QMo6zFL7r+wZyOZVmcpe317RdMbK-rpomn+Q@mail.gmail.com>
 <CA+9S74hs_1Ft9iyXOPU_vF_EFKuoG8LjDpSna0QSPMFnMywd_g@mail.gmail.com>
 <CACGkMEvHiAN7X_QBgihWX6zzEUOxhrV2Nqg1arw1sfYy2A5K0g@mail.gmail.com>
 <CAK8fFZ6P6e+6V6NUkc-H5SdkXqgHdZ-GEMEPp4hKZSJVaGbBYQ@mail.gmail.com>
 <20240404063737.7b6e3843@kernel.org> <CAK8fFZ5LHFMPAOFCKu-vr7JQJHKo9jshrgvCCP50d596nFiXUQ@mail.gmail.com>
In-Reply-To: <CAK8fFZ5LHFMPAOFCKu-vr7JQJHKo9jshrgvCCP50d596nFiXUQ@mail.gmail.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Mon, 8 Apr 2024 08:35:30 +0200
Message-ID: <CAK8fFZ74tj=u5HKfpFue1ejy_9V3xWdf-ekC0gLt8BmJs7Y5ZQ@mail.gmail.com>
Subject: Re: REGRESSION: RIP: 0010:skb_release_data+0xb8/0x1e0 in vhost/tun
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Igor Raits <igor@gooddata.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 4. 4. 2024 v 20:17 odes=C3=ADlatel Jaroslav Pulchart
<jaroslav.pulchart@gooddata.com> napsal:
>
> =C4=8Dt 4. 4. 2024 v 15:37 odes=C3=ADlatel Jakub Kicinski <kuba@kernel.or=
g> napsal:
> >
> > On Thu, 4 Apr 2024 07:42:45 +0200 Jaroslav Pulchart wrote:
> > > We do not have much progress
> >
> > Random thought - do you have KFENCE enabled?
> > It's sufficiently low overhead to run in production and maybe it could
> > help catch the bug? You also hit some inexplicable bug in the Intel
> > driver, IIRC, there may be something odd going on.. (it's not all
> > happening on a single machine, right?)
>
> We have KFENCE enabled.
>
> Issue was observed at multiple servers. It is not a problem to reproduce =
it
> everywhere where we deploy Loki service. The trigger is: I click
> once/twice "run query" (LogQL) button by Grafana UI. the Loki is
> starting to load data from the minio cluster at a speed of ~2GB/s and
> almost immediately it crashes.
>
> The Intel ICE driver is in my suspicion as well, it will not be for
> the first time when we are hitting some bugs there. I will try one
> testing server where we have different NIC vendor later.

I run the setup on a server with a different network card than E810, I
used BCM57414 NetXtreme-E + driver bnxt_en. The issue is not
reproducible there. So it looks to be connected with Intel's ice
driver for E810 network card and introduced in 6.3.
