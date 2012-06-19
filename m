From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Tue, 19 Jun 2012 10:51:18 +0800
Message-ID: <4FDFE926.7030309@redhat.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-4-git-send-email-asias@redhat.com>
	<87hau9yse7.fsf@rustcorp.com.au> <4FDEE0CB.1030505@redhat.com>
	<87zk81x7dp.fsf@rustcorp.com.au> <4FDF0DA7.40604@redhat.com>
	<1340019575.22848.2.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1340019575.22848.2.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On 06/18/2012 07:39 PM, Sasha Levin wrote:
> On Mon, 2012-06-18 at 14:14 +0300, Dor Laor wrote:
>> On 06/18/2012 01:05 PM, Rusty Russell wrote:
>>> On Mon, 18 Jun 2012 16:03:23 +0800, Asias He<asias@redhat.com>  wrote:
>>>> On 06/18/2012 03:46 PM, Rusty Russell wrote:
>>>>> On Mon, 18 Jun 2012 14:53:10 +0800, Asias He<asias@redhat.com>  wrote:
>>>>>> This patch introduces bio-based IO path for virtio-blk.
>>>>>
>>>>> Why make it optional?
>>>>
>>>> request-based IO path is useful for users who do not want to bypass the
>>>> IO scheduler in guest kernel, e.g. users using spinning disk. For users
>>>> using fast disk device, e.g. SSD device, they can use bio-based IO path.
>>>
>>> Users using a spinning disk still get IO scheduling in the host though.
>>> What benefit is there in doing it in the guest as well?
>>
>> The io scheduler waits for requests to merge and thus batch IOs
>> together. It's not important w.r.t spinning disks since the host can do
>> it but it causes much less vmexits which is the key issue for VMs.
>
> Is the amount of exits caused by virtio-blk significant at all with
> EVENT_IDX?

Yes. EVENT_IDX saves the number of notify and interrupt. Let's take the 
interrupt as an example, The guest fires 200K request to host, the 
number of interrupt is about 6K thanks to EVENT_IDX. The ratio is 200K / 
6K = 33. The ratio of merging is 40000K / 200K = 20.

-- 
Asias
