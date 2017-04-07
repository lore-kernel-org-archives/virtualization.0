From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 3/3] virtio-net: clean tx descriptors from rx napi
Date: Fri, 7 Apr 2017 17:14:45 -0400
Message-ID: <CAF=yD-JPet2ujY9C4oFa+x7vf6ZHv-XtS+imZM_vsZUFdsPMBg__6612.01372645355$1493076963$gmane$org@mail.gmail.com>
References: <20170402201012.76473-1-willemdebruijn.kernel@gmail.com>
	<20170402201012.76473-4-willemdebruijn.kernel@gmail.com>
	<20170403024751.GA21883@redhat.com>
	<CAF=yD-+tJxqvwvLU81=H7nwqDtiSWfAv8UdfncjPQiuNteJ6jQ@mail.gmail.com>
	<20170407222616-mutt-send-email-mst@kernel.org>
	<CAF=yD-JmO7XVng74BubyDLyP5Yf7wSCdXJdza+hx-NkrhDoxrw@mail.gmail.com>
	<20170408000823-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170408000823-mutt-send-email-mst@kernel.org>
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
Cc: Willem de Bruijn <willemb@google.com>, Network Development <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 7, 2017 at 5:10 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Apr 07, 2017 at 04:59:58PM -0400, Willem de Bruijn wrote:
>> On Fri, Apr 7, 2017 at 3:28 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Mon, Apr 03, 2017 at 01:02:13AM -0400, Willem de Bruijn wrote:
>> >> On Sun, Apr 2, 2017 at 10:47 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > On Sun, Apr 02, 2017 at 04:10:12PM -0400, Willem de Bruijn wrote:
>> >> >> From: Willem de Bruijn <willemb@google.com>
>> >> >>
>> >> >> Amortize the cost of virtual interrupts by doing both rx and tx work
>> >> >> on reception of a receive interrupt if tx napi is enabled. With
>> >> >> VIRTIO_F_EVENT_IDX, this suppresses most explicit tx completion
>> >> >> interrupts for bidirectional workloads.
>> >> >>
>> >> >> Signed-off-by: Willem de Bruijn <willemb@google.com>
>> >
>> > This is a popular approach, but I think this will only work well if tx
>> > and rx interrupts are processed on the same CPU and if tx queue is per
>> > cpu.  If they target different CPUs or if tx queue is used from multiple
>> > CPUs they will conflict on the shared locks.
>>
>> Yes. As a result of this discussion I started running a few vcpu affinity tests.
>>
>> > This can even change dynamically as CPUs/queues are reconfigured.
>> > How about adding a flag and skipping the tx poll if there's no match?
>>
>> I suspect that even with the cache invalidations this optimization
>> will be an improvement over handling all tx interrupts in the tx napi
>> handler. I will get the datapoint for that.
>>
>> That said, we can make this conditional. What flag exactly do you
>> propose? Compare raw_smp_processor_id() in the rx softint with one
>> previously stored in the napi tx callback?
>
> I'm not sure. Another idea is to check vi->affinity_hint_set.
> If set we know rq and sq are on the same CPU.

I was not aware of that flag, thanks. Yes, that looks like it should work.
