Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725582;
	b=tos6PCdSB1Npo9iQGml0wAoY6kpMxbc2h0lh0a3+wRpfYnjWeggjmp25hfQ250h5syl+
	 XIZu93t6azruGkFsED0k657uYmEWi4ZxLPuw6CvrYaX1qffWfF3FsDPt4LC8U6Myyno0W
	 Sp979Ew2bBLcSFnnxkUcGUpanFSUuIlcEz3PV/nCmshRSKtbUWMoEe5g5MTfEdwKBmeJ5
	 /GnZ4FuyHRwoD5IgL5B/UBf98sbPcVgxy5l8qGj4EL6qEjMSDSSQevfVClkBwi5TrLNM9
	 AN/UBZGHmH3HEksXu3mdAJof3s3K/5foWskvsCVNkuEK8i6u4/VsIA4RSYJ8x35E2ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=59iGDOcne8oZ9CQ+nnh1K7KAR/IbzmaK4/PRVFsySsY=;
	b=3Qet1z+eNwasu5PaIvlF3yttsTiHUZB6SbM+TpyGNcUPR46PFMaxvgKf17sv1nFIpcKS
	 RfIG4KS46OSmwalnTsUohrRA/g6xcOMBzGy1AEAYvVLei0j2WiO62NTrmZf8aIkv5w28e
	 aDYB6uE5s7K+y0ihjYgT4K/DNmJTYMImgP2HvyJ3AAf6I+JB2CQKjqEH+PmxRzF0MwVc2
	 SygP7xQtb94BUnnqyYFimhJRKy/VdiIDgAla/6/LB/8Xv/olociNRnYK90EC3w04Dsla/
	 okA1GGAbbvY0auqgH8PvHhCcZucgVV06b0cokdvCQSSXuY77jn0ZrE0GXV5u2fS27GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bNzjxTwG;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E448606A32E
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 17:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E448606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bNzjxTwG
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso7374237eec.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 09:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793725581; x=1794330381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59iGDOcne8oZ9CQ+nnh1K7KAR/IbzmaK4/PRVFsySsY=;
        b=bNzjxTwGI6f8C/OPwA027SwOrhvDNd3HAYyHiK79zNbB1XmYVnA5/hvxK3VLyJtpk0
         Eu5943TXCvUm6K3QMe0DMKR9gMXBb/Mb+Dqnl+6UCf2oTKPsKBcFDYhuQ24QAnj94FwR
         S9cMpihlxfY2fv9SG5lBszhxWJaQQYYNeUStVuQLPrnh0DYj04xBfowQwnOdZmdAUipO
         8SssjfsdfKdAh1osZEA+Ih3HKW3b7wcgqu57/C0eA5JqIxZYwWoZqFeKAPa42bJCASJ7
         fM6Y+hGiMaQrQhS3LFTSEteIuMFuuL2eZPe8jPWyoUE2Yz8Yz+p59tSi6m3ZN5iqd7vs
         Qqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725581; x=1794330381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=59iGDOcne8oZ9CQ+nnh1K7KAR/IbzmaK4/PRVFsySsY=;
        b=2frSNxh54Du2unhIKCdkT9F//TWTLg2IYcvXNCTjNY4bq7RTd9nHvCao41pbS7i5OR
         Fr2OaRFh1MkNTyTc1M2xat80iTmmtv+GUb2DuWBJCIjtGgzKKOlZM3k25RbmoHXd7DuM
         0+3HPW7Y/2K6KlUHF83gG0e6WQ7w329RFInbW4OavIvru8a5ud6sxkqcMxlVYm4jKRa9
         kdtpqnhQJofShPv7mp5DxdlXPnV1mlqOcerTTGhJQw1PYanBpKSfgszA/InkejsNgp2t
         EEzKD1bvF4yktfrC5/bViAWB3bSQ2TyApbC4eDxkTmhK/jzTz11V3JVivSNUW/TFofp9
         8eNw==
X-Forwarded-Encrypted: i=1; AKwUvBxgUzyCqKfEc4XCue8gNFDpMV6kWp44bvqcdoJ2xHKqA40tZZDpTTCFUVc8+Y4M8bi9XxPYUQc1hWSZrxkNDg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/s983EsBXnIRIDjBzYwWWDNqvLIp7M0t3qFI2rL7YQTi0tu7cI
	0A4ElsVKZxOQTzYtM9BRElLyrUCUlMNf0X+Iy4eNN/QPjt8u1lVSBCr1
X-Gm-Gg: AYBFou24kPdZBA5TCc4aubi8AY0NzEkdrjG5MflQTOOzS471r0SAblamSUowULee3Am
	x/xcd5cp17Q6plyU6aYmNWq6VMVZqnLFm8sgnNUsSZQPxAdRc46h+J83IZbm9dxlAimpSMBMmmi
	eboUsOsa6196eYIOvc8Tee3kPDHzkIQsD4kkeo7UMhdVkHju8tW1cc1/+OGUc6Pp2j4k0PwBn4Y
	7hVXW7JHTDYjSt48fU+nGn7cda+e0LI9To63OQpzrgd2gEoG9kmm6sno24e/YiMAlRvt2i0ROG2
	AuNCYd8jAQ54ynJhQphjn7FKNpzh7nyUboamgbQqlkttrc0AQV/QAMLJ1MJ8tOFPn9+PdAk2/+c
	XJfOLcPuTkfiz57WKd3bGknHCh6n6N9OQRixiponFbA7UcAiaTJDFDv0nS/6gr+b1bYflamq69W
	tXYs1qYq49TtY5Zgg8NtR9s1ePmq1n8dpU77J/SsiZYM4GhDfXDBhvLN3OhcfzFSPzpwy+QqAZm
	r+Mmnszzx+TdmMEyScEb1/cEg7Z4Rahno9xHVcY5HzfuTdkv8HFvuv7WdWn80/SkxBlIY5Xs+kD
	FEd+A8cSa8Q/mlkxfjxVJKfMQMwtVEwS+yGUIqJ8/dRS5bC2492VGQJVU0reQztxAVibnD9/liA
	yxbaRJB0Jl0CSxTdJ5sn9lJ3tVaZ/wgyrJWMcVWpCT7Co1Vuf2+05AxIe9nDyEYNd+Cs9qy6v32
	o=
X-Received: by 2002:a05:693c:88d2:20b0:36a:6d52:e16c with SMTP id 5a478bee46e88-36a6d52e261mr9285160eec.12.1793725580459;
        Tue, 03 Nov 2026 09:06:20 -0800 (PST)
Received: from LAPTOP-97G9G880.domain.name ([106.222.203.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a504c6sm49661571eec.21.2026.11.03.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:06:19 -0800 (PST)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sashiko-reviews@lists.linux.dev,
	Mike Christie <michael.christie@oracle.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Eugenio Perez <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH RESEND] vhost-scsi: use FOLL_PIN for DMA page pinning
Date: Tue,  3 Nov 2026 17:06:13 +0000
Message-ID: <20261103170613.162803-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102073033-mutt-send-email-mst@kernel.org>
References: <20261020182640.2048506-1-karthiproffesional@gmail.com> <sashiko-outbox-180555@kernel.org> <20261102073033-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 02, 2026 at 07:30:54AM -0500, Michael S. Tsirkin wrote:
> Karthikeyan were you going to address this review?

Yes. The leak Sashiko found predates this patch (the same loop leaked a
put_page() reference) and is fixed in your tree by Jia Jia's
058fc59326af ("vhost-scsi: fix page reference leak in misaligned I/O
fallback"). v2 is rebased on it and only switches that loop to
unpin_user_page():

  https://lore.kernel.org/20261103165917.148720-1-karthiproffesional@gmail.com

Thanks,
Karthikeyan
