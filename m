Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9620370B
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150810; cv=none; b=jzZCacALqfFW1a3Hd0sJnyFnD5Lu3TsogCDRec33ujmdNMA8F6x0IcxIyNH2KELKOF0az3GCbWfQ5JxZUgO+/CG1qJtEM3ORThu0Tb4o1Ig80vPBOMGRe4TLYLYCvA5D7Xlm28WEIJC1I2S7b+RR7wIb9pljhFKtYTcWdtNJRTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150810; c=relaxed/simple;
	bh=5XiYO7bxY3Db6NEw7v4TiSKU5u4AGw26sTZNdVrYAko=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=EoS5Y+RvbAsCXGIfObeJRnhpdVi4+fIrPJ1/1J4MFqlnvpg1kxVlomv/NC4QISVKSwN02HMK7pOw+XRDqBEqTPmFv7sHzruiTNwSHgPynBe9kyjdta23E7Xs9hqSBAnSFPdFur6jmQKztQv4iLUk083mi/8+4LoPe/kz9HaJcK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvhAWFQK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvhAWFQK"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso423069a12.1
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 16:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758150807; x=1758755607; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5XiYO7bxY3Db6NEw7v4TiSKU5u4AGw26sTZNdVrYAko=;
        b=UvhAWFQK4SeAXz6otfgLd/G3M4u9THWBTInHQf82Mx5TplCym3E+tRIrQF5hM2f2cO
         /PH1HXjapIhqqJ4P59xoKHsNaHfY0i/rr2EvcodWIYPTrKin8La8xmciT2JxaqxtDBsA
         UhPQ6UMWk6fkiB6XixHU9rG1POmX7xhaFfCIblD/uNI7a6aedlyJLAoBNfAK4P/ZllHZ
         g0JA3g07/kEZU0PuYJnyXQ5vgWme2/2/wfzSVll7W/oSUojvWGZzEiKiMFx/ENfl3VGu
         NMq2JK4tur9GPL+Hl4FgRXu21XzaO3MMlJHoDqIXzN5iNxFqmlVlmGnfmclByBGBqSVY
         pXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758150807; x=1758755607;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XiYO7bxY3Db6NEw7v4TiSKU5u4AGw26sTZNdVrYAko=;
        b=DcrnN37adWNa9Hm3FjQDv1JAxmY7rvInDCkpLiU6u5Y1m6p2DK38z/+l401uw20Mya
         JFK6fJMCemkr2xIdmAVKhnLwAD8FbQXVsjq/k9VP7laNz4WX/HnY/HQ4PJtkdG22sBXf
         rYOi0mKg5zQpS4A/Y3HTuPuxus6A2hMO3JAaNH/APvnqolfICgUz5Q0TrXwQRVivth+V
         ah3VbRtkTNybfOcmmgHVqicUZp+dJttDJtvIi+Wbo02G4PlXaWOxlA06/h0dGLTspMJe
         TvStxSH9/0pU2qPnbSdzSB8glDbGq2E28d3nM95YiDY9P4wl4RUDHnPyq83DdN/n4RaH
         XGtg==
X-Forwarded-Encrypted: i=1; AJvYcCXpFUIsbioI1exHaAhc/9fl+5Br9hxOuFbg1XOYynTz0YlDIID3HWkOtClfO9FBMuFROYeQLAzCSODfIpRxJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywlw3QL63RIWkZf2yUf+akXBvX/SFk1czIVIkpcYW8ce7lT00jx
	wH5/T8My5mZzR+d8uMY8SrgkcWPBzFe1We5ETgqRMJWnhwBNCFTTVVgg/k1lPnM+
X-Gm-Gg: ASbGncv/VFukaSj2Xgr9GyMJbJKVV88K9lIH6fo08H3r+NwYqFLfRGe7fTWCvj7jL9W
	V+KMigzBHGoyZLsEMCXHelkoxccWjI5pEMfAX0FTJr4CThPChCrbXU5rvxoGSRqVoL+I7TtvgzQ
	hQbrTTzkq9k5QFeaE2I2UEarnJKdoXyyuccFMzUkM94tNwPCk6njmAakoK7L+nGNtBN7wFddviX
	WxvqcwKhKqvTe2nclE4hlueMn6vkDEBQPZP9Z3rMRismRJtQoE/lt16ZQZs/Qo8a5m/263l0Ng7
	2ZBcZq/0flGWfFbed5LYVKHuEvMMeRdf/hWd9PmZUy3YI0KQBCr+vfgazXgWTnvvA2yfO0gB1gv
	lSW8ftoXRGrkQW7rbyPLyCMj0OkswVxpk2WWP2Rj+oDgspp/fH/JunEAHzvMGUNEEdKLJ
X-Google-Smtp-Source: AGHT+IG98aQ5FwXvLTrJD63OHQ0Iwiuhiyghh+T8O/k661ClbeZPhpM/Dtz/FiShgdzzaGKD9JUgvA==
X-Received: by 2002:a17:906:dc91:b0:b04:6cf7:75cd with SMTP id a640c23a62f3a-b1bbd77a791mr420272066b.54.1758150807361;
        Wed, 17 Sep 2025 16:13:27 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fcfe88badsm62702366b.52.2025.09.17.16.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 16:13:26 -0700 (PDT)
Message-ID: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
Subject: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
From: Filip Hejsek <filip.hejsek@gmail.com>
To: stable@vger.kernel.org
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, "Michael S.
 Tsirkin"	 <mst@redhat.com>, Daniel Verkamp <dverkamp@chromium.org>, Amit
 Shah	 <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev
Date: Thu, 18 Sep 2025 01:13:24 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi,

I would like to request backporting 5326ab737a47 ("virtio_console: fix
order of fields cols and rows") to all LTS kernels.

I'm working on QEMU patches that add virtio console size support.
Without the fix, rows and columns will be swapped.

As far as I know, there are no device implementations that use the
wrong order and would by broken by the fix.

Note: A previous version [1] of the patch contained "Cc: stable" and
"Fixes:" tags, but they seem to have been accidentally left out from
the final version.

[1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.co=
m/

Thanks,
Filip Hejsek
