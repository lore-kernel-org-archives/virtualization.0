Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26307463B61
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142929; cv=pass; b=NfxtU+pVkAl14i4k521iFMVD2Lfhmy2oIyOib7m0HsDtjQRvoghUmT+lXU0iUl9Sc/fEGPkao2m5GiJXDiGgg2RTvWUWoIf52T3WANZikOKND0nRJZlYNxwLhO3sOFSh/N/Tmxl2+QctrD1VR9+v29UdT69bBYlefvX79hOWq9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142929; c=relaxed/simple;
	bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmygdeF2XO9CUSr/fPzLPN8TEgEuk6ppp+ERdlHbxg5PrkQrriAcNyjIoffGC4ZiSnyZhy2nbNMxvrEtgRgoohd2ggdzHB/MwPfkHIPzwaGiuPTZRntKyT9wE+k2coG9NepXfNSXkbHlkWRYi3CTMQzjSJ5Graal8fRqnPLIgG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fXewYDXg; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fXewYDXg"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35d7fa491deso814568eec.1
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 02:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792142925; cv=none;
        d=google.com; s=arc-20260327;
        b=TzuEDC6rhuvjLyACyzE8tCVIp5RnDNsxLZvSFmqwm5+vQgNgWH5D5SvWvqmTSYbnF+
         lKVANIa3NI2HT1Lb1PS/J6HuCCrOXNGVorj7KyxYIsm496hR9KOInzsRb+5xZkFPdepW
         C46rC7ZBfCKFelNEi0Lsz4GTm6QqiwKi6dQ12JuScnDmU1NvoN6nBPWZd9UkISHWFFTl
         3hXoEAOOe5LloJqTfCze4yZvHT5pxqhTHgtww4F7F/xbxHRpE8FSpthH8PrEIbhOX921
         R3m9j2/WPWY9KhbYye7fGq4jSmbrLNF10HS9DX3+8CfpIz7qqG2JRGfbvn3Ytie1unFg
         3hNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
        fh=taM8Useer69M3BiRW+90uzPLZ7ZA/Dh3SA87hllb/Qs=;
        b=TbDZdb3FydYvI8sY46sx674em1NYMZ5KCXn4icW1tNEKXYp+71O+3PaV6YOZVfY3qU
         cqlfNgCToZsaWsPl5yZEpe0uZCYAwYJP4gTirMr/LY+hDuxRxlHRP/52GqM/zmeA9iB1
         DcF0+hbaXWFXpWkvKgv+ggCJos8oMIz+UaHkuUPCHpBB+Bg264dNz6KFPOSwHZRfG2KK
         CnZzgDj9fW7IbdheoinaxcvvMqiBlz0HYElVjy89ExPJ6FbVO8XrdLrUNWAazBh2KwHR
         YYIErN7NfiLL+2GLHdaoYFiJ2WqK2txDj7CZW2agi2BZGWo+jzNIoHEX4YargIg/TF6S
         +ZFg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792142925; x=1792747725; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
        b=fXewYDXgU2oAC5jOK8hs+N5e54PE+MNs6Nkg5q7fMCwrDRM4lg7rV1rnZXIQQtxV7T
         j573af6XS4WoMfLBvypyRjohIgCvnTNWWYUqf50s7Bj/4mYnrlNdlTzURKPGTRzD2mXX
         0wB5M/UQ3LCdpVlM9i5gISTAiJxNYzWFBjF+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142925; x=1792747725;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
        b=11zErppwyqvik80jsp/rNiXh/PjlkdgOSp5okMbWohSTLFVfwTj6cqT8s07V8/+XC1
         1fg6oJV+EZAW/Hjn9Ei70g/N9SVe14kmKVZ5ZXP05dvtcXWj8LJ3VfKnP4YWKnnJxLYY
         c0YAQuCsFRNJYFFUMAkYRFUWBd7tXzdK+KTmR1tkYt4Y7uM3GeKLoaSED2arx/O/phrV
         wNGy8866agonZdoaMB7qZhB9Dke6P2PkdEGg8zgNq215XIRyQ5xRRW9r3Vr4tW6FL2Dc
         ecna/WxHw9n2zM8ezJB8kba4db91FeN/tZxx04qhaeS2yazAq7ISquYOfbqDsq/kTkh3
         rH7w==
X-Forwarded-Encrypted: i=1; AKwUvBzMPg92UL/VETaKfP9txUGo9ydkOixpmCMPTODbhRwXQjHea3JU+IqESxZx31XIbf8d6stM2ZyUb5TPQyaCbQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLcdjCokKzj6+zefhfukdKbv554SXeUNEyN77RLL/hoLJxwEHeJ
	3wxBQ71lAa6vaqAfNI84nhJ/gs8tk6Dbru/oUPxKpQLM8PcvT+N6SqeHgFf7A/dK4TqVKlduAzn
	IW4G4PaV/EC5jFhZGZkQYlP6Zd24ZixVjf/w6ol73/g==
X-Gm-Gg: AYBFou0bHiWqt11004KjoGkLcpceELbKiI6xLMltY2ZHOFKDfe5hDuV2UWF8Wqj0V71
	YSYw3Zvg43kBfYxlIOwB3msgm3q1jS3lNleLTbOVU5RxG+a4h2sWHhSg2XeldAHJ+yVxLY9BmKq
	d145NG78yzPuPdUxIx2Bxjn9Rk+fzAUlIbZ0GarYxSJTUadKskaj8aPNvm4pP4tOY7K/9pzpzLu
	0A5nsuszWpW6qpluBbAFi2o7LzLMvTY7rycz3Bz64sgi/l7SZMPeTBEHXsXNQkksheX5QIiGMZj
	4R9KGlNr17R9LRDyM6XIUysgfiDPjsPTJYyJkWbPx0FgNLg7B6mq9sInR9YdVGF3fo7N2XnD4PH
	XwenL0qA=
X-Received: by 2002:a05:7301:6f0b:b0:353:7f47:8168 with SMTP id
 5a478bee46e88-3602e69d2a3mr3111663eec.17.1792142924976; Fri, 16 Oct 2026
 02:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260922081318.321686-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260922081318.321686-1-fanwu01@zju.edu.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 Oct 2026 11:28:32 +0200
X-Gm-Features: AclHuK96WMdSHWqen9On0_lt8gWo8BgW6QbnTyh16O2fTHfi3XWjbb_9a4MR3Lg
Message-ID: <CAJfpegseUy1_sw-ZY2XQQLY3ic9ifs+ar3GsxtyY90OASXu=yQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: gmaglione@redhat.com, vgoyal@redhat.com, stefanha@redhat.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Song Li <songl@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 10:14, Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> The vring size was read after virtio_fs_find_instance() had dropped
> virtio_fs_mutex, so a concurrent virtio_fs_remove() could free the
> virtqueue first. The reference from the lookup keeps the virtio_fs
> alive, but not its virtqueues.
>
> Hold the mutex across the lookup and the read.

Applied, thanks.

Miklos
