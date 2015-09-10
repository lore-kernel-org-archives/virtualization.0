From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: remove unused operation
Date: Thu, 10 Sep 2015 12:46:22 +0200
Message-ID: <55F15F7E.3000502__4087.82632225684$1441882020$gmane$org@suse.com>
References: <1438862127-19674-1-git-send-email-jgross@suse.com>
	<55E02501.5030105@suse.com> <87d1y4qq4f.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87d1y4qq4f.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com, virtualization@lists.linux-foundation.org, x86@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/31/2015 02:05 AM, Rusty Russell wrote:
> Juergen Gross <jgross@suse.com> writes:
>> Ping?
>
> Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Anyone willing to take this patch?


Juergen

>
> Cheers,
> Rusty.
>
>> On 08/06/2015 01:55 PM, Juergen Gross wrote:
>>> Remove the paravirt operation "get_tsc_khz" as it is used nowhere.
>>>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> ---
>>>    arch/x86/include/asm/paravirt_types.h | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
>>> index a6b8f9f..5a18a66 100644
>>> --- a/arch/x86/include/asm/paravirt_types.h
>>> +++ b/arch/x86/include/asm/paravirt_types.h
>>> @@ -97,7 +97,6 @@ struct pv_lazy_ops {
>>>    struct pv_time_ops {
>>>    	unsigned long long (*sched_clock)(void);
>>>    	unsigned long long (*steal_clock)(int cpu);
>>> -	unsigned long (*get_tsc_khz)(void);
>>>    };
>>>
>>>    struct pv_cpu_ops {
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
