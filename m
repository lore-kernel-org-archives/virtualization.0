Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D93B3894
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133788; cv=none; b=L7ddfFOjYWWsqYKVhULYH8DLgETMHTzMDYydrwCZLrxIxhicZOAdPGizVFhDG/GBFnkHXvnRzytil8vxc9C8lElbnMAFNoF0Ev6mzCkVI0Pkb1Z5BoNXeRkDr6H3fxMbsgXrw3EruDCeu8tdTaMK6PGz07QVcDe2opPv5C04P5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133788; c=relaxed/simple;
	bh=KIu+EvlorbnlKwwXdHIcvC3HLEpMtc0UtI9j2rJH8zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCYwFdIY/ocndlXcjUETbhFi7cmrqdpmfyDXsEHNlkgey8jWqLeY+1lH7CkIBRpHE6FEZ9tsKjcsd06jIdCs8tfl8Y4uFo3isbnpzXb/Hqj3OVln55ir74XAIaaXZiwWwmRiWZ9Rf7xBx+0ffjx+bSOr7UE5OtrQXuAnJ4A0rV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s24J+G7E; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s24J+G7E"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so9484261a12.2
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784133785; x=1784738585; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YyrwCmoer2aeH7zF0wwvp/QUbG2nb9e4P0wWSlLo9Ak=;
        b=s24J+G7EOLmNgmvehc8Dz+FOoRtU86Ji0aE3tT//kyfZC0sYxFkSCXSWHZ1OrWj5mG
         tfAh1fOFyMPmSXr+7VVSyy9EiFVUEea0Lurze7GoMgQvIUVkpQ9kutY68g+gEH3C/jUA
         tqGOyPkrHB++Oo+E6d8g0TU6o5/pODiTVgEYlcuUEEhioziTU2BYwCITZAaaxvtPmWKK
         F8tJ52fjaHDGRPgylt0srqEugFke0PGd5kFKbAOZYN/Dwd2axZEnxCPaZtzV+rKlr/Z4
         2D5qFOOhYyvmeSqBY2doVYDxBDKivb6O4TMRokQRtE/zAF6IOkXG5hxkuX6OsOZDQc7N
         eeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784133785; x=1784738585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YyrwCmoer2aeH7zF0wwvp/QUbG2nb9e4P0wWSlLo9Ak=;
        b=DftdXWlcjmZHzmjeMHcznHAZJckZc8shJGuI4Ari9UyA5FcVF20xnREFeUMhybCNPQ
         Cis3Et7vXmMkww1PKELj5DgK69E6FwMPzmWgZ/D5heCMirPsY5GZy9VOrdlAEDd0izOh
         dOocK8nx4PUfVADXocPJCNylHyBTMJs+S/ycPW2yV1yMvBSHapB68WBabPadkvFJTDxR
         3b4UE3dBGHFNxXzBB1MjnUDB7OhSlMwvDb999d+weNgBgR5NicNZBTmqg/eFIGukLHfC
         SrtW5er5S3yMYdtvOu+iJfff2O5eK72dLhMQFZ0DGmTb1Ml4sFtVLR28af18762AtzVQ
         kBow==
X-Forwarded-Encrypted: i=1; AHgh+RpnfEWk7TgrUVbqrpw0WpEUcCFAJ8haTfDMSOnp7NlQDPWTGiP8mZ3WUWs7b1uXGlucJv8BIu7hn/+el8tzng==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMbqF77crgzFaqmfq+eG3Wxfoo9Wb6BDpqQ3/jyXnLzzE2sfee
	tD2F+nE4mPXABGDwn87TUd49OyVy/UJoyMuZg8T7UFGEW0VbEc5EDBpW
X-Gm-Gg: AfdE7ckGU0BtTMXiD7Au7vWk7HJm1wx5zp7z/WY+BsLuiOIoV+1Gp7ReuJzeRLGQxdj
	szb3Tt907yvDGhDbgh80GanO15IqckoCxLpngc7OLdfE8vVJMaNjaOkVVYN8tUZZbezgupeH1io
	TCf+pfQRCU4YYw7byR1RXXZAMGQmzWgeyENmTuFRMEOPUlP3pTPDS1Himn9jiWPXBmdixkY+6iP
	NgA2e/xepnRXNFmF3h+LPz7ZdRTamcmRJgpYHGc+LQE+TpPeb25VpnecVWGCysWfZQS9sE43S90
	Yr3Vu7vm67rgFgUbEVwQLoM2G07dZrT/EJboHLjvEBiau1lpZHHQ/bV4Chs+Zd9Q5JvztHjw+ot
	MTiWQgm4xzS74NGuTbM5EBDEU/KL//Va1BTDtpvA9mxRyS9S5hnNIG6fQQyKM9Cjy6ZYY/hlZ+e
	nqmTfG8pBIPbeYECInkKsa3LBXiIzEUhkJLxLBZpGyH38YlVIcPhAFD9Ndhou2dsxuQYSRnlgb0
	qoo
X-Received: by 2002:a05:6402:1cc9:b0:69a:2ee6:4c94 with SMTP id 4fb4d7f45d1cf-69e1977783amr2054499a12.2.1784133784997;
        Wed, 15 Jul 2026 09:43:04 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd29213d7sm3503437a12.16.2026.07.15.09.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:43:03 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH v2 2/4] virtio_input: validate device-reported multitouch slot count
Date: Wed, 15 Jul 2026 18:41:58 +0200
Message-ID: <20260715164259.41060-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715142337.22811-3-harimishal1@gmail.com>
References: <20260715142337.22811-3-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nslots is derived from the ABS_MT_SLOT maximum reported by the virtio
device. A device could report a bogus maximum (e.g. -1) making nslots <=
0, and input_mt_init_slots() can independently fail too (e.g. it rejects
slot counts over 1024). Neither case was handled here, and
input_mt_init_slots() failing took down the whole probe, losing the rest
of the input device over a problem isolated to multitouch.

Instead of failing the probe, warn and disable the ABS_MT_SLOT
capability in either case, and let the rest of the device register
normally. This recovery assumes input_mt_init_slots() is called with
flags == 0: with nonzero flags it can fail after already mutating the
input_dev (e.g. via input_set_abs_params()), which this recovery does
not account for.

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
v2: per review, disable multitouch instead of failing the whole
    probe when the reported slot count is invalid or
    input_mt_init_slots() otherwise fails.

 drivers/virtio/virtio_input.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index deec24e8e682..786f5150724f 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -312,9 +312,25 @@ static int virtinput_probe(struct virtio_device *vdev)
 
 		if (test_bit(ABS_MT_SLOT, vi->idev->absbit)) {
 			nslots = input_abs_get_max(vi->idev, ABS_MT_SLOT) + 1;
-			err = input_mt_init_slots(vi->idev, nslots, 0);
-			if (err)
-				goto err_mt_init_slots;
+			if (nslots <= 0) {
+				dev_warn(&vdev->dev,
+					 "invalid multitouch slot count %d, disabling multitouch\n",
+					 nslots);
+				__clear_bit(ABS_MT_SLOT, vi->idev->absbit);
+			} else {
+				/*
+				 * flags is 0: input_mt_init_slots() can only fail
+				 * before touching *idev, so the recovery below is
+				 * a full rollback.
+				 */
+				err = input_mt_init_slots(vi->idev, nslots, 0);
+				if (err) {
+					dev_warn(&vdev->dev,
+						 "failed to init %d multitouch slots (%d), disabling multitouch\n",
+						 nslots, err);
+					__clear_bit(ABS_MT_SLOT, vi->idev->absbit);
+				}
+			}
 		}
 	}
 
@@ -331,7 +347,6 @@ static int virtinput_probe(struct virtio_device *vdev)
 	spin_lock_irqsave(&vi->lock, flags);
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
-err_mt_init_slots:
 	input_free_device(vi->idev);
 err_input_alloc:
 	vdev->config->del_vqs(vdev);
-- 
2.43.0

