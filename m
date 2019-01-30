From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost: fix OOB in get_rx_bufs()
Date: Wed, 30 Jan 2019 14:31:17 -0800 (PST)
Message-ID: <20190130.143117.30926981436378456.davem__2005.95008661679$1548967321$gmane$org@davemloft.net>
References: <20190129.151026.358327408932275252.davem@davemloft.net>
	<20190129.153810.493942539151548676.davem@davemloft.net>
	<20190129203157-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190129203157-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 29 Jan 2019 20:36:31 -0500

> If it helps I can include most virtio stuff in my pull requests instead.
> Or if that can't work since there's too often a dependency on net-next,
> maybe Jason wants to create a tree and send pull requests to you.  Let
> us know if that will help, and which of the options looks better from
> your POV.

Thanks for offering Michael, I really appreciate it.

Let me think about the logistics of that and how it may or may not
help me with my backlog.
