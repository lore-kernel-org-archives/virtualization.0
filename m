From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv10] vhost: vhost TX zero-copy support
Date: Mon, 18 Jul 2011 15:28:04 +0300
Message-ID: <20110718122804.GA5580__22197.645964525$1310992114$gmane$org@redhat.com>
References: <20110718105905.GA4786@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110718105905.GA4786@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shirley Ma <mashirle@us.ibm.com>
Cc: netdev@vger.kernel.org, jj@chaosbits.net, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 18, 2011 at 01:59:05PM +0300, Michael S. Tsirkin wrote:
> This adds experimental zero copy support in vhost-net,
> disabled by default.

Looks like there was a memory leak in the patch,
I'll address that and post a new version shortly.

-- 
MST
