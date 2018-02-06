From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC] virtio-iommu version 0.6
Date: Tue,  6 Feb 2018 18:11:06 +0000
Message-ID: <20180206181106.21815-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
Cc: eric.auger@redhat.com, eric.auger.pro@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Please find version 0.6 of the virtio-iommu specification at the following
locations.

Document: http://jpbrucker.net/virtio-iommu/spec/virtio-iommu.pdf
          http://jpbrucker.net/virtio-iommu/spec/virtio-iommu.html

Sources: git://linux-arm.org/virtio-iommu.git viommu/v0.6

I didn't receive any comment for v0.5 [1], so this update is fairly light:
* Changed range definition in map and unmap requests
* Use virtio-iommu device ID
* Update IORT node ID and simplify layout

The following document shows the difference between v0.5 and v0.6:
http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-pdf-diff-v0.5-v0.6.pdf

Next version will hopefully add vSVA (PASID+PRI) and/or architectural
optimizations, but I can't provide a timeline yet. I'll probably send a
small draft first.

I will send the Linux driver soon. In the meantime you can fetch it on my
development branches, based on next-20180206.

git://linux-arm.org/linux-jpb.git virtio-iommu/devel
git://linux-arm.org/kvmtool-jpb.git virtio-iommu/devel

Any comments welcome!

Thanks,
Jean

[1] https://www.spinics.net/lists/kvm/msg157402.html
