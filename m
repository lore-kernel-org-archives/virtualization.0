From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 06/10] virtio: console: fix race in port_fops_poll() and
	port unplug
Date: Tue, 23 Jul 2013 15:20:37 +0800
Message-ID: <51EE2EC5.4040700@redhat.com>
References: <cover.1374177234.git.amit.shah@redhat.com>
	<bb9fe1cb5a1aeff6ecfc68936254045024e25e56.1374177234.git.amit.shah@redhat.com>
	<51E8E4D6.7030807@redhat.com>
	<20130719072113.GL3087@amit-x200.redhat.com>
	<51E9123C.5040708@redhat.com>
	<20130719102941.GN3087@amit-x200.redhat.com>
	<87fvv7b11d.fsf@rustcorp.com.au> <51EDF1EE.4010801@redhat.com>
	<87fvv5alua.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87fvv5alua.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07/23/2013 01:26 PM, Rusty Russell wrote:
> Jason Wang <jasowang@redhat.com> writes:
>> On 07/22/2013 01:45 PM, Rusty Russell wrote:
>>> Amit Shah <amit.shah@redhat.com> writes:
>>>> On (Fri) 19 Jul 2013 [18:17:32], Jason Wang wrote:
>>>>> On 07/19/2013 03:48 PM, Amit Shah wrote:
>>>>>> On (Fri) 19 Jul 2013 [15:03:50], Jason Wang wrote:
>>>>>>> On 07/19/2013 04:16 AM, Amit Shah wrote:
>>>>>>>> Between poll() being called and processed, the port can be unplugged.
>>>>>>>> Check if this happened, and bail out.
>>>>>>>>
>>>>>>>> Signed-off-by: Amit Shah <amit.shah@redhat.com>
>>>>>>>> ---
>>>>>>>>  drivers/char/virtio_console.c | 4 ++++
>>>>>>>>  1 file changed, 4 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
>>>>>>>> index 7728af9..1d4b748 100644
>>>>>>>> --- a/drivers/char/virtio_console.c
>>>>>>>> +++ b/drivers/char/virtio_console.c
>>>>>>>> @@ -967,6 +967,10 @@ static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
>>>>>>>>  	unsigned int ret;
>>>>>>>>  
>>>>>>>>  	port = filp->private_data;
>>>>>>>> +	if (!port->guest_connected) {
>>>>>>>> +		/* Port was unplugged before we could proceed */
>>>>>>>> +		return POLLHUP;
>>>>>>>> +	}
>>>>>>>>  	poll_wait(filp, &port->waitqueue, wait);
>>>>>>>>  
>>>>>>>>  	if (!port->guest_connected) {
>>>>>>> Looks still racy here. Unlike port_fops_read() which check
>>>>>>> will_read_block(). If unplug happens after the check but before the
>>>>>>> poll_wait(), caller will be blocked forever.
>>>>>> unplug_port() calls wake_up_interruptible on the waitqueue.
>>>>> I mean the following cases:
>>>> (formatting to fit properly:)
>>>>
>>>>> CPU0:                                CPU1: unplug_port()
>>>>>
>>>>> if (!port->guest_connected) {
>>>>>     return POLLHUP;
>>>>> }
>>>>>                                      wake_up_interruptiable()
>>>>>
>>>>> poll_wait(filp, &port->waitqueue, wait);
>>>> Agreed, this can happen.  I can't think of a way to resolve this.  One
>>>> way would be to remove the waitqueue (port->waitqueue = NULL in
>>>> unplug_port()), but I'm not sure of the effect on the other parts
>>>> yet.  I'll leave this one for later analysis.
>>> No, you are confused by the name, I think,
>>>
>>> poll_wait() doesn't actually wait.  It's more like a poll_enqueue().
>> Yes, but the caller will wait then and since the wakeup was called
>> before adding into waitqueue. It may block forever?
> No, we enqueue then check:
>
> 	port = filp->private_data;
> 	poll_wait(filp, &port->waitqueue, wait);
>
> 	if (!port->guest_connected) {
> 		/* Port got unplugged */
> 		return POLLHUP;
> 	}
> 	ret = 0;
> 	if (!will_read_block(port))
> 		ret |= POLLIN | POLLRDNORM;
> 	if (!will_write_block(port))
> 		ret |= POLLOUT;
> 	if (!port->host_connected)
> 		ret |= POLLHUP;
>
> 	return ret;
>
> Which is the correct way to do this.

Right, thanks for the explaining.
>
> Cheers,
> Rusty.
