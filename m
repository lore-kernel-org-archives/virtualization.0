Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA6299A84
	for <virtualization@lists.linux.dev>; Fri,  6 Feb 2026 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395044; cv=none; b=jASCin3pImXje676hVRStf1JVEnvIXsV+UcF67Z/Y/PctK+pguofnA3bTUEP7cW12cB7UpLbPbnLyGYgPtEZpy+ZSr3nhYTDj029+vzIFalzT2DRcAlsRTCTAY1GNXHV4Y0rAp8BZyALDKU4uOq+0cInweR6k9J8xn4+/EBlE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395044; c=relaxed/simple;
	bh=eoZQP6Pw5nf5m7F2meipgxmbmle6wXNPF6+XfM6ec8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HrNPPnvXXxVpVuAziF2f2mXpcwYlRq7ZBzlTX/h2Ur21SxDr8ZUOB/RINAJdMbk6mX3HqeugJMTyQDUMiykvscW8ZkyEjWSpC5TMaAXelglFLnx5EIe6vkrW2jsJz11InPND54v64e7ieF4dazx8aAqSacDHJLfuwcyxl57jeRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ti0RAcJ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ti0RAcJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770395043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SixDUkQfbGW/CySUSPTvhYKmVPlXZV2VssvRFKjxUY=;
	b=Ti0RAcJ5TsEkA1BM/ipd5icJEamcrWNSZ0aRmJ74p5SsQE24hUTsYFwMFmhtEyAxh25XYa
	A45a0irKTpXemA2mcV/a7uxD5dDAgNz3PUNY7tIeg+hEiF7Nm7ygMDEBLRNZS3PV5kNczU
	rQx7C5CR7z1LNpMyTURSPqbkbYx4zRI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-BpJlmL63Pd27yovmrmjSGQ-1; Fri, 06 Feb 2026 11:24:02 -0500
X-MC-Unique: BpJlmL63Pd27yovmrmjSGQ-1
X-Mimecast-MFC-AGG-ID: BpJlmL63Pd27yovmrmjSGQ_1770395041
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee1fe7b24so29781775e9.1
        for <virtualization@lists.linux.dev>; Fri, 06 Feb 2026 08:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770395041; x=1770999841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SixDUkQfbGW/CySUSPTvhYKmVPlXZV2VssvRFKjxUY=;
        b=mHkoqkYBbR4QWqlBBnIIe1OiPaH963SmUhHgb2SAXa9iASfadqrzlmtL05sCIaTzDW
         TQGECWQjs9ZfeX3hdKxKnuNxZNH5w47EVkpmiJPL61cXsXmHgu56rQeyPPlKVsLdgAjH
         FWfC30FiOWLWW/Yg1/NbIE9BkMVRerv/fOCb9hiwRlZlE818rsEDu0/HLzu1lTBfpSOC
         NbMh8K2q1jrlCt6OYqDiQiJKAZoMdpGrIlyvCrbktmzz/U9muBmCIu42Doq6KyRAXxP4
         6CqwoKB2RxyCfsRPAgUhp6LUX8etCDqsTuTwse7XzNvmNDJV0ww+OWE1KZkwJFgRzNa4
         IIeQ==
X-Gm-Message-State: AOJu0YyYFP13ADI6O68iGVNlpFpheYkl64NAgiZY+Ow52C6H0qnS/tM8
	3v90UwGgDWhesdjl60+GpeFnSDLiUcMEqdbVGEwX9jM5/YRUEkEYk+qKU3r9kjxn/McYPjeh9Ch
	Yh5N+bt3AFe5JG5hNaLQcPuTEtr017EQwd+qM2teXnNV308NemJTcowIZP9x9VNGXGhMU
X-Gm-Gg: AZuq6aIRu+nfbMpU2sN1Eb3dtoGmxR7Ji/5XCyzV75hFso9BkN9xy7AIptuyiU3wT7J
	fUazpg1/IVlwvj3TQAEyjYWZe6rHTn1gSyWnfQzUHSzD8nspf2E0axY8UCJNixXWnMEHD3H24mO
	1ElzW63S/uVrgvtERBSJNjGVFjEhkwzAlmybfhAw55nqaaBDIgNGIvZJBOGZAiIFIAAu3PsYt2d
	LikpUkG8PF75belaDHOLoZBWkKOs1j+FgqCteXrzgYcp1qysiLikrAp80HjmlYlHEshOgel2eyN
	9AHMh21yHBeDJ/gq+lm/OHfzKAZ0WRWHauZUxzCtPlNLte9Z39/ROHvlwaZTIgjIGesbShFWFaL
	XNqmw6Bn/S/0taopEti6hIM6xa6qpZ2SPL4afqc9NoR1gPT5BJ6lN7DEsrxM=
X-Received: by 2002:a05:600c:34c7:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-483201dc3ebmr47795795e9.3.1770395040990;
        Fri, 06 Feb 2026 08:24:00 -0800 (PST)
X-Received: by 2002:a05:600c:34c7:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-483201dc3ebmr47795425e9.3.1770395040442;
        Fri, 06 Feb 2026 08:24:00 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320728774sm57584915e9.14.2026.02.06.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 08:23:59 -0800 (PST)
Date: Fri, 6 Feb 2026 17:23:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: agpn1b92@anonaddy.me
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [BUG] vsock: poll() not waking on data arrival, causing
 multi-second SSH delays
Message-ID: <aYYTder4-zvgOfV7@sgarzare-redhat>
References: <f3a801a1a32670294d5d703cad8ab609@anonaddy.me>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f3a801a1a32670294d5d703cad8ab609@anonaddy.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H3P0GLrqU1oo0nPcyDq5ikRoRFb0BFnwjctyD8ldWXQ_1770395041
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Feb 05, 2026 at 07:53:33AM +0000, agpn1b92@anonaddy.me wrote:
>Hi,

Hi [Your Name],

>
>I'm experiencing a bug where SSH sessions over vsock take 2-20+ seconds
>to establish due to poll() not signaling POLLIN when data is available.
>The bug does NOT occur on the first connection after VM boot, but affects
>all subsequent connections.
>
>* Summary
>
>- vsock poll() fails to return POLLIN when data is in the receive buffer
>- sshd-session's ppoll() times out every ~20ms instead of waking on data
>- First SSH connection after guest boot works instantly
>- All subsequent connections experience 2-20+ second delays
>- Non-PTY commands (ssh -T ... 'echo test') work instantly

mm, so not sure if it's related to the kernel or the user space proxy, 
etc. Would be nice to replicate without ssh.

I tried with 6.18 on both guest and host and I'm not able to reproduce 
it.

Can you try to write a simple reproducer without ssh involved?

Thanks,
Stefano

>- TCP connections to the same VM work instantly
>
>* Environment
>
>Host:
>- OS: Arch Linux
>- Kernel: 6.18.2-arch2-1
>- QEMU: system package (latest)
>
>Guest:
>- OS: Debian trixie
>- Kernel: 6.17.13+deb13-amd64 (also tested on 6.12.57, same issue)
>- OpenSSH: 10.0p2
>
>QEMU command (relevant parts):
>  qemu-system-x86_64 -enable-kvm -smp 8 \
>    -object memory-backend-memfd,id=mem,size=20G,share=on \
>    -machine memory-backend=mem \
>    -device vhost-vsock-pci,guest-cid=5 \
>    ...
>
>Connection method: ssh user@vsock/5 (via systemd-ssh-proxy)
>
>* Symptoms
>
>Interactive SSH (PTY) - SLOW:
>  $ time ssh user@vsock/5
>  # Takes 2-20+ seconds before shell prompt appears
>
>Non-interactive SSH - FAST:
>  $ time ssh user@vsock/5 'echo test'
>  test
>  real    0m0.156s
>
>TCP to same VM - FAST:
>  $ time ssh -p 33594 user@127.0.0.1
>  # Instant
>
>* Key observation: First connection after boot is fast
>
>After guest reboot:
>  $ ssh user@vsock/5      # INSTANT (< 1 second)
>  $ exit
>  $ ssh user@vsock/5      # SLOW (2-20 seconds)
>  $ ssh user@vsock/5      # SLOW
>  ...
>
>This suggests the bug involves state that accumulates or isn't properly
>cleaned up between connections.
>
>** bpftrace evidence
>
>Using syscall tracepoints on guest during slow connection:
>
>  === MINIMAL VSOCK DIAGNOSTIC ===
>  [   29 ms] sshd-session: ppoll() duration=19 ms ret=1
>             ^^^ 20ms TIMEOUT pattern detected!
>  [   50 ms] sshd-session: ppoll() duration=20 ms ret=1
>             ^^^ 20ms TIMEOUT pattern detected!
>  [   70 ms] sshd-session: ppoll() duration=18 ms ret=1
>             ^^^ 20ms TIMEOUT pattern detected!
>  ... (continues for ~2 seconds) ...
>
>  [ 5000 ms] --- 5s stats: ppoll=455, timeouts=103, recv=0 (0 bytes) ---
>
>  [19432 ms] sshd: recvmsg() = 308 bytes [4 µs]
>  [19442 ms] sshd-session: recvmsg() = 308 bytes [4 µs]
>
>Pattern analysis:
>- ppoll() returns ret=1 (1 fd ready) but takes exactly ~20ms (timeout)
>- The ready fd is the PTY, NOT the vsock socket
>- recv=0 during the timeout phase: vsock data not being read
>- recvmsg() finally succeeds after ~19 seconds
>- When recvmsg() runs, it completes in 4 microseconds (data WAS there)
>
>This proves: data is sitting in the vsock receive buffer, but poll()
>is not returning POLLIN, so sshd doesn't know to read it.
>
>* 30-second summary from bpftrace
>
>  Total ppoll calls: 488
>  Timeouts (20ms pattern): 103
>  Successful recvmsg: 6 (984 bytes)
>  Timeout rate: 21%
>
>* Why PTY-specific?
>
>PTY sessions require bidirectional traffic:
>1. Server sends shell prompt → client must receive it
>2. Client sends keypress → server must receive it
>3. Server sends echo → client must receive it
>
>Each exchange relies on poll() waking on POLLIN. The bug causes poll()
>to miss the wakeup, forcing sshd to wait for its 20ms timeout fallback.
>
>Non-PTY commands do request-response-exit quickly before the bug
>manifests significantly.
>
>## Additional context
>
>I previously encountered the identical issue on WSL2's Hyper-V vsock
>implementation, suggesting this may be a fundamental issue with how
>vsock transports handle poll/wakeup semantics, not specific to virtio.
>
>## Hypothesis
>
>Based on the evidence, this appears to be a lost wakeup race condition:
>1. Host sends packet to guest
>2. Packet is enqueued to socket's rx_queue
>3. sk_data_ready() is called but poll waiters aren't properly woken
>4. vsock_poll() returns 0 (no POLLIN) despite data being available
>5. ppoll() times out after 20ms, sshd retries
>6. Eventually succeeds through timeout-based retry
>
>The "first connection works" pattern suggests the race involves
>existing state from previous connections - possibly worker threads,
>interrupt handlers, or virtqueue state that isn't properly reset.
>
>## Reproducer
>
>1. Start QEMU VM with vhost-vsock-pci device
>2. Boot guest, ensure sshd is running
>3. From host: ssh user@vsock/<CID>  # First connection is fast
>4. Exit and reconnect: ssh user@vsock/<CID>  # Now slow
>
>## Request
>
>Could someone familiar with the vsock/virtio poll implementation
>review the wakeup path? Specifically:
>- virtio_transport_recv_pkt() -> sk_data_ready() path
>- vsock_poll() -> poll_wait() registration timing
>- Any state that persists between connections
>
>Happy to provide additional traces or test patches.
>
>Thanks,
>[Your Name]
>
>---
>bpftrace script used (runs on guest):
>
>#!/usr/bin/env bpftrace
>BEGIN {
>    @start = nsecs;
>    printf("=== MINIMAL VSOCK DIAGNOSTIC ===\n");
>}
>tracepoint:syscalls:sys_enter_ppoll {
>    if (comm == "sshd-session" || comm == "sshd") {
>        @ppoll_enter[tid] = nsecs;
>        @ppoll_count++;
>    }
>}
>tracepoint:syscalls:sys_exit_ppoll {
>    if (@ppoll_enter[tid]) {
>        $ms = (nsecs - @start) / 1000000;
>        $dur = (nsecs - @ppoll_enter[tid]) / 1000000;
>        if ($dur > 10) {
>            printf("[%5lld ms] %s: ppoll() duration=%lld ms ret=%d\n",
>                   $ms, comm, $dur, args->ret);
>            if ($dur >= 18 && $dur <= 25) {
>                printf("           ^^^ 20ms TIMEOUT pattern detected!\n");
>                @timeout_count++;
>            }
>        }
>        delete(@ppoll_enter[tid]);
>    }
>}
>tracepoint:syscalls:sys_exit_recvmsg {
>    if (comm == "sshd-session" || comm == "sshd") {
>        if (args->ret > 0) {
>            $ms = (nsecs - @start) / 1000000;
>            printf("[%5lld ms] %s: recvmsg() = %lld bytes\n", $ms, comm, args-
>>ret);
>            @recv_count++;
>            @recv_bytes += args->ret;
>        }
>    }
>}
>interval:s:5 {
>    printf("\n[%5lld ms] --- 5s stats: ppoll=%d, timeouts=%d, recv=%d (%d bytes)
>---\n\n",
>           (nsecs - @start) / 1000000, @ppoll_count, @timeout_count,
>@recv_count, @recv_bytes);
>}
>
>
>
>

