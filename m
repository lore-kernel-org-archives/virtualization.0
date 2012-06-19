From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Tue, 19 Jun 2012 10:39:13 +0800
Message-ID: <4FDFE651.20207@redhat.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-4-git-send-email-asias@redhat.com>
	<87hau9yse7.fsf@rustcorp.com.au> <4FDEE0CB.1030505@redhat.com>
	<87zk81x7dp.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87zk81x7dp.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On 06/18/2012 06:05 PM, Rusty Russell wrote:
> On Mon, 18 Jun 2012 16:03:23 +0800, Asias He <asias@redhat.com> wrote:
>> On 06/18/2012 03:46 PM, Rusty Russell wrote:
>>> On Mon, 18 Jun 2012 14:53:10 +0800, Asias He <asias@redhat.com> wrote:
>>>> This patch introduces bio-based IO path for virtio-blk.
>>>
>>> Why make it optional?
>>
>> request-based IO path is useful for users who do not want to bypass the
>> IO scheduler in guest kernel, e.g. users using spinning disk. For users
>> using fast disk device, e.g. SSD device, they can use bio-based IO path.
>
> Users using a spinning disk still get IO scheduling in the host though.
> What benefit is there in doing it in the guest as well?

Merging in guest kernel's IO scheduling can reduce the number of 
requests guest fires to host side. For instance, with the same workload 
in guest side, the number of request drops to ~200K from ~4000K with 
guest kernel's merging in qemu.

>
> Cheers,
> Rusty.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Asias
