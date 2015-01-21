From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 00/16] virtio-pci: towards virtio 1.0 guest support
Date: Wed, 21 Jan 2015 12:31:08 +0100
Message-ID: <1421839868.11160.28.camel__12608.1520146274$1421839889$gmane$org@nilsson.home.kraxel.org>
References: <1421256142-11512-1-git-send-email-mst@redhat.com>
	<1421356698.3933.18.camel@nilsson.home.kraxel.org>
	<20150115213256.GA4813@redhat.com>
	<1421397146.21318.16.camel@nilsson.home.kraxel.org>
	<1421665620.3610.13.camel@nilsson.home.kraxel.org>
	<20150120163256.GA1785@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150120163256.GA1785@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > While hacking it up I've noticed spec doesn't match reality.  The
> > "Virtio Structure PCI Capabilities" section here ...
> > 
> > http://docs.oasis-open.org/virtio/virtio/v1.0/cs01/virtio-v1.0-cs01.html#x1-690004
> > 
> > ... doesn't match what qemu is doing.  Huh?
> 
> Thanks a lot for the report, and the tool!

pciutils patch needs an update too (because I've made it decode the
broken qemu capabilities).  Will come as separate mail with proper
commit message in a moment.

> I sent patches to fix this all up.
> You can try my qemu and linux virtio-net branches now,
> they should be spec compliant.

Yep, much better.  caps match spec, the system boots fine from
virtio-scsi, and the nfs-mounts (using virtio-net) are there too.

cheers,
  Gerd
