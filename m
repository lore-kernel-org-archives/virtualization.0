From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for
	host-guest	communication
Date: Mon, 10 Aug 2009 16:02:36 +0200
Message-ID: <4A80287C.7050400__2466.00335599414$1249913348$gmane$org@redhat.com>
References: <20090805175713.GB28738@shareable.org>	<4A79C8D9.5030606@codemonkey.ws>	<20090806103843.GC9222@amit-x200.redhat.com>	<4A7ADAC4.70902@codemonkey.ws>	<20090806134103.GC11733@amit-x200.redhat.com>	<4A7AE169.4000606@codemonkey.ws>	<20090806140404.GA12083@amit-x200.redhat.com>	<20090806173740.GA1178@shareable.org>	<20090807063800.GA16769@amit-x200.redhat.com>	<4A7C36D3.3040305@codemonkey.ws>
	<20090810065508.GA4499@amit-x200.redhat.com>
	<4A7FECCA.8080804@redhat.com> <4A801A7B.1020208@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A801A7B.1020208@codemonkey.ws>
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/10/09 15:02, Anthony Liguori wrote:

> I think you're missing my fundamental point. Don't use the kernel as the
> guest interface.
>
> Introduce a userspace daemon that exposes a domain socket. Then we can
> have a proper protocol that uses reverse fqdns for identification.

We need nothing but (a) bidirectional byte streams and (b) name tags for 
them.

Do we really want design a daemon and a protocol for such a simple 
thing?  Especially as requiring a daemon for that adds a few problems 
you don't have without them.  Access control for example:  For device 
nodes you can just use standard unix permissions and acls.  You can 
easily do stuff like adding the logged in desktop user to the 
/dev/vmchannel/org/qemu/clipboard acl using existing solutions.  With a 
daemon you have to hop through a number of loops to archive the same.

Can't we simply have guest apps open "/dev/vmchannel/$protocol" ?

cheers,
   Gerd
