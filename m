From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v4 00/16] qemu: towards virtio-1 host support
Date: Fri, 28 Nov 2014 10:50:19 +0100
Message-ID: <20141128105019.3a24454a.cornelia.huck@de.ibm.com>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
	<20141127152422.GA26747@redhat.com>
	<20141127163139.7db48144.cornelia.huck@de.ibm.com>
	<20141127154211.GC26747@redhat.com>
	<20141127170651.67f918e2.cornelia.huck@de.ibm.com>
	<20141127161825.GA27124@redhat.com>
	<20141127172842.42782626.cornelia.huck@de.ibm.com>
	<20141127163859.GA28193@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141127163859.GA28193@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 27 Nov 2014 18:38:59 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Also, let's focus on one device, e.g. -net for now.

Yes, I'm currently looking at net.

> Then probably virtio scsi.
> That's because blk needs to be reworked to support ANY_LAYOUT.

I had focused on blk because that's the other device used on every s390
image :) But the ANY_LAYOUT stuff looks like a bit of work :/
