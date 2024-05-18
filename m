Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F5DDC1
	for <virtualization@lists.linux.dev>; Sat, 18 May 2024 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716027473; cv=none; b=sTsbY4qNLalLnNnZHJ4TbWMIlEcHAuCHUgirc6Re/YipOoGy2ZcAVB7+CAHkeUx32d5yRlZtc4nsqXaahBlKPx3zvmBd1VPFtpGIdaQyHFI/7q2465NYBVil8ssRy+SnQVUgM4wG8qPElDfdnK5Rd84x0FaSFVnC/ADi2+yVhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716027473; c=relaxed/simple;
	bh=xA2Bf8n5RCyqeoXlRG/S9pgpV9kOGAQ4TBNdrifLrLg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iVA+hFtp0+VYSaPbSnDkJ30ljvbVvmaeo9e9boULm5MDoFBlA3TjlK6zjmO6HC8cAv1q1V92C7SbQBhhJZxxQIThOj5gIxy2PmuGZhpMPSMpJx8nltJ9ydMPfv6QQPxeYsqjvmITdN26mLQwJH7bv+gW8rD0T3+IO8/i/ZBWw0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF0sc55i; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF0sc55i"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e538a264f7so17775971fa.0
        for <virtualization@lists.linux.dev>; Sat, 18 May 2024 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716027470; x=1716632270; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xA2Bf8n5RCyqeoXlRG/S9pgpV9kOGAQ4TBNdrifLrLg=;
        b=mF0sc55i8l6NzXtxXN00ZG3pSybL/7FtsRyr1NfsjQ7gchVQ5dLK5yVuGi6DcA6osk
         MFlA6aClgGLoOC2t26vbJcHiswIkLkPxhX3VSo3oBG1T/2A2Jw5DC6SwUHq6Sa6lA6Lc
         YiQ3Xi5mzmLEAY5z34sxmBoxnGkdQ8FyHbz7z0pOxnIcsGVPUbrasFqWg1iGm0PDYus7
         75JcoNJLITNW7gnqpH06mJRNRYhQaCSqPbcJIzHlJ9GGGHczjHWBqT0OLPvSdfJ0UCtu
         CVmgt7pf+5L5Q0ENauSrBSWVt9KQUNgbvDJHsZKQ0Xci0HnGMAwxh6gehXJrN3fGci16
         xNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716027470; x=1716632270;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xA2Bf8n5RCyqeoXlRG/S9pgpV9kOGAQ4TBNdrifLrLg=;
        b=K9L05H6Vhr7vpSJ6qEXedSs7iSxLzRakdPw1GhVdqlsThsSXQrGhaAHl2Ihzqhd5Ej
         6t0zHbKVSGCjSg7wzriKd/TUdenJMqkJ46tOcn2B8aPUZLqdPNK47eVcSPYxwUX6pzE6
         x1foMDxflqzLsmuiCybYsXbCHEdcj5DtU5Jr6sDGA8Wn4VmtITn2OzSxxIHTVgX6sf7f
         s0F1/t9BqmJXrdsCD3fGNpa/o4/VMmVTSqnj/r0F8XkS2XkbL3KdXJ9SMLUji7NdxoLj
         5kKNUiGsQ9IbnuBoafEMUt8ThLBo7jolfQ+C+M4lP10KgMVfYZIwJN3TIwMSahmEmh8J
         VeSQ==
X-Gm-Message-State: AOJu0YwQt1oYDK0B+1cB/VguBmjZH17uwdi49XOLAPLRutMs75HFp/fo
	3GuFzzrT9mCGqaMuHTHvIJKn5N4JxJifhjDFKEScPOVXjfoGhlPjUxwtpbJopsCCYeue5tU9klV
	C3H0hH/yan2GRE52/oVQNtQmgGhG2Mluf
X-Google-Smtp-Source: AGHT+IHdD80bucwwGfBvIzB+/cPOI8ABdlz0Zfb6O/bBatrsEmQ3rYLNrEXm0kKzesZxrgLoHZ0g9pPzIbQuxQvAe+E=
X-Received: by 2002:a2e:9284:0:b0:2d7:1a30:e881 with SMTP id
 38308e7fff4ca-2e51fd4a537mr167836001fa.12.1716027469622; Sat, 18 May 2024
 03:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sat, 18 May 2024 16:17:38 +0600
Message-ID: <CAFfO_h7xsn7Gsy7tFZU2UKcg_LCHY3M26iTuSyhFG-k-24h6_g@mail.gmail.com>
Subject: How to implement message forwarding from one CID to another in vhost driver
To: virtualization@lists.linux.dev
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>, agraf@csgraf.de, stefanha@redhat.com, sgarzare@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Hope you are doing well. I am working on adding AWS Nitro Enclave[1]
emulation support in QEMU. Alexander Graf is mentoring me on this work. A v1
patch series has already been posted to the qemu-devel mailing list[2].

AWS nitro enclaves is an Amazon EC2[3] feature that allows creating isolated
execution environments, called enclaves, from Amazon EC2 instances, which are
used for processing highly sensitive data. Enclaves have no persistent storage
and no external networking. The enclave VMs are based on Firecracker microvm
and have a vhost-vsock device for communication with the parent EC2 instance
that spawned it and a Nitro Secure Module (NSM) device for cryptographic
attestation. The parent instance VM always has CID 3 while the enclave VM gets
a dynamic CID. The enclave VMs can communicate with the parent instance over
various ports to CID 3, for example, the init process inside an enclave sends a
heartbeat to port 9000 upon boot, expecting a heartbeat reply, letting the
parent instance know that the enclave VM has successfully booted.

The plan is to eventually make the nitro enclave emulation in QEMU standalone
i.e., without needing to run another VM with CID 3 with proper vsock
communication support. For this to work, one approach could be to teach the
vhost driver in kernel to forward CID 3 messages to another CID N
(set to CID 2 for host) i.e., it patches CID from 3 to N on incoming messages
and from N to 3 on responses. This will enable users of the
nitro-enclave machine
type in QEMU to run the necessary vsock server/clients in the host machine
(some defaults can be implemented in QEMU as well, for example, sending a reply
to the heartbeat) which will rid them of the cumbersome way of running another
whole VM with CID 3. This way, users of nitro-enclave machine in QEMU, could
potentially also run multiple enclaves with their messages for CID 3 forwarded
to different CIDs which, in QEMU side, could then be specified using a new
machine type option (parent-cid) if implemented. I guess in the QEMU side, this
will be an ioctl call (or some other way) to indicate to the host kernel that
the CID 3 messages need to be forwarded. Does this approach of
forwarding CID 3 messages to another CID sound good?

If this approach sounds good, I need some guidance on where the code
should be written in order to achieve this. I would greatly appreciate
any suggestions.

Thanks.

Regards,
Dorjoy

[1] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
[2] https://mail.gnu.org/archive/html/qemu-devel/2024-05/msg03524.html
[3] https://aws.amazon.com/ec2/
