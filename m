From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH] kvm guest balloon driver
Date: Tue, 08 Jan 2008 18:18:13 +0200
Message-ID: <4783A245.90002__48629.8163225458$1199809309$gmane$org@qumranet.com>
References: <20080108153356.GA21726@dmt> <478399D5.9030707@codemonkey.ws>
	<20080108161005.GA22168@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080108161005.GA22168@dmt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Marcelo Tosatti wrote:

 

>> Why is it taking over the irq?  This is very, very wrong.  A virtio 
>> device cannot be dependent on being used on top of the virtio-pci backend.
>>     
>
> A notification is necessary whenever the host changes the target value
> in the config space. So right now this notification is sharing the
> same IRQ as the main PCI device.
>
> Do you have any suggestion on how to retrieve the IRQ of the virtio
> device, or some other notification mechanism?
>   

One way would be to send a "look at config" queue message, but it seems 
that it is a fairly generic operation.  Maybe virtio can add support for 
it, with a new callback.

-- 
error compiling committee.c: too many arguments to function
