From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 4/25] [PATCH] Add debugreg/load_rsp native hooks
Date: Wed, 08 Aug 2007 22:47:26 -0700
Message-ID: <46BAAA6E.2060208__29805.6761771024$1186638683$gmane$org@goop.org>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865467662182-git-send-email-gcosta@redhat.com>
	<11865467702103-git-send-email-gcosta@redhat.com>
	<200708081116.43237.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081116.43237.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> @@ -264,13 +270,64 @@ struct thread_struct {
>>  	set_fs(USER_DS);							 \
>>  } while(0)
>>
>> -#define get_debugreg(var, register)				\
>> -		__asm__("movq %%db" #register ", %0"		\
>> -			:"=r" (var))
>> -#define set_debugreg(value, register)			\
>> -		__asm__("movq %0,%%db" #register		\
>> -			: /* no output */			\
>> -			:"r" (value))
>> +static inline unsigned long native_get_debugreg(int regno)
>> +{
>> +	unsigned long val;
>>     
>
> It would be better to have own functions for each debug register I think
>   

?  A separate pvop for each?  Seems excessive.  And surely this should
be identical to 32bit either way.

    J
