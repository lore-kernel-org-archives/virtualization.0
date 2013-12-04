From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] 9p/trans_virtio.c: Fix broken zero-copy on vmalloc()
	buffers
Date: Wed, 4 Dec 2013 21:49:23 +0100
Message-ID: <2B23B2D2-CCDE-4715-A35D-CD670BD9C923@suse.de>
References: <1386189798-22157-1-git-send-email-ryao@gentoo.org>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1386189798-22157-1-git-send-email-ryao@gentoo.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Richard Yao <ryao@gentoo.org>
Cc: Eric Van Hensbergen <ericvh@gmail.com>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, kernel@gentoo.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Ron Minnich <rminnich@sandia.gov>, v9fs-developer@lists.sourceforge.net, Brian Behlendorf <behlendorf1@llnl.gov>
List-Id: virtualization@lists.linuxfoundation.org


On 04.12.2013, at 21:43, Richard Yao <ryao@gentoo.org> wrote:

> The 9p-virtio transport does zero copy on things larger than 1024 bytes
> in size. It accomplishes this by returning the physical addresses of
> pages to the virtio-pci device. At present, the translation is usually a
> bit shift.
> 
> However, that approach produces an invalid page address when we
> read/write to vmalloc buffers, such as those used for Linux kernle
> modules. This causes QEMU to die printing:
> 
> qemu-system-x86_64: virtio: trying to map MMIO memory
> 
> This patch enables 9p-virtio to correctly handle this case. This not
> only enables us to load Linux kernel modules off virtfs, but also
> enables ZFS file-based vdevs on virtfs to be used without killing QEMU.
> 
> Also, special thanks to both Avi Kivity and Alexander Graf for their
> interpretation of QEMU backtraces. Without their guidence, tracking down
> this bug would have taken much longer.
> 
> Signed-off-by: Richard Yao <ryao@gentoo.org>

Looks good and clean to me, but I'm not expert on the mm subsystem.

Acked-by: Alexander Graf <agraf@suse.de>


Alex
