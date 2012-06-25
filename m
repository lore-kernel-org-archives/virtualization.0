From: mc@linux.vnet.ibm.com
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-scsi: Implement hotplug support
	for virtio-scsi
Date: Mon, 25 Jun 2012 03:51:13 -0400
Message-ID: <20120625035113.Horde.eaU3vZir309P6Bhxk01CidA@imap.linux.ibm.com>
References: <cover.1340022196.git.mc@linux.vnet.ibm.com>
	<69a1a349ba21144e66843ab335cb3a243926bba8.1340022196.git.mc@linux.vnet.ibm.com>
	<CAJSP0QWoRt-GgWytPpSBEjNDtSHHRXOs7hDnyUpspW-knYPY5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QWoRt-GgWytPpSBEjNDtSHHRXOs7hDnyUpspW-knYPY5g@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, senwang@linux.vnet.ibm.com, Anthony Liguori <anthony@codemonkey.ws>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Andreas =?iso-8859-1?b?RuRyYmVy?= <afaerber@suse.de>
List-Id: virtualization@lists.linuxfoundation.org


Quoting Stefan Hajnoczi <stefanha@gmail.com>:

> On Wed, Jun 20, 2012 at 7:47 AM, Cong Meng <mc@linux.vnet.ibm.com> wrote:
>> Implement the hotplug() and hot_unplug() interfaces in virtio-scsi,  =

>> by signal
>> the virtio_scsi.ko in guest kernel via event virtual queue.
>>
>> The counterpart patch of virtio_scsi.ko will be sent soon in another thr=
ead.
>
>> Signed-off-by: Cong Meng <mc@linux.vnet.ibm.com>
>> Signed-off-by: Sen Wang <senwang@linux.vnet.ibm.com>
>> ---
>> =A0hw/virtio-scsi.c | =A0 72  =

>> +++++++++++++++++++++++++++++++++++++++++++++++++++--
>> =A01 files changed, 69 insertions(+), 3 deletions(-)
>
> I compared against the virtio-scsi specification and this looks good:
> http://ozlabs.org/~rusty/virtio-spec/virtio-0.9.5.pdf
>
> Dropped events and event throttling are not implemented by this patch.
>  This means that the guest can miss events if it runs out of event
> queue elements.  A scenario that might be able to trigger this is if
> multiple LUNs are hotplugged in a single QEMU monitor callback.
>
> Implementing dropped events is easy in hw/virtio-scsi.c.  Keep a bool
> or counter of dropped events and report them when the guest kicks us
> with a free event element (virtio_scsi_handle_event).

Yes. It's easy to do this in qemu. But I'm not sure what should be done
in virtio-scsi.ko to respond the "VIRTIO_SCSI_T_EVENTS_MISSED" event.
The spec says "poll the logical units for unit attention conditions", or
just a whole bus rescan?

>
> Stefan
