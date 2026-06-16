Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCF4183BF
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598943; cv=none; b=V4L/JXrWMsCaikOJCmjNdXmtcUwz1g9nLoLdsdK5a+mtgQ8f2L734NsT53hYr08JJYw8ouj6fg6ekAhbLdJuUfPZbdZpLN9fsrZfWSs+I3HuscZw5H0fwMpGnPWNzUMNbZ40xHF3byk6vL5vjJqNRe2ugHLr3/yBZBwIjhai3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598943; c=relaxed/simple;
	bh=BYNWjDrljSu++9EAAQn7raDvnykGXPVajd+F+x7ETEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpwZa2fpdz0gdOWgRtG7MNNOd7iXf8i9nWslsh6MG93y9e7snKIkx14HC4KwMdd67ExcHcoObteVtVBgUBBWR8M2XGb06VqWcQGAvxKcJNrylZcgeELuEBJ+Sb7tl+UmSCuVwdMMLoBMPClCd0NExJckavXo1mgrMtzDWOlqUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blXu7VXo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blXu7VXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781598941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3efmxi08uqzcSZPF9PPWMJrIYYHz/b0LBw8WBsw1Ns=;
	b=blXu7VXoCIEAPxddbOWBq7pgFJZR2oWRaz3kzvL4xmlTNAGusulSEMWUZBnCZvhlaBp4ay
	TVSNpVt53c8WCwUz1JQDhbjDeT96PaVaTNGF9syBL9rduKyHRHCoaeutR6BUkccEvLeTM8
	P5398O2yEZp+AupEiDNQsE2cUTp/Cos=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-nLFo9C8uNKOHhD5Uw6sUhA-1; Tue, 16 Jun 2026 04:35:39 -0400
X-MC-Unique: nLFo9C8uNKOHhD5Uw6sUhA-1
X-Mimecast-MFC-AGG-ID: nLFo9C8uNKOHhD5Uw6sUhA_1781598939
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66073c7c2f1so886485d50.2
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 01:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781598939; x=1782203739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3efmxi08uqzcSZPF9PPWMJrIYYHz/b0LBw8WBsw1Ns=;
        b=OG/sfCqPZ4zGmZ+ySIQqy6ikOhGLofq+1EbuRe/KJLutshoOz7aKa7RCOYZN2nGPzm
         Bi4v20EBbm9GnNpUahBNXOul2qAE2z3oqOYrdvHChuk8r5LFq02NrZCmTivXS/IGaN1H
         OjPUCU9ljN0e1fsU/T/FWQA4HvNkHSkW20wjGKzVU56ziKE24uIgFGWCicIOoqRyRY6K
         l07y3j2ZEHucjCuyHArIG7dqp0D7kCMB0D3by8hwOixZoVzo6j8AkQ/UpAb3nSUabz5m
         6TfH7etEPCw67sIw0a9uxWgsKCSVpvIP6XzYms6IOV1phrHGD7zUw0lCLVgRsjx8hQ14
         M1sA==
X-Forwarded-Encrypted: i=1; AFNElJ9wAKgryrvoIg1LRki4DfFsXiO/1s3rwiO8s24/9SGfBdTrqolbdSfxC/gG9OUeWyjMZ8/jTE5b6/95ZQHsAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw13e1EqvJlbbbXee0wOB9b2Uo1153dqVZpNQQcj8EWpSv6qoB2
	jRrjKLeW14/1rCFr/NHp31VQH6Ag9QUiuTV9Xps4MNf7OXkmvf3FfB4Iw4XLYKLqKW6baLHQD9l
	HX3EPskgk1vr9TQy6szQhcpR5YH4HqD8CoFRurfxaIAh7FOV99TPD/6qzuQ+oLfEYub5949vYXJ
	pP0NWdPHDy/M0T4AR0AfSHwR6oHqwQiSO2nafZLrdlD1I=
X-Gm-Gg: Acq92OFck3i38p8NRrtOzUcIeud/rVl9wHGvwJVxvs0zzpdXdhdkYWQQ+dCThlCUuID
	viSs/d7zwRUc1SuBpQN0JlN9yGtSXcNMg2lKlPc5K/2Jd0zI6ZR/eqDivYKeCxlGMYaIvmEsFw9
	dSYiLZaehD1XOMmG5RI2PsP8sKsqxmQnlCuyv/K6abg+8p0MeY8YjTDerD2Rq2OKi+uhHNvVRdq
	/6w8g==
X-Received: by 2002:a05:690e:43d4:b0:662:b56e:64cd with SMTP id 956f58d0204a3-662b5f5938bmr1327759d50.8.1781598938670;
        Tue, 16 Jun 2026 01:35:38 -0700 (PDT)
X-Received: by 2002:a05:690e:43d4:b0:662:b56e:64cd with SMTP id
 956f58d0204a3-662b5f5938bmr1327746d50.8.1781598938240; Tue, 16 Jun 2026
 01:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
 <CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com> <20260613144612.0c5b7ba4@kernel.org>
In-Reply-To: <20260613144612.0c5b7ba4@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Jun 2026 10:35:02 +0200
X-Gm-Features: AVVi8CeQ3jVbf-KzGUfJXXjCbhXarTVvO5RoA44we9duCL1ckJ3ss1l-cBbGECA
Message-ID: <CAJaqyWeGAoH_vy8a7ZPAtCzLMg82rjP0uja8dErXj+gq70FWNw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, xuanzhuo@linux.alibaba.com, mst@redhat.com, 
	jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: noyMKaxk_tClvKMQMRObxz6J-vROfnFNugs1Z41hw44_1781598939
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 11:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 10 Jun 2026 10:27:28 +0200 Eugenio Perez Martin wrote:
> > And the From and Signed-off-by emails don't match, which I'm not sure i=
s valid.
>
> It's clearly the same person. Please focus on the code, not trivial
> process issues.
>
> Quoting documentation:
>
>   Reviewer guidance
>   -----------------
>
>   [...]
>
>   Reviewers are highly encouraged to do more in-depth review of submissio=
ns
>   and not focus exclusively on process issues, trivial or subjective
>   matters like code formatting, tags etc.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#=
reviewer-guidance
>

Ack'd, it was just a nitpick since the fixes tag was already needed.
Thanks for the doc pointer, I agree with that so I'll try to avoid
these nits in the future!

