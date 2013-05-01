From: David Miller <davem@davemloft.net>
Subject: Re: [PULL] vhost: cleanups and fixes for 3.10
Date: Wed, 01 May 2013 15:05:48 -0400 (EDT)
Message-ID: <20130501.150548.1959140741961524114.davem@davemloft.net>
References: <20130501150130.GA21230@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20130501150130.GA21230@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, agrover@redhat.com, asias@redhat.com, brian@purestorage.com, hch@lst.de, joern@logfs.org, mark.d.rustad@intel.com, martin.petersen@oracle.com, nab@linux-iscsi.org, ogerlitz@mellanox.com, yongjun_wei@trendmicro.com.cn
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 1 May 2013 18:01:31 +0300

> Please pull the following vhost core updates for 3.10 -
> they affect both vhost-net and vhost-scsi devices.
> They also *depend* on both net-next and target-pending.  Since Linus
> merged target-pending but not net-next at this point, merging through
> the net tree seems to make sense.

I don't have target-pending in my tree though and I'm not going to pull
it in just for this.

Since you have such a multi-dependency situation, just ask Linus to pull
this directly after I push net-next to him, which should be later today.

Thanks.
