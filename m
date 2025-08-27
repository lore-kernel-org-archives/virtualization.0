Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E362820BA
	for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289964; cv=none; b=o2NAdzkor/QbFDPjaO7UeUYVSZbyNEdgOOWmltpfxnWOCNt2jhCQNLiHF7VIDqzelQ5MCNTym37rbtsPcm2/QDXpug8KmLdud7BeUnoP7YmoFbjbA7tYMyPPa8/tIIxzli6yquNP4XiZlYAeEZmq7eBdmV5tgQ2KZQaZJsoSVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289964; c=relaxed/simple;
	bh=y7lHJpJz82+fq+cmoA2Rje1ObPa1jJyCFZ+xy5la4bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GWnOLjxh9t8knwolXUcECVSr6YNbmitQyVA6y+wv7VittaEF2AygkuqTpnVIcWeUaCvHHtmI57jr4YFTPEB2881AXzrZ27Fn86BgtoOoC4hEJ3MsZe73CzXS4xrVGY3qPTMFq/i6zFrynGK5fbkuEOCPkE6om36xC1N90YktYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YErr8aUP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YErr8aUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756289961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnxDSV7VEWbUTH7IQE/IACCp8ml0MfXzZao1fPU++/o=;
	b=YErr8aUPsxVS3SRYxNvQjrxinSo5ZmP1NzJFJPa5n1YIWyFasK4yy4bo6yl7dQXE6EGDsy
	B276XaBXN1Bp+jUH69M39U/1LRHMxoOo34PLuaO44eUiCicrpuVk5ecMgY8OaSk+VoAHqO
	d6WfhoXVu4n+cfF1am+IBsNi9Owl06k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-GnhHvdLuPNu1HIOrxZlzhg-1; Wed, 27 Aug 2025 06:19:19 -0400
X-MC-Unique: GnhHvdLuPNu1HIOrxZlzhg-1
X-Mimecast-MFC-AGG-ID: GnhHvdLuPNu1HIOrxZlzhg_1756289958
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3cca50781ddso395512f8f.2
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 03:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289958; x=1756894758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnxDSV7VEWbUTH7IQE/IACCp8ml0MfXzZao1fPU++/o=;
        b=hkYc3KG7bcgKvvFp6RlEgHoV1W8fXAtKeyBiJVXf87f1F07y1Sq3a9ZzgpPVZLZgVW
         8jUdZz9gPWEXVFsxhh4Atvz+fEQh+TApZojo4Udjr9FEgt0x9UpC+YYvKuraJ3kOjcZx
         XWGwnxsioXILPMid/YtnDftevR4mQckyDJ7taHIlBb8jWUpLNzng4Jq2gQZzZ5xFm24z
         zxpkIL5Gaz+VeQ+IP274EwvfAEMzjougpTDvokzFsHNxfo0wrFpxkDbWSYBXrOu1ghe8
         s/F0cAJRJTYKqB54z9J2BLSHP1bpNmc89kKdD8LIgmKmvYPt2ZHNeVhppSEmsKlyNUwx
         6/hw==
X-Gm-Message-State: AOJu0YxByP9kL4OXjj/gHEeV2oN5uDjGzW8QOhnJlV8bU7WIasaivlX0
	FL37sJz8Ul6D6JrdbUcIiiwYvtavyC8doj3GWOb2G7piwoFnwoNAm43O7TFwYn3HCLh9AjUver1
	MZaCAfb858m62qZPM5z0QST+XH1gHhzlMim7gM/FfrpoyBR0mCWn22pZh+HnkpT59X15r
X-Gm-Gg: ASbGncshsqT8JJKkeP9qOcYGTFkSPZh3WTRdrbNGfWT4rcumoAfOMGbHlU0hSC5AX45
	ySIOAGrOjAZtzEb3bKew34Ykj1/HcE5jJ9cdBvZ4iXtSuLKsnn/3BcKJiwyWjeNo5zWR3G2gr9S
	498w2ChYQnD91mnsKVsLtOnte1SMrkzwZEPJooQOyuNhQ6EsUZRwLjASi5dviij5KetENUxq8XB
	K5YiOewNy74/1XI0GqASrR06fd4zphKrXggswqCh2dJz0XhmIMjXbbgULPM9ArlBDSscrdvvpjS
	Ow24PLx4XkQJ3DrdtAmSY/GtszjgtVU=
X-Received: by 2002:a05:6000:3105:b0:3c9:c3dd:76b7 with SMTP id ffacd0b85a97d-3c9c3dd798dmr7365855f8f.13.1756289957752;
        Wed, 27 Aug 2025 03:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnBgHJDVrf3uqIPu7fLXfZWC1O9D9UZiySAsYPd5ClZgciVjBuom+qiFTUkCyFtJ3+vfLYKA==
X-Received: by 2002:a05:6000:3105:b0:3c9:c3dd:76b7 with SMTP id ffacd0b85a97d-3c9c3dd798dmr7365831f8f.13.1756289957299;
        Wed, 27 Aug 2025 03:19:17 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711abd15asm20132997f8f.56.2025.08.27.03.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:19:16 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:19:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250827061537-mutt-send-email-mst@kernel.org>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eZ2R-ySDUuROAtaWp7zapFr_LFOYCSIExEJPgeBl9A4_1756289958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
> > What I do not understand, is what good does the revert do. Sorry.
> > 
> Let me explain.
> It prevents the issue of vblk requests being stuck due to broken VQ.
> It prevents the vnet driver start_xmit() to be not stuck on skb completions.

This is the part I don't get.  In what scenario, before 43bb40c5b9265
start_xmit is not stuck, but after 43bb40c5b9265 it is stuck?

Once the device is gone, it is not using any buffers at all.


-- 
MST

