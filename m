From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: rework
	VIRTIO_BALLOON_F_MUST_TELL_HOST feature, support silent deflation
Date: Tue, 28 May 2013 14:04:03 +0200
Message-ID: <51A49D33.8090008@redhat.com>
References: <1368007813-1264-1-git-send-email-pbonzini@redhat.com>
	<51A381D9.5010800@redhat.com> <20130527160437.GA18270@redhat.com>
	<51A38552.9050808@redhat.com> <20130527170259.GA18800@redhat.com>
	<51A46D0B.9080508@redhat.com> <20130528104503.GD5467@redhat.com>
	<51A4913F.5050206@redhat.com> <20130528114402.GA21107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130528114402.GA21107@redhat.com>
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

Il 28/05/2013 13:44, Michael S. Tsirkin ha scritto:
> negotiated in spec means "present and acked by guest".
> We can try and replace "negotiated" by "present and acked by guest"
> everywhere - think it will be clearer?

No, I understand what negotiated means.  But in this case, "negotiated"
is not the word that you want.

>>>> Now rereading it, it may be correct, but it is not clear enough.
>>>>
>>>> Perhaps my patch is even too verbose, but it doesn't leave anything open
>>>> for interpretation.
>>>
>>> I'm fine with adding more clarifications but I don't yet see why
>>> do we need a new bit.
>>
>> There are three cases:
>>
>> 1) the drivers is not able to tell the host first (or never tell the
>> host at all), like the Windows driver or the Google fileballoon driver.
>>  If the host always wants to be told first (e.g. a hypothetical
>> virtio-balloon running on Xen) it should somehow prevent these drivers
>> from running.
> 
> I don't think hosts that always want to be told first can exist.
> Handling guests that don't tell first is super easy -
> e.g. just don't do anything.

Of course you can work around it and not do anything.  This doesn't
change the fact that the host needs to know whether to actually balloon
out pages, or fake it.

>> 2) the driver will always tell the host first, like the Linux driver.
>> The host can trust the guest to do the right thing.
> 
> It should not if guest did not ack the feature bit.

Of course.

1 = guest doesn't ack feature bit, host may have to "fake" ballooning
2 or 3 = guest acks feature bit, host assumes that guest will tell first

>> 3) the driver wants to optimize if the host can be told last (or not
>> told altogether).  Again, the host can trust the guest to do the right
>> thing, but there are two possible behaviors for the guest driver.
>>
>> The existing bit lets the host distinguish 1 from 2+3.  The other bit is
>> needed for the guest to pick the right behavior in case 3.
> 
> 1 does not exist.

1 does not exist in the sense that it's always possible to work around
the problem.  But you need to know when to work around it.  In that
sense, 1 exists.

> And guests simply do not treat the existing bit as your spec patch says
> they should. Instead they treat it as they would treat your new bit.

How so?  I even changed the name of the existing bit to
VIRTIO_F_GUEST_TELLS_HOST.

Paolo
