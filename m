Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128984052
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596893; cv=none; b=NefjnrHm3KSXtfyg/2DHbC6au9f2TcE7XPHZ/crwT9Yug7ICYhHDX3EAP1ymXpNTtMTWi3Gl2PPu1NQKTU7V7j7bjOCX6M2Mni42zFYsdME3Tk+qc3g4a72xY4cJ2uuZ4iFJ9abxY7St5LyJi1aPHO07BI3isqmgwTbkhODwvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596893; c=relaxed/simple;
	bh=NfrfV5Vy+VM7vSghradxFkPpeufS31T/y1I2gyDTmrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gvn6Q0uoci1yOUkGRNbDLPNc8n0U74mKnCsGcK3u4JLT4JdVcC4cxsBcD+pJ7hIkR8Wg5KpX0cBocXtr7e3gotS9Lc8z9X+NyE3UUmOB6cuD7yOOvTa7HZPD4q1h2wJx/5vIpD6jTBk4DU4EiL2sQLMZeuCiBuFQ72fq8noH3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKia5BPA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKia5BPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720596890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D2M3DvwDrSJcyOfWVtdeker8I2MWaBFXWRzk+di5ddk=;
	b=EKia5BPAfD8DeU4s52TsWwZa0JHiHIlZJf+muVIv/RuBA7tp55kaGycrve82ac0CcLS8yp
	G36mMU04XdsPaawcSs0T2pRaTOVpe9A60PDzxecc/CP3KMvpvgmLthH4PopcOxWGxI2nNb
	GAz4YIJZJi90/1bbT3/HFh/beuUdc0E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-FJVUwHPeMe-_CwrlwJnOGw-1; Wed, 10 Jul 2024 03:34:45 -0400
X-MC-Unique: FJVUwHPeMe-_CwrlwJnOGw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-58d6fdee657so5378470a12.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 00:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720596885; x=1721201685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2M3DvwDrSJcyOfWVtdeker8I2MWaBFXWRzk+di5ddk=;
        b=X3uv9MacdJ3Y4cTWqvhw2iGcSLxdtvKTrLdc9HEGf56vHvxBboasH4mk8E0G/bPYUz
         /Ho0rC4NTKloA4AFGHIvuX/JUPTlHNIyODHtrZiS0Lz8v3kXuXifvTUgTr67ayHfq24C
         27o+NmlgM8rXaHoV5kmbuNCvbua8zRLp587Q9RGxRNrtx9B+MrWP/cu1/2SjpqPwKMkR
         wy7Zf/qEmLvSAjyZGYp2FXlYb+Y38zzZatExB++2Ma4dn6IiNUI5Pee/JE5vNz5w4/E8
         WOLJkskJH1yukX3/fuzfQ1ILAKRIs3PiF8zWGcJ9EG4CwhYSyybSmo7WWMu1f20+vMcc
         2FqA==
X-Gm-Message-State: AOJu0YxxiXixUn8ITWYZCuxTaJwNaBufH+dWVP/u3uomWCmi3v3p7kkO
	H99qN5m+h+IMNXrWBuGy0eHLrQt0W0dN9LudXS81gCKVf4w9MK280i6+guD95Q2QpKJJBISF2xq
	Hzu38nQbRw0qeIq0YXFIPLmm9T0EQTt+irYro/4OMYU+wyuV7vHD83hbpIGobH3F6
X-Received: by 2002:a17:906:d925:b0:a77:c364:c4f2 with SMTP id a640c23a62f3a-a780b883457mr263385466b.52.1720596884832;
        Wed, 10 Jul 2024 00:34:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdCK3sPHoX5ymCLdtTzOFCG6cqJ6FCKNdOKjpgNsX4y+qO5d6Ij6ITF6psUTIa6WmxdNi7Pw==
X-Received: by 2002:a17:906:d925:b0:a77:c364:c4f2 with SMTP id a640c23a62f3a-a780b883457mr263384166b.52.1720596884237;
        Wed, 10 Jul 2024 00:34:44 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc520sm136516266b.51.2024.07.10.00.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:34:43 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:34:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 09, 2024 at 09:50:51PM GMT, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>Add install target for vsock to make Yocto easy to install the images.
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
> tools/testing/vsock/Makefile | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index a7f56a09ca9f..5c8442fa9460 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -8,8 +8,20 @@ vsock_perf: vsock_perf.o msg_zerocopy_common.o
> vsock_uring_test: LDLIBS = -luring
> vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
>
>+VSOCK_INSTALL_PATH ?= $(abspath .)
>+# Avoid changing the rest of the logic here and lib.mk.
>+INSTALL_PATH := $(VSOCK_INSTALL_PATH)
>+
> CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
> .PHONY: all test clean
> clean:
> 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf vsock_uring_test
> -include *.d
>+
>+install: all
>+	@# Ask all targets to install their files
>+	mkdir -p $(INSTALL_PATH)/vsock

why using the "vsock" subdir?

IIUC you were inspired by selftests/Makefile, but it installs under 
$(INSTALL_PATH)/kselftest/ the scripts used by the main one 
`run_kselftest.sh`, which is installed in $(INSTALL_PATH instead.
So in this case I would install everything in $(INSTALL_PATH).

WDYT?

>+	install -m 744 vsock_test $(INSTALL_PATH)/vsock/
>+	install -m 744 vsock_perf $(INSTALL_PATH)/vsock/
>+	install -m 744 vsock_diag_test $(INSTALL_PATH)/vsock/
>+	install -m 744 vsock_uring_test $(INSTALL_PATH)/vsock/

Also from selftests/Makefile, what about using the ifdef instead of 
using $(abspath .) as default place?

I mean this:

install: all
ifdef INSTALL_PATH
   ...
else
	$(error Error: set INSTALL_PATH to use install)
endif

Thanks,
Stefano

