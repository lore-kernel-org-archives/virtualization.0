From: Dmitry Vyukov via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH net] vhost: Use kzalloc() to allocate vhost_msg_node
Date: Sun, 29 Apr 2018 10:10:34 +0200
Message-ID: <CACT4Y+YG+P3NmQsiSwq1WpHiQ6sXaKy650vm1Ah7w+p8ZRtb5Q__49764.4784431488$1524989345$gmane$org@mail.gmail.com>
References: <000000000000a5b2b1056a86e98c@google.com>
	<20180427154502.GA22544@la.guarana.org>
	<20180427185501-mutt-send-email-mst@kernel.org>
	<CACT4Y+b4fEOw=GjTsZMHVyQPOZmuqPWj6AJJshpS-UGRx=bhXA@mail.gmail.com>
	<20180427223636-mutt-send-email-mst@kernel.org>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180427223636-mutt-send-email-mst@kernel.org>
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
Cc: Kevin Easton <kevin@guarana.org>, KVM list <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 27, 2018 at 9:36 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> The struct vhost_msg within struct vhost_msg_node is copied to userspace,
>> >> so it should be allocated with kzalloc() to ensure all structure padding
>> >> is zeroed.
>> >>
>> >> Signed-off-by: Kevin Easton <kevin@guarana.org>
>> >> Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
>> >
>> > Does it help if a patch naming the padding is applied,
>> > and then we init just the relevant field?
>> > Just curious.
>>
>> Yes, it would help.
>
> How about a Tested-by tag then?

I didn't test either patch.

>> >> ---
>> >>  drivers/vhost/vhost.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> >> index f3bd8e9..1b84dcff 100644
>> >> --- a/drivers/vhost/vhost.c
>> >> +++ b/drivers/vhost/vhost.c
>> >> @@ -2339,7 +2339,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>> >>  /* Create a new message. */
>> >>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>> >>  {
>> >> -     struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>> >> +     struct vhost_msg_node *node = kzalloc(sizeof *node, GFP_KERNEL);
>> >>       if (!node)
>> >>               return NULL;
>> >>       node->vq = vq;
>> >> --
>> >> 2.8.1
>> >
>> > --
>> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180427185501-mutt-send-email-mst%40kernel.org.
>> > For more options, visit https://groups.google.com/d/optout.
