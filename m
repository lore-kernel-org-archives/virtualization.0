From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] virtio_blk: add missing __dev{init,exit} markings
Date: Fri, 26 Jun 2009 12:37:36 -0700
Message-ID: <20090626123736.594969c8__9553.79062002084$1246045223$gmane$org@jbarnes-g45>
References: <1242632349-15894-1-git-send-email-vapier@gentoo.org>
	<200905200010.51786.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905200010.51786.rusty@rustcorp.com.au>
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
Cc: Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, Andrew@smtp1.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 20 May 2009 00:10:51 +0930
Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Mon, 18 May 2009 05:09:09 pm Mike Frysinger wrote:
> > -static int virtblk_probe(struct virtio_device *vdev)
> > +static int __devinit virtblk_probe(struct virtio_device *vdev)
> 
> This makes sense, I think, but then it implies that
> virtio_dev_probe() should also be __devinit, right?
> 
> And I look at pci_bus_probe(), and it's not __devinit.
> 
> Is the PCI code just slack?

I wouldn't be surprised if some annotations were missing or incorrect
given the churn in hotplug lately, but I can't find that particular
symbol...

-- 
Jesse Barnes, Intel Open Source Technology Center
