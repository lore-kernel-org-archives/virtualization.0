Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7C9CA0FE1
	for <virtualization@archiver.kernel.org>; Fri,  1 Sep 2023 10:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F28683AE0;
	Fri,  1 Sep 2023 10:37:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F28683AE0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TyuNuh1m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 35Ki4XOqPEGw; Fri,  1 Sep 2023 10:37:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DAED783B10;
	Fri,  1 Sep 2023 10:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DAED783B10
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B80A4C0039;
	Fri,  1 Sep 2023 10:37:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6FB1C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 10:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A66DF41FD5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 10:37:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A66DF41FD5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=TyuNuh1m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QP2FrFUESuEh
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 10:37:04 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2393641FC4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 10:37:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2393641FC4
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4cbso2268213a12.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Sep 2023 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693564622; x=1694169422;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1ZtOmmUyUHsJfv4kZ2SxuGxZMcXZ7XGWuYUry0oDA0=;
 b=TyuNuh1mYKKPDNx66IypTrDgT90DcYAf7CMnHjN7+LYe82Yn1nr4CLOcyaJ6/alhgG
 M4YugCSjG0xaS4VpUDGktO46lX066RzthZEexHIeWI6bTa3zGoUGKSaoUOYymYoEZK0+
 3cQi15lokJm5smjCX376EUweQ+FZfzGhiCVL+uJvh5S4FAAwGfPwO8V8Q+7JAno+OuOq
 FapQSEU1ZCVuWIBQ21Xswi82aKKWm5igqPsjkmnO/WV8061z1XyLWlOiggEwblOrKQ5V
 ACLCth7VQTwnrUykIZOG9IOChzLuhCV+13bD0Fl5Z6+evwLVQbyURb9MazLBkqRPXy0C
 B1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693564622; x=1694169422;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H1ZtOmmUyUHsJfv4kZ2SxuGxZMcXZ7XGWuYUry0oDA0=;
 b=Gnmcmkf5WHldcvngBBg4RbHOhZxRHPZcBKRl5inIze0biNfgvu39f1MRl9sPpVRheV
 MtGQCbjjYA5Afk4mTofZpYkeZv8qLdtXdOqNJ1Q+rDSOjIys+rbcaO2o40rhqhzGfOxZ
 Xylp2sJUR9V/pqdYcxZmdi7VpFr6oaALUH3RKcuIjxc9D/bw80/XUwBQ3q/vajkuQwQy
 4us37PFi7wvgXnIajFjJFAuFtvKJOGFkr6n3YAdxkZfCiQjXPhgU+xzM4rRalZFddld+
 InIzQMaKywxJks43uWLAvs675f6TxEYhs2LgkT2ajkMjjiW/62/8OEixdiN/xLVdHNr5
 s5Iw==
X-Gm-Message-State: AOJu0Yxi9BNCirt4ae3uwRsFq+xRFJtpdq1EnM8U9Mw1BPFsqzaSC6OX
 CWt8yKXBt6MRmieXRWaX9t4xFw==
X-Google-Smtp-Source: AGHT+IFNlKnN7dJb+GuNlMKWA12egaLKprzsWCbsoyPebkYoiY/dym9gVNq/qV7dap3/RFa/GJqhKA==
X-Received: by 2002:aa7:ccc2:0:b0:522:57d9:6553 with SMTP id
 y2-20020aa7ccc2000000b0052257d96553mr1706209edt.1.1693564622005; 
 Fri, 01 Sep 2023 03:37:02 -0700 (PDT)
Received: from localhost (i53878940.versanet.de. [83.135.137.64])
 by smtp.gmail.com with ESMTPSA id
 m7-20020aa7c2c7000000b00523a43f9b1dsm1904700edp.22.2023.09.01.03.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 03:37:01 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 01 Sep 2023 12:37:00 +0200
Message-Id: <CV7IJY36ZXDZ.250Z3B8VKN4Y5@ablu-work>
Subject: Re: [BUG] virtio-fs: Corruption when running binaries from
 virtiofsd-backed fs
To: "Erik Schilling" <erik.schilling@linaro.org>,
 <virtualization@lists.linux-foundation.org>,
 <linux-fsdevel@vger.kernel.org>, <virtio-fs@redhat.com>
From: "Erik Schilling" <erik.schilling@linaro.org>
X-Mailer: aerc 0.15.2
References: <CV5Q388ZKSI3.2N5DT3BRV3RIM@fedora>
In-Reply-To: <CV5Q388ZKSI3.2N5DT3BRV3RIM@fedora>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>
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

On Wed Aug 30, 2023 at 10:20 AM CEST, Erik Schilling wrote:
> Hi all!
>
> Some days ago I posted to #virtiofs:matrix.org, describing that I am
> observing what looks like a corruption when executing programs from a
> virtiofs-based filesystem.
>
> Over the last few days I spent more time drilling into the problem.
> This is an attempt at summarizing my findings in order to see what other
> people think about this.
>
> When running binaries mounted from virtiofs they may either: fail with a
> segfault, fail with badaddr, get stuck or - sometimes - succeed.
>
> Environment:
>   Host: Fedora 38 running 6.4.11-200.fc38.x86_64
>   Guest: Yocto-based image: 6.4.9-yocto-standard, aarch64
>   virtiofsd: latest main + some debug prints [1]
>   QEMU: built from recent git [2]
>
> virtiofsd invocation:
>   RUST_LOG="debug" ./virtiofsd --seccomp=none --sandbox=none \
>     --socket-path "fs.sock0" --shared-dir $PWD/share-dir/ --cache=never
>
> QEMU invocation:
>   ~/projects/qemu/build/qemu-system-aarch64 -kernel Image -machine virt \
>     -cpu cortex-a57 \
>     -serial mon:stdio \
>     -device virtio-net-pci,netdev=net0 \
>     -netdev user,id=net0,hostfwd=tcp::2223-:22 \
>     -display none -m 2048 -smp 4 \
>     -object memory-backend-memfd,id=mem,size=2048M,share=on \
>     -numa node,memdev=mem \
>     -hda trs-overlay-guest.qcow2 \
>     -chardev socket,id=char0,path="fs.sock0" \
>     -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=/dev/root \
>     -append 'root=/dev/vda2 ro log_buf_len=8M'
>
> I figured that launching virtiofsd with --cache=always masks the
> problem. Therefore, I set --cache=never, but I think I observed no
> difference compared to the default setting (auto).
>
> Adding logging to virtiofsd and kernel _feeled_ like it made the problem
> harder to reproduce - leaving me with the impression that some race is
> happening on somewhere.
>
> Trying to rule out that virtiofsd is returning corrupted data, I added
> some logging and hashsum calculation hacks to it [1]. The hashes check
> out across multiple accesses and the order and kind of queued messages
> is exactly the same in both the error case and crash case. fio was also
> unable to find any errors with a naive job description [3].
>
> Next, I tried to capture info on the guest side. This became a bit
> tricky since the crashes became pretty rare once I followed a fixed
> pattern of starting log capture, running perf and trying to reproduce
> the problem. Ultimately, I had the most consistent results with
> immediately running a program twice:
>
>   /mnt/ld-linux-aarch64.so.1 /mnt/ls.coreutils /; \
>     /mnt/ld-linux-aarch64.so.1 /mnt/ls.coreutils /
>
>   (/mnt being the virtiofs mount)
>
> For collecting logs, I made a hack to the guest kernel in order to dump
> the page content after receiving the virtiofs responses [4]. Reproducing
> the problem with this, leaves me with logs that seem to suggest that
> virtiofsd is returning identical content, but the guest kernel seems to
> receive differing pages:
>
> good-kernel [5]:
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x312 nodeid 0x1 in.len 56 out.len 104
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 1 unique 0x314 nodeid 0x1 in.len 53 out.len 128
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x316 nodeid 0x29 in.len 56 out.len 104
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 14 unique 0x318 nodeid 0x29 in.len 48 out.len 16
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 15 unique 0x31a nodeid 0x29 in.len 80 out.len 832
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs: page: 000000006996d520
>   kernel: virtio_fs: to: 00000000de590c14
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   [...]
>
> bad-kernel [6]:
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x162 nodeid 0x1 in.len 56 out.len 104
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 1 unique 0x164 nodeid 0x1 in.len 53 out.len 128
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x166 nodeid 0x16 in.len 56 out.len 104
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 14 unique 0x168 nodeid 0x16 in.len 48 out.len 16
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 15 unique 0x16a nodeid 0x16 in.len 80 out.len 832
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs: page: 000000006ce9a559
>   kernel: virtio_fs: to: 000000007ae8b946
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   kernel: virtio_fs rsp:80 40 de c8 ff ff 00 00 cc 2b 62 ae ff ff 00 00  .@.......+b.....
>   kernel: virtio_fs rsp:02 4e de c8 ff ff 00 00 00 00 00 00 00 00 00 00  .N..............
>   [...]
>
> When looking at the corresponding output from virtiofsd, it claims to
> have returned identical data:
>
> good-virtiofsd [7]:
>   [DEBUG virtiofsd::server] Received request: opcode=Read (15), inode=41, unique=794, pid=481
>   [src/server.rs:618] r.read_obj().map_err(Error::DecodeMessage)? = ReadIn {
>       fh: 31,
>       offset: 0,
>       size: 832,
>       read_flags: 2,
>       lock_owner: 6838554705639967244,
>       flags: 131072,
>       padding: 0,
>   }
>   [src/file_traits.rs:161] hash = 2308490450751364994
>   [DEBUG virtiofsd::server] Replying OK, header: OutHeader { len: 848, error: 0, unique: 794 }
>
> bad-virtiofsd [8]:
>   [DEBUG virtiofsd::server] Received request: opcode=Read (15), inode=22, unique=362, pid=406
>   [src/server.rs:618] r.read_obj().map_err(Error::DecodeMessage)? = ReadIn {
>       fh: 12,
>       offset: 0,
>       size: 832,
>       read_flags: 2,
>       lock_owner: 6181120926258395554,
>       flags: 131072,
>       padding: 0,
>   }
>   [src/file_traits.rs:161] hash = 2308490450751364994
>   [DEBUG virtiofsd::server] Replying OK, header: OutHeader { len: 848, error: 0, unique: 362 }
>
> The "corruption" only seems to happen in this one page, all other pages
> are identical between runs (except that the bad run terminates earlier).
>
> What do the experts think here? To me it feels a bit like some kind of
> corruption is going on. Or am I misinterpreting things here?
>
> Which further analysis steps would you suggest?
>
>
> Further notes:
>
> After collecting the above results, I realized that running the guest
> with -smp 1 makes the problems a lot worse. So maybe that is a better
> choice when trying to reproduce it.
>
> Repo with my scripts is available at:
> https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/
>
> The scripts are just quick and dirty implementations and are not
> particulary portable.

Summary of my testing during the last few days:

Testing with KCSAN revealed a few cases that look like missing READ_ONCE
annotations (will send patches separately). But nothing of that was
related to the immediate problem. I tested instrument_read() and another
round of logging with a delay to virtio_fs_request_complete. It looks
like the buffer get corrupted before entering that function. KCSAN
or manual sleeps + prints did not show any corruption while in that
function.

KASAN did not report any issues.

Patching virtiofsd to do an additional copy and going through rust-vmm's
.copy_to() function did not change the behaviour.

I will mostly be off next week, will continue analysis afterwards. Happy
to hear about suggestions of other things to try :).

Good weekend,

- Erik


>
> - Erik
>
> [1] https://gitlab.com/ablu/virtiofsd/-/commit/18fd0c1849e15bc55fbdd6e1f169801b2b03da1f
> [2] https://gitlab.com/qemu-project/qemu/-/commit/50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4
> [3] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/-/blob/397a6310dea35973025e3d61f46090bf0c092762/share-dir/write-and-verify-mmap.fio
> [4] https://github.com/Ablu/linux/commit/3880b9f8affb01aeabb0a04fe76ad7701dc0bb95
> [5] Line 12923: https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/good-drop-bad-1.txt
> [6] Line 12923: https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/good-bad-1.txt
> [7] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/virtiofsd.txt#L2538-2549
> [8] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/virtiofsd.txt#L1052-1063

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
