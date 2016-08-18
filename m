From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 11/15] zram: Pass attribute group to device_add_disk
Date: Thu, 18 Aug 2016 11:06:37 +0900
Message-ID: <20160818020637.GA500@swordfish>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
	<1471418115-3654-12-git-send-email-famz@redhat.com>
	<20160818015901.GA499@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160818015901.GA499@swordfish>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, "Ed L. Cashin" <ed.cashin@acm.org>, Keith Busch <keith.busch@intel.com>, Minchan Kim <minchan@kernel.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>, Nitin Gupta <ngupta@vflare.org>
List-Id: virtualization@lists.linuxfoundation.org

On (08/18/16 10:59), Sergey Senozhatsky wrote:
[..]
> I like the previous "Error creating sysfs group for device" string better,
> than "Error creating disk", because the latter one is much less informative.
> 
> do you want to do something like below?
> 
> int device_add_disk(struct device *parent, struct gendisk *disk,
> ...
>        if (attr_group) {
>                retval = sysfs_create_group(&disk_to_dev(disk)->kobj,
>                                            attr_group);
> 
> +		pr_err("Error creating sysfs group for device ...\n", ...);

d'oh... a typo. pr_err() is meant to be in `if (retval)' branch.

>                if (retval)
>                        goto fail;
>        }

	-ss
