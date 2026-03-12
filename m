Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817C3F54A2
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351774; cv=pass; b=EA6e4KVtUZuYyQRtA9ylg4dMW2ulgZdrV/t9GbiDe2VdBUAelolIgLWiQi5Lqwb4If7MghA7WaSXpRURDwN32HMZbeiVDDwBQhWZXrc8LSTdpRbHU1ibSDPI7VEHqOLINEqxxVX62L51DCaiTXGh1mwqtzsqwEk2z9y0OLqfeKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351774; c=relaxed/simple;
	bh=E/0Q1PrTA27sEodrUrpVDvKc4d/yoWXHBz9v8xXtnes=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nlwJg+UquO60NgkBP2hy6rEA5RlKxka+AYVwqMncitl4KEm+d7ZJ5P/CR9yfWFvM8DMp/dslrIY9/eSERPGl695lRfklxIODlAdlvwR0hMQWk4D/DhZj/IoLyLqHsRw7MH1Ze+PIfWET7MghsBudDT6jpw8ta6dH0ARr5Z/z67U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgG7C+dX; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgG7C+dX"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-46701f2077cso2129725b6e.0
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 14:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773351772; cv=none;
        d=google.com; s=arc-20240605;
        b=M8nW4D04dt0WrV8NW4Nt80rsRbmFAifTBYwZFIkiymxxWquiiooXGo5b9SbiqESTUH
         +KqlXBMZnUGLG5MQPcAojc4d1dop2ZCTwbgBZSD7aub0OStLitlQ/sCubw/1YkG99rxL
         KtzSlzoDPX1G7deMhaFoUdGEPGYOk7uJ1wAiPwDZ0q+0VRvQqR+YNqMWdGCn7bmFcz3S
         qGlWvXAZuqoQTJlHruF+Dg8zJnEM1bsXaln0OCHADG0yoxLwE2XOfN3wceIqTBGrIKrk
         4SRHjYcWSrUf9CKClvQ1QZJyiihZ10aipw9Om1O3PJc9bhvvd7a6q+NTUxIx1HO/Laqz
         N9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/xoeXzzp8XgrtrV67WeyyhcRmlvHOjFX0f3SI3cL0Js=;
        fh=y8lVMgusNXAmR4P598sLa/NdOpr64KpfzBZmUVkivew=;
        b=TavXJUxaHxH5cAPkpWylGoR55jlzPjadzoPS0C8rnVPDTFmrxxRF0eI3n7Ho1i7/XU
         GICd62wWF8g3ptErnE5l3vBvgrkGySoBkjv68OJtqynMHl9lcAX2VyLfLETdU1aQZ/h9
         9+3OYq/XA9tU77tkCP6xYvztuzJUVcON+wXPcI/2iB750BF5fZQWIxyvoh4zfnJPP73s
         GXnEy2sx7v/sHESEy2HQTVYycTYuuj88GViaFHZ93ItkfPQWphTC2A4lHBb7kxoNdWZY
         Ta1q4opln/2lg6gx02cS0tcex0r+a5x1l9NWtnZPwdP6YfJjCwSLpK1G0yqCR6i8oDeF
         IQaw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773351772; x=1773956572; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/xoeXzzp8XgrtrV67WeyyhcRmlvHOjFX0f3SI3cL0Js=;
        b=kgG7C+dXNKBAOMj062U4RUnvKPO81GkUE4gUapASS4HYa0HbewAIdgSIX22635H7QY
         V8GrPxZgps8EMWgONkQM2STmeVlb6faZ+nVFWsUPE9/BKThnCw+jXQ/urUL8lufE0eYj
         /iI/dagjhFHMRBILSl6zvayhZ4OISh1fRbBK7n9QY/nbBnFqXeHMM+4+nmoID1Z4bPea
         6Y7qVQrizV9XuX6eOX/l5n2TDXCoXOhdfUk/b4QngbJJ2dliX54tNoRBItqviPX5tKv9
         6Vj2HmkapOG4aDmdCkPTBUtqqzEvBFysmb13hqTCOoqS252ZNWmhWtuYlL0YEr2MiZAy
         af0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773351772; x=1773956572;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xoeXzzp8XgrtrV67WeyyhcRmlvHOjFX0f3SI3cL0Js=;
        b=LeqH+ksD3A6c5R9SesyzmJRQ//bCHQqeE3j7knZhnlrgk/UyrBrS7MlQMxD3VOxjsP
         EoqOMjFMnE5NymWLkZxEMmRp0GkQzsbxN6T8Q+hoPFsJi3INTUewaR3bglLjiFuhjY7D
         xfQXLz34PpLzczeUbBAvFDLu03Tb26kX2IzopPSvjwqFvGil3bmm3i0m8c7j+Efi93wo
         iKkAjZNyP0tftHeOwnUC1565an2NX23O7PiY1uzbXRvfqu+Dwsv/uT+hJISQ2QlrzKEj
         ooVKKVZkq7WiTVQjVeU7/bVjlN3A6F6JkRlh8pkFHU8h/9itHtPUJn6uETjTUJHL60tf
         U7kg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ688qqYdmHpWb4H1rAQsBvL6sEHOXBZj09uKJ+nky3T/+kaRpL+UfIjF01KsG7Zw6nkZ2bCjGrar1eAPEvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMDkkNZcHBpIDhWr6IimXmrtdesy8HzdsWngV/jQSntryGXlH7
	9dWWLj+h7GMtnLpd/k/7HjqMX4oV5hcEuR/x84b9yZODk7ctRQMOzYDuz0RRIi82p7Vz6q2WgG7
	tXi71jZRVghI/xQXkLvQ070RM4rJrv9I=
X-Gm-Gg: ATEYQzxObHDuGvzDybfW1KhTax3jvxiys3oqP1kOJOuf8keZWDsQTjtAIF8MqM7+IxE
	lP5pPObiyXc4TLKMaOZ83JIkbtSnHcUEae+UWnB25CpPyjAuWXS8lkaXDA7/V8cW9+xbLYi4sa0
	0a7OTnAeLiKAuxKOAWLZHHMUhroJ7ZQJk/qZ9ruDAuGDdlnO6yA9beZP7Mxw4B0ZcKwPO/y0W8I
	98csmUOhnsgV0ewXacolhw4FcSosHg8YfH4DhSFvfOXz2b7MIlU3nvSVW91rZKSHZ9odaTo5JMu
	PAKN45hlLxSEMp3SO9YBQp3fHOfaRZLQ2V6074eETvcImgP/Cv0us2SqzKn3iAlyi6D/qgI8Cny
	/VqfI
X-Received: by 2002:a05:6808:2223:b0:467:f85:d81c with SMTP id
 5614622812f47-46743205855mr2575481b6e.20.1773351772310; Thu, 12 Mar 2026
 14:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: John S <xaum.io@gmail.com>
Date: Thu, 12 Mar 2026 22:42:39 +0100
X-Gm-Features: AaiRm503XZ0ng5s11KqSPzO0zG44I8_tVkyXYuPbiZepavVF2j5k0SiHkDwNk9E
Message-ID: <CAAZVx9_Tq6afZJb-4pNKCwmB7xw=NZVCR8aSXM5N9+BbDdmTtg@mail.gmail.com>
Subject: [PATCH] virtio: add kernel-doc for map and vmap members
To: mst@redhat.com, jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document the map and vmap members of struct virtio_device that were
added without kernel-doc descriptions.

This fixes the following warnings when building with W=1:

  include/linux/virtio.h: struct member 'map' not described in 'virtio_device'
  include/linux/virtio.h: struct member 'vmap' not described in 'virtio_device'

Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 include/linux/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3386a4a8d06b..fc7940298d4b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -157,10 +157,12 @@ struct virtio_device_admin_cmd {
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
+ * @map: the mapping ops for this device.
  * @vqs: the list of virtqueues for this device.
  * @features: the 64 lower features supported by both driver and device.
  * @features_array: the full features space supported by both driver and
  *                 device.
  * @priv: private pointer for the driver's use.
+ * @vmap: mapping token passed to the mapping operations.
  * @debugfs_dir: debugfs directory entry.
  * @debugfs_filter_features: features to be filtered set by debugfs.
  */
--
2.53.0
