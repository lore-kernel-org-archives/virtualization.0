From: Dmitry Vyukov via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [net] vhost: Use kzalloc() to allocate vhost_msg_node
Date: Mon, 4 Jun 2018 14:34:52 +0200
Message-ID: <CACT4Y+aG9_MSdiRTeHzAn2EVaJffCefekRksv+JHY=YsELGHFA@mail.gmail.com>
References: <20180427154502.GA22544@la.guarana.org>
	<20180529221908.GA22742@roeck-us.net>
	<20180530055704-mutt-send-email-mst@kernel.org>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180530055704-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Easton <kevin@guarana.org>, KVM list <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Guenter Roeck <linux@roeck-us.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 30, 2018 at 5:01 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, May 29, 2018 at 03:19:08PM -0700, Guenter Roeck wrote:
>> On Fri, Apr 27, 2018 at 11:45:02AM -0400, Kevin Easton wrote:
>> > The struct vhost_msg within struct vhost_msg_node is copied to userspace,
>> > so it should be allocated with kzalloc() to ensure all structure padding
>> > is zeroed.
>> >
>> > Signed-off-by: Kevin Easton <kevin@guarana.org>
>> > Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
>>
>> Is this patch going anywhere ?
>>
>> The patch fixes CVE-2018-1118. It would be useful to understand if and when
>> this problem is going to be fixed.
>>
>> Thanks,
>> Guenter
>> > ---
>> >  drivers/vhost/vhost.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> > index f3bd8e9..1b84dcff 100644
>> > --- a/drivers/vhost/vhost.c
>> > +++ b/drivers/vhost/vhost.c
>> > @@ -2339,7 +2339,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>> >  /* Create a new message. */
>> >  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>> >  {
>> > -   struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>> > +   struct vhost_msg_node *node = kzalloc(sizeof *node, GFP_KERNEL);
>> >     if (!node)
>> >             return NULL;
>> >     node->vq = vq;
>
> As I pointed out, we don't need to init the whole structure. The proper
> fix is thus (I think) below.
>
> Could you use your testing infrastructure to confirm this fixes the issue?

Hi Michael,

syzbot is self-service, see:

https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches


> Thanks!
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f3bd8e941224..58d9aec90afb 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2342,6 +2342,9 @@ struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>         struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>         if (!node)
>                 return NULL;
> +
> +       /* Make sure all padding within the structure is initialized. */
> +       memset(&node->msg, 0, sizeof node->msg);
>         node->vq = vq;
>         node->msg.type = type;
>         return node;
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180530055704-mutt-send-email-mst%40kernel.org.
> For more options, visit https://groups.google.com/d/optout.
