From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [systemd-devel] udev virtio by-path naming
Date: Wed, 1 Mar 2017 16:24:55 +0000
Message-ID: <20170301162455.GI10160__36003.8503692069$1488385506$gmane$org@redhat.com>
References: <de55b0f4-4582-cf06-4b0d-12c2282406a8@linux.vnet.ibm.com>
	<20170220170041.68c9bf4f.cornelia.huck@de.ibm.com>
	<9cb1f5ff-0a5b-4d0a-16f6-887c7658795a@linux.vnet.ibm.com>
	<CALVzVJZhZTNbZp1EB9cT82YxUnbUZZ+ZPo7Od8CWz5C3faN1AA@mail.gmail.com>
	<14ac3e2c-180b-cb18-fd68-268dc5d85f8b@linux.vnet.ibm.com>
	<20170301033007.GG29552@in.waw.pl>
	<7de4f313-d3a6-b50d-4e53-3b01d6f0f2a0@linux.vnet.ibm.com>
	<20170301155812.GG10160@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170301155812.GG10160@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: systemd-devel <systemd-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 01, 2017 at 03:58:12PM +0000, Daniel P. Berrange wrote:
> On Wed, Mar 01, 2017 at 04:02:53PM +0100, Viktor Mihajlovski wrote:
> > If wanted, I can take a stab at virtio-mmio, but would need the output
> > of udevadm -a /dev/vda from a virtio-mmio system.
> 
> Presumably you mean 'udevadm info -a /dev/vda' ?  That reports the following,
> given a basic Fedora 25 guest, with a virtio-mmio disk added as per the
> guide above...
> 
>   looking at device '/devices/platform/a003e00.virtio_mmio/virtio3/block/vda':

BTW, the hex digits in here are the virtio mmio address which changes per
device eg if i have 3 virtio-mmio backed disks, I get

  looking at device '/devices/platform/a003a00.virtio_mmio/virtio3/block/vda':
  looking at device '/devices/platform/a003c00.virtio_mmio/virtio4/block/vdb':
  looking at device '/devices/platform/a003e00.virtio_mmio/virtio5/block/vdc':


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
