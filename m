From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] virtio-blk: Add stats VQ to collect information about
	devices
Date: Sun, 21 Aug 2011 18:31:18 -0500
Message-ID: <4E519546.1050406__32714.7003532902$1313969550$gmane$org@codemonkey.ws>
References: <1313524071-27250-1-git-send-email-levinsasha928@gmail.com>	
	<4E4C481A.5080205@redhat.com> <1313642283.22532.4.camel@lappy>	
	<4E4D2B6D.1040908@redhat.com> <1313684984.30799.20.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1313684984.30799.20.camel@lappy>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Pekka Enberg <penberg@kernel.org>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On 08/18/2011 11:29 AM, Sasha Levin wrote:
> On Thu, 2011-08-18 at 08:10 -0700, Avi Kivity wrote:
>> On 08/17/2011 09:38 PM, Sasha Levin wrote:
>>> On Wed, 2011-08-17 at 16:00 -0700, Avi Kivity wrote:
>>>>   On 08/16/2011 12:47 PM, Sasha Levin wrote:
>>>>   >   This patch adds support for an optional stats vq that works similary to the
>>>>   >   stats vq provided by virtio-balloon.
>>>>   >
>>>>   >   The purpose of this change is to allow collection of statistics about working
>>>>   >   virtio-blk devices to easily analyze performance without having to tap into
>>>>   >   the guest.
>>>>   >
>>>>   >
>>>>
>>>>   Why can't you get the same info from the host?  i.e. read sectors?
>>>
>>> Some of the stats you can collect from the host, but some you can't.
>>>
>>> The ones you can't include all the timing statistics and the internal
>>> queue statistics (read/write merges).
>>
>> Surely you can time the actual amount of time the I/O takes?  It doesn't
>> account for the virtio round-trip, but does it matter?
>>
>> Why is the merge count important for the host?
>>
>
> I assumed that the time the request spends in the virtio layer is
> (somewhat) significant, specially since that this is something that adds
> up over time.
>
> Merge count can be useful for several testing scenarios (I'll describe
> the reasoning behind this patch below).
>
>>>
>>> The idea behind providing all of the stats on the stats vq (which is
>>> basically what you see in '/dev/block/[device]/stats') is to give a
>>> consistent snapshot of the state of the device.
>>>
>>>
>>
>> What can you do with it?
>>
>
> I was actually planning on submitting another patch that would add
> something similar into virtio-net. My plan was to enable collecting
> statistics regarding memory, network and disk usage in a simple manner
> without accessing guests.

Why not just add an interface that lets you read files from a guest 
either via a guest agent (like qemu-ga) or a purpose built PV device?

That would let you access the guest's full sysfs which seems to be quite 
a lot more useful long term than adding a bunch of specific interfaces.

Regards,

Anthony Liguori
