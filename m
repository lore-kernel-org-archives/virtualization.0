From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Mon, 01 Jul 2013 09:17:13 +0930
Message-ID: <87ppv3tb3y.fsf@rustcorp.com.au>
References: <20130314111020.GA18050@redhat.com> <5141E990.7070609@redhat.com>
	<20130314173918.GB29411@redhat.com>
	<87k3lyzknl.fsf@rustcorp.com.au>
	<20130613080259.GA11175@redhat.com>
	<20130613081047.GA11269@redhat.com>
	<20130617063746.GA5693@redhat.com> <87r4fyn1wx.fsf@rustcorp.com.au>
	<20130619082417.GA2558@redhat.com>
	<51C16BC2.2060302@redhat.com> <8761x9mrmk.fsf@rustcorp.com.au>
	<51C2CABD.70000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51C2CABD.70000@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il 20/06/2013 04:40, Rusty Russell ha scritto:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>> Il 19/06/2013 10:24, Michael S. Tsirkin ha scritto:
>>>>>> 2) We introduce VIRTIO_NET_F_ANY_LAYOUT and VIRTIO_BLK_F_ANY_LAYOUT
>>>>>>    specifically for net and block (note the new names).
>>>
>>> So why not a transport feature?  Is it just because the SCSI commands
>>> for virtio-blk also require a config space field?  Sorry if I missed
>>> this upthread.
>> 
>> Mainly because I'm not sure that *all* devices are now safe.  Are they?
>
> virtio-scsi's implementation in QEMU is not safe (been delaying that for
> too long, sorry), but the spec is safe.

Then if we added a transport feature, we couldn't use it :(

So I think it needs to be a per-device feature bit.

Cheers,
Rusty.
