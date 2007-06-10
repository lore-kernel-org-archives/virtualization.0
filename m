From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [Xen-devel] More virtio users
Date: Sun, 10 Jun 2007 11:06:02 +0300
Message-ID: <20070610080602.GD3738__4051.54276309094$1181462862$gmane$org@rhun.haifa.ibm.com>
References: <466BA965.6050208@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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

On Sun, Jun 10, 2007 at 10:33:57AM +0300, Avi Kivity wrote:
> It is worthwhile, when designing virtio, to keep in mind as many 
> possible users as possible.  In addition to block and net, I see at 
> least the following:
> 
> - vmgl (paravirtualized 3D graphics) 
> [http://www.cs.toronto.edu/~andreslc/xen-gl/]
> - scsi (for tape, cd writer, etc.)
> - framebuffer (with just one request to share the framebuffer?)
> 
> There are probably more.  Any ideas?

- Fast inter-domain networking, a-la XenSocket.
- PCI (or your favorite HW bus) passthrough, for your favorite oddball
  device (e.g., crypto-accelerators).

Cheers,
Muli
