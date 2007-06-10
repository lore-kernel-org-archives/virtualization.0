From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: More virtio users
Date: Sun, 10 Jun 2007 18:13:40 +1000
Message-ID: <1181463220.16428.24.camel__14932.2388614111$1181463319$gmane$org@localhost.localdomain>
References: <466BA965.6050208@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <466BA965.6050208@qumranet.com>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-06-10 at 10:33 +0300, Avi Kivity wrote:
> It is worthwhile, when designing virtio, to keep in mind as many 
> possible users as possible.  In addition to block and net, I see at 
> least the following:
> 
> - vmgl (paravirtualized 3D graphics) 
> [http://www.cs.toronto.edu/~andreslc/xen-gl/]
> - scsi (for tape, cd writer, etc.)
> - framebuffer (with just one request to share the framebuffer?)

Console, USB.  HPA suggested an entropy device.

Framebuffer is an interesting one.  Virtio doesn't assume shared memory,
so naively the fb you would just send outbufs describing changed memory.
This would work, but describing rectangles is better.  A helper might be
the right approach here

Lguest doesn't have a framebuffer, so maybe this is a good thing for me
to hack on, but I promised myself I'd finish NAPI for the net device,
and tag for block device first.

Cheers,
Rusty.
