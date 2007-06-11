From: Avi Kivity <avi@qumranet.com>
Subject: Re: [Xen-devel] Re: More virtio users
Date: Mon, 11 Jun 2007 11:19:23 +0300
Message-ID: <466D058B.3000606__3414.59090491316$1181550054$gmane$org@qumranet.com>
References: <466BA965.6050208@qumranet.com>
	<1181463220.16428.24.camel@localhost.localdomain>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
>   Hi,
>
>> Framebuffer is an interesting one.  Virtio doesn't assume shared memory,
>> so naively the fb you would just send outbufs describing changed memory.
>> This would work, but describing rectangles is better.  A helper might be
>> the right approach here
>
> Rectangles work just fine for a framebuffer console.  They stop 
> working once you plan to run any graphical stuff such as an X-Server 
> on top of the framebuffer.  Only way to get notified about changes is 
> page faults, i.e. 4k granularity on the linear framebuffer memory.
>

For X an accelerated device is probably much better than a dumb framebuffer.

> Related to Framebuffer is virtual keyboard and virtual mouse (or 
> better touchscreen), which probably works perfectly fine with virtio.  
> I'd guess you can even reuse the input layer event struct for the 
> virtio events.

Need to be careful if we want to support non-Linux guests.


-- 
error compiling committee.c: too many arguments to function
