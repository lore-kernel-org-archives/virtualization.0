From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [Xen-devel] Re: More virtio users
Date: Mon, 11 Jun 2007 14:24:35 -0500
Message-ID: <466DA173.70205__10722.9977650151$1181589986$gmane$org@us.ibm.com>
References: <466BA965.6050208@qumranet.com>	<1181463220.16428.24.camel@localhost.localdomain>
	<466D04C2.8010403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <466D04C2.8010403@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
>   Hi,
> 
>> Framebuffer is an interesting one.  Virtio doesn't assume shared memory,
>> so naively the fb you would just send outbufs describing changed memory.
>> This would work, but describing rectangles is better.  A helper might be
>> the right approach here
> 
> Rectangles work just fine for a framebuffer console.  They stop working 
> once you plan to run any graphical stuff such as an X-Server on top of 
> the framebuffer.  Only way to get notified about changes is page faults, 
> i.e. 4k granularity on the linear framebuffer memory.
> 
> Related to Framebuffer is virtual keyboard and virtual mouse (or better 
> touchscreen), which probably works perfectly fine with virtio.  I'd 
> guess you can even reuse the input layer event struct for the virtio 
> events.

Virtio seems like overkill for either of those things.  It's necessary 
for pure PV but not at all necessary for something like KVM.

> Xen has virtual framebuffer, kbd & mouse, although not (yet?) in the 
> paravirt_ops patch queue, so there is something you can look at ;)

In retrospect, IMHO, a shared framebuffer was a bad idea for Xen.  It's 
easy enough for dealing with an unaccelerated display, but once you 
start getting into more advanced features like blitting (which is really 
important actually for decent VNC performance), the synchronization 
becomes a big problem.

If we were to do a PV display driver again, I really think something 
that is closer to a VNC protocol is the right way to go.  There simply 
isn't a significant performance overhead to copying the relatively small 
amount of memory.

So virtio in it's current form would actually be pretty useful for that.

Regards,

Anthony Liguori


> cheers,
>   Gerd
