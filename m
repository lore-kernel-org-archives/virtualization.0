From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: [PATCH] qemu/virtio: move features to an inline
	function
Date: Wed, 12 Aug 2009 14:18:20 -0500
Message-ID: <4A83157C.9040009@codemonkey.ws>
References: <20090810192809.GA16800@redhat.com>
	<4A8076F0.5050700@codemonkey.ws>
	<20090810194753.GA16803@redhat.com>
	<4A808437.8040307@codemonkey.ws>
	<20090810221940.GB17099@redhat.com>
	<4A80A0A1.2020905@codemonkey.ws> <20090811084807.GA3029@redhat.com>
	<4A816EEB.4070707@codemonkey.ws>
	<20090811134331.GA22661@redhat.com>
	<4A819780.4040002@codemonkey.ws>
	<20090811162537.GA25705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090811162537.GA25705@redhat.com>
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
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> On
>   
>> Why bother switching to userspace for migration?  Can't you just have  
>> get/set ioctls for the state?
>>     
>
> I have these. But live migration requires dirty page logging.
> I do not want to implement it in kernel.
>   

Is it really that difficult?  I think it would be better to just do that.

I wonder though if mmu notifiers can be used to make it transparent...

Regards,

Anthony Liguori

>> Regards,
>>
>> Anthony Liguori
>>
>>     
