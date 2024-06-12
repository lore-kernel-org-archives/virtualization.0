Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B016F29C;
	Wed, 12 Jun 2024 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196071; cv=none; b=YvoLWru2vy0oPxgPa3TdkMlQAJUHOO+1x4O6wbpSdmcHIqNmlhwdDUAsLO3iozXH7Rzpqmvy0MIjEumv2WlTuShjcUwwqSeoDDQDBklBorBDi9Pq3rNGD9gVZgsdmCmpBBGxhXKyBp3juwV+ikkNSER8A1fhUOCryYQ9zQMvMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196071; c=relaxed/simple;
	bh=8t9V+RAuQ307UNgRL1t8CxJDFzSaO2i9p55Z97H1iSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLjno9OkAsKqgsVQeGxN19+oldqAUW4S1iR7sra3Iwl3/TWNyvHJhQzGS6Ii+rMP5gnnDEIS0rSaAq832M7pH+1kCPaBkb+chF15XAomXkHgN59sbMjOSQ72gxCjAS2zIMuzC5cdh2GuaNgMv9dQC44cG6QMYe4mCk5Ch/xtc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=A/5sGVd3; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="A/5sGVd3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=pRy0sJWQM10IgB/bhi5G6l1DK7UQGSd130PPr57Mh4Y=;
	t=1718196069; x=1718628069; b=A/5sGVd3QQbrZi9TzZmWda2DCsSu4WcQCFj9QwkkG6b0xmx
	Zv3onSkETgPd341pc2KfX7lUmKJOw3p1YWkO+SJrtnSxxBv9aNrMpImVaDS40wCJF8HyQMa3kweNQ
	6TJk4mvRAE6xBDFUn8jhYMakbx1eX8dtlwDfQ4AHxVMLHWpGA/HPlyEABjCtxxX9i6NAOvfnhyuSV
	w/pbYPj3m7aoz95SvGFbI4RV/DtYW1Lx0dMvEweP0ydlujKa5dFB0BDiG9G/KL44QVOzAKfZrxiOM
	9rPyPWEPEwVpb7Orssb1D5Adv0aeRzvfKpQE/NzzzzKI+DFObWz1TYrAYOpsbd2w==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sHNHl-0004yB-H5; Wed, 12 Jun 2024 14:41:05 +0200
Message-ID: <67b279c7-1b65-46be-baa2-06794b47b9d1@leemhuis.info>
Date: Wed, 12 Jun 2024 14:41:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] QXL display malfunction
To: "tzimmermann@suse.de" <tzimmermann@suse.de>
Cc: "Petkov, Borislav" <Borislav.Petkov@amd.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "zack.rusin@broadcom.com" <zack.rusin@broadcom.com>,
 "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
 "Kaplan, David" <David.Kaplan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Dave Airlie <airlied@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
References: <DS7PR12MB576622398096CB650FF6AF4294FF2@DS7PR12MB5766.namprd12.prod.outlook.com>
 <DS7PR12MB57665F9F4BDF0598D7CC53DD94FF2@DS7PR12MB5766.namprd12.prod.outlook.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <DS7PR12MB57665F9F4BDF0598D7CC53DD94FF2@DS7PR12MB5766.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718196069;3e301e0f;
X-HE-SMSGID: 1sHNHl-0004yB-H5

[CCing a few more people and lists that get_maintainers pointed out for qxl]

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Thomas, from here it looks like this report that apparently is caused by
a change of yours that went into 6.10-rc1 (b33651a5c98dbd ("drm/qxl: Do
not pin buffer objects for vmap")) fell through the cracks. Or was
progress made to resolve this and I just missed this?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke


On 03.06.24 04:29, Kaplan, David wrote:
>> -----Original Message-----
>> From: Kaplan, David
>> Sent: Sunday, June 2, 2024 9:25 PM
>> To: tzimmermann@suse.de; dmitry.osipenko@collabora.com; Koenig,
>> Christian <Christian.Koenig@amd.com>; zach.rusin@broadcom.com
>> Cc: Petkov, Borislav <Borislav.Petkov@amd.com>; regressions@list.linux.dev
>> Subject: [REGRESSION] QXL display malfunction
>>
>> Hi,
>>
>> I am running an Ubuntu 19.10 VM with a tip kernel using QXL video and I've
>> observed the VM graphics often malfunction after boot, sometimes failing to
>> load the Ubuntu desktop or even immediately shutting the guest down.
>> When it does load, the guest dmesg log often contains errors like
>>
>> [    4.303586] [drm:drm_atomic_helper_commit_planes] *ERROR* head 1
>> wrong: 65376256x16777216+0+0
>> [    4.586883] [drm:drm_atomic_helper_commit_planes] *ERROR* head 1
>> wrong: 65376256x16777216+0+0
>> [    4.904036] [drm:drm_atomic_helper_commit_planes] *ERROR* head 1
>> wrong: 65335296x16777216+0+0
>> [    5.374347] [drm:qxl_release_from_id_locked] *ERROR* failed to find id in
>> release_idr
>>
>> I bisected the issue down to "drm/qxl: Do not pin buffer objects for vmap"
>> (b33651a5c98dbd5a919219d8c129d0674ef74299).
>>
>> The full guest .config and guest XML can be provided if desired.  The guest
>> kernel has QXL support compiled in and the VM has
>>
>> <video>
>>   <model type="qxl" ram="65536" vram="65536" vgamem="16384"
>> heads="1" primary="yes"/>
>>   <address type="pci" domain="0x0000" bus="0x00" slot="0x01"
>> function="0x0"/> </video>
>>
>> The host is Ubuntu 24.04 (stock) running QEMU version 8.2.2.  The VM is run
>> under virt-manager 4.1.0.  If other information would be helpful, just let me
>> know.
>>
>> Thanks --David Kaplan
> 
> Fixing emails...sorry
> 
> --David Kaplan
> 
> 
