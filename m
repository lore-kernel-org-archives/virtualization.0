Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E872231A
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860339; cv=none; b=oMPhEF3joSd5TruCBpK5gpenk82lb4AUy2bLFMa80onqqN66XdT3MLt8qkRMFWnX1/nq6dF3qBzXKCbx2KL+FwnqAwr+KuOpfGh0ItOzC8rNy3OXuYC5aH83MnyOAAHihyOhI7eJfN5hk4KgvGPp9AQohSZOR5MVxSgheI/4148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860339; c=relaxed/simple;
	bh=1ry6AQG7FDQURpCv8xY189XkCSFEOUrLObp2q9zDSA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjZUujqCcCNsg3x7qoGIhVnraQ2jjBnsNNzltru4sYmv3jZZmMMHapTAstr5TUkkDI01TfGBtDnHpF9nAZ5gFRVDhmUH+cfVY7qoVdoLXM619P4NQMY61/ypD3ALzSgLwcFxmD/h9VtYl8jmlD0VJAG/xkRYyO4p+LoFX7LW+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaviOGpe; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaviOGpe"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8DB8405B3
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 01:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZG94WvmPYrUz
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Mar 2024 01:12:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=dreaming.about.electric.sheep@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7774A40176
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7774A40176
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kaviOGpe
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7774A40176
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 01:12:16 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33e285a33bdso855398f8f.2
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Mar 2024 17:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860334; x=1710465134; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rYDwFy7vdGfEU3AYQcMyBM3b1/hHXEUCIhC7owEbTA=;
        b=kaviOGpeP4UxLl2y0dy7iTBjrMnLfbx15dxU2ZEVxYpYrS0pTlBEZANOeC4Bvaaq8b
         QxKcyeibLOhgFz00PsxDqiW11Qls6H/LBB/uPbfPbK83h74mL2GtyO9gGsTaJ9GW2apm
         MAYjAti3ROsyqHJszja9ryY8RR02U9/YWufNO/Fh96T27ruLAh0IuTx8ywzQG02F2zqK
         TTcjVYg4numCh6FVMe42ev+lTPRBtjA1/PVMa0uxdaoncC9cko4FwQed/5a3yho37VbQ
         +63raQ0/OfZMYU28Wm8cx+VetEczTDYVU/2J3b8y5yZINFT8fL/m1bIOgv0y3l1ubeL7
         27Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860334; x=1710465134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rYDwFy7vdGfEU3AYQcMyBM3b1/hHXEUCIhC7owEbTA=;
        b=vEUbB4gvMyaEQ11yFrFJS9XE2XwEwQSTsc304WzQgPGqdCHkjBC4Rj05Bedzh6TPP5
         KMuwnWgYTuJeQcdbTvxxWPcHa0fKo/nkzdgspgt1e4+yG8cRQ5JCQtUtpkDrsVNHJpMK
         CyXJGT5Q6Y3FXevJWtkpdCejjWBGz8lvAnTEjTWgwEzT5T7DailKj9XuPer9nEGKG4sY
         aZBiuEuXITZZs9M2WnhyivmGOBMzxywgPZSx2MSRxLN6DAH9TsT9StjhDDaGvUqSOm9I
         QN2DQy3Fp7VkmYjsPqS0FqsHKBsgTTvSMd2h6p4iN08avSS/W5ZU2k2Jveggr4X6YE/O
         y2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUD7ZIy8Vp8TTAzI1fx57A4btkFftFToVk8SVvvpX2BXwhN62087CByZ1zvzRO4zgc8IIeK6eKem/bL6hWqfhxWAh+RXIY4nfrQqpCnzR6Fl99yC4gbAv2/SA==
X-Gm-Message-State: AOJu0Yyu8P3FQH188SLTvtqsjxmCvDtVSOzqpm3RloIQiFrQux65UiuW
	m1cgLClPf/whNUmvxrYq3ihH1vux6zwptY7rqcIJNl6X6Q9g5e9/
X-Google-Smtp-Source: AGHT+IGKMlg7G8idiMgtUIW7KsMqQOgjBUReKZbtn1HelBvnmw950hTkhxqpW8un5mj/gRLn/HuyMA==
X-Received: by 2002:adf:f7d2:0:b0:33d:6ede:1149 with SMTP id a18-20020adff7d2000000b0033d6ede1149mr13774269wrq.35.1709860334120;
        Thu, 07 Mar 2024 17:12:14 -0800 (PST)
Received: from localhost (ec2-18-169-47-158.eu-west-2.compute.amazonaws.com. [18.169.47.158])
        by smtp.gmail.com with ESMTPSA id w15-20020adfec4f000000b0033e767cac6csm298769wrn.115.2024.03.07.17.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 17:12:13 -0800 (PST)
From: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
To: regressions@leemhuis.info
Cc: 1054514@bugs.debian.org,
	airlied@redhat.com,
	carnil@debian.org,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	timo.lindfors@iki.fi,
	tzimmermann@suse.de,
	virtualization@lists.linux-foundation.org,
	Alex Constantino <dreaming.about.electric.sheep@gmail.com>
Subject: [PATCH 0/1] drm/qxl: fixes qxl_fence_wait
Date: Fri,  8 Mar 2024 01:08:50 +0000
Message-Id: <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
References: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
As initially reported by Timo in the QXL driver will crash given enough
workload:
https://lore.kernel.org/regressions/fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info/
I initially came across this problem when migrating Debian VMs from Bullseye
to Bookworm. This bug will somewhat randomly but consistently happen, even
just by using neovim with plugins or playing a video. This exception would
then cascade and make Xorg crash too.

The error log from dmesg would have `[TTM] Buffer eviction failed` followed
by either a `failed to allocate VRAM BO` or `failed to allocate GEM object`.
And the error log from Xorg would have `qxl(0): error doing QXL_ALLOC`
followed by a backtrace and segmentation fault.

I can confirm the problem still exists in latest kernel versions:
https://gitlab.freedesktop.org/drm/kernel @ c6d6a82d8a9f
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git @ 1870cdc0e8de

When I was investigating this issue I ended up creating a script which
triggers the issue in just a couple of minutes when executed under uxterm.
YMMV according to your system, for example when using urxvt crashes were
not as consistent, likely due to it being more efficient and having less
video memory allocations.
For me this is the fastest way to trigger the bug. Here follows:
```
#!/bin/bash
print_gradient_with_awk() {
    local arg="$1"
    if [[ -n $arg ]]; then
        arg=" ($arg)"
    fi
    awk -v arg="$arg" 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "%s\n", arg;
    }'
}
for i in {1..10000}; do
    print_gradient_with_awk $i
done
```

Timo initially reported:
commit 5f6c871fe919 ("drm/qxl: properly free qxl releases") as working fine
commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") introducing the bug

The bug occurs whenever a timeout is reached in wait_event_timeout.
To fix this issue I updated the code to include a busy wait logic, which
was how the last working version operated. That fixes this bug while still
keeping the code simple (which I suspect was the motivation for the
5a838e5d5825 commit in the first place), as opposed to just reverting to
the last working version at 5f6c871fe919
The choice for the use of HZ as a scaling factor for the loop was that it
is also used by ttm_bo_wait_ctx which is one of the indirect callers of
qxl_fence_wait, with the other being ttm_bo_delayed_delete

To confirm the problem no longer manifests I have:
- executed my own test case pasted above
- executed Timo's test case pasted below
- played a video stream in mplayer for 3h (no audio stream because
  apparently pulseaudio and/or alsa have memory leaks that make the
  system run out of memory)

For quick reference here is Timo's script:
```
#!/bin/bash
chvt 3
for j in $(seq 80); do
    echo "$(date) starting round $j"
    if [ "$(journalctl --boot | grep "failed to allocate VRAM BO")" != "" ]; then
        echo "bug was reproduced after $j tries"
        exit 1
    fi
    for i in $(seq 100); do
        dmesg > /dev/tty3
    done
done
echo "bug could not be reproduced"
exit 0
```

From what I could find online it seems that users that have been affected
by this problem just tend to move from QXL to VirtIO, that is why this bug
has been hidding for over 3 years now.
This issue was initially reported by Timo 4 months ago but the discussion
seems to have stalled.
It would be great if this could be addressed and avoid it falling through
the cracks.

Thank you for your time.


---

Alex Constantino (1):
  drm/qxl: fixes qxl_fence_wait

 drivers/gpu/drm/qxl/qxl_release.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)


base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
-- 
2.39.2

