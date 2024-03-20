Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21451CD1D
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932041; cv=none; b=UvNvnF3mu636jz1qcNSQluVBOcoAjeaNCeo+F1ecNZ3e6qNX2lCMY4uzeh4LVY4UINzikAXJcn+Fka1ll1Vmcsb58x2fkpKCaxpbq4kur9J6VNuZNVh4lhrVTUEkGYH21WWfZTEcHLVrpr8LaDBJU2Ns31rEk+WOizTTW6rIYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932041; c=relaxed/simple;
	bh=hpima0NrYAV+sFRtWb4NnEJJV2aVW5wrjXhYWO8saB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aZD7cZ/QWNmEaDmGxRM3LY789GYRqjioLkD9NL3cs7Rt8esly2Gun5/Cx4MF5gMrom53z7JtmuwaW9urPpc0ylkJg+wvYsgUJNzb8KRW+MtLm2DetlQyl3NrrFJHMyCWOK9IiF7TlVmoboNu2S2cgEI8fYKEwZfHjy41GP+yKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5t5KMRF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5t5KMRF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710932038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpima0NrYAV+sFRtWb4NnEJJV2aVW5wrjXhYWO8saB8=;
	b=F5t5KMRFiyt1XY4HB1M8AQ1UlusbKkYHh5XdnPiA4JhhDMMzwUEykw5ypvEtRRYQzQApVo
	mBPtmuExMCfhj1ihCjUYJaTJKnBIUk1sxb+K+tN26iRBpIZsj0bBo9kYAkcPce5JZnQ3ir
	7CxCis1ytJ7wh51/VtTkNA6fh5TajoY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-vpi7EGkSOCaGZf42QTO8Sw-1; Wed, 20 Mar 2024 06:53:57 -0400
X-MC-Unique: vpi7EGkSOCaGZf42QTO8Sw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56b7f548d3dso1643332a12.2
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 03:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710932035; x=1711536835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpima0NrYAV+sFRtWb4NnEJJV2aVW5wrjXhYWO8saB8=;
        b=j0MyBjuEnLOh78jy0/Y0oJUDd2mmVD0qtkHV2O3UxoRFVMIOsB8S0JTo9Xo3yINEK/
         MHu4lxKNV9J/UqQt2Sw5bN9CJPx7eQLqLIc7QMgrGJYxSFw3Z8S+6e/0mI/VfbK+bJ0R
         d2JnB4OiMuvEMVgEBtyDdpgw6yR8e9m2BZaCNsU4RgWF8Y+oLMD9QZofYpejep9CaHWG
         eJVmlQvu6NFJO/Vk9UAufuKixYoxOWZmdT5qlrCE+1TeVu4mkpwttmqNmRB1FdiES0nJ
         jlRxGEs1wCN83ghNoU1OEjSTFYX5MkIGq/I0h1OHnZjJRpBov9pmjoob4SiS5diFAWqQ
         Lgkw==
X-Forwarded-Encrypted: i=1; AJvYcCVDETdOlAbPLi3+vT2pFXbhDN1QWsmxWBpfeCWuEPY6OwrAobyuH63mGhksbwLI1VFHxD14BbRPvn+RsxSUqAVMz45ruPQBRP40i/5Zk9s=
X-Gm-Message-State: AOJu0YxTjWGbx1TRLNdOJ4d0Td0/JgpVjDae821MVx6gV1ka3+F48uLQ
	P1eSILA+C5dLD+OO/anlo4m75PzJXKfOVMruKipdvSvb6bu4jEaBqyBxoLdcp4/X6Qp4gjV746K
	PzZ+YXqX12XuiOqDkb9Br5xVb1V9BqQhwB/bfyXwYbgy4PEBATCHIgBJaBb+Wc8Oo
X-Received: by 2002:a05:6402:4284:b0:567:1221:d486 with SMTP id g4-20020a056402428400b005671221d486mr15823950edc.33.1710932035452;
        Wed, 20 Mar 2024 03:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCxWOL8qcRB8x+JM0lPEQty5dwz8rq8KoJCYy8GhMCjU8ipsRKsJfuivfQB9rya5QMZFfIcA==
X-Received: by 2002:a05:6402:4284:b0:567:1221:d486 with SMTP id g4-20020a056402428400b005671221d486mr15823939edc.33.1710932035147;
        Wed, 20 Mar 2024 03:53:55 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id cq28-20020a056402221c00b00568addda0d1sm5794895edb.45.2024.03.20.03.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:53:54 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:53:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 00/10] vDPA: allow userspace query virito-block device
Message-ID: <wc7i6ordm2wiz3gpodg6zyqc2mhzaleh5wwpgg5mirwlqgzwky@freilztxryfd>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <ktoczf6fo4ta54lsrliawcdhjuy65kedfnrqdx7w7qlvybje3n@cbb6e4upeu7t>
 <4d87dc97-9ae6-4a23-8fff-c9f688045105@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4d87dc97-9ae6-4a23-8fff-c9f688045105@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Mar 20, 2024 at 06:31:43PM +0800, Zhu, Lingshan wrote:
>
>
>On 3/20/2024 12:49 AM, Stefano Garzarella wrote:
>>On Mon, Feb 19, 2024 at 02:55:56AM +0800, Zhu Lingshan wrote:
>>>This series allows the user space applications query vDPA virtio-block
>>>device inforamtion.
>>>
>>>testing on vdpa_sim_blk, iproute2 output:
>>>sudo ./vdpa/vdpa dev config show -jp vdpa_blk0
>>>{
>>>   "config": {
>>>       "vdpa_blk0": {
>>>           "capacity": 262144,
>>>           "segment size": 4096,
>>>           "block size": 512,
>>>           "max segments in a request": 32,
>>>           "num of queues": 1,
>>>           "logical blocks per physical block (log2)": 0,
>>>           "offset of first aligned logical block": 0,
>>>           "minimum io size": 1,
>>>           "optimal io size": 1,
>>>           "maximum discard sectors for a segment": 4294967295,
>>>           "max discard segments in a command": 1,
>>>           "discard sector alignment": 512,
>>>           "max write zeros sectors in a segment": 4294967295,
>>>           "max write zero segments": 1,
>>>           "read only": false,
>>>           "flush command support": true
>>>       }
>>>   }
>>>}
>>>
>>>Please help review
>>
>>Thanks for this series, and sorry for the deleay.
>>I left some comments in the patch, about the virtio-blk config space
>>there are some missing fields:
>>- virtio_blk_geometry fields
>>- writeback field
>>- *secure_erase* fields
>>- virtio_blk_zoned_characteristics fields
>>
>>Do you plan to add them later?
>Yes, I will work on them and will send another series which
>also addressing your comments for this series

Great, thanks for that!

Please put me in CC in the next series.

Stefano

