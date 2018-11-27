From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 00/13] virtio: support packed ring
Date: Mon, 26 Nov 2018 22:18:04 -0800 (PST)
Message-ID: <20181126.221804.911097813637187592.davem__34085.6817820624$1543299365$gmane$org@davemloft.net>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
	<20181127010157-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181127010157-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 27 Nov 2018 01:08:08 -0500

> On Wed, Nov 21, 2018 at 06:03:17PM +0800, Tiwei Bie wrote:
>> Hi,
>> 
>> This patch set implements packed ring support in virtio driver.
>> 
>> A performance test between pktgen (pktgen_sample03_burst_single_flow.sh)
>> and DPDK vhost (testpmd/rxonly/vhost-PMD) has been done, I saw
>> ~30% performance gain in packed ring in this case.
>> 
>> To make this patch set work with below patch set for vhost,
>> some hacks are needed to set the _F_NEXT flag in indirect
>> descriptors (this should be fixed in vhost):
>> 
>> https://lkml.org/lkml/2018/7/3/33
> 
> I went over it and I think it's correct spec-wise.
> 
> I have some ideas for enhancements but let's start
> with getting this stuff merged first.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Series applied.
