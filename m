From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/4] megaraid_sas HBA emulation
Date: Tue, 27 Oct 2009 16:26:14 +0100
Message-ID: <4AE71116.6080809__22056.8200260916$1256657440$gmane$org@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

this patchset implements an emulation for the megaraid_sas HBA.
It provides emulates an LSI MegaRAID SAS 8708EM2 HBA, ie
presenting to the guest a virtual SCSI adapter.
Internally it is using aio for read/write requests and
either SG_IO or SCSI command emulation for everything else.

The reason for choosing the megaraid_sas HBA and not, say,
implementing a virtio scsi interface is because:
- the megaraid_sas is using a very simple firmware interface,
  comparable to virtio
- the HBA driver are already existent, so I only have to
  write the backend :-)

The device can be accessed by

-drive if=3Draid,file=3DXXX

In order to support SCSI command emulation I had to update /
patch up the existing SCSI disk support. This might be
not to everyones taste, so I'm open to alternative
suggestions.

But I certainly do _not_ want to update the SCSI disk
emulation, as this is really quite tied to the SCSI parallel
interface used by the old lsi53c895a.c.
Plus it doesn't do scatter-gather list handling, which
is quite impossible to fix without proper documentation.

Of course, if anyone else would step in here, I won't object :-)

It currently runs guests with 2.6.27 and up; Windows XP
support is not quite there yet. Anything else might work;
if not, enable debugging and sent me the logfile.

As usual, comment / suggestions  etc welcome.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
