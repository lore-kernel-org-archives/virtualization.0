From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/4] Add helper functions for paravirtual clocksources.
Date: Tue, 27 May 2008 14:23:26 +0100
Message-ID: <483C0B4E.9050909@goop.org>
References: <1210924885-5353-1-git-send-email-kraxel@redhat.com>
	<1210924885-5353-2-git-send-email-kraxel@redhat.com>
	<4834A630.7060208@goop.org> <48353DB4.1020303@redhat.com>
	<483C0A65.2090208@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090206070405020307080705"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <483C0A65.2090208@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------090206070405020307080705
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gerd Hoffmann wrote:
> Gerd Hoffmann wrote:
>   
>>> And having defined a common structure, we may as well use it in the
>>> hypervisor-specific code/headers so there's no strange casting going on.
>>>       
>> Hmm, what is the state of include/xen/interface/?  It is a straight copy
>> of the xen public header files, right?  Is it really ok to modify them?
>>  We have to do that to make the cast actually go away ...
>>     
>
> ping ...
>   

Hm?  I sent a reply, didn't I?  Attached again.

    J

--------------090206070405020307080705
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message"

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
Received: from lurch.goop.org ([unix socket])
	 by lurch.goop.org (Cyrus v2.3.9-Fedora-RPM-2.3.9-7.fc7) with LMTPA;
	 Thu, 22 May 2008 02:58:16 -0700
X-Sieve: CMU Sieve 2.3
Received: by lurch.goop.org (Postfix, from userid 525)
	id C195D2C8047; Thu, 22 May 2008 02:58:16 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on lurch.goop.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=6.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.4
Received: from lurch.goop.org (localhost [127.0.0.1])
	by lurch.goop.org (Postfix) with ESMTP id 88CCD2C8043
	for <jeremy@goop.org>; Thu, 22 May 2008 02:58:09 -0700 (PDT)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org [140.211.169.13])
	by lurch.goop.org (Postfix) with ESMTP
	for <jeremy@goop.org>; Thu, 22 May 2008 02:58:09 -0700 (PDT)
Received: from daredevil.linux-foundation.org (localhost [127.0.0.1])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4M9uF0N028354;
	Thu, 22 May 2008 02:56:16 -0700
Received: from mail.goop.org (gw.goop.org [64.81.55.164])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id m4M9uCwf028343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <virtualization@lists.osdl.org>; Thu, 22 May 2008 02:56:14 -0700
Received: by lurch.goop.org (Postfix, from userid 525)
	id 5CF2C2C8049; Thu, 22 May 2008 02:56:11 -0700 (PDT)
Received: from lurch.goop.org (localhost [127.0.0.1])
	by lurch.goop.org (Postfix) with ESMTP id 254F62C8047;
	Thu, 22 May 2008 02:56:10 -0700 (PDT)
Received: from [0.0.0.0] (unknown [192.168.0.2])
	by lurch.goop.org (Postfix) with ESMTP;
	Thu, 22 May 2008 02:56:09 -0700 (PDT)
Message-ID: <4835431E.5080004@goop.org>
Date: Thu, 22 May 2008 10:55:42 +0100
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/4] Add helper functions for paravirtual clocksources.
References: <1210924885-5353-1-git-send-email-kraxel@redhat.com>
	<1210924885-5353-2-git-send-email-kraxel@redhat.com>
	<4834A630.7060208@goop.org> <48353DB4.1020303@redhat.com>
In-Reply-To: <48353DB4.1020303@redhat.com>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV using ClamSMTP by lurch.goop.org
Received-SPF: pass (localhost is always allowed.)
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.21
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.osdl.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
X-Virus-Scanned: ClamAV using ClamSMTP by lurch.goop.org

Gerd Hoffmann wrote:
> Jeremy Fitzhardinge wrote:
>
>   
>>> +static unsigned pvclock_get_time_values(struct pvclock_shadow_time *dst,
>>> +                    struct kvm_vcpu_time_info *src)
>>>   
>>>       
>> I think the kvm_* types should be renamed.  xen_* would make some sense
>> since the ABI originated with Xen, but something generic would be OK
>> too.  The important thing to get across is that the structure defines a
>> guest<->host ABI which happens to be shared by Xen and KVM, and it isn't
>> an in-kernel API like the rest of paravirt_ops.
>>     
>
> Fine with me, but see below.
>
>   
>> And having defined a common structure, we may as well use it in the
>> hypervisor-specific code/headers so there's no strange casting going on.
>>     
>
> Hmm, what is the state of include/xen/interface/?  It is a straight copy
> of the xen public header files, right?  Is it really ok to modify them?
>   

Yeah, sure.  They were copied once, but they can now drift without 
consequence.  Xen defines an ABI, so it doesn't matter how the source 
spells the names of the structures.

>>> +/*
>>> + * This is our read_clock function. The host puts an tsc timestamp
>>> each time
>>> + * it updates a new time. Without the tsc adjustment, we can have a
>>> situation
>>> + * in which a vcpu starts to run earlier (smaller system_time), but
>>> probes
>>> + * time later (compared to another vcpu), leading to backwards time
>>> + */
>>>   
>>>       
>> This comment is confusing.  Are you explaining why the tsc is read
>> within the loop?  I think it can be clarified.
>>     
>
> This was just copyed over from somewhere else (kvmclock I think).
>   

OK, but it still needs to be clarified.

>>> +++ b/include/asm-x86/pvclock.h
>>> @@ -0,0 +1,6 @@
>>> +#include <linux/clocksource.h>
>>> +#include <asm/kvm_para.h>
>>> +cycle_t pvclock_clocksource_read(struct kvm_vcpu_time_info *src);
>>> +void pvclock_read_wallclock(struct kvm_wall_clock *wall,
>>> +                struct kvm_vcpu_time_info *vcpu,
>>> +                struct timespec *ts);
>>>   
>>>       
>> No #ifdef guards?
>>     
>
> Oh yes, I should better add some ...

Also, the patches themselves need some changelogs.  Even though they're 
mostly just code motion, it would be good if the changelog for the 
common pvclock code had a description of the basics of operation.

Also, one implicit part of the ABI which should be explicitly documented 
is that the interface expects that the host updates the per-vcpu time 
structures on the same physical CPU that the guest runs, and that's why 
we can avoid explicit cross-cpu ordering barriers.

    J
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization

--------------090206070405020307080705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------090206070405020307080705--
