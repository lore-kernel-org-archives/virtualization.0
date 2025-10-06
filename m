Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652C1A23B1
	for <virtualization@lists.linux.dev>; Mon,  6 Oct 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760115; cv=none; b=HIaddF1JGKp6XeNhW5QJCJ4K/zS0jgdmbOM7pQZiORzP2abjcdNWhhUuXFjhhJo/1qEM7IMAQP1kIkE+8VM2MQnksjSGIZIZAw0KyTvdhXSoQXdXKaOyahYeFYnCgSbSvvVZsAUBUq9EHd79Uj+yeT0I+Wp0gO5C/T9aQdaVLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760115; c=relaxed/simple;
	bh=dpC1E3ty+TFIwvkaEmernFgK/zs4Oj/TxnNsvw9c65s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mg3MA6u+I3XHsodG3ltbtBhjMOwfImMiwHplVHImL2W1n1Wrtwp4o+lsWx2f9aASAS/QLhb4sMSnVRESTM30Euy6PYmTuDn6asd6mywL+W/WUGqjhb1PPW1mdlvSwexG+tUaZhhA4pfIPBBbrozvuq6wInPlqzQSw/ToGpKbn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hny3TGOH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hny3TGOH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso37281435e9.1
        for <virtualization@lists.linux.dev>; Mon, 06 Oct 2025 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760112; x=1760364912; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dpC1E3ty+TFIwvkaEmernFgK/zs4Oj/TxnNsvw9c65s=;
        b=hny3TGOHM900WtxWybCRisf9LpsxKUMYTMmqHM5JR19Tar7uoFr3MyvB6QX2sdCetz
         ITc08LWIm5ZOQ95QaAHYwBSI+Y2j3ewrlMWKmqhFEGV8CtLjXYehsDA1OOONXqKlTv5q
         v87vwfBtfc7IY6mGn/0k1iPvaoSNwzIh4y/6opMyOqYINVjzXwQ3XXozxrvCFJg+KYXc
         eQHaugJi9KRkZFWMH+k1TUdXach1GL22vAmPHZrV6XJzXyuKpbsh5li+RfAdKKWVyihS
         VxbjcYeRdLaDXY0m2VJ2zEbExDTEFG/H/O1FLKDTsAEgpu06sSm2a3Vs8JPbzA50qb/d
         /1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760112; x=1760364912;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpC1E3ty+TFIwvkaEmernFgK/zs4Oj/TxnNsvw9c65s=;
        b=qtXHRxZahLFdAbiwLggcHJbJCJFFxfFN+HCGFUzv+u9uSIgNmTduCUfefP7Ol2OyGS
         vU4taNdORLdoHTZJgVLlx6DlJRZb0WaX160SPjMDeC4A9VnL6qNvOybopNG1xlW+JRzP
         HN35qlKZDrOrBFA5kxiLlTi7ApWsrKoEQ5USsuAfMC5JoRtKh25RIJFQoDyBbvI8l+qr
         pJiOG4dBRqAM1AKfLdqLRrsAjqsUFWbc6m+NS39zG6ZecAwEPZ5UWHu0wtJNZuq+0KVE
         IFH8OiyxP4mJ9GdaHD/Z3aVl2BcLrcMrRTeAWj8EDhetTqdFm/YDh700LVIkdOFPT7T8
         aGoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYZxeo4eeC05BAJkyyv+nO7h/ZTU+1nnkKjEREytDN4rxwr8hRCc5QiZpFDMA+uWprcLN4lKWfLzKTf2VltA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yweud1bJhw9N+5UVJyAoXsqmmDb+x9lAtyWTGH3eTFS0Pz6utxM
	ediNfs6xipWDCy9YhF5HJutVLGEnVPJTzpQzFOfkODh9/3a3AtScJ9eM
X-Gm-Gg: ASbGncv8fiEca8urkAPXezqBuO3+2g0ldOzmbemTfYA5ENfmLOm7Q2c50YscbknrKhV
	qPWLuriimMRwXz9wJgdnHgPhhrvUm6/AwVaClh//9J3QiZJZStU2zZBBQAhvE0n7H/CB+jjH0de
	ourOFVq2gT7f+gmiNaofyHy6ncGKO/lmeKxdcFOSobHtmIk23ql6XPdZsoVcv0l6SLxIrmt9bHx
	HAkSgxkCv8tU4jNXFr/S4dR5ZsUPNXL4CvJJuh9ORI59WTEHc93HmGUY+VQjB3++92PIv2cjA+u
	4ye8i1rzbkV3xdDQ9ibBD2+DKMsVxJasTyLH9Nu7UKzfJ7lTCUG7sj7NpAxygc885wROzD1Q83D
	E8LjP/jzJKVSJxtzoyZvh96HFfP1M+3k8csEGwY3SFEive6Z0ViDxORAPZXenqrK9JSKPav/aMs
	6nAP7xZQ==
X-Google-Smtp-Source: AGHT+IFvFV4OWJrtZLVyN6HOHxV1pZ8u+HpcMb9x2itMg3VtsVtai86lf60GZYy3ywG2hvyKpuqDFw==
X-Received: by 2002:a05:600c:530e:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-46e70c5ca50mr85971895e9.7.1759760111974;
        Mon, 06 Oct 2025 07:15:11 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72359e2bsm161672755e9.13.2025.10.06.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:15:11 -0700 (PDT)
Message-ID: <a4e912547211eed865bdf769647936c1e3034e4e.camel@gmail.com>
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stable@vger.kernel.org, Maximilian Immanuel Brandtner
 <maxbr@linux.ibm.com>,  Daniel Verkamp <dverkamp@chromium.org>, Amit Shah
 <amit@kernel.org>, Greg Kroah-Hartman	 <gregkh@linuxfoundation.org>,
 virtualization@lists.linux.dev
Date: Mon, 06 Oct 2025 16:15:10 +0200
In-Reply-To: <20251006062851-mutt-send-email-mst@kernel.org>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
	 <20251006062851-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2025-10-06 at 06:29 -0400, Michael S. Tsirkin wrote:
> On Thu, Sep 18, 2025 at 01:13:24AM +0200, Filip Hejsek wrote:
> > Hi,
> >=20
> > I would like to request backporting 5326ab737a47 ("virtio_console: fix
> > order of fields cols and rows") to all LTS kernels.
> >=20
> > I'm working on QEMU patches that add virtio console size support.
> > Without the fix, rows and columns will be swapped.
> >=20
> > As far as I know, there are no device implementations that use the
> > wrong order and would by broken by the fix.
> >=20
> > Note: A previous version [1] of the patch contained "Cc: stable" and
> > "Fixes:" tags, but they seem to have been accidentally left out from
> > the final version.
> >=20
> > [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ib=
m.com/
> >=20
> > Thanks,
> > Filip Hejsek
>=20
> But I thought we are reverting it?

I'm kinda confused by this question, because I thought you already
understood the situation.

I sent this backport request after a discussion with Max in the revert
thread, from which I got the impression that the virtio spec
maintainers were unwilling to change the spec to match the Linux
implementation. That impression might have been wrong though.

When you sent Linus a pull request containing the revert, I realized
that there was no consensus about which side should be fixed (spec or
Linux) and told you that I think it should be reverted only if the spec
is also changed. You then sent a spec change patch [1] to the virtio
mailing list.

I'm not familiar with how decisions about the virtio spec are made, so
I don't know if that change is going to be accepted or not.

[1]: https://lore.kernel.org/virtio-comment/7b939d85ec0b532bae4c16bb927eddd=
cf663bb48.1758212319.git.mst@redhat.com/t/

Best regards,
Filip Hejsek
