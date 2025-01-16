Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03B18D65F
	for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737008723; cv=none; b=AX+zSIdZSNEP6aJUWWZjRQeTjsM7ylHvCGzQnQg7xf1Loy88drBuyHzPl6pICkgn0+6YjJZn1S4mux4gixRqBt9qMKVRlPPnLOlOfSUp2ZnLt+uDT8v8xt3MNXoKWkj18OeBtjQnC5K3vq82JBayIindVvw/zvBf0N82ZwejB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737008723; c=relaxed/simple;
	bh=WMJn4P15Uop0ZUJaj8l/izNbz6zUAeoohtTpPY/IIWw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=E3edUrcbgmu6fBzIKeM1AJKD4DwsnhEPkl8pBKiDnHx1UT6iOU2SVfyb2oRmFywSB+9H+RixVao3UJO6sFi64dhcsMiub9eQ98OoFNJOXk47M99AexX9lZ2UzC0Cgyhq9M6rbMgRHexABuJis1A1XcUmbQsVqvWRPrSpPLVimvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWjYO0et; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWjYO0et"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2163a2a1ec2so19788475ad.1
        for <virtualization@lists.linux.dev>; Wed, 15 Jan 2025 22:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737008720; x=1737613520; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0AN0Fv7sq/hB9CZnHK+4fFyVr9YDFDdUdaXoaXDLHo0=;
        b=sWjYO0etkrpv2LKnZRlGyvlCkvOXE97tSTyWNufHI0o2uCv4Bg3GPPD/DA9cBdJTSp
         Zig5rc062PbE4VvKuLjwyKENDe+iuCO4VTa/qdtPuRmoKWNxHui8hTfHv8BzgTbB90dZ
         n+FtJEDmYz520h0IM7yn+FbK0FEy8yTS9OWS5VFrym4fPAcfLbtrJm3aOJt6t2lf/p2N
         UGAIIiMqRSI4K0/+c6ACBrI4pggAkJ0s+tezbfuUddUp5yaTnSltUO7he2CFAtjSkThF
         jfe7UH8Gzzsa+VNiXK0SbGpa2DNsC9eRSNN6/9pLNz6v0ibw9jdehLqaZs6uNoT951Ju
         bNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737008720; x=1737613520;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0AN0Fv7sq/hB9CZnHK+4fFyVr9YDFDdUdaXoaXDLHo0=;
        b=ZUl14m9oQ6Nd1EIzmFqLo2Z5F7eeuvw+3BPQAfK3fiKSuZySmxRjSUmrhXSAE0xewL
         vV19AmlBXqAuNhN7qZPdHvR7hSAU3aQMgCMWM8ZprpNnk0o54uzBAQ7UnWDL6+clyPV8
         zDjiCqR9NvVU6r455cyq71lOIyUZvpVriuuAfrhwCvQC8XKFZYuO9j+Kv8AUTtm29aHU
         HPgv76Jga1JlX2cWxF5thJ5ffs75s79Gtil1L0qkI+X6BssNlxQGNRpHxPTVS9pHKvkQ
         +9mtns6pzwlbHYu0B1vSiva5IDagaoQae6tKLyeT4AopTi2I69h6CN5NOYXhEqc4oDXW
         klzA==
X-Forwarded-Encrypted: i=1; AJvYcCUFv0/M7riWNMdVquPd7CoGnMlidbBfoBE8JwOewKorUBcmi1PB+3w1dmFKJXKoK52ZeXx07my9BfSFSdx07A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwN0k9AHtHBJQxuLnH9kIovabn4a9MaTzbdhOZZmEshEs5TDRo1
	wsoGO4GlHxTCO8xX3XkIsewwDdfN0reIQ0s7XHwi2Xwurzo2BbxQcBAlwf5tFKR5vS6Gtqgyeu+
	jK1QG
X-Google-Smtp-Source: AGHT+IFuQloDZ6I9ZKV+hzAUpeyDuwaFLgqIic+b8+hSoEirG8TVYZ5FbcDjE0Zwn+8UmU2ObD/PiAwBYNLJ
X-Received: from pghv4.prod.google.com ([2002:a63:f204:0:b0:7fd:38f5:be0])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7885:b0:1db:eff0:6ae7
 with SMTP id adf61e73a8af0-1e88d36152cmr48823832637.33.1737008720197; Wed, 15
 Jan 2025 22:25:20 -0800 (PST)
Date: Wed, 15 Jan 2025 22:25:08 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250116062514.2391108-1-jstultz@google.com>
Subject: [RFC][PATCH] sound/virtio: Fix cancel_sync warnings on uninitialized work_structs
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	virtualization@lists.linux.dev, linux-sound@vger.kernel.org, 
	kernel-team@android.com, Betty Zhou <bettyzhou@google.com>
Content-Type: text/plain; charset="UTF-8"

Betty reported hitting the following warning:

[    8.709131][  T221] WARNING: CPU: 2 PID: 221 at kernel/workqueue.c:4182
...
[    8.713282][  T221] Call trace:
[    8.713365][  T221]  __flush_work+0x8d0/0x914
[    8.713468][  T221]  __cancel_work_sync+0xac/0xfc
[    8.713570][  T221]  cancel_work_sync+0x24/0x34
[    8.713667][  T221]  virtsnd_remove+0xa8/0xf8 [virtio_snd ab15f34d0dd772f6d11327e08a81d46dc9c36276]
[    8.713868][  T221]  virtsnd_probe+0x48c/0x664 [virtio_snd ab15f34d0dd772f6d11327e08a81d46dc9c36276]
[    8.714035][  T221]  virtio_dev_probe+0x28c/0x390
[    8.714139][  T221]  really_probe+0x1bc/0x4c8
...

It seems we're hitting the error path in virtsnd_probe(), which
triggers a virtsnd_remove() which iterates over the substreams
calling cancel_work_sync() on the elapsed_period work_struct.

Looking at the code, from earlier in:
virtsnd_probe()->virtsnd_build_devs()->virtsnd_pcm_parse_cfg()

We set snd->nsubstreams, allocate the snd->substreams, and if
we then hit an error on the info allocation or something in
virtsnd_ctl_query_info() fails, we will exit without having
initialized the elapsed_period work_struct.

When that error path unwinds we then call virtsnd_remove()
which as long as the substreams array is allocated, will iterate
through calling cancel_work_sync() on the uninitialized work
struct hitting this warning.

The simplest fix seems to just check the work_struct->func ptr
is valid before calling cancel_work_sync(), but I wanted to share
in case folks had ideas for a better solution.

I have not yet managed to reproduce the issue myself, so this
patch has had limited testing.

Feedback or thoughts would be appreciated!

Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev
Cc: linux-sound@vger.kernel.org
Cc: kernel-team@android.com
Reported-by: Betty Zhou <bettyzhou@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 sound/virtio/virtio_card.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 965209e1d872..87dc49c9390a 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -365,7 +365,9 @@ static void virtsnd_remove(struct virtio_device *vdev)
 	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
 
-		cancel_work_sync(&vss->elapsed_period);
+		/* check we initialized the work struct before cancelling*/
+		if (vss->elapsed_period.func)
+			cancel_work_sync(&vss->elapsed_period);
 		virtsnd_pcm_msg_free(vss);
 	}
 
-- 
2.48.0.rc2.279.g1de40edade-goog

