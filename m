Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAD1C578C
	for <virtualization@lists.linux.dev>; Tue,  6 Aug 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949805; cv=none; b=pDtgXKNFUnEkztCsQVIXXSHPYWGyhEh5XO85f6IEAH28dl11TZHyhJFIjEzssJpKzDMpY3eUn9R0QM0cfE4CE5PBrA6gpBIgYDHsv9SZT+4VovRGtkGufimT/D/PEsGxfwcwyxxMRCXcIy25AV8dXWa6EK8/4dEjVuKV4tA0do0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949805; c=relaxed/simple;
	bh=KREccnRV9/lcz1AxarrngZjnkiUg2IvSSWsvWfX4xFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCdhRMXPHWJ9WWCMnNvv4ACpjyEgCZLuioyjeB52WWCzsYf7mUCmAbywU6MeWs6m1/fC9dhFfGHwlb8Mj9K3Zk6NDnxNrjyaJYQ29INQjkFO9BozFn0NE2rt7u+WSeAL7aTmH/RNlrEXOF3o1QZHpRun2PD92lY56GnHs79ESpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjWtTrrk; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjWtTrrk"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-260dde65a68so364594fac.2
        for <virtualization@lists.linux.dev>; Tue, 06 Aug 2024 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722949803; x=1723554603; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KREccnRV9/lcz1AxarrngZjnkiUg2IvSSWsvWfX4xFM=;
        b=gjWtTrrkZnZTCxjH85fH3UhsZ8o/ghQhE5Q9yVf1754jJp6oH0kPrehoBxK2LsC++i
         rwNltieUFl9vs4/mba0f2YDw/AadEZJ+RDKk9XyVLsshooQL2qisaPAZ+bE+lDR5A+Lp
         MCgcbdDCk2gglq/yUkpY8zLCHQiVNjPmaYpl/reLoHo1L4VkVjW+GTLvq4MF6zFVI0R8
         FCsLx/1Ditq6IGBLmgdISrZch56bZRGuVXLBBvFOJtLUJWRWzd1Gvh2tbYvs1GaenYlP
         1vWwVixlwgylY30V3YL31I70BAhasX6fr1khBEhGr1eLmPgifmC+vmKMl5nLklqMnm3m
         Ge1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722949803; x=1723554603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KREccnRV9/lcz1AxarrngZjnkiUg2IvSSWsvWfX4xFM=;
        b=ia2mhUYWpA+tuNBgan+B6qOGg9l71yPB47dvn6ms2TZhlo/5FE2MvZSaS8pkJwUP8W
         TboQ14mKFnGkCi5JeoxjyIyKvLIw9EClhrOtSuLgHM0HE0yO3QkcuRI8Qz6al70sTb5I
         ga/wTbAf3Af0eVVILOBdNT+XvSUivi8hCPUmWDcuOVd8Z66dFelXY68jeVXLnXe7tK0x
         FBoLFyZj/0jZdWUKgSd4noIoKOu5Ru3TEfwHzQi2XGCXZsR2fRNkNwjeim/t/km/dHWp
         Ja/Z5s/IbgCxArVCVdcIWbOPZb4AskS9imBBMUDtX/z8qMoZgDBqLWFwnCUxu7pnv/bt
         Ontw==
X-Forwarded-Encrypted: i=1; AJvYcCWIucR5eVLfXxeTOAZxzmX3GmODa5lK2xIL2pZF1HDiy9f5MKdc7KU5yaqeeI3sKEQmgErDh2VvroYGb79wZOnkP09rB/fGTigcWqCwYY0=
X-Gm-Message-State: AOJu0YwA5GAIUGl7kA8Aa3k3oBFRfQjub3zzJ4VzcPxt4mgXWgpLMe0d
	ihgE4aIG1ksFOm/08oAdQQ3iVSIlAYTwvlgLsLfvWt8ylIy2B5w1tcKsLmzvHHBDpS5AvK14C2e
	f1jM+HEV+EMHWiyVlSJ3hkGqvZXQ=
X-Google-Smtp-Source: AGHT+IGVJxX/HbV5Wr6MzBf+fuxb+mIBQRp2TWTznpKDIx+yrOgDwhY5P4ZF8kRUebG9zXa+VAy7m3G1u1r+X9IB2Rg=
X-Received: by 2002:a05:6870:50d:b0:259:8b4e:e71a with SMTP id
 586e51a60fabf-26891ee1b6dmr17272867fac.46.1722949803427; Tue, 06 Aug 2024
 06:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
In-Reply-To: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 6 Aug 2024 09:09:50 -0400
Message-ID: <CAJSP0QVod5DA2hdNFrpN+HZcfm6Bg11teRmt5d+MBTB1wH4vZg@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] honor isolcpus configuration
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Kashyap Desai <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>, 
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
	Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Nilesh Javali <njavali@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Jonathan Corbet <corbet@lwn.net>, 
	Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, virtualization@lists.linux.dev, 
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 08:10, Daniel Wagner <dwagner@suse.de> wrote:
> The only stall I was able to trigger
> reliable was with qemu's PCI emulation. It looks like when a CPU is
> offlined, the PCI affinity is reprogrammed but qemu still routes IRQs to
> an offline CPU instead to newly programmed destination CPU. All worked
> fine on real hardware.

Hi Daniel,
Please file a QEMU bug report here (or just reply to this emails with
details on how to reproduce the issue and I'll file the issue on your
behalf):
https://gitlab.com/qemu-project/qemu/-/issues

We can also wait until your Linux patches have landed if that makes it
easier to reproduce the bug.

Thanks!

Stefan
