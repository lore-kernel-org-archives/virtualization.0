Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6C190485
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612731; cv=none; b=ZZldz+FY8PY+OqaDCy2GpWBYpnNwiVMGFflTaoN2Tdle9jTLDhFFdE4w/JN91ZBLpi0tu1Vv+ZqC/AZpQR5GhJubHBDdsKm+TayaEFBrdtscidkXnZ2XTaqPtGR5GgoSCc9e01CcuPN9hyiKrmCZxTs7DRr1Zgf0DGusrAx16m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612731; c=relaxed/simple;
	bh=Iy9qRE8Y5APVAleyDwqX1y3CEBdSQXgITL5U0jl/Imk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fNG3+mxk2w1f1Ico4MFWn/Ts1oanqRxUppnCzZq2fYtn4PJwaZZF+bnbA6s0zSvqPUEBz4kJH/w35q2yfQws7eI8XneDMSOuqfF3m6yB8GeD9V6/VujPOzV91M3l1jYmXLAoRJwHQolHkrXrUgkElu/ns/etdu1gAaYFvSj3ujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyWNDYRC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyWNDYRC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720612728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9cBzQHxEUSy/GLPpmbG8l/BFQoIEskC6HXCprR7AyeM=;
	b=KyWNDYRCryNdYyqGYyn0AHBPo1bwu1cSX1X2uGA44AOMJyhe46h8PH0PzsztVXhYmmL/Zy
	7Hw7+3wT3EkORZPxPVEzGS9Z3h0bCQ/X6SahxzRof284lWmAyFcG66e4/hh69t+5fRj00f
	B8r6O0qO2pUqsTiTjfvZMbRz8MBwdZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-B1V7kiepNMOuth2TXWWK5w-1; Wed, 10 Jul 2024 07:58:46 -0400
X-MC-Unique: B1V7kiepNMOuth2TXWWK5w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-426654e244dso24830395e9.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 04:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720612725; x=1721217525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cBzQHxEUSy/GLPpmbG8l/BFQoIEskC6HXCprR7AyeM=;
        b=Z2hz7Fy1Ix/lzYJTWOaAg6z7DuEIXgQwSA3hjQJfuPIGTga/V1l2oqee2ZISQe+vCG
         hBeTLZGtj2Xs1muup6ANAnpK0b/stEnOjabT4Yy4M9tVL0MFgTymYsdVH2yHwHEAQSDj
         Hq8Hu8tPiGzL3o/0hWvXAKola5qjWj4SJ/YbakPXCc1TTlp4ltxqdAL3v9SYt3nYu6Bl
         EBhbvIKrf8dl43XtoLaZMQnPcRqQ8y7hi3XfqfMJA8/1u+AmkvvqJu43I8sbIX9spQhw
         +E0HQmzEX6KhLFAdiLcOYzonufHxReon1Dl6fWi/DogeC8JjhUMB6MWwOKRPr/Sdx1wE
         huhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpcb/PvFVmZZdB883q9hZhWmkvF35pYsHeBLet957qa6A9Fa0Tiid1hKSTaVjI/6kcJImIm9z+ORXV0e0UMhl6fEykXmUm8UkeloLRJ4s=
X-Gm-Message-State: AOJu0Yz/6icvwTrUVg6rwq95/FdZyv7YtZ8vXBMF3IwI4ASY+a4DBnfs
	6QsjFyJ4UhEkwviB4Et1vSTUKxNhuo8iWMG0+aEKDas7QaDHb/rIa3UjDIFEWyX8R3gUsrHKoBa
	nJiiJd0odBgEi6F25yIhwzt0HDp/0gsEIK5DnBM10u9aF/72EzBunKOgKS+GWUzLL
X-Received: by 2002:a05:600c:6d8:b0:426:6389:94c4 with SMTP id 5b1f17b1804b1-426708f9d84mr33461585e9.37.1720612725588;
        Wed, 10 Jul 2024 04:58:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4UkulkcyxlC7Ah2eFUVKyIxI8uAFa3f4cBpDHjvh5FS46HcksyT7ueYgbU3NS63H4CRlFIg==
X-Received: by 2002:a05:600c:6d8:b0:426:6389:94c4 with SMTP id 5b1f17b1804b1-426708f9d84mr33461445e9.37.1720612725023;
        Wed, 10 Jul 2024 04:58:45 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0613sm5164442f8f.88.2024.07.10.04.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:58:44 -0700 (PDT)
Date: Wed, 10 Jul 2024 13:58:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <whgbeixcinqi2dmcfxxy4h7xfzjjx3kpsqsmjiffkkaijlxh6i@ozhumbrjse3c>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
 <PAXPR04MB845955C754284163737BECE788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <PAXPR04MB845955C754284163737BECE788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jul 10, 2024 at 11:34:05AM GMT, Peng Fan wrote:
>> Subject: Re: [PATCH] test/vsock: add install target
>>
>> On Wed, Jul 10, 2024 at 08:11:32AM GMT, Peng Fan wrote:
>> >> Subject: Re: [PATCH] test/vsock: add install target
>> >>
>> >> On Tue, Jul 09, 2024 at 09:50:51PM GMT, Peng Fan (OSS) wrote:
>> >> >From: Peng Fan <peng.fan@nxp.com>
>> >> >
>> >> >Add install target for vsock to make Yocto easy to install the
>> images.
>> >> >
>> >> >Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> >> >---
>> >> > tools/testing/vsock/Makefile | 12 ++++++++++++
>> >> > 1 file changed, 12 insertions(+)
>> >> >
>> >> >diff --git a/tools/testing/vsock/Makefile
>> >> >b/tools/testing/vsock/Makefile index a7f56a09ca9f..5c8442fa9460
>> >> 100644
>> >> >--- a/tools/testing/vsock/Makefile
>> >> >+++ b/tools/testing/vsock/Makefile
>> >> >@@ -8,8 +8,20 @@ vsock_perf: vsock_perf.o
>> >> msg_zerocopy_common.o
>> >> > vsock_uring_test: LDLIBS = -luring
>> >> > vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o
>> >> >msg_zerocopy_common.o
>> >> >
>> >> >+VSOCK_INSTALL_PATH ?= $(abspath .)
>> >> >+# Avoid changing the rest of the logic here and lib.mk.
>> >> >+INSTALL_PATH := $(VSOCK_INSTALL_PATH)
>> >> >+
>> >> > CFLAGS += -g -O2 -Werror -Wall -I. -I../../include
>> >> > -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow
>> >> > -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -
>> >> D_GNU_SOURCE
>> >> > .PHONY: all test clean
>> >> > clean:
>> >> > 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf
>> >> vsock_uring_test
>> >> > -include *.d
>> >> >+
>> >> >+install: all
>> >> >+	@# Ask all targets to install their files
>> >> >+	mkdir -p $(INSTALL_PATH)/vsock
>> >>
>> >> why using the "vsock" subdir?
>> >>
>> >> IIUC you were inspired by selftests/Makefile, but it installs under
>> >> $(INSTALL_PATH)/kselftest/ the scripts used by the main one
>> >> `run_kselftest.sh`, which is installed in $(INSTALL_PATH instead.
>> >> So in this case I would install everything in $(INSTALL_PATH).
>> >>
>> >> WDYT?
>> >
>> >I agree.
>> >
>> >>
>> >> >+	install -m 744 vsock_test $(INSTALL_PATH)/vsock/
>> >> >+	install -m 744 vsock_perf $(INSTALL_PATH)/vsock/
>> >> >+	install -m 744 vsock_diag_test $(INSTALL_PATH)/vsock/
>> >> >+	install -m 744 vsock_uring_test $(INSTALL_PATH)/vsock/
>> >>
>> >> Also from selftests/Makefile, what about using the ifdef instead of
>> >> using $(abspath .) as default place?
>> >>
>> >> I mean this:
>> >>
>> >> install: all
>> >> ifdef INSTALL_PATH
>> >>    ...
>> >> else
>> >> 	$(error Error: set INSTALL_PATH to use install) endif
>> >
>> >Is the following looks good to you?
>> >
>> ># Avoid conflict with INSTALL_PATH set by the main Makefile
>> >VSOCK_INSTALL_PATH ?= INSTALL_PATH := $(VSOCK_INSTALL_PATH)
>>
>> I'm not a super Makefile expert, but why do we need both
>> VSOCK_INSTALL_PATH and INSTALL_PATH?
>
>INSTALL_PATH is exported by kernel root directory makefile.
>So to user, we need to avoid export INSTALL_PATH here.
>So I just follow selftests/Makefile using KSFT_INSTALL_PATH

There is a comment there:

     # Avoid changing the rest of the logic here and lib.mk.

Added by commit 17eac6c2db8b2cdfe33d40229bdda2acd86b304a.

IIUC they re-used INSTALL_PATH, just to avoid too many changes in that 
file and in tools/testing/selftests/lib.mk

So, IMHO we should not care about it and only use VSOCK_INSTALL_PATH if 
you don't want to conflict with INSTALL_PATH.

Stefano

