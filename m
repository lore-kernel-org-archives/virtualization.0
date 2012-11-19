From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH 09/14] xen: events: Remove redundant check on unsigned
	variable
Date: Mon, 19 Nov 2012 09:22:37 +0530
Message-ID: <50A9AD05.5080201@linaro.org>
References: <1353048646-10935-1-git-send-email-tushar.behera@linaro.org>
	<1353048646-10935-10-git-send-email-tushar.behera@linaro.org>
	<20121116160923.GP22320@phenom.dumpdata.com>
	<b0cd27cf-919f-46b0-afa1-4566f6ea0f61@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b0cd27cf-919f-46b0-afa1-4566f6ea0f61@email.android.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, patches@linaro.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/16/2012 10:23 PM, Jeremy Fitzhardinge wrote:
> To be honest I'd nack this kind of patch. The test is only redundant in the most trivial sense that the compiler can easily optimise away. The point of the test is to make sure that the range is OK even if the type subsequently becomes signed (to hold a -ve error, for example).
> 
> J
> 

The check is on the function argument which is unsigned, so checking '<
0' doesn't make sense. We should force signed check only if the argument
is of signed type. In any case, even if irq has been assigned some error
value, that would be caught by the check irq >= nr_irqs.

> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> 
>> On Fri, Nov 16, 2012 at 12:20:41PM +0530, Tushar Behera wrote:
>>> No need to check whether unsigned variable is less than 0.
>>>
>>> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>
>> Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>
>>> CC: Jeremy Fitzhardinge <jeremy@goop.org>
>>> CC: xen-devel@lists.xensource.com
>>> CC: virtualization@lists.linux-foundation.org
>>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>>> ---
>>>  drivers/xen/events.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/xen/events.c b/drivers/xen/events.c
>>> index 4293c57..cadd7d1 100644
>>> --- a/drivers/xen/events.c
>>> +++ b/drivers/xen/events.c
>>> @@ -216,7 +216,7 @@ static void xen_irq_info_pirq_init(unsigned irq,
>>>   */
>>>  static unsigned int evtchn_from_irq(unsigned irq)
>>>  {
>>> -	if (unlikely(WARN(irq < 0 || irq >= nr_irqs, "Invalid irq %d!\n",
>> irq)))
>>> +	if (unlikely(WARN(irq >= nr_irqs, "Invalid irq %d!\n", irq)))
>>>  		return 0;
>>>  
>>>  	return info_for_irq(irq)->evtchn;
>>> -- 
>>> 1.7.4.1
> 


-- 
Tushar Behera
