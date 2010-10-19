From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] virtio: console: Don't block entire guest if host doesn't
	read data
Date: Tue, 19 Oct 2010 08:57:43 +0200
Message-ID: <4CBD4167.1010104@redhat.com>
References: <baecf865292e0cc96914d30fc601e3a96fad9845.1287467155.git.amit.shah@redhat.com>
	<4CBD40D4.9050106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CBD40D4.9050106@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: stable@kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Ok replying to my own reply, because I misread the code.

On 10/19/2010 08:55 AM, Hans de Goede wrote:
> Hi,
>
> On 10/19/2010 07:45 AM, Amit Shah wrote:
>> If the host is slow in reading data or doesn't read data at all,
>> blocking write calls not only blocked the program that called write()
>> but the entire guest itself.
>>
>> To overcome this, let's not block till the host signals it has given
>> back the virtio ring element we passed it. Instead, send the buffer to
>> the host and return to userspace. This operation then becomes similar
>> to how non-blocking writes work, so let's use the existing code for this
>> path as well.
>>
>> This code change also ensures blocking write calls do get blocked if
>> there's not enough room in the virtio ring as well as they don't return
>> -EAGAIN to userspace.
>>
>> Signed-off-by: Amit Shah<amit.shah@redhat.com>
>> CC: stable@kernel.org
>> ---
>> drivers/char/virtio_console.c | 17 ++++++++++++++---
>> 1 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
>> index c810481..0f69c5e 100644
>> --- a/drivers/char/virtio_console.c
>> +++ b/drivers/char/virtio_console.c
>> @@ -459,9 +459,12 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count,
>>
>> /*
>> * Wait till the host acknowledges it pushed out the data we
>> - * sent. This is done for ports in blocking mode or for data
>> - * from the hvc_console; the tty operations are performed with
>> - * spinlocks held so we can't sleep here.
>> + * sent. This is done for data from the hvc_console; the tty
>> + * operations are performed with spinlocks held so we can't
>> + * sleep here. An alternative would be to copy the data to a
>> + * buffer and relax the spinning requirement. The downside is
>> + * we need to kmalloc a GFP_ATOMIC buffer each time the
>> + * console driver writes something out.
>> */
>> while (!virtqueue_get_buf(out_vq,&len))
>> cpu_relax();
>> @@ -626,6 +629,14 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
>> goto free_buf;
>> }
>>
>> + /*
>> + * We now ask send_buf() to not spin for generic ports -- we
>> + * can re-use the same code path that non-blocking file
>> + * descriptors take for blocking file descriptors since the
>> + * wait is already done and we're certain the write will go
>> + * through to the host.
>> + */
>> + nonblock = true;
>> ret = send_buf(port, buf, count, nonblock);
>>
>> if (nonblock&& ret> 0)
>
> 1) Hmm, this changes the code to kfree the buffer, but only if the send_buf
> succeeded (which it always should given we did a will_block check first).
>
> I cannot help but notice that the data was not freed on a blocking fd
> before this patch, but is freed now. And I see nothing in send_buf to make
> it take ownership of the buffer / free it in the blocking case, and not take
> ownership in the blocking case.

This part still stands.

 > More over if anything I would expect send_buf
> to take ownership in the non blocking case (as the data is not directly
> consumed there), and not take owner ship in the blocking case, but the check
> is the reverse. Also why is the buffer not freed if the write failed, that
> makes no sense.
>

This part is wrong the:

if (nonblock && ret> 0)

Check make it jump (goto) over the free, so it does make sense, but is coded
rather convolutedly.

> 2) Assuming that things are changed so that send_buf does take ownership of the
> buffer in the nonblocking case, shouldn't the buffer then be allocated
> with GPF_ATOMIC ?
>
> 3) This patch will cause processes filling the virtqueue fast enough to block
> to never wake up again, due to a missing waitqueue wakeup, see:
> https://bugzilla.redhat.com/show_bug.cgi?id=643750

These 2 parts still stand.

Regards,

Hans
