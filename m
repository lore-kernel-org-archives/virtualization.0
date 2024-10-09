Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8D161313
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460670; cv=none; b=G7NQtk6/souFQ6O1asf3c9ocdcTzhonvoZN38Nr2+RJbe1FuYLdHCa0smd2S87QKj984+lnEEN+uRlHfesA8R30Xn3R0KAVkjuAUgbSJ+emYSbxECsKXpZE/7ngwYX3/B15NSxuatNhVvqSSlTT0RkqiiDFuiQVtiRcqbkNeLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460670; c=relaxed/simple;
	bh=4IZ9kpdlykp+ZcsHXczVOJRE1epELVCs54RvK50CheI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IU1O5L29oAg2hawTUDAZpmvUpAxrn1QpP/prreikfzRO8kdSylHopks3ONzjkn/LmSQLDjjQTPfMqhh+RKWaKMniZw7Qpv90UkTgEsxOA4cjP7Uf2qMaoDsSIIYLOIFLYMD5bfvXnQVqUpjPJ+Is31TLL+BFUvwA05G0NkiJR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZQnpK4E; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZQnpK4E"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7CE48125A
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 07:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tmxVdYXpv2lB for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Oct 2024 07:57:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F31C08124A
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F31C08124A
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BZQnpK4E
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F31C08124A
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728460666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Avzij+L+4NBcCeyDm835566DodnsC8NlmStQMnsvhLg=;
	b=BZQnpK4Esj4td6MYIWgOJYq3qfQ6Sun19FJmWAa12s4XoCxKSK9q3tQFDuZzbn7s6UqOyr
	9vCDoSCj6YtMgkWPy77KY5WRYgJZPcZ4puFgLGO4U7RXiqg22+yaWua/dOTbSAdyxFnCaj
	ha9lOmfPR2Lgw1i2kz5XFCJhMmVBppc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-AYm5-xaXOSilAGnqPy0LiA-1; Wed, 09 Oct 2024 03:57:20 -0400
X-MC-Unique: AYm5-xaXOSilAGnqPy0LiA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7ae5c847af1so912785885a.1
        for <virtualization@lists.linux-foundation.org>; Wed, 09 Oct 2024 00:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460640; x=1729065440;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Avzij+L+4NBcCeyDm835566DodnsC8NlmStQMnsvhLg=;
        b=vIgSPZh34lCYSEwy0lXV1W1/O+mGXOAsySVQyoQB7TmOLRNA1esYY51aElIyhPUVmW
         sMbImPQgkniw3FUygKI4gYNbzC+l/tz3h2ViXPHJrxVEDQHMpHjU6LJmpaZCu7dFO/A5
         flEalAaZF4DZdFZPrNGVVFN2t5R/kBiUu6upO04UIAGch0HMJgifV9NgmQHDLCRGYJl2
         9Q9Wf7CcqqKERJ1db9V5IRA/gpYMu843f4W5h66JEj8os7njeKGsoh/xRsckGjc6FHqe
         wIn9YLkgliIv3bt9K1R8yKzQg0Xh/2WGNqqDJ1gkjctK1AB5VqA11p9MfDq+luwDNMSv
         SfLA==
X-Forwarded-Encrypted: i=1; AJvYcCXBdoGUEiGWXDjCdEN9uwMzayTgyeC3jd5988Q/Vd5CLsYRmXUZN07sdLM0KBNq0JLTtwaJ9Q86Gu2iyrOysw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw3AraUJd0q957Kq6l23FtJnLnhquvqQUX6Ok3USwRKuFI9Jk79
	2OlXd/8KS/4DZmF18txflKw+7035QW4AJ9vHSQat1HdDuHPU3TteDbNO2ZvLw6P5bdpGxnSZzyu
	5n4gZ2UY3Yu85D/CnfBlbdRIRexHV6eeGKLNdmqqd5E7ZWMNxwkbjUFkyTvZ8S86xA9QE/uCgOQ
	95x7M=
X-Received: by 2002:a05:620a:4509:b0:7a9:c333:c559 with SMTP id af79cd13be357-7b0874a9a24mr209132885a.48.1728460640222;
        Wed, 09 Oct 2024 00:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESo0NmZIHT1z6RekNTQiUjGY/96nXVPyjFU/Gy078glQMkADkOM4numum8sa85/IUGjTMTBQ==
X-Received: by 2002:a05:620a:4509:b0:7a9:c333:c559 with SMTP id af79cd13be357-7b0874a9a24mr209130985a.48.1728460639838;
        Wed, 09 Oct 2024 00:57:19 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75615aa2sm437290585a.14.2024.10.09.00.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:57:18 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:57:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, 
	michael.christie@oracle.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
Message-ID: <d4h4g7txswidmpau5i6evvnragzzgtbxgoelorcolowweb4qjo@ujevaic3uzrv>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-2-lulu@redhat.com>
 <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
 <CACGkMEt-8hdiAaAPjNAPNSNtBFHK+ogCndHFJMtYpjEzoTK6Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt-8hdiAaAPjNAPNSNtBFHK+ogCndHFJMtYpjEzoTK6Qg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 09, 2024 at 03:28:19PM GMT, Jason Wang wrote:
>On Mon, Oct 7, 2024 at 9:31 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
>> >The vhost is now using vhost_task and working as a child of the owner thread.
>> >While this makes sense from containerization POV, some old userspace is
>> >confused, as previously vhost not
>>
>> not what?
>>
>> > and so was allowed to steal cpu resources
>> >from outside the container. So we add the kthread API support back
>>
>> Sorry, but it's not clear the reason.
>>
>> I understand that we want to provide a way to bring back the previous
>> behavior when we had kthreads, but why do we want that?
>> Do you have examples where the new mechanism is causing problems?
>>
>
>The main difference is whose (kthreadd or the owner) attributes
>(namespace, affinities) would vhost thread inherit.
>
>The owner's attributes tend to be different from kthreadd, so
>management might be surprised for example, vhost might be created in
>different namespaces or having different scheduling affinities.

Okay, so this requires some API to allow the managment to understand how 
the device vhost will be created.

But why do we need to restore the old behavior with a kthread where the 
resource accounting is completely disconnected from userspace?
For the old managments that don't expect this?

BTW I would suggest adding all this information in this commit, in the 
parameter/IOCTL documentation, and in the cover letter because IMHO it 
is very important.

Thanks,
Stefano

