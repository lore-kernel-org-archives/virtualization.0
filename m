From: Fengguang Wu <lkp@intel.com>
Subject: Re: [kbuild-all] [PATCH net-next] vhost_net: do not stall on
	zerocopy depletion
Date: Sun, 1 Oct 2017 11:26:55 +0800
Message-ID: <20171001032655.7tuk6qcrd2awtwbe__7494.78050643138$1506828442$gmane$org@wfg-t540p.sh.intel.com>
References: <20170928002556.41240-1-willemdebruijn.kernel@gmail.com>
	<201710010753.KeY9a5xF%fengguang.wu@intel.com>
	<20171001062018-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171001062018-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, den@klaipeden.com, virtualization@lists.linux-foundation.org, kbuild-all@01.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Oct 01, 2017 at 06:20:49AM +0300, Michael S. Tsirkin wrote:
>On Sun, Oct 01, 2017 at 08:09:30AM +0800, kbuild test robot wrote:
>> Hi Willem,
>>
>> [auto build test WARNING on net-next/master]
>>
>> url:    https://github.com/0day-ci/linux/commits/Willem-de-Bruijn/vhost_net-do-not-stall-on-zerocopy-depletion/20171001-054709
>> reproduce:
>>         # apt-get install sparse
>>         make ARCH=x86_64 allmodconfig
>>         make C=1 CF=-D__CHECK_ENDIAN__
>
>BTW __CHECK_ENDIAN__ is the default now, I think you can drop it from
>your scripts.

Good tip, thank you! However since we're testing old kernels, too,
we'll need to keep it for probably 1-3 more years.

Thanks,
Fengguang

>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>
>> vim +440 drivers/vhost/net.c
>>
>>    433	
>>    434	static bool vhost_exceeds_maxpend(struct vhost_net *net)
>>    435	{
>>    436		struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
>>    437		struct vhost_virtqueue *vq = &nvq->vq;
>>    438	
>>    439		return (nvq->upend_idx + UIO_MAXIOV - nvq->done_idx) % UIO_MAXIOV >
>>  > 440		       min(VHOST_MAX_PEND, vq->num >> 2);
>>    441	}
>>    442	
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>_______________________________________________
>kbuild-all mailing list
>kbuild-all@lists.01.org
>https://lists.01.org/mailman/listinfo/kbuild-all
