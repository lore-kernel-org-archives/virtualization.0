Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8DFE571
	for <virtualization@lists.linux.dev>; Sat, 13 Jun 2026 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309417; cv=none; b=GRUrTxmY0FSUFlp3nncgk1OenyiQ2ExQ9elqvtm/FM1ETfrVd2dnccNqasZnP9zSl07btyUlTiczIGyg8G1ufDw37jB6rgtmDWfD66NV9SpJL1+kcWGWaFuHd3KvIM+0/pnBTd8fzBjZh9Mybkdn0xyVamRCl9wwdvUdXBtKJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309417; c=relaxed/simple;
	bh=c0Q49lpbntXNXsuLl1k74yDPvD9eCdJopUkpac70rjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HZjbgvRqpbrvCORmUGdOyD+8Cca6xVoYrMDyNCp1wheKM1ziA9Et7Pyo6K2Ikq0nGohb9pH3I4FzMNAGgsvhpsp5vyypRGsNcKkyMLb2Da3LyFmKFR+9LSkAgwX2661RDSW+CLsBcxgzXLO87Jg0AUvzFPxEbE41ZsYCWMearIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9renn0O; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9renn0O"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f24dcedso1714651b3a.1
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309416; x=1781914216; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kz/YGgUT7Uc36MorqsAsmMwEDPJGbRICV4QU2IwdKQo=;
        b=v9renn0OASv5P+dnulUzs0haA2j8ZGqMlE8sUfmuTkYNvI78/7uEALO0l5WwiWaau0
         yOu6l6qr7CJ3zA/vCMVO7smwC/nd+5oIvymzxah/iHDKv3yTc96oXLvy9dS5uHNZg827
         S/k7c/HDftGgw9IUfbSbprSLfVDae0BzKURL87aQAdlOL0TpKTS2/IlDdI9KnmxHFDNh
         jc4pWDt3SwzDswI2ppk2yRT/RRgoOIJenefqI+GyKY/1bx3Oyz9o0z9LtgdP6iSY7PjV
         FEKv+sKu/3BAdJFGZyCp04conPoNGAmCMeHp2twMQPqYJ4ndoVUvXXB+NyXs1WcfS+8C
         ADyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309416; x=1781914216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz/YGgUT7Uc36MorqsAsmMwEDPJGbRICV4QU2IwdKQo=;
        b=dhS7xxvGusQnkUmNmAp6MIlQ5yZfp98LPyFjLMOFcbHSLMjMzTxOn86Wwt9ZfixQws
         LXv7csP3ueBjVwK0RHVykWws6om9VcziJv9Fww8zJoferwx/+aqJaeIP4rsB0jzAhCT/
         poHfsPVfE1cBqf1gcKN11CK/G/owNOTmdXKAP/N5MujstbqJxLA+hz3Gj/u4qBISaH+7
         J78sq4vNSyt7bjTH90MpaSikbHNCC/KOHjU1BPrxVz5sqsmtH0Y/ssLgEWgRuaFgegYk
         qw3mQd85A3n92+O+L2J45mAonSG7gWa4ukVO42984f173zI8ZQoY8754M93s056k6opj
         MWtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bYjMA/bYOF8evJkpBuj/NoMdXgnzp0/KlypGzr6j7M9/W14ezr3mGbv2ZTA7U7bQ5cJ0zuDLP7AOH+QP0xg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOlZiWGuaE+qsb+jMWNsMU3qhSjDYniPI/V9FkcmypqpOloTfv
	xx+wvKA2G5FShPLQO53Gn9x34kO/VbCQoexi0VKHA0/M37E+AMKPzz9OPEQWlM7kkNih1ShbFYd
	Lvw==
X-Received: from pfra26.prod.google.com ([2002:aa7:8e9a:0:b0:835:3df8:d72])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1404:b0:836:3f6a:3e77
 with SMTP id d2e1a72fcca58-8434cd4b0abmr5407830b3a.17.1781309415402; Fri, 12
 Jun 2026 17:10:15 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:09:52 +0000
In-Reply-To: <20260613000953.467473-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260613000953.467473-1-tavip@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000953.467473-2-tavip@google.com>
Subject: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Export iov_iter_restore so that it can be used by modules.

This is needed by the virtio vsock transport (which can be built as a
module) to restore the msg_iter state when transmission fails.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 lib/iov_iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af73..067e745f9ef53 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 		i->__iov -= state->nr_segs - i->nr_segs;
 	i->nr_segs = state->nr_segs;
 }
+EXPORT_SYMBOL(iov_iter_restore);
 
 /*
  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
-- 
2.54.0.1136.gdb2ca164c4-goog

