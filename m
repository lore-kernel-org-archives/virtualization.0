From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Wed, 20 Jul 2016 00:32:57 +0900
Message-ID: <CAM9d7cijGGXE0tJbzg1T2r8V44mGwB2rnbS+xW1fjmeafd6eMg@mail.gmail.com>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-2-git-send-email-namhyung@kernel.org>
	<CAGXu5jL8frrV99QXrw4touwnXAX0pesxKJnq4Bd_2QZDip7K6Q@mail.gmail.com>
	<20160718055037.GA8051@danjae.aot.lge.com>
	<CAGXu5jJBM6GLwR6B28US11v90pFsiU2yJddm4V6kx3CHdLcOqQ@mail.gmail.com>
	<20160719134303.GA20047@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160719134303.GA20047@danjae.aot.lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com>, Radim Kr??m???? <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel <qemu-devel@nongnu.org>, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 19, 2016 at 10:43 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> Hi Kees,
>
> On Mon, Jul 18, 2016 at 10:50:06AM -0700, Kees Cook wrote:
>> On Sun, Jul 17, 2016 at 10:50 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>> > Hello,
>> >
>> > On Sun, Jul 17, 2016 at 10:12:26PM -0700, Kees Cook wrote:
>> >> On Sun, Jul 17, 2016 at 9:37 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>> > [SNIP]
>> >> > +static u16 to_virtio_type(struct virtio_pstore *vps, enum pstore_type_id type)
>> >> > +{
>> >> > +       u16 ret;
>> >> > +
>> >> > +       switch (type) {
>> >> > +       case PSTORE_TYPE_DMESG:
>> >> > +               ret = cpu_to_virtio16(vps->vdev, VIRTIO_PSTORE_TYPE_DMESG);
>> >> > +               break;
>> >> > +       default:
>> >> > +               ret = cpu_to_virtio16(vps->vdev, VIRTIO_PSTORE_TYPE_UNKNOWN);
>> >> > +               break;
>> >> > +       }
>> >>
>> >> I would love to see this support PSTORE_TYPE_CONSOLE too. It should be
>> >> relatively easy to add: I think it'd just be another virtio command?
>> >
>> > Do you want to append the data to the host file as guest does
>> > printk()?  I think it needs some kind of buffer management, but it's
>> > not hard to add IMHO.
>>
>> Well, with most pstore backends, the buffer size is limited, so it
>> tends to be a circular buffer of some sort. I think whatever you
>> choose to do is fine (I saw the various mentions of resource limits in
>> the qemu part of this thread), as long as the last N bytes of console
>> can be seen on the host side, where N is some portion of the memory
>> set aside for the log. (I don't mind the idea of an unlimited console
>> log either, but I suspect that will not be accepted on the qemu
>> side...)
>
> I think it needs two kinds of buffer management.
>
> The first one is the psinfo->buf (or something similar).  IIUC the
> PSTORE_TYPE_CONSOLE is different than PSTORE_TYPE_DMESG as it is
> emitted every time printk() sends messages to console.  So I think the
> it should remain in async mode due to performance reason.  To do that,
> the message should be copied to psinfo->buf and then sent via virtio.
> Then it needs to keep track of the available buffer position IMHO.

Looking at the code, I found myself confused with the PSTORE_TYPE_FTRACE
and PSTORE_TYPE_CONSOLE.  It seems that handling of
PSTORE_TYPE_CONSOLE is basically same as PSTORE_TYPE_DMESG..

Thanks,
Namhyung
