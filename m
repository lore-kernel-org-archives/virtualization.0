From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] drivers/vhost/scsi.c: avoid a 10-order allocation
Date: Wed, 4 Sep 2013 12:02:01 +0300
Message-ID: <20130904090201.GA31564@redhat.com>
References: <1376815736-21003-1-git-send-email-alonid@stratoscale.com>
	<20130818091838.GB17111@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130818091838.GB17111@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Aloni <alonid@stratoscale.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Aug 18, 2013 at 12:18:38PM +0300, Michael S. Tsirkin wrote:
> On Sun, Aug 18, 2013 at 11:48:56AM +0300, Dan Aloni wrote:
> > On 3.10.7 and x86_64, as a result of sizeof(struct vhost_scsi) being
> > 2152960 bytes the allocation failed once on my development machine.
> > 
> > Saw it would be prudent to split the bulk of it, which is the vqs array
> > into separately allocated parts. sizeof(struct vhost_virtqueue) is
> > currently 16816 bytes.
> > 
> > Signed-off-by: Dan Aloni <alonid@stratoscale.com>
> 
> This extra indirection is likely to have measureable cost though.
> 
> net core saw a similar problem, it was fixed in patch
>     net: allow large number of tx queues
> 
> So let's do it in a similar way: try to allocate with
> GFP_KERNEL | __GFP_NOWARN | __GFP_REPEAT
> and if that fails, do vmalloc.
> 
> To free, we can do
>        if (is_vmalloc_addr())
>                vfree();
>        else
>                kfree();
> 
> 

Hi Dan,
were you going to make this change? Or prefer me to do it?

-- 
MST
