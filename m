From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio-mmio: Update the device to OASIS spec version
Date: Thu, 15 Jan 2015 20:39:36 +0200
Message-ID: <20150115183936.GA31044@redhat.com>
References: <1419014284-18500-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1419014284-18500-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 19, 2014 at 06:38:04PM +0000, Pawel Moll wrote:
> Tested with our custom models (*not* qemu).

Could you look into updating qemu as well please?
I'd like to make sure patches are widely testable
before pushing them, to reduce the chances of
finding issues after kernel is released.

You can find draft patches for pci and s390 here:
git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git virtio-1.0

-- 
MST
