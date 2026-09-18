Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D00481DD;
	Fri, 18 Sep 2026 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741363; cv=none; b=EhKTjW6nbTcwn5aaIzsS0l6f+27YW7Bw/1lmsvlmB/ybMHl51qufqBtOEwdEwWaYOONMuSEGjgJPFB7upZDTa+hpeXZNMtB1c0pYOVSa12Ol3Kcdttl6R1j9LJE6/g4HZ7ndii+W3v04J5DDVwbSnGG0p6Pi9vYYdBvs+c0bTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741363; c=relaxed/simple;
	bh=cbGPyXO8tDYVSie4U1A8gTgdS3deiymDv3GNSI34Uws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1p1iS42WniirBg6amGGbyyAzxy4YlFU4rHltu2HPlF4fcdHe9i9bi5+T7ypwZkdthY+9VDvwpFScab/Ixc/mU4T8R7vd5AOGm6Xldcdoe+v06cFrzBYxOscRFZyxKzPINR3Q/IwCWpInGE8GDd+bZrck65GIh8AAelf9YaLPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EaeCuaRd; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EaeCuaRd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=pYtYAfDJI8svYgT1CrIOHRyiBJYKlCKWW3kx3NqqXaA=; b=EaeCuaRdcRqVmNl2UEMC6QisP0
	kg5w3HbqifVeXKkmWkqX/s3URonieftbiyE2PXXeRhhfc7HXBuk3ieziDcosLAl1GrXN3pT6ugQQq
	7Yd8nkvCaLko1T29eHPgIpQ0LBjrbe168rUfvyfmaNFS3b6QmCCyPi/4ili4OPD+j1n2Up6AkH9Pg
	+r98FiPmT98FQqtjOkmlYk626vUg+wOJmym5DE6qYjYmRFS7C9K2Iwfzo5JuE7qJQqZoWr5xZRTiC
	O/cDJYTRL4ZnoBCzihKo6i6OeOl2UssF1T8i6v5xx2DiVvS2vTEzVHpCNR3RhrQhUf8EIuy6MX4u7
	9nJTRW5A==;
Received: from [191.32.244.140] (helo=[192.168.1.56])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x7ZTG-003yti-Ta; Fri, 18 Sep 2026 16:21:46 +0200
Message-ID: <bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com>
Date: Fri, 18 Sep 2026 11:21:38 -0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by
 default
Content-Language: en-US
To: Zack Rusin <zack.rusin@broadcom.com>, Petr Mladek <pmladek@suse.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
 Joel Granados <joel.granados@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 John Ogness <john.ogness@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
 Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 Stephen Brennan <stephen.s.brennan@oracle.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
 <aquttpMVKX8e6zGB@pathway.suse.cz>
 <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Petr, Zack - thanks for CCing me!
Some comments below:


On 18/09/2026 00:23, Zack Rusin wrote:
>> [...]
>> Maybe, we should start with something simple, and introduce
>> one more panic notifier as a start. It might be called either:
>>
>>   + "panic_hypervisor_list" because "crash_kexec_post_notifiers = true"
>>     seems to be primary set on hypervisors.
>>
>> But I would rather make it more generic and call it
>>
>>   + panic_pre_crash_kexec or panic_pre_kdump because there might be
>>     more notifiers which are either 100% safe and useful or are worth
>>     the risk before calling crash dump.
>>
>> We could put there x86/vmware notifiers as a start. And we could later
>> move there other important notifiers.
>>
>> How does that sound, please?
> 

It's a good idea, IMO. We could start with this, Zach commented some
implementation details below...and after it gets merged, we could move
other hypervisors that currently set "crash_kexec_post_notifiers" to
this list and eventually, unexport this symbol. We should avoid having
code forcing this parameter, as Petr said, many notifiers are executed
if that is set.

(I'm CCing Stephen Brennan here, I recall he had problems with this
being auto-set, we talked about that in the panic notifiers big
discussions in the past heh)

The only thing I'd like to suggest: I think we should have a parameter
that disables running this list, which would be the opposite of
"crash_kexec_post_notifiers".

I would implement it as something like: "postpone_pre_kexec_notifiers"
or something like that. The parameter would basically "move" this list
execution to the same time as the current notifiers, gating them to
"crash_kexec_post_notifiers". This way, we'd allow users to debug kexec
failures maybe related to the "early" notifiers. WDYT?


> [...]
> I think that without that default though, x86 oops_end() can enter
> crash_kexec(regs) before reaching panic(), for example with
> panic_on_oops=1. To cover that path too, I'd call the chain from
> __crash_kexec() after the image check and register capture, under the
> existing kexec lock. A second call in vpanic(), immediately before
> kmsg_dump_desc(), would cover the fallback path. And I think a
> set-once guard would prevent duplicate or recursive dispatch.
> 

Regarding this, 2 things:

a) I think you could change kexec_should_crash() to "return 0" also in
case the new list is set to run, the same is done currently for
"crash_kexec_post_notifiers". Makes sense?

b) Well, does this whole panic diag thing you're implementing here aims
only at x86 guests ? Or would it be possible to run, for example, arm64
guests? Asking this because in x86 and some other architectures (but not
arm64[0]), it's possible to override machine_crash_shutdown() handler,
and run things prior to a kexec. Take a look on how Hyper-V does that on
arch/x86 - this could be just what you need, except if you plan to have
it for all architectures heh

Finally, if possible please keep me looped in the following patches, I'm
very interested on that =)
Cheers,


Guilherme


[0]
https://lore.kernel.org/r/427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com/
