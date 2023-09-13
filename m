Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3568DEEB596
	for <virtualization@archiver.kernel.org>; Wed, 13 Sep 2023 06:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC4CC404C1;
	Wed, 13 Sep 2023 06:18:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC4CC404C1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Dk46d7Js
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kCsuEsIWpbJU; Wed, 13 Sep 2023 06:18:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A3F0A40156;
	Wed, 13 Sep 2023 06:18:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3F0A40156
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CBB7C0071;
	Wed, 13 Sep 2023 06:18:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 463DAC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 06:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13F4D60C02
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 06:18:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13F4D60C02
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Dk46d7Js
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6fu-ptC5ZNds
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 06:18:41 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4393D60B3F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 06:18:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4393D60B3F
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99357737980so799440466b.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 23:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694585919; x=1695190719;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:references:message-id:from:to:cc:subject:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAf/16hy8GPnKFTGuy3hCSRkInFeqAXMGniiY3Op/qM=;
 b=Dk46d7JsqbawJGFGuDiIYx0Jzo2xx6+jWdSdNhTyRmN/LpbaHSJeB6DV2rPgE6uoZQ
 srHTk6hE244XdbqstMQViKDHXvGJfilcXbzl5cMe7uHn0tFgxUnV1bngiGg/fFNfYR4y
 7iCOR4TpT/rVLESu99UwZkGY3Y7SBqKa5p2wPjwIh1B5/9176BefDtKtQFVVSS9GUx44
 p5nJvOWulaPNR6tPJHHgy1MA/s5quvAZJaZf+eQxj/h3j1qLrvdDHWDKCgenCnKxsG0Z
 tUwB46fAbbX4layeuRCxmOjU7WX7epV0SNMP5cTFzLYKbckaNCOJz4FB36naH4HGJ076
 Lhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694585919; x=1695190719;
 h=in-reply-to:references:message-id:from:to:cc:subject:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iAf/16hy8GPnKFTGuy3hCSRkInFeqAXMGniiY3Op/qM=;
 b=xTvRgSi+9z3R06TPcf3atQr9nApqDmx6PmVN+kaVq6g0FqGaMVfoQoxVP8ADKh6j1+
 xVjHCO1qmyn6ApmTeHEZCYfnqsxohpVjpM8KtWnoFauHjLckJIa4LEonFiaIbb3Qp0CV
 V3lbyK2Fp8PwdDAHoyoB7QDedVJ9A750dJz5qPe/6JUuhlR6Nbef8dcE2zo4R4a36Vhh
 Zz7uGWSQtF3seTl8tpR5lI2UM0euwuuqXAZJBD880aUoJdkgASlAM5kJYcIeK3L1wxcF
 wFo52pjl6v0SZLPtC3NMAAnsR6uOy9mbXNyaIRslmu6nHWxsTmKJo3FMvsSc4RNFyCkz
 FheA==
X-Gm-Message-State: AOJu0YylVKCefCW2D7KYUg3LK60takQJJbqchpfqPH21qLQbru4V6UwO
 XqHiY3qk4t8sk4CIsz6KmW19dw==
X-Google-Smtp-Source: AGHT+IEpQ6UxFd2NYZE8e6Or8dEuAHXIYe1z39yFCE2jq9fpGtTVMioEY8d/I4euaiZn+CEUXnyA4A==
X-Received: by 2002:a17:906:de:b0:9a2:16e2:353 with SMTP id
 30-20020a17090600de00b009a216e20353mr1268546eji.6.1694585919242; 
 Tue, 12 Sep 2023 23:18:39 -0700 (PDT)
Received: from localhost (i5C74380B.versanet.de. [92.116.56.11])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a170906490900b00992f2befcbcsm7828614ejq.180.2023.09.12.23.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 23:18:38 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 13 Sep 2023 08:18:38 +0200
Subject: Re: [BUG] virtio-fs: Corruption when running binaries from
 virtiofsd-backed fs
To: "Erik Schilling" <erik.schilling@linaro.org>,
 <virtualization@lists.linux-foundation.org>,
 <linux-fsdevel@vger.kernel.org>, <virtio-fs@redhat.com>
From: "Erik Schilling" <erik.schilling@linaro.org>
Message-Id: <CVHKGP2HRKVG.TEIWT3U6ZVTX@ablu-work>
X-Mailer: aerc 0.15.2
References: <CV5Q388ZKSI3.2N5DT3BRV3RIM@fedora>
 <CV7IJY36ZXDZ.250Z3B8VKN4Y5@ablu-work>
In-Reply-To: <CV7IJY36ZXDZ.250Z3B8VKN4Y5@ablu-work>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri Sep 1, 2023 at 12:37 PM CEST, Erik Schilling wrote:
> On Wed Aug 30, 2023 at 10:20 AM CEST, Erik Schilling wrote:
> > Hi all!
> >
> > Some days ago I posted to #virtiofs:matrix.org, describing that I am
> > observing what looks like a corruption when executing programs from a
> > virtiofs-based filesystem.
> >
> > Over the last few days I spent more time drilling into the problem.
> > This is an attempt at summarizing my findings in order to see what other
> > people think about this.
> >
> > When running binaries mounted from virtiofs they may either: fail with a
> > segfault, fail with badaddr, get stuck or - sometimes - succeed.
> >
> > Environment:
> >   Host: Fedora 38 running 6.4.11-200.fc38.x86_64
> >   Guest: Yocto-based image: 6.4.9-yocto-standard, aarch64
> >   virtiofsd: latest main + some debug prints [1]
> >   QEMU: built from recent git [2]
> >
> > virtiofsd invocation:
> >   RUST_LOG="debug" ./virtiofsd --seccomp=none --sandbox=none \
> >     --socket-path "fs.sock0" --shared-dir $PWD/share-dir/ --cache=never
> >
> > QEMU invocation:
> >   ~/projects/qemu/build/qemu-system-aarch64 -kernel Image -machine virt \
> >     -cpu cortex-a57 \
> >     -serial mon:stdio \
> >     -device virtio-net-pci,netdev=net0 \
> >     -netdev user,id=net0,hostfwd=tcp::2223-:22 \
> >     -display none -m 2048 -smp 4 \
> >     -object memory-backend-memfd,id=mem,size=2048M,share=on \
> >     -numa node,memdev=mem \
> >     -hda trs-overlay-guest.qcow2 \
> >     -chardev socket,id=char0,path="fs.sock0" \
> >     -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=/dev/root \
> >     -append 'root=/dev/vda2 ro log_buf_len=8M'
> >
> > I figured that launching virtiofsd with --cache=always masks the
> > problem. Therefore, I set --cache=never, but I think I observed no
> > difference compared to the default setting (auto).
> >
> > Adding logging to virtiofsd and kernel _feeled_ like it made the problem
> > harder to reproduce - leaving me with the impression that some race is
> > happening on somewhere.
> >
> > Trying to rule out that virtiofsd is returning corrupted data, I added
> > some logging and hashsum calculation hacks to it [1]. The hashes check
> > out across multiple accesses and the order and kind of queued messages
> > is exactly the same in both the error case and crash case. fio was also
> > unable to find any errors with a naive job description [3].
> >
> > Next, I tried to capture info on the guest side. This became a bit
> > tricky since the crashes became pretty rare once I followed a fixed
> > pattern of starting log capture, running perf and trying to reproduce
> > the problem. Ultimately, I had the most consistent results with
> > immediately running a program twice:
> >
> >   /mnt/ld-linux-aarch64.so.1 /mnt/ls.coreutils /; \
> >     /mnt/ld-linux-aarch64.so.1 /mnt/ls.coreutils /
> >
> >   (/mnt being the virtiofs mount)
> >
> > For collecting logs, I made a hack to the guest kernel in order to dump
> > the page content after receiving the virtiofs responses [4]. Reproducing
> > the problem with this, leaves me with logs that seem to suggest that
> > virtiofsd is returning identical content, but the guest kernel seems to
> > receive differing pages:
> >
> > good-kernel [5]:
> >   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x312 nodeid 0x1 in.len 56 out.len 104
> >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
> >   kernel: virtio_fs_wake_pending_and_unlock: opcode 1 unique 0x314 nodeid 0x1 in.len 53 out.len 128
> >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
> >   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x316 nodeid 0x29 in.len 56 out.len 104
> >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
> >   kernel: virtio_fs_wake_pending_and_unlock: opcode 14 unique 0x318 nodeid 0x29 in.len 48 out.len 16
> >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
> >   kernel: virtio_fs_wake_pending_and_unlock: opcode 15 unique 0x31a nodeid 0x29 in.len 80 out.len 832
> >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
> >   kernel: virtio_fs: page: 000000006996d520
> >   kernel: virtio_fs: to: 00000000de590c14
> >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   [...]
> >
> > bad-kernel [6]:
> >   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x162 nodeid 0x1 in.len 56 out.len 104
> >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
> >   kernel: virtio_fs_wake_pending_and_unlock: opcode 1 unique 0x164 nodeid 0x1 in.len 53 out.len 128
> >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
> >   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x166 nodeid 0x16 in.len 56 out.len 104
> >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
> >   kernel: virtio_fs_wake_pending_and_unlock: opcode 14 unique 0x168 nodeid 0x16 in.len 48 out.len 16
> >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
> >   kernel: virtio_fs_wake_pending_and_unlock: opcode 15 unique 0x16a nodeid 0x16 in.len 80 out.len 832
> >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
> >   kernel: virtio_fs: page: 000000006ce9a559
> >   kernel: virtio_fs: to: 000000007ae8b946
> >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   kernel: virtio_fs rsp:80 40 de c8 ff ff 00 00 cc 2b 62 ae ff ff 00 00  .@.......+b.....
> >   kernel: virtio_fs rsp:02 4e de c8 ff ff 00 00 00 00 00 00 00 00 00 00  .N..............
> >   [...]
> >
> > When looking at the corresponding output from virtiofsd, it claims to
> > have returned identical data:
> >
> > good-virtiofsd [7]:
> >   [DEBUG virtiofsd::server] Received request: opcode=Read (15), inode=41, unique=794, pid=481
> >   [src/server.rs:618] r.read_obj().map_err(Error::DecodeMessage)? = ReadIn {
> >       fh: 31,
> >       offset: 0,
> >       size: 832,
> >       read_flags: 2,
> >       lock_owner: 6838554705639967244,
> >       flags: 131072,
> >       padding: 0,
> >   }
> >   [src/file_traits.rs:161] hash = 2308490450751364994
> >   [DEBUG virtiofsd::server] Replying OK, header: OutHeader { len: 848, error: 0, unique: 794 }
> >
> > bad-virtiofsd [8]:
> >   [DEBUG virtiofsd::server] Received request: opcode=Read (15), inode=22, unique=362, pid=406
> >   [src/server.rs:618] r.read_obj().map_err(Error::DecodeMessage)? = ReadIn {
> >       fh: 12,
> >       offset: 0,
> >       size: 832,
> >       read_flags: 2,
> >       lock_owner: 6181120926258395554,
> >       flags: 131072,
> >       padding: 0,
> >   }
> >   [src/file_traits.rs:161] hash = 2308490450751364994
> >   [DEBUG virtiofsd::server] Replying OK, header: OutHeader { len: 848, error: 0, unique: 362 }
> >
> > The "corruption" only seems to happen in this one page, all other pages
> > are identical between runs (except that the bad run terminates earlier).
> >
> > What do the experts think here? To me it feels a bit like some kind of
> > corruption is going on. Or am I misinterpreting things here?
> >
> > Which further analysis steps would you suggest?
> >
> >
> > Further notes:
> >
> > After collecting the above results, I realized that running the guest
> > with -smp 1 makes the problems a lot worse. So maybe that is a better
> > choice when trying to reproduce it.
> >
> > Repo with my scripts is available at:
> > https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/
> >
> > The scripts are just quick and dirty implementations and are not
> > particulary portable.
>
> Summary of my testing during the last few days:
>
> Testing with KCSAN revealed a few cases that look like missing READ_ONCE
> annotations (will send patches separately). But nothing of that was
> related to the immediate problem. I tested instrument_read() and another
> round of logging with a delay to virtio_fs_request_complete. It looks
> like the buffer get corrupted before entering that function. KCSAN
> or manual sleeps + prints did not show any corruption while in that
> function.
>
> KASAN did not report any issues.
>
> Patching virtiofsd to do an additional copy and going through rust-vmm's
> .copy_to() function did not change the behaviour.
>
> I will mostly be off next week, will continue analysis afterwards. Happy
> to hear about suggestions of other things to try :).

Back from a week of vacation...

Summary of what was discussed on #virtiofs:matrix.org:

The issue only seems to happen in QEMU TCG scenarios (I tested aarch64
and x86_64 on x86_64, wizzard on Matrix tested arm32).

CCing qemu-devel. Maybe someone has some hints on where to focus the
debugging efforts?

I am trying to build a complex monster script of tracing the relevant
addresses in order to figure out whether the guest or host does the
writes. But I am happy to hear about more clever ideas :).

- Erik

>
> Good weekend,
>
> - Erik
>
>
> >
> > - Erik
> >
> > [1] https://gitlab.com/ablu/virtiofsd/-/commit/18fd0c1849e15bc55fbdd6e1f169801b2b03da1f
> > [2] https://gitlab.com/qemu-project/qemu/-/commit/50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4
> > [3] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/-/blob/397a6310dea35973025e3d61f46090bf0c092762/share-dir/write-and-verify-mmap.fio
> > [4] https://github.com/Ablu/linux/commit/3880b9f8affb01aeabb0a04fe76ad7701dc0bb95
> > [5] Line 12923: https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/good-drop-bad-1.txt
> > [6] Line 12923: https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/good-bad-1.txt
> > [7] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/virtiofsd.txt#L2538-2549
> > [8] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/virtiofsd.txt#L1052-1063

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
