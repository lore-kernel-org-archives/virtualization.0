From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net,stable v4 0/3]  vhost: fix a few skb leaks
Date: Fri, 1 Dec 2017 16:47:59 +0200
Message-ID: <20171201164731-mutt-send-email-mst@kernel.org>
References: <1512123038-15773-1-git-send-email-wexu@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1512123038-15773-1-git-send-email-wexu@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: wexu@redhat.com
Cc: mjrosato@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 01, 2017 at 05:10:35AM -0500, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
> 
> Matthew found a roughly 40% tcp throughput regression with commit
> c67df11f(vhost_net: try batch dequing from skb array) as discussed
> in the following thread:
> https://www.mail-archive.com/netdev@vger.kernel.org/msg187936.html

Series

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v4:
> - fix zero iov iterator count in tap/tap_do_read()(Jason)
> - don't put tun in case of EBADFD(Jason)
> - Replace msg->msg_control with new 'skb' when calling tun/tap_do_read()
> 
> v3:
> - move freeing skb from vhost to tun/tap recvmsg() to not
>   confuse the callers.
> 
> v2:
> - add Matthew as the reporter, thanks matthew.
> - moving zero headcount check ahead instead of defer consuming skb
>   due to jason and mst's comment.
> - add freeing skb in favor of recvmsg() fails.
> 
> Wei Xu (3):
>   vhost: fix skb leak in handle_rx()
>   tun: free skb in early errors
>   tap: free skb if flags error
> 
>  drivers/net/tap.c   | 14 ++++++++++----
>  drivers/net/tun.c   | 24 ++++++++++++++++++------
>  drivers/vhost/net.c | 20 ++++++++++----------
>  3 files changed, 38 insertions(+), 20 deletions(-)
> 
> -- 
> 1.8.3.1
