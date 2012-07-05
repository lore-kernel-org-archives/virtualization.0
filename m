From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-blk: allow toggling host cache between writeback
	and writethrough
Date: Thu, 05 Jul 2012 08:45:56 +0200
Message-ID: <4FF53824.6090303@redhat.com>
References: <1341321577-24435-1-git-send-email-pbonzini@redhat.com>
	<20120704154220.GB27064@redhat.com> <4FF46728.7030302@redhat.com>
	<20120704160258.GB27271@redhat.com> <4FF46A92.3020009@redhat.com>
	<20120704213037.GA27713@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120704213037.GA27713@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 04/07/2012 23:30, Michael S. Tsirkin ha scritto:
>>>>>> +static int virtblk_get_cache_mode(struct virtio_device *vdev)
>>>>>
>>>>> Why are you converting u8 to int here?
>>>>
>>>> The fact that it is a u8 is really an internal detail.  Perhaps the bug
>>>> is using u8 in the callers.
>>>
>>> Make it bool then?
>>>
>>> You are using u8 in the config. So you could get any value
>>> besides 0 and 1, and you interpret that as 1.
>>> Is 1 always a safe value? If not maybe it's better to set
>>> to a safe value if it is not 0 or 1, that is we don't know how to interpret it.
>>
>> That would be a host bug; the spec only gives meaning to 0 and 1.
> 
> Yes but if the other side does not validate values implementations
> *will* have bugs. Why not declare bits 1-7 reserved?

Ok, that would be a different change.  I thought about it yesterday, but
it seemed like a useless complication.  It's not like we have been
adding configuration fields every other week. :)

But I can certainly prepare patches to both virtio-blk and the spec for
that if you prefer.

Paolo
