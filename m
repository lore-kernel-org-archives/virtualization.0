From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH resend] virtio_console: Free buffers from out-queue upon
	close
Date: Thu, 8 Nov 2012 10:25:43 +0100
Message-ID: <CAJK669bHafJMJ-eoiwoOiHG9bB1hjSp_8cRX4+26n9dMj50tTA@mail.gmail.com>
References: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
	<1350287856-5284-5-git-send-email-sjur.brandeland@stericsson.com>
	<878vayhsca.fsf@rustcorp.com.au>
	<20121101073951.GA17012@amit.redhat.com>
	<87r4oc52ov.fsf@rustcorp.com.au>
	<20121102102047.GE10483@amit.redhat.com>
	<81C3A93C17462B4BBD7E272753C1057923BE98E5C6@EXDCVYMBSTM005.EQ1STM.local>
	<1352298171-21869-1-git-send-email-sjur.brandeland@stericsson.com>
	<1352295822-22906-1-git-send-email-sjur.brandeland@stericsson.com>
	<87sj8l2cea.fsf@rustcorp.com.au>
	<20121108085913.GA31962@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121108085913.GA31962@amit.redhat.com>
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
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

>> > Note: This patch is compile tested only. I have done the removal
>> > of buffers from out-queue in handle_control_message()
>> > when host has acked the close request. This seems less
>> > racy than doing it in the release function.
>>
>> This confuses me... why are we doing this in case
>> VIRTIO_CONSOLE_PORT_OPEN:?
>>
>> We can't pull unconsumed buffers out of the ring when the other side may
>> still access it, and this seems to be doing that.
>
> Yes -- and it's my fault; I asked Sjur to do that in the close fops
> function.

Thanks Amit :-), but this was really my bad.

> We should only do this in the port remove case (unplug or device
> remove) -- so the original patch, with just the WARN_ON removed is the
> right way.
>
> I'll send the revised 3/3 patch for you.

Thank you.

Regards,
Sjur
