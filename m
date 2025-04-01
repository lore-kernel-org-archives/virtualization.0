Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D581A7253
	for <virtualization@lists.linux.dev>; Tue,  1 Apr 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743534754; cv=pass; b=Trs6pilUPmmnm7qlBPlirI/jqHuxNOBA7YL2iq7RYW0Qj4v3FSmnM+68V9B38Ui5XwbGc0KlNbr1pepCMLnJGw03hVkafbiIBoattnZd07XfXiv+9N86siI8JhwQjejxY8Nag6IjJ4eJq3NGOWbLIfyc/OYEFe0Vno4FeRERacE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743534754; c=relaxed/simple;
	bh=bE1yAIhrEWxAlMWNE/KTyOoH7yf1v/La5iLt4FXCVTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvIRi841vXSuuoYSWOLlRl3Il6uX9EWtqWFTnzkiM63G3AYPAOB1a58fY5T/Os8ozyTBh1LuEG4NGBy2ZFF3f3EtgGMTfLdoGiqFFnexM+pWCYdbyqa6lTPwFNkVhvVIyORc8E7rJHT3RO9JkKpLxmPIfbhtkGvL5dUAmIiqA2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=AXaidp3E; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="AXaidp3E"
ARC-Seal: i=1; a=rsa-sha256; t=1743534734; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h4W51Kp9TYp3/hubl+pXq6brywk/RNHzca7dOGszEkOBVsd3laJ9Viii84/6EEs1WqGmld9sKlDx29g/2ZG+hobxsjmOvq4b1u59Y0u5S65eY/RKWD1FbwY/Vyuoy5QOxyB65N4XF5cgx1mBSNn2+QZr7BpIMtcgpqFjF+/g5NU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743534734; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PbAVbbtn4nkBDdDi/36gTKmdg2f/TMrBf3VtHNjV5rs=; 
	b=m5p9GhHjRAiAFx3hUKdbJQcL5FjbjfL+/rjEOfQ1gTsc+Xz6LLnM6VPPUa2LCMRk4mRYcUM1HqVaEpeYxXiR0Csq4JVWJ8BgkZzm2D0yRs4DEr457/Vq6dakNagpj0TgsAydLUm1M1kJPNnV8BDltqlVL73L6UAobFgcmUDKj58=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743534734;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PbAVbbtn4nkBDdDi/36gTKmdg2f/TMrBf3VtHNjV5rs=;
	b=AXaidp3Ea8r9RDl2Zg2yrG6MM0Iu9sdNhRs0G16HP4KwcVAI1PYQ1dn48+n77k8Y
	AGWGxMYemRCNqwmSHss0GisPpDzloJgJJbdLWZwCwRzTRp1sNqGiEC+OCVKlV+Mj2GV
	y6he5FQN1w7CvpA2pbN/+AJ7oDF3rf4HhrR8OCz8=
Received: by mx.zohomail.com with SMTPS id 1743534731442578.0386605740838;
	Tue, 1 Apr 2025 12:12:11 -0700 (PDT)
Message-ID: <cdb67b5f-8591-4fd8-a9c1-abd36ff5a08d@collabora.com>
Date: Tue, 1 Apr 2025 22:12:07 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: Add Dmitry Osipenko as drm/virtio
 co-maintainer
To: Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20250401130151.2238772-1-dmitry.osipenko@collabora.com>
 <l2ndn2jo2swv4unuc5r7fm3of6w3teyytpqfpgcvkdwnp3fubc@ect2rh2ikmhn>
 <CAAfnVBkMMVQVXeS9Bo=bkXQs1wG2xHMWBCwxjHxPbLkBU2upbA@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAAfnVBkMMVQVXeS9Bo=bkXQs1wG2xHMWBCwxjHxPbLkBU2upbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/1/25 17:34, Gurchetan Singh wrote:
> On Tue, Apr 1, 2025 at 7:25 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
>> On Tue, Apr 01, 2025 at 04:01:51PM +0300, Dmitry Osipenko wrote:
>>> I was helping to co-maintain VirtIO-GPU driver in drm-misc with
>>> permission from Gerd Hoffmann for past 2 years and would like to
>>> receive new patches directly into my inbox. Add myself as co-maintainer.
>>>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>>
>>
> Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
> 

Thanks, all! Applied to misc-next

-- 
Best regards,
Dmitry
