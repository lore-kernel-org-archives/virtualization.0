From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Sun, 03 Jun 2007 20:29:00 +1000
Message-ID: <1180866540.17442.74.camel__33166.4598234513$1180866710$gmane$org@localhost.localdomain>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<46610E8D.10706@qumranet.com>
	<1180777836.9228.44.camel@localhost.localdomain>
	<46625192.5020108@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46625192.5020108@qumranet.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-06-03 at 08:28 +0300, Avi Kivity wrote:
> Sure, 'used' is important (how else do you get the packet size on
> receive?)

Well, the sender can prepend the length, or for networking just leave
Linux to trim packets.  It's the trust issue which bugs me.

> ,  I'm just bitching about the linear scan.

If you're doing interrupt mitigation on a high-bandwidth device, I think
it's optimal.  And if you're not, you obviously don't care 8)

That said, thousands of descriptors may not be insane...

> Well, if you have 256 slots per direction, you will scan 4KB of memory
> per interrupt (256 slots x 2 directions x 8 bytes).  You may need a
> queue length greater than 256 for a high bandwidth interface, if you
> want to reduce your interrupt rate, or if your guest is scheduled out
> for lengthy periods (say, a millisecond).

Hmm... Perhaps I should move the used arrays into the "struct
virtio_device" and guarantee that the id (returned by add_*buf) is an
index into that.  Then we can trivially add a corresponding bit array.

This also makes the "id" easier to use from the driver side: if we add a
"max_id" field it can size its own arrays if it wants to.  Gets rid of
the linked-list in the block driver...

Thoughts?
Rusty.
