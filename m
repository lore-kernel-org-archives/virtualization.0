From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH/RFC 3/4]Introduce "account modifiers"
	mechanism
Date: Sun, 19 Aug 2007 10:38:10 +0300
Message-ID: <46C7F362.80106__27361.3448408016$1187509196$gmane$org@qumranet.com>
References: <46C4719A.2060308@bull.net>
	<46C4720F.7030304@bull.net>		<46C4725A.4070607@bull.net>
	<46C4740F.2050701@bull.net>		<1187303955.6449.7.camel@localhost.localdomain>	<46C54FB8.7050504@bull.net>	<1187339450.6449.115.camel@localhost.localdomain>
	<46C56774.2030009@bull.net> <46C59AB1.6070505@qumranet.com>
	<46C5ACE8.2050004@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C5ACE8.2050004@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Laurent Vivier wrote:
> Avi Kivity wrote:
> [...]
>   
>> The normal user/system accounting has the same issue, no?  Whereever we
>> happen to land (kernel or user) gets the whole tick.
>>
>> So I think it is okay to have the same limitation for guest time.
>>
>>     
>
> So this is how it looks like.
> PATCH 1 and 2 are always a prerequisite.
>
>   

> +	tmp = cputime_to_cputime64(cputime);
> +	if (p->flags & PF_VCPU) {
> +		p->utime = cputime_add(p->utime, cputime);
> +		p->gtime = cputime_add(p->gtime, cputime);
> +
> +		cpustat->guest = cputime64_add(cpustat->guest, tmp);
> +		cpustat->user = cputime64_add(cpustat->user, tmp);
> +
> +		p->flags &= ~PF_VCPU;
> +
> +		return;
> +	}
> +

Where did CONFIG_GUEST_ACCOUNTING go?


-- 
error compiling committee.c: too many arguments to function
