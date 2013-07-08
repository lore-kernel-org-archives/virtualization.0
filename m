From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Mon, 08 Jul 2013 13:58:16 +0930
Message-ID: <87ehb9ekv3.fsf@rustcorp.com.au>
References: <20130613080259.GA11175@redhat.com>
	<20130613081047.GA11269@redhat.com>
	<20130617063746.GA5693@redhat.com> <87r4fyn1wx.fsf@rustcorp.com.au>
	<20130619082417.GA2558@redhat.com>
	<51C16BC2.2060302@redhat.com> <8761x9mrmk.fsf@rustcorp.com.au>
	<51C2CABD.70000@redhat.com> <87ppv3tb3y.fsf@rustcorp.com.au>
	<51D16EB8.3050709@redhat.com>
	<20130704073912.GE2095@redhat.com> <51D53AC9.80506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51D53AC9.80506@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:
> Il 04/07/2013 09:39, Michael S. Tsirkin ha scritto:
>>> > Transport feature bits are still negotiated per device though.
>>> > virtio-scsi devices in QEMU would not negotiate that feature.
>>> > 
>>> > Paolo
>>> > 
>>>> > > So I think it needs to be a per-device feature bit.
>> We don't know that it's helpful for any devices besides -net
>> so I'd say keep it simple.
>
> Then we should stop calling it a "device model bug".
>
> If we call it a bug, we must strive for support in all devices.  If we
> don't care, we should stop calling it a bug.

This has been a cause of hot debate: this bug has fossilized into a
feature, so we ignored it as long as we could :)

I plan on proposing that this be a requirement for the 1.0 spec, so we
might as well fix it everywhere now in preparation.

Cheers,
Rusty.
