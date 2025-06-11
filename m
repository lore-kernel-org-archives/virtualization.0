Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB42D541D
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628262; cv=none; b=rEG1VtiCY2P/hHs6NQReKDCT0kT+ceBkLeCOk4FFsD9avLKmKbVrdEx5JOJXqyaYree+NF95WJBh/on8TBEnk6FBCwpG4w70xcvrYtqVTJCkyFCu7IeOjSIZIsfQ2ayxjhNd//pwZZmW4kWxulySOuINVZQbIwEFy40mNDpN0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628262; c=relaxed/simple;
	bh=5zLr20a+3RMq10bavAeuj+N1S3OiM13yEW5G+e+YVgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n453EzSGIYrY4D1enYyW+2ouTPgIWSQdYUGaMsGWzRCh1SpqLUAd6Smg8hxORx80KRseJ1gOXVf2j6NL3r7BIs+INBt3l6hNw0rob1o2fwHqqN8EFZaVQHjIXymPsxWtj/5rnR6im7ybbquCYQ4KQnzuxzMELc5r3vCKnCaEeiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAvRPTcX; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAvRPTcX"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0EF7607BB
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 07:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id muVnTaJnvCYD for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jun 2025 07:51:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1198660727
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1198660727
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LAvRPTcX
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1198660727
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 07:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749628258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0YvNJY72YPNytizyINf9m6BS42PxsRIt0OwIHT6goXE=;
	b=LAvRPTcXkQOaZnzC+JYvy79P6Zwt1AhSTb2e8yQuAFxxdnAgPIO3CBsOVi5gDoiPH0oIwY
	nKs8IUqyOzFZGgIXqDBUjTMLsZcRJXFezy89B47JbzO+FECtbxj1LhhCnwmhjSGDJ8/Mu4
	1so/bMmbTnAreaJbBZ8fVrrM1D/uKyE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-ApVnwgdPNdyZhYGwL2JBnw-1; Wed, 11 Jun 2025 03:50:57 -0400
X-MC-Unique: ApVnwgdPNdyZhYGwL2JBnw-1
X-Mimecast-MFC-AGG-ID: ApVnwgdPNdyZhYGwL2JBnw_1749628256
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a585dc5f6aso138417601cf.3
        for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 00:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749628256; x=1750233056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YvNJY72YPNytizyINf9m6BS42PxsRIt0OwIHT6goXE=;
        b=h09XfTlcfz5j+4r/3E9m4U8k+NO2bjx71piOJHYyc2cmn9z1XbnBM76RE7x+ZaSJwe
         SSFcDcggR2WfdJgcMgtV7uB6sLlq4S8Vfg6qVJfSojkkHOFPQmV8GIGbyg7SEnmKHVpz
         DDDGytl7KqaECg7cNFZke6I4Pg9YFqwfo1a2IDfCdQnVavOvGdgO3ktKDj96dVx7n5ys
         2XBnLkwaug70DnfDsEApZq5Oam69W12Goq6s/1O8PUO9+WHHDTq79u2AsJRFv2PzyISv
         RfpjwJrkJcYvF0u5RRwE/GKO2KS61zkicxA9ka54PkLrWzEEKuzJahfRT8EfByCADOwk
         oW8A==
X-Forwarded-Encrypted: i=1; AJvYcCVI4YizOjpG6o40iFQCuqpQaJ1BpFNoeZrmNQ2uM/hzDgp5zs++DPgCWbHJp76PMlUY2vcNzPZmR1tvZgHbMA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywvc4qvQMOaiOKHu5PquOA+YOsc55LdNIua5mbuA2n3z30Cq8LO
	L8e5hfaqbDGhw4i5mY4ApkLOyzQ5qaNtI4iXgexUpMcLeH7Bhm6kCTcIl0oQFAacAzjsAGVrHAi
	EBhSwWFIIBF+u5dPuB49iNtod0ikYyDvzzjkdz4EoYdtVjGJvlU7EHBi5p2KEw2oZdMTeTrATdy
	6UWrO2NYw=
X-Gm-Gg: ASbGncsURQbL+go5o5KOXF5HrchqsDTpzXKEY33YYqlEkl53vnxkF9yosjRFKy+qIye
	zWfnoiwRsYGHX2GZ1FGJzIHhTORH47sDWSse2oPy8Zo52lpgsVlILt4rUMhMbOhenUOUqN8Mm/I
	OjuYPvbmsl4jNzT2yWifoy02YVp1WPlO1k8rGrjKhfD4++GzPkJ6beCup772gzLhUA0f8sRsByT
	pQ9dkLCrMBTR4BHCFcDGIxmadzGYuNh19l9GiMRjlrJoVLY2bM5Rdqw21gvNDB4XJk0ny7YOlNf
	rOXqW4Rr7m+NYflTT1Xq4/7Rp8s=
X-Received: by 2002:a05:622a:988:b0:4a6:ef77:3deb with SMTP id d75a77b69052e-4a713c5eb2bmr38977551cf.40.1749628256432;
        Wed, 11 Jun 2025 00:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmqDemiqiS5qeDSOYZIKIfZAYFvzYuafCBh5KXUhqyROiO7EVozBqZBoaz7q0w302HM70QzA==
X-Received: by 2002:a05:622a:988:b0:4a6:ef77:3deb with SMTP id d75a77b69052e-4a713c5eb2bmr38977371cf.40.1749628255996;
        Wed, 11 Jun 2025 00:50:55 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.145.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61116b831sm87356651cf.22.2025.06.11.00.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 00:50:55 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:50:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: michael.christie@oracle.com
Cc: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] vhost-scsi: Fix log flooding with target does not exist
 errors
Message-ID: <oudxv7fw7jziowituwevjiah6ow6is6y3fmnbcdfkz5mkgoyuh@qs2whsn7kbit>
References: <20250607171815.111030-1-michael.christie@oracle.com>
 <7hsh4exxtfbeu2h4zvt2bptunezs5ppaeqep6gkn7xkmpu4y7k@rb5wfwqaembu>
 <051e7185-5fd9-418b-92ca-807418e88ae9@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <051e7185-5fd9-418b-92ca-807418e88ae9@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RYfvtK1S389lDsku0iKzY1GiHbaQaJDT5beEuY8GLNE_1749628256
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jun 10, 2025 at 11:30:58AM -0500, michael.christie@oracle.com wrote:
>On 6/10/25 9:18 AM, Stefano Garzarella wrote:
>> On Sat, Jun 07, 2025 at 12:18:15PM -0500, Mike Christie wrote:
>>> As part of the normal initiator side scanning the guest's scsi layer
>>> will loop over all possible targets and send an inquiry. Since the
>>> max number of targets for virtio-scsi is 256, this results in 255
>>> error messages about targets not existing. When there's more than 1
>>> vhost-scsi device, then you get N * 255 log messages.
>>>
>>> It looks like the log message was added by accident in:
>>>
>>> commit 09d7583294aa ("vhost/scsi: Use common handling code in request
>>> queue handler")
>>
>> IIUC that commit just moved the code, but it looks like it was added by
>> commit 3f8ca2e115e5 ("vhost/scsi: Extract common handling code from
>> control queue handler")
>
>I saw that and was not 100% sure what patch to blame.
>
>Your commit adds the new vhost_scsi_get_req function which adds the
>vq_err call. It also hooks the control queue handler into it (control ==
>SCSI task management like LUN_RESET). With just this patch we don't see
>a problem yet because the normal SCSI command handler is not using it yet.
>
>My commit hooks the normal SCSI command handler into the new
>vhost_scsi_get_req function. The SCSI command handler calling the new
>function is what hits the problem because it's the SCSI INQUIRY command
>going through this path during scanning that hits the problem.
>

I see, thanks for the details. If you want, I'd expand the commit 
description with part of this details, mentioning commit 3f8ca2e115e5, 
but keeping your Fixes tag.

BTW also this version is fine by me, so up to you. In both cases:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

