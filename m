Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F8446436;
	Mon,  1 Jul 2024 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828154; cv=none; b=maDOaQMVBefIWsMhXx1ytm0sCd5CX2O8nQZtY67J9u3sxVhkh1U0h6sLHtiQRdsd7GTRRRr7T6hoDFyIvLkZ1zXBp6xScyt4hsqwJvwAwoTmDQ2jdwxDxSNyEKA1TTs3R1NoPqe3MeSCBCVO1HF+Xa93ExSp61wv9yG8fUVEeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828154; c=relaxed/simple;
	bh=qpqOlNCc6pE+Az7x1zOSWa1Hy2UVVKTtKCMN0PvJV2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYIe7Ku8J/Lvw/3rZzMZXXGn/8A1JgAdqxgKH34D0hXEOEzGqNF6K6oveaPP3w63vhCXF+7PZmsfr8DJWjXUzjCnXSPi4uIkPrR+Z44SNSszwxrt1RP5BCBlS4BEHQT2e1gd+6LJvkZGp1fTJEyTvrZmM+V1IR+Q0xUwh/umgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=A6X+9638; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="A6X+9638"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=DJ9+LxV54Ieb6gRSrHFlDXvJdhuQToWOdrkYwkWiAjg=;
	t=1719828152; x=1720260152; b=A6X+9638Ee5F083A/4TnUMgo2C6rHZSIH062qgydb+xzkYN
	P1fNquUmSUvWkdGzAB2jIPDgfo7kQaWFCPkHeK7EdYvD2tbFRGUFatoqiAAAqkA2dl4TSSiPomCU3
	6+Kc/lp1tcTj3a77P++OiuK0tRCpOIti8jR3XwqwpHp5omH9RjAqHSxknS4JkGFqri4wrF3DcDHJB
	osahfQd8pQhKVj+evon6Vbn5jE8vy9MJ3EBzzrbY9608qpVkAbUsUTfIBYElXA8ztTglV1M38w+Sp
	nwnvFv3aQaj2eCFCfHrg5nkCzUwqCcygiYcjgP/sR5Yv4spJ/x0/I8zRBgXrHwXg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sODrZ-0007Nt-U6; Mon, 01 Jul 2024 12:02:22 +0200
Message-ID: <e0d95288-17b4-4286-8084-95f496603ada@leemhuis.info>
Date: Mon, 1 Jul 2024 12:02:20 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] QXL display malfunction
To: "Kaplan, David" <David.Kaplan@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "Petkov, Borislav" <Borislav.Petkov@amd.com>,
 "zack.rusin@broadcom.com" <zack.rusin@broadcom.com>,
 "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "spice-devel@lists.freedesktop.org" <spice-devel@lists.freedesktop.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
References: <DS7PR12MB576622398096CB650FF6AF4294FF2@DS7PR12MB5766.namprd12.prod.outlook.com>
 <DS7PR12MB57665F9F4BDF0598D7CC53DD94FF2@DS7PR12MB5766.namprd12.prod.outlook.com>
 <67b279c7-1b65-46be-baa2-06794b47b9d1@leemhuis.info>
 <ab0fb17d-0f96-4ee6-8b21-65d02bb02655@suse.de>
 <DS7PR12MB57662053B081FBD62213016B94C22@DS7PR12MB5766.namprd12.prod.outlook.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <DS7PR12MB57662053B081FBD62213016B94C22@DS7PR12MB5766.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719828152;8b6a32e2;
X-HE-SMSGID: 1sODrZ-0007Nt-U6

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Thomas, was there some progress wrt to fixing below regression? I might
have missed something, but from here it looks like this fall through the
cracks.

Makes me wonder if we should temporarily revert this for now to fix this
for rc7 and ensure things get at least one week of testing before the final.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 14.06.24 15:45, Kaplan, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Thomas Zimmermann <tzimmermann@suse.de>
>> Sent: Wednesday, June 12, 2024 9:26 AM
>> To: Linux regressions mailing list <regressions@lists.linux.dev>
>> Cc: Petkov, Borislav <Borislav.Petkov@amd.com>;
>> zack.rusin@broadcom.com; dmitry.osipenko@collabora.com; Kaplan, David
>> <David.Kaplan@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
>> Dave Airlie <airlied@redhat.com>; Maarten Lankhorst
>> <maarten.lankhorst@linux.intel.com>; Maxime Ripard
>> <mripard@kernel.org>; LKML <linux-kernel@vger.kernel.org>; ML dri-devel
>> <dri-devel@lists.freedesktop.org>; spice-devel@lists.freedesktop.org;
>> virtualization@lists.linux.dev
>> Subject: Re: [REGRESSION] QXL display malfunction
>>
>> Caution: This message originated from an External Source. Use proper
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> Hi
>>
>> Am 12.06.24 um 14:41 schrieb Linux regression tracking (Thorsten Leemhuis):
>>> [CCing a few more people and lists that get_maintainers pointed out
>>> for qxl]
>>>
>>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>>> for once, to make this easily accessible to everyone.
>>>
>>> Thomas, from here it looks like this report that apparently is caused
>>> by a change of yours that went into 6.10-rc1 (b33651a5c98dbd
>>> ("drm/qxl: Do not pin buffer objects for vmap")) fell through the
>>> cracks. Or was progress made to resolve this and I just missed this?
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
>>> hat)
>>> --
>>> Everything you wanna know about Linux kernel regression tracking:
>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>> If I did something stupid, please tell me, as explained on that page.
>>>
>>> #regzbot poke
>>>
>>>
>>> On 03.06.24 04:29, Kaplan, David wrote:
>>>>> -----Original Message-----
>>>>> From: Kaplan, David
>>>>> Sent: Sunday, June 2, 2024 9:25 PM
>>>>> To: tzimmermann@suse.de; dmitry.osipenko@collabora.com; Koenig,
>>>>> Christian <Christian.Koenig@amd.com>; zach.rusin@broadcom.com
>>>>> Cc: Petkov, Borislav <Borislav.Petkov@amd.com>;
>>>>> regressions@list.linux.dev
>>>>> Subject: [REGRESSION] QXL display malfunction
>>>>>
>>>>> Hi,
>>>>>
>>>>> I am running an Ubuntu 19.10 VM with a tip kernel using QXL video
>>>>> and I've observed the VM graphics often malfunction after boot,
>>>>> sometimes failing to load the Ubuntu desktop or even immediately
>> shutting the guest down.
>>>>> When it does load, the guest dmesg log often contains errors like
>>>>>
>>>>> [    4.303586] [drm:drm_atomic_helper_commit_planes] *ERROR* head
>> 1
>>>>> wrong: 65376256x16777216+0+0
>>>>> [    4.586883] [drm:drm_atomic_helper_commit_planes] *ERROR* head
>> 1
>>>>> wrong: 65376256x16777216+0+0
>>>>> [    4.904036] [drm:drm_atomic_helper_commit_planes] *ERROR* head
>> 1
>>>>> wrong: 65335296x16777216+0+0
>>
>> I don't see how these messages are related. Did they already appear before
>> the broken commit was there?
> 
> No, I did not observe them prior to the broken commit.
> 
>>
>>>>> [    5.374347] [drm:qxl_release_from_id_locked] *ERROR* failed to find
>> id in
>>>>> release_idr
>>
>> Is there only one such message in the log? Or multiple/frequent ones.
> 
> I would usually only see one.
> 
>>
>> Could you provide a stack trace of what happens before?
> 
> Here's the top of a backtrace when the error occurs:
> #0  qxl_release_from_id_locked (qdev=qdev@entry=0xffff88810126e000, id=id@entry=262151)
>     at drivers/gpu/drm/qxl/qxl_release.c:373
> #1  0xffffffff819f5b6a in qxl_garbage_collect (qdev=0xffff88810126e000)
>     at drivers/gpu/drm/qxl/qxl_cmd.c:222
> #2  0xffffffff810e3aa8 in process_one_work (worker=worker@entry=0xffff888101680300,
>     work=0xffff88810126f340) at kernel/workqueue.c:3231
> #3  0xffffffff810e6281 in process_scheduled_works (worker=<optimized out>)
>     at kernel/workqueue.c:3312
> #4  worker_thread (__worker=0xffff888101680300) at kernel/workqueue.c:3393
> 
>>
>> We sometimes draw into the buffer object from the CPU. For accessing the
>> buffer object's pages from the CPU, only a vmap operation should be
>> necessary. It appears as if qxl also requires a pin. My guess is that the pin
>> inserts the buffer-object's host-side pages and the code around
>> qxl_release_from_id_locked() appears to be garbage-collecting them.
>> Hence without the pin, the GC complains about inconsistent state.
>>>>>
>>>>> I bisected the issue down to "drm/qxl: Do not pin buffer objects for
>> vmap"
>>>>> (b33651a5c98dbd5a919219d8c129d0674ef74299).
>>
>> Thanks for bisecting. Does it work if you revert that commit?
> 
> Yes
> 
> Thanks --David Kaplan
