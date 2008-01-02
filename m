From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [kvm-devel] [Virtio-for-kvm] [PATCH 7/7] userspace virtio
Date: Wed, 02 Jan 2008 23:45:37 +0200
Message-ID: <477C0601.2040508__25305.217880714$1199310474$gmane$org@qumranet.com>
References: <476BD1A9.2040701@qumranet.com> <477BB5D2.6010304@us.ibm.com>
	<477BC853.405@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <477BC853.405@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>> I think we should hold off on this sort of patch at first.  I know it 
>> improves performance, but it's very hack-ish.  I have a similar 
>> patch[1] that improves performance more but is even more hack-ish.
>>
>> I think we have to approach this by not special cases virtio-net to 
>> know about the tap fd, but to figure out the interface that 
>> virtio-net would need to be efficient, and then refactor the net 
>> interface to look like that.  Then we can still support user, pcap, 
>> and the other network transports.
>>
>> [1] http://hg.codemonkey.ws/qemu-virtio/file/75cefe566cea/aio-net.diff
>>   
>
> While you are right in principle, high performance networking is long 
> overdue in kvm so I applied that patch.  Once a mega async dma 
> framework is added to qemu, we'll just revert that patch prior to 
> adding the glue to said framework.
>
I second Avi, the reason we wanted quick (and ugly) performance patch 
merged was because people are trying kvm and sometime
get disappointed of IO performance. Since we did have unmerged pv net 
for quite a while, we're pushing towards merging it.
We can't wait for qemu guys to merge it and we also plan to develop host 
kernel pv network side.

btw: My hack leaves the -user support but with the previous performance.
I'll add the tx improvement too.

Thanks for the backward compat patch :)
Dor
