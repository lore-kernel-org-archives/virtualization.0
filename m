From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 04/10] virtio: console: return -ENODEV on all read
	operations after unplug
Date: Fri, 19 Jul 2013 15:00:45 +0800
Message-ID: <51E8E41D.10309@redhat.com>
References: <cover.1374177234.git.amit.shah@redhat.com>
	<39ab201027a58e792724172f1f559fe837e89556.1374177234.git.amit.shah@redhat.com>
	<51E8C9A5.2070309@redhat.com>
	<20130719054512.GG3087@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130719054512.GG3087@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07/19/2013 01:45 PM, Amit Shah wrote:
> On (Fri) 19 Jul 2013 [13:07:49], Jason Wang wrote:
>> On 07/19/2013 04:16 AM, Amit Shah wrote:
>>> If a port gets unplugged while a user is blocked on read(), -ENODEV is
>>> returned.  However, subsequent read()s returned 0, indicating there's no
>>> host-side connection (but not indicating the device went away).
>>>
>>> This also happened when a port was unplugged and the user didn't have
>>> any blocking operation pending.  If the user didn't monitor the SIGIO
>>> signal, they won't have a chance to find out if the port went away.
>>>
>>> Fix by returning -ENODEV on all read()s after the port gets unplugged.
>>> write() already behaves this way.
>>>
>>> CC: <stable@vger.kernel.org>
>>> Signed-off-by: Amit Shah <amit.shah@redhat.com>
>>> ---
>>>  drivers/char/virtio_console.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
>>> index 6bf0df3..a39702a 100644
>>> --- a/drivers/char/virtio_console.c
>>> +++ b/drivers/char/virtio_console.c
>>> @@ -749,6 +749,10 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
>>>  
>>>  	port = filp->private_data;
>>>  
>>> +	/* Port is hot-unplugged. */
>>> +	if (!port->guest_connected)
>>> +		return -ENODEV;
>>> +
>> What if the port is hot-unplugged after this check? Should we serialize
>> the hot plug with inbuf_lock here?
> If that happens, port_has_data() returns false, and the later
> functions return appropriately, as unplug_port() clears out all the
> data.
>
> However, I spotted a couple of things that need fixing:
>
> 1. In the condition you describe above, port_has_data will return
> false, and host_connected will be false as well, and fops_read() will
> return 0 instead of -ENODEV once.  Subsequent reads will return
> -ENODEV.

Then the check is not needed here.

>
> 2. get_inbuf(), which is called by port_has_data() accesses the vqs
> even if the port is unplugged.  The vqs are still available, and won't
> have data in them (since the port is unplugged), but it's best to not
> rely on such behaviour.  For the next merge window, I'll add extra
> state, port_(un)plugged to track this instead of abusing
> guest_connected.
>
> That also simplifies the path for later if we get vq hot-plug as well.
>
> I think the current code will behave satisfactorily for now; what do
> you think?

Yes, sounds good.
>
> 		Amit
