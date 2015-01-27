From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost-scsi support for ANY_LAYOUT
Date: Tue, 27 Jan 2015 10:52:26 +0200
Message-ID: <20150127085226.GC21584__22042.4928390004$1422348766$gmane$org@redhat.com>
References: <1422340517.9532.26.camel@haakon3.risingtidesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1422340517.9532.26.camel@haakon3.risingtidesystems.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, target-devel <target-devel@vger.kernel.org>, kvm-devel <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 26, 2015 at 10:35:17PM -0800, Nicholas A. Bellinger wrote:
> Hi MST & Paolo,
> 
> So I'm currently working on vhost-scsi support for ANY_LAYOUT, and
> wanted to verify some assumptions based upon your earlier emails..
> 
> *) When ANY_LAYOUT is negotiated by vhost-scsi, it's expected that
> virtio-scsi request + response headers will (always..?) be within a
> single iovec.

Do you mean a single struct iovec - as opposed to an array?
If so this is not a valid assumption I think, it can
be split across entries as well.
For example:
	struct virtio_scsi_cmd_req {
		__u8 lun[8];            /* Logical Unit Number */
		__virtio64 tag;         /* Command identifier */
		__u8 task_attr;         /* Task attribute */
		__u8 prio;              /* SAM command priority field */
		__u8 crn;
		__u8 cdb[VIRTIO_SCSI_CDB_SIZE];
	} __attribute__((packed));

We get struct iovec *iov and len 4, then
lun[0-3] might be in iov[0], lun[4-7], tag, task_attr, prio might be in
iov[1], crn, cdb and data-out might be in iov[2].
data-in must be separate in iov[3].

But if it makes sense, you can optimize for current
guest behaviour.



> *) When ANY_LAYOUT is negotiated by vhost-scsi, it's expected that
> virtio-scsi request + response headers may be (but not always..?)
> combined with data-out + data-in payloads into a single iovec.

No. From virtio POV, you have to separate out (written by guest,
read by host) and in (written by host, read by guest).
Including both header and data.

The rule is that
1. out comes before in
2. out and in entries are separate


> *) When ANY_LAYOUT + T10_PI is negotiated by vhost-scsi, it's expected
> that PI and data payloads for data-out + data-in may be (but not
> always..?) within the same iovec.  Consequently, both headers + PI +
> data-payloads may also be within a single iovec.
> 
> *) Is it still safe to use 'out' + 'in' values from vhost_get_vq_desc()
> in order to determine the data_direction...?  If not, what's the
> preferred way of determining this information for get_user_pages_fast()
> permission bits and target_submit_cmd_map_sgls()..?
> 
> Also, what is required on the QEMU side in order to start generating
> ANY_LAYOUT style iovecs to verify the WIP changes..?  I see
> hw/scsi/virtio-scsi.c has been converted to accept any_layout=1, but
> AFAICT the changes where only related to code not shared between
> hw/scsi/vhost-scsi.c.

QEMU needs to write-list this feature bit.

> Thank you,
> 
> --nab
