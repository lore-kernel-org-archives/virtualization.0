From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] virtio-blk: Generate uevent after attribute available
Date: Tue, 28 Jun 2016 04:45:53 -0700
Message-ID: <20160628114553.GA18354@infradead.org>
References: <20160628023915.6012-1-famz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160628023915.6012-1-famz@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fam Zheng <famz@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 28, 2016 at 10:39:15AM +0800, Fam Zheng wrote:
> Userspace listens to the KOBJ_ADD uevent generated in add_disk. At that
> point we haven't created the serial attribute file, therefore depending
> on how fast udev reacts, the /dev/disk/by-id/ entry doesn't always get
> created.
> 
> This race condition can be easily reproduced by hot plugging a number of
> virtio-blk disks.
> 
> Also in systemd, there used to be a related workaround in udev rules
> called 'WAIT_FOR="serial"', but it is removed in later versions.
> 
> Now let's generate a KOBJ_CHANGE event after the attributes are ready.

The same race is present in other drivers as well, e.g. nvme.  Please
find a way to make this work properly without needing to hack every
driver to send events manually.
