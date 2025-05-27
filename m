Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B1A2798F8
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361326; cv=none; b=HabzzYW+8QkuoBUaqH4Zs8jtyD+MPT53xVQDJWmIrN9v0t8vZeTT2XcuS7fyzvdB/8PUkEiuip7dLSMK+61eiSmGZan1P22BVPYNNOC5NcyGiIn+ruMVR8AudYQXJsCzIr8SF+xdrzG4/vk4tQ7oY4Dd13wguhQv3rOdLNNy3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361326; c=relaxed/simple;
	bh=IooNweYioThGUT8ZOiX1XzvjjfrhAJn0Sd6ftIx9E+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bSdFMNt9mVNVTd11/znpYRtrK1eo0yIo7hnJJx15p+oA0usHXw3W61HjFAVALNLPAytheoEqbvWEdXqjsKArIcCpgvVF84bz7yCr6YIGAv3PkwYkHnUKlpWYVeFpqtvJOXKq12jgT945X1ClavMupYlfYvRCeoXnGRVxlnHtKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHzBpFTy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHzBpFTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748361323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wb8/uzIi16fAJXtQ9hucGUiGMDmIuuatlVp8gYmB16c=;
	b=XHzBpFTyKxnzqZQi/36bCgTr3TeCadsZg76vjXGAtHXcEM/T5rLDUln4HC3i+wV9saf+XJ
	8WYtKXHvYPN0ECBWdsKmCukXFgvJuB+LcbEnPX/fZo7+fJ5Yf2qskoY9diOGTfwEKhau6+
	EyQjiGu3dlEi1XMrh+ln/PVSt8awv5w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-S39VYjZrP5OKK3TRugRq5A-1; Tue, 27 May 2025 11:55:20 -0400
X-MC-Unique: S39VYjZrP5OKK3TRugRq5A-1
X-Mimecast-MFC-AGG-ID: S39VYjZrP5OKK3TRugRq5A_1748361320
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad212166df4so266916666b.0
        for <virtualization@lists.linux.dev>; Tue, 27 May 2025 08:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748361320; x=1748966120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb8/uzIi16fAJXtQ9hucGUiGMDmIuuatlVp8gYmB16c=;
        b=YswTCg30LuCGLg3Fvw80nM5Po8rF1IJeWrdskppSm76jRGprSGUgRhDVmtEsEL/iSU
         lH4EfQJNNUbs6fn1xY9t4lR3fiL0fbVF8X9jlQCaE37c8sbzhoUGL5f0Hq2RrPDV3Dlq
         wXqcgU0YqwT95/Ti+O1XbX7n8fsc5IjqnWIL64ZYBXJzMBr+PzVEen38pm5T6wmDM6UY
         A//9GO4CDAZ3AG/WATrc/wb0AVDT/K/CJwz5xNZBPTlJc0bTZjvxgZGgzGkeSvud6tDh
         OydEqxNG7DqJYEKjwqOMfJs3Ksfd2boc9i5ImjCAk6p0bx9LjMJPmCpOcbiAAwCunYLF
         R/tA==
X-Forwarded-Encrypted: i=1; AJvYcCX/oladHvdBXjUZLWXqiMraj8xTWsHBjrURvwYJOdonLSuqhbvKZgQGGXpP7k25JLjA7lQ1EQTUz1685U1xzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZXjg4bGj8vwCOV8yqrLMKchzbIkrMFZn6OR3cGKYwPHmTFX1w
	CwBPA7tzr1HcKYtnHIlzTncBMhTZpVBtPP2JQBR4q+bfnGMa3VXXzUHftzCKk0/G+zuwghtKieT
	EP5bkOx5PsDEtGMCCAC1197yx7WvCp4zb3m0TWZt7+pjZb3AI040qT+ZfgYaJdQzhFu6/
X-Gm-Gg: ASbGncvfu169V+j/cFmzW3pU/KnhwIUfwU0zf/Qs1tOnYGkqnS18JW51YJHaLT5uD9I
	ivxmae6NXLV2TmDfV5H+1JpGdsvorrfNhVDV8Kp0dwh5DCkBnFJWyXmpV79sa66UQ2AtmF2fwax
	qN5Jh9NoRwZwGVS5VNmvSgwY+YMKTU/rfo3zt+DpxMd3fb78S7WpJYb6fMHPDEU9kZDA1c/q+ou
	i8AjEq64d1vARgZer7xqrE77WHqX0H/PBWyew9TBCDL2/1Ql4T9l9rQQGCtrICUySj1PuZfaZkV
	qV97clM0oAX524Dm9hceA6DbMtgwSUyz3kX2wQBnwIYWO0x4BiHbC2HdRXA3
X-Received: by 2002:a17:907:2ce4:b0:ad5:7234:e4a9 with SMTP id a640c23a62f3a-ad85b1300d0mr1255525866b.28.1748361319406;
        Tue, 27 May 2025 08:55:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENGDDVZ4asqZqtXTsQ2gw0NrLKQ1ZAzCAtVfopIjbSKMMjc6DGQBSFxH6caBgoySG+L0hShQ==
X-Received: by 2002:a17:907:2ce4:b0:ad5:7234:e4a9 with SMTP id a640c23a62f3a-ad85b1300d0mr1255520566b.28.1748361318653;
        Tue, 27 May 2025 08:55:18 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8977b36a9sm53081366b.70.2025.05.27.08.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:55:18 -0700 (PDT)
Date: Tue, 27 May 2025 17:55:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <tabqpll3r76jhx2ujayry25a7ujfsikm7tejv5sviayyojlmwz@amcchbc5xiqp>
References: <20250522-vsock-vmtest-v8-1-367619bef134@gmail.com>
 <ta2ub5v7txhobccgvpnwsz7cyzcnx6aw74cjlcviosjetuwfhh@7gdahptdpbnd>
 <aDXMhbqhhUAMe0Oz@devbig793.prn5.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aDXMhbqhhUAMe0Oz@devbig793.prn5.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wGtCPZZ7P_CI4_yVUJmn3YUvqsIKO9F2FqzyVhhw6WU_1748361320
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, May 27, 2025 at 07:30:29AM -0700, Bobby Eshleman wrote:
>On Mon, May 26, 2025 at 01:18:18PM +0200, Stefano Garzarella wrote:
>> On Thu, May 22, 2025 at 09:59:07PM -0700, Bobby Eshleman wrote:
>> > This commit introduces a new vmtest.sh runner for vsock.
>> >
>> > It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
>> > H2G, and loopback. The testing tools from tools/testing/vsock/ are
>> > reused. Currently, only vsock_test is used.
>> >
>> > VMCI and hyperv support is included in the config file to be built with
>> > the -b option, though not used in the tests.
>> >
>> > Only tested on x86.
>> >
>> > To run:
>> >
>> >  $ make -C tools/testing/selftests TARGETS=vsock
>> >  $ tools/testing/selftests/vsock/vmtest.sh
>> >
>> > or
>> >
>> >  $ make -C tools/testing/selftests TARGETS=vsock run_tests
>> >
>> > Example runs (after make -C tools/testing/selftests TARGETS=vsock):
>> >
>> > $ ./tools/testing/selftests/vsock/vmtest.sh
>> > 1..3
>> > ok 0 vm_server_host_client
>> > ok 1 vm_client_host_server
>> > ok 2 vm_loopback
>> > SUMMARY: PASS=3 SKIP=0 FAIL=0
>> > Log: /tmp/vsock_vmtest_m7DI.log
>> >
>> > $ ./tools/testing/selftests/vsock/vmtest.sh vm_loopback
>> > 1..1
>> > ok 0 vm_loopback
>> > SUMMARY: PASS=1 SKIP=0 FAIL=0
>> > Log: /tmp/vsock_vmtest_a1IO.log
>> >
>> > $ mkdir -p ~/scratch
>> > $ make -C tools/testing/selftests install TARGETS=vsock INSTALL_PATH=~/scratch
>> > [... omitted ...]
>> > $ cd ~/scratch
>> > $ ./run_kselftest.sh
>> > TAP version 13
>> > 1..1
>> > # timeout set to 300
>> > # selftests: vsock: vmtest.sh
>> > # 1..3
>> > # ok 0 vm_server_host_client
>> > # ok 1 vm_client_host_server
>> > # ok 2 vm_loopback
>> > # SUMMARY: PASS=3 SKIP=0 FAIL=0
>> > # Log: /tmp/vsock_vmtest_svEl.log
>> > ok 1 selftests: vsock: vmtest.sh
>> >
>> > Future work can include vsock_diag_test.
>> >
>> > Because vsock requires a VM to test anything other than loopback, this
>> > patch adds vmtest.sh as a kselftest itself. This is different than other
>> > systems that have a "vmtest.sh", where it is used as a utility script to
>> > spin up a VM to run the selftests as a guest (but isn't hooked into
>> > kselftest).
>> >
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>> > ---
>> > Changes in v8:
>> > - remove NIPA comment from commit msg
>> > - remove tap_* functions and TAP_PREFIX
>> > - add -b for building kernel
>> > - Link to v7: https://lore.kernel.org/r/20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com
>> >
>> > Changes in v7:
>> > - fix exit code bug when ran is kselftest: use cnt_total instead of KSFT_NUM_TESTS
>> > - updated commit message with updated output
>> > - updated commit message with commands for installing/running as
>> >  kselftest
>> > - Link to v6: https://lore.kernel.org/r/20250515-vsock-vmtest-v6-1-9af1cc023900@gmail.com
>> >
>> > Changes in v6:
>> > - add make cmd in commit message in vmtest.sh example (Stefano)
>> > - check nonzero size of QEMU_PIDFILE using -s conditional (Stefano)
>> > - display log file path after tests so it is easier to find amongst other random names
>> > - cleanup qemu pidfile if qemu is unable to remove it
>> > - make oops/warning failures more obvious with 'FAIL' prefix in log
>> >  (simply saying 'detected' wasn't clear enough to identify failing
>> >  condition)
>> > - Link to v5: https://lore.kernel.org/r/20250513-vsock-vmtest-v5-1-4e75c4a45ceb@gmail.com
>> >
>> > Changes in v5:
>> > - make log file a tmpfile (Paolo)
>> > - make sure both default and user defined QEMU gets handled by the dependency check (Paolo)
>> > - increased VM boot up timeout from 1m to 3m for slow hosts (Paolo)
>> > - rename vm_setup -> vm_start (Paolo)
>> > - derive wait_for_listener from selftests/net/net_helper.sh to removes ss usage
>> > - Remove unused 'unset IFS' line (Paolo)
>> > - leave space after variable declarations (Paolo)
>> > - make QEMU_PIDFILE a tmp file (Paolo)
>> > - make everything readonly that is only read (Paolo)
>> > - source ktap_helpers.sh for KSFT_PASS and friends (Paolo)
>> > - don't check for timeout util (Paolo)
>> > - add missing usage string for -q qemu arg
>> > - add tap prefix to SUMMARY line since it isn't part of TAP protocol
>> > - exit with the correct status code based on failure/pass counts
>> > - Link to v4: https://lore.kernel.org/r/20250507-vsock-vmtest-v4-1-6e2a97262cd6@gmail.com
>> >
>> > Changes in v4:
>> > - do not use special tab delimiter for help string parsing (Stefano + Paolo)
>> > - fix paths for when installing kselftest and running out-of-tree (Paolo)
>> > - change vng to using running kernel instead of compiled kernel (Paolo)
>> > - use multi-line string for QEMU_OPTS (Stefano)
>> > - change timeout to 300s (Paolo)
>> > - skip if tools are not found and use kselftests status codes (Paolo)
>> > - remove build from vmtest.sh (Paolo)
>> > - change 2222 -> SSH_HOST_PORT (Stefano)
>> > - add tap-format output
>> > - add vmtest.log to gitignore
>> > - check for vsock_test binary and remind user to build it if missing
>> > - create a proper build in makefile
>> > - style fixes
>> > - add ssh, timeout, and pkill to dependency check, just in case
>> > - fix numerical comparison in conditionals
>> > - check qemu pidfile exists before proceeding (avoid wasting time waiting for ssh)
>> > - fix tracking of pass/fail bug
>> > - fix stderr redirection bug
>> > - Link to v3: https://lore.kernel.org/r/20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com
>> >
>> > Changes in v3:
>> > - use common conditional syntax for checking variables
>> > - use return value instead of global rc
>> > - fix typo TEST_HOST_LISTENER_PORT -> TEST_HOST_PORT_LISTENER
>> > - use SIGTERM instead of SIGKILL on cleanup
>> > - use peer-cid=1 for loopback
>> > - change sleep delay times into globals
>> > - fix test_vm_loopback logging
>> > - add test selection in arguments
>> > - make QEMU an argument
>> > - check that vng binary is on path
>> > - use QEMU variable
>> > - change <tab><backslash> to <space><backslash>
>> > - fix hardcoded file paths
>> > - add comment in commit msg about script that vmtest.sh was based off of
>> > - Add tools/testing/selftest/vsock/Makefile for kselftest
>> > - Link to v2: https://lore.kernel.org/r/20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com
>> >
>> > Changes in v2:
>> > - add kernel oops and warnings checker
>> > - change testname variable to use FUNCNAME
>> > - fix spacing in test_vm_server_host_client
>> > - add -s skip build option to vmtest.sh
>> > - add test_vm_loopback
>> > - pass port to vm_wait_for_listener
>> > - fix indentation in vmtest.sh
>> > - add vmci and hyperv to config
>> > - changed whitespace from tabs to spaces in help string
>> > - Link to v1: https://lore.kernel.org/r/20250410-vsock-vmtest-v1-1-f35a81dab98c@gmail.com
>> > ---
>> > MAINTAINERS                              |   1 +
>> > tools/testing/selftests/vsock/.gitignore |   2 +
>> > tools/testing/selftests/vsock/Makefile   |  16 ++
>> > tools/testing/selftests/vsock/config     | 114 ++++++++
>> > tools/testing/selftests/vsock/settings   |   1 +
>> > tools/testing/selftests/vsock/vmtest.sh  | 460 +++++++++++++++++++++++++++++++
>> > 6 files changed, 594 insertions(+)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 657a67f9031ef7798c19ac63e6383d4cb18a9e1f..3fbdd7bbfce7196a3cc7db70203317c6bd0e51fd 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -25751,6 +25751,7 @@ F:	include/uapi/linux/vm_sockets.h
>> > F:	include/uapi/linux/vm_sockets_diag.h
>> > F:	include/uapi/linux/vsockmon.h
>> > F:	net/vmw_vsock/
>> > +F:	tools/testing/selftests/vsock/
>> > F:	tools/testing/vsock/
>> >
>> > VMALLOC
>> > diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
>> > new file mode 100644
>> > index 0000000000000000000000000000000000000000..9c5bf379480f829a14713d5f5dc7d525bc272e84
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/vsock/.gitignore
>> > @@ -0,0 +1,2 @@
>> > +vmtest.log
>> > +vsock_test
>> > diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
>> > new file mode 100644
>> > index 0000000000000000000000000000000000000000..7ab4970e5e8a019be33f96a36f95c00573d7bfcf
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/vsock/Makefile
>> > @@ -0,0 +1,16 @@
>> > +# SPDX-License-Identifier: GPL-2.0
>> > +
>> > +CURDIR := $(abspath .)
>> > +TOOLSDIR := $(abspath ../../..)
>> > +
>> > +$(OUTPUT)/vsock_test: $(TOOLSDIR)/testing/vsock/vsock_test
>> > +	install -m 755 $< $@
>> > +
>> > +$(TOOLSDIR)/testing/vsock/vsock_test:
>> > +	$(MAKE) -C $(TOOLSDIR)/testing/vsock vsock_test
>> > +
>> > +TEST_PROGS += vmtest.sh
>> > +TEST_GEN_FILES := vsock_test
>> > +
>> > +include ../lib.mk
>> > +
>>
>> I had modified the tests, but I noticed that they were not copied,
>> in fact we have no dependencies on the test sources.
>>
>> This may not be a problem in the selftest environment, but locally I
>> think it is.
>>
>> We can either use .PHONY and call `$(MAKE) -C ...` each time, or do
>> something like this (which solved my problem):
>>
>> diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
>> index 7ab4970e5e8a..d1bb1f63a9d1 100644
>> --- a/tools/testing/selftests/vsock/Makefile
>> +++ b/tools/testing/selftests/vsock/Makefile
>> @@ -3,11 +3,14 @@
>>  CURDIR := $(abspath .)
>>  TOOLSDIR := $(abspath ../../..)
>> -$(OUTPUT)/vsock_test: $(TOOLSDIR)/testing/vsock/vsock_test
>> +VSOCK_TEST_DIR := $(TOOLSDIR)/testing/vsock
>> +VSOCK_TEST_SRCS := $(wildcard $(VSOCK_TEST_DIR)/*.c $(VSOCK_TEST_DIR)/*.h)
>> +
>> +$(OUTPUT)/vsock_test: $(VSOCK_TEST_DIR)/vsock_test
>>         install -m 755 $< $@
>> -$(TOOLSDIR)/testing/vsock/vsock_test:
>> -       $(MAKE) -C $(TOOLSDIR)/testing/vsock vsock_test
>> +$(VSOCK_TEST_DIR)/vsock_test: $(VSOCK_TEST_SRCS)
>> +       $(MAKE) -C $(VSOCK_TEST_DIR) vsock_test
>>  TEST_PROGS += vmtest.sh
>>  TEST_GEN_FILES := vsock_test
>>
>>
>
>Makes sense!
>
>> > +
>> > +# virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
>> > +# control port forwarded for vsock_test.  Because virtme-ng doesn't support
>> > +# adding an additional port to forward to the device created from "--ssh" and
>> > +# virtme-init mistakenly sets identical IPs to the ssh device and additional
>> > +# devices, we instead opt out of using --ssh, add the device manually, and also
>> > +# add the kernel cmdline options that virtme-init uses to setup the interface.
>>
>> This version of the script doesn't work for me, the VM starts, but I
>> can't connect in ssh. After spending some time debugging, I saw that
>> `sshd` was not being launched inside the VM.
>>
>> I think it depends on the version of vng (maybe recently updated on my
>> Fedora 41); here I have:
>> $ vng --version
>> virtme-ng 1.36
>>
>> Playing around with `vng`, I found that it now also supports ssh on
>> vsock (I think it is now default). By forcing it to use tcp
>> (`vng ... --ssh --ssh-tcp`), it adds another parameter to my cmdline:
>> `virtme_ssh_channel=tcp`.
>>
>> And indeed this change fixed my issues:
>> --- a/tools/testing/selftests/vsock/vmtest.sh
>> +++ b/tools/testing/selftests/vsock/vmtest.sh
>> @@ -39,7 +39,7 @@ readonly QEMU_OPTS="\
>>          -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
>>          --pidfile ${QEMU_PIDFILE} \
>>  "
>> -readonly KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_user=$USER"
>> +readonly KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER"
>>  readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
>>  readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
>>  readonly TEST_DESCS=(
>>
>> That said, I'm concerned about the weakness of assuming the cmdlines
>> supported by vng (which do not seem stable to me at this point).
>>
>> Should we check the version of vng and at least print a warning to say
>> that this script is not tested on that version?
>>
>> Thanks,
>> Stefano
>>
>
>I'm also not a big fan of assuming cmdlines and I think adding the
>version warning sounds good. I have been using 1.33. One thought I'm
>having is that I should probably submit a PR to vng to either fix the
>multi-NIC setup in virtme-ng or add a hostfwd option... then restrict
>our assumptions here to only prior versions.

Yes, that would be great, but anyway for now I would say let's go with 
this since we're supposed to support these current versions I guess, and 
this hack at the end I think is doable.

BTW, thanks again for this useful work!
Stefano

