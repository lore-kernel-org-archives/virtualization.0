Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14F291C09
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 06:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751525241; cv=none; b=Tm4G26cWch/aeKjoDmY/16s7wS277xahDhIGZ9SAEg0p/DV02uDFBn+z+fHMZcrXCAj5BHLkJoQM4UyiP0d0dxDOP2TAxu9O+x2Rreera1+s8shIMJ19XHYbqxo350ZC2rXa7HubXEJnMnb6H4l18udkBe8DFlZJgqgRY4REeBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751525241; c=relaxed/simple;
	bh=MSVutCCp67jaY9kTTe08eiPHGQOT0pg75lPz6NOjG3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qCJGvQZWB8GNGJT1I2JvhrdhTlnq4nJ21j90/fm1YLqKxLopJrJ2Z1jN4wA4HzIs9mNX75AhcCHV31SEkH9tls1RgAwfYh/NzyGpH/Lixevbxi+5g3pif83DKILmIqj7mu8seNi9FgZVR9bb0YHvTj+N3htQaSOk9Jm3Zn8Su58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cu39d2qM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cu39d2qM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751525238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvCXgPzLxWjP91HmSWgq6BOmNgwC2NN0GTXYEMSPt1w=;
	b=cu39d2qMy5MfemL66ObfFJvxMbptQcovKoqc0HGi0csurTZG4PJEFhfQ1PH09XhRgHIoYh
	5AP2tmbx6VdQXYclgMNqxNwUsYCAbgITr1hZhLJiQhxokK9EAJZuziRWgFCWkOIeGGb8xl
	YZkvmkES74oGIR8VZqpkfD3Kr9ARC2Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-P3rgXNYEPNC3HoxXcHMxDg-1; Thu, 03 Jul 2025 02:47:14 -0400
X-MC-Unique: P3rgXNYEPNC3HoxXcHMxDg-1
X-Mimecast-MFC-AGG-ID: P3rgXNYEPNC3HoxXcHMxDg_1751525233
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso2514846f8f.2
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 23:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751525233; x=1752130033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvCXgPzLxWjP91HmSWgq6BOmNgwC2NN0GTXYEMSPt1w=;
        b=MFSaFENHr1rlvZRxsD05Ebk/dhXtEp+93n+IBvf1j1hXwGLsnh1eXs51qIwmOmUdkU
         BcEnaOrSiSaDYAodXxHrcQX7D0S2mu7ZVVVukdn5DvODem2ZOCKGuNqU5ChbyJ4dlMAW
         AztactbU41MCUomi9Qsg9j9MQvgjwwzqmcwkV/0K2INvIv8yjz4S0lcTofsOOwvQlTU0
         RGRfmouKUay9D4M3huY05e5zW1VBvj8FGdWpxOO1t6RUSy6JJLSAmfi0kPIo9g6ntV5b
         bvwqCers2K9nHOIPMWM3BI+btIHiWiLV8w8tLQLJcLUqlxWmrRp4K+bbjNYOny72MVzI
         uozw==
X-Forwarded-Encrypted: i=1; AJvYcCVzpuFkcw1AtSTZiB/XOWQd+amApRxRQc1ZYjPfZf6QWTLM/FcfTyQSnN4jEyBcumTl1Wk133TXoVWAZbXvOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1noNMLSYmTgv5kXZjsOtJ4UmSsRBLEChVc4iYqxnShyg0nh5o
	d+4ZHPAZgUorNiCSno4OJ/39sTIosQVr1LTjWhobsl1dhOccbgIg5ywHXeGdY82nP7OUieZyhWS
	ZtaT8Mn9KKhJ1KK+jmtj/pfzOVl5Al5XbOG7+nhYl5b3bh3NQyfS6jfc64cqTBU5CJ3E+
X-Gm-Gg: ASbGncurWXgfbim1BIHACkaMWQ9BbZRiQojARisBzsM+FaMcvRNuGAutSDFo38HQ16q
	t3ik+Gt5E/lxeTTriziXurqnCZYR3D9k5OKbL7Ov4X9Zdk7/3rpt+HpgO0kZ+ggDj9/dfJgahz2
	ad3k5yaF0sZ8W7thYwEIgPv+GsYKgDcznv+vNdskDx8Nw3mg4WvLK2R2RRK8VGAr0IQsggkx2Rh
	pIHHn1dg615gPlnd//ng+VDWmH2KNnY1X0ZGph9uZyNTZSBczo95FPFKkoQnlOjTLbYTfuFViuw
	mpI9GdXfMhGI9/Jj
X-Received: by 2002:adf:e19d:0:b0:3a5:88cf:479c with SMTP id ffacd0b85a97d-3b32db890f2mr1220493f8f.30.1751525233368;
        Wed, 02 Jul 2025 23:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbT6IWeRb9RgSnX0sKCNwQimpT2cnxiegS1Oig52G9mAPuoHSVd+NrN0XhRxJEKACcLqYEiw==
X-Received: by 2002:adf:e19d:0:b0:3a5:88cf:479c with SMTP id ffacd0b85a97d-3b32db890f2mr1220477f8f.30.1751525232944;
        Wed, 02 Jul 2025 23:47:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e6f74sm17766578f8f.3.2025.07.02.23.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 23:47:12 -0700 (PDT)
Date: Thu, 3 Jul 2025 02:47:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wenli Quan <wquan@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: Host Crash When creating a vDPA Device with device_features
Message-ID: <20250703024601-mutt-send-email-mst@kernel.org>
References: <CADZSLS0r78HhZAStBaN1evCSoPqRJU95Lt8AqZNJ6+wwYQ6vPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CADZSLS0r78HhZAStBaN1evCSoPqRJU95Lt8AqZNJ6+wwYQ6vPQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7IgqxHOY6n73z6eCpFnoISRnx-ddc4uYsVqVSS8N2YA_1751525233
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jul 03, 2025 at 11:58:26AM +0800, Wenli Quan wrote:
> Hello all:
> 
> I am reporting a issue where the host system crashed when attempting to add a
> vDPA device using the command:
> 
> # uname -r
> 
> 6.16.0-rc2
> 
> # modprobe vdpa
> 
> # modprobe vhost-vdpa
> 
> # modprobe mlx5-vdpa
> 
> # echo 1 > /sys/class/net/ens7f1np1/device/sriov_numvfs
> 
> # lspci |grep -i Mell
> 
> 61:00.0 Ethernet controller: Mellanox Technologies MT43244 BlueField-3
> integrated ConnectX-7 network controller (rev 01)
> 
> 61:00.1 Ethernet controller: Mellanox Technologies MT43244 BlueField-3
> integrated ConnectX-7 network controller (rev 01)
> 
> 61:00.2 DMA controller: Mellanox Technologies MT43244 BlueField-3 SoC
> Management Interface (rev 01)
> 
> b5:00.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6
> Dx]
> 
> b5:00.1 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6
> Dx]
> 
> b5:03.2 Ethernet controller: Mellanox Technologies ConnectX Family mlx5Gen
> Virtual Function
> 
> #vdpa dev add name vdpa0 mgmtdev pci/0000:b5:03.2 device_features 0x300c31829
> 
> 
> Then the host creatshed, please check the crash dump in attachment.
> 


....

Thanks a lot for the report! How reproducible is this? Bisectable to
a specific commit?

-- 
MST

