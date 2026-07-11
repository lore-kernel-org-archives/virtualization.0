Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798E92E7389
	for <virtualization@lists.linux.dev>; Sat, 11 Jul 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783809; cv=pass; b=nlLakw7KhFT3/RsRCNB9p2ar5Q/OwILWwZv4q63JzDDihX49COTkihzpHT5YHymjdWt40zq4M/2VcIxS6kHN3Ta6eRR25WolVprlnD+puMMX0rNQ6YbgRSgwfD5sBqbCkS2XyBzXXbtD2Qb6Eug+0t7YBCWDAw27+zhhA3XGvNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783809; c=relaxed/simple;
	bh=VgLcjMWmevXm7ESHz2wQzgI3sAUBCb1NgNAir+5i0GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g10p2RlE6S1rGCHAJZCthhz8vRVy6vi/lOkivO9CL9Bvdaq6gzU7cRYJAemObSDK30tXocV80nfjPPkcAozKhtaTCKCN8qLnZncJEfp3LjrEgoh00gwDzmg04zy15NeadOLcDoZYPGBQJy0HXktRTZH+NC8ZvGBwoMGllHTOFE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okViXq3m; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okViXq3m"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-667b0ced2d3so2916224d50.2
        for <virtualization@lists.linux.dev>; Sat, 11 Jul 2026 08:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783783807; cv=none;
        d=google.com; s=arc-20260327;
        b=X1j3QaZksIyHqEA7IcMMA1dL+vkoBfEsc6Ch5Ijj9G0iHtmchRUIwEn4c6W7wLWrwC
         LwV4e32SXGs2+Fgqi5X6gWGewsEC/bcTMVqVEpdptBQ+JanNmHcHqWzK4y+8VKTaBHOB
         dc92WmD62fyFjPowvb8N0VgWIku5mAQG+sjsKwk6Gu2WRt6or95qYArm+vzmic8ozGtr
         K+RPHc7HTjgDw3HbLkeXd9Dh7wsggwZZhoLONdNt4NTb4kom8LHFrcHw7uBBG8hFjrQ/
         REIEVCv3FKmXJ146HIRWC0GxTBKisjG1cfiQk68dZmRs7J0IVHpxhb/xn6sETWdxAq8H
         stgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+djRPG1+yP7gLniNybddU9i7XevMPm8WBoJDKoJ3OMs=;
        fh=pfRztQVYMXGYiqiOnDVT4qsnOQLoHmBU4mD7x2fXFAE=;
        b=qqVvyfQjiUqi0i5HVh+OdTIBB/zrDBxx0OeACQBd2LlAKVC3XAGFP7aURfFhva6ycQ
         vQUHWVedJ+jPFo/5Pkwnc2gGD1nDFffuvBQyGa/NUZbx6BBqNEgG7x2H3whaYuC4wibn
         zfjcv/TD5W0+xYMKGec8ziYoRBMHsd4P8fOgs+CGtHX8euEi6MfdOqAtrQ5rU/mq1ur8
         QD5jqyUpPqZrZS+YY1paTjnwoK3yZoJCDoF6zdytnLzMkBq3g+NmTzJfcq+ZzaESKEI4
         yKDvbzsSgMfoyI6lOpOlsgL5F2lsnLm5gbY2Tya2IijgDNehoMCTUr9Rg4B81ee1wi93
         dvpA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783783807; x=1784388607; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+djRPG1+yP7gLniNybddU9i7XevMPm8WBoJDKoJ3OMs=;
        b=okViXq3mjXMEXe4dOl4SfbKnA7u930R3O9Y0RDrGqucWYqq5jyp9Nu6YhfWMtrHqm/
         uDrSA8BnURSCMsT2R9EfalcetFqgwxk1hBO1Eq2VZgz/sUMvMGIrHK66Ax3U0rC+CZJI
         CmUqk5shQjUZ7wpXA/+ZV7ij8FqvQUvdnJHCJJX0BzBDdO2gd2jts/Iz+MLyTUQPQ3vJ
         OSFUlubiF9Sbb8KTBay4bNa8f43q+g+YQporZ8Hi6aPuIQvATHOKa2yx25OllikG9b/a
         Ddq/WwQY6p1dXZvDOcbeukt2TWmhhdnLQ50xoHfFmX2TzlT+h8U4Ae34PaXFt2m8BIeH
         IT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783807; x=1784388607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+djRPG1+yP7gLniNybddU9i7XevMPm8WBoJDKoJ3OMs=;
        b=dw9hzndmbWwBLynccMAd1UD+oNrxY77Qn4YwjDVs8PfriRMuDr1QNAOzn2jamix+Ip
         P2aKe+UMDNmvcLbSMaFu76EpkInsFtTW8sgJ/08+jEICRiIwBnoBT4q4eJQyovvBwrN+
         QqkGx3A3CpQFuI1D25B9K+VWPoapKQuGco/PGb5g/c0zaH48uZOLPRH+n5PSmjnS3gPE
         5nAa5vVn6TeENCmzIRBxRXmTc7TfaKiZXp4xPULJHLSYXcXcvDWx1SRbLqiY1MIKf+zO
         NudPCzOzWoROZEkvw6RL1tEJ+3ND054YzO1nU4Bp1lUD7ovj1sPylbdfIMqGiDgQ95zb
         TLXg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2ugm9oMIk96M2rt5IkVZOukWb0UA0sgce77LDeStiSzKcaSwZZytjRofcEAs3LJoMTcCvq2pNJsyCew0E2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq2EdHO5VlS+ZYyRIfKie0O8MV1rmzmYLdXlSz7pd7P8cvYIQO
	4Mn85hisHainQ/LVxbdt2GTb1yiweVCeCRuH3N8wGnaKm5Mt+Zm2xRhNw76meb2/Mqjts5iCcf8
	53TtEAKClzuHgP+SPNzaWS5tBgZ3IEbY=
X-Gm-Gg: AfdE7ckJPoR7zOpEHjFr+GYOoNnj06jK1NWtU4sKxeccOvSFxO4Nd6rgWdx2L6jstQ5
	wHahaWc+4RMiPx6np3le6Bsu5uqXGmD3XFxM5ahm+o6rj8G+hJ7v+rDwiVeCQd2FhvYEvsSAP0p
	+ASJ3qv9rmckULntM3SX6BOuzSaLwJlihMAYs/s0mGtANn1+p2gG7OtizZIbG7SLTADkyOhgVaM
	GTWPywdKixIkb4gORGJEMfXzUfWYGwX5euv4fVlEpfhBipgSZQ3sTcVOvVLqiYrkuur4hsYqtOf
	5dksDqW4vlfT5LsgDBez+UIjxhuYymBwNG7b
X-Received: by 2002:a05:690c:480b:b0:81e:4e5d:4849 with SMTP id
 00721157ae682-81e90060695mr22842997b3.16.1783783807477; Sat, 11 Jul 2026
 08:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260711150754.2918392-1-michael.bommarito@gmail.com> <20260711111503-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260711111503-mutt-send-email-mst@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 11 Jul 2026 11:29:56 -0400
X-Gm-Features: AUfX_mxgD_lh4gOsRso7LSqjgvGgXmvPV1lIQqbOp9oTE3YTU5O6OP4lBsiP8lo
Message-ID: <CAJJ9bXwUtQ3pHqZ=AMuwaNLs16pmujiMdeBQtB5kFc6JjM-Pug@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: validate device stats reply records before use
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 11:20=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> Why does it "matter most", or at all, there?
> Host can always deny guest service. In fact, this is how cloud vendors
> charge their clients, by denying service to whoever did not pay them.
...
> I'm all for making things easier to debug even when the device is buggy.
> But I'm not inclined to add tons of hard to maintain code to
> that end, and I would be worried broken hosts will come to
> rely on drivers working around them.

I am always confused by the CoCo threat model to be honest, since it
seems like some people care a lot about maximalist reliance on the
contract and other people are more practical about how many other
vectors exist anyway.  No hard feelings if you want to NACK, but at
least it's documented publicly now for people to consider.

Thanks,
Mike
