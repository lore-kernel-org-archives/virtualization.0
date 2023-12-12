Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195718049
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="k3iFPADr"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC52D60F48
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 08:05:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC52D60F48
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=k3iFPADr
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A3pMaOUTeX0l
	for <virtualization@lists.linux-foundation.org>;
	Tue, 12 Dec 2023 08:05:24 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6175060C06
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 08:05:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6175060C06
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5ca1b4809b5so659516a12.3
        for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 00:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702368322; x=1702973122; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyrJ/oaF1a1+OdMWUr85QqR8PoKu+Afm3G/pEUOxUgM=;
        b=k3iFPADrj4gEEUR7hOsWAmIkXSm9jzEkNfI9TQ1lTZRpsY+P+JAcYuFvD6hByQLE0B
         gQXTXe/0WKsOkM/uCfIgaijzGDuemKSNcdzNlueRBqXqMNHp6zd/6+AcpT4O7CzYJAHK
         ZQOtjsYMBBkGfXVI54boqp1Eyx7ZxLll+S3VeMjeCFiRzx87k6xH7JHGuLo31vWxGIt9
         y5oGnjkiCxGY8qsa6yGUqmC+ZYPNw/J5jBJgwe+qbbaV+MO5BMQioEVLwrXaOLNYCGz2
         JoSlCWFECe6InYC35EUUchqESiZ2oHNbEtrnNnCpCtIQmsSkcYwcv9c6IbnS2PiIMn3D
         pErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702368322; x=1702973122;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xyrJ/oaF1a1+OdMWUr85QqR8PoKu+Afm3G/pEUOxUgM=;
        b=gmxUGDwFi1IAN+lQzLJB9RqzSG47Jr8JZWUcpfD4ZskPhgt6ri5TuKqiUjsLfocU4J
         xb8anFD1HRO86CpoGre00dXZ7PhDsCrndu7iq2cDkQKEGNJiP9L9EE72ShFPopD9uF52
         WYJnDVPbYriAmfrLDrkGHGxaZTHUSprX/yZSe4FSxVnVB7Q3V32seGJRA2FBvcjKQF68
         h1vgpIw6St9mbSUYIgCuBGyXkChqliBdVAFcmCeY0sChQ3UCmH+OmSPX57y+0iTfqBdd
         1dJZSZS7ERD2+fiyoqb24D0v7EVm4osqz7527E3shphcbYmN7t8BBNmNQiktfvcqDjev
         jhvQ==
X-Gm-Message-State: AOJu0YweX0YaqVdrNCJ8YmAulY2VcX6fZU8CvSXFv178G5n5VBw/ORaw
	Sb7dIYcDY/dPtvmVN57Ejqa4EQ==
X-Google-Smtp-Source: AGHT+IEql1gIzfMgiC3uwAyX05ccRP/TJmlVXqhwk7OLXHzm7HuO8eWQfZEt37CKdp9jdfYH1gF7Bw==
X-Received: by 2002:a05:6a21:999d:b0:18f:fb0d:e961 with SMTP id ve29-20020a056a21999d00b0018ffb0de961mr3147656pzb.60.1702368322598;
        Tue, 12 Dec 2023 00:05:22 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id j17-20020a056a00175100b006ce6bf5491dsm7531509pfc.198.2023.12.12.00.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 00:05:22 -0800 (PST)
Message-ID: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
Date: Tue, 12 Dec 2023 17:05:15 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Yuri Benditovich
 <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 Benjamin Tissoires <bentiss@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Should I add BPF kfuncs for userspace apps? And how?
Cc: bpf <bpf@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kvm@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

It is said eBPF is a safe way to extend kernels and that is very 
attarctive, but we need to use kfuncs to add new usage of eBPF and 
kfuncs are said as unstable as EXPORT_SYMBOL_GPL. So now I'd like to ask 
some questions:

1) Which should I choose, BPF kfuncs or ioctl, when adding a new feature 
for userspace apps?
2) How should I use BPF kfuncs from userspace apps if I add them?

Here, a "userspace app" means something not like a system-wide daemon 
like systemd (particularly, I have QEMU in mind). I'll describe the 
context more below:

---

I'm working on a new feature that aids virtio-net implementations using 
tuntap virtual network device. You can see [1] for details, but 
basically it's to extend BPF_PROG_TYPE_SOCKET_FILTER to report four more 
bytes.

However, with long discussions we have confirmed extending 
BPF_PROG_TYPE_SOCKET_FILTER is not going to happen, and adding kfuncs is 
the way forward. So I decided how to add kfuncs to the kernel and how to 
use it. There are rich documentations for the kernel side, but I found 
little about the userspace. The best I could find is a systemd change 
proposal that is based on WIP kernel changes[2].

So now I'm wondering how I should use BPF kfuncs from userspace apps if 
I add them. In the systemd discussion, it is told that Linus said it's 
fine to use BPF kfuncs in a private infrastructure big companies own, or 
in systemd as those users know well about the system[3]. Indeed, those 
users should be able to make more assumptions on the kernel than 
"normal" userspace applications can.

Returning to my proposal, I'm proposing a new feature to be used by QEMU 
or other VMM applications. QEMU is more like a normal userspace 
application, and usually does not make much assumptions on the kernel it 
runs on. For example, it's generally safe to run a Debian container 
including QEMU installed with apt on Fedora. BPF kfuncs may work even in 
such a situation thanks to CO-RE, but it sounds like *accidentally* 
creating UAPIs.

Considering all above, how can I integrate BPF kfuncs to the application?

If BPF kfuncs are like EXPORT_SYMBOL_GPL, the natural way to handle them 
is to think of BPF programs as some sort of kernel modules and 
incorporate logic that behaves like modprobe. More concretely, I can put 
eBPF binaries to a directory like:
/usr/local/share/qemu/ebpf/$KERNEL_RELEASE

Then, QEMU can uname() and get the path to the binary. It will give an 
error if it can't find the binary for the current kernel so that it 
won't create accidental UAPIs.

The obvious downside of this is that it complicates packaging a lot; it 
requires packaging QEMU eBPF binaries each time a new kernel comes up. 
This complexity is centrally managed by modprobe for kernel modules, but 
apparently each application needs to take care of it for BPF programs.

In conclusion, I see too much complexity to use BPF in a userspace 
application, which we didn't have to care for 
BPF_PROG_TYPE_SOCKET_FILTER. Isn't there a better way? Or shouldn't I 
use BPF in my case in the first place?

Thanks,
Akihiko Odaki

[1] 
https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/
[2] https://github.com/systemd/systemd/pull/29797
[3] https://github.com/systemd/systemd/pull/29797#discussion_r1384637939
