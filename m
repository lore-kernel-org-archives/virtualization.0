From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_net: Extend virtio to use VF datapath when
	available
Date: Tue, 19 Dec 2017 17:47:07 +0200
Message-ID: <20171219174259-mutt-send-email-mst__26179.9063919627$1513698329$gmane$org@kernel.org>
References: <1513644036-45230-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1513644036-45230-1-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I'll need to look at this more, in particular the feature
bit is missing here. For now one question:

On Mon, Dec 18, 2017 at 04:40:36PM -0800, Sridhar Samudrala wrote:
> @@ -56,6 +58,8 @@ module_param(napi_tx, bool, 0644);
>   */
>  DECLARE_EWMA(pkt_len, 0, 64)
>  
> +#define VF_TAKEOVER_INT	(HZ / 10)
> +
>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>  
>  static const unsigned long guest_offloads[] = {

Why is this delay necessary? And why by 100ms?
