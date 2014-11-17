From: Venkateswara Rao Nandigam <venkateswararao.nandigam@citrix.com>
Subject: RE: vhost + multiqueue + RSS question.
Date: Mon, 17 Nov 2014 04:54:20 +0000
Message-ID: <5CC583AB71FC0C44A5CAB54823E83A8422B8ABD4__13428.2641964548$1416203948$gmane$org@SINPEX01CL01.citrite.net>
References: <20141116161818.GD7589@cloudius-systems.com>
	<20141116185604.GA12839@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141116185604.GA12839@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Gleb Natapov <gleb@cloudius-systems.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

I have a question related this topic. So How do you set the RSS Key on the Mellanox NIc? I mean from your Guest?

If it being set as part of Host driver, is there a way to set it from Guest? I mean my guest will choose a RSS Key and will try to set on the Physical NIC.

Thanks,
Venkatesh

-----Original Message-----
From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On Behalf Of Michael S. Tsirkin
Sent: Monday, November 17, 2014 12:26 AM
To: Gleb Natapov
Cc: kvm@vger.kernel.org; Jason Wang; virtualization@lists.linux-foundation.org
Subject: Re: vhost + multiqueue + RSS question.

On Sun, Nov 16, 2014 at 06:18:18PM +0200, Gleb Natapov wrote:
> Hi Michael,
> 
>  I am playing with vhost multiqueue capability and have a question 
> about vhost multiqueue and RSS (receive side steering). My setup has 
> Mellanox
> ConnectX-3 NIC which supports multiqueue and RSS. Network related 
> parameters for qemu are:
> 
>    -netdev tap,id=hn0,script=qemu-ifup.sh,vhost=on,queues=4
>    -device virtio-net-pci,netdev=hn0,id=nic1,mq=on,vectors=10
> 
> In a guest I ran "ethtool -L eth0 combined 4" to enable multiqueue.
> 
> I am running one tcp stream into the guest using iperf. Since there is 
> only one tcp stream I expect it to be handled by one queue only but 
> this seams to be not the case. ethtool -S on a host shows that the 
> stream is handled by one queue in the NIC, just like I would expect, 
> but in a guest all 4 virtio-input interrupt are incremented. Am I 
> missing any configuration?

I don't see anything obviously wrong with what you describe.
Maybe, somehow, same irqfd got bound to multiple MSI vectors?
To see, can you try dumping struct kvm_irqfd that's passed to kvm?


> --
> 			Gleb.
--
To unsubscribe from this list: send the line "unsubscribe kvm" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
