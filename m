From: Yuval Shaia <yuval.shaia@oracle.com>
Subject: Re: [RFC 3/3] RDMA/virtio-rdma: VirtIO rdma driver
Date: Sun, 14 Apr 2019 08:20:25 +0300
Message-ID: <20190414052024.GA2842__32597.9877774202$1555718233$gmane$org@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411110157.14252-4-yuval.shaia@oracle.com>
	<199a70a8-5926-66af-d2d7-b19a0a0f46a2@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <199a70a8-5926-66af-d2d7-b19a0a0f46a2@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yanjun Zhu <yanjun.zhu@oracle.com>
Cc: mst@redhat.com, linux-rdma@vger.kernel.org, cohuck@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, jgg@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

> > +
> > +	wake_up(&dev->acked);
> > +
> > +	printk("%s\n", __func__);
> 
> Cool:-)
> 
> this line should be for debug?

Yes

> 
> Zhu Yanjun
> 
