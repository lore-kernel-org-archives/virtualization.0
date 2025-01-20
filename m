Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2C1FB4
	for <virtualization@lists.linux.dev>; Mon, 20 Jan 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381188; cv=none; b=OXHCOymCkMCtdP5uJevQpXCZIdtIHg6bcBfuVPjbfCq8XMq2rbBo1e8A5UJFH3SEjMeAmY+wUF5v3ncdS3hKLoH26/Uyb+8hkKmioTbRIBnLAmElDKpyp4LcW4m+CPubi9aNisORSEjgMYcTdkSoagAz8jCyq/mjA/qGc9GQBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381188; c=relaxed/simple;
	bh=Vura6+yciQTZ2zNGl8kEIKSnHsT6BHXQZI7yah00L58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvFNZO7n5mBUFauXsL7Is6QD3/FakDDEwO8dWitmddIUO+nsylcpZ9N0wULXVSFwvztfFf9w0sh5ghHcUUvcDFjfkoo/gzjzY62Jen2/lVirw1ob5vmciYfvXw3qD/df6y9GrQFlPlaXeTdsJD6vOcwZr0OwaFTekpdGQz1VONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THa5BJXL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THa5BJXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737381185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOWOzVhXBnkVvqPrieOu4AWUxRmbQl7knuwuCl48rK4=;
	b=THa5BJXLByOVZwo9ELHvzeVFvPiIXwxOVo3JeFSNzKoiEqekehuuVDhTu+LALvg33ACpOX
	/DSBqo6zQB/zWMz1QQ4ePYH/h7myvKCl879MMhxt7mRXY+/8887MkyKPndEsCVZoADj4si
	PX/o+eLmJ8JfIcYbTykxYrjP2yLk5q4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-dfCp3B34NtyGuxQeySGN5g-1; Mon, 20 Jan 2025 08:53:04 -0500
X-MC-Unique: dfCp3B34NtyGuxQeySGN5g-1
X-Mimecast-MFC-AGG-ID: dfCp3B34NtyGuxQeySGN5g
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361a8fc3bdso23446465e9.2
        for <virtualization@lists.linux.dev>; Mon, 20 Jan 2025 05:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737381183; x=1737985983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOWOzVhXBnkVvqPrieOu4AWUxRmbQl7knuwuCl48rK4=;
        b=w7Nv/t4b3jM1E06dMlOrQkzXe4IsUShHzK5tx2uv441m3PZ7BvSFi8aGVyjC4vWDLb
         7nOwTo4Pz1zzdSWvrhYfOGoZKyvRpJ/a3165P0Bvo+6ZjwKl6DtJrD7fRgJg72G/OeMe
         4MhVDUuZ4VGALj0P6c8SgkHDGT9fPZoMShtYS7o+bMjeoAStbMnnEI/bMhM2mtV9kEMK
         ciStnn4t92bnDM4+76+lLC4qKV5Jfn96oMOI+9yxWgg61t1r1UMfDxzKml/O18BVSaua
         Icv8xacg1xuweQkOJgnNnjvgF40l/R5hTB5sEWjrAtqONorumrkLq4ZWkbe3lXnlcfP/
         bEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+St//pkzfLxlqkbGIeOOu1zGWYq1rbeUot0sfuq4GLvmL+438Li7QpOccEZCON9B7ViSpuAWPvGBr5a9icw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoMYM/fVO1JlBGkm6wFOunmeC1br1nBLhiWo6gFKkrxIWfH0ff
	teYCW16LkT1qYOegK7Wg+zHbHc299RR7/YmMmmMAqKX3xZLbyEhzljfidSc3xXLLDm6Axog2IRH
	o26ui08NrKcNEW81oqPFp5nrRwBAydMghvBENT/CqSshtUfxxHdd40DwmhsCn8h/N
X-Gm-Gg: ASbGnct5DIMPBjZR3fnjbpr2Q7ZBb7vRLz2vct6ycA1oQaqPR/AOXYObfIhwrv7WVCk
	6oNmm8VMfDtUFkcqypbWmJ2TXKg4WuvdjffXDEXikzfBAmrCUbjPxYKJOle3S/PPVU0nCiHSw/W
	uo/jLnRH/FUiMllk669IBkKV2lZj1uyOvOpR0au/wKRSz/rltlN47bqCbpVc0zPDxvU2Y8wTwL5
	FpaScWYlgechJRfMMWSCQzk962YWi4Kb6DKCjDjy3eWwroGO7RqpWexO4u+Q5xSyNf2YV5lJeEN
	sMcUrSahORxdy7+FjgQGlBGSiNZXKzMZHTWAWFjw+A==
X-Received: by 2002:a05:600c:4e4f:b0:434:f767:68ea with SMTP id 5b1f17b1804b1-438913bf92cmr143732805e9.5.1737381182740;
        Mon, 20 Jan 2025 05:53:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrgov4Y1tyEzzjnnH/8SXJtEJ9mBMJdAZNTF35upcrbR4gJ6ayYDavrclh41utO/0Yrmoztg==
X-Received: by 2002:a05:600c:4e4f:b0:434:f767:68ea with SMTP id 5b1f17b1804b1-438913bf92cmr143732525e9.5.1737381182375;
        Mon, 20 Jan 2025 05:53:02 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221c25sm10365602f8f.23.2025.01.20.05.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 05:53:01 -0800 (PST)
Date: Mon, 20 Jan 2025 14:53:01 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Harmstone <maharmstone@meta.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 mst@redhat.com, kraxel@redhat.com
Subject: Re: problems with virtio and microvm in ACPI mode
Message-ID: <20250120145301.012f7e25@imammedo.users.ipa.redhat.com>
In-Reply-To: <a02be605-7aa1-4d31-bbb4-835dc3948ad8@meta.com>
References: <a02be605-7aa1-4d31-bbb4-835dc3948ad8@meta.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s3tGLcJz_6ghjxYM4cwsDjkFLQrqE6iROl9F8own_RA_1737381183
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Dec 2024 18:22:39 +0000
Mark Harmstone <maharmstone@meta.com> wrote:

> Hi all,
> 
> I've encountered a really weird bug when trying to run the fstest 
> generic/476 in a loop on a microvm VM. The block device is a
> virtio-blk-device, formatted as btrfs.
> 
> With acpi=on, it eventually grinds to a halt, and prints a hang message. 
> I tracked the problem down to be within wait_dev_supers, i.e. it's 
> apparently issuing a write for the superblock that never returns. The 
> strange thing is that with acpi=off everything works as it should.
> 
> acpi=off adds this to the cmdline: virtio_mmio.device=512@0xfeb00e00:12
> 
> acpi=on adds this to the DSDT:
> 
> Device (VR07)
> {
>      Name (_HID, "LNRO0005")  // _HID: Hardware ID
>      Name (_UID, 0x07)  // _UID: Unique ID
>      Name (_CCA, One)  // _CCA: Cache Coherency Attribute
>      Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>      {
>          Memory32Fixed (ReadWrite,
>              0xFEB00E00,         // Address Base
>              0x00000200,         // Address Length
>              )
>          Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
>          {
>              0x0000000C,
>          }
>      })
> }
> 
> ...and to my untrained eye it's not obvious if there's something wrong 
> there.
> 
> Does this ring a bell to anyone? Is the bug in Qemu, the kernel, or am I
> inadvertently doing something stupid? I'm happy to help someone 
> reproduce this.

on the 1st glance nothing looks unusual,
CCing Michael and Gerd in case they see where it might break.

> 
> Thanks
> 
> Mark

