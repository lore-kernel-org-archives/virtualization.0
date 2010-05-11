From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: virtio: power management
Date: Tue, 11 May 2010 21:12:21 +0300
Message-ID: <20100511181221.GA9361__17891.2094132558$1273601906$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anyone looked at power management with virtio?
virtio-pci has callbacks to save/restore pci config
on suspend/resume, but it seems that more action,
such as restoring queue state, would be needed
for e.g. suspend to disk to work.

Rusty, any hints on the code in virtio-pci
that deals with suspend? Is it incomplete?

Thanks,

-- 
MST
