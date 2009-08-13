From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] qemu/virtio: move features to an
	inline function
Date: Thu, 13 Aug 2009 09:15:22 +0300
Message-ID: <20090813061522.GD3029@redhat.com>
References: <20090810194753.GA16803@redhat.com>
	<4A808437.8040307@codemonkey.ws>
	<20090810221940.GB17099@redhat.com>
	<4A80A0A1.2020905@codemonkey.ws> <20090811084807.GA3029@redhat.com>
	<4A816EEB.4070707@codemonkey.ws>
	<20090811134331.GA22661@redhat.com>
	<4A819780.4040002@codemonkey.ws>
	<20090811162537.GA25705@redhat.com>
	<4A83157C.9040009@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A83157C.9040009@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: avi@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 12, 2009 at 02:18:20PM -0500, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>> On
>>   
>>> Why bother switching to userspace for migration?  Can't you just have 
>>>  get/set ioctls for the state?
>>>     
>>
>> I have these. But live migration requires dirty page logging.
>> I do not want to implement it in kernel.
>>   
>
> Is it really that difficult?  I think it would be better to just do that.

The idea is if it can be in userspace, let's keep it there.

> I wonder though if mmu notifiers can be used to make it transparent...

Maybe they can, but that decision belongs to KVM.
Avi, what do you think?

> Regards,
>
> Anthony Liguori
>
>>> Regards,
>>>
>>> Anthony Liguori
>>>
>>>     
