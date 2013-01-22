From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH V6 1/3] virtio-net: fix the set affinity bug when CPU IDs
	are not consecutive
Date: Tue, 22 Jan 2013 11:42:40 +1030
Message-ID: <87hamavx4n.fsf__17886.6153503352$1358818226$gmane$org@rustcorp.com.au>
References: <1358767524-17934-1-git-send-email-gaowanlong@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358767524-17934-1-git-send-email-gaowanlong@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Eric Dumazet <erdnetdev@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Wanlong Gao <gaowanlong@cn.fujitsu.com> writes:

> As Michael mentioned, set affinity and select queue will not work very
> well when CPU IDs are not consecutive, this can happen with hot unplug.
> Fix this bug by traversal the online CPUs, and create a per cpu variable
> to find the mapping from CPU to the preferable virtual-queue.

This series looks fairly sane at a glance, to me, but MST is the Ack you
need.

Thanks,
Rusty.
