From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Wed, 04 Jul 2012 16:10:40 +0200
Message-ID: <4FF44EE0.9040200@redhat.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-4-git-send-email-asias@redhat.com>
	<87hau9yse7.fsf@rustcorp.com.au> <4FDEE0CB.1030505@redhat.com>
	<87zk81x7dp.fsf@rustcorp.com.au> <4FDF0DA7.40604@redhat.com>
	<4FF3001C.9020706@redhat.com> <4FF3017C.4020605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FF3017C.4020605@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dlaor@redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ronen Hod <rhod@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 03/07/2012 16:28, Dor Laor ha scritto:
>>>> Users using a spinning disk still get IO scheduling in the host though.
>>>> What benefit is there in doing it in the guest as well?
>>>
>>> The io scheduler waits for requests to merge and thus batch IOs
>>> together. It's not important w.r.t spinning disks since the host can
>>> do it but it causes much less vmexits which is the key issue for VMs.
>>
>> Does it make sense to use the guest's I/O scheduler at all?
> 
> That's the reason we have a noop io scheduler.

But is performance really better with noop?  We had to revert usage of
QUEUE_FLAG_NONROT in the guests because it caused performance
degradation (commit f8b12e513b953aebf30f8ff7d2de9be7e024dbbe).

The bio-based path is really QUEUE_FLAG_NONROT++, so it should really be
a special case for people who know what they're doing.  (Better would be
to improve QEMU, there's definitely room for 20% improvement...).

Paolo
