Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4817B517
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602674; cv=none; b=JZWvks75EHj66ZkHkkCnjs/IWXZ286lxHklggeJQpn1hoKdiaWSop+Edjk3Qr6CcAHdY/jCJaPbXrfNmN6iDCXxJGGt9XxVTFbPJIQ9d18rfrEY6H9+cPtYKSPhz8UaYBvnt0j3xeudUO4PgRIN4XULQYbUuO6sWSviDCuqq6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602674; c=relaxed/simple;
	bh=sVcVGZKl2xwIdvcTfd9mefZDBHmsqt4J1Ded4unQblk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iFgxyqlwC35Gal4B700ysPzgK9Uv8R0RsnkZ5TztJAKM99N5jM7jPonvcB2eIpn6OqConxoDahteksIq8iYiPYKgmXyMATMbkyqD+g10gmhIIwb4g11S1RkjoTlgCJMojIbUlwoURPEbITQGM3YrrjIndD9DTGfMOgZkx78cNws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3Q4sren; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3Q4sren"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720602671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1cQDDUjmr5ak9+joDdULTaEfg0ceo+yAVZe0qbv7s9U=;
	b=d3Q4srenZ8pyavahp9KCEyPNfugmBkHaBXatSgukzfHpOhFcElY5kVV2gktHKd1gZikQyo
	G1nLM8IvrQbLUlyX8qwFKD3hrwnFTpET+Jkqvs/2BO29Hu3b7RE0PzJ1rnlKp/iL/siQQZ
	6q4vZ/Bd1sTxoF+tvv0Cp1s018RgRkk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-3coaUJUqO5C3Q103MUJb9A-1; Wed, 10 Jul 2024 05:11:09 -0400
X-MC-Unique: 3coaUJUqO5C3Q103MUJb9A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-58cdd86c091so5097179a12.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 02:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720602668; x=1721207468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cQDDUjmr5ak9+joDdULTaEfg0ceo+yAVZe0qbv7s9U=;
        b=F43Z1dXzahi1K4bqg4FowultGFv9zTOZGHtJ6+k9RrFztvMMiPKuXpfft6i0jKkiA6
         M4DHsbRd4N/e4c8G68+1PN1rxPRF5St4CCrnelcnmyonH6AvvFNhkAzZpydz0lTgVO7l
         5ZkE/VokoPUZoek4h1taPgFPHHHQVGIKq7qjvtJmKgkB7Krn8w5Z05oTfOac/bRY8zBE
         ogkhVWUQfcAEgdT26Z0GrJDSQSmQyORrl9EBNmMz5pLCgTSeJ398rcaqkeGcZz86dvZk
         C9xvSH82NF/tXG8fqbkM1TQl83s/e6jzcVK/C2MX+68iQqkv/UibczO7dy+EmRWfvbUK
         j46g==
X-Forwarded-Encrypted: i=1; AJvYcCVGsYyVl4D4Xe7buglDaSQpspnnrr1CKHon+Mgemsphf/nNXhh84a+V8hSSOhvxPI5fpYrlQI+/s1YJ4OX/jH64Qxr/+1nkQYhfCR9jk7g=
X-Gm-Message-State: AOJu0Yz04lyYbh7LACxO2Xjl5Xsb4bBl5P9hBPzjL2ButDN0FZqDjsEs
	JX/W3KiXNuFGU14DQ/n5jHb0MucJPRHATNRjjS0njgSX3LDvat2E2pP1pe4CAHuBuRwPFKf2h4m
	qZ1OlhHo1QP6ADu3Esbb15yHmf9ICDiarFkTc/5A5E4ya6IbGl8D4WgJP/JJQbnpc
X-Received: by 2002:a05:6402:2552:b0:58b:1df9:d3c1 with SMTP id 4fb4d7f45d1cf-594baf871aamr3923843a12.12.1720602668487;
        Wed, 10 Jul 2024 02:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMHjnifV3M27H8S9u+6/lvaJAWQKKtA/LzTGGDKIijdNacTcJVUCSPqn79d2thZJLRbSd3sQ==
X-Received: by 2002:a05:6402:2552:b0:58b:1df9:d3c1 with SMTP id 4fb4d7f45d1cf-594baf871aamr3923807a12.12.1720602667795;
        Wed, 10 Jul 2024 02:11:07 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bba548e8sm2009554a12.1.2024.07.10.02.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 02:11:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:11:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jul 10, 2024 at 08:11:32AM GMT, Peng Fan wrote:
>> Subject: Re: [PATCH] test/vsock: add install target
>>
>> On Tue, Jul 09, 2024 at 09:50:51PM GMT, Peng Fan (OSS) wrote:
>> >From: Peng Fan <peng.fan@nxp.com>
>> >
>> >Add install target for vsock to make Yocto easy to install the images.
>> >
>> >Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> >---
>> > tools/testing/vsock/Makefile | 12 ++++++++++++
>> > 1 file changed, 12 insertions(+)
>> >
>> >diff --git a/tools/testing/vsock/Makefile
>> >b/tools/testing/vsock/Makefile index a7f56a09ca9f..5c8442fa9460
>> 100644
>> >--- a/tools/testing/vsock/Makefile
>> >+++ b/tools/testing/vsock/Makefile
>> >@@ -8,8 +8,20 @@ vsock_perf: vsock_perf.o
>> msg_zerocopy_common.o
>> > vsock_uring_test: LDLIBS = -luring
>> > vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o
>> >msg_zerocopy_common.o
>> >
>> >+VSOCK_INSTALL_PATH ?= $(abspath .)
>> >+# Avoid changing the rest of the logic here and lib.mk.
>> >+INSTALL_PATH := $(VSOCK_INSTALL_PATH)
>> >+
>> > CFLAGS += -g -O2 -Werror -Wall -I. -I../../include
>> > -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow
>> > -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -
>> D_GNU_SOURCE
>> > .PHONY: all test clean
>> > clean:
>> > 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf
>> vsock_uring_test
>> > -include *.d
>> >+
>> >+install: all
>> >+	@# Ask all targets to install their files
>> >+	mkdir -p $(INSTALL_PATH)/vsock
>>
>> why using the "vsock" subdir?
>>
>> IIUC you were inspired by selftests/Makefile, but it installs under
>> $(INSTALL_PATH)/kselftest/ the scripts used by the main one
>> `run_kselftest.sh`, which is installed in $(INSTALL_PATH instead.
>> So in this case I would install everything in $(INSTALL_PATH).
>>
>> WDYT?
>
>I agree.
>
>>
>> >+	install -m 744 vsock_test $(INSTALL_PATH)/vsock/
>> >+	install -m 744 vsock_perf $(INSTALL_PATH)/vsock/
>> >+	install -m 744 vsock_diag_test $(INSTALL_PATH)/vsock/
>> >+	install -m 744 vsock_uring_test $(INSTALL_PATH)/vsock/
>>
>> Also from selftests/Makefile, what about using the ifdef instead of
>> using $(abspath .) as default place?
>>
>> I mean this:
>>
>> install: all
>> ifdef INSTALL_PATH
>>    ...
>> else
>> 	$(error Error: set INSTALL_PATH to use install) endif
>
>Is the following looks good to you?
>
># Avoid conflict with INSTALL_PATH set by the main Makefile
>VSOCK_INSTALL_PATH ?=
>INSTALL_PATH := $(VSOCK_INSTALL_PATH)

I'm not a super Makefile expert, but why do we need both 
VSOCK_INSTALL_PATH and INSTALL_PATH?

Stefano

>
>install: all
>ifdef INSTALL_PATH
>        mkdir -p $(INSTALL_PATH)
>        install -m 744 vsock_test $(INSTALL_PATH)
>        install -m 744 vsock_perf $(INSTALL_PATH)
>        install -m 744 vsock_diag_test $(INSTALL_PATH)
>        install -m 744 vsock_uring_test $(INSTALL_PATH)
>else
>        $(error Error: set INSTALL_PATH to use install)
>Endif
>
>Thanks,
>Peng.
>>
>> Thanks,
>> Stefano
>

