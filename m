Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795843176;
	b=jhquqb2kEGiQmp19DUtbqa+wEp4iRyfmN/+HV+Qyn9vB8oCRYuF5Kyy155OfKx3K5/gJ
	 j6xKa0c/C2NhXqhJzoqjloleoY3Nre39hRc208qvjQVTbiQpI/IsKyEO6ASO/0BFCOT0+
	 7Pzk+9djNQfj7iCkexk/EaZQl0HJd2YlHIcS2CxWksfGEFMlfiKeqgS9+MwSFmq9wqv2+
	 vJGUhxu6AnYzT9WuKsnMNpW4jiLQlQ8/UjYF4tvbbCB6/QMOz3X9M/LUqudqHedOkm5Qw
	 +y9+6DwAGNEJZxurrgRv3vZH7AwxNG7quv4ovxX7NZgAYZZT0vpzjGHv+TFdRavdlVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795843176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HtNzOYXtrlk1GeN45JF0qQjTBnBFa2AUeyHnRycNV6Y=;
	b=L/iVHTivAJ7BAHfSNbQ//IO8AR/0OB/DlhlAnRn+M3fUTZdi2+yGz37+eZ2I2bcRrKBJ
	 GrtyOehCIiKXcaH63/26Q+h56rn+JwT/nKhCRKggKmRrbXFVh688CsuJK5iZX3Y8NHGyT
	 l951bxvNaPHO3z3JPIk1T1IV2JR1P0nFVBkvQKRTn5FHixmlzFMozbsrsLH7f9xgn8rR0
	 gGK2j4u8rmonN8RGRAcpF23T0Yh+8LXVAeEdkem8ADRNMlNHanjU4oR0yUx+GcFraSnwS
	 t54D7FA5S8fOM6pF4JlmV4j1Np+OpA+kcbr7odJuvBXpEkABw12c9wNOP72b50Ki1xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFmxdeFI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C302606A31C
	for <virtualization@lists.linux.dev>; Sat, 28 Nov 2026 05:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFmxdeFI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070461F00897;
	Sat, 28 Nov 2026 05:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795843176;
	bh=HtNzOYXtrlk1GeN45JF0qQjTBnBFa2AUeyHnRycNV6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TFmxdeFI6ViMbdgGeChnHmlm/TIftSk1pGBuvUBLElzFkoS6R6826SpkoyQ3eSdwf
	 cMhY1KDwv7LZfBcQ7d53IumFxL7V3Okqux5YfME597B+12MCTWMlfmsqxrR/Hxxf8l
	 pIp7nQrwU8YrcVFmeY4tcf9FYXQG2zYABon4aTvI1AtAhl8cSrXWk0WoEK0H8Hty9/
	 155hYiIczUPmlAxh6wbXyVhvlMsFGvRNSmHi/8ZjSRKlyiSqmgn/6a9y2fA7Om2ghk
	 5GQf/a4lsArRCgP4/LQedm26wNovIKwVXbLSNe3QnSqS2+ySgo7SLPU3j3st8K/ges
	 vdymucexI+J7Q==
Message-ID: <sashiko-outbox-238471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 0/2] vsock: preserve receive timeout across partial
 reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <weir@nebusec.ai>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <cover.1795587333.git.caoruide123@gmail.com>
References: <cover.1795587333.git.caoruide123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 05:19:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Sashiko has finished reviewing this 2-patch series:

- Patch 1: no issues found.
- Patch 2 ("vsock/test: add stream MSG_WAITALL receive timeout test"): 1
  potential issue (1 Medium)

A detailed review has been sent as a separate reply to patch 2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795587333.gi=
t.caoruide123@gmail.com
