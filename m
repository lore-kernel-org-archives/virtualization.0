From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_net: large tx MTU support
Date: Thu, 27 Nov 2008 23:00:56 +1030
Message-ID: <200811272300.58151.rusty__49268.4215693318$1227789231$gmane$org@rustcorp.com.au>
References: <1227707891.9579.44.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1227707891.9579.44.camel@blaa>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: netdev <netdev@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 27 November 2008 00:28:11 Mark McLoughlin wrote:
> We don't really have a max tx packet size limit, so allow configuring
> the device with up to 64k tx MTU.

Hi Mark,

Just one comment: maybe we should be conservative and maybe limit to 1500 if 
the host doesn't offer any of the GSO or MRG_RXBUF features?

Thanks,
Rusty.
