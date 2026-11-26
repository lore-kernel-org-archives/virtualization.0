Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661115;
	b=EUwee63KkWUs31WqafI8r3u3KruFcM18VX08gA+q2FUYs5CrYxGJqp+pXt6/JfRK9/3f
	 f1wk9B0aSkI1KTNuJ/4Ls8sQv0AOcQvBR/JmWwRdWaDQNgdWbJI2D7xBhIh1UKjjrbbNm
	 zydlb4UUDP+TgchhNMMha6MtigSkAHzgHxrCMoHTw2s5YMFVjovQxj7ZJJwGFRrrDY4zd
	 kq8NjIgM6dnbO6MDYKAc2S1jTpxzhM7pj51lfr8wa/JJxDBkLVZI9Q4vxsfXMiS9z+egm
	 mkbXL9etD5i46SYtYEQU/m+tjWOQ3YvCP1qaQYeujO7gVHicUwifQfIDnfYyow2N46A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=R6c2jmbYqWccEr0Zv9Hq/ZQeve0kZ7n3mGg4UZDjyvA=;
	b=K48AQxtHolFJkOg8daJ8Br9vd1BDWmrKT8a2WYa8vpc3475uanZo9i5wk549vCYtYFrY
	 PJasvJsVdK3LDkPxCc6Q4z2o+MRpLNOKJ7qN6ti+82Ym/wgmi1BDcENHF7J5r3KORd8MR
	 SoDizY+ANW4rOvbCu+AoQZPJucp4509o3kEJHfB2vH+of7hR0DAeAq9zsKzXVW9xBz92G
	 h3TvYwHrG41DbMe6vOcG14qEeDYIuOW2ILSwrC7UClo8axx9zhULqpiJ0WsifiOkag/Dq
	 L7fi7Mo74WaGKJBkGocm+ilkTkpCeVK2PvS+2odLh448w0M8vP9oKO3Tb1FdO92k4VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=CRdr1LSX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1A606A32C
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 02:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE1A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=CRdr1LSX
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-679aeeddc6bso6295995d50.2
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 18:45:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661114; cv=none;
        d=google.com; s=arc-20260327;
        b=YMXcM0WtC/VSdlho+PwVFojfWjBoTT8msrqUWgWqdTZ7Xlo8pAZMQJDViG5hPRU8Kf
         BzL6VaVE85VajyliSQzec6ug2kAU7s6INOYqf2V+YnwN9z5OyS9ix8P3uPsyEdOClj85
         VLgQ7UrDfZZEXjKSuNR0QJAnBWdua8Xtgs2hv5Y5BXOaz8tfwlptk787yn97fQZw4BLc
         cYldrVzVEkLGs/KTWJaGZWQe/xlP88JTaY2/zBIDIcZbayrqXpFQgNnwHgad05zTq3OM
         LbdWZ2Ghti928jTJnvYZs2sYbDNmPf4+BVb7Rasuf7rkNeCRxMVpWIaG8ZLAuF3t7qfn
         7n+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=R6c2jmbYqWccEr0Zv9Hq/ZQeve0kZ7n3mGg4UZDjyvA=;
        fh=MkMQNeszdrsfFrFrHHlrQjO/pt84UX2b7ycZdBWcXvE=;
        b=V1E5ANz2uUyeWYah8R+Jo+rzyb9S4hzn6K/+0dSHOrdTfXrbD2qQz/XUcbAasaPg6B
         SRLPjLRgFJGaYBb4WtnfTKMFZZ/iDhsiQjbk0OqqXUym3Yp2ygjFPrbELXDPILb+Hpoj
         5JYT3qvnbiWLnqjplQF4gwMUX2KlL/h0iMZ5gVGK1jyb/EFYhojqfoiWE3CbC8zGFRdF
         JslHO6lSYhfrn4n2nfHu1IV4d2o++113FFcRTjPTJquCXlAqFa6eOMYVq8SwPhZNPQa+
         H3bp4C/JbyhOCc2ZEltufv7FTjvEqEBcUE/0MktBGBc99qqrfeMDIac2uMkQbJ+QBB1q
         YUPg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661114; x=1796265914; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R6c2jmbYqWccEr0Zv9Hq/ZQeve0kZ7n3mGg4UZDjyvA=;
        b=CRdr1LSXRa5E9X54qZlBhOF2xNeb+RwYg4iMS/UMVsTxtAWUm5DBhn4nFLPpamB5B8
         plca2WR+E7h9fBfTICkiYDCFFipliORO4D4hWCE5Vi6II6DoNT7YxjioskSRDFDj3DRW
         ij7VI4XpwBI/Y6loGYXWStgCQwxbkWYiNqKX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661114; x=1796265914;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R6c2jmbYqWccEr0Zv9Hq/ZQeve0kZ7n3mGg4UZDjyvA=;
        b=BuwjzJ3kQjyKPBlgekdhRkizFd7wZRyhKuotadyRQ1zxc7lHaNhhD5SqscbeFRsP59
         TIk4Gd36rPoNk0JB/75lpQPI0Gi6RQuq3O//WF6z1eeENE+5nxupxpu4Mll5rxJJ6MWr
         ZNPWUiQCAY6Z/4VRkQG8xXO+zweLK4NuWmY/ZDSurftwqFajgTay2IJTOo1XX5fiaAqH
         FsFY+znLgYFwRBigMCvKIbhQMq6BsnNR34dR8jiXomKDA1c/RRFTFiFLgC57qYhdQrmT
         TzTmvPmlNSrGNM0tORWc1lUBjr/1VBiCGRCfZLL2VC48HxKGIqXHQcOkZXMifIdwP0h3
         TC9A==
X-Forwarded-Encrypted: i=1; AL+hErFNWsXP/W/YoXbsTiUnGS6LoUHhPMgTQrAJyn6uuo97s0VNrxRkzPXsKZ+iJSjH/e+mQCbVMqlvAifrmAkkkA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8zPw7rDEpsP1EfFdRhVHBunla6gthD5dpKfeHs/FdMsIKrYIiG
	U2TT5dB/vpTR+ULJFi0Qk5JO99x/fuMyvL0wzazLL4fhSIXT0PUTwk9Ov1fqDA9G5Bumj+6sIVX
	XYhbwuyrzEgX8GRtjRWPRhqCZkzdxLpO7O8Zmr469cw==
X-Gm-Gg: AZFdTZfl7SHCH0lOXfyzzL6G5mLI+S13/YJY3SIvyWcn9Q+Q4PhLVg7b4uJCkPg4CkO
	ojAYN2vO+k//n+HOajfwkKGisrHHrbqQfX0AZfpEouq5WQL2w9ZUYJ2eQD+Xp1k+1xOCodz97qR
	wtbTLkNCPJi6R/g+w1Heb7NaWUfhGIKo1iphH3HlEo/5eLA7BW82TuGhitHshyHD8rLA3dLqdTB
	JVKLC77SUR1swl47SQ59yYufAHpCxjC3CSyNefMpciVkR6YYqm3bnZoTAIPogzVPoHcwvpVlv5M
	G/ASjFV1O2sj74P0njZwIFJwOFneumXIyX/bTBCxIlI1FlrIZHVo2pypIMosb83UHKVDY9olj0G
	8VinDoJczhwuEYY2Zn7uowcc3FaEi66Hfy6l1uNrr6unGHZ2OVyRJTsXGbA1k6aSsx9f6iifSFZ
	JZReJtPpm/JnUCwo2o9Jlmz7WmXrYdgYeZ+WPkemOh6zrx5EYoBVDEejCgWmDCkQxQurEyN/qoX
	CsjXmCS6XCctbwnpnc1rHEBgmvEFBsoy6px
X-Received: by 2002:a05:690e:440d:b0:67c:6e85:56c6 with SMTP id
 956f58d0204a3-67df442280emr3979707d50.32.1795661113738; Wed, 25 Nov 2026
 18:45:13 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 18:45:13 -0800
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 18:45:13 -0800
X-Gm-Features: Aa3M54paebocmbNVntVMdO9KFEoA8PWN3oNp27JwrB7O8xF9Ll5ZA1pgj1Og6sw
Message-ID: <CAFaZ9epp-Y8efod8a7CQuQqYEjk5L_ruwP+c1SoBRPjdu9uGyQ@mail.gmail.com>
Subject: [PATCH 6.12.y 4/4] virtio_balloon: quiesce balloon work before device shutdown
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: "Denis V. Lunev" <den@openvz.org>

commit 7e17eef04600c399c7e0f5ce765da5cf9d40d8e1 upstream.

Commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
device_shutdown()") added a generic virtio bus .shutdown handler that
breaks and resets every virtio device during device_shutdown(), i.e. on
reboot and kexec.

virtio_balloon provides no .shutdown of its own, so that generic path
runs while the balloon's asynchronous work is still armed. Once the
device has been broken, virtqueue_add_inbuf() in
virtballoon_free_page_report() returns -EIO and trips its
WARN_ON_ONCE(). On a kernel booted with panic_on_warn that turns an
ordinary reboot, for example a kexec based upgrade, into a fatal panic
in the middle of device_shutdown(), so the machine never reaches the
new kernel.

Relaxing that single WARN_ON_ONCE() would only hide the symptom: the
inflate/deflate and OOM paths do not warn, they call
wait_event(vb->acked, ...) and would instead block forever on a broken
queue that can no longer complete. The device has to be quiesced, not
just kept quiet.

Add a .shutdown handler that quiesces the balloon via the shared
virtballoon_quiesce() helper while the device is still alive, and only
then breaks and resets it via virtio_device_shutdown(). Unlike
virtballoon_remove() the balloon workqueue is not destroyed, as shutdown
does not free the device and cancel_work_sync() together with stop_update
already prevent any further work from being queued.

Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on
device_shutdown()")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260624140846.2616797-4-den@openvz.org>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 726aef5be178..efa77daa93b8 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1159,6 +1159,12 @@ static void virtballoon_remove(struct
virtio_device *vdev)
 	kfree(vb);
 }

+static void virtballoon_shutdown(struct virtio_device *vdev)
+{
+	virtballoon_quiesce(vdev->priv);
+	virtio_device_shutdown(vdev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int virtballoon_freeze(struct virtio_device *vdev)
 {
@@ -1229,6 +1235,7 @@ static struct virtio_driver virtio_balloon_driver = {
 	.validate =	virtballoon_validate,
 	.probe =	virtballoon_probe,
 	.remove =	virtballoon_remove,
+	.shutdown =	virtballoon_shutdown,
 	.config_changed = virtballoon_changed,
 #ifdef CONFIG_PM_SLEEP
 	.freeze	=	virtballoon_freeze,
