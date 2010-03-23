From: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] vhost-blk implementation
Date: Tue, 23 Mar 2010 10:57:33 -0700
Message-ID: <4BA9010D.6010607@us.ibm.com>
References: <1269304444.7931.68.camel@badari-desktop>
	<20100323123916.GA24750@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100323123916.GA24750@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Discussion of kvm memory usage <kvm-memory@lists.linux.ibm.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> On Mon, Mar 22, 2010 at 05:34:04PM -0700, Badari Pulavarty wrote:
>   
>> Write Results:
>> ==============
>>
>> I see degraded IO performance when doing sequential IO write
>> tests with vhost-blk compared to virtio-blk.
>>
>> # time dd of=/dev/vda if=/dev/zero bs=2M oflag=direct
>>
>> I get ~110MB/sec with virtio-blk, but I get only ~60MB/sec with
>> vhost-blk. Wondering why ?
>>     
>
> Try to look and number of interrupts and/or number of exits.
>   

I checked interrupts and IO exits - there is no major noticeable 
difference between
vhost-blk and virtio-blk scenerios.
> It could also be that you are overrunning some queue.
>
> I don't see any exit mitigation strategy in your patch:
> when there are already lots of requests in a queue, it's usually
> a good idea to disable notifications and poll the
> queue as requests complete. That could help performance.
>   
Do you mean poll eventfd for new requests instead of waiting for new 
notifications ?
Where do you do that in vhost-net code ?

Unlike network socket, since we are dealing with a file, there is no 
->poll support for it.
So I can't poll for the data. And also, Issue I am having is on the 
write() side.

I looked at it some more - I see 512K write requests on the virtio-queue 
in both
vhost-blk and virtio-blk cases. Both qemu or vhost is doing synchronous 
writes
to page cache (there is no write batching in qemu that is affecting this 
case).
I still puzzled on why virtio-blk outperforms vhost-blk.

Thanks,
Badari
