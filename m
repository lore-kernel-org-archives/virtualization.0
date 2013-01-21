From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v4 2/3] net: split eth_mac_addr for better error handling
Date: Mon, 21 Jan 2013 17:13:28 +0100
Message-ID: <20130121161328.GE24473__33710.2595869966$1358784837$gmane$org@stefanha-thinkpad.redhat.com>
References: <1358649789-2338-1-git-send-email-akong@redhat.com>
	<1358649789-2338-3-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1358649789-2338-3-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akong@redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jan 20, 2013 at 10:43:08AM +0800, akong@redhat.com wrote:
> From: Stefan Hajnoczi <stefanha@gmail.com>
> 
> When we set mac address, software mac address in system and hardware mac
> address all need to be updated. Current eth_mac_addr() doesn't allow
> callers to implement error handling nicely.
> 
> This patch split eth_mac_addr() to prepare part and real commit part,
> then we can prepare first, and try to change hardware address, then do
> the real commit if hardware address is set successfully.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Amos Kong <akong@redhat.com>
> ---
>  include/linux/etherdevice.h |  2 ++
>  net/ethernet/eth.c          | 43 ++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 38 insertions(+), 7 deletions(-)

Feel free to make yourself author and put me just as Suggested-by:.  I
posted pseudo-code but didn't write the patch or test it, so it's fair
to say that credit goes to you. :)

Stefan
