From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Thu, 28 Mar 2013 11:03:02 +0100
Message-ID: <51541556.2040907@redhat.com>
References: <1363653285-23776-1-git-send-email-asias@redhat.com>
	<1363653285-23776-4-git-send-email-asias@redhat.com>
	<20130319084057.GB24393@stefanha-thinkpad.redhat.com>
	<1363744628.13070.28.camel@haakon2.linux-iscsi.org>
	<20130320095140.GA16615@redhat.com>
	<1364419887.17698.19.camel@haakon2.linux-iscsi.org>
	<20130327215625.GC10678@redhat.com>
	<1364423629.17698.25.camel@haakon2.linux-iscsi.org>
	<1364453115.17698.106.camel@haakon2.linux-iscsi.org>
	<1364456142.10253.6.camel@haakon2.linux-iscsi.org>
	<20130328090416.GA18482@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130328090416.GA18482@redhat.com>
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
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, seabios-devel <seabios@seabios.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Kevin O'Connor <kevin@koconnor.net>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 28/03/2013 10:04, Michael S. Tsirkin ha scritto:
>>> > > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
>>> > > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
>>> > > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
>>> > > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
>>> > > Calling l: 5124 for start_addr: c0000 for vq 2
>>> > > Unable to map ring buffer for ring 2
>>> > > l: 4096 ring_size: 5124
> okay so the ring address is within ROM.
> Unsurprisingly it fails.
> bios should stop device before write protect.
> 

The above log is very early, when everything is RAM:

  vhost_set_memory: section: 0x7fe2801f2b60 section->size: 2146697216 add: 0
  Before vhost_verify_ring_mappings: start_addr: c0000 size: 2146697216

The rings are not within ROM.  ROM is at 0xc0000-0xcc000 according to the
PAM registers.

The way I followed the debug output, "Got ranges_overlap" means 
actually "bailing out because ranges do not overlap".  In particular, 
here all three virtqueues fail the test, because this is the ROM area 
0xc0000..0xc7fff:

  vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 32768 add: 1
  Before vhost_verify_ring_mappings: start_addr: c0000 size: 32768
  Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
  Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
  Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
  Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
  Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
  Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124

Just below, vhost looks at the large RAM area starting at 0xc8000
(it's large because 0xf0000..0xfffff is still RAM):

  vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 2146664448 add: 1
  Before vhost_verify_ring_mappings: start_addr: c8000 size: 2146664448
  Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
  Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
  Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
  Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
  Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
  Calling l: 5124 for start_addr: c8000 for vq 2

Here vq 0 and 1 fail the test because they are in low RAM, vq 2 passes.

After 0xf0000..0xfffff is marked readonly, vhost looks at the RAM
between 0xc9000 and 0xf0000:

  vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 159744 add: 1
  Before vhost_verify_ring_mappings: start_addr: c9000 size: 159744
  Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
  Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
  Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
  Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
  Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
  Calling l: 5124 for start_addr: c9000 for vq 2

and the ROM between 0xf0000 and 0xfffff, which no ring overlaps with:

  vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 65536 add: 1
  Before vhost_verify_ring_mappings: start_addr: f0000 size: 65536
  Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
  Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
  Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
  Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
  Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
  Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124



SeaBIOS is indeed not initializing vqs 0/1 (the control and event 
queues), so their ring_phys is 0.  But the one that is failing is vq 2, 
the first request queue.

Your patch seems good, but shouldn't fix this problem.

Paolo
