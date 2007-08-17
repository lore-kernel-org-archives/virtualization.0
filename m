From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH/RFC 3/4,
	second shot]Introduce "account_guest_time"
Date: Fri, 17 Aug 2007 15:59:41 +0300
Message-ID: <46C59BBD.6050204__44902.1267392256$1187355897$gmane$org@qumranet.com>
References: <46C4719A.2060308@bull.net>
	<46C4720F.7030304@bull.net>		<46C4725A.4070607@bull.net>
	<46C4740F.2050701@bull.net>		<1187303955.6449.7.camel@localhost.localdomain>	<46C54FB8.7050504@bull.net>	<1187339450.6449.115.camel@localhost.localdomain>	<46C56774.2030009@bull.net>
	<46C58BD5.3090207@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C58BD5.3090207@bull.net>
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
> This is another way to compute guest time... I remove the "account modifiers"
> mechanism and call directly account_guest_time() from account_system_time().
> account_system_time() computes user, system and guest times according value
> accumulated in vtime (a ktime_t) in task_struct by the virtual machine.
>   


> @@ -3246,6 +3277,10 @@
>  	struct rq *rq = this_rq();
>  	cputime64_t tmp;
>  
> +#ifdef CONFIG_GUEST_ACCOUNTING
> +	cputime = account_guest_time(p, cputime);
> +#endif
> +
>  	p->stime = cputime_add(p->stime, cputime);
>  
>  	/* Add system time to cpustat. */


In order to reduce the impact on whatever function this is in (use diff
-p please), you can always have a definition of account_guest_time:

#else

static cputime_t account_guest_time(struct task_struct *p, cputime_t cputime)
{
        return cputime;
}

#endif


This way the #ifdef/#endif is not necessary when calling it.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
