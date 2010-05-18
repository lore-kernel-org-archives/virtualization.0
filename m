From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost-net: utilize PUBLISH_USED_IDX feature
Date: Mon, 17 May 2010 21:08:32 -0700 (PDT)
Message-ID: <20100517.210832.27816606.davem@davemloft.net>
References: <20100518011931.GA21918@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20100518011931.GA21918@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com
Cc: quintela@redhat.com, rusty@rustcorp.com.au, paulmck@linux.vnet.ibm.com, arnd@arndb.de, kvm@vger.kernel.org, virtualization@lists.osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 18 May 2010 04:19:31 +0300

> With PUBLISH_USED_IDX, guest tells us which used entries
> it has consumed. This can be used to reduce the number
> of interrupts: after we write a used entry, if the guest has not yet
> consumed the previous entry, or if the guest has already consumed the
> new entry, we do not need to interrupt.
> This imporves bandwidth by 30% under some workflows.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Rusty, Dave, this patch depends on the patch
> "virtio: put last seen used index into ring itself"
> which is currently destined at Rusty's tree.
> Rusty, if you are taking that one for 2.6.35, please
> take this one as well.
> Dave, any objections?

None:

Acked-by: David S. Miller <davem@davemloft.net>
