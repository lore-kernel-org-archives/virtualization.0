Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675620310
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 06:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721887359; cv=none; b=q8tYHgyUqssP8ozx6h29fs2WoQ0mkCquc8Tu/P+aXAlM0unJTGZs0cKugtzevEjQesyUrQrFQ90vyDFfAGaGJMYFujvVGZFEbDewHxJHf2CiLriR0q/RH/g9P4HgL0S4LRDJReD49GxwZi/M0gCf88IQ3L4Out1jnBy5ZLxvsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721887359; c=relaxed/simple;
	bh=bJxhMwX5MN4PZYqh4rjulBy/TefzKfENjWcr6rkWqiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TLELFGQqf/6DJNC1PnKcjQPMf//OglZq6zLcLX4MVqDXD+NR+1QyHf6Qas7zVnKE5+sVorv8thnK6MMdqENLuOCLyBux21piSr2f4wc71KG6lbn9vXYcVyThIACy+TkbTO5nvu7XmIDtCsi5Sfx67jb4PJQBiw5WPU/r1y3llRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGuJpEzK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGuJpEzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721887357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yq+ONMd9WuBlCAQ6A6Hc1Ir9vZzuTQX8vW2XHjRZ4n0=;
	b=ZGuJpEzKAo5H+cYnCNqXKjGNCPmPh6f0g3xwHZsAKVIO+awwR+vZIc/NA36a8BqkPtBAdX
	bXriEr0Y94lyZdzwZFcEsu1hnIDX37Ku3bSE51puqF4RUwtaHzW7xXFBP17elDpePemJZx
	jvJySGG4xcOxUdySFdK/rXtS4cwTu1o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-3-w6yXNZPdy1PpERdnQa6A-1; Thu, 25 Jul 2024 02:02:35 -0400
X-MC-Unique: 3-w6yXNZPdy1PpERdnQa6A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-426724679f0so7402495e9.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 23:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721887353; x=1722492153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yq+ONMd9WuBlCAQ6A6Hc1Ir9vZzuTQX8vW2XHjRZ4n0=;
        b=D9MkT4Ev801Xc/G0fnKUVKeWxRzCTbYjv8X5/TYA8MPp8lVgJV5G+vKKFWYhfJ10O8
         nA166dZBX/GKCaIBMpJWPRQktEWNYXQNrVfywpc6b3V1F7bVUoqRBbO8HPZ/bwZZFMwc
         QF15FTdMIEaPZCpse3E/iF6Bx6WXYlmuM/3l1Rh2DzhHGboLpWai4Kl5gHGBn6VspfkU
         E4yLjKahZtCcjEHg0WN+xeR9W1xr+tev2D2KMxgtKNS1Uwa6kWy4+QCe7GQgHjk7hcgC
         Eg7j8jOcLFfzXK0TCSxZyMQYAIMVLCjry4Z9LGfncs3M+wY6z8dA+OcWS+PwzfxbOURW
         WpnA==
X-Gm-Message-State: AOJu0Yy/eCnrHtjezsAHq2DHF9/kHw7C9UYycj0ftTRon3l/OYxZFP2E
	Tdrh4JCUFe5v7OTeJEjzNoIiFKV0mV1MM8PrX8eQ5CUHOCs5KByb3fHPQLu9vvD+ptmf+FrotDK
	59ynA69xJP6KUl+H81bafqfuzCzgRJ0gUVHp7XTXpgVrvggD2oJ1nN7Kvy4zpIo8vDyqrXfZd
X-Received: by 2002:a5d:6087:0:b0:361:e909:60c3 with SMTP id ffacd0b85a97d-369f6680495mr2752772f8f.9.1721887353403;
        Wed, 24 Jul 2024 23:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwqVue5Mf6XLgGkmnAaJRjvXMWBBXUCN0k1VxemVnDKPTUE1QnlrEiRusOCjOhpbbVx9j0yQ==
X-Received: by 2002:a5d:6087:0:b0:361:e909:60c3 with SMTP id ffacd0b85a97d-369f6680495mr2752746f8f.9.1721887352812;
        Wed, 24 Jul 2024 23:02:32 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:8427:35e3:731c:3106:ee46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42807246ca4sm9364315e9.11.2024.07.24.23.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 23:02:32 -0700 (PDT)
Date: Thu, 25 Jul 2024 02:02:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
Cc: virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio: Fix various coding style issues
Message-ID: <20240725015833-mutt-send-email-mst@kernel.org>
References: <Zpn9t5xJCPMhvpZO@fedora>
 <CAJaqyWfU0th74hJ3Vww6QXqewvSyOobgogT=Vt57M+HqaTZ0ig@mail.gmail.com>
 <20240719140906-mutt-send-email-mst@kernel.org>
 <ZpromZpQ7ajhEJHB@fedora>
 <20240724100022-mutt-send-email-mst@kernel.org>
 <ZqE4P1EjiLI9iQj-@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZqE4P1EjiLI9iQj-@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 24, 2024 at 12:22:07PM -0500, Juan José Arboleda wrote:
> > Makes backports harder for little gain.
> > Code gets tweaked naturally as someone works on it.
> 
> I understand your concern about backports. However, this patch only updates
> the coding style to match kernel-wide standards without altering behavior.
> Consistent style improves readability and maintainability without impacting
> functionality, thus not complicating backports.
> 
> Thank you for considering this.
> 
> Best,
> - Juan José

checkpatch keeps adding warnings, they are there to help patch
submitters especially new ones. It's not a holy script and there is
little interest in rewriting all of kernel each time this happens.
As contributors start being active in a specific area,
they will tend to also adjust the style to make it easier to
work with, and this is fine.

Thanks,
-- 
MST

