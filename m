From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Thu, 20 Aug 2009 18:10:18 +0100
Message-ID: <20090820171018.GA2370__42549.0543283106$1250788529$gmane$org@shareable.org>
References: <20090806173740.GA1178@shareable.org>
	<4A856B5E.2000303@redhat.com> <4A858FFC.7000607@codemonkey.ws>
	<200908201701.30467.rusty@rustcorp.com.au>
	<4A8CFEDD.4000009@redhat.com>
	<20090820075539.GA5876@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090820075539.GA5876@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> > I think strings are better as numbers for identifying protocols as you  
> > can work without a central registry for the numbers then.
> 
> I like the way assigned numbers work: it's simpler to code, needs a
> bitmap for all the ports that fits in nicely in the config space and
> udev rules / scripts can point /dev/vmch02 to /dev/console.

How would a third party go about assigning themselves a number?

For the sake of example, imagine they develop a simple service like
"guesttop" which let's the host get a listing of guest processes.

They'll have to distributed app-specific udev rule patches for every
guest distro, which sounds like a lot of work.  The app itself is
probably a very simple C program; the hardest part of making it
portable across distros would be the udev rules, which is silly.

Anyway, every other device has a name or uuid these days.  You can
still use /dev/sda1 to refer to your boot partition, but LABEL=boot is
also available if you prefer.  Isn't that the ethos these days?

Why not both?  /dev/vmch05 if you prefer, plus symlink
/dev/vmch-guesttop -> /dev/vmch05 if name=guesttop was given to QEMU.

If you do stay with numbers only, note that it's not like TCP/UDP port
numbers because the number space is far smaller.  Picking a random
number that you hope nobody else uses is harder.

... Back to technical bits.  If config space is tight, use a channel!
Dedicate channel 0 to control, used to fetch the name (if there is
one) for each number.

-- Jamie
