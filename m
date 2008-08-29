From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC] [PATCH] SCSI passthrough for virtio-blk
Date: Fri, 29 Aug 2008 13:01:44 +0200
Message-ID: <200808291301.44242.borntraeger@de.ibm.com>
References: <48B7C159.5010800@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48B7C159.5010800@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Freitag, 29. August 2008 schrieb Hannes Reinecke:
> So when using '-drive file=/dev/sgXX,if=virtio,format=host_device' you
> can happily call any sg_XX command on the resulting vdX device. Quite
> neat, methinks. And it's even backwards compatible, so each of these
> patches should work without the other one applied.

Does not work here. If the host does not support the pass-through, the device 
drivers waits for an response. I tried  sdparm /dev/vda with a patched kernel 
and an unpatched userspace.

I think you should use a feature bit to avoid problems.

Christian
