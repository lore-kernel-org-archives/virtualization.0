From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH V2 net-next 2/6] sctp: Handle sctp packets with
	CHECKSUM_PARTIAL
Date: Mon, 20 Aug 2018 15:39:32 +0000
Message-ID: <a9c9c7f8bb89475c84d665bfdc182f57__9393.92440855063$1534779431$gmane$org@AcuMS.aculab.com>
References: <20180502020739.19239-1-vyasevic@redhat.com>
	<20180502020739.19239-3-vyasevic@redhat.com>
	<20180502143824.GF5105@localhost.localdomain>
	<20180820145415.GA5310@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180820145415.GA5310@localhost.localdomain>
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
To: 'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>, Vladislav Yasevich <vyasevich@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Marcelo Ricardo Leitner
> Sent: 20 August 2018 15:54
> On Wed, May 02, 2018 at 11:38:24AM -0300, Marcelo Ricardo Leitner wrote:
> > On Tue, May 01, 2018 at 10:07:35PM -0400, Vladislav Yasevich wrote:
> > > With SCTP checksum offload available in virtio, it is now
> > > possible for virtio to receive a sctp packet with CHECKSUM_PARTIAL
> > > set (guest-to-guest traffic).  SCTP doesn't really have a
> > > partial checksum like TCP does, because CRC32c can't do partial
> > > additive checksumming.
...

Actually that isn't entirely true.
For all crc, crc(a) ^ crc(b) == crc(a^b).
Since crc(0) == 0 you can xor together two separately calculated crc
provided they both end at the same point.
The slight problem is that you are more likely to be appending
one buffer to another - which requires appending lots of zero
bytes to one of the crcs.
This could be speeded up by using lookup tables that add moderate
sized blocks of zero bytes to a crc instead of adding the zero
bytes one at a time.
Doing it without large const data and/or data cache trashing
is left as an exercise to the implementer.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
