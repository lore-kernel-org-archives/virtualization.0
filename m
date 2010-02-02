From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/2] virtio net improvements
Date: Wed, 3 Feb 2010 09:57:06 +1030
Message-ID: <201002030957.06307.rusty__6160.90420303426$1265153398$gmane$org@rustcorp.com.au>
References: <201001292346.43675.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201001292346.43675.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: Shirley Ma <mashirle@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 29 Jan 2010 11:46:43 pm Rusty Russell wrote:
> Hi Dave,
> 
>    Nice driver optimization from Shirley, but requires a new virtio hook.
> Do you want to take both?  I have nothing else overlapping it.

Dave, any news on this?  Shirley, I note that your final commit message did
not contain this information from your original version:

	Tests have been done for small packets, big packets and
	mergeable buffers.

	The single netperf TCP_STREAM performance improved for host to guest. 
	It also reduces UDP packets drop rate.

	The netperf laptop results were:

	mtu=1500
	netperf -H xxx -l 120

	                w/o patch       w/i patch (two runs)    
	guest to host:  3336.84Mb/s   3730.14Mb/s ~ 3582.88Mb/s

	host to guest:  3165.10Mb/s   3370.39Mb/s ~ 3407.96Mb/s

Thanks,
Rusty.
