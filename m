From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 2/2 v1] virtio-scsi: set per-LUN queue limits for sg
	devices
Date: Tue, 21 Aug 2012 10:56:53 +0100
Message-ID: <CAJSP0QVwW6Ugwx6xqE=pFAK0ajS3g+=MHV=ueC5oqMaBLekJEg__39452.9907768176$1345543026$gmane$org@mail.gmail.com>
References: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
	<1345537427-21601-2-git-send-email-mc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1345537427-21601-2-git-send-email-mc@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cong Meng <mc@linux.vnet.ibm.com>
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 21, 2012 at 9:23 AM, Cong Meng <mc@linux.vnet.ibm.com> wrote:
> @@ -557,6 +621,7 @@ static uint32_t virtio_scsi_get_features(VirtIODevice *vdev,
>  {
>      requested_features |= (1UL << VIRTIO_SCSI_F_HOTPLUG);
>      requested_features |= (1UL << VIRTIO_SCSI_F_CHANGE);
> +    requested_features |= (1UL << VIRTIO_SCSI_F_LUN_QUERY);

This should be a QEMU 1.3 and later feature bit.  VMs running with -m
pc-1.2 or earlier should not see it by default, this ensure the device
ABI is stable.  For more info, see:
http://patchwork.ozlabs.org/patch/177924/

Stefan
