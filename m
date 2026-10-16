Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BDC31283E
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185935; cv=pass; b=DvrHZr/q8Rv0qzQ181YsDyusRanATXm1li0om0lKtAi2ZWq3YhN3TYualH7Xgc/lalpGJaDC2eMVN8XmLhEaA4fMSp2wpc3IDj1Wlfawr5oMTzMTmDRni3CvL1DppFVmZoJK1nx/7QqYEK5SC+OvAREr6TmpygImn5ydctaLemY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185935; c=relaxed/simple;
	bh=LElthuPsn/7TYpPq+R+k0wJNUaoxQUU4pHFLIVdSMGY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kPVVf4kuvUFXa9dDVcYA3vqA+lxyR1Y0nicljbM8oiQGgKabiG5FTo9JEwm9s1l3RsPBJ4C2XeCzV8dJIrvNqz0AbM9r+IM8QZU6kNkoh1x8tdc7pfLJTcJY59zZENj6l0aFOg+wz4hsiFZ0b8kHE3o1lnHKvfys7MQQddvLBDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2zaOdmu; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2zaOdmu"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91b8b456dbeso4367966d6.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 14:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792185932; cv=none;
        d=google.com; s=arc-20260327;
        b=RmSHDJh/UDYBPkTbKEaUj6HyA84xSPohDkniHYBOiTkg1E8n3Ldn3+M7+fYY3bPDAv
         7lOmsothOltyb9vn3HI8gZY3PBrYqwznliQTEEC0LWGxw16OO2uETDMoKuD1C1kWysbk
         XkBtAtiVpGBtRZqtGvzNTmd7fuUFDrnnLlImDgCDx6GjdQSMclbgl21e7+xIrHxzo9d5
         mBWxiJh9DINUJcWL7vSD4e2RvfHDMBZehrsKfqMYihJnQSF49mFnByxB4iVio6rhALff
         EkpwnYLvy1IvWMS7TJnt/o3b9V4AtmX5LKhifzOGT5mcBICVkb5XC9DYV+k3aVlmmyer
         bboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8ayVjMNxSu57uj3PmVl8DsCWHmYuapevpS1NhYOtLbI=;
        fh=ewyel11ujbCy6l/tQDaGwc5bnkxKmVZ7JltiX+Nruw8=;
        b=XOlm1KXZJQoqdIJXy/E/JYLzd1sr4xl7XyBnZknAIkdR3K71lLDI/6b0Ug8HdLbbCI
         5OKLVjU5a/T4E67IoRVXqzDy0WTqVIo2ijhpRyTigjEtWUMgovs/hZiJpAemL97izx9c
         Q4VsgBU3BgqDqx+Z+4yTgFY5FTdyMvI3eJl49DB62+aXTZ7YpYfhD0VCY9JoOWU9/4Ov
         lR6UgoWpudYyEmpTveRQa31CjTlG2UycMjBP9OhVRMCoVSrtvSwdeMAr7/YyCT/Pe+zA
         3cLEXIU4TKaAntkIYM0ZecJYpa5TowEuV7ecCt4h/oN53wN5qFqIqSUvu8KQbQaqRcXP
         EMpQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792185932; x=1792790732; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ayVjMNxSu57uj3PmVl8DsCWHmYuapevpS1NhYOtLbI=;
        b=g2zaOdmu++7mGB0CUqxt3rmlNxBDDALLkH7b5Tp9KC1HDxLdKsJ5ENH2SAo9vFmcGb
         /FMEZ9Mf/lZ5dVkATHKufsrIPYHZ7j5UWCUpwk0BmVT2HePC4lKG5se9mxNP11Hljc2s
         0cnNMaih6OnaSy4sUO7jNz3nZJXBGdV3PHFNqnMgFjmdDyhwXWuoJR2RHX5f+Cq9+ydZ
         2LxU/F9+VxSEKYhzKaaCAhvaqahSRlp3Y0KTmo3s8B1yVhW/0mDEt1dP+k/gZMhOiNAY
         S2nlpDAkb/LuaTd2YW0M7SLbXELApQHqvGJ2yLC3PcLdBHiPmcMM20M8t6Vr9pxDju29
         qi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792185932; x=1792790732;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8ayVjMNxSu57uj3PmVl8DsCWHmYuapevpS1NhYOtLbI=;
        b=ZU3DNCAb1BjqNhTsVb3tkfLbjKbv4INc9HjCzTeW2mVcidHvZNjCrnmJcBCwvsknU4
         gIEBDaVDdjy6zN7EeggOkWaIVFJG07Rh1eI/bEIeJNeD2LSQe9W/J0hF8RQ3Jht6rNo/
         qmPiVt9JnKLQVWk3jrKtRwU2W/2cS9k/p5x90LPNPOPz4U6jpq4+WC+Kc31BdmqpeeNO
         RXDUhWmmfZdXhnpjswW2WuU//n8+X0PsQ2QU/pBFPYpyQ2Y0BS6S1mLqqR7cgnaB2FQr
         UP3y23t9TQeWZ/1spHF69HJSOT0RnD+pVGiXi6lNyI70HkvjUOGI6Wp9glHY0gIlJgNo
         8YaQ==
X-Gm-Message-State: AFq9FYKUmf3WQtQ634y3YgL4Sj0v6JH/swFd94wiUZlZyJHziQmPNmr2
	d+7qx157zyH6CbCFhJf8Vid5vyBh9z0/yfKc62nUQyo0XGFRGChItQf+tIsCUhnNU8cItdVdU8v
	nMD75nZx5jWVuecBxyIyl6VDpAqZ6lQk=
X-Gm-Gg: AYBFou3XkG0lb5Qc3ALEmkmJMv4j7cT93vrCtXkdeLo2BW7HlEFJSnkfp8VSW0Wi6Lx
	v5VnJ0AMXN18A/C58KhQxVPDJICe3scj4XBCDpp17zXzchFD1EBCtFWLDYSAceCb7s5g4+zLOUW
	OwWBEFP2cQ7CrTuevrNAc3gGuCTBISCc8P7yMSOf4ach3YLvttyqWGIKK6h2iwBR27FNi1uYW2k
	P4s+Ums3Wp2T/f6WtDCjjgz8Eo55Z6/KD+844RQFHCnNnZwZf0PDUhh+xo5nANmOs10SgBmT1pz
	hzTu67+XPPXPlZyLME0XbcMdBFIqKdcr2H8BglgLRb2AX8myoz/B
X-Received: by 2002:a05:6214:5f0f:b0:91b:8272:5157 with SMTP id
 6a1803df08f44-91bdec17542mr24685236d6.2.1792185932246; Fri, 16 Oct 2026
 14:25:32 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 14:25:31 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 14:25:31 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Megane Hebo <hebomegane@gmail.com>
Date: Fri, 16 Oct 2026 14:25:31 -0700
X-Gm-Features: AclHuK9pmWtEy3zQyyEKGrHhE1l95osK04juwr-0ujtfJxacEl_f2hsKY5beLWE
Message-ID: <CAJPVW+=TP73rBavAGTJVqXVN4Uer6JwOi210+2V8nDsH=H=BcQ@mail.gmail.com>
Subject: [PATCH net-next] virtio_net: validate csum_start before installing
 partial state
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	willemdebruijn.kernel@gmail.com, habte.yibelo@gmail.com
Content-Type: text/plain; charset="UTF-8"

__virtio_net_hdr_to_skb() currently installs untrusted NEEDS_CSUM
metadata into the skb with skb_partial_csum_set() and only then checks
that the resulting transport offset is beyond the minimum network
header length.

Validate the raw csum_start first. Successful packets are unchanged,
but malformed metadata is rejected before it can transition the skb to
CHECKSUM_PARTIAL state. This deliberately does not replace the broader
ingress validation being discussed for virtio checksum metadata; it only
narrows the state transition at the existing check.

Link: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yibelo@gmail.com/
Signed-off-by: tonegawa <kiyotaka.tonegawa@gmail.com>
---
 include/linux/virtio_net.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd00c..c8180f1222f492 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -102,9 +102,9 @@ static inline int __virtio_net_hdr_to_skb(struct
sk_buff *skb,
 		if (!pskb_may_pull(skb, needed))
 			return -EINVAL;

-		if (!skb_partial_csum_set(skb, start, off))
+		if (start < nh_min_len)
 			return -EINVAL;
-		if (skb_transport_offset(skb) < nh_min_len)
+		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;

 		nh_min_len = skb_transport_offset(skb);
--
2.51.0
