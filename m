From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v2 0/5] virtio: support packed ring
Date: Fri, 13 Jul 2018 06:26:57 +0300
Message-ID: <20180713062627-mutt-send-email-mst__25598.3103685596$1531452299$gmane$org@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
	<20180712.144458.2076041018423659380.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180712.144458.2076041018423659380.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 12, 2018 at 02:44:58PM -0700, David Miller wrote:
> From: Tiwei Bie <tiwei.bie@intel.com>
> Date: Wed, 11 Jul 2018 10:27:06 +0800
> 
> > Hello everyone,
> > 
> > This patch set implements packed ring support in virtio driver.
> > 
> > Some functional tests have been done with Jason's
> > packed ring implementation in vhost:
> > 
> > https://lkml.org/lkml/2018/7/3/33
> > 
> > Both of ping and netperf worked as expected.
> 
> Michael and Jason, where are we with this series?

I'm at netdev, won't be able to review before Monday.

-- 
MST
