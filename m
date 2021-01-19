Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123E2C433DB
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 11:36:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E6C20867
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 11:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E6C20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E1E9285A82;
	Tue, 19 Jan 2021 11:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xB1Ishq2G0xv; Tue, 19 Jan 2021 11:36:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 04E8A86187;
	Tue, 19 Jan 2021 11:36:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1DD7C088B;
	Tue, 19 Jan 2021 11:36:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC6A0C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D6F2020434
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fkX2+kfTGmoW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:36:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id A465320430
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:36:40 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611056199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BA18z5VqrKcytidarAoSFYLY2l1omqCAkHtcL3oW9cU=;
 b=IZSlN6U9gI1+JtiiSVu8zkNNU2tlK7ZRdW2EoEFd9h6ixl7UuPHZXraQzuwohdOvN4ZDrE
 ZHObA3bKHX8d6dut9BCX9AHjz295xejl7J54IUYMzukPDM+8YNA0ZNEejmPE5BmlCaLVfw
 Ipnqnj7YaeScdwwqIQIM5dgAAkHlUd4=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1EA44AB9F;
 Tue, 19 Jan 2021 11:36:39 +0000 (UTC)
Subject: Re: [PATCH v3 06/15] x86/paravirt: switch time pvops functions to use
 static_call()
To: Michael Kelley <mikelley@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20201217093133.1507-1-jgross@suse.com>
 <20201217093133.1507-7-jgross@suse.com>
 <MW2PR2101MB1052877B5376112F1BAF3D93D7C49@MW2PR2101MB1052.namprd21.prod.outlook.com>
Message-ID: <5e34b263-da71-daf4-8ff6-b583427f1565@suse.com>
Date: Tue, 19 Jan 2021 12:36:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1052877B5376112F1BAF3D93D7C49@MW2PR2101MB1052.namprd21.prod.outlook.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 "VMware, Inc." <pv-drivers@vmware.com>, Ben Segall <bsegall@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Joerg Roedel <joro@8bytes.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Jim Mattson <jmattson@google.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Content-Type: multipart/mixed; boundary="===============3054639937182692338=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3054639937182692338==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MUpXQXJRqI9FNcl5WEQsoh0wg1RbQRaFG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MUpXQXJRqI9FNcl5WEQsoh0wg1RbQRaFG
Content-Type: multipart/mixed; boundary="QrT993NSGR0x4rfkkXRz07GavpdL5Q4yL";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Michael Kelley <mikelley@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Deep Shah <sdeep@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, vkuznets <vkuznets@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>,
 Joerg Roedel <joro@8bytes.org>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <5e34b263-da71-daf4-8ff6-b583427f1565@suse.com>
Subject: Re: [PATCH v3 06/15] x86/paravirt: switch time pvops functions to use
 static_call()
References: <20201217093133.1507-1-jgross@suse.com>
 <20201217093133.1507-7-jgross@suse.com>
 <MW2PR2101MB1052877B5376112F1BAF3D93D7C49@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1052877B5376112F1BAF3D93D7C49@MW2PR2101MB1052.namprd21.prod.outlook.com>

--QrT993NSGR0x4rfkkXRz07GavpdL5Q4yL
Content-Type: multipart/mixed;
 boundary="------------32C8808B241E19696785B4EC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------32C8808B241E19696785B4EC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 17.12.20 18:31, Michael Kelley wrote:
> From: Juergen Gross <jgross@suse.com> Sent: Thursday, December 17, 2020=
 1:31 AM
>=20
>> The time pvops functions are the only ones left which might be
>> used in 32-bit mode and which return a 64-bit value.
>>
>> Switch them to use the static_call() mechanism instead of pvops, as
>> this allows quite some simplification of the pvops implementation.
>>
>> Due to include hell this requires to split out the time interfaces
>> into a new header file.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   arch/x86/Kconfig                      |  1 +
>>   arch/x86/include/asm/mshyperv.h       | 11 --------
>>   arch/x86/include/asm/paravirt.h       | 14 ----------
>>   arch/x86/include/asm/paravirt_time.h  | 38 +++++++++++++++++++++++++=
++
>>   arch/x86/include/asm/paravirt_types.h |  6 -----
>>   arch/x86/kernel/cpu/vmware.c          |  5 ++--
>>   arch/x86/kernel/kvm.c                 |  3 ++-
>>   arch/x86/kernel/kvmclock.c            |  3 ++-
>>   arch/x86/kernel/paravirt.c            | 16 ++++++++---
>>   arch/x86/kernel/tsc.c                 |  3 ++-
>>   arch/x86/xen/time.c                   | 12 ++++-----
>>   drivers/clocksource/hyperv_timer.c    |  5 ++--
>>   drivers/xen/time.c                    |  3 ++-
>>   kernel/sched/sched.h                  |  1 +
>>   14 files changed, 71 insertions(+), 50 deletions(-)
>>   create mode 100644 arch/x86/include/asm/paravirt_time.h
>>
>=20
> [snip]
>  =20
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/ms=
hyperv.h
>> index ffc289992d1b..45942d420626 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -56,17 +56,6 @@ typedef int (*hyperv_fill_flush_list_func)(
>>   #define hv_get_raw_timer() rdtsc_ordered()
>>   #define hv_get_vector() HYPERVISOR_CALLBACK_VECTOR
>>
>> -/*
>> - * Reference to pv_ops must be inline so objtool
>> - * detection of noinstr violations can work correctly.
>> - */
>> -static __always_inline void hv_setup_sched_clock(void *sched_clock)
>> -{
>> -#ifdef CONFIG_PARAVIRT
>> -	pv_ops.time.sched_clock =3D sched_clock;
>> -#endif
>> -}
>> -
>>   void hyperv_vector_handler(struct pt_regs *regs);
>>
>>   static inline void hv_enable_stimer0_percpu_irq(int irq) {}
>=20
> [snip]
>=20
>> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/=
hyperv_timer.c
>> index ba04cb381cd3..1ed79993fc50 100644
>> --- a/drivers/clocksource/hyperv_timer.c
>> +++ b/drivers/clocksource/hyperv_timer.c
>> @@ -21,6 +21,7 @@
>>   #include <clocksource/hyperv_timer.h>
>>   #include <asm/hyperv-tlfs.h>
>>   #include <asm/mshyperv.h>
>> +#include <asm/paravirt_time.h>
>>
>>   static struct clock_event_device __percpu *hv_clock_event;
>>   static u64 hv_sched_clock_offset __ro_after_init;
>> @@ -445,7 +446,7 @@ static bool __init hv_init_tsc_clocksource(void)
>>   	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
>>
>>   	hv_sched_clock_offset =3D hv_read_reference_counter();
>> -	hv_setup_sched_clock(read_hv_sched_clock_tsc);
>> +	paravirt_set_sched_clock(read_hv_sched_clock_tsc);
>>
>>   	return true;
>>   }
>> @@ -470,6 +471,6 @@ void __init hv_init_clocksource(void)
>>   	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
>>
>>   	hv_sched_clock_offset =3D hv_read_reference_counter();
>> -	hv_setup_sched_clock(read_hv_sched_clock_msr);
>> +	static_call_update(pv_sched_clock, read_hv_sched_clock_msr);
>>   }
>>   EXPORT_SYMBOL_GPL(hv_init_clocksource);
>=20
> These Hyper-V changes are problematic as we want to keep hyperv_timer.c=

> architecture independent.  While only the code for x86/x64 is currently=

> accepted upstream, code for ARM64 support is in progress.   So we need
> to use hv_setup_sched_clock() in hyperv_timer.c, and have the per-arch
> implementation in mshyperv.h.

Okay, will switch back to old setup.


Juergen

--------------32C8808B241E19696785B4EC
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0xB0DE9DD628BF132F.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOBy=
cWx
w3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJvedYm8O=
f8Z
d621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y=
9bf
IhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xq=
G7/
377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR=
3Jv
c3MgPGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsEFgIDA=
QIe
AQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4FUGNQH2lvWAUy+dnyT=
hpw
dtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3TyevpB0CA3dbBQp0OW0fgCetToGIQrg0=
MbD
1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbv=
oPH
Z8SlM4KWm8rG+lIkGurqqu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v=
5QL
+qHI3EIPtyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVyZ=
2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJCAcDAgEGFQgCC=
QoL
BBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4RF7HoZhPVPogNVbC4YA6lW7Dr=
Wf0
teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz78X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC=
/nu
AFVGy+67q2DH8As3KPu0344TBDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0Lh=
ITT
d9jLzdDad1pQSToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLm=
XBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkMnQfvUewRz=
80h
SnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMBAgAjBQJTjHDXAhsDBwsJC=
AcD
AgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJn=
FOX
gMLdBQgBlVPO3/D9R8LtF9DBAFPNhlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1=
jnD
kfJZr6jrbjgyoZHiw/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0=
N51
N5JfVRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwPOoE+l=
otu
fe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK/1xMI3/+8jbO0tsn1=
tqS
EUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuZGU+wsB5BBMBAgAjBQJTjHDrA=
hsD
BwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3=
g3O
ZUEBmDHVVbqMtzwlmNC4k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5=
dM7
wRqzgJpJwK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu5=
D+j
LRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzBTNh30FVKK1Evm=
V2x
AKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37IoN1EblHI//x/e2AaIHpzK5h88N=
Eaw
QsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpW=
nHI
s98ndPUDpnoxWQugJ6MpMncr0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZR=
wgn
BC5mVM6JjQ5xDk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNV=
bVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mmwe0icXKLk=
pEd
IXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0Iv3OOImwTEe4co3c1mwARA=
QAB
wsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMvQ/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEw=
Tbe
8YFsw2V/Buv6Z4Mysln3nQK5ZadD534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1=
vJz
Q1fOU8lYFpZXTXIHb+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8=
VGi
wXvTyJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqcsuylW=
svi
uGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5BjR/i1DG86lem3iBDX=
zXs
ZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------32C8808B241E19696785B4EC--

--QrT993NSGR0x4rfkkXRz07GavpdL5Q4yL--

--MUpXQXJRqI9FNcl5WEQsoh0wg1RbQRaFG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmAGxEUFAwAAAAAACgkQsN6d1ii/Ey/e
Awf+O4iqom4Eij8DMvjvErPmOh0eAOIU4lUY2nIxHUNLRJWlamwLfALvTyFPgTS/rywLovXjfCgs
a/mGEXOH2P7gXOZ/1S9cfDTogJ3SRh1UGf8Ce3mQJUVhyKNEsbnLxAr84U2xhD+JertrtiV5mbgU
bUVHMXt84h4jwlGB5KGEZX5sgWVqXu+6Egs3w6f9FP31Md/DfZlU/eKtcOpZW5uquwglI00un1EH
hxM9j1HhrVWPvTYmoyw6UoRS8h7PN+HanPTy4jj2UWhFLGiyd1/KJawRTaLKl2jSbxej43JFZXQu
KRf8zj56PSIsyMujCQndphLV+bR0L39rnb4PDEeK+Q==
=m9RS
-----END PGP SIGNATURE-----

--MUpXQXJRqI9FNcl5WEQsoh0wg1RbQRaFG--

--===============3054639937182692338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3054639937182692338==--
