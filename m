From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Mon, 21 Jan 2013 22:22:03 +1030
Message-ID: <87r4levjmk.fsf@rustcorp.com.au>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
	<20130117112314.GA15504@redhat.com>
	<877gn7w9fc.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <877gn7w9fc.fsf@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> writes:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>> +		iov->iov[iov->i].iov_base = (__force __user void *)addr;
>>> +		iov->iov[iov->i].iov_len = desc.len;
>>
>> The following comment from the previous version still applies:
>> 	> This looks like it won't do the right thing if desc.len spans multiple
>> 	> ranges. I don't know if this happens in practice but this is something
>> 	> vhost supports ATM.
>> in otgher words, we might need to split a single desc to multiple
>> iov entries.
>
> Ah, separate offsets for consecutive ranges, right.  I'd prefer to say
> "don't do that", but qemu is rarely sane.  I'll fix it.

Actually, you make the same assumption for vhost, with your use of
getuser and putuser for accessing the ring.

The complexity and cost of handling this is significant, and the error
if it ever did happen is distinctive.  Does qemu ever create such
things?

Thanks,
Rusty.
