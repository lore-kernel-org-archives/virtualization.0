From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 07:50:53 +1100
Message-ID: <1326315053.23910.133.camel@pasglop>
References: <87zketp9nz.fsf@rustcorp.com.au>
	<20111218101831.GB30374@redhat.com> <87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com> <871us0om2t.fsf@rustcorp.com.au>
	<20111220113718.GF3913@redhat.com> <878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com> <8762gj6q5r.fsf@rustcorp.com.au>
	<4F0D8EFA.3010503@codemonkey.ws> <20120111151230.GA20570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111151230.GA20570@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2012-01-11 at 17:12 +0200, Michael S. Tsirkin wrote:

> This is similar to what we have now. But it's still buggy: e.g. if guest
> updates MAC byte by byte, we have no way to know when it's done doing
> so. 

Do like real HW, there's plenty of options:

 - (better) Have a command "update MAC" sent to a ring. A command ring
would be generally useful and could replace anything you do via writing
to config space today. The advantage of having a read-only config space
is that you significantly remove the need for synchronization. You could
also have an event ring and avoid the seqlock for reading. It's MUCH
better to have a fine granularity of what actually changed that having a
generic "something is changing in the config space".

With a new ring format allowing direct data in the ring descriptor that
would be trivial.

 - If you really don't like a command ring, you can have a command
"register", write the new MAC and send a command to make it "apply", but
that's not fantastic as there's going to be a possible discrepancy
between what's in the config and what's actually used.

 - Have a separate "MAC write" register set with the "hot" byte beeing
the low order byte. writing to it updates the MAC. 

Etc etc...

Cheers,
Ben.
