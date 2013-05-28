From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: rework
	VIRTIO_BALLOON_F_MUST_TELL_HOST feature, support silent deflation
Date: Tue, 28 May 2013 10:38:35 +0200
Message-ID: <51A46D0B.9080508@redhat.com>
References: <1368007813-1264-1-git-send-email-pbonzini@redhat.com>
	<51A381D9.5010800@redhat.com> <20130527160437.GA18270@redhat.com>
	<51A38552.9050808@redhat.com> <20130527170259.GA18800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130527170259.GA18800@redhat.com>
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

Il 27/05/2013 19:02, Michael S. Tsirkin ha scritto:
>>> So if we don't want to require all guests to tell host
>>> first, all we need to do is admit it's not a bug.
>>
>> I think we want the possibility for the host to require that.
> 
> But why? TELL_HOST makes some optimizations possible, but if
> guest won't cooperate, balloon is useless anyway.

If the guest won't tell host and still propose the feature, then we can
crash it.  So we need to know what the guest is going to do, in order to
enable/disable the optimization.

> If guest cooperates we don't have to require anything,
> just go with what guest tells us it will do.

Yes.

>>> Please see
>>> 	[PATCH] virtio-spec: balloon: MUST_TELL_HOST is optional
>>> that does exactly this.
>>
>> That patch mandates a change in guest behavior that is not compatible
>> with the existing Windows driver.  Mine doesn't.
>>
>> Paolo
> 
> Hmm I don't see it.
> In fact the goal was to document the Windows driver behaviour
> as correct.
> Can you explain the incompatibility please?

Whenever "If the X feature is (not) negotiated" is used in the spec, it
means "in general you should be ready to implement both behaviors", or
perhaps the guest should fail to initialize if the feature is not available.

Here it is the other way round.  The existing guest is not checking the
outcome of the negotiation, so the host must check whether negotiation
happened and possibly fail the initialization of the device.  It is
sufficiently different from any other case that I don't think a one-word
change is enough.

The way I read it yesterday I didn't see any change from the current
specification, so the problem of having a "negative feature" remains.
Now rereading it, it may be correct, but it is not clear enough.

Perhaps my patch is even too verbose, but it doesn't leave anything open
for interpretation.

Paolo
