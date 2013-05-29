From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/2] virtio-balloon spec: rewrite description of
	VIRTIO_BALLOON_F_MUST_TELL_HOST
Date: Wed, 29 May 2013 10:45:35 +0200
Message-ID: <51A5C02F.8040301__21670.7697873519$1369817165$gmane$org@redhat.com>
References: <1369762818-8787-1-git-send-email-pbonzini@redhat.com>
	<1369762818-8787-2-git-send-email-pbonzini@redhat.com>
	<20130528181510.GC30968@redhat.com> <51A59F0A.80805@redhat.com>
	<20130529074522.GB4472@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130529074522.GB4472@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 29/05/2013 09:45, Michael S. Tsirkin ha scritto:
> On Wed, May 29, 2013 at 08:24:10AM +0200, Paolo Bonzini wrote:
>> Il 28/05/2013 20:15, Michael S. Tsirkin ha scritto:
>>> What you write in spec below and what you write above seems to
>>> contradict.
>>>
>>> Look, how about the simpler patch that I sent:
>>> "[PATCH] virtio-spec: balloon: MUST_TELL_HOST is optional"
>>>
>>> does it functionally do everything you want in this patch?
>>
>> No, though it is a step forward.
>>
>> But let's take a step back instead; here are the requirements:
>>
>> 1) old drivers work unmodified on new hosts
>>
>> 2) new drivers work unmodified on old guests, though it is okay if they
>> do not use silent deflation
>>
>> 3) if both the balloon and the driver supports silent deflation, it
>> should be used
> 
> I don't agree with this one.  We used to have this:
> bf50e69f63d21091e525185c3ae761412be0ba72
> and we dropped this patch.

I think it's telling that none of the benefits in the commit message
were ever reaped.  In fact they don't matter if you do not tell the host
at all.

>> 4) if the balloon has to enter a "degraded" mode of operation when
>> guests do not "tell first", this has to happen only for old guests
> 
> I don't agree with this either.
> I think if we make tell host optional, it's up to the guest whether
> to tell host.

Yes, let me rephrase: if the balloon has to enter a "degraded" mode of
operation when guests do not "tell first", new guests must have a way to
know that they should "tell first" and avoid that.

>> Basically, you're saying that the driver should set MUST_TELL_HOST to
>> !SILENT_DEFLATE.
> 
> No, I am saying if you don't want to tell host do not ack
> MUST_TELL_HOST.

I want to tell host _if it is necessary to do so_.  I don't want to tell
host if it can be avoided.

>>  However, in the Linux virtio implementation, features
>> are independent,
> 
> Not just in the implementation. We try to keep it like this in the spec
> too. One feature overriding another is messy.

There is at least one such case already.  VIRTIO_NET_F_HOST_TSO4
requires the guest to use large buffers, _unless_ VIRTIO_NET_F_MRG_RXBUF
is also negotiated.

Note that in the May 8th version there was no such overriding.  In that
version communication was unidirectional, host->guest for SILENT_DEFLATE
and guest->host for CAN_TELL_HOST.  SILENT_DEFLATE is set if the host
doesn't really care about CAN_TELL_HOST.  It is much much simpler.

>> and the feature list is told beforehand by the driver
>> to the virtio layer; with your proposal, the driver would have to
>> "retract" support for MUST_TELL_HOST after it has negotiated it.
> 
> And that's planned by design - we just never had the need to
> do this before.

And that's exactly why I want to make the feature bits unidirectional.
The guest tells the host what it can do, the host tells the guest what
it can accept.  The guest then acts based on what the host told it.

> You are confused by the implementation. Look at the spec.
> Also look at commit logs for c45a6816c19dee67b8f725e6646d428901a6dc24
> and c624896e488ba2bff5ae497782cfb265c8b00646.
> Specifically:
>     Drivers can still remove feature bits in their probe routine if they
>     really have to.

How so? virtio.c has this:

        dev->config->finalize_features(dev);
        err = drv->probe(dev);

>> This is why I'm making SILENT_DEFLATE=1 override MUST_TELL_HOST=1.
> 
> And that's messy I think. It is cleaner if features are independent.

In the original wording, they are independent.  I messed it up because
you wanted split patches.

>> In this case, saying "has to be told" is not entirely precise, but
>> "wants to be told" does not say that the operation is degraded.  Any
>> improvements on the wording are welcome.
> 
> Well I think if host "wants" something then that's exactly because
> it can optimize it better.
> If you like, add "host should set this feature bit if
> being notified before page reuse allows some host-side
> optimizations, for example conserving memory".

Ok.

>> In the previous version I just said that all hosts should set this
>> feature bit (and commented that old hosts can still be
>> upwards-compatible).
>>  I changed it because you didn't like it, but I
>> think the change is for the worse.  I still really prefer the version I
>> sent on May 8th.
> 
> Then you get into a mess with yet another feature bit
> which overrides an old feature bit.
> 
> Stop thinking about your new SILENT_DEFLATE for a moment,
> that's what confuses I think. Look at this change in isolation.

I am trying, but at the same time I don't want to put myself in the corner.

> Some hosts *might* not do anything when the balloon
> is inflated or deflated. But should above is still wrong.

Ok.

I'll try making a patch with the old feature bit only, and with the
assumption that all hosts support silent deflate.  Let's see what we
come up with.

Paolo
