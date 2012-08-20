From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-scsi spec: add per-LUN parameter query
Date: Mon, 20 Aug 2012 15:18:30 +0200
Message-ID: <50323926.8000205@redhat.com>
References: <1345453404-15244-1-git-send-email-mc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1345453404-15244-1-git-send-email-mc@linux.vnet.ibm.com>
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
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 20/08/2012 11:03, Cong Meng ha scritto:
> Each virtio scsi HBA has global request queue limits. But the passthrough
> LUNs (scsi-generic) come from different host HBAs may have different request
> queue limits. If the guest sends commands that exceed the host limits, the
> commands will be rejected by host HAB. 
> 
> To address this issue, this patch adds a per-LUN parameter query via the control
> queue, and defines some parameter query types. The driver can query and set the
> needed per-LUN parameters if the device enables this feature.
> 
> Signed-off-by: Cong Meng <mc@linux.vnet.ibm.com>
> --
>  virtio-spec.lyx |  218 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 218 insertions(+), 0 deletions(-)

Do you have kernel and QEMU patches for this?  That would help me
evaluate whether the interface is the correct one.

In any case, I'd rather have a single command returning all three values
(VIRTIO_SCSI_T_LUN_QUEUE_PARAMS), since it's unlikely that you need just
one.

Paolo
