From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Regression in virtio block driver with 4.13.2
Date: Sun, 17 Sep 2017 16:57:31 -0700
Message-ID: <20170917235731.GA31789__40131.6793323078$1505692683$gmane$org@infradead.org>
References: <93e65aef-e93d-6a99-854a-f6147f84e3b1@redhat.com>
	<20170915173703.GA23073@infradead.org>
	<db314009-f47f-17bc-e2d6-d84936432575@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <db314009-f47f-17bc-e2d6-d84936432575@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laura Abbott <labbott@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Sep 16, 2017 at 04:16:06PM -0700, Laura Abbott wrote:
> Yes, the issue goes  away when CONFIG_VIRTIO_BLK_SCSI is
> disabled.

Ok, so it's probably related to follow ups to the scsi_request split.

That being said, I would highly recommend turning off
CONFIG_VIRTIO_BLK_SCSI in fedora.  The feature has caused more trouble
than it helped with, and should never have been added (saying that as
the person who added it). It was never supported with virtio 1.0 devices
and has been disabled in qemu by default for quite a while.
