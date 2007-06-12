From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Xen-devel] Re: More virtio users
Date: Mon, 11 Jun 2007 22:36:06 -0500
Message-ID: <466E14A6.6020400__11628.6584562205$1181619464$gmane$org@codemonkey.ws>
References: <466BA965.6050208@qumranet.com>	<1181463220.16428.24.camel@localhost.localdomain>	<466D04C2.8010403@redhat.com>
	<1181603983.16428.100.camel__36651.2330751449$1181608748$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181603983.16428.100.camel__36651.2330751449$1181608748$gmane$org@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Mon, 2007-06-11 at 10:16 +0200, Gerd Hoffmann wrote:
>> Hi,
>>
>>> Framebuffer is an interesting one.  Virtio doesn't assume shared memory,
>>> so naively the fb you would just send outbufs describing changed memory.
>>> This would work, but describing rectangles is better.  A helper might be
>>> the right approach here
>> Rectangles work just fine for a framebuffer console.  They stop working 
>> once you plan to run any graphical stuff such as an X-Server on top of 
>> the framebuffer.  Only way to get notified about changes is page faults, 
>> i.e. 4k granularity on the linear framebuffer memory.
> 
> Yes, I discussed this with Ben Herrenschmidt a couple of months ago.  It
> would be better to provide a fb ioctl which X could use to describe
> changed rectangles if available.  In the virtio case we could hand that
> information through, and other virtualized framebuffers would be able to
> use it similarly.

The X fbdev driver is going to make supporting a new fb ioctl pretty 
fun.  It currently doesn't even support the existing fb ioctls and has a 
strange abstraction layer.

I reckon writing a new X driver from scratch (or based on something like 
the vnc X driver) would be easier in the long run.

Regards,

Anthony Liguori


> Cheers,
> Rusty.
